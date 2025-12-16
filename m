Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7C2E36F8
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851033; cv=fail; b=j9wq1uKOkOB9HAO6oi8PZu5chjP6GGUAuP5I9lvjq4f64EbRD+U7YM655Cu/coSANw2+VFEP38Iv07BAiFwCFhJIgxabKgRhy3TVJZHpCPpkAvfXNsuwi5UBkqvUk/l13tBINCx5vRVVJx6Gsn1aETSkj4OV+liABy2vwP9hiwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851033; c=relaxed/simple;
	bh=z1uWgRV6wODgfCIKg0xuI0OWi6m1qlzNbQDhlTWFfOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0TcDQ6oDQd4XM2UwIv0eetZ00y40DhluwznY6ChGp3bjlfykaMoDRKi7FHc9wILIdVP9yS0cuKWnOENCY4CJc/tZrzL8FdDMHUdaFwD1sFN5ADP1RVn+ZfDvGlQf97V2ZQP7dDvCIE+TU0ylvFcFDBZpgFMnaY1s1D8vF6ci4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqTsDtjg; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqTsDtjg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keaE9UXFLCdl6krFcHMSf99YHuN8iUUpHbT5uDI6gbmMjmcTlUgo3A2JuYJehhvt/yyoOf9MogTe0VNAW+byjni31TmUbYbqVMw4Fdo4tkAFJHtenQi8w/UDZxDntvkvsVjHIxS1fDHnpNAAipy4M2GeMP5kNC2hyFUOnqU6KJfbri3zWuTLr8mby5scAiI1z4oefDU39j4q/ixPB5fsOegn7u0XjBpF9y15RKGPYpM85S7NZj3UKjtB1QOTeskz7KtCst9qF71GT4SEI0shDWhC69jF/QCMPeAuRuZcsBj2ho/keBXoi71QOIr4qyNkjT6xZl7QA8UeKBePWE0rSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lvgrdxg/5X3hsQ9h7dD5jRV1bxEhN49hDG5PVPmMW6w=;
 b=aNMW3UHSEdd/FimzXZZ2gPZsHcs0adxZiOWPfvC4NSRWN12DmWHSjZlHurUr3Mg5qefOBYMIft1o4DxLpFLbiRQv9bGewJDEctC71F6kJjbRjEq7FS8nj5FBpTDAKjNzEI5F7f3XQRPkDrvYp97vr0OPsGYFpHU1wtYbWbFUlTHbVxx+3PwL3AUSjydeh6oFE+t7nFYFZB8UNTS1YI0Q8Y7jSuRQhJwjqRIwOq7+UKQstti6bqvK5bTQTjyFPVtO6if4YPs++53fNPMplu0fbgKDnBvcDmAPHusq5n7kIiHLzSbP/I+H25l8A51njD9oogS6imto/fsUs9S+wHDwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvgrdxg/5X3hsQ9h7dD5jRV1bxEhN49hDG5PVPmMW6w=;
 b=FqTsDtjggxeQfq+QW+U5UVTfXI63d7gIM3FAg8zMHQpRxS1Fhw2t6wx6yDcOmx+RBEY7ewcn0exxwM8Tu7UHuv0txmNrwDLa2vPNbur6agSvc8axcRZOqFdenJn+6dVdv8qv2XQ+mNVnhPN/JLn3BH+54NcO3Z5933Nv+KohU+PLG5OluQlqBYVl3vfYFtppYMvOiwoySDq62ZtXTejKOjrH4bJbKnQqMoNxAkqPfudwyH8PbZC30eJM0NEJwj2tA4blSZqZqyWZSNbUqiLlb0fY3fsbFRkTNfI5povB3x92fSx1YFwQV/kfsNNfUl3qJybIt5ZVkJl/8WWFIFZc9w==
