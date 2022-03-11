Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A77FC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1AF1611CD;
	Fri, 11 Mar 2022 09:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5P58Mf5DiGT; Fri, 11 Mar 2022 09:51:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6FCBB611C6;
	Fri, 11 Mar 2022 09:51:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A42CC0012;
	Fri, 11 Mar 2022 09:51:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47624C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3411B611CD
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJKpAnB4pqxb for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:51:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 023B9611C6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKhcdnJrv7FEbvJ93vHfyjHP2ln7OtMDkGpry4tpUGczewbuWILf+rfqJqJdP0KfU1TpZ4yzfELwIs3raMxZ8RQmvQTE4IoNbvl269BjTgdkqjzo380lhK0akMGv8gyfB8tOTKatB9Br2lp4awjWFIrGfIah8nzOMRD8xnhvj6Fxk9zcKUByrjkyp6ii7NeuSI1OnPicDN4xZlilvFmAylGNs45adlBz2H+2/eAc7Z4g2zNEjtnp0XZlyIx+P/FJNtU/J6xZR8w8kng7c5BzkTWov/2GT7+K109FnsMeTaA/C2+NtQAC0HPbjzA8I7F3eH3/iyKEj+lY7CrqW64x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rG89MrNJn2HgqhwfMpAzxcehzR0K0nP+MKmP0Ps9q4=;
 b=GixW39HigkAi346Eos7C6+La8wuWxEiP9Eg6oSOzWu/eF6XYhz8fo9bIxZLSmhvc88eFS6j/MFIBTV3q89dLoQ6CAMVbuFxtzwZ2SB9zQW9i0O40FDtPTNRuQhN/16xhwAYbMpk6myv/lVb9j0CG8gvMWPWLN+mHWjm7p8egVqlS4p78j6p1oEMgIwt8rQ2E8VvHZ0aqLIPL5shT6GMKTu3ineZuORRbkec6mv27XqgQrKjwSCUg1RkmiAUW04K85sAE7qbVj3KgTYn1fwmNYuFpiK04r/gyi5w3D7l6h53jjcYgr0AdcOi4SGTFWMyi+s1ATfqtT6D9+LoSJe4W3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rG89MrNJn2HgqhwfMpAzxcehzR0K0nP+MKmP0Ps9q4=;
 b=ni1tagpT1U1ZN+44P21HhoWHBhcEgKJBZ7Fjprces6JxY+L4WHsdlbh3/5bps3IwPxVOGomIkAF9AM4sIzrGBjj8b0VXUpB67qWXW5pO1DVa7hRPkYnHnIrKN+2dsiTwKjwo+UKie/4US9yW+JujsHGgE1rzV5a3jewb1XJC9kE=
Received: from BN6PR20CA0069.namprd20.prod.outlook.com (2603:10b6:404:151::31)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:51:19 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::82) by BN6PR20CA0069.outlook.office365.com
 (2603:10b6:404:151::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 09:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:51:18 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:51:07 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 06/36] iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
Date: Fri, 11 Mar 2022 15:18:24 +0530
Message-ID: <20220311094854.31595-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9261e5f5-11f1-42e6-3fd2-08da0344b095
X-MS-TrafficTypeDiagnostic: CH0PR12MB5059:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5059A39C385E7A8C02F1E10B870C9@CH0PR12MB5059.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyhj3R/6f8pdEQR6uxZlOztU7ADKsN4eIZHow91XXotM+tHTfQ8H+ApVfqWo0+fLT6pvluyKe6K7w/z+PudbcARggdwUdV6OLD37QMjals7m3TePsdV4DZy/iv4IaUim2PKiRf1qgHP2XPwCNMNG8Z0uRnlcV3TZBKQB0wKveh0itK5gYFvo3KKSHFDx6NN+fDvJ05APccjgxoVxu1ybM6AD+bI/BKGpfIfGyO6RtCc8+8AdCaWwPAfvsKSCghu5x75uHgm2LkOk5+iEk5MGF4czRwhSSDYb4cbMs34tOZMeJL6QF4Pqm6PaSelxWQK2O4jq/VJlv2aSZpBH/bmV3SchkHX8ZcI+85XPiAzjvjuZzR3H803YKm6PEonhw1Ndz5ObSA4vfzIAFY/uCt5tZdiln1ni2jgUBqdcHDTXwOLVrS9fBRuNpDx1yYZkWDoda6XnrGlBQ6W2Kyis5kiyTpijSNuVD0w2/FahsJ6V99dB6EQr+U5Xlg22KebCViUXYsOTuhcN7DIhA4dg5cWovvee6wRNGxPAtKt9JWf/8AUdzrPcUXEG5Of830QGL76tE2Ke/hhzDrKUv0s17kQx/jux6S0ReM7mJCwSAQD7u1LII4hDssvU+tSWBHr8wUprinR0FpsO6z6EI4De16IqwMvMtf+2NPfwqOfggNebXZoPlq3byuRAEBy4a2QHCDR5yu3yj/YgZdinMJqTZ+ZgVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(47076005)(6666004)(70586007)(70206006)(82310400004)(8676002)(4326008)(86362001)(110136005)(54906003)(316002)(36860700001)(16526019)(1076003)(26005)(186003)(336012)(426003)(81166007)(356005)(40460700003)(83380400001)(2616005)(2906002)(36756003)(8936002)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:51:18.0952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9261e5f5-11f1-42e6-3fd2-08da0344b095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
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
index 31ae5a73604c..aca4f32d06f8 100644
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
