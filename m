Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8699DC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31238410A3;
	Mon, 25 Apr 2022 11:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbZms6APp99v; Mon, 25 Apr 2022 11:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F113409FE;
	Mon, 25 Apr 2022 11:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 742E5C007B;
	Mon, 25 Apr 2022 11:35:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16875C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0523D81765
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8A870bKXYvP for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:35:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2676D81497
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfgbdlrsFrhg2cJOJRL+pqyeYCLOUSTF0gYvCAKv2DY0VceoeJSqsqvH/ruxfw7RM+Za4L5yMuwcgDUMPKOmMVfYnZTSYFhF8/pLc6ERf1phFfasAfKC/x5IfZuaAXir6FTXdMWJJ+OSwUDgcHvv0Z+YR0MDDDwjIIXrGtmK/g75grO3VPyWN5TxPAIVA4teMyxH71zOc56oqjS5ivwUbvUBzTT+Q8Dn7T2gjfTv5R2Z6H8pIRsK4VMTeZ/d/qgpmFVt1v2Dx4XZIT6M1UYu2IFIvWc37tZ+6PEY7wbHl3RoNPShgWLU8d1qYRPPiv844DaPvJ2Y/kf2n2ld5/JHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GuEf55Ec5Wqvoom7Qj+637fh36mL2mPxfWkTwYj61E=;
 b=QovtjXnTsZ/E+xa2q/IeE+zrHG9tdlno0Rly0zx00Hj2keHp1LAQzudOiVpKkLtb8P9bP7ES9vK68nSGjBoJFQ1YAWPM70FO8kyhOUrhxRu3CbpxW0efBSKN4/w4zvN1n9wQEWfj5vEa9yL2mxC2c0A4qO2nshvNaMW5uz5m2A0NdBDtNdcuTlHWsNqdNJdqvwvWyvX8Fz2L81g/o2iEzrVz3TliAxiw5SPkTPaYdZ8o4zFob55hf/YVVcCSGCPV7hmXLsjTETB84waQPdx6HVfEt9SZzEpqzTtPWCm3vCgdJLxdbtOt3Lf/qmqLRuNVciqzt8AnhOmeBjNakV3UXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GuEf55Ec5Wqvoom7Qj+637fh36mL2mPxfWkTwYj61E=;
 b=pSx27BV+ygdApnDT4FCQgELJl3Yj3wWS1zKc0NqXoNip/ONbwyJXI0KqZHpUbOXFdq0eOkCsdZ9VsXpZSgeq1Q+WHbm+mkHdLLW2vmsCfgO2Htscb5OdF4TIMTa8NjJ/v2hhn0nxwC4dGrZjuYc+n6p8Vyh7czYxpP92GoBEoQw=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:35:48 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::7a) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:35:47 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:35:46 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 03/37] iommu/amd: Introduce per PCI segment device table
Date: Mon, 25 Apr 2022 17:03:41 +0530
Message-ID: <20220425113415.24087-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc18d49-06b3-4bae-a005-08da26afbe53
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02060141150D8A8BB4918B4087F89@MWHPR1201MB0206.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PelmBjoHZEHFcg0zYi2uIVCtJJiL3xkdSOCa+4wwoP/t1zV8PVDwetIiiZlGoYLNwuiiN9g4e/3tpkBsTCoZJKwyl4lgbknEN2dBWIsAaw61N3iKsX8+qqEu02y+JwxgV+CIoXNIJ6Dzk7sFIHiSIY/DB8Gz8C3ArM1oNYUMy/zl+1CKGuGZC7QOfhW53ozMV2C4Z+IrlxwJBvqNxNjzYsmv3AVIX8W08g7hZTmGqiHYrsVKlCm9wg0AEZFAZq6KBDeyvUk+3TT0ctM7mA8gcJJpUyH5sP0Ixz64iV6tGkw3CHxkeYQXOEPcNDOjekIpTQwfwy4UbuKD7tQbbkd/Tv/iXvBe012m9IPiTf0w5BhsGd42Xjenf5msGBR+WqF1hdXhAcK4c89X40s4YWz3DCP7B9M6CGLS7H0LkjHHFwmpWksdpmauAwnr7WAVBHZ4SzI0HBIqbjN1bmEpxaoAwfi2sxBFJIvxXYVSFIQ3Scya0QKsbnvJptuKPIt6EKbEPY987V/WpWWjEn3YDrsscn0dS5e4mHVZsbH1Kbh3vF475+eiwrC+QuKcU4i/0o9uVhfD/+dCpsbshG54ybpH9Kh1jwfV7Zsk5dvMeP8wCaD2pvP/YPCsP3t19J4dza28ccRdvAaj/cL+H63eU76KnmATcqYIQO7J3KCMWreQxHRmS8sWGsdrVAYOVB/GZmNCT8zNIVLBVl37R+K3uYLJ6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(316002)(26005)(86362001)(2906002)(40460700003)(2616005)(6666004)(44832011)(1076003)(36860700001)(5660300002)(82310400005)(8936002)(81166007)(70206006)(4326008)(8676002)(70586007)(186003)(16526019)(83380400001)(336012)(508600001)(356005)(54906003)(47076005)(426003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:35:47.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc18d49-06b3-4bae-a005-08da26afbe53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce per PCI segment device table. All IOMMUs within the segment
will share this device table. This will replace global device
table i.e. amd_iommu_dev_table.

Also introduce helper function to get the device table for the given IOMMU.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           | 12 ++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..885570cd0d77 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -128,4 +128,5 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 62442d88978f..404feb7995cc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -539,6 +539,16 @@ struct amd_iommu_pci_seg {
 
 	/* PCI segment number */
 	u16 id;
+
+	/*
+	 * device table virtual address
+	 *
+	 * Pointer to the per PCI segment device table.
+	 * It is indexed by the PCI device id or the HT unit id and contains
+	 * information about the domain the device belongs to as well as the
+	 * page table root pointer.
+	 */
+	struct dev_table_entry *dev_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e01eae9dcbc1..0fd1071bfc85 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -640,11 +640,29 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table)
  *
  * The following functions belong to the code path which parses the ACPI table
  * the second time. In this ACPI parsing iteration we allocate IOMMU specific
- * data structures, initialize the device/alias/rlookup table and also
- * basically initialize the hardware.
+ * data structures, initialize the per PCI segment device/alias/rlookup table
+ * and also basically initialize the hardware.
  *
  ****************************************************************************/
 
+/* Allocate per PCI segment device table */
+static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
+						      get_order(dev_table_size));
+	if (!pci_seg->dev_table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->dev_table,
+		    get_order(dev_table_size));
+	pci_seg->dev_table = NULL;
+}
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1469,6 +1487,9 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 	pci_seg->id = id;
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
+	if (alloc_dev_table(pci_seg))
+		return NULL;
+
 	return pci_seg;
 }
 
@@ -1490,6 +1511,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cf57ffcc8d54..54b8eb764530 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -134,6 +134,18 @@ static inline int get_device_id(struct device *dev)
 	return devid;
 }
 
+struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
+{
+	struct dev_table_entry *dev_table;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	BUG_ON(pci_seg == NULL);
+	dev_table = pci_seg->dev_table;
+	BUG_ON(dev_table == NULL);
+
+	return dev_table;
+}
+
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
