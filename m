Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3058FC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDA6D40936;
	Mon,  4 Apr 2022 10:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8WSLKMSUTIp; Mon,  4 Apr 2022 10:04:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6AE9D4091C;
	Mon,  4 Apr 2022 10:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 443B2C002C;
	Mon,  4 Apr 2022 10:04:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D7C5C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B933818C9
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5oUm02TZzqeG for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:04:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 639EA8188B
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu+LLkE9Cg2qpbnwTrGH5TwU6jHQ3IcT0CvJfEk47R22qjB8xexJklNyKOWPJHiCtm+8MQ2xuQhmJzSBXAQSw0U6y/47bDcAoViRRnMwxKEx1QNtFraHENgFhhvW/hdbpZNOSY0y6QPUuSLCHkaKUJzBqzAIGPl4ZNwwghamxguAzUm/PKl/EVFL/dKHdijdIqmsIkTZDcI8sWLP6z4Wy+Rk+fJ9ngZhuAxHHm6xKgME9dLPjMgPAjlpO78AX0kWoD2Oj8dAJLUDOKuHJsDk/vISiDzUgRRBkP8uRcQ4Gs9w488qudNECfbRo9ZxRQV9T8eJiWILERam1hB9UagRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWlbaW2mKPTa/tcISkzQlUrA2uz0hrG/TzLxRum+CD0=;
 b=NobFkWq5tzjUByCt/QVB8plHTLP8ZDfYqBte0F/Q1bhML6v/9TRdMrIBlFQ4qtjh86HH01lEmU0mvqcqMQ/NdkTwLkA09Qo8zVLSXp0E/Mw132YKs9x3H5bPFKr5l5kF0IMW/90R0BP/ZJD4uGwb8VEvh/D/PqyDr85dRoAR5j/lyFXijhM3FrmRzVZs+ETO1B5INNTUP+xX1pBVNLll13avV3gWlMXMa6M/gt0/GWSLFAJYodwboCxbOMYjRXidz2sHnhwG55w2QrCuCMx+nn9s6prLE7BtSfWKfVPcu3h5yYJvwcbYEwVWzoR8d27SdvNpoNrEaYV6na4ppPMcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWlbaW2mKPTa/tcISkzQlUrA2uz0hrG/TzLxRum+CD0=;
 b=okk7QwD7gc9wvJchDfWvbb8cxpRYhSYysklRCx3+I5FiG5GUVtMynW25mdbUcdqS5D1EiyfuL8zHuGkU66y0vVZLDdk+GaaZueqFMIzIJYssvKkifYlFSBj1T/DAGzle/d11fpJJK5Lnm43KB8tXa/4vYSK/zKYRdsMr6HGjKgU=
Received: from BN6PR22CA0057.namprd22.prod.outlook.com (2603:10b6:404:ca::19)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:04:20 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::87) by BN6PR22CA0057.outlook.office365.com
 (2603:10b6:404:ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:04:19 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:04:17 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 14/37] iommu/amd: Convert to use per PCI segment
 irq_lookup_table
Date: Mon, 4 Apr 2022 15:30:00 +0530
Message-ID: <20220404100023.324645-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0177088a-505d-411f-4e71-08da16227c73
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB321013DE94356781367AC0C187E59@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90dbGW2YuO+SFS1WYYaxQZSUGtG74n1ovGXhklrNFkSljqKAYq9wCEqEdjG7yNsiVzB/s4SpZ6rnyK6M9wefv+qQfxgOHBtjosy/GIwZ2Z1ucF/La2CoRGB4GgNDQ1CnWWTOBBlaF9sbKqPpO3/hPrAStKDlw5LhAgGIMVLb9IqfzjC/y5DW2DiQZqS9K3sZu2uBiEsVzwV3bGL9WhQr77NqftMrIYPyyvWTya5jSNJ5P1hmx9LphBimeHmDsVuQfQLScfuw2ajgPl0/nvhnIj1Y9LkVU55Xx9WisuzypapI+o6EXXaoAVtngsIJOiKGVcDb9VnI9EGGlsDv0MsWSd/Ag2CRauODAzrRXGUsealN0yDuPoE3HdwaYHbuE98NPzP7/i42BGVDAAN33eKpZB3x9wVq15saKbiOHAnFjHbULt1BBTCii4QIB0NEM4OcCvkUnxL+rHJmcGrN6zFJ6KnGoUf416V0sIcAZ8kAa9sP5HKmYADTMSts5gEaBgRCvuAHpszv7rv+Or2Af14ih0pVVku5deN5NRjNxW5GYgfK/u8VsKrHEC7p7EcBKT/7cyLje+B4UvujkE/MQyeGhNlGIbyA0eyEHgjH01HcvPQdaB3uh5MEShR0ELHnF/5COQwtUDQCBR0u3QssvsOS+ZehW63VPLFvZIuyXeUKTYQnle0Vb4ROGLPTDOe/RWVB7aU37ezPpvxNpzVdwdpq6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(54906003)(316002)(83380400001)(40460700003)(36860700001)(110136005)(82310400004)(2906002)(8936002)(47076005)(70206006)(70586007)(356005)(4326008)(2616005)(81166007)(44832011)(8676002)(426003)(336012)(26005)(508600001)(1076003)(186003)(16526019)(36756003)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:04:19.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0177088a-505d-411f-4e71-08da16227c73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
index 6f1900fa86d2..badf49d2371c 100644
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
index 1688532dffb8..29ed687bc43f 100644
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
@@ -2786,11 +2780,6 @@ static struct syscore_ops amd_iommu_syscore_ops = {
 
 static void __init free_iommu_resources(void)
 {
-	kmemleak_free(irq_lookup_table);
-	free_pages((unsigned long)irq_lookup_table,
-		   get_order(rlookup_table_size));
-	irq_lookup_table = NULL;
-
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
@@ -3011,14 +3000,6 @@ static int __init early_amd_iommu_init(void)
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
index 97cae067cbb4..2c18f45fc13d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2727,16 +2727,18 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
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
@@ -2769,7 +2771,9 @@ static struct irq_remap_table *__alloc_irq_table(void)
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
@@ -2778,8 +2782,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
@@ -2803,12 +2813,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
@@ -2822,11 +2832,11 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 
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
@@ -2920,7 +2930,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2961,7 +2971,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2985,7 +2995,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return;
 
@@ -3620,7 +3630,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
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
