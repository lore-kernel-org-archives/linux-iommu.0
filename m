Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366523AF
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 09:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6mlkkIaNqJBo4k3UkxlgSXAqfKyspCK4q8kKDEJ4FfSXQf7sHpOwEJpgJP6MPwANh+P1DAIgJ3ZpltwqYe4qpxj+Yj6d5thAvJ7xQBQD1tX61A9W1WTBS9y+26gZFgmEULLOdq/G1c7TgFnvl0R4mN0J9bgTNX3j3LGix1xrB8rf9Miq3U4B3F34po7Ke41gMjJeUJaQpepccAQvqi+QGNVIsaM5ya2ZeZQP9C+3T7SXD1PWVOFM6SWhXE7tUb7ZmBXYMBCO+3bZQY5I3XeByAj9EzTNqPZCPR+0BSfdnhui1xWelbJ57ZjAP5h+3Y0o8pvRuJa73AF9rsSAY9Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MFrgCnq8qQl82HsgD99hp30SRUdjcla9t2fhE2nk6I=;
 b=f9IO4GwzrFvU2vRM/7c39gFwH1SsUZJJpyJaLmy6UwCdamT7aaPYl9zYWtM9btl6AjHUSc7kJZy98V4rEszU92R60LsIdcKs38saFBB4jGxzCWfVLQg5bH25V8S6HJVA9w1Kgkg0qhGJDLG0FJ5pxpXTfOw/NA2u9nCz59gKsd8MAlX3jwwJMzV64WYaKwWes5MXCHgxaQlSLIl/MxI2PRJqTeIFD4POI1WI8cs/rZ7r6qAc97wXttCSq3t06a/t8zXkYzxIyE9aD87689oSVOhKIQFRpT8V6F2Z/bnIh3T+RmqyPAODWv9gz6nBqnrG/mp5WcuECSZp1iLcQ9fUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MFrgCnq8qQl82HsgD99hp30SRUdjcla9t2fhE2nk6I=;
 b=a525ODI1UMP5/d5x9JDIUSYt8OH613IT3v54/D60h8kkCX1/gYLHxSdTO4eTEe+x9OqGT5rANPvv9P5xMMAscyApZpRks3GpwjOOpjgT0m0JlMV+RgvdA5KgKFS3GVc6MPaPScSjntbQHCy8JQp6nlMd0cajlxRKRd5CBve5wLY=
Received: from CY5PR15CA0143.namprd15.prod.outlook.com (2603:10b6:930:67::12)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:32:40 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::4d) by CY5PR15CA0143.outlook.office365.com
 (2603:10b6:930:67::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:38 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/3] iommu/amd: Allocate IOMMU irqs using numa locality info
Date: Fri, 10 Mar 2023 09:31:30 +0000
Message-ID: <20230310093130.6064-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093130.6064-1-vasant.hegde@amd.com>
References: <20230310093130.6064-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 727272b8-6093-4150-d1b7-08db214a64e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7F8Jmwyz5G032E+eF+pb4WB+anfh/HwUj74GN/FTcEUuBYA3vm9t4QnJ+maC8Itx+MX4bhvcrfOAgoxiPrivL7ICbCCH/glp7lqPlQ9lZcVwP96DKd62lQru7i54mj5bUQmvrdotjENUJA2m83eXhe9/iJnWBHiUoBw5obcbQgxe17I5JJJru3got//+L1XkxueaU0VozG48SqvkOFZTkoMN16TpB25mNm23yykzaJY9QXmJAI0BeTrMQDNGWok3myvvZem0xKvjQ19N0/oXvI957O9jJWJjKk2VZWy9iAV0hZXVO/xg6zLpzpxWZt8e6kpCao4bCkuShvXPSdb/TrTs+gWaHtl4+2kYPhkHDRInQTSUut6KyyuwL3AdTEGGR8j7HxCh8lwKPjkWpnaqGhGxo4XlB+yoPPOxCrR2npVrknXKZeS6WJDRg2IpDVZ4WMPWBdz8hX1ZoqkrM1e8i+vwOsg7NaYJK9ZSGoNgn+UL5KvONWStwfP9c+krq9v0Yy0RlMJHvtsXWOTTuvxBet3okUX02+QcgRxGX4FPHxyqI2SHRsY6boCcvBSbAbWB3PZYOHExcw4rUUUP7P+22HCqav2rmk2nMpIaoQvaVx+4Yb1VAKQRn58DwMJAsnowkIkWfuYpg14GjTPTLqZIwbE+O2Xv5O3Ri+12AQYCAq4ocxmB+DQIoJgV5KP9qhqQOVCPa3xGEuw5MY4T5k+R/LAIiqxjUC/ZuRmn4cDD00o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(47076005)(336012)(426003)(110136005)(54906003)(40460700003)(36756003)(16526019)(356005)(40480700001)(86362001)(81166007)(82740400003)(36860700001)(82310400005)(83380400001)(6666004)(186003)(1076003)(26005)(2616005)(7696005)(316002)(5660300002)(478600001)(2906002)(41300700001)(4326008)(8936002)(70586007)(8676002)(70206006)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:40.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727272b8-6093-4150-d1b7-08db214a64e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

Use numa information to allocate irq resources and also to set
irq affinity. This optimizes the IOMMU interrupt handling.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 19a46b9f7357..141eca29c951 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2383,6 +2383,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	struct irq_domain *domain;
 	struct irq_alloc_info info;
 	int irq, ret;
+	int node = dev_to_node(&iommu->dev->dev);
 
 	domain = iommu_get_irqdomain();
 	if (!domain)
@@ -2392,7 +2393,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
 	info.data = iommu;
 
-	irq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
 	if (irq < 0) {
 		irq_domain_remove(domain);
 		return irq;
-- 
2.31.1

