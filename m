Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D31C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 729188130B;
	Mon, 25 Apr 2022 11:40:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K_i9Wuw7pIRL; Mon, 25 Apr 2022 11:40:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39206812FF;
	Mon, 25 Apr 2022 11:40:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21E92C0039;
	Mon, 25 Apr 2022 11:40:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F4A1C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C7B5401BC
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QzA5bcYEtNZI for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:40:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::602])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3462C4109D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHXFWlGQnKba/5mzM2JFF6JR0Ahq6xPZjwE00SWXGZiPVQzdHCcC9JM0EjXT1tqAK4ln3c/9nSQsXRVPYI3hulx729ZHmE2iWTY/uXY8Hvc3iV3+wBAJ25Nf/woTtgGDAh53QtqpSiP+lT5jDBoH8+fLfEanyO8i2JXXsz6TnFHhljmVEJtIWSgHyUFrKypFKOuueDczkJN9IbxpFdmHIS/DnTkq8AYqB6OkdW1XxiNW970ba43RB7qB2ereTK4FuYS5lBL0yWUSWIXP9Y0pD/cubEGm/B0pW+onCE/pNubD/MPJc07mVvATO/hyJkKD7uZeHC+wyemitFDi7R+rlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9AAGMLNiI2q/w1RMMt8ntaWEvr4hjOE8uqfgu9DG18=;
 b=f9nn5OQ/On8R63jfuZ4AyImEVPKBL0GKYGX82VnEGeEVMkStdZRcKHt6tID9pp2pB5YjVZolZmDFJgWCqy+Egf0kg5DmGPGTEWzRPEgg2oQi4xqrLSnkyM2rQA8mxRmWc5F4+KM/r9eTetNmuf7XuKSYkjGrQTBQIkZAyjkYqrHG/2jgkt16UCozFw7R+3Z8edpkvaEOcipgQxUbm0u1H+mSEhrMtGXBzahn1r8FYY+ejmjORPYiksD+6N71SgR/BAA86Vm+JLZaJUbK7kbfUOJinVFc4fL7C2/mxsD+Py0BwsmklfTk1L4AGNUONqQ6VJE4ruCgXYs4GByFSL+P2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9AAGMLNiI2q/w1RMMt8ntaWEvr4hjOE8uqfgu9DG18=;
 b=wTX43vbwRpKlI0aPII+DfHFcyKM8vST1XkbN3gu/2ZW+QVNW6v2IYfGE3pSY8Fjiv6kITp99SvGkfUVsLAT2WavE3Tae/NaOHSy5wWM/tuJFFtSKo8ToROfLVStF4V1G+2IUWIvF5ixuchbp+4XFcn7R/lRU1HN/99ZgWiIIRMY=
Received: from BN9PR03CA0473.namprd03.prod.outlook.com (2603:10b6:408:139::28)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:40:01 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::f8) by BN9PR03CA0473.outlook.office365.com
 (2603:10b6:408:139::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:40:00 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:39:58 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 20/37] iommu/amd: Convert to use per PCI segment
 rlookup_table
Date: Mon, 25 Apr 2022 17:03:58 +0530
Message-ID: <20220425113415.24087-21-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0e4b15a-f513-444c-e1db-08da26b054f3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52478BA51E19F793B94359E987F89@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMGVPtkDbFaMBnlhFw3wnIxtXYc0U6mZQ4HbtjIR8Sk4eqhADQ4ovocXUt/sskdSLAqnuEUngqK/9bsoEfN8sVS3N42obw71jODsZGjKHV/fLedRl/OmJUmpYiOcvd9mxJPOpY9xAf7uNk67IkeawcNsF3JyJrkKSydZhYJ6qBYGeBL0lUaejS9hR+E4XUsvHu0RrvO6vjnLAtp1jkexOjOZIpHqQKwRsJ5v96Do+i+YzDIKfTNpeVCjpzMXEMsH+8TfhY+syVWWqNv4uNFjyxanO6mjlwcQpgbfLsd7+0uEObro4Wb5KP+PYdpslkd4gVdaUBBhJBbMEPZmAjex5YYqlObIeePaxVqXRpLCRvBfKG57OFaDSFJlveBWdAG2vEANdtB4I0Xy1imLcg/kQLpeVUFT1wTnKRDUK/ZrO0uSklxx05L9b6D8w/RGmLNOFSGUsUZbxp34y/hzXSvuletgH3nOpdj/ALXI40quuxCIcxlIN6lCsazx9gu3rC5u0al2P0+W4WvpMAGUQpy9YacqB3WKtjUz4UEMkQtiiZbMGYwZ78MnN/5QYw8wzwLRQFm1nYguY68owYKBglV/VXKZgz1tOLM3PAet/rko/pczEk4nO2ws4RcVTO573lD4D8baryIa2gIcq8y8P7Sijz8IwMhm7kwjg1l4am+Yt9WQ8epXtUvRiESywVi9CKg3gFBqDX5T5xgSQkIq6KzjSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(47076005)(4326008)(83380400001)(8936002)(8676002)(316002)(5660300002)(82310400005)(2906002)(70586007)(70206006)(86362001)(36756003)(81166007)(36860700001)(44832011)(356005)(508600001)(54906003)(26005)(6916009)(1076003)(186003)(2616005)(16526019)(40460700003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:40:00.7090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e4b15a-f513-444c-e1db-08da26b054f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
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
index 990272a470aa..334206381f84 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -838,11 +838,6 @@ extern struct dev_table_entry *amd_iommu_dev_table;
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
index 29ed687bc43f..70eb6338b45d 100644
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
@@ -1143,7 +1136,7 @@ void amd_iommu_apply_erratum_63(u16 devid)
 /* Writes the specific IOMMU for a device into the rlookup table */
 static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
 {
-	amd_iommu_rlookup_table[devid] = iommu;
+	iommu->pci_seg->rlookup_table[devid] = iommu;
 }
 
 /*
@@ -1825,7 +1818,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
 	 */
-	amd_iommu_rlookup_table[iommu->devid] = NULL;
+	pci_seg->rlookup_table[iommu->devid] = NULL;
 
 	return 0;
 }
@@ -2783,10 +2776,6 @@ static void __init free_iommu_resources(void)
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
-	free_pages((unsigned long)amd_iommu_rlookup_table,
-		   get_order(rlookup_table_size));
-	amd_iommu_rlookup_table = NULL;
-
 	free_pages((unsigned long)amd_iommu_alias_table,
 		   get_order(alias_table_size));
 	amd_iommu_alias_table = NULL;
@@ -2925,7 +2914,6 @@ static int __init early_amd_iommu_init(void)
 
 	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-	rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
 
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
@@ -2944,13 +2932,6 @@ static int __init early_amd_iommu_init(void)
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
index 770a7ba558cf..0d6230e493c8 100644
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
