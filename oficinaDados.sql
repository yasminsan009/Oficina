use Oficina;

INSERT INTO clients (CPF, Cname, contact, address) VALUES
('12345678901', 'Carlos Silva', '11987654321', 'Rua das Flores, 123, São Paulo - SP'),
('23456789012', 'Maria Souza', '21987654321', 'Av. Paulista, 1000, São Paulo - SP'),
('34567890123', 'João Oliveira', '31987654321', 'Rua Minas Gerais, 45, Belo Horizonte - MG');

-- Inserir funcionários
INSERT INTO employee (ecode, specialty) VALUES
('EMP001', 'Mecânico'),
('EMP002', 'Eletricista'),
('EMP003', 'Funileiro');

-- Inserir veículos
INSERT INTO vehicle (idClients, model, carPlate) VALUES
(1, 'Toyota Corolla', 'ABC1234'),
(2, 'Honda Civic', 'XYZ5678'),
(3, 'Ford Fiesta', 'DEF9012');

-- Inserir ordens de reparo
INSERT INTO car_repair (idEmployee, specialistTeam) VALUES
(1, 'Equipe A'),
(2, 'Equipe B'),
(3, 'Equipe C');

-- Inserir check-ups
INSERT INTO checkup (idEmployee, checkupLevel, checkupTeam) VALUES
(1, 'Parcial', 'Equipe Diagnóstico'),
(2, 'Completo', 'Equipe Completa'),
(3, 'Parcial', 'Equipe Diagnóstico');

-- Inserir pedidos de serviço
INSERT INTO request (idVehicle, idEmployee, service, Rdescription, requestDate) VALUES
(1, 1, 'Troca de óleo', 'Óleo sintético 5W30', '2024-02-20'),
(2, 2, 'Troca de bateria', 'Bateria nova Moura 60Ah', '2024-02-21'),
(3, 3, 'Pintura', 'Pintura lateral esquerda', '2024-02-22');

-- Inserir taxas e valores
INSERT INTO taxAndValues (taxService, pieceValue) VALUES
('10%', '150.00'),
('10%', '200.00'),
('10%', '120.00');

-- Inserir ordens de serviço
INSERT INTO serviceOrder (idTaxAndValues, emissionDate, deliveryDate) VALUES
(1, '2024-02-21', '2024-02-23'),
(2, '2024-02-22', '2024-02-24'),
(3, '2024-02-23', '2024-02-25');

-- Inserir pagamentos
INSERT INTO payments (idClients, paymentMethod, limitAvailable) VALUES
(1, 'Cartão', 5000.00),
(2, 'PIX', 3000.00),
(3, 'Boleto', 2000.00);


-- 1. Quantos pedidos de serviço cada cliente fez?
SELECT c.Cname AS Cliente, COUNT(r.idRequest) AS Total_Pedidos 
FROM clients c
LEFT JOIN vehicle v ON c.idClients = v.idClients
LEFT JOIN request r ON v.idVehicle = r.idVehicle
GROUP BY c.Cname
ORDER BY Total_Pedidos DESC;

-- 2. Quais serviços custaram mais de R$150,00 e foram solicitados depois de 20/02/2024?
SELECT r.service AS Serviço, t.pieceValue AS Valor_Peça, r.requestDate AS Data_Solicitação
FROM request r
JOIN serviceOrder so ON r.idRequest = so.idserviceOrder
JOIN taxAndValues t ON so.idTaxAndValues = t.idTaxAndValues
WHERE CAST(t.pieceValue AS DECIMAL(10,2)) > 150.00
AND r.requestDate > '2024-02-20'
ORDER BY t.pieceValue DESC;

--3. Qual é o limite médio disponível dos clientes que pagam por PIX?
SELECT paymentMethod AS Método_Pagamento, 
       COUNT(idPayment) AS Quantidade_Clientes,
       AVG(limitAvailable) AS Média_Limite_Disponível
FROM payments
WHERE paymentMethod = 'PIX'
GROUP BY paymentMethod
HAVING AVG(limitAvailable) > 2500;
