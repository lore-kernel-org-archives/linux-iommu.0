Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A26EC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEEBF410A6;
	Mon, 25 Apr 2022 11:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3hUEPsp8s45; Mon, 25 Apr 2022 11:42:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1892440250;
	Mon, 25 Apr 2022 11:42:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4331C0039;
	Mon, 25 Apr 2022 11:42:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABEEC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 090DB81AF5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G8_VcGTA_v5D for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:42:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 130FF81AF4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtVBnndgYkH2uWD1II6REeYFDPCLSJlyAq1w6vG8AXjDMxphn7uea5d1jYv5oPykK0R3GyKPfTEGs9YivOJUPKjH4ju5aS12qGlkr4nk32fbZ3NMXAgnOPQAOKW3veNFdYlchLtwc0qyJD3XwjPhxUymzU53/U7Wq9yYrB2nIbrmZwqTinRwtWM31naM968luDfak+cId0WDPjE4QJSZ2AakLuCFIj8yoT0gCH/5vkQPvymb2IBlfPcYWRghp0VOZEVva9OywLGw+yVSzILm0G6qm0wed2PDesHVIYFT9Y5QKnAkAdNgqSjl2P/qoQqfraOwvT/YfKYFiyQj/RXSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJzv7bR/bfHKefAUcs8B9s3SqFOO99JTl+NnXWTNnf0=;
 b=FoB9ixWW3/i++Glzlgl8uqd3mNwxUzUnuLEHpfy5UZ1QyLWTFBTgEsB6sJ9hqM2ZC+71k72ZSzibzy+fcW6rNhF7P+Mb4+Wr3VVRFFSXMUH/57ddjxaOdeOkNuG3xoKZbiSEgdCcuG/9RkG0pM1ycFsPtQi19g0qaBUL3ItF7KEh6S0mz/gCYhPtqJ/fkaNVYM/+RbRYyj2fvi1wITlkRumY5ctX8hvggDJsqfLQh6tO5CklAJ7fiXHHvke9xv9lejQLUAWU5fYmcY4ug3Fx8t1ja7ov3WbQcEtTx6tx/FYI9BrAR9rIQ8n8Q7GuPhFTOx/n9jtX5BLXfBQbL8VBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJzv7bR/bfHKefAUcs8B9s3SqFOO99JTl+NnXWTNnf0=;
 b=wzOTAu/Cfg7QHbaKrD6odF8718+cmaUOGa0MCP48z6PXjW8cfCRkbhyILXIBw4PFRNM5IxYRJJbv9GEYsgOybyCB/7T/7VSFqA/2o9eyDePj1IOL0b1xIx/C2k4uhCbHcfiqh/b/+PW6aii/pzANz2acsCUN2a48U62lVFI+T4w=
Received: from BN8PR16CA0023.namprd16.prod.outlook.com (2603:10b6:408:4c::36)
 by BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:42:14 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::99) by BN8PR16CA0023.outlook.office365.com
 (2603:10b6:408:4c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Mon, 25 Apr 2022 11:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:42:14 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:42:12 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 29/37] iommu/amd: Remove global amd_iommu_last_bdf
Date: Mon, 25 Apr 2022 17:04:07 +0530
Message-ID: <20220425113415.24087-30-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ade1c0-28fc-46de-6939-08da26b0a472
X-MS-TrafficTypeDiagnostic: BN8PR12MB3266:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3266D023B6A22B95EA2403C187F89@BN8PR12MB3266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1YGOW4zp8q6Ye0X51fKdi9GifpKMxLYZUsi2JHALm6ecRQUBS4sXri6peQn/oRtvGT9IjiS/ZLGfoSCj3MtgdvvL+OybQNJY8wVrUfcyH9DS7ywx8ciHEZVcW9umuYl/ITPqovAHpNuBC8xoasX/qcf2BTKGVlb+dVM0H1TIwolGthjAhLvNrbXe8Pc9uS5FWuJcByY+0/2+1dUMw/mRy7um/6+LY4qjZKyJnlyXWRstqL2twhbGmCnidrEpqtTTKQGWV38Ug0oaIBPvaaiVCbKrYlLMMgrUwvG434+ojbdkxapXyIDYt6gbIdeZPNn1TK+xxmMqijwhHG0I4ePgzPYmdhUAjhGG6N5YX+XrBtVPy35Wnr5uxo8VQsz8blKXYWb3LwO8i6siiq7h22F14cy09EEc4X4dL6IC1mOveutdjVXst/q6n6G0fERn2c0ea/VB+66q9A6QPduPzk2kCwDvm2aqZISZyN84fybIXpKWwbLNT7BwjK6axfe5A23WjQR0hgjCG5oHDO8nakmBk1h5s7H49Vlg+1ejonyf+g4PDXNWX7poof+eYXsNL/aGACExESZVgbMOTHeog0u9LMn1YzyhRWjdBglXiLekmS0EE/03h0LlpTr+8R6H1vOIgoHr/Uyof6v9DxpXcKy3nXgzxclydFu8cIw8Q0Rc/vsLFoHPHKvAPkbiEQBpD1FDMOKMbO33CWgEv9541eE0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(44832011)(2906002)(54906003)(36860700001)(16526019)(47076005)(2616005)(26005)(186003)(36756003)(426003)(1076003)(508600001)(5660300002)(336012)(6666004)(8936002)(82310400005)(70206006)(70586007)(81166007)(83380400001)(356005)(4326008)(316002)(6916009)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:42:14.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ade1c0-28fc-46de-6939-08da26b0a472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
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

