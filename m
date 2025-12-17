Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428B21D3CD
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015856; cv=fail; b=UZuPjLsdgb2VoVbuIotXQKc6GBsds9F+K0Jugy6Lf9zwr3F+OUqOeOploTpG6zpXZ3xchy5VqAfDEGaDJSIGRJWaN4UoDK5gPu6UPdtjaXDCb05tAXtPa+jqfYTP0Ia274yVXEywgXQImN6J/UpWZlq0ChSh9n23w3A66I7ilCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015856; c=relaxed/simple;
	bh=z1uWgRV6wODgfCIKg0xuI0OWi6m1qlzNbQDhlTWFfOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ayk86D2IA2/AAWFvqO7N6tiCZHQgWUOthkw3gS7u5/gcdbtJyB0Oto9aWbIrBnWGLf0cxeZc1XC7/BsLXNk7MaSh3O2y4A1MxU7ysHk0tbdhx3eOb5gBrPWCBP5g1IR8jlnCsaTjndoOh2n6rdXPM44d+fs4FzaAyu2uo7vgKd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ruyhQGMX; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ruyhQGMX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRjymia/GzqG/ykwe6NFz7zNF7enhkvQaB63KtK8lT5NvF27D1y74/B3uMFNCUia6qtYegfDBirW27GzV9kJqeUo4diRVXfodjhyWz/5BoLGAbK5nfbfD2lOvuylbIwmYvnAwyWY5cIv6YDYfm8iy3H5llw+uiEFt8eKozmAMEEsQSxZk8/1SXT3sScA5NsRjhc1rwKLk9gI7CBV+FWh8zhN0uNIvXmznKM5rfyzFZHW5a78WTCeFZ8quX/WAwFQeKMg+LGHRhzas3z0lq15TKF8bWMGSYfSO5PRDPmkxS07FGOMcMeIOBa3HSkUHWJAeFveGS5P0J50LBR1iLk6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvgrdxg/5X3hsQ9h7dD5jRV1bxEhN49hDG5PVPmMW6w=;
 b=zF9wCk65K6UT8mv4lRpM8ZUmrcRm7TP/wTh1s0jMBmWUWpmUYrz3EGWPceihYpf6YSvY3KCNg1AUdyWOUgsHJZ+molRgS/YlXj4ZK1PPPqaisJDDA/51c57H1CXH/tGfwVIvQY1TmGezVUSLFoEmm9v3bkElmgK+PLGMXFxP9Hn+dDXXAXyPBaaY/oHqp5SfUOZelv0jR0BlzpUFku3XfunLr+zJRMjwBETeNK/eogpYPi4i1XI+LLnuX6yRpjFNOOLzjXYDPlGZvsKN0bPofyd0+LwcDscN1JRTdOc0pgcAdwcsmuhlKc1gm4pdurBJtKjXhBN5SPzhmL+M/LWrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvgrdxg/5X3hsQ9h7dD5jRV1bxEhN49hDG5PVPmMW6w=;
 b=ruyhQGMXHpWKEifd9gvNq6JAd2//0yrdQ0ILGjQYD21CTVVYrJAtHLoIaYoZLD4HDfKpx2eX+dFlfXchXKC8mwxnaYojNe6GesQZSornZfu0RFhkC+exTm7sbsO+acj1HJyuLjdeVflHDJ4Dgw5erCZFmabj/+pIstPaJb3O4d7MHJ0ciH/DKUUFn58tBDDg5gCx1defxj6al7mcZ4aoZPWyczmANP+V5VXpoPQGUdIXWcmGpTT8O6ealzi5GFADMwiYaNibqHT+BrezmQGXsbw86G3KckL6iTBX/TqAA8KWHMprnlHNAbKGbRpb/zWFTklF7OBvhN+WMrZ0owxn2w==
