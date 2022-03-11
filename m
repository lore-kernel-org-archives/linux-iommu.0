Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F98C433FE
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0705041868;
	Fri, 11 Mar 2022 09:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBah3aMWQcwQ; Fri, 11 Mar 2022 09:57:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD26E418C8;
	Fri, 11 Mar 2022 09:57:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D0F0C0082;
	Fri, 11 Mar 2022 09:57:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98585C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8863641868
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0D-WkDHxgzE for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:57:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DB4C41893
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLpoe1AP/rUuricFeA/gPln2OZEzObQaL1HBg6kGXs+8ZjJwAPrHqxiEKaHwVU4qjemWd8YpEpJESDtM0yN3l5KohsJEmFkv69GqSgmVcHqHrnciaL+6yYXXwPNU4eob8SMFmO8Oua0nyzeegiMvaVq/lq9klW5dbwkUeows0hbvs85WPV5KExH0zcc2N4KVeF8Ru9R1zcuKacK3W09lQtKP3JUBtY3hceXGGsqosVOjTtdTgCMEqf2bNnk2alFHyOCWVuCUbFH4gAI5IjqbYX1GFZQVdoOCVXHQCico+GS4Xe0B4CJH8gE2ZiNSJULKCqJ8TXV1pKiu3TjQTnb4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18bxVziLVKfeBBiWnoYZbVtSw6JkaWXnFxyRVWB/kE0=;
 b=bXAycn+Xrb7GtQKjLPk1XXPOnKq7CYwuca30yQ3tLJqdybQxZhBPwcQ5z8zWriiL8Ga2a18gDF7v0MNOClKw053ixnbcyosXRya1WcFDwbuZWnZXYtcIV8fEhk2iyP+hCs/H2NUBlJLCAfcWcPILTq3vdQvstX6MzxqdQtd+Fwp3NVMRuiQT9/XK1fSPFSRDcI71GPjGZinmqxK2px1zmc4f6jRnZd2UYHWcZvzSmfLxcuq0tgHaG3B3rJlJjwtStjS6k3VhDT/6WsbWkzHn6yt+SVHPnUrvhWPuwBI0P/Kv4pmp9qGh5vZnrMWImZlyhwrY+J8g+4fOZm8ceYd8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18bxVziLVKfeBBiWnoYZbVtSw6JkaWXnFxyRVWB/kE0=;
 b=IHyu6HKlNzd+ZA+lBzjn3iY6xUPJrFZ4KPWtPJ9l023A6fOkoZ/Oc9zWh+hoK+y/ZZkeSjWieWe2j223mkG/F9jO/x25VvqzHK4t2uTQSJIwNmqq6QtWIQhy0KLDbNFUC3XaoGlJd5gzWx4NCX51N9T8XIOO4Jr9BJ5D8Gww+wo=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 DM6PR12MB3337.namprd12.prod.outlook.com (2603:10b6:5:118::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Fri, 11 Mar 2022 09:57:20 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::9c) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 11 Mar 2022 09:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:57:20 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:57:08 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 19/36] iommu/amd: Convert to use per PCI segment
 rlookup_table
Date: Fri, 11 Mar 2022 15:18:37 +0530
Message-ID: <20220311094854.31595-20-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77b0afe-c46a-4b4a-fe0c-08da034588b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3337:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33377C904368A59BA2FC06A1870C9@DM6PR12MB3337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS7CFk+VMUMiE2ldHUyGzsiKEVo8506k9oMEwf2ClkA1f2KKmNQajhM+htHG0K2yoDmzrLmY8IEx5M1V72sIZPYHmxyDN0nVMOiA6jcPEMACP2W7xQAAxMIpXJpljLNFiF0FipohawoBe7+rxaPnkJeXuFBeRdyxTpbgQWCR/mAq91ZO6fCdCF4NneO4yEKRDk3FLER2bdcNS+iVK7oQZJBYsrEWrBMYg7boQebC2aASb/9V/rHzkeG53P7kfUCh8q6b89Lk/BQdo7WzoKK9+QJgZVPs2YYgJ/5wsmFCRE0fqJuFMDokfzd/etYENdxmsSV4UoCI6ET24iHrF17lTGZsrsNhTQK0WlKuBmq5JCTSmZCpe+ShLDo/JVly8ncna63R0s+IoaSM020egaizSoiFuOo4Bl6sXDXryK7EdUXJLCe9WwEkhVhnnlkEU2y/Yv0dn84LOnz1bbceWbfUpNdQEE7Ut3wQofW7PCyu73FjcSNQI/V4kzabbq+3KIPaNBgLriBMxy0VKX2BOH8C1mtT4NZn2QQC5gHORCR/dRtDAUhTo60T3IwZzLMrNDmuZ5O8w8zmLc+oI7cvufe0GHk4FCSCUKremnTRMOctcjswNzigOw6/gS7jrKl3APbuFM9qSPooIa+0lZ8WULw013L7nv7ewUyP6Zu+Lm0KkwMkATkdMQNjnwsfVuXo02spvUTJlzx6E/2CQKQdwwuRxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(8676002)(70586007)(70206006)(5660300002)(2616005)(8936002)(110136005)(54906003)(47076005)(316002)(40460700003)(44832011)(2906002)(36756003)(186003)(1076003)(426003)(36860700001)(16526019)(86362001)(6666004)(82310400004)(26005)(508600001)(81166007)(83380400001)(336012)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:57:20.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77b0afe-c46a-4b4a-fe0c-08da034588b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3337
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
index c4bc07a58348..e36f043ad19e 100644
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
index d5fecca5a547..f6547d888899 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -286,10 +286,9 @@ static struct pci_dev *setup_aliases(struct amd_iommu *iommu, struct device *dev
 	return pdev;
 }
 
-static struct iommu_dev_data *find_dev_data(u16 devid)
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	dev_data = search_dev_data(iommu, devid);
 
@@ -387,7 +386,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	if (devid < 0)
 		return devid;
 
-	dev_data = find_dev_data(devid);
+	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
 		return -ENOMEM;
 
@@ -401,9 +400,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
 	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		struct amd_iommu *iommu;
-
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
 	}
 
@@ -414,13 +410,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 
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
@@ -2740,8 +2738,9 @@ static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 	struct irq_remap_table *table;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
-	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
-		      "%s: no iommu for devid %x\n", __func__, devid))
+	if (WARN_ONCE(!pci_seg->rlookup_table[devid],
+		      "%s: no iommu for devid %x:%x\n",
+		      __func__, pci_seg->id, devid))
 		return NULL;
 
 	table = pci_seg->irq_lookup_table[devid];
@@ -2800,7 +2799,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
