Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7CBC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0020640183;
	Mon,  4 Apr 2022 10:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id djs7BQMztMX4; Mon,  4 Apr 2022 10:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8539E4002B;
	Mon,  4 Apr 2022 10:05:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B758C002C;
	Mon,  4 Apr 2022 10:05:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1183AC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F35234093E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwbBcjwLxtBw for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:05:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 989F24091C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKujWkI1FYMCJEqSIHZinFsQk9DxZV68UFz46tQw9kA079NcHEgx+Gqn7j7W3iPTg0Y3ye8Yc8ZfZtSmPjFyT4QY5X03TD2EdGGgNjvOwdXCcMsJ1rYmtYzLDo4Q4l2xs7NOZdxGhy9yDsbmPCTtk0iddt2Di0JruRJBCmyKk1T1IEwdz65HN+i43ifLBm/5zyAw5bxsMn3aelNPMbLztciVqdZqKPpa6Vz3KsE+3xcFBh5VlRRNQnsceLanuSxbEx+EXC29lgi18ICwJWKvYbCvykCJkg7XZP63ist+/vK3qd5Zr2gVPHnmw0kL2Xy6TCJmFL5W6bG5A6id+20mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYmgerBEVuWH7BdT7LMKVBze5HHBHOhfyqGCGejA6i0=;
 b=Gea4+mrZSZuPhH7tDn+a/JY4miX4jV1wr+OrVqlHsARKX6MTzpN1I4RgeYj7jLGFB3ZaGCDCr/3DfWJzcvBj0OsWMg1sUWI/BPRFS1IbMw4jsM3SZdo/ttDQsevF2k0zTzcrqs8BgoAkGc40vDPrmodXtdfdotNUtYbAmoAJIgSCPuOSB25g67Epk4+/FiohySLm77btfr2+cM6411XiyUzF8cAnDGjt8TiypzhSSyH554D9yzf3viEH5uuTWRgzuczvXqntnbJhgfEa1/FAdRDgMZ3OZvR2pyKMHS1l5xQad0givmO7taaE/YizgVK/2qwOWNov7ENTRVMJDu5pxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYmgerBEVuWH7BdT7LMKVBze5HHBHOhfyqGCGejA6i0=;
 b=RN44aczl02DQyLmn9oL0BlV4RK6TLJ45b85THz0P1niQjHdrWwHM2kYQyJUpnWq8artKpG+YAQ8tz26YfXrhaeasz4355uUWFfserDHy5ouCd+9SlT2E4Ao4QPh3tMvc1opy4DkMiJiJm+a4Z0AFeQgq7NSrpXBR0Sc4ktR3r1k=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by DM5PR12MB1946.namprd12.prod.outlook.com (2603:10b6:3:110::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:05:51 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::d5) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:05:49 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:05:47 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 20/37] iommu/amd: Convert to use per PCI segment
 rlookup_table
Date: Mon, 4 Apr 2022 15:30:06 +0530
Message-ID: <20220404100023.324645-21-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c95aa342-f454-4b48-e099-08da1622b233
X-MS-TrafficTypeDiagnostic: DM5PR12MB1946:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB194612BEC7D8B90C434E4C5D87E59@DM5PR12MB1946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIgOR4Z51LT52o7CEgmyG1PWp7B/pzws2ULnAeMtiPM8Cjp270ukQ8bskxUfCXj1I8edBtChWADY8Q5IYAOQTHHjWVePh727Z12XHK5KrsA5kSsG9UgOw8NzfArzZ8oALvnBtntzzS2fjwPQyJNagHPy6CDdD7eBNBqusJxLBaZaYB26P/OFFCVUHym1cMF5s+wcmOTjlIaU1ZLgNYUHR/kg0GpcLQ4aNXIZKJRIaGNFRcWVRTash6r4VjL+3TaAouusjiuDWjh90KZa9jODZ60VNuTWkZm3eHo8bdy+Hv/X/A6dsURxXl6yKRDvYdCYZW5N1UB7KLcIAeCtibpDW68ukcCvLHMQRKgyHUqtO+BSn0p3PfjmusiojdhZ6hmUreE70c4bihqJV6+lp8Uzd+8WY+WNYOHJEkOudwgshAmxO+T18OVUmE1hms8+QY0M5kTzEFkYPM2v9mbuebSqVqerwbvA9m62KxvJmuVxntP/icILnNIIiSjSuDFpKIeenMd9ssvVtKUFgrWlTlVCS13OyB1vDreGj9jx3iOB5gQAXlT4Ow1KTPXJ5NQZXsNWboG5+GQjcVVewKiwJiBE1g+jDkbiNjxJMboMNatMiSne+ZYJzm/4y2SW76Z7m1inmz33aKlDJyitczaU9dgLXXRQgvuMrLRbCuwHXvfS6yZfcKtyMsq7yaUX7GcBXCl2Hpo6rJwEkkqCtbVrHisS1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(44832011)(1076003)(26005)(316002)(6666004)(16526019)(47076005)(186003)(508600001)(83380400001)(5660300002)(426003)(336012)(82310400004)(40460700003)(8676002)(70206006)(70586007)(36756003)(81166007)(356005)(8936002)(36860700001)(4326008)(110136005)(2906002)(2616005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:05:49.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95aa342-f454-4b48-e099-08da1622b233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1946
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
index 814b5abe676a..bae65b05e37b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -286,10 +286,9 @@ static void setup_aliases(struct amd_iommu *iommu, struct device *dev)
 	clone_aliases(iommu, dev);
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
 
@@ -402,9 +401,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
 	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		struct amd_iommu *iommu;
-
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
 	}
 
@@ -415,13 +411,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 
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
@@ -2744,8 +2742,9 @@ static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 	struct irq_remap_table *table;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
-	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
-		      "%s: no iommu for devid %x\n", __func__, devid))
+	if (WARN_ONCE(!pci_seg->rlookup_table[devid],
+		      "%s: no iommu for devid %x:%x\n",
+		      __func__, pci_seg->id, devid))
 		return NULL;
 
 	table = pci_seg->irq_lookup_table[devid];
@@ -2804,7 +2803,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
