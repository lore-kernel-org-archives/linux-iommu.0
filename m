Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D318C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7903823A0;
	Mon,  4 Apr 2022 09:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fWmqDDJIS74Y; Mon,  4 Apr 2022 09:44:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9946881276;
	Mon,  4 Apr 2022 09:44:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73E44C002C;
	Mon,  4 Apr 2022 09:44:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 479CDC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3454360C34
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uTOgOcrGOsV for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:44:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4756C60A80
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFE2qOUmwNVBTEjusnJaIY6YgOv8xSHMV7GokEGSc4ezqF6NEDCZpLZXeloIvWP6occU20up4ib95OUibECO9aXHwJy5khXCsNunRbljJ2Fe99MOmhXEnPikQ5Hfv8wSCxXQlayYSKVHWYMBj29/ipu4wKHFDCALszgzpx25+00K2AMZ1bdVm8nleLZg9dWtMfxWiGx+ZUdR29lUbyV+SRNaYDO6sZ3WuEKKRVy+H1rXQGe6li77yBrIMLvlTBDcVzub5la8XzojW+IwWBpYGKB4gDS9L3L1r7TEcYUVM35PQoPZkfYlHS/sGCLLO5zF9CPqScVjCJstlHCuHKsdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqFB+qy+l7atMnGPRWrBouoYbjlI+IkU5dDGzQhifQs=;
 b=Hzj2auBYhp+jh2whfrv+V2pc1TFIpIRTq5Zs46JhFQpkWePgGozNvYNKa8ZUgLX07g4RmFVy2K+kSc43DXRXFtGkEcoThwz5pvADW71KSw1fwx31pWhdhb5lKl0W0VgRKkK8UFbDtFSCu+DcV4hU4rUcAZ9bbRkmAbad3g6kr29Mpghx5RHSNhg1BU4U3w//hY9EHB8tWube0wyTka2Qk5ZFPHelUQnJxIDVxvisnaxBqdlLcCk7KJQZwcxXNtwuzsICY05HU3r73EeliCCMVpkS+UelaZraFEbFTB0+q7a4B7v7qj8JmxDROVH+48L+8o+LE+B73NlXlthPxSVRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqFB+qy+l7atMnGPRWrBouoYbjlI+IkU5dDGzQhifQs=;
 b=kK9cba2xoKIUnOf/FSrmx/ohxikvoavcxNJPYEakcdgKpT0x2yP4tYlB3AbElG9mdV2ziFrlQo28WNNEGUx2f8IVQ6Y4iEAi7yKfZ2mFxmisGwMFIuaCk6Cn3QodGG4LRRtnZAArGScITzSXRtpmLgdEhiV8AFau/V8BKzIfld4=
Received: from MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::9)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:44:21 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::d1) by MW4P220CA0004.outlook.office365.com
 (2603:10b6:303:115::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Mon, 4 Apr 2022 09:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:44:20 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:44:15 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 04/37] iommu/amd: Introduce per PCI segment rlookup table
