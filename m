Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743232F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0PSkNeCghttgIid/+Kx3cLTWaQB/46iQhB26yDvPsaly2+TChho2nCBH69ot0pCZDOoh75nM6Ze1fwav+jmzE7ABpEEqGx0TAnVWfFyCQCpOrGB2XwcoFhKkPbPe8lFAbQSbamIjbKbCFzh7z2VDA/s26ThOjutZCyPxG/VJHrJWOEkBvJ0QogNhVmz/A5apyxNMbHAillOk1nTEUrjOUh5JU2ZxVPGS+eZExw4GPtQB5J+KeqAnNpaAKir+CJm7zhTUkxDjMAnkSm4mrGSWC0gi8Dv5SMSBFgjsKfMzK59SAhHys+pFhp96U+am9LBnrQOeE+rVi5gtrctdyM0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9echDqOKJGNQeDnnZWr1O9BDdaaHPHA6kXbvnwejgN0=;
 b=A5Cf2El7r5yiXoCZ9ygoG2Cf1EkyL6ULvqIYKZG8PEvgbvRgiYmC7pskE6Ywgb7ehOI4A1JuMvsEdiUCpn3prsq391k7OObezNjkCc9W0Oz532/HUppUA4sODOw0SKlbbLqEJhbufkXNFOcc9KHkX39tLutNrsGniSNZglhjAonuSBhDdgdwGyV9snv6Ac+BxlnmLlph4XbO80GavYcPrKX9TYDuMuIYLb6WQESqhIwScIewVZTVuNR2H1m8QhB2ugcWJ0+2xVmrhinvk7wjChn0YRHD5YBFQ0kCtv7tXq9mmvFSKXK8aPYMuxaOe1jjitb/9lA7Kjhvhp38U+gN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9echDqOKJGNQeDnnZWr1O9BDdaaHPHA6kXbvnwejgN0=;
 b=o9vU/LH5Er397etqEjNiwKoO1EGcmnzGl/qJBzM6hrvk8cHWcUvn9eC5A/R6i9icb1S5F2q8OCJzYQ0my6ox5BMhxzBFkl2v0PvEvd3mohh6kYpohCD8UKtB6V8lvAxoAs3rxTmYSrwFnOkzbGx7z2jsojF9pfEx9WFUW1gKJDs=
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 11:43:42 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106::4) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:43:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:43:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 05/35] iommu/amd: Introduce per PCI segment irq_lookup_table
Date: Wed, 6 Jul 2022 17:07:55 +0530
Message-ID: <20220706113825.25582-6-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 930c0abf-022b-4b58-5f49-08da5f44c6ac
X-MS-TrafficTypeDiagnostic: DM4PR12MB6205:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lUTBbmKpCPrYp0tjECjCNUxl+i7EVTW+oIgLdSvLfW2WrBwfcW9eItRJtK3uVsDG58loITL6/wYkm7/GYBsGLYm1KdcnnETZjhVBRl27Ovtq2mu/zSatcmBvgDo4sJcD7VvYVBeeasdoQ6aF4CADkqgpgG8gN+La0JehD+3tZhV4XS6fFGk8rEFasflHmo86shRDXmfgJg7GjOgfv/VP/cKhdBjfUoRIe6hdXUMSILqHF4Dnbnftm36wwtERrhwNU4C4RQz4X//sySA66tbk23dGHQPr5ETNwcJq0gGRkXOiAg7YogxkBoytWYJEOQ3yyBUoC99rtH2WyHdrp7RPtpbt4cTY5uj43+pNj+tHmAu/8fKvO4MBcHa3DIBQqN7TBtOKuHvu9g1eHsAZv/jYz9pK5nNCafLPsh2OZXkhmiraTal0+KWdnLXzUzMrEnuhw5qjt0wNqzqV87j5MRDgSo2l6WbsWq8uclvIKv0Upkht0fh9QSPqFJH7LcXNNDy8pRFBDq5XuqBU348N7lMi9x1I7qk+wqy4MxgEmpB4AwqJ4oEPNq+qlrsGnCYW75tgaCu4YoASAOvAcgQNliV8zwz+EXo6tFijSKtkKMvJLa/KVcTkle/B5IWjLpYslDJKnMFlIFV3TMgC/iMA3p7pVUWKiR6lOX0YswZRsyQpzreU6r2yasxpOKmf3PsimDTQEfjmeq6aNJVQvCw7z99QaMVFR2YSHMmZ4alKnmiUKZN6q7/gty/BLgxy9SNNtwtxuDuicqDlDQ2PCohFdjBbhhSJSzUfIu2snn0bBo4xOJ8B4hNxVsDSxsqjaoBaLNE/z3lAkM3IXoKY7WuTeFkjHYNOjf9iHavG3UiLMT43zvO9PH9E07t9uzW8S+epXvGS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(46966006)(36840700001)(8936002)(26005)(4326008)(8676002)(70206006)(70586007)(2616005)(478600001)(40460700003)(86362001)(54906003)(110136005)(5660300002)(316002)(6666004)(2906002)(41300700001)(7696005)(44832011)(40480700001)(16526019)(186003)(36860700001)(34020700004)(47076005)(426003)(336012)(83380400001)(82740400003)(356005)(81166007)(1076003)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:43:42.1321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 930c0abf-022b-4b58-5f49-08da5f44c6ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
Message-ID: <20220706113755.Iw4tJVNyRn-Ir4otyEAhe6qFCLhLCMwuZT66ODjFr8U@z>

This will replace global irq lookup table (irq_lookup_table).

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/init.c            | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d0ee78c656ff..cfb5f0e44186 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -565,6 +565,12 @@ struct amd_iommu_pci_seg {
 	 * device id.
 	 */
 	struct amd_iommu **rlookup_table;
+
+	/*
+	 * This table is used to find the irq remapping table for a given
+	 * device id quickly.
+	 */
+	struct irq_remap_table **irq_lookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2fb3e1b82e09..f6678dd56e28 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -684,6 +684,26 @@ static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->rlookup_table = NULL;
 }
 
+static inline int __init alloc_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->irq_lookup_table = (void *)__get_free_pages(
+					     GFP_KERNEL | __GFP_ZERO,
+					     get_order(rlookup_table_size));
+	kmemleak_alloc(pci_seg->irq_lookup_table,
+		       rlookup_table_size, 1, GFP_KERNEL);
+	if (pci_seg->irq_lookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_irq_lookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	kmemleak_free(pci_seg->irq_lookup_table);
+	free_pages((unsigned long)pci_seg->irq_lookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->irq_lookup_table = NULL;
+}
 
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
@@ -1535,6 +1555,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
@@ -2897,6 +2918,7 @@ static int __init early_amd_iommu_init(void)
 		amd_iommu_irq_remap = check_ioapic_information();
 
 	if (amd_iommu_irq_remap) {
+		struct amd_iommu_pci_seg *pci_seg;
 		/*
 		 * Interrupt remapping enabled, create kmem_cache for the
 		 * remapping tables.
@@ -2913,6 +2935,11 @@ static int __init early_amd_iommu_init(void)
 		if (!amd_iommu_irq_cache)
 			goto out;
 
+		for_each_pci_segment(pci_seg) {
+			if (alloc_irq_lookup_table(pci_seg))
+				goto out;
+		}
+
 		irq_lookup_table = (void *)__get_free_pages(
 				GFP_KERNEL | __GFP_ZERO,
 				get_order(rlookup_table_size));
-- 
2.31.1

