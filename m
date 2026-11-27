Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779053;
	b=rKCobQ+IJq9qFr2Nh/n2idisUkHpCxdouxboyTq1YOm6dMwf2+cra8X+H/TmANVTtGWm
	 Mny3vttqjZ1mIIObpka9gU7OVQrTOf2R9vBBjOvOXQDO8OMlCrSfzkT/V5TxNOVqRIgEq
	 C0Gha25+unSGqxws/zDDE7zuGZ27xIh0n46nBxZcMWxz9fp2sE0Nzw8XSadv1K1RlArBs
	 aATwg4P1b+qTi6WwYjPlJaVQfkdU/xN2E6kV6JAbTkLFDJ20Ldj2u35cSYtb3QpK2AlAz
	 HVcVH21O0jz0iBI5EZYQ9OO7gVz0bBAQoi1vKHdFeicLucjBiVr6KKNuT34EY92ljRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779053;
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
	bh=KSP9pafrIMxqz5xBSu7jeumKmSdlBmCOijDgVYVd4Rc=;
	b=5cGcfBK1KadyRF/1gxGoMVQetGuoxcC1Z+b7bdbSw35YugiVetBNPAPFEAXa+iiIaytg
	 92YvMW3GIm8r0AAuMTA2AsdU/u1ayRwGofkAxZ6/Q4KAcvG7P0mW1lGjh1M0VL+hJpflW
	 b75YCLT1t7bN81BQOStUFyZ8UktF+nhh0MP7P4bqlVuK39SNKpcruUN4x9EzZ0etsBenK
	 urRyv0rUmRbfnItqgMJX+WVztZ//4AiTYBAjYSi8J7F6kGZnUeOsEa5crOmtJOJXsvDv5
	 DyxSvuR5MMGurXMWR6oXiAuI6pPkpcCd4kA+8anSZjTr4AS31lwsV45AurnVZMCH6BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ki+NKe6A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6FE606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D6FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ki+NKe6A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsaaXQbhTSWA5wO/4aLBRsLQc6yG/MJOm8qn5dkwGwJrVnBQ8qPBollukgmMt5qOxY+7UTxlGWZBX/ljx4EtGvARUlWym1+IwtyEuMxMLO8pqRnSqLzkqiC/rjwXc4PnI9ma5KZdXYSWQHmhze7EDrirP7TornkhEZyIm5Gvs53J6sdVqi6ttaysFich6VkYJpOkGIEQjqNtPOLpl8EymRQ/PmUb7l2pQ73z+MzO19CGHL2epBKjTAyf16YhbzfhAD4w9tz53eysgFnJhv5pRk45/IBmy+TFCIRwE9Bvm806YawloPJtxncSjyNeQ7M5Ylkm+yy6vd2gVhawlfgi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSP9pafrIMxqz5xBSu7jeumKmSdlBmCOijDgVYVd4Rc=;
 b=YKLShNjszv8l/rdgTkTgNFIItdPBjJoBqpJWMd16Fo7VPwPERYWwOyaQ+XEJ5uqWhUhq9vaI7ctsAB+9XjdSaq1rR0iMlj9abGtRO501ADpy9SVmCUbRlyAHt33DuB626YU70b8yVFIaQVHlnM57prdGlJyAD4XIJHQQonYsxpoQiQjYAQhe8bSMMtPl0Gur1Ou+OzZZScojMpgg6ecdXRrXvS0bT1+9eeO7hsiHL6RvLOVpFM23jbZXDiQmctqjV4xzhFfkFw2ykPriFpVZI/w8rgQqjiRYlSXGHKYPvXustrSQjkkHp8j9NaFYHGmr185n94bV+U+XOAnrbZhqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSP9pafrIMxqz5xBSu7jeumKmSdlBmCOijDgVYVd4Rc=;
 b=ki+NKe6A3SjXfe4AuK0mQQDEHxjDWDSTB/kfZnbAj0wyK2bs2YnNW6IyriKC42xbC2IKhK9c7OQQQ7dwcmfk9vLGGdFVQpK89nXHhkLiZULIKV4+8w5c9eNqCa5ZTPy7Kr1exeUOoeG1NxUjrfqT2NU4EuYy3O/JaT0TdpvI1Rg=
Received: from MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) by
 SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.7; Fri, 27 Nov 2026 11:30:47 +0000
Received: from IA0PEPF00000037.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::3d) by MN2PR01CA0066.outlook.office365.com
 (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:30:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000037.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:30:47 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:30:43 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/3] iommu/amd: Serialize device-table writes with one per-segment lock