Received: from PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::14)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 02:10:16 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::f) by PH5P220CA0009.outlook.office365.com
 (2603:10b6:510:34a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 02:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 02:10:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:04 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 18:10:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 18:10:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
Date: Mon, 15 Dec 2025 18:09:32 -0800
Message-ID: <542ff2578f7c808daae8e7044ef1bbcada16ba53.1765850465.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765850465.git.nicolinc@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 9203fd27-e902-4882-12da-08de3c48409d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b1QssHTfqCrU7PbZs9eT/r29Qp3gu670ksj5QuIY3A86ZS6E7iUjesMV3ka5?=
 =?us-ascii?Q?Sf3ugY9urde3EXdPmK+gvENP18dQL8HeCNE5wyDlrqdf9wr+bFI16KmG/Z2z?=
 =?us-ascii?Q?9YdhHDYhQhvz46KQpERSGf/kT9z6LtoDSMz0TqdZO9ed+698HgL0Cij7+w5d?=
 =?us-ascii?Q?ZhOPf1sjJowih+EpbKlY3ZTo9w3/VjOgJYS4cD1kclvcGXADLx+L31tDG8TX?=
 =?us-ascii?Q?3HkN9n/31+158NVnAUMZ6DhZZ3pcYuuK8PgmFMqErmJb8/KJhJeeRdWy4kUe?=
 =?us-ascii?Q?wSafo4vOBvxM+cEPG1uYi8ZEOx1WNm9BMGRN8SSHF6XvB1U7slTvNvN6f3MY?=
 =?us-ascii?Q?+8vqgSqBFLDc6N4av+tEsz/VZMlxvXbHO9WeY+yHrS7pHHJJb3aPHaktwsCo?=
 =?us-ascii?Q?4fJ1bV5o5bbnSl0DWY2USHLfLRo0+QHV/VpOGWtLXhMJKSiaOkGbXdUARWw4?=
 =?us-ascii?Q?71RqH1p88A9ETVxEhf8LDrlSUk4KIrJw9MWTcYsE8zqKIjaZYibRRWs6ufMc?=
 =?us-ascii?Q?NSiXlFSQkD2dnw6xoT/K12bXll808WyKOojt46SZ38uy72jqFILOHenCB2Lw?=
 =?us-ascii?Q?IcRSzI6yf7480Cb1knM/uDf74xnl5FcSsEkVKd8IsU29vEKtY2wGSoXUOqNg?=
 =?us-ascii?Q?djnb9c65aK1O7anVdrVFUIzRprvBXHISaYR4AziZGsBtRXpZbyzXGxpf+lqC?=
 =?us-ascii?Q?ApDeCTmPjFSNWv28omXwdWEnqAD9OVoi5I6aQLEDcddHvKRscDEtPVqKnAII?=
 =?us-ascii?Q?0IHUErNP2EMTwOVQHZatF3okUEK30vMaU5EuR1cQGiXGAz4iBFO3KMZ6VAZC?=
 =?us-ascii?Q?ryEToxylrxdR9zONFuPtz2pJtXIDg6yrFogfsoBJCBjrX1FZz45Zcvsb9BIS?=
 =?us-ascii?Q?/3zagmtIqw62AEWox/9XIRLjXmRtMaGEtCizdJ5LDPBFpew9g5UV4DguTjm6?=
 =?us-ascii?Q?9jEe2RP7/D2tjXANY+vY7zI8EOLyk3hVIDxQt91BbtFSYVMJ6e9jFBsZSQx+?=
 =?us-ascii?Q?pxqkM67NvnBm8d52DfqWGdjiqeWrxV97vh8FizY28vu1weWXqbjvF9dnZhjy?=
 =?us-ascii?Q?wHVaC9fI0jJrrnlcY+I465xx6fv9ASmzxmqkIa8aj4YAEAF3D9+6NSuByoel?=
 =?us-ascii?Q?b2QmwtDP2OTKfY9mXIYbJ+oyiX/Az2DNQMAqsxQNtoj4L/ZSt9J4TdWUZr6e?=
 =?us-ascii?Q?NQLjhElm1SSBFtPlFFauPAtWQOnt+xmjYTCYOW7sor4s56jtBe9IzkQ4boYP?=
 =?us-ascii?Q?nAQnZG2HJTjNZfBuRf3kSloAPKG2ZbQTheRePKiGMK0AH6qEW0WgwAkTVIpA?=
 =?us-ascii?Q?03saFrISpIfmzL+3U4d7JhA1UmqY2lk+YxfGJXpBjc+aUtHUIyQyjF973PTE?=
 =?us-ascii?Q?0mv06g6Atq5IkJhxwqSc0lCMEquDDqDWeatMRPqFKWMhTOyHWFnjJTc4shSc?=
 =?us-ascii?Q?5a9IFKRtsDahWXq0XfAID6AVVMZ2N939X9KwalytCd7oNEuLYgOEgorCR5WD?=
 =?us-ascii?Q?e1ojby18vO9F7cLsmD/lK+cfVxWPprzUMGNdqviHhoyaa2beXsJzXoKYpXhk?=
 =?us-ascii?Q?MXxMzT8JwywSzqQJmFw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 02:10:15.1435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9203fd27-e902-4882-12da-08de3c48409d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

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