Received: from BL1PR13CA0369.namprd13.prod.outlook.com (2603:10b6:208:2c0::14)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:25:03 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::fd) by BL1PR13CA0369.outlook.office365.com
 (2603:10b6:208:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.5 via Frontend Transport; Wed,
 17 Dec 2025 23:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 23:25:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:48 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 15:24:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
Date: Wed, 17 Dec 2025 15:24:28 -0800
Message-ID: <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766013662.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766013662.git.nicolinc@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a75eda-5c84-4dd2-e7fb-08de3dc3817e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yZcnp+PRqPs9BpB62niEG+HGiyeCy5ClVrvXLGS5nMTScP4QtkpFV6e8yW03?=
 =?us-ascii?Q?vwzgrYnitfwdhhdQBosk+gEjrnh/C3ZPyf3LlYWMV4BzgIZWcIzRHb43Ma/J?=
 =?us-ascii?Q?Tni79rn9Wwv9nyypJCpOBPtQyt3nsRzqbVhDOnOHFnWPi5EXtUfyYYrr9lfr?=
 =?us-ascii?Q?UcWQG0jofyp4ESrSS3iP67LD4K9TTWIqQQTtRLwcX7x7XcvLsE/gt08x/ATG?=
 =?us-ascii?Q?YHWfg5kvV1N9ufIMm9QB1tuKtKLtJSbi63zImjmSQdkyzIojc2vfQpFfQAYt?=
 =?us-ascii?Q?scG0eFwHlFC9TshPcHMdjsTMLowJZUTEI4J9xuQboAojT+WWGAGNtVcnoEmT?=
 =?us-ascii?Q?wcJm/pqrgBuy/Ro7Jn/ncG7CqKVKp/HnKh2I9vNuMglN+nmG3YDa7GO/aeQg?=
 =?us-ascii?Q?t4rxvWimIzTlLYGBtekUR4eak9goRbN06WJq+eWbbZxaibaOfrz4/N0wVyvq?=
 =?us-ascii?Q?7QHL2bdR1T+Y7zsKxkWKPq9FKc+Wj9yg1n7sS3sRY3GUUu9eU1lJfe7CmOxO?=
 =?us-ascii?Q?YW09TfI408uepsKqi5eKky9OWylt0pa3GrDnuEnG4Y/byMTyrG8poRiD72Bm?=
 =?us-ascii?Q?SABk6LnYv6DOoRV/jRYWTzO4b83B87R2XfFdCDYd8+CT2FQ8lPKt04a8fr0f?=
 =?us-ascii?Q?DEJhVBITFNZXawHLVb9MxzToAXpxXWKcxCHHXrAhlaHgGTcaWm4E6gsbc26b?=
 =?us-ascii?Q?OB0Hj9piJfUevF2BwMu2UQF3K6T0bO7WifQmBwkRQYc+8BvyUWuPOgW4yP0u?=
 =?us-ascii?Q?HaVQ5c8FBLXyDTm2kiqnzhbd2oZTMmXWFon/yFWB7Kju83b9FOGPyCZjfyPa?=
 =?us-ascii?Q?/UWD+96jhY5PoIWfTMLVp4Ae6Obkz4MGPFMgnrqVRjHcWhGCxxxSeSK8g9NM?=
 =?us-ascii?Q?+qp3YKT/zL2u/kQW9qjbvk6ys+svtbtMbLaLCeoqlgXez2v5CBvNS5f9/LXG?=
 =?us-ascii?Q?PM8UZt0SnWc49gW9Cr6T7L8KN6EHeP59ss9rq0yCpYtkURQF7naszVsr+YfH?=
 =?us-ascii?Q?Oxjp+i7xx2bfEpmgC2zTAEfe2DrME3/GwYH6i8gNLmO1ZPlXC9q5ymtxa8Zo?=
 =?us-ascii?Q?0o8o6YIJNoTf23LYvBbbrfJRT9Wmlvq/2JugebvEa818zu5MZtTSBDPUMq1T?=
 =?us-ascii?Q?wOJ1karfebgnkUI1pLvIjDwf662aWaXVegJZMecuVFNyVjA4ov9iqL2Wr6xk?=
 =?us-ascii?Q?XO4im6BnPb12CLLPzNW78fzwPgcMclI7GpSvDGWWdiwJpMqGRleBGDBLa7J/?=
 =?us-ascii?Q?Pqh0iaRLkOJmI594OWTfWWSyUwEbCDhoVc2Ftbz6uREo8zQK4d2NS59RFaCA?=
 =?us-ascii?Q?64njBj8K6cas9GUqHAghDUrlePdiER0/T2nB/5Ynnmp6gV1i53SIQa+/IcF9?=
 =?us-ascii?Q?LOHHU0Br3nzZ2qceFeOY6nNtqH4xuGz6UBGFdd0uYB8y6TF68YCEWhtnZfX4?=
 =?us-ascii?Q?R1KUB2DnTrkiEpYN4DoidF2XF6FTurmSuKebml39SzW4alXahoHQOO1JhJ64?=
 =?us-ascii?Q?NnKvPFElnRjx/UzelQyeQ0AnRlR7Hp5Ylmy4Azvyy+Xr5R0hE4863SWCpvnQ?=
 =?us-ascii?Q?2TvW7Vmnp/Cy4hbSR+A=3D?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:25:03.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a75eda-5c84-4dd2-e7fb-08de3dc3817e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

From: Jason Gunthorpe <jgg@nvidia.com>

Create a new data structure to hold an array of invalidations that need to
be performed for the domain based on what masters are attached, to replace
the single smmu pointer and linked list of masters in the current design.

Each array entry holds one of the invalidation actions - S1_ASID, S2_VMID,
ATS or their variant with information to feed invalidation commands to HW.
It is structured so that multiple SMMUs can participate in the same array,
removing one key limitation of the current system.

To maximize performance, a sorted array is used as the data structure. It
allows grouping SYNCs together to parallelize invalidations. For instance,
it will group all the ATS entries after the ASID/VMID entry, so they will
all be pushed to the PCI devices in parallel with one SYNC.

To minimize the locking cost on the invalidation fast path (reader of the
invalidation array), the array is managed with RCU.

Provide a set of APIs to add/delete entries to/from an array, which cover
cannot-fail attach cases, e.g. attaching to arm_smmu_blocked_domain. Also
add kunit coverage for those APIs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  98 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 258 ++++++++++++++++++
 3 files changed, 448 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 96a23ca633cb..a9441dc9070e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -649,6 +649,93 @@ struct arm_smmu_cmdq_batch {
 	int				num;
 };
 
+/*
+ * The order here also determines the sequence in which commands are sent to the
+ * command queue. E.g. TLBI must be done before ATC_INV.
+ */
+enum arm_smmu_inv_type {
+	INV_TYPE_S1_ASID,
+	INV_TYPE_S2_VMID,
+	INV_TYPE_S2_VMID_S1_CLEAR,
+	INV_TYPE_ATS,
+	INV_TYPE_ATS_FULL,
+};
+
+struct arm_smmu_inv {
+	struct arm_smmu_device *smmu;
+	u8 type;
+	u8 size_opcode;
+	u8 nsize_opcode;
+	u32 id; /* ASID or VMID or SID */
+	union {
+		size_t pgsize; /* ARM_SMMU_FEAT_RANGE_INV */
+		u32 ssid; /* INV_TYPE_ATS */
+	};
+
+	refcount_t users; /* users=0 to mark as a trash to be purged */
+};
+
+static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
+{
+	return inv->type == INV_TYPE_ATS || inv->type == INV_TYPE_ATS_FULL;
+}
+
+/**
+ * struct arm_smmu_invs - Per-domain invalidation array
+ * @max_invs: maximum capacity of the flexible array
+ * @num_invs: number of invalidations in the flexible array. May be smaller than
+ *            @max_invs after a tailing trash entry is excluded, but must not be
+ *            greater than @max_invs
+ * @num_trashes: number of trash entries in the array for arm_smmu_invs_purge().
+ *               Must not be greater than @num_invs
+ * @rwlock: optional rwlock to fench ATS operations
+ * @has_ats: flag if the array contains an INV_TYPE_ATS or INV_TYPE_ATS_FULL
+ * @rcu: rcu head for kfree_rcu()
+ * @inv: flexible invalidation array
+ *
+ * The arm_smmu_invs is an RCU data structure. During a ->attach_dev callback,
+ * arm_smmu_invs_merge(), arm_smmu_invs_unref() and arm_smmu_invs_purge() will
+ * be used to allocate a new copy of an old array for addition and deletion in
+ * the old domain's and new domain's invs arrays.
+ *
+ * The arm_smmu_invs_unref() mutates a given array, by internally reducing the
+ * users counts of some given entries. This exists to support a no-fail routine
+ * like attaching to an IOMMU_DOMAIN_BLOCKED. And it could pair with a followup
+ * arm_smmu_invs_purge() call to generate a new clean array.
+ *
+ * Concurrent invalidation thread will push every invalidation described in the
+ * array into the command queue for each invalidation event. It is designed like
+ * this to optimize the invalidation fast path by avoiding locks.
+ *
+ * A domain can be shared across SMMU instances. When an instance gets removed,
+ * it would delete all the entries that belong to that SMMU instance. Then, a
+ * synchronize_rcu() would have to be called to sync the array, to prevent any
+ * concurrent invalidation thread accessing the old array from issuing commands
+ * to the command queue of a removed SMMU instance.
+ */
+struct arm_smmu_invs {
+	size_t max_invs;
+	size_t num_invs;
+	size_t num_trashes;
+	rwlock_t rwlock;
+	bool has_ats;
+	struct rcu_head rcu;
+	struct arm_smmu_inv inv[] __counted_by(max_invs);
+};
+
+static inline struct arm_smmu_invs *arm_smmu_invs_alloc(size_t num_invs)
+{
+	struct arm_smmu_invs *new_invs;
+
+	new_invs = kzalloc(struct_size(new_invs, inv, num_invs), GFP_KERNEL);
+	if (!new_invs)
+		return NULL;
+	new_invs->max_invs = num_invs;
+	new_invs->num_invs = num_invs;
+	rwlock_init(&new_invs->rwlock);
+	return new_invs;
+}
+
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
 	struct iopf_queue		*iopf;
@@ -875,6 +962,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
+	struct arm_smmu_invs __rcu	*invs;
+
 	/* List of struct arm_smmu_master_domain */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
@@ -923,6 +1012,13 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			  struct arm_smmu_master *master, struct mm_struct *mm,
 			  u16 asid);
