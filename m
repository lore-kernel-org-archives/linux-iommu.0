Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3633C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/nVGu2C9pMMUFFd/E26QmI+n32sCasY01jforjaOGtgaDKvKymDnnt/HSdioaB1P66nmmuPJkPcUVzPRJ8iopgv7Yqrv2944lnCryVNYL4M6hOlR+h8Cm0eVRe4QV7Q22FCGYS1fEKbK+HQOglCxYq5EUQRjYArtp3z66v7h+U03xcM3PSEQYr3tXNrXfd3EBRa2PDB+dOvIi6fz7lRFOFDZeAB9ODEbK+1GyCTuFULEykOWkCwPqsv/Nmy5lowJfhoy2/qPkSUh4DR54YXvcGa3fqWf6N7KnvPLKeBRWkGE1cHFDPWA0Ubx1YJOjSg5tBOTJUHcYtonqWObXlrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQwUlgV7oijHrKs9lX+IyYs9JVCSzccnvfAgc7vAOcM=;
 b=Vk+cUsQPbGpq1ioXnHR0W/ZG+QY8w+Ml+J/6jMkdXP9uI3w6phwWvg3gkphWuKWn7VSY0VYw17rHbzk6gQTw5LO6PYnSTwIAcFeyEXiZq9tYuO4v8HyobbcbEdhw4X6Bshm602b3kjDUqB6LEFvKb+btktPDybADGjOnNEqs3zufalUDcLKZBOdHlc6DZqkzkc4Kzh61tll4Ax7qheoicsBarT5Et5CgvlfpsXhm4FVHU3awsRbmZck8H3RWVKhUjwW488CpC02CQ0XyY43OGkNbQl7lJuMosgf5KaUcVCm5HS9NsoQ3E+KEnY6N5kCwGf9oyjFM3Alib2jd71dpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQwUlgV7oijHrKs9lX+IyYs9JVCSzccnvfAgc7vAOcM=;
 b=sr5GE1MCkheQbtPG++M0/fqpKLqYCpCbAJNcxE3HWbrpsaSj2NG7GOqjEJVxmRaE3AG2q/us/yZ7d2zzuWR1W1gbfLIocqsxQZ5a/3xGikslsqmDaZ7M+4eOQd/6njYZbfVStjvKd1+iptrF/NE1Hr3VFJiZNgP6teYREZAchRg=
Received: from MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::24)
 by DM5PR1201MB0138.namprd12.prod.outlook.com (2603:10b6:4:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 11:46:31 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::7) by MW4P220CA0019.outlook.office365.com
 (2603:10b6:303:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 11:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:46:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:46:28 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 16/35] iommu/amd: Update irq_remapping_alloc to use IOMMU lookup helper function
Date: Wed, 6 Jul 2022 17:08:06 +0530
Message-ID: <20220706113825.25582-17-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039e87c9-dffd-412d-76c8-08da5f452b84
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0138:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aLfCDuAu8GvvixEeaLekAkrLPICndcbUhCYI4l+oFdN4fdFpG8QXxWkUVxA1uHzKWG+ryZ7oK3NrnsPDE6qI2Ik/5L0aRaruOf4hH/WSHfvy3aS1/+aN42PLah22xoO6g0EDpAEuDXh0T8+4BsswkdnlReQSabi9qvQQpVGUgd+vRBZtslKbGsBsc/8ZsApojXFu33Z4x0bZPjKYTxTMLS4KwIc904z0Fl2C4pBADoPmtbnKw0jKtBPgmy7dqrWBTu1KT94M+dXvrRmgKEMv4CHY+UkW81n8AN12rMi3M+xWL8wZfOllgKBli7tXA/aC6BWA+W1xad1k+WhrJkHw2Vy2O8cT1PP7TEg3QX0KoclbLKK1PnIhQHSqEJb/ptQpzsRiY6I2nouK8qZjFW/db+YNGaXtzk08D5K9xHq6ELZiSaE1xRQNum3g1H9BDpC8Mnv6V7nrwX1T05tBrNrQ7Xg3bKXWckLl25pFihTpyDiZAxxNeDsJcFk4HKqvnlqo5vJVjQi1OjquA3R/j1QmL8nv026Lx5BWUGdBz+AMfoEv4VUUIkAb+B4BZlYvUyqF5Hk4tKJ/p+v9yf0RAlKW4t8lTNGoOQi2BgDpp9mS4O0pIrvXQUmpqhBSZwDbNKFxGptCVLb1AUkO/gpAkz1+Zfiw9JBZJcX9P0wLoG0j2a0nnbVNaZl23NEszUs8syoum8znH5RzNLo1Ipde1K8o2WZEQ9jO24h0KBOS8oDwXVjkrtq0ZLdndOa7PkBTELC7JfU6MBSgWn/4tctmqmRhshL+64s+hNhqBUbVu7PlYDf1u88lfCFD57AzUXRCmiUL7dkSyc/xL2kcGE1QDJH25bdomQrbToYfSp9H80I99KkTweBxG63Fv6gd/b51Fn6e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(40460700003)(54906003)(110136005)(82310400005)(36756003)(34020700004)(8936002)(5660300002)(44832011)(2906002)(86362001)(47076005)(316002)(4326008)(186003)(16526019)(478600001)(40480700001)(81166007)(70206006)(70586007)(8676002)(7696005)(41300700001)(6666004)(26005)(1076003)(2616005)(82740400003)(356005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:46:31.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039e87c9-dffd-412d-76c8-08da5f452b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0138
Message-ID: <20220706113806.uqlXkfhFjr4RZ-vMTrK1y1UU1Jjz5EUhqVgdFpiQMYQ@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To allow IOMMU rlookup using both PCI segment and device ID.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 19db4d54c337..5e4648cadff9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3246,8 +3246,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
 	struct amd_ir_data *data = NULL;
+	struct amd_iommu *iommu;
 	struct irq_cfg *cfg;
-	int i, ret, devid;
+	int i, ret, devid, seg, sbdf;
 	int index;
 
 	if (!info)
@@ -3263,8 +3264,14 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
-	devid = get_devid(info);
-	if (devid < 0)
+	sbdf = get_devid(info);
+	if (sbdf < 0)
+		return -EINVAL;
+
+	seg = PCI_SBDF_TO_SEGID(sbdf);
+	devid = PCI_SBDF_TO_DEVID(sbdf);
+	iommu = __rlookup_amd_iommu(seg, devid);
+	if (!iommu)
 		return -EINVAL;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
@@ -3273,7 +3280,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
 		struct irq_remap_table *table;
-		struct amd_iommu *iommu;
 
 		table = alloc_irq_table(devid, NULL);
 		if (table) {
@@ -3283,7 +3289,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 				 * interrupts.
 				 */
 				table->min_index = 32;
-				iommu = amd_iommu_rlookup_table[devid];
 				for (i = 0; i < 32; ++i)
 					iommu->irte_ops->set_allocated(table, i);
 			}
-- 
2.31.1

