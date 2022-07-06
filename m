Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E842F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3CuzRt+dsvxGT++4in8Rbqn6oIwgGdBMmxly1yPClvxX1Z3vBwv/74cf0Q0LA719lZDi3YL3teh/oIDZU2xiqNmUi1Lcb1boIXUKf9rn5C4kZNgRvUqBio6sCTuFWPZEhBsJFLr89HQOp0ol+90H0PawRY9OwMEHeiRELZdrFN2Ne6AoqjQCeqJOyllFSLA+b89zLiHNfcST2MfspGZrkvDdQh1qIeXiCYR9c3seaI9mta6I/FoWb+IlqFU5s8W4IzcYXbRu3vNb9bDqro/EWLVSYsAdKxWWVTERMrPM4S66HL9r3BB7J7FtwTCJ594Cd1KCDdc1fglqo8QLeTQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hODCuNlfb0bpgJQdy/H6DfJWx99opEXltFNhMLSxGT0=;
 b=WRDDvPt6jC1rwC70m0wibKqVy5aUQf2X+ALzoRBDyLmsCDAeXyyf7k84/65HLZLf6eFjvMbXOPRwERojqvlOyv5V8J5pgCw9t0OqVpnBaUdTsRtF6yt3eqt9eFjZn/2iK0ZldOYHrFsJRcRGgiZoEIord4GLKa3C3Hlj+FLZubRxa9dhr33mRsaaFAl70oZ4ye467NUSAIND9MDnXGh5ZClBQdKRgCR2f3wNVxX9VzLVOfrmL7GxuAk69aQ4eeQbRRL+LRH2Y7iHWZS9Fa4OjlSH2oe1w+8h3WSKFJpmEcmsdA4ZUANAyWmlOH7viLN0PIF9GHZEo3aFCZUl8i3JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hODCuNlfb0bpgJQdy/H6DfJWx99opEXltFNhMLSxGT0=;
 b=M6KvahTxEPnn8sCH8Qo127g9g05TdmxJAxXXH0jP057TlbMjHnZbVmyARWGF5EqiA01e2Eq8VHmwi0t30t9qI3ukEnwKcvEaukKVELvOPx/Etle9Rh+mV7N/kS0kuja3Ylbhizjiiam6Mj4wSlTg47446Fk5LTjMsdAWK7Pfrvw=
Received: from CO1PR15CA0080.namprd15.prod.outlook.com (2603:10b6:101:20::24)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 11:46:15 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::3) by CO1PR15CA0080.outlook.office365.com
 (2603:10b6:101:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:46:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:45:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 14/35] iommu/amd: Convert to use per PCI segment irq_lookup_table
Date: Wed, 6 Jul 2022 17:08:04 +0530
Message-ID: <20220706113825.25582-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 069543cd-e21b-46be-93b6-08da5f4520f9
X-MS-TrafficTypeDiagnostic: PH0PR12MB5483:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4s3n/LuljfLFkavWuqD4kRA0syfLVow/c/smS2shhSMXT1d/pqiPhJ4rO7L8wIZ931wXbWViif9FFCpPasKkI6+79dU+rLZbqY0Kdmiy9CXzAvepIxSe4dIVnkg99o6cTmsNkFESNy1Ucz37D2GvqWbV3TC2IZoN8AdT0XN//XSw094XBPoT9KQEYIsv6bdFm7v4YnYn7Z/fxMd1dUcfpKVHckE+8HzVO5RXOTGrDXEeHfFxG1LNQyRUgWZH48WN6RCn8V8TjpwPMA0mZXbikZWUZto46aYk8gJdKURDMg2bIvo0g8P0cv8hbka7StWowSBiB3v+Dar0VkDTcIhjWFa74qggwXCNpWaw+kAcXfLGPKidGHbm4WSOOu3B6Qdyjir2zb3WcGH7B+XRjcKvbwoSqy7oWrf2JJm+zO0lesLaSdEZi0FKQuqA81l0bX4rsp2mo8jlRG3XoAdZjo/lZopXhhcxZ/aHPrH6tqcj28eIv+IfikXt6yTJC0GFcaZQe7PrvTScqw1qhiVAdVWDiDY7UCI7UfyvssdzA9X+Hb4JqdvfApBAEbk3A/ixeCbFOwuCtx9gW+H98m1KptKcs7w+Nzl3U4RFtemt/rEP776Tll280/yrs48rVVHQTTflBBS5O9+yVI2RPjCysUwC9nDd/6shTRJ7ZT/bgRpJZejAxN/eniIh/ymo8xgMkFrhb5gIlW9RRxe3BTyuQ7W6i1D6YKgKKRM4sg4A+zVPqSOql8Ca39lAAWzg3rCrHqHvqVEOOEALcQBWjhDxu9IlNkgt40x6u9GfNY71a5k4Wr70iYN87JkOldE91q+J4YP1WjRwAkLDw6Q1TYkkYtIwFcf5CJC1LWw9Skmh8Yz6pbAQW4JQB6M7hIS2GPXv6bMw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(34020700004)(356005)(336012)(2906002)(40480700001)(5660300002)(44832011)(40460700003)(36756003)(36860700001)(8936002)(1076003)(478600001)(70206006)(81166007)(8676002)(4326008)(82310400005)(70586007)(83380400001)(54906003)(82740400003)(26005)(47076005)(86362001)(426003)(110136005)(316002)(6666004)(7696005)(186003)(16526019)(41300700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:46:13.4455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069543cd-e21b-46be-93b6-08da5f4520f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
Message-ID: <20220706113804.Ni21CfB_L8GDpXaBZ4apqRlmuLwkx5F0VWktBBCIc-I@z>

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
index 8d2d5fbdb57f..ca1a3d55cc83 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -445,8 +445,6 @@ struct irq_remap_table {
 	u32 *table;
 };
 
-extern struct irq_remap_table **irq_lookup_table;
-
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index afe3bff5bce0..b7b50345c8a5 100644
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
index 53ccee57a7a0..cfecd072e7a6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2732,16 +2732,18 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
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
@@ -2774,7 +2776,9 @@ static struct irq_remap_table *__alloc_irq_table(void)
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
@@ -2783,8 +2787,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
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
@@ -2808,12 +2818,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
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
@@ -2827,11 +2837,11 @@ static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 
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
@@ -2925,7 +2935,7 @@ static int modify_irte_ga(u16 devid, int index, struct irte_ga *irte,
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2966,7 +2976,7 @@ static int modify_irte(u16 devid, int index, union irte *irte)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENOMEM;
 
@@ -2990,7 +3000,7 @@ static void free_irte(u16 devid, int index)
 	if (iommu == NULL)
 		return;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return;
 
@@ -3625,7 +3635,7 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 	if (!iommu)
 		return -ENODEV;
 
-	table = get_irq_table(devid);
+	table = get_irq_table(iommu, devid);
 	if (!table)
 		return -ENODEV;
 
-- 
2.31.1