Date: Fri, 27 Nov 2026 11:30:16 +0000
Message-ID: <20261127113018.209034-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113018.209034-1-vasant.hegde@amd.com>
References: <20261127113018.209034-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000037:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: f1393b82-3dba-4a27-45cb-08df4c79e1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|11063799006|56012099006|261026121527099003|261026140227099003|261009223027099003|261022105027099003|261102123227099003|261021121427099003|261028144727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	h1WAE+2ZujZdkGte6jEjAt88AK6PgSdZZQjojpSooaWblyYM9jrs6VhhoefwfA+tLlW58wkIbRMRUHI/r5ckmuuMviPiBanACMFzFXywJufsAXWl5Vck2+IKaQ3J9Y2iNiUoeAgpuKBkM1+bbWWIO8UA8DSeIDi67g632GJuDpTs8A47NEMMg2wc+Jv/PBgbxBOj22AwriegtOdaUaL8gvSy1NMtwpQARHSbiMJOyy/sRj3JiXXlXCCIqH/oAoxyJyzC2570vlX7VDnX6LZoqlvj94VytpdxY5cc8vEjAniHzckBo285YrilsEVuPECiv/g+XeZxUx5ovswEYGzF3q4brzX77ED5b5WYCW83/lUomoYE+SV8ElZEpBlFldhRivSbQnOAMF+mC51ywBUlFAHLpOJ0gbL50yNnfJNHbwWpmpdCdkSbTFZ10XYKEpfu/a/kTbsm4VTV+R6Ihli0Raew9DnWdc8fxI6ijJHJgoZi7c03wN6OtsTqXnaQOQ2TrNhyVZ1nmYSijHEGLLpm6TF11fAiK0ErvSg2jVSVu/HKI+uIvjVui9yky4csH2t4zigbeNbqKfC5+MPT5Q2L3T/YrbXTYMtXIl+2iv/pYcvjOeZO3cggocJnGQLElYVT7jXGcdF+9EW6y2t9Jdhx71z0oU18mM30Uw+dy7wJBOcxH3JXj5gMgq32h5JRpbc7gPjgZZvbXVf5BAg+/cZ9PA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z4n/ySuv5AnhMeOCsvVyEGEbO1FqhS8liMyW3AncYgv0EedoHtYizJ/Z70W7qM16mL1/MKXhBSsBZwHKwv96+TOVk94gCt442ZDskcVLxXYg8FP1WfQLFRZduEhBtnV4QxTNEod1FprANAf9tNVglKUNwRe6FeMsglD2hBqSfQXUb7gi01KeEukcMD4Vo8PYamEWadB2A9i3Ub14e/5J/xuTPPai4fjBjnx/0T7+HGkZvYmPefI/QetBcapK90zCsNgLYO2MrzWpefs7BMGsGWIeJ3N1VDZBA6Co9D4QY8pyJoqSgBpPQwQxFHxP/YA+bke/PmCqRsXGv8cqbCGvhSZfjRdV8eQT1k5leHPQTo4813WYAEYsJAXJA8tHnwDKvlhat7gGKJSQ6tXDmeYUQeNAa4a0yB2+vw/kNkcC6/sKcddQriU8u6HoGnobvEwV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:30:47.0769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1393b82-3dba-4a27-45cb-08df4c79e1b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886

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

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/iommu.c           | 22 ++++++++++------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9657e80ffdeb..30dc9495e3ee 100644
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
index c9c504ce8ce6..61e7b70fb063 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1801,6 +1801,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
+	spin_lock_init(&pci_seg->dte_lock);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 41ee4ad1dcf8..8beb23e96c8e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -121,7 +121,7 @@ static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_ent
 	/*
 	 * Preserve DTE_DATA2_INTR_MASK. This needs to be
 	 * done here since it requires to be inside
-	 * spin_lock(&dev_data->dte_lock) context.
+	 * pci_seg->dte_lock context.
 	 */
 	new->data[2] &= ~DTE_DATA2_INTR_MASK;
 	new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
@@ -152,7 +152,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
 
-	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 
 	if (!(ptr->data[0] & DTE_FLAG_V)) {
 		/* Existing DTE is not valid. */
@@ -208,7 +208,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		write_dte_lower128(ptr, new);
 	}
 
-	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 void amd_iommu_update_dte(struct amd_iommu *iommu,
@@ -230,10 +230,10 @@ static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
 
 	ptr = &dev_table[dev_data->devid];
 
-	spin_lock_irqsave(&dev_data->dte_lock, flags);
+	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 	dte->data128[0] = ptr->data128[0];
 	dte->data128[1] = ptr->data128[1];
-	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
@@ -383,7 +383,6 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	mutex_init(&dev_data->mutex);
-	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -3104,13 +3103,13 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -3340,11 +3339,11 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
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
@@ -3354,8 +3353,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
-	if (dev_data)
-		spin_unlock(&dev_data->dte_lock);
+	spin_unlock_irqrestore(&iommu->pci_seg->dte_lock, flags);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.31.1

