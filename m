Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62608C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1883581A39;
	Mon, 25 Apr 2022 11:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DdjZ46rIJY4h; Mon, 25 Apr 2022 11:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA63481699;
	Mon, 25 Apr 2022 11:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85903C0039;
	Mon, 25 Apr 2022 11:36:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD541C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B3168198A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2DIEo1Dmk-N for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:36:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::621])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A918081699
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO2KV8h8H21Ks5m79NkxdpkhGfqjUuznGU0Y2LO8d34cG1iReHm4tKa5Tf7QZJq/XY4cODzV+V1qBmTA9tG4494P6UkNw9GjszKumscHgZV2MlJP1v5I4VtzdfBbHzKnYaQp5D0+FFiJNZKjMCpwVa4y1F7n19fQ7VZDb1Vl27TFFEO39YdPmVHltfoleo+GSNG5Y4i44cTKBj2MTmP7ZnVhfU7735V7goD3upCTW3qSj95aTvnYm1c73yzQOANMtnr6+b0lLfAF8gWiQlXJ4mVze1cGKwfONskCXC4IKU6vgdVgO3C5sqy+SctWgvGhjZz1arlHjQsGn3i1gGsrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhH3ERBonZheciGKsN3o06O+r3X0DeXg/QJUEySf+Ho=;
 b=St66Oz6qjz1VuFosriqelUJy7Tf6e6itJhsh3KpbBx2WwVS5vJHoiSHD873h4MdF9q1Nyvaba3UcxYmQrmHYLVhpEMTmL0G/zzfg2+OaeYSxmE9Hxkh6o1/H6eEBTYV7fhPEJ53icanPxITiAjdJ6vrrXajjJr0PrdkpVZd7IzpNqf4mWWHfWTuchZp+8Ff6Hzo4+dBdoxIIcuvNIE/oAf7Pr6tCH8NaRZOoUZRDZxLpH+EuOdbpLYMUXmFXQy7KO7fqVcWxhJw8TGgV17800A0AFyNU5GbAP9bTB7shhKt9tNuwbWdWwYrbU2yd2Evx4mmyP8QL9HnmTyahvuSb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhH3ERBonZheciGKsN3o06O+r3X0DeXg/QJUEySf+Ho=;
 b=fO/RvEa/jalTxY58RkTc2N5hy71hyn408OSAN6lf8FAUmK+bWxTolPqRJgKDZt581WDr1SyOHqnAVutyDBEwq6PeHylQK2QIhDKi8UEndOJvh1Z0YjVWxoxCuQimyu9mRRhd4EtEbBcCFlqE79oxI2CXxAMGURhRmm910ccSAA0=
Received: from BN7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:408:34::31)
 by DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:36:47 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::8) by BN7PR06CA0054.outlook.office365.com
 (2603:10b6:408:34::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:36:47 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:36:45 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 07/37] iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
Date: Mon, 25 Apr 2022 17:03:45 +0530
Message-ID: <20220425113415.24087-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7622a4-4e83-4e5e-ffdb-08da26afe1d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962EAECFC5B59D635F9593987F89@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlLUJ1O5tpfpodUpaQvzGMn/YlOtWGXU/jxjwcpPntl/rLhT6OP9X3XwjlUUCb0piBlLfXbS6wVYWsCQKgp+PS+Vr2bzp+dJ2d2kag8cD6VYQxgRV2I4VDklk1cqaRaLR8bkrs46DOBlq6lzz6CkwImWRhdQzq7fdW864h4UNDPykcsFsigeGEAX3VUBQ6KuhnB26J/7N0GoqVOKWBYWcx+y1J6C1wnr7f7Py23/fJJQN0xWcVAOfkX3GaHJSkYv2JL7LYC5j+wnN6ctl7TcYsMkqBTTs9Vsm7tqXKN4ZBOdI4jB6CQGiezDgUS6hU2JG3NPd3wkURRILf+QbQQDuiIJYgRr25JCbAyNkMrPrnWpINXNHpF7FkG2MKkVALZZdIQf7PaiIFgVegpL237CgH67VgeqO5IJBN5V8KpQrZUtC5/p9tRJilxNtvrPLgncUQrKeTBsFn0z7A3Jjy4ZwtmX264WzU+ywze2fqj89AZFtZCYIYvNR5KdECmIfcjBvAS0dTOiVdgKr01HvAqd/e9Ke6LUppcYypq+k7IJbfHnOObV9hAZUAcrORyPi1+BOwNU6upht96m8GbVl7XJj9pcYK0f9UWBJ1qpL8iVlzh+90yzMD7Xk8XjgyfgVjSLG/X/ZRug1SKntqUS/eX75CrqBNw8xXxB+sxCFmL7HXJKjgRBP8VLKpXFoGdQm/ED9YX4wN4WDHzIgrr3GPurug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(40460700003)(1076003)(2616005)(2906002)(86362001)(26005)(8936002)(336012)(426003)(47076005)(508600001)(186003)(16526019)(44832011)(5660300002)(82310400005)(316002)(36860700001)(81166007)(6916009)(4326008)(356005)(54906003)(70586007)(36756003)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:36:47.5752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7622a4-4e83-4e5e-ffdb-08da26afe1d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
