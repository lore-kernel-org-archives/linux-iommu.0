Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19133C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyhYRnl6qs5M1ZvnSpRd6NLRAni3/DrJ3xZFdQ0t5/3SAzNDIP16xpUBwK58A39oSXqpS9H3ZeYyR1ZxrkduIkVXqSZ7yfF7gBIAAndHOigf1xHMbcQWQOd/ONNuXSP3K8n1BIT5hgwj19u5j2GTjXxONSqJcw+/V3I2mMiMNZID6jG4hhAW6q0Knq0p/tDwMQ0co6/YLzc/ObA2CI22UBtG/OIVjO6bWWQF1MMIWKujLYjl34KxB0gv+OiArRvxFBVWCe7yBcMecJtWR8G52mhEZTmhxgye/IqqD/DvUMNF4ztFM+0cK48ZrmEqaoeuwaRUHSy8W82MJUnY8XJg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrKePv/8j8+GOdMsDxDPEpZ96rTGtJ58eKvep2IeZ9I=;
 b=YYogA1PBjLYqXj6dSB6/sP5bV6ZblRKfNWdX1y+w7tE4l0eYeej5MtFuZt3bS8+GIYRBKgKmfs1FsKh8DA1zKW8rlaFZPG4d3hBMKo5HzPM0GFrXz9qGpJRw97eU8XCANg6lpkVA9e6kqXs5aKs2ZavdY/UvxAW+cnKTPyg+GDz5aSuFNmOyJmhSNMw0CrxFLZB6vXw3ecz7JSFgSXeIVxdLyIbSK13UxyV1WldzPUwVF/5EqXh88NTRmsDJD64nFYw92CM4FrwjFwpz8H+PzqXtqTCPTMFC/zLb6gNXo6wBoSGiIpih2MQmKr9ByUI5CWrGNvO/ITGRX90Gr7FZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrKePv/8j8+GOdMsDxDPEpZ96rTGtJ58eKvep2IeZ9I=;
 b=Ol6RB2HPJKE13CjBCB9bG+hgk3k35ngcT0Pye4e3EW3vcsohxrRCuZUhTS/7uagfAeCg9g5Q6g1vMYc/uz+r2zQfQiPVuX2udkrtwq0N3w41T113IEBi+Rr3jV8I62G/h9cTw/wB7Dzo9ElaI5dxRslbahOk9znw9ciZyKOqfSo=
Received: from MWHPR13CA0046.namprd13.prod.outlook.com (2603:10b6:300:95::32)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 11:47:32 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::ad) by MWHPR13CA0046.outlook.office365.com
 (2603:10b6:300:95::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Wed, 6 Jul 2022 11:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:47:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:47:29 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 20/35] iommu/amd: Convert to use per PCI segment rlookup_table
Date: Wed, 6 Jul 2022 17:08:10 +0530
Message-ID: <20220706113825.25582-21-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18656682-6bfb-40c6-f432-08da5f454ffa
X-MS-TrafficTypeDiagnostic: CY5PR12MB6057:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qkr15h1qM99/3gypZNU1sYgprmcHcOvzHbV2/Y27ms5JFIKcZhu1ojT//OiMeFoEMpgt2ZMizwreJnpUp7ceORWx9gPN3Ms43N40EK5wFPthxrs/y3qOqYjOtmVwjNotZ4crRoEoP0c0/AFkE8jc6y70JMAH4Zxc4tRhNX6xdUjdP1TZU6tnDHBkle3XCRizLoOM+mSaA7Y0VLwKUsA4QVgPE1bDSroiXpXqBsehXV7OArpTAroWr1bynavgmLU346HN4komvDwpYKpfcFsr6X/WaQ0UDDDFYvfMW4vUqdPSXvi5PfqfUf3AKmcMvkEHIx1Oh7kGvKEDqoFBsu2HlQameJuJw3NAC0uwo0YCOarLmhkyQCF6oFUhKp1ovrW6e6RAdrbNn4l9OAno1kOy7CsxRD44k+fEm9WNSu0+X8zVovOhEeIohl6QuX77ZqKSjq8D2CPpncipWGJHcb7gUGZtCvhXGquUHtmm6Uhwzr/8monY3zI6wqIn7pwwRSeiOM43dxOuCHB7EMwvC7e6jruGJBmBSzGAfczSp1Az+1WGQ3K3RkxLAAzHrflyiTbeC78T1HQF7zuAae6SLtFBVUezOLWYjdKdIUZB0qrhdePkda8DxshbJZngHBmuxDLcpAx3H1owzNTPQGyDtOXKdDpVwtxV3Lw6Nc3nM9/jzMNMUhIsTm70DcjevOo5W6YNuymXEnaIaOSk+wAScRCTUPlGNS1b/V8m1Eb7OvRXSf2aJWUNjjqzJS5NihNqBiEkvSJyyeFEvptgXZdEQ2GaFCD/emMA5gGe6rkLuiiP60E5vqjZjpcAl12sO2LXAKyjd6fHFArVPX8she233x/lCLkleUvAWqOIYPAoLMvOUE4zSXqTMzhvQWIEANW68vc8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(478600001)(186003)(16526019)(34020700004)(1076003)(2616005)(36756003)(7696005)(41300700001)(6666004)(110136005)(2906002)(316002)(54906003)(8936002)(5660300002)(44832011)(86362001)(47076005)(82310400005)(81166007)(336012)(356005)(82740400003)(426003)(40460700003)(26005)(36860700001)(40480700001)(83380400001)(70206006)(70586007)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:47:32.3700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18656682-6bfb-40c6-f432-08da5f454ffa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
Message-ID: <20220706113810.OME3XUGS85-8IxnHvLDb_ZHwGsvKYHnIEI3lWhlpmCQ@z>

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
index 67feb847fc13..d932c90329e4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -846,11 +846,6 @@ extern struct dev_table_entry *amd_iommu_dev_table;
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
index b7b50345c8a5..b7e54bb5efc5 100644
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
@@ -1144,7 +1137,7 @@ void amd_iommu_apply_erratum_63(u16 devid)
 /* Writes the specific IOMMU for a device into the rlookup table */
 static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
 {
-	amd_iommu_rlookup_table[devid] = iommu;
+	iommu->pci_seg->rlookup_table[devid] = iommu;
 }
 
 /*
@@ -1826,7 +1819,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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
index 5ee1af9a0a54..6e0cd9c4f57c 100644
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
@@ -2749,8 +2747,9 @@ static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
 	struct irq_remap_table *table;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
-	if (WARN_ONCE(!amd_iommu_rlookup_table[devid],
-		      "%s: no iommu for devid %x\n", __func__, devid))
+	if (WARN_ONCE(!pci_seg->rlookup_table[devid],
+		      "%s: no iommu for devid %x:%x\n",
+		      __func__, pci_seg->id, devid))
 		return NULL;
 
 	table = pci_seg->irq_lookup_table[devid];
@@ -2809,7 +2808,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 	pci_seg->irq_lookup_table[alias] = table;
 	set_dte_irq_entry(alias, table);
 
-	iommu_flush_dte(amd_iommu_rlookup_table[alias], alias);
+	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
 	return 0;
 }
-- 
2.31.1

