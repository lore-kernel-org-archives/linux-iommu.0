Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A5FC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DCC484368;
	Fri, 11 Mar 2022 09:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vcj657MKMu4o; Fri, 11 Mar 2022 09:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 044BE8435D;
	Fri, 11 Mar 2022 09:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B15C0012;
	Fri, 11 Mar 2022 09:53:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96F00C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 776DC40331
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M2Jxe7GyG80q for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:53:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 837174032E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byccXbqcAKd4jKErGU6JkyEkvNCZ3i7IadrzLoqSNggmLwqlTl9tp3VJYapuMb8kp5POJOAeJL5vOdALjiiNsLZ7sBfbXXFjH36Gx68zpE7MD2QsHfBDv/aUoxBeHq/BZyOdITotRMrYWDs3Sb87IC8ItnYLNOufj9BL+HSa7J5GzHKsABxX5Gw/toZlyIOBgswiJHTeztv93MNbXFqWi9tms/ZjJRfCl4lyAhypgTsH+m3aBDSFnymjxHPXIfVP4yJJl1v2Q4pRyJaD04CyAHESi8HVsTlEToA0fAsAfLJf6l0dg+DLzpPTVzD8J0XrETKC+wSrJmJAUIYHpBQ92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbAPrm5yoYZVv6HfYN89z4z5gF2xm56je//zOkSU2C8=;
 b=L6i8A4TbY2AX5x/MDTnImnvAyBSlfGwV+iRV3PNgdo6fnSYd7SMNkj/jjuMDRunLdtOFXpbKH8b6jpyY6Qj361b8pfLvOhHtGPUMlmRYOKaXVh33odhcg2YA6Szo+oobhy0knRpMxul5K9ubKlWvmOlwxJmgqvQJqVIQ9Sw6BrtPboizOr2C6hd+GEAPmEAOVVzVw0rRyv1zRbOipPedyYXweTbI+Alrgppu+RSlmP+TBmplPPbE+9rArQp8zYE4GzLnUdBTwzvAGdu5fxsQaKR6l/qBLJ+heP/GV07G6n2OJaNeJsEW4xx2Ei81KDhmCjacSTjKhLfTfdKq77zyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbAPrm5yoYZVv6HfYN89z4z5gF2xm56je//zOkSU2C8=;
 b=VpbFXvByydI9PGASybkyg/B+QStH22J5Ba8QcgMn+wmGK/JU4GVbrnQSQSJpBHG09Lov6zB6bjOiEKcJ3hi3pC9vkjNcgtYMLZb7WoL7eqeNnRDfcxQFRfib/hwTd8UGB7JSlT8mISypTF5yabMBSXD0RJIWJFayIBwCUHAiaFM=
Received: from BN6PR1101CA0007.namprd11.prod.outlook.com
 (2603:10b6:405:4a::17) by BN6PR1201MB0052.namprd12.prod.outlook.com
 (2603:10b6:405:53::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Fri, 11 Mar
 2022 09:53:05 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::a4) by BN6PR1101CA0007.outlook.office365.com
 (2603:10b6:405:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:53:00 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:52:57 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 13/36] iommu/amd: Convert to use per PCI segment
 irq_lookup_table
Date: Fri, 11 Mar 2022 15:18:31 +0530
Message-ID: <20220311094854.31595-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539210f4-4021-4e36-d538-08da0344f07f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0052:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0052CD0E338E2BAE20857282870C9@BN6PR1201MB0052.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vy4sAK/9kYxmkqhIZSOkO5wWm+nT3PPfPPSEZhajBkhz7bbinVd+FLnM8rqk03FwORKFSMrZhJZTC6KpFQ6BKjW9HxJuegsUYpUl6BdQveh+S48Zau+J1ASWk2p+j1um4bM8w9Tl77whTCV8m2k0s210ruNmuQvjliMX4sa3tinTkj3PNDIvuJlBtbFfa93aoxB8T85jEmbtyZwcL1D3TEcAlHEBLglFzUPQXx1bvttHKrsXnUEAtvCqSCRZeVeNRTI0ahOArYDZs1WK8OP289wA+OVv9/066jJEnPUqnTO6XLkFowch4zIokBgtnL9uX+Fs8TRgSbLxGf+hLfip9m0xGk8o5OqrsOFpaaXNnDIwpsvX77Pl7470g9xHffNKRLmOylLZa/6YAEAeTAymkQBx+tkVnRRzFQxe48gLW9XeXBuQ+/4gbaUO8+VKfz0N31tgm5B4S9H3+9E/QZX50+IijEBw1vsLQABEyvrtBWDAI2JmwyoFFEmbIw3bZp0gWWyFMZCYQXZf1X70o5w/Vu/sTd0c0JKkh/OLS9xfreltMNgTBO0ONMZB0gdfCxoWpiK3zQNqM3Mi0Y85+KKwkm5aQ6Pc3Lg5hQ0s2aWxzD5LfmB7E5Fu32td8DD8kiOd5elOJNdsHWVGUHx8Lypw0hka2qp946Mhae0aRTg3A2/FcaH6oXsoHOebJb8IL/ubSUYDNOi0QnIxUTyA78+Z9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(5660300002)(82310400004)(83380400001)(8936002)(86362001)(4326008)(44832011)(70206006)(508600001)(6666004)(36860700001)(70586007)(47076005)(81166007)(356005)(316002)(54906003)(110136005)(40460700003)(426003)(1076003)(336012)(2616005)(2906002)(16526019)(36756003)(186003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:53:00.8918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539210f4-4021-4e36-d538-08da0344f07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0052
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
index 8df736dea1d4..484d73dcbe6c 100644
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
index 8bb551eef62b..e5867b27a47e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2723,16 +2723,18 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
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
@@ -2765,7 +2767,9 @@ static struct irq_remap_table *__alloc_irq_table(void)
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
@@ -2774,8 +2778,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
@@ -2799,12 +2809,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
@@ -2818,11 +2828,11 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 
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
@@ -2916,7 +2926,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2957,7 +2967,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2981,7 +2991,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return;
 
@@ -3616,7 +3626,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
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
