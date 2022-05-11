Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECDBC433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8591440ADF;
	Wed, 11 May 2022 07:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6XIc7MpjX6gm; Wed, 11 May 2022 07:25:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A012404F0;
	Wed, 11 May 2022 07:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24AEAC0039;
	Wed, 11 May 2022 07:25:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F02BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FAD060AAF
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aUM5hHGO1v93 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:25:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6FB4960A83
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcEJcdvScZJiIaUe3Ee1e9SokYfJcG1nJW9U1Aw4hgrjAoaAax0haq07pakBucCvUd6THcxjmealHnX4UtgYSoCnPhHxvm6kwUDmOPkZdi4xDeKgEbueA9aACqDTkMFpz1/wN8cpS+iRFM7zNakZDoMMZg+pT2mNCp4phb/nNAjIFKkpTKnSIWFPz3JHn7kV+XerGEurgaY7R/zIYEsuuGIlj0iKQDyXcHI0y3SZC5Q4lOcxBnP3FsTPn5+5eAlCWat+LWijnP7KS7HDT02uZT1mZ/lWZxNBdLQ8vTM/8gOwXindGDUEq2UNWm68XJY1Wt9lHN26Fi4aW41bOXQHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0veOtb9viND2yJ869Z2ezb1YQRQzNy0yfW4KGlXf1w=;
 b=JjXxb14RzOkg8FzbmRHSTrq5+D+Nq1fKzYK/DIYTLz217NqvRlUg4GSrJuKqXMMZ7FVcTcoZObHfbxcZ3GIgXINTJFhOEVJtPhrGqF+LLbY0ZPnpP9t3ep4hXbU6+57c/1D+cci2Duf2nDie1J4T44fWeu9ORm6J6El8Kx2F+3KPhNMo9dCcXbxXskzPcxhcsCgIpCUYSfKx7OZ98J3qnnt/ZIvS4xqmrvzGwPDAqtsxhum+j3oW6auhjTzDahJgLR3/4Zr2CPs2a/iko/6gB25ui+VqdenjS6fz3oUORvZvFigPfr759OIXB5A1omxyzNhtGS8imOLDP1ArSXOgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0veOtb9viND2yJ869Z2ezb1YQRQzNy0yfW4KGlXf1w=;
 b=SbO1wQhyzeD/ZREBeN/YttO/osdWHhkPUnUS5eS4HxEumgpxz6U0ojB6fvQh0MVrT0o18wawZdi3QqnOdDgjwbnkgEDBgzlad7ZAflau1T91CoOJHZ4QNmZo70FND5Ai8Aej//twIawpf6sCFe13jrNH5GBPKgJ57mhrP/5aAH4=
Received: from DM6PR04CA0022.namprd04.prod.outlook.com (2603:10b6:5:334::27)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:25:46 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::fe) by DM6PR04CA0022.outlook.office365.com
 (2603:10b6:5:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:25:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:25:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 14/35] iommu/amd: Convert to use per PCI segment
 irq_lookup_table
Date: Wed, 11 May 2022 12:51:20 +0530
Message-ID: <20220511072141.15485-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbdfd5a1-b54e-4914-ff90-08da331f7732
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB443334B1977C05C051340E7187C89@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3V2trWcEl/6MTT/feAMzzzVuX7Qj9eeuSzL/AWuaP3HkkHIeJ71zXLI9mIqhQNJgot6OSH0v//n7JlJCxrKp87HK+bZDfw5oBW+UrDeFWVMz1t46TKaQS3CDA+k6YEjj3gN5AHxKLXQugx46KFMBAzWdyCwgNzUerFiyDnVB6Xxky2i8m7IzCAumoJOfBH0ibT2Vqgu4eYasyKb7w/wK5njVpEeth5lVA77CTrZaJ4nBNSophNqi30OQ3zbTWBhJ1xdwF5Oq2JhZG9jA8SY+xc3JYulDUTTLPQRqESzsOPR0AlhJR7jYxkPV6ZnN0SFZSDJqzVWQflrH/PIO3sKwiY9E/5OtugaQ2ybTQCyF8KO0SUGco0cFfbfe1AzRQMaKlnlx8s1DemYwlX7iDsBTyP6a1PVIChYHJe4f4rsrKYOroiH+tLGR0rAmTmdHkQJKRj7kqjKfQTM8JK+6qPqugtsCnPp1/3CMwnbNKQU58I48+WbcRdh7BoWJZH/ASK5Y30juVppeoPp5BABfXULSn/UcgC2T0Uy2sZf2rzkb3lPh4C1X+HuxCA5ZZEs7U8q6q/t/LHbbDLNj9dDZHRDRuhV070AE5cP1uih03cfMvbLq684b9kX3sr7tQI71qoNBmV13zGQw4607slfTb+FfSIPOChSosmV5+bI666c9IvzHpdCPnWMQCyCXEbs17WPT32GR3pnAfj9QlCf/M3r+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(2906002)(83380400001)(26005)(47076005)(426003)(82310400005)(7696005)(356005)(86362001)(336012)(36860700001)(6666004)(40460700003)(70206006)(70586007)(8676002)(4326008)(16526019)(316002)(5660300002)(186003)(1076003)(36756003)(54906003)(6916009)(2616005)(44832011)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:25:46.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdfd5a1-b54e-4914-ff90-08da331f7732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