+
+struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
+					  struct arm_smmu_invs *to_merge);
+void arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			 struct arm_smmu_invs *to_unref,
+			 void (*free_fn)(struct arm_smmu_inv *inv));
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs);
 #endif
 
 struct arm_smmu_master_domain {
@@ -956,6 +1052,8 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
+	/* No concurrency with invalidation is possible at this point */
+	kfree(rcu_dereference_protected(smmu_domain->invs, true));
 	kfree(smmu_domain);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd3798..238bfd328b5b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -567,6 +567,97 @@ static void arm_smmu_v3_write_cd_test_sva_release(struct kunit *test)
 						      NUM_EXPECTED_SYNCS(2));
 }
 
+static void arm_smmu_v3_invs_test_verify(struct kunit *test,
+					 struct arm_smmu_invs *invs, int num,
+					 const int *ids, const int *users)
+{
+	KUNIT_EXPECT_EQ(test, invs->num_invs, num);
+	while (num--) {
+		KUNIT_EXPECT_EQ(test, invs->inv[num].id, ids[num]);
+		KUNIT_EXPECT_EQ(test, refcount_read(&invs->inv[num].users),
+				users[num]);
+	}
+}
+
+static struct arm_smmu_invs invs1 = {
+	.num_invs = 3,
+	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, },
+		 { .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
+		 { .type = INV_TYPE_ATS, .id = 3, }, },
+};
+
+static struct arm_smmu_invs invs2 = {
+	.num_invs = 3,
+	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
+		 { .type = INV_TYPE_ATS, .id = 4, },
+		 { .type = INV_TYPE_ATS, .id = 5, }, },
+};
+
+static struct arm_smmu_invs invs3 = {
+	.num_invs = 3,
+	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
+		 { .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
+		 { .type = INV_TYPE_ATS, .id = 6, }, },
+};
+
+static void arm_smmu_v3_invs_test(struct kunit *test)
+{
+	const int results1[2][3] = { { 1, 1, 3, }, { 1, 1, 1, }, };
+	const int results2[2][5] = { { 1, 1, 3, 4, 5, }, { 2, 1, 1, 1, 1, }, };
+	const int results3[2][3] = { { 1, 1, 3, }, { 1, 1, 1, }, };
+	const int results4[2][5] = { { 1, 1, 3, 5, 6, }, { 2, 1, 1, 1, 1, }, };
+	const int results5[2][5] = { { 1, 1, 3, 5, 6, }, { 1, 0, 0, 1, 1, }, };
+	const int results6[2][3] = { { 1, 5, 6, }, { 1, 1, 1, }, };
+	struct arm_smmu_invs *test_a, *test_b;
+
+	/* New array */
+	test_a = arm_smmu_invs_alloc(0);
+	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
+
+	/* Test1: merge invs1 (new array) */
+	test_b = arm_smmu_invs_merge(test_a, &invs1);
+	kfree(test_a);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results1[0]),
+				     results1[0], results1[1]);
+
+	/* Test2: merge invs2 (new array) */
+	test_a = arm_smmu_invs_merge(test_b, &invs2);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results2[0]),
+				     results2[0], results2[1]);
+
+	/* Test3: unref invs2 (same array) */
+	arm_smmu_invs_unref(test_a, &invs2, NULL);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results3[0]),
+				     results3[0], results3[1]);
+	KUNIT_EXPECT_EQ(test, test_a->num_trashes, 0);
+
+	/* Test4: merge invs3 (new array) */
+	test_b = arm_smmu_invs_merge(test_a, &invs3);
+	kfree(test_a);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results4[0]),
+				     results4[0], results4[1]);
+
+	/* Test5: unref invs1 (same array) */
+	arm_smmu_invs_unref(test_b, &invs1, NULL);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results5[0]),
+				     results5[0], results5[1]);
+	KUNIT_EXPECT_EQ(test, test_b->num_trashes, 2);
+
+	/* Test6: purge test_b (new array) */
+	test_a = arm_smmu_invs_purge(test_b);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results6[0]),
+				     results6[0], results6[1]);
+
+	/* Test7: unref invs3 (same array) */
+	arm_smmu_invs_unref(test_a, &invs3, NULL);
+	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
+	KUNIT_EXPECT_EQ(test, test_a->num_trashes, 0);
+
+	kfree(test_a);
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
@@ -590,6 +681,7 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
+	KUNIT_CASE(arm_smmu_v3_invs_test),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e9759e8af0c0..39e89176fa87 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/sort.h>
 #include <linux/string_choices.h>
 #include <kunit/visibility.h>
 #include <uapi/linux/iommufd.h>
