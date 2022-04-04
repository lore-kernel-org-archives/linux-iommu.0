Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58640C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 179AC402F5;
	Mon,  4 Apr 2022 10:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lpAmIWTbzZBI; Mon,  4 Apr 2022 10:02:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAA614002B;
	Mon,  4 Apr 2022 10:02:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1CA6C002C;
	Mon,  4 Apr 2022 10:02:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45D51C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2542D819B8
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5d2tGXBPdz5m for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:02:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E54CE8187F
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7lnsK1J8voucDtuaBF5WaHmxGjY4mBQrJ5BarMefwn0fwYJHEI+PLl5SmuYMveTLfkTySp7VX18a2n5aoi80+3wK+lNvyFlSoq2MY3l0J3e6IRyzl81jEIYZWI+G9NJkMMLIh5CYbg9Q15hbcuDAP/baVhK43n2ZMmDPIslWcCx2GFHKeZGTnyS3J1SWuw7WATpdolzyHUQd7RQ7k8RfQwBfatBAfCaNA8CBSJnhu4Es1toXjH7peofwBvTPOL2dvBC3VyjC4Ebu3zpeA3cNaAEdkKY0SvzZf2GhhyH2zzSKsxnpleZCeP6QPSetVlB0l+uOCvqqbsw0kcOwn8wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhH3ERBonZheciGKsN3o06O+r3X0DeXg/QJUEySf+Ho=;
 b=KCvOX+fOoItPes6+Lc02GVVLyyfSg9YMOmK9WDH+icjuKAWEOrduTMn9THGUJhe2BN39dXdhM+KBBlK6zTDmPvfXjxkq6FpXFPvji+TXiK2GfOFyFkPyI8pbCmYP8wzc/ukr7GwsyJ7zOvx9P3dobZ2k+HsXqkLbfIQWCisU1IVn6y8FkakqfixHmGltKSCw3On8M8cJhiBb7Jfl9Yy03ZbOjTgU3Cwx8i5AMEl+LCgNMyhmPOntnTCMzk2nXYlARk02mHGf/OR/+Gv9kbOffbm7KIjmcSkqqfxbd9ceKeQFq4AichgT5zzHE8+1XP0rKlIymCainzAwJ9nPDIVayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhH3ERBonZheciGKsN3o06O+r3X0DeXg/QJUEySf+Ho=;
 b=w/nvkzQRver8XrkzI2PuVcvEcrkrp3euKYR7XSBs3kQvpm7jd7kuvVJcwclbrncGRJ9t0ujdsR4b+bzY+Niqw5H5WDbVNdPMuMfw+PkikMXJKQH8pdAcrT/AZ9PLAt2aaMh/HnoKKq3VMFP/lnXcdLDvDag06Anknz/iKgZLhkk=
Received: from BN0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:141::33)
 by CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:02:35 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::20) by BN0PR07CA0024.outlook.office365.com
 (2603:10b6:408:141::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:02:35 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:02:32 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 07/37] iommu/amd: Introduce per PCI segment
 old_dev_tbl_cpy
