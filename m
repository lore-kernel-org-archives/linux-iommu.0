Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851615;
	b=dC11KOmWGWPoCP4lnA29uFwKTb9/AzDbvYsUXGcV7Isc/katwtAnTVR6l8nphCPf6m6r
	 TlYri3t+WRP1jsTcNxTxMGaoSpw+dYsv0z86Y0m/c9ylxAtDwlcqQBP0LbiSFEHcZ4fff
	 bMSfPhHLCMx7PfK4zzLlMYcRxdja7pQoUhAI3g1N9rlQg1Fbyp/lR+Y9alHoV4dlooszL
	 BxzYkDmGCPnrAXZCsmyD13fQPqM8Dotg1eaXuJRwUDW3iKo9brntWTKBRLtJmFuwY9h/n
	 l6xxr+Z9w32d0Mg5L1wOJ8X4ML0fqgqjAEWFoVDS79VHtPX8nr2qK5MINpS0tZJmz7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851615;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VIIpeGd2JhOnp2lI1u2+g01qQKUz1Zj6+YmiLuyv6xg=;
	b=TCbDKWV8TGVrP96oqksyWkVL7kPnc0O34YeiVwPlryvQjiOn/GIy5ouHxNdyXsMEhQIr
	 rgAKK5iV9m9LNXPO+m4V9P+Yru/Rgns80T42BzUK5mIeCvOh7Ihp1Xaa0Sg4i3aiB+VP4
	 6+4j7XORa0A15lqR1rxpBvx69hvmEr1SMtQGcjeeWg7uJoeWEBJOz/rwYbpNrQcFz1x3h
	 pR8wEbphLhKwTqsgCQTGqSqgespeNDWx0G197JxP/WZmQdYoDI6fw4436jW6sVN36eI/5
	 wplK/pXHe5tR9+M73yDobzP2b9hiz9yuzCzHkf6amjrEOH74XiraINvSfTWBrQWggnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="ThjrFSg/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6A606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE6A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ThjrFSg/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzvyGwT835vCQ1csqhCHz54EPBIjH0iyYyikM4yH997zDIDyl2bP8TbTeSISObyAmPJ3+R6LqJZFFPil4kJAAwFbPhRAX6j1YMiURI4yYu2FYPjZE1kFgsqzkOILXcLgPqo9vTbnNQLpolGu58fsQX76G6tNAjfdAPK3qXVR1XNX48eWjA9mlqScnFO0w7QYsbsQBVozW6k3QTDJ/pbzz66pUy31UQveBPI4xqs8c9KuopHz4nDGvePpjLFqnnMmYC8qQe6GkrkU5h9nlUJ84TUXF7vyaXTIWbmYcRl0rrbeyxGHKHW+2zZkjX6TmZ3NeBLMwYOKESF+zPCql0wI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIIpeGd2JhOnp2lI1u2+g01qQKUz1Zj6+YmiLuyv6xg=;
 b=cGILWJVOSJIGLD2XFDBYkOil1CMoXsE9xlbcWWFwObcTNHM5rms5418kRlslm9lQaUKOJHiinETtiV2+6RuLFsVFNjedOwFZTfF5lmDy6aep5kkArJ92pOXyKCI+X0EBo46JPpRhvWT2XFl2TPUEtHGkw/HAKtVZyAM2b4jLyQWSI9F4PRa4dVeFCU8d853Jm9l6aiwXUKJZJary9FT3cQqtO/dvwP/aTdkLy2NJkQUzyNyuU0Ss9OOH88tiL0P4SFDDgK2rk8X7VlhGpAW5KPsvOftUjBYfoRJ/8Sdt9U3nIXV/f37m5jg1C0rheFNTBnSjvi4UTpA4mgeVWDcrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIIpeGd2JhOnp2lI1u2+g01qQKUz1Zj6+YmiLuyv6xg=;
 b=ThjrFSg/QF0AIHfdF697oUjMAQObvHDh1I5ONZH92pyM1p7LFV/3AyJzuH8XuA0d1P8zpTIHrtHbgpWIlPahKMdpjR+3CjoqwBblCzW0YO8s45lNFfepVp1Wew5PYKxIhQSiw8MbY/o50pSbGHVxD4oN//+ADjIiYPVFfglDuPg=
Received: from BN9PR03CA0480.namprd03.prod.outlook.com (2603:10b6:408:139::35)
 by PH6PR12MB902451.namprd12.prod.outlook.com (2603:10b6:510:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:06:51 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::68) by BN9PR03CA0480.outlook.office365.com
 (2603:10b6:408:139::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 5
 Nov 2026 04:06:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:06:50 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:06:48 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/3] iommu/amd: Serialize device-table writes with one per-segment lock