Date: Mon, 4 Apr 2022 15:10:56 +0530
Message-ID: <20220404094129.323642-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c81014-0d47-4275-0b09-08da161fb1df
X-MS-TrafficTypeDiagnostic: CH0PR12MB5298:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5298440D0F7850F81EEBA17B87E59@CH0PR12MB5298.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQmYl6zMb+tkWkWIeuKXpmkXiYBdEkSQcBqWp56jbjdfcr1psHlDwWwemEXGp4bczQawR6O6fMhWRop4k2mQzECttYobvsYctB342/7y6Yva+5tmfKBREHEFNn3X0ccSPep/MV+OcxP0TwXVYGB6AYxK6QOrqVmV4EII3PBMdKEYLgqLzHw113yyche47y50eiucNEmiaYybiwOIhgimCXT86qsSUUgmBq1qbHi4bRKqcwl4TZmhAY5NbVGDCdARyGrglzwaFI/FViRdxuaGPlTFoPKYjwxpM4XFMz98w15OQCEZIqKpq3rvpoQ6cKO9DWzTGspGC6S4p/8FqYN959d/9Of7a6qvstFdzpylZpQh7+uoD82UdwJQxxDUu2Whp9gNTCsH+ZvdORH5RF6hSNiJ0AlHdaca18YZwFqSqjSek4bsLWaGdFxQNljPI4iPIUHeEc9bt54qmangcgvlo5IbqxTxrATC8eo+WnvfOrTJIa+cmtKsmYGiMaFo3zBqIMoFgPxZ34/8a2FCoXBuiQK7cISkLYT45Y3skdI2QuAWJQsH2NCTyC86NAULOj+vsfvz8+mzbDq923p6BlTDUtIqqIpTs5mqA6WPbH4E+GKaQ08xOYwGBSou0fOXY2ioFaFuM7Y01mxZ4355X7g0Sxs895wP7ZE3UMqKRq7EtHG5QftyYHm1L2YMRzXEZyi4qDzG3XLqexj7uWBQCg10Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(356005)(26005)(8676002)(4326008)(44832011)(40460700003)(1076003)(186003)(6666004)(82310400004)(54906003)(86362001)(110136005)(70586007)(70206006)(2906002)(81166007)(508600001)(16526019)(2616005)(36756003)(8936002)(83380400001)(5660300002)(336012)(426003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:44:20.8453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c81014-0d47-4275-0b09-08da161fb1df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
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

This will replace global rlookup table (amd_iommu_rlookup_table).
Also add helper functions to set/get rlookup table for the given device.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  8 ++++++
 drivers/iommu/amd/init.c            | 23 +++++++++++++++
 drivers/iommu/amd/iommu.c           | 44 +++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 885570cd0d77..2947239700ce 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -19,6 +19,7 @@ extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 404feb7995cc..9c008662be1b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -486,6 +486,7 @@ struct amd_iommu_fault {
 };
 
 
+struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
 struct amd_irte_ops;
@@ -549,6 +550,13 @@ struct amd_iommu_pci_seg {
 	 * page table root pointer.
 	 */
 	struct dev_table_entry *dev_table;
+
+	/*
+	 * The rlookup iommu table is used to find the IOMMU which is
+	 * responsible for a specific device. It is indexed by the PCI
+	 * device id.
+	 */
+	struct amd_iommu **rlookup_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0fd1071bfc85..a2efc02ba80a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -663,6 +663,26 @@ static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 	pci_seg->dev_table = NULL;
 }
 
+/* Allocate per PCI segment IOMMU rlookup table. */
+static inline int __init alloc_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->rlookup_table = (void *)__get_free_pages(
+						GFP_KERNEL | __GFP_ZERO,
+						get_order(rlookup_table_size));
+	if (pci_seg->rlookup_table == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_rlookup_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->rlookup_table,
+		   get_order(rlookup_table_size));
+	pci_seg->rlookup_table = NULL;
+}
+
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1489,6 +1509,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 
 	if (alloc_dev_table(pci_seg))
 		return NULL;
+	if (alloc_rlookup_table(pci_seg))
+		return NULL;
 
 	return pci_seg;
 }
@@ -1511,6 +1533,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_rlookup_table(pci_seg);
 		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52058c0d4f62..a8baa64c8f9c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -146,6 +146,50 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
 	return dev_table;
 }
 
+static inline u16 get_device_segment(struct device *dev)
+{
+	u16 seg;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		seg = pci_domain_nr(pdev->bus);
+	} else {
+		u32 devid = get_acpihid_device_id(dev, NULL);
+
+		seg = (devid >> 16) & 0xffff;
+	}
+
+	return seg;
+}
+
+/* Writes the specific IOMMU for a device into the PCI segment rlookup table */
+void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	pci_seg->rlookup_table[devid] = iommu;
+}
+
+static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id == seg)
+			return pci_seg->rlookup_table[devid];
+	}
+	return NULL;
+}
+
+static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
+{
+	u16 seg = get_device_segment(dev);
+	u16 devid = get_device_id(dev);
+
+	return __rlookup_amd_iommu(seg, devid);
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
