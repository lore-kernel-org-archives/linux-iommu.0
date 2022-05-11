Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E1C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:27:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E973683224;
	Wed, 11 May 2022 07:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qWJFkUQw2sN; Wed, 11 May 2022 07:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 918B5831DA;
	Wed, 11 May 2022 07:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 655C9C0039;
	Wed, 11 May 2022 07:27:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF638C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADEC94056F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iiIzBR3rx_He for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:27:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4B2D4060C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2mmBVHl+Mk8mBHllArytswLqT05AANR7pPhcnOeXCkRTE+B/rMDso2q3DWZjKNFO/WL/y0RTd+pXjH/SD2vYGxLJ5BlZPqgyUxJOm3aZPdhyRqaz0+bBErLJ299Qf+zhtZ/5wi265xvtSi75xKjE1djvH53C6DIgJsghHf0AsDi97XDxqgFGWM6uXDjz40sIkkBpS4KnB4rXos+QpG+n/SXNAt2xnwiDism4C5khyM2GbLDEB+mNfqOG91h6FCkccOnfqCIHWnKGL9dTi1skBSdSSfUpyZvGNcQ6j8YfT0Npsj6U+lw3T1OxMEAgNFZYQ3PD8v1EHIAdxNnqaz8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv/KXbJtxt1JiF/tn88ltnAloHnD1zBm1zREjmAbOXw=;
 b=E19JavUe1KqJl0pN15QDYLg9tZl7Hooil9rYZUSXJPbaUh9kvrkvC6YdG2NCAtFRtUJpKbAXVX5kt635m+4MpL7y4Ib5yBeTVi9gXoTj2Y5KoVEDwwTMZ0wT7L47yGgXWYJ64EgcvR1oKGaXQ4OvobjeFgziEsl/vOG1x4NFDj8Zh/qiKyY7xSiHqKd8NiLdUMaHb3cdPNJo0sEDRBGFBOEBECKgTj8rngDg1iLGwPHLKOpXR6KCOeVpxnwpWxbgEKNyAnjSzYqWhr/FcZNc31O2hGnh41eDr+Jb7AH8HlsZbNFBsJu35OvjPl4GRw66czsuRecmYMd0Z74FTu/+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv/KXbJtxt1JiF/tn88ltnAloHnD1zBm1zREjmAbOXw=;
 b=RbcrpXsIFGuaEPMYqv5WZeLFaOALdFkbk2iHRF32B4ygLwTZq9XyN6jnuuo6oG96DwqTN6/8g6317zd/QsSrDwBSLW/cLe5h1Xg9+JAsXUISMjXrfjqutiBZxwM8emSmbHI1JWHEjNn/pAJ+tHj9OJHRe3IVAm6K3ybF3pzDcU8=
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:27:17 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::9c) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Wed, 11 May 2022 07:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:27:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:27:14 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 20/35] iommu/amd: Convert to use per PCI segment
 rlookup_table