Date: Thu, 5 Nov 2026 04:06:15 +0000
Message-ID: <20261105040617.398870-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105040617.398870-1-vasant.hegde@amd.com>
References: <20261105040617.398870-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|PH6PR12MB902451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afdd286-cd41-4da0-a6b0-08df3af237eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261022105027099003|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006|261009223027099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WOFYBNLckdJLN6Dd18oMQNatfkRxNw7q01zBGM9V2Nqm7XiHrLLwf+i3BVGVss01DgkzVpIiXi4DGOz5uKgc6eIy5WAxnnzj/pJ96uWNy2PAR3vm/MBcJwSxq8vtTSn7Z36liFssonC+oH2EmJHL1cAPGux2DhyMcaXYjZfiabO4ld0woTJbKFVzqAAUZEaplbprhE5wgPWLzaOxRXcZaquJRZM9alv2SQVNFGp3lRHEJPY4jTgob8aStH2E4P5KWnPKYBW/pUE1HjgrbAeAYCNdN282ypZupiZMxcHPEjmlsrxG8VVOR+FAAw2S2G8KE5FJ0LwYoDnujeqPSDQxGt0jc75WeewpHqW2wg4T/cmUwSgkw+w4JPvPtb0162MKwqdOq8v481ZZPZIcSQdIqQuU4CoPiNydQk3eLiKQDSFQ5DMQS6LmpSVNFADQNJrUZ07QtJcEQd+vm9k+CRf0G4gaP3b0URgcSevRd55mRZlaKZCJIjhlgHB8h/YZA0ha96E3FhXGRTdud1yOLh/UNzEA/iO9+7EFARULXCqQnHicv3O6R0nCGxKtFkcAjKdj7rWs7KxhI5xTmgjHqhxtueSEhVJrW8helRi/kGFAgrFFhrl2sB/Q+4B6AghFIS96/T5o8JG4YSnQZBC5TO8+2HVF5YRbXuFtHEtEkw7pLyxT3wXQlXPoqBziVCkUAMQnprOUrj9U1XqgFbL0xIhhsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261022105027099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NR4GsghOS3h/raH6nY4r1l24nJkWcANipfiAoZWsxsQikVaKRTihkuCT4mAddu6aZNBCFxHySKFMMbm1C63RxoLitlai4PHO25kMRePVHNblTPSoM5ChutVHBO99hO0W4+6Z0CLLN8rcf/ufzfxMccgbgUNBg00uuBTf8GRidXSNOyK1bqjTQXoZh76UqItjTSXXvYxjSnj0w0bDYkuArLkLnKmC2tOEYgBRjivGTpcswseB3iKCksEZ081uk+gKWgkJFM2dXeu46JIqxX2w+yw33jIy4jsYomWKKTMlbfCHOiuGaF8ADnVZKC4JjE1cLJyjvJ1U5o7kg0H9E0gyenk81O8NZYFSLYjOojx6XnOs2FLFBfXDoOYmMerI/nXqkSSbd165/UNyBlq4RiwZHAHBCErO6J2lMrnVqoWLpFKPzuySAVBmloxPyPBrX2gx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:06:50.4182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afdd286-cd41-4da0-a6b0-08df3af237eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB902451

The DTE update lock (dte_lock) currently lives in iommu_dev_data structure.
Because of this, dte[devid] can only be serialized when a corresponding
dev_data object exists. This leads to inconsistent locking:

 - The interrupt remapping path (set_dte_irq_entry()) skips the lock
   entirely when search_dev_data() returns NULL, leaving the DTE write
   unprotected.
 - An alias ID has no device object of its own, so clone_alias() has to
   create a dev_data for alias devices purely to have a lock to hold
   before updating the DTE.

Move dte_lock to per PCI segment (amd_iommu_pci_seg). This guarantees that
every code path holds the lock before updating DTE. A subsequent patch
builds on this by removing the need to create dev_data objects solely for
alias devices.

A DTE update is not a fast-path operation, so using a single per-PCI-
segment lock instead of a per-device lock does not affect performance.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/iommu.c           | 22 ++++++++++------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 47a5ec3c8ef0..c5e66334117d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -566,6 +566,7 @@ struct amd_iommu_pci_seg {
 
 	/* List of all available dev_data structures */
 	struct llist_head dev_data_list;
+	spinlock_t dte_lock;		/* Device-table update lock */
 
 	/* PCI segment number */
 	u16 id;
@@ -806,7 +807,6 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	struct mutex mutex;
-	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a48aa8806a19..5d2096910731 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1743,6 +1743,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
+	spin_lock_init(&pci_seg->dte_lock);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec6..668d6ec208c4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -120,7 +120,7 @@ static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_ent
 	/*
 	 * Preserve DTE_DATA2_INTR_MASK. This needs to be
 	 * done here since it requires to be inside
-	 * spin_lock(&dev_data->dte_lock) context.
+	 * pci_seg->dte_lock context.
 	 */
 	new->data[2] &= ~DTE_DATA2_INTR_MASK;
 	new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
@@ -151,7 +151,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
 
-	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 
 	if (!(ptr->data[0] & DTE_FLAG_V)) {
 		/* Existing DTE is not valid. */
@@ -207,7 +207,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		write_dte_lower128(ptr, new);
 	}
 
-	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 void amd_iommu_update_dte(struct amd_iommu *iommu,
@@ -229,10 +229,10 @@ static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
 
 	ptr = &dev_table[dev_data->devid];
 
-	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 	dte->data128[0] = ptr->data128[0];
 	dte->data128[1] = ptr->data128[1];
-	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
@@ -382,7 +382,6 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	mutex_init(&dev_data->mutex);
-	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -3285,13 +3284,13 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
-		spin_lock(&dev_data->dte_lock);
 		iommu = get_amd_iommu_from_dev_data(dev_data);
+		spin_lock(&iommu->pci_seg->dte_lock);
 		dte = &get_dev_table(iommu)[dev_data->devid];
 		new = dte->data[0];
 		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
 		dte->data[0] = new;
-		spin_unlock(&dev_data->dte_lock);
+		spin_unlock(&iommu->pci_seg->dte_lock);
 
 		/* Flush device DTE */
 		device_flush_dte(dev_data);
@@ -3517,11 +3516,11 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
 	u64 new;
+	unsigned long flags;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
 	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
 
-	if (dev_data)
-		spin_lock(&dev_data->dte_lock);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 
 	new = READ_ONCE(dte->data[2]);
 	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
@@ -3531,8 +3530,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
-	if (dev_data)
-		spin_unlock(&dev_data->dte_lock);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.31.1