Replace it with per PCI segment last_bdf variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ---
 drivers/iommu/amd/init.c            | 35 ++++++++++-------------------
 drivers/iommu/amd/iommu.c           | 10 ++++++---
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0aa170014b85..1109961e1042 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -829,9 +829,6 @@ struct unity_map_entry {
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
-/* largest PCI device id we expect translation requests for */
-extern u16 amd_iommu_last_bdf;
-
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b3905b1c4bc9..093304d16c85 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -161,9 +161,6 @@ static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
-u16 amd_iommu_last_bdf;			/* largest PCI device id we have
-					   to handle */
-
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -245,16 +242,10 @@ static void init_translation_status(struct amd_iommu *iommu)
 		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
 }
 
-static inline void update_last_devid(u16 devid)
-{
-	if (devid > amd_iommu_last_bdf)
-		amd_iommu_last_bdf = devid;
-}
-
-static inline unsigned long tbl_size(int entry_size)
+static inline unsigned long tbl_size(int entry_size, int last_bdf)
 {
 	unsigned shift = PAGE_SHIFT +
-			 get_order(((int)amd_iommu_last_bdf + 1) * entry_size);
+			 get_order((last_bdf + 1) * entry_size);
 
 	return 1UL << shift;
 }
@@ -538,7 +529,6 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		switch (dev->type) {
 		case IVHD_DEV_ALL:
 			/* Use maximum BDF value for DEV_ALL */
-			update_last_devid(0xffff);
 			return 0xffff;
 			break;
 		case IVHD_DEV_SELECT:
@@ -546,7 +536,6 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		case IVHD_DEV_ALIAS:
 		case IVHD_DEV_EXT_SELECT:
 			/* all the above subfield types refer to device ids */
-			update_last_devid(dev->devid);
 			if (dev->devid > last_devid)
 				last_devid = dev->devid;
 			break;
@@ -688,7 +677,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	/*
 	 * let all alias entries point to itself
 	 */
-	for (i = 0; i <= amd_iommu_last_bdf; ++i)
+	for (i = 0; i <= pci_seg->last_bdf; ++i)
 		pci_seg->alias_table[i] = i;
 
 	return 0;
@@ -1054,7 +1043,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		return false;
 	}
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		pci_seg->old_dev_tbl_cpy[devid] = old_devtb[devid];
 		dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 		dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
@@ -1315,7 +1304,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
 
-			for (dev_i = 0; dev_i <= amd_iommu_last_bdf; ++dev_i)
+			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
 				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
@@ -1560,9 +1549,9 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
-	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
-	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
+	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE, last_bdf);
+	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE, last_bdf);
+	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE, last_bdf);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
@@ -2443,7 +2432,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	case ACPI_IVMD_TYPE_ALL:
 		s = "IVMD_TYPE_ALL\t\t";
 		e->devid_start = 0;
-		e->devid_end = amd_iommu_last_bdf;
+		e->devid_end = pci_seg->last_bdf;
 		break;
 	case ACPI_IVMD_TYPE_RANGE:
 		s = "IVMD_TYPE_RANGE\t\t";
@@ -2510,7 +2499,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	if (dev_table == NULL)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
@@ -2524,7 +2513,7 @@ static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	if (dev_table == NULL)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		dev_table[devid].data[0] = 0ULL;
 		dev_table[devid].data[1] = 0ULL;
 	}
@@ -2539,7 +2528,7 @@ static void init_device_table(void)
 		return;
 
 	for_each_pci_segment(pci_seg) {
-		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
+		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
 			__set_dev_entry_bit(pci_seg->dev_table,
 					    devid, DEV_ENTRY_IRQ_TBL_EN);
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 476217f2890d..5976038d48a3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -358,6 +358,8 @@ static bool pci_iommuv2_capable(struct pci_dev *pdev)
  */
 static bool check_device(struct device *dev)
 {
+	struct amd_iommu_pci_seg *pci_seg;
+	struct amd_iommu *iommu;
 	int devid;
 
 	if (!dev)
@@ -367,11 +369,13 @@ static bool check_device(struct device *dev)
 	if (devid < 0)
 		return false;
 
-	/* Out of our scope? */
-	if (devid > amd_iommu_last_bdf)
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
 		return false;
 
-	if (rlookup_amd_iommu(dev) == NULL)
+	/* Out of our scope? */
+	pci_seg = iommu->pci_seg;
+	if ((devid & 0xffff) > pci_seg->last_bdf)
 		return false;
 
 	return true;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