Date: Mon, 4 Apr 2022 15:29:53 +0530
Message-ID: <20220404100023.324645-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be22a52-c217-4cf0-bf51-08da16223e09
X-MS-TrafficTypeDiagnostic: CH0PR12MB5139:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5139C15F4075D3C00078A60787E59@CH0PR12MB5139.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0e2HqD3j6eZwl95LoNv77m4pxld3erqZ7qiTruLdC+uoCqbWMdxhaEs8W/6dfRn8qfH3SuHcI5L/j0FKjGIbmcNHLFg0dw7mFxAKPcnQV0c4wgpobtIt/+QzggCdHRgbs3OyZQ2FkbjgKHSONDLwRv0HYlGCn7SRpA7xeDvjMO/isy08QFwp3ZgRvNwHjNIvVnCrRpj0PiZo3Um4almPe+xsxWJ65AGewVv3L0+gjQgRli3CHVQbLa2xe3EN7jt2kGlGVUAzNt+y2mRvbUyPr1wVlChnCwsdfRYuAFFdVkhGAcZdrH6LDzwqcu5axWvyzZTSrCWI/JMAak71VNf8L6xgn5HBgTK7j+9ypuwR3Z62EObWx0jRfRS48acWMYTrQYYSaVIDWRtQ15Lxx05vXA5SdUQ06cggO6DL2C4xMBmdw+AXkBevSWkkHukLUZjDRMbVXC4M0Ek1SeQzRbpR1yqbTVoEE1NRu6chP2kTDTVuN8jsYJeTpfLd/pcMCeM2NAKOsmjJFQsmlPxQB+/aeyeCDuUSjTqlQleEBgVg4Wt5ypdUoB0oNIxI7g4UdiiB7JniwkrEKQf3hlp0H9OA4OsVZ/7nl70qHjJQhGo2FQfKlNv2AKZ5LHL31z4GDBG+qrUXjitOSczyQPjg7kBrbvtnz60sRI7jvvwzrZgQYBeJX88YjAStWriHKF0e/QltWs8wDdNgxbTuuUfHq9i6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(336012)(86362001)(356005)(40460700003)(82310400004)(426003)(6666004)(2906002)(44832011)(47076005)(508600001)(4326008)(8676002)(81166007)(70206006)(316002)(5660300002)(26005)(8936002)(54906003)(186003)(1076003)(16526019)(110136005)(2616005)(36756003)(83380400001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:02:35.1246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be22a52-c217-4cf0-bf51-08da16223e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
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

It will remove global old_dev_tbl_cpy. Also update copy_device_table()
copy device table for all PCI segments.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   6 ++
 drivers/iommu/amd/init.c            | 109 ++++++++++++++++------------
 2 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7bf35e3a1ed6..330bb346207a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -566,6 +566,12 @@ struct amd_iommu_pci_seg {
 	 * device id quickly.
 	 */
 	struct irq_remap_table **irq_lookup_table;
+
+	/*
+	 * Pointer to a device table which the content of old device table
+	 * will be copied to. It's only be used in kdump kernel.
+	 */
+	struct dev_table_entry *old_dev_tbl_cpy;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 27785a558d9c..af413738da01 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -193,11 +193,6 @@ bool amd_iommu_force_isolation __read_mostly;
  * page table root pointer.
  */
 struct dev_table_entry *amd_iommu_dev_table;
-/*
- * Pointer to a device table which the content of old device table
- * will be copied to. It's only be used in kdump kernel.
- */
-static struct dev_table_entry *old_dev_tbl_cpy;
 
 /*
  * The alias table is a driver specific data structure which contains the
@@ -990,39 +985,27 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
 }
 
 
-static bool copy_device_table(void)
+static bool __copy_device_table(struct amd_iommu *iommu)
 {
-	u64 int_ctl, int_tab_len, entry = 0, last_entry = 0;
+	u64 int_ctl, int_tab_len, entry = 0;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	struct dev_table_entry *old_devtb = NULL;
 	u32 lo, hi, devid, old_devtb_size;
 	phys_addr_t old_devtb_phys;
-	struct amd_iommu *iommu;
 	u16 dom_id, dte_v, irq_v;
 	gfp_t gfp_flag;
 	u64 tmp;
 
-	if (!amd_iommu_pre_enabled)
-		return false;
-
-	pr_warn("Translation is already enabled - trying to copy translation structures\n");
-	for_each_iommu(iommu) {
-		/* All IOMMUs should use the same device table with the same size */
-		lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
-		hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
-		entry = (((u64) hi) << 32) + lo;
-		if (last_entry && last_entry != entry) {
-			pr_err("IOMMU:%d should use the same dev table as others!\n",
-				iommu->index);
-			return false;
-		}
-		last_entry = entry;
+	/* Each IOMMU use separate device table with the same size */
+	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+	hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+	entry = (((u64) hi) << 32) + lo;
 
-		old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
-		if (old_devtb_size != dev_table_size) {
-			pr_err("The device table size of IOMMU:%d is not expected!\n",
-				iommu->index);
-			return false;
-		}
+	old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
+	if (old_devtb_size != dev_table_size) {
+		pr_err("The device table size of IOMMU:%d is not expected!\n",
+			iommu->index);
+		return false;
 	}
 
 	/*
@@ -1045,31 +1028,31 @@ static bool copy_device_table(void)
 		return false;
 
 	gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
-	old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
-				get_order(dev_table_size));
-	if (old_dev_tbl_cpy == NULL) {
+	pci_seg->old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
+						    get_order(dev_table_size));
+	if (pci_seg->old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
 		memunmap(old_devtb);
 		return false;
 	}
 
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
-		old_dev_tbl_cpy[devid] = old_devtb[devid];
+		pci_seg->old_dev_tbl_cpy[devid] = old_devtb[devid];
 		dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 		dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
 
 		if (dte_v && dom_id) {
-			old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
-			old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
+			pci_seg->old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
+			pci_seg->old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
 			__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
 				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
 				tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-				old_dev_tbl_cpy[devid].data[1] &= ~tmp;
+				pci_seg->old_dev_tbl_cpy[devid].data[1] &= ~tmp;
 				tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
 				tmp |= DTE_FLAG_GV;
-				old_dev_tbl_cpy[devid].data[0] &= ~tmp;
+				pci_seg->old_dev_tbl_cpy[devid].data[0] &= ~tmp;
 			}
 		}
 
@@ -1084,7 +1067,7 @@ static bool copy_device_table(void)
 				return false;
 			}
 
-		        old_dev_tbl_cpy[devid].data[2] = old_devtb[devid].data[2];
+			pci_seg->old_dev_tbl_cpy[devid].data[2] = old_devtb[devid].data[2];
 		}
 	}
 	memunmap(old_devtb);
@@ -1092,6 +1075,33 @@ static bool copy_device_table(void)
 	return true;
 }
 
+static bool copy_device_table(void)
+{
+	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
+
+	if (!amd_iommu_pre_enabled)
+		return false;
+
+	pr_warn("Translation is already enabled - trying to copy translation structures\n");
+
+	/*
+	 * All IOMMUs within PCI segment shares common device table.
+	 * Hence copy device table only once per PCI segment.
+	 */
+	for_each_pci_segment(pci_seg) {
+		for_each_iommu(iommu) {
+			if (pci_seg->id != iommu->pci_seg->id)
+				continue;
+			if (!__copy_device_table(iommu))
+				return false;
+			break;
+		}
+	}
+
+	return true;
+}
+
 void amd_iommu_apply_erratum_63(u16 devid)
 {
 	int sysmgt;
@@ -2587,7 +2597,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
-
+	struct amd_iommu_pci_seg *pci_seg;
 
 	if (!copy_device_table()) {
 		/*
@@ -2597,9 +2607,14 @@ static void early_enable_iommus(void)
 		 */
 		if (amd_iommu_pre_enabled)
 			pr_err("Failed to copy DEV table from previous kernel.\n");
-		if (old_dev_tbl_cpy != NULL)
-			free_pages((unsigned long)old_dev_tbl_cpy,
-					get_order(dev_table_size));
+
+		for_each_pci_segment(pci_seg) {
+			if (pci_seg->old_dev_tbl_cpy != NULL) {
+				free_pages((unsigned long)pci_seg->old_dev_tbl_cpy,
+						get_order(dev_table_size));
+				pci_seg->old_dev_tbl_cpy = NULL;
+			}
+		}
 
 		for_each_iommu(iommu) {
 			clear_translation_pre_enabled(iommu);
@@ -2607,9 +2622,13 @@ static void early_enable_iommus(void)
 		}
 	} else {
 		pr_info("Copied DEV table from previous kernel.\n");
-		free_pages((unsigned long)amd_iommu_dev_table,
-				get_order(dev_table_size));
-		amd_iommu_dev_table = old_dev_tbl_cpy;
+
+		for_each_pci_segment(pci_seg) {
+			free_pages((unsigned long)pci_seg->dev_table,
+				   get_order(dev_table_size));
+			pci_seg->dev_table = pci_seg->old_dev_tbl_cpy;
+		}
+
 		for_each_iommu(iommu) {
 			iommu_disable_command_buffer(iommu);
 			iommu_disable_event_buffer(iommu);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
