Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE71BC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A536414E6;
	Mon,  4 Apr 2022 09:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plbyIokYxpzX; Mon,  4 Apr 2022 09:46:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EE48414C2;
	Mon,  4 Apr 2022 09:46:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85445C002C;
	Mon,  4 Apr 2022 09:46:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9EACC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6D5E414C5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DShZDEfvKASP for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:46:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57F28414C2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k05x4P3dPJdZxd6t2lHuguv4k+vEHvRvfdi7FmS58HvjYmhQFwvZScKY5f6kAdfmhycXnPwALvJTc3PtTisJCwWx8daOyfiYCa3AczpX6Vfnz4KchtV5FCIz+Lvr8H9VtTeh5cmY0P/mouYQC3PgOUFQ+T2eGPIE6Z7CBv/FafajtnFn/mWJ+rv4Kn3Qu4s06gFHCFMDXqMRyfc15cZX0alwAiQqGlapdlRgEwPFUOjshBsPeH7OpQC1Q+0uB80eI6lP7CV5bto+DgVDHdspMCjZgD9tP3T0bZ4DgCTUyiT31RfqQjvAwtan6jfGLA2ZtUIuEneGGNbZQ3+rTda1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWlbaW2mKPTa/tcISkzQlUrA2uz0hrG/TzLxRum+CD0=;
 b=nLNSbgNiIXx/xO+Ei5jLQrOz5ihQPJHsYa0AcZa+Ipu9xhBojJ26+Lp01BMNKVIyKViF3i72i5pMfUKhVqjAhGYsiF01GJGsQ3m9Xy8aYgHwMhRAkklECHELxGQeditZqCprbPdEcy6UNTmdyT/Jw6IiCgI84zDsoXIwB85JNPd5chweplvgT4U6Mdo0DOWiEaS7ReJWEKGyAXylp1r3+3NzvG9yZRdLfvRXSuss0K5fSilYeCsyuJvu2ymNNQbS8EGG79QRnlI9ncYA8xsucH/0hA+c5cvdZH8P0UGeg8NUjZNMaVHGf556OUVIaKmckQUZ6Gtd41XaL02Tacvuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWlbaW2mKPTa/tcISkzQlUrA2uz0hrG/TzLxRum+CD0=;
 b=5nFJFlrBrneQVxKJDJqopUXV6rfA8RGzFxFRNoZWze6NTQr/Z3unhLm03U2zFv8wTJUul9rC4EcFz4GQCropInX3f9fbEAph2ijpSVUV5ffpk0iB/DWSVUMJgTJ9CfUjD9lQaPe1Xx+z6M1D6Mk6Cw/FLG1B3zUYwrs+bKWIPFk=
Received: from DM6PR06CA0001.namprd06.prod.outlook.com (2603:10b6:5:120::14)
 by BN6PR12MB1780.namprd12.prod.outlook.com (2603:10b6:404:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:46:52 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::81) by DM6PR06CA0001.outlook.office365.com
 (2603:10b6:5:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:46:51 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:46:46 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 14/37] iommu/amd: Convert to use per PCI segment
 irq_lookup_table
Date: Mon, 4 Apr 2022 15:11:06 +0530
Message-ID: <20220404094129.323642-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da09a3d-574c-43a7-b5a1-08da16200b77
X-MS-TrafficTypeDiagnostic: BN6PR12MB1780:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB178014A9CF30BDD90A6F875487E59@BN6PR12MB1780.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbLXNfn5jwXaYlfSVxJr8gXiCXP62J9cVoG9GDXGvqWwewDVdXmYlRqRyPOouyUNGbTcbSgKx0CmLCobjrwePA0t2LISYfZQRyLAJZm2nzu/xCY9R26P9x2rRVM2zlHM29z2OHz9RL7pusGAaZ7CtuigxcfaQKyF9JevFZZK2/fUvwSIp8NO075Jeep4JczDpGQIHkPZQhFOodm0/VFWnf40aK5vVLdGH0QYFMR09edq2d87ls6SmbxvdniReqt6NyEPZL3OTl7BAC+QZPl3mEiN3cN2VCSk9daoJxxcu429Od6LukYbW2yZtMyBO0fPJPrguZGALGIrlJCsU7W6Vj+m0BanVsjy+mGck6IBChOTz6PkQoNJr2LCwt/jX1iOXjHWl+kEKbtfWcZoQE2ZeXGiOIjmhMfbek7YiS7XoOI3/ZTIFisjz9yywZr+bTNXC+yh3nbUzKQtNv3zg0s1BCaGRmOxQm4l0517ryOYqRCOPHjwSjRXdGBgresLb8Gv4CC8k8VEKJVIjwtF+3h5f9Oph5CP8v4c9FK4VeWgY6CEKCJ6n5ipRvOwuskHqRrDavZOnVkqXsUKmlIaCA1+AAHNjo5gfSVDmL3mfZEiHgMTGRmOkBW/b7M1i5FO1PiMLpYK4HMBey0yb5d0SjZZa09F7hZM3CYmwnLgc9iuLaVzhyT63y1u/CA6+YTnFfyrD+n9cUmyGUHp3fkwvFqvbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(16526019)(81166007)(2616005)(40460700003)(356005)(1076003)(54906003)(83380400001)(82310400004)(426003)(36756003)(2906002)(5660300002)(26005)(86362001)(508600001)(70586007)(110136005)(44832011)(8676002)(4326008)(316002)(47076005)(70206006)(6666004)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:46:51.2412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da09a3d-574c-43a7-b5a1-08da16200b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1780
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