Then, remove the global irq_lookup_table.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 --
 drivers/iommu/amd/init.c            | 19 ---------------
 drivers/iommu/amd/iommu.c           | 36 ++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index cf3157ba1225..79c44f6033e0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -444,8 +444,6 @@ struct irq_remap_table {
 	u32 *table;
 };
 
-extern struct irq_remap_table **irq_lookup_table;
-
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 018dfd0370c6..ed40c7cec879 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -206,12 +206,6 @@ u16 *amd_iommu_alias_table;
  */
 struct amd_iommu **amd_iommu_rlookup_table;
 
-/*
- * This table is used to find the irq remapping table for a given device id
- * quickly.
- */
-struct irq_remap_table **irq_lookup_table;
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
@@ -2785,11 +2779,6 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_iommu_resources(void)
 {
-	kmemleak_free(irq_lookup_table);
-	free_pages((unsigned long)irq_lookup_table,
-		   get_order(rlookup_table_size));
-	irq_lookup_table = NULL;
-
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
@@ -3010,14 +2999,6 @@ static int __init early_amd_iommu_init(void)
 			if (alloc_irq_lookup_table(pci_seg))
 				goto out;
 		}
-
-		irq_lookup_table = (void *)__get_free_pages(
-				GFP_KERNEL | __GFP_ZERO,
-				get_order(rlookup_table_size));
-		kmemleak_alloc(irq_lookup_table, rlookup_table_size,
-			       1, GFP_KERNEL);
-		if (!irq_lookup_table)
-			goto out;
 	}
 
 	ret = init_memory_definitions(ivrs_base);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5118ade206b8..02fb244c3c7d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2730,16 +2730,18 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
 	amd_iommu_dev_table[devid].data[2] = dte;
 }
 
-static struct irq_remap_table *get_irq_table(u16 devid)
+static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 {
 	struct irq_remap_table *table;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
 		      "%s: no iommu for devid %x\n", __func__, devid))
 		return NULL;
 
-	table = irq_lookup_table[devid];
-	if (WARN_ONCE(!table, "%s: no table for devid %x\n", __func__, devid))
+	table = pci_seg->irq_lookup_table[devid];
+	if (WARN_ONCE(!table, "%s: no table for devid %x:%x\n",
+		      __func__, pci_seg->id, devid))
 		return NULL;
 
 	return table;
@@ -2772,7 +2774,9 @@ static struct irq_remap_table *__alloc_irq_table(void)
 static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 				  struct irq_remap_table *table)
 {
-	irq_lookup_table[devid] = table;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	pci_seg->irq_lookup_table[devid] = table;
 	set_dte_irq_entry(devid, table);
 	iommu_flush_dte(iommu, devid);
 }
@@ -2781,8 +2785,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 				       void *data)
 {
 	struct irq_remap_table *table = data;
+	struct amd_iommu_pci_seg *pci_seg;
+	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
 
-	irq_lookup_table[alias] = table;
+	if (!iommu)
+		return -EINVAL;
+
+	pci_seg = iommu->pci_seg;
+	pci_seg->irq_lookup_table[alias] = table;
 	set_dte_irq_entry(alias, table);
 
 	iommu_flush_dte(amd_iommu_rlookup_table[alias], alias);
@@ -2806,12 +2816,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 		goto out_unlock;
 
 	pci_seg = iommu->pci_seg;
-	table = irq_lookup_table[devid];
+	table = pci_seg->irq_lookup_table[devid];
 	if (table)
 		goto out_unlock;
 
 	alias = pci_seg->alias_table[devid];
-	table = irq_lookup_table[alias];
+	table = pci_seg->irq_lookup_table[alias];
 	if (table) {
 		set_remap_table_entry(iommu, devid, table);
 		goto out_wait;
@@ -2825,11 +2835,11 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 
 	spin_lock_irqsave(&iommu_table_lock, flags);
 
-	table = irq_lookup_table[devid];
+	table = pci_seg->irq_lookup_table[devid];
 	if (table)
 		goto out_unlock;
 
-	table = irq_lookup_table[alias];
+	table = pci_seg->irq_lookup_table[alias];
 	if (table) {
 		set_remap_table_entry(iommu, devid, table);
 		goto out_wait;
@@ -2923,7 +2933,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2964,7 +2974,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2988,7 +2998,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return;
 
@@ -3623,7 +3633,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENODEV;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