Date: Wed, 11 May 2022 12:51:26 +0530
Message-ID: <20220511072141.15485-21-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32da22c1-8015-45a3-fac1-08da331fad4c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1382:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13829DD89BF617BAD2C854A087C89@CY4PR12MB1382.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jif66ot5QLs+R0f8MSW9GHsxlAoLPQbNs/P+5BnFMYlqbo6Ktu+iuy+0DjMmKNhUws/zY1c0bjqf+3B67DnxvTwaP1SWcDsBAPGgA247+2XgysqCYLGopDrCG/qokvdCpnkrswe/J+wH5bdJ8Bd7ysjXIKksaWQAqhG9vHQrwQ1ZLHD1JkQEVF05S2zEESCvd8+MBsz30kqJw5CWAt62iIggHYkVVe3AaDb8eKYaHnmW+zGsbAsAXf9dyNkl+U78LlOyQEG2adWEGp8b4FXQ2ntQbe89X7xmQbA0rCapj7/Z49hTptn4Zd0bV4ui28+e6GEXXccfHYt3L9UwryaMgJHpRA0LNfjK/72fN4eoYcalbcK0x++NERVVqPYXTG+4nO09mdmaPTC36vcpR26DkaE+GQ/xKqtUWle1qUiTLP1SUvW3t7NbDKUJhHy1JvKn65TXIGgBg/j53YFjpJKbG7v+eRqyVESgn8JFrdyJUS9NTb9qvtIu0XGJPKZmnHPFhNDYrmAKZCCpecvPlazQaAkEidxBiJz0cN4smilewRFAb6gotm3O35B9J7Ljw7KqQfBUDizPeQa97ngs1/+HmkFuqR+0dW0QVmMnDEqFNqZ4XtT0YdttX/Ot/oeS/sYLcBRuAA16NbZ4D04CJU3k6F5HxTHXGgp56lXPeAqQ5HVepeH5yt3k9yZwepyTxlrJxj3+92T54xqyY/VfeaQ3cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(508600001)(6916009)(356005)(316002)(81166007)(40460700003)(70586007)(54906003)(86362001)(70206006)(83380400001)(26005)(8676002)(4326008)(6666004)(5660300002)(7696005)(44832011)(186003)(36756003)(16526019)(2616005)(1076003)(82310400005)(336012)(47076005)(2906002)(8936002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:27:16.9915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da22c1-8015-45a3-fac1-08da331fad4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
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

Then, remove the global amd_iommu_rlookup_table and rlookup_table_size.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 -----
 drivers/iommu/amd/init.c            | 23 ++---------------------
 drivers/iommu/amd/iommu.c           | 19 +++++++++----------
 3 files changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 553e9910e91d..ddd606daa653 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -842,11 +842,6 @@ extern struct dev_table_entry *amd_iommu_dev_table;
  */
 extern u16 *amd_iommu_alias_table;
 
-/*
- * Reverse lookup table to find the IOMMU which translates a specific device.
- */
-extern struct amd_iommu **amd_iommu_rlookup_table;
-
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ed40c7cec879..5e8106641c5c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -200,12 +200,6 @@ struct dev_table_entry *amd_iommu_dev_table;
  */
 u16 *amd_iommu_alias_table;
 
-/*
- * The rlookup table is used to find the IOMMU which is responsible
- * for a specific device. It is also indexed by the PCI device id.
- */
-struct amd_iommu **amd_iommu_rlookup_table;
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
@@ -214,7 +208,6 @@ unsigned long *amd_iommu_pd_alloc_bitmap;
 
 static u32 dev_table_size;	/* size of the device table */
 static u32 alias_table_size;	/* size of the alias table */
-static u32 rlookup_table_size;	/* size if the rlookup table */
 
 enum iommu_init_state {
 	IOMMU_START_STATE,
@@ -1142,7 +1135,7 @@ void amd_iommu_apply_erratum_63(u16 devid)
 /* Writes the specific IOMMU for a device into the rlookup table */
 static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
 {
-	amd_iommu_rlookup_table[devid] = iommu;
+	iommu->pci_seg->rlookup_table[devid] = iommu;
 }
 
 /*
@@ -1824,7 +1817,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
 	 */
-	amd_iommu_rlookup_table[iommu->devid] = NULL;
+	pci_seg->rlookup_table[iommu->devid] = NULL;
 
 	return 0;
 }
@@ -2782,10 +2775,6 @@ static void __init free_iommu_resources(void)
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
-	free_pages((unsigned long)amd_iommu_rlookup_table,
-		   get_order(rlookup_table_size));
-	amd_iommu_rlookup_table = NULL;
-
 	free_pages((unsigned long)amd_iommu_alias_table,
 		   get_order(alias_table_size));
 	amd_iommu_alias_table = NULL;
@@ -2924,7 +2913,6 @@ static int __init early_amd_iommu_init(void)
 
 	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-	rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
 
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
@@ -2943,13 +2931,6 @@ static int __init early_amd_iommu_init(void)
 	if (amd_iommu_alias_table == NULL)
 		goto out;
 
-	/* IOMMU rlookup table - find the IOMMU for a specific device */
-	amd_iommu_rlookup_table = (void *)__get_free_pages(
-			GFP_KERNEL | __GFP_ZERO,
-			get_order(rlookup_table_size));
-	if (amd_iommu_rlookup_table == NULL)
-		goto out;
-
 	amd_iommu_pd_alloc_bitmap = (void *)__get_free_pages(
 					    GFP_KERNEL | __GFP_ZERO,
 					    get_order(MAX_DOMAIN_ID/8));
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 34909faeef76..126832ae2997 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -287,10 +287,9 @@ static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
 	clone_aliases(iommu, dev);
 }
 
-static struct iommu_dev_data *find_dev_data(u16 devid)
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	dev_data = search_dev_data(iommu, devid);
 
@@ -388,7 +387,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	if (devid < 0)
 		return devid;
 
-	dev_data = find_dev_data(devid);
+	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
 		return -ENOMEM;
 
@@ -403,9 +402,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
 	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		struct amd_iommu *iommu;
-
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
 	}
 
@@ -416,13 +412,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	int devid;
 
 	devid = get_device_id(dev);
 	if (devid < 0)
 		return;
 
-	amd_iommu_rlookup_table[devid] = NULL;
+
+	pci_seg->rlookup_table[devid] = NULL;
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
 
 	setup_aliases(iommu, dev);
@@ -2747,8 +2745,9 @@ static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 	struct irq_remap_table *table;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
-	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
-		      "%s: no iommu for devid %x\n", __func__, devid))
+	if (WARN_ONCE(!pci_seg->rlookup_table[devid],
+		      "%s: no iommu for devid %x:%x\n",
+		      __func__, pci_seg->id, devid))
 		return NULL;
 
 	table = pci_seg->irq_lookup_table[devid];
@@ -2807,7 +2806,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 	pci_seg->irq_lookup_table[alias] = table;
 	set_dte_irq_entry(alias, table);
 
-	iommu_flush_dte(amd_iommu_rlookup_table[alias], alias);
+	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
