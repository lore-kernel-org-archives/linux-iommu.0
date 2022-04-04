Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C8C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECFC960C34;
	Mon,  4 Apr 2022 10:08:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AfnnyYo-vWbI; Mon,  4 Apr 2022 10:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 98C02607F7;
	Mon,  4 Apr 2022 10:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C055C002C;
	Mon,  4 Apr 2022 10:08:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F25BCC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D261882B24
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eu9Z1BYaH3sA for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:08:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::616])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0A9182B21
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHpJ5k88anD9cTuuYW2Uer7NQVETagcICglCjRvx+IcGnlgyACsazhPCuPTQIrAyNVGrVulozrhRxeLQmbACcewMtNvCsXpDSjpLqsmtsQxE9Erc67PLTtpzTx8FFSdrAVu4HVJMRvS0Q2298X0oJtMjc0VZPDD08dix/F4NM6y3kLd5GXRA1VqHywUs7+LcLEqqwo1pTB5Jp2Kn8NQtKsgqUPRaRidbiGrt/afXS0DHtKnWY7ZDuybh8zZ2aNihBmfXt6PNLB2oKntt68Xwfo5mYcDgS+ScU4e7y7O+cXc4eScTmeHCr0BuJRZX4q5OUaTP2zT8AWBBrnTAfSjZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1PxE/jM2nHZ44rAXo7gJDf9p13B3CMg+KPIhm8jhMc=;
 b=dbRalVm3Nqs1Jd3Olwfr+ueSXPLrpDP9YXNPTIGlA/uuxHstZ9TCs9yzMpvqCVzmb4d6Akgxh64T3RONIMnKI6dvF3WIpCbvtNDCdFhMXuP0jZQ7KnMMO3FnxqAF6p/WLROmW4/LpR6QNvPhnJ6kHl1w3XLKi2xP/KIVZ87KU9hV/wjQ7HS8O5t6F3aTrprucZjl0db3dVGvdfsbhE9g6oE/lIlZCIKMD7mMuMdy2BrwVi8f6mi38MDptwRKtW67Xtx1G55LwVG5oyDEuyFcA6J5PGDmGe/FN0DcZO4h5QxxwuJF4UHAd0pVPHkgjBv7uI7S6VnhBPOBhiGp3DWIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1PxE/jM2nHZ44rAXo7gJDf9p13B3CMg+KPIhm8jhMc=;
 b=OJBXNYITyaME8KLa0MU7yKGxseuQp8v8aquFgvvR6a+fqs800oEjR1B4UKFBSUC1Q6hzZv/7zocvtu4KweiztqMR7+lb/3+AcVki174kexQBwz5Kr/6lbZxI8prfZed6Z3vsjl4jVdX6U1gL6UW9ZJQoDjH3Ae1SRSIxq8SZnN0=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:08:06 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::8a) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Mon, 4 Apr 2022 10:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:08:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:08:02 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 29/37] iommu/amd: Remove global amd_iommu_last_bdf
Date: Mon, 4 Apr 2022 15:30:15 +0530
Message-ID: <20220404100023.324645-30-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 475ded4e-6bff-4273-6a8c-08da162302a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4959:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49598B35D466E507D531496487E59@DM6PR12MB4959.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C04zEgR9+fAWECHSz6Segi64Dq3bFR23g9b1O4ooYI8gWDZ/Vj8v22zoAxjrdnsxHcVyIJ4n9bbz73b1QmWCs2ZKIRgcGmopB7A3eKWAfKZUD6a727WrHhMzE2988vktYxehIk/OdqlrEBL/8EKkoZJfgENzt5Vylgxt2u1MveBm60xAMwu9uq+WJP6wJQ/EqTUMP4ld6y2g8EtNlJYXClvSAOG9gVMWPCb3yaLQWql/BYNhPtoWS7EKbfnOVjSx7JzWoYtzAcXfOBQaTzA1NeTirVbXSTPYpHr1smZA4aFQXMfTrGd5jgr0puU1wGjV9OF866Hhs4MXI7/3LJ0xV9DsLzilkAqpsIoG0XlyGzdsJwn4F2J2y0rErsso2ONL2CM6XO7AqmEPg0V4VqPsGWOBI60EWM/6y+POYiSqg4c+q0rzCvS0gWl9MC2KTR3hVuGEDNupw9r8FTIEEbc7dExOv8F1XLBxY29cNrGHUsEF8PBiODazuZBgRrWsTtpekflsWOO+qOC4xVmNMCq57oxZPmX3DVT4fm32x5mQtILMu7Es8p1qljgyZZQk1WFWM6jGSHPzEF5BnNGxvgW7c9OiQxgjH79tFDrO6LvdOPF6v2h+BI5OCvp9zZ0OkZoX57mZUBrV/NYadq6OqydXizCCKycCVtMf6p+EThF0/w65G0oLnTPwbajmqrjkI+55BjCxws+aXRCs0Asa597TWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(70586007)(70206006)(8676002)(8936002)(4326008)(36860700001)(356005)(81166007)(44832011)(5660300002)(6666004)(86362001)(16526019)(316002)(83380400001)(36756003)(508600001)(54906003)(26005)(1076003)(186003)(2616005)(40460700003)(110136005)(426003)(336012)(2906002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:08:04.8402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 475ded4e-6bff-4273-6a8c-08da162302a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
index 13731fa241f2..69c88e6c9fde 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -357,6 +357,8 @@ static bool pci_iommuv2_capable(struct pci_dev *pdev)
  */
 static bool check_device(struct device *dev)
 {
+	struct amd_iommu_pci_seg *pci_seg;
+	struct amd_iommu *iommu;
 	int devid;
 
 	if (!dev)
@@ -366,11 +368,13 @@ static bool check_device(struct device *dev)
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