@@ -1015,6 +1016,255 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 */
 }
 
+/* Invalidation array manipulation functions */
+static inline struct arm_smmu_inv *
+arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
+{
+	while (true) {
+		if (next >= invs->num_invs) {
+			*idx = next;
+			return NULL;
+		}
+		if (!refcount_read(&invs->inv[next].users)) {
+			next++;
+			continue;
+		}
+		*idx = next;
+		return &invs->inv[next];
+	}
+}
+
+/**
+ * arm_smmu_invs_for_each_entry - Iterate over all non-trash entries in invs
+ * @invs: the base invalidation array
+ * @idx: a stack variable of 'size_t', to store the array index
+ * @cur: a stack variable of 'struct arm_smmu_inv *'
+ */
+#define arm_smmu_invs_for_each_entry(invs, idx, cur)                           \
+	for (cur = arm_smmu_invs_iter_next(invs, 0, &(idx)); cur;              \
+	     cur = arm_smmu_invs_iter_next(invs, idx + 1, &(idx)))
+
+static int arm_smmu_inv_cmp(const struct arm_smmu_inv *inv_l,
+			    const struct arm_smmu_inv *inv_r)
+{
+	if (inv_l->smmu != inv_r->smmu)
+		return cmp_int((uintptr_t)inv_l->smmu, (uintptr_t)inv_r->smmu);
+	if (inv_l->type != inv_r->type)
+		return cmp_int(inv_l->type, inv_r->type);
+	return cmp_int(inv_l->id, inv_r->id);
+}
+
+static inline int arm_smmu_invs_iter_next_cmp(struct arm_smmu_invs *invs_l,
+					      size_t next_l, size_t *idx_l,
+					      struct arm_smmu_invs *invs_r,
+					      size_t next_r, size_t *idx_r)
+{
+	struct arm_smmu_inv *cur_l =
+		arm_smmu_invs_iter_next(invs_l, next_l, idx_l);
+
+	/*
+	 * We have to update the idx_r manually, because the invs_r cannot call
+	 * arm_smmu_invs_iter_next() as the invs_r never sets any users counter.
+	 */
+	*idx_r = next_r;
+
+	/*
+	 * Compare of two sorted arrays items. If one side is past the end of
+	 * the array, return the other side to let it run out the iteration.
+	 *
+	 * If the left entry is empty, return 1 to pick the right entry.
+	 * If the right entry is empty, return -1 to pick the left entry.
+	 */
+	if (!cur_l)
+		return 1;
+	if (next_r >= invs_r->num_invs)
+		return -1;
+	return arm_smmu_inv_cmp(cur_l, &invs_r->inv[next_r]);
+}
+
+/**
+ * arm_smmu_invs_for_each_entry - Iterate over two sorted arrays computing for
+ *                                arm_smmu_invs_merge() or arm_smmu_invs_unref()
+ * @invs_l: the base invalidation array
+ * @idx_l: a stack variable of 'size_t', to store the base array index
+ * @invs_r: the build_invs array as to_merge or to_unref
+ * @idx_r: a stack variable of 'size_t', to store the build_invs index
+ * @cmp: a stack variable of 'int', to store return value (-1, 0, or 1)
+ */
+#define arm_smmu_invs_for_each_cmp(invs_l, idx_l, invs_r, idx_r, cmp)          \
+	for (idx_l = idx_r = 0,                                                \
+	     cmp = arm_smmu_invs_iter_next_cmp(invs_l, 0, &(idx_l),            \
+					       invs_r, 0, &(idx_r));           \
+	     idx_l < invs_l->num_invs || idx_r < invs_r->num_invs;             \
+	     cmp = arm_smmu_invs_iter_next_cmp(                                \
+		     invs_l, idx_l + (cmp <= 0 ? 1 : 0), &(idx_l),             \
+		     invs_r, idx_r + (cmp >= 0 ? 1 : 0), &(idx_r)))
+
+/**
+ * arm_smmu_invs_merge() - Merge @to_merge into @invs and generate a new array
+ * @invs: the base invalidation array
+ * @to_merge: an array of invlidations to merge
+ *
+ * Return: a newly allocated array on success, or ERR_PTR
+ *
+ * This function must be locked and serialized with arm_smmu_invs_unref() and
+ * arm_smmu_invs_purge(), but do not lockdep on any lock for KUNIT test.
+ *
+ * Both @invs and @to_merge must be sorted, to ensure the returned array will be
+ * sorted as well.
+ *
+ * Caller is resposible for freeing the @invs and the returned new one.
+ *
+ * Entries marked as trash will be purged in the returned array.
+ */
+VISIBLE_IF_KUNIT
+struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
+					  struct arm_smmu_invs *to_merge)
+{
+	struct arm_smmu_invs *new_invs;
+	struct arm_smmu_inv *new;
+	size_t num_invs = 0;
+	size_t i, j;
+	int cmp;
+
+	arm_smmu_invs_for_each_cmp(invs, i, to_merge, j, cmp)
+		num_invs++;
+
+	new_invs = arm_smmu_invs_alloc(num_invs);
+	if (!new_invs)
+		return ERR_PTR(-ENOMEM);
+
+	new = new_invs->inv;
+	arm_smmu_invs_for_each_cmp(invs, i, to_merge, j, cmp) {
+		if (cmp < 0) {
+			*new = invs->inv[i];
+		} else if (cmp == 0) {
+			*new = invs->inv[i];
+			refcount_inc(&new->users);
+		} else {
+			*new = to_merge->inv[j];
+			refcount_set(&new->users, 1);
+		}
+
+		/*
+		 * Check that the new array is sorted. This also validates that
+		 * to_merge is sorted.
+		 */
+		if (new != new_invs->inv)
+			WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);
+		if (arm_smmu_inv_is_ats(new))
+			new_invs->has_ats = true;
+		new++;
+	}
+
+	WARN_ON(new != new_invs->inv + new_invs->num_invs);
+
+	return new_invs;
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_merge);
+
+/**
+ * arm_smmu_invs_unref() - Find in @invs for all entries in @to_unref, decrease
+ *                         the user counts without deletions
+ * @invs: the base invalidation array
+ * @to_unref: an array of invlidations to decrease their user counts
+ * @free_fn: A callback function to invoke, when an entry's user count reduces
+ *           to 0
+ *
+ * Return: the number of trash entries in the array, for arm_smmu_invs_purge()
+ *
+ * This function will not fail. Any entry with users=0 will be marked as trash.
+ * All tailing trash entries in the array will be dropped. And the size of the
+ * array will be trimmed properly. All trash entries in-between will remain in
+ * the @invs until being completely deleted by the next arm_smmu_invs_merge()
+ * or an arm_smmu_invs_purge() function call.
+ *
+ * This function must be locked and serialized with arm_smmu_invs_merge() and
+ * arm_smmu_invs_purge(), but do not lockdep on any mutex for KUNIT test.
+ *
+ * Note that the final @invs->num_invs might not reflect the actual number of
+ * invalidations due to trash entries. Any reader should take the read lock to
+ * iterate each entry and check its users counter till the last entry.
+ */
+VISIBLE_IF_KUNIT
+void arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			 struct arm_smmu_invs *to_unref,
+			 void (*free_fn)(struct arm_smmu_inv *inv))
+{
+	unsigned long flags;
+	size_t num_invs = 0;
+	size_t i, j;
+	int cmp;
+
+	arm_smmu_invs_for_each_cmp(invs, i, to_unref, j, cmp) {
+		if (cmp < 0) {
+			/* not found in to_unref, leave alone */
+			num_invs = i + 1;
+		} else if (cmp == 0) {
+			/* same item */
+			if (!refcount_dec_and_test(&invs->inv[i].users)) {
+				num_invs = i + 1;
+				continue;
+			}
+
+			/* KUNIT test doesn't pass in a free_fn */
+			if (free_fn)
+				free_fn(&invs->inv[i]);
+			invs->num_trashes++;
+		} else {
+			/* item in to_unref is not in invs or already a trash */
+			WARN_ON(true);
+		}
+	}
+
+	/* Exclude any tailing trash */
+	invs->num_trashes -= invs->num_invs - num_invs;
+
+	/* The lock is required to fence concurrent ATS operations. */
+	write_lock_irqsave(&invs->rwlock, flags);
+	WRITE_ONCE(invs->num_invs, num_invs); /* Remove tailing trash entries */
+	write_unlock_irqrestore(&invs->rwlock, flags);
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
+
+/**
+ * arm_smmu_invs_purge() - Purge all the trash entries in the @invs
+ * @invs: the base invalidation array
+ *
+ * Return: a newly allocated array on success removing all the trash entries, or
+ *         NULL if there is no trash entry in the array or there is a bug
+ *
+ * This function must be locked and serialized with arm_smmu_invs_merge() and
+ * arm_smmu_invs_unref(), but do not lockdep on any lock for KUNIT test.
+ *
+ * Caller is resposible for freeing the @invs and the returned new one.
+ */
+VISIBLE_IF_KUNIT
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs)
+{
+	struct arm_smmu_invs *new_invs;
+	struct arm_smmu_inv *inv;
+	size_t i, num_invs = 0;
+
+	if (WARN_ON(invs->num_invs < invs->num_trashes))
+		return NULL;
+	if (!invs->num_invs || !invs->num_trashes)
+		return NULL;
+
+	new_invs = arm_smmu_invs_alloc(invs->num_invs - invs->num_trashes);
+	if (!new_invs)
+		return ERR_PTR(-ENOMEM);
+
+	arm_smmu_invs_for_each_entry(invs, i, inv) {
+		new_invs->inv[num_invs] = *inv;
+		num_invs++;
+	}
+
+	WARN_ON(num_invs != new_invs->num_invs);
+	return new_invs;
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
+
 /* Context descriptor manipulation functions */
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
@@ -2462,13 +2712,21 @@ static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
 struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_invs *new_invs;
 
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
 		return ERR_PTR(-ENOMEM);
 
+	new_invs = arm_smmu_invs_alloc(0);
+	if (!new_invs) {
+		kfree(smmu_domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
+	rcu_assign_pointer(smmu_domain->invs, new_invs);
 
 	return smmu_domain;
 }
-- 
2.43.0

