Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6B2F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH18TgKOJub1Zeis/lA46HDzBLgfLcO1092DxZOTlVOIpPALSoJQbneTgHXCUR6M0qMiz0qGfVaxRrJa+zKPxHiLiRpsNI9UPYCIAZIESQkbvFrSK8HLrVkwYN6txpcR2la6mEaYX/Dm6FiLvmT700kwqXn26rUJSBFP2aGpQAW7kHkL3qLZRD0sLa32ZlEudwtQV5JgfTXWiTSJElC2E0nQ7jEnVg3DtCPxwz8vS8CfVsB4qM/Y3LQ66OeI4KVJfi0CHDTSb3w0vbpoaykRQ4ChUytMlPCnu7otvHuNwNE+3mSj/N1zf5+KTCrhBLQXfYJeKbllOGhpVq1lM3NtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNOUsiC7dMvP9GwbJRGlZGvUDwEz4XUDP4T8DC1FH8I=;
 b=X6JV8yqJb6m/U4ClyX3pGwSLyiyTywtSb0Hvr0SgRBYk3Y9Vy2ShZ9319af8cXnva0drcJzPGhMZ8SUD7LTJDODQg+IM/kDRJpWqQSGMY+shI5GZpDqE2/rramug7Soe3xMgiX59E67ule0cgsTK/g3PSpt32E4XYpLTJ8WSlYslB4oKOKICP5k02MSWPQtOPfziNTqMRVborbcbBYec/gnjBlBcmOZeyH1vr1Vtkqz9i+JfUjnq59Uo5EwSObaz0ED5Nf7Ch1dpUkSaFIobXdv7KvBx7jVw2h3SLvB4vlk9kd1qFpWrESCjbx+2GxXSwqVyxKb6QBmjjVPkWzNFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNOUsiC7dMvP9GwbJRGlZGvUDwEz4XUDP4T8DC1FH8I=;
 b=3+o+xc/hQADer9nPQ09NXdSbTmUgUBdxZyzlJ8qFlLYplRlA5PSEJ7qKErcRoLoXTyVsQ9dNujVCNAx3NcwaRhuaYExZRr8Vrh4JjzoSX9FcEqU1thqVBbb8Q5aBsX7WwRJJIhJnV/xtJ/Golf0rxXyICm1ay/jt4hEkaBqv8c8=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by BN8PR12MB3074.namprd12.prod.outlook.com (2603:10b6:408:65::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 11:45:45 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::5c) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:45:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:45:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 13/35] iommu/amd: Introduce per PCI segment rlookup table size
Date: Wed, 6 Jul 2022 17:08:03 +0530
Message-ID: <20220706113825.25582-14-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcc3677b-4011-47dd-e3d2-08da5f450feb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3074:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uOSMIvLmA/E8D7syv2/Uz6iVJo3UUDnA0r50S2AqFTIyW3sHovVCW/CKuq7JWLYIdS34Z+YXxOl0XK0DOgfCUI5PBWvdi54LvIC3Fu6nidxn1NYQb5zRl04eRMxDY7lvsrryKQyvP4lgWeoxbIiWq7WYrm7kLMGBZFy1qXlktcBAy+R0lZRc2lN9ribKMBL0IrUexcT72n4eGwAFa05AEz9cDZPsgrkwEo9isnl1a0OPscectBIri88ztuPmHxUEfx37Gtd8BhVMTZQDs87067iDFYpAuRfP0l+NyAemUpvNpgZQhLi/K7G/3g+rT29slXVz/jNGZNPpe0CpTwvg6MymY/HdhdQxWyCQ8a8j+MlvxYVFgBZtB/rBUAlZmcj7iAWx2OHWonCN6DAsb3N2VejpfYjqOCxinbQvRCyaLsaaIHy4XqQRHBHStcwxeojqTd4uRqxXeOyNtBhlDiTPOVtz+bwTDoYY6zKYcPN5VY5ukudNJqAqr/DC5SVvk86/c+U3ay/caFr+CVDg2rsEPO38mkADv9jrQgvA41hEqW9ABCmmJG4XLuc+HS6+kZoUxFbgOgBUiVpCOuWIZZerSQSRn8p+KiTdd//jls/COVYRjZ+fA3yln5GZQe/52Jki15PL5H6cMQVKnUog/nexpshbcItJzxTM/7LlQyENkGfj7j5gGId7XCi1+fvoG+zsqtcq2EZl7O6kokfCFU9VvoU8031/SL5xA/O8O+9KXXJwDyL+mVClvbIB6SyQoj602QcVQ6K40403MAPAyyWPoOmxChKc+5sYUUEmW1n72Eri3aIwA9Y+Am1gj3T8wUvrMa0j9YD8aHC/dlDPv83cStHpWy9dtlEos/xLZcrdmnEml4FR2nbBGVOgkR1BIUx+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(316002)(8936002)(54906003)(5660300002)(4326008)(8676002)(36860700001)(34020700004)(478600001)(36756003)(110136005)(44832011)(70206006)(70586007)(86362001)(40460700003)(356005)(426003)(6666004)(81166007)(41300700001)(47076005)(7696005)(2906002)(82310400005)(26005)(82740400003)(336012)(83380400001)(16526019)(186003)(2616005)(40480700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:45:44.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc3677b-4011-47dd-e3d2-08da5f450feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3074
Message-ID: <20220706113803.XM5poEBBAbH0tUwHA37Eg7Tk2bu3sSiMJTypt-LO9Ow@z>

It will replace global "rlookup_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8638b1107dd2..8d2d5fbdb57f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -561,6 +561,9 @@ struct amd_iommu_pci_seg {
 	/* Size of the alias table */
 	u32 alias_table_size;
 
+	/* Size of the rlookup table */
+	u32 rlookup_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 22a632397818..afe3bff5bce0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -672,7 +672,7 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	pci_seg->rlookup_table = (void *)__get_free_pages(
 						GFP_KERNEL | __GFP_ZERO,
-						get_order(rlookup_table_size));
+						get_order(pci_seg->rlookup_table_size));
 	if (pci_seg->rlookup_table == NULL)
 		return -ENOMEM;
 
@@ -682,7 +682,7 @@ static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->rlookup_table,
-		   get_order(rlookup_table_size));
+		   get_order(pci_seg->rlookup_table_size));
 	pci_seg->rlookup_table = NULL;
 }
 
@@ -690,9 +690,9 @@ static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_se
 {
 	pci_seg->irq_lookup_table = (void *)__get_free_pages(
 					     GFP_KERNEL | __GFP_ZERO,
-					     get_order(rlookup_table_size));
+					     get_order(pci_seg->rlookup_table_size));
 	kmemleak_alloc(pci_seg->irq_lookup_table,
-		       rlookup_table_size, 1, GFP_KERNEL);
+		       pci_seg->rlookup_table_size, 1, GFP_KERNEL);
 	if (pci_seg->irq_lookup_table == NULL)
 		return -ENOMEM;
 
@@ -703,7 +703,7 @@ static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	kmemleak_free(pci_seg->irq_lookup_table);
 	free_pages((unsigned long)pci_seg->irq_lookup_table,
-		   get_order(rlookup_table_size));
+		   get_order(pci_seg->rlookup_table_size));
 	pci_seg->irq_lookup_table = NULL;
 }
 
@@ -1584,6 +1584,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
 	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
+	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-- 
2.31.1

