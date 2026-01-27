Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EE328B71
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540141; cv=fail; b=s54xxefEJHGcmpxe9EGXbL8nw3bIXH0QMhXouMzQfzHQS4/E5YsQ6TG65F69ea9276f3lmvLKjo7pFLGXAA2RWk9kiMiJLDnzXHxzfln+LWiFfhgUiQswWnmUI9Ev74hU+OF2LbAwXcYhvhU/DiLVQtWYdpg0e72Ew8uT9WeL+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540141; c=relaxed/simple;
	bh=vOlZdLUj3TXtopVT8LrKMgTt2Mx8SgUWC5Gxjp4IFAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7mroDJEpPe6dBCWcA2/qNIUJEw5+tn7OVqqzDE3oQ8A8F/HGO2EFTIC6jZhbVR6MDurlnWN+Vck80eWShmcZyvAsekLn8bPNyReI+DB2Wy1sf04tt4c/oHMjP+VznOGrG79S40s1+rumHNBHR8BBBKfglU1x92PjLKBUobmiTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rPiZ97N+; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rPiZ97N+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPMen6O2XJgwTpX+8O682xn1wI2kIozQ6YqBNmnU5FIxA8HLgIS3wKkfhNen1XAQVR6y+8gxMPI0hpvtDsDzDiOxWQo+0dpXTVo+4d7PlePgCF+bKZnDIbUyRu4FgMsVKy53B9wuTPw0beloaZtCS2KRlJDjaYcAzqTaUQpKGjIREdffMSKSWWhbc70COFmR0syIDGue0VVM4Jp7cFH9+c5U1vTmpp0yRiURiQY+2ZpIjMDj1WwGE4BDi9GbXayXSNqbbWj+RX9UB3puoQ7LKi5mayxVvL5Y/eptBGWvzDFzLOEWbUkXLCkZQlIXvJtxpbTpo/TmDdlc/+Dsrzf02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpdF2YjpOzQANOUp/YBZ2XUg6x/g/giQ0hrK3lELJ8U=;
 b=aDz+/FF9QmVNK5247bvezB/su6O1mxSGT0aRd1gKLwipEsDsG1FLJcSUj0MyLK/EznTSzWcKeiSwHW15AnhlPLl3zZiY+KaKfjt00SYEW/r9YcgPSlDoPoVU2OISUVjbtyV8ShNs3QHF+t7nhSXQaCQCh4qeIQLc2CGMdLdv4RRReV9/T7tCFRe+KFxXm7g8TXuikg1+S2csboYsb9FOTJWcvEEaAblfKN3wsWfizlmB3iuUXGQUrOsTpXJfV7V3FOdYnEbWek/9IGFTdvmyTNijj3z0bPOzGqGyF0uDAAejyJH+b010b4cVuQNP0DVjfq6SLL2nP/4rgRMtO21OOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpdF2YjpOzQANOUp/YBZ2XUg6x/g/giQ0hrK3lELJ8U=;
 b=rPiZ97N+no/o+tGyzoieCo6DUq5sI4cfhyMOBJv505PnZJYNfplX7Nj7eB9Zs1tNZLZaPWjQf4RMwmoJ2HbfDuQDhh5ddE40mXcPtQYSSLBqRTSeeAhJ1EPHOwIJhe3MaA8mQiX3OgG+OO2dSntbRnpA1oiMN5n3LAKq4bAO4x/2ddYh5X5KXNS8zeByTTwrYsENRcgPQDPybFteRB09VMesEM+b7zm+VGdu5sDF65c7hnKUyz3JONmsuFEgUjXJjDele/YOsaLF8b2UDMzhaz0cnCUA8GPpuXso1YDlVzB3dO0tXubeSPa9BFjWmj/bbh3wCAX+N2hkylOd2niZUg==
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:55:29 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::5a) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:55:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:09 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:55:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 4/8] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
Date: Tue, 27 Jan 2026 10:54:56 -0800
Message-ID: <2aa5e516f9e22be2c96d1d5b69252011210da5e8.1769539310.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769539310.git.nicolinc@nvidia.com>
References: <cover.1769539310.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: dd631def-e45a-475b-40e0-08de5dd5a3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sGi+QnhlPI4ESMYzco/CUNHnrOZG/xAnZiqESmS00oR26Z5LRuO4mTRx8yuA?=
 =?us-ascii?Q?HqswsX5BJQMFAvj2Ck6RsT5dxjFur5xCb3gdOtDp/Mr1peIJXRvDG0dSpG42?=
 =?us-ascii?Q?f0BtOt06PZwAZ3Jcfanxje7jJ5OAk+ksK9QqRhWBJSbxYNzrvsp7IeZtRy6n?=
 =?us-ascii?Q?sw0xeXexve+LsNlLmvTweKDYMdCJvpYWrAoDEuLlBhsBpgF0AhJU/IpWFKCo?=
 =?us-ascii?Q?TutzT01dIomLfRkzgL7X56kCbmntv4xY6pn6Jc50zIwG0rOWmOgFkr2fMH3W?=
 =?us-ascii?Q?/rRAwDPD6jJuO2oudj7c00sZVCoBs8IbI9LsahK0osrpXBFgy83MYoo8AMHA?=
 =?us-ascii?Q?ov4lc3pVGXaFgU3vXRvgi5qlxxJfiFj7AHN5xDYcn9aiIJq04AFssbd+Snva?=
 =?us-ascii?Q?lZ277Bl/d5FSVt66MPBHx1TFji4s+o/s/71alTRj1D6kIYkilD+wRZCWlAdK?=
 =?us-ascii?Q?cnXWao/KkXmwKlGHPpuxgetUqovLw7OPJCARcPfESMButkAOmPpBYpkukty1?=
 =?us-ascii?Q?OOnHX+tgUHZwwJ15klPdbuQQj8EoSPVfU0I0gYaTNlGhnqF4NWad76GInGB1?=
 =?us-ascii?Q?VS2vIokETl1kTUnJyRdKcougo6bdIl1EK/JjCN1if8Duso8PHhl+m14rOgUi?=
 =?us-ascii?Q?mL6wh+Kaa6G0bGcy4Sl+yQKrU+bipykHrvnawQcTj8GYBWWZO26dFo7IrWGc?=
 =?us-ascii?Q?lLqNpt7tqKPaaIiG/kgED+PkzLr1jSFVEKiDuS0EjhhDpTq7b/mOEcL9BWe3?=
 =?us-ascii?Q?GULYj6g56uDK1CkxBXHxSAuaXHqqhoy02EyrArAjnvMiHUOdNxOzwQsn9odn?=
 =?us-ascii?Q?6SsWKKqUwjuiwfVLqPY6Fwxf3I1s5EJDq6bsE2cR33I15/GnuP2e8byuXrB6?=
 =?us-ascii?Q?qtPeBsoIcZv8p17XTv0Z0gYWajaET5xo+s8vQPBRjmofpbi3x+cNgfhFZTUy?=
 =?us-ascii?Q?HPB7jZWc9+WOyYcWVYLwc+Ntso96baGIp5Qssqw8w8UEP7YDoY7Zo8KM6kzp?=
 =?us-ascii?Q?B60OAlQYAN4YQDHG6nHdBq0LXHClYSZfuMywqZNxkBbcvq9yySrdMQ3POf1c?=
 =?us-ascii?Q?JjsHNypYs9DmGeZlvEzBsgaoEivD0NGMXq1bPfe/yxxQsRNDonjjs0gGNSff?=
 =?us-ascii?Q?XGRalDAsvw9LTVVlQ3j9PcKpzRKaCLU+wsa579btWAKvxlsoaZQGp83mMsQ/?=
 =?us-ascii?Q?qDmiqG0unry209T4Q8hMCaY3t3sfv39H5SN8Uw9fV9fe+H7pXYZLPypUbiaa?=
 =?us-ascii?Q?LkLbXQU6QzEs+EGrgFrmuUZtPoqVrc/vV2FOGw7rBJprFZbJGJpIwmQsLjQq?=
 =?us-ascii?Q?UGUHHAhTzvzCAk7wrWFMSe+BM0TBd6v2OWFusbnJBdD+wAWpLDKOnGoHVU+0?=
 =?us-ascii?Q?6fempFCkcDvhj2XcwrdRKz7M3wctUCBacRSugjBnKXuJP7c1JFw2eo5TCo8O?=
 =?us-ascii?Q?WaVGcCzW2hbjXI7WUH6xFksqe695BhHdZV7z9fle+1Dv9ZHBRj+Ia86ntaeJ?=
 =?us-ascii?Q?zC++buAjr56eSehs7NGx6acbq/81oBA7iy/KN3R5AjqumVRdmE+1eNlhCnwd?=
 =?us-ascii?Q?uoaHAxA2770WdhDiCh4Dh4hMUTbu40Cn8zwM7dGJ7mcnZribw+MsIkOMmRTy?=
 =?us-ascii?Q?p/Veo6snDUroj53c4CYX0UqIl44y0JsWkr2NHUjEwtdpjoioXAbgEmSMzZiI?=
 =?us-ascii?Q?rnMAxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:55:29.0904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd631def-e45a-475b-40e0-08de5dd5a3d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058

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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  97 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 265 ++++++++++++++++++
 3 files changed, 454 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cfbedb76c8ba..ed8820f12ba3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -648,6 +648,93 @@ struct arm_smmu_cmdq_batch {
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
+	int users; /* users=0 to mark as a trash to be purged */
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
@@ -873,6 +960,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
+	struct arm_smmu_invs __rcu	*invs;
+
 	/* List of struct arm_smmu_master_domain */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
@@ -925,6 +1014,12 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			  struct arm_smmu_master *master, struct mm_struct *mm,
 			  u16 asid);
+
+struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
+					  struct arm_smmu_invs *to_merge);
+void arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			 struct arm_smmu_invs *to_unref);
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs);
 #endif
 
 struct arm_smmu_master_domain {
@@ -958,6 +1053,8 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
+	/* No concurrency with invalidation is possible at this point */
+	kfree(rcu_dereference_protected(smmu_domain->invs, true));
 	kfree(smmu_domain);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 69c9ef441fc1..7b8035b1db24 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -637,6 +637,97 @@ static void arm_smmu_v3_write_cd_test_sva_release(struct kunit *test)
 						      NUM_EXPECTED_SYNCS(2));
 }
 
+static void arm_smmu_v3_invs_test_verify(struct kunit *test,
+					 struct arm_smmu_invs *invs,
+					 int num_invs, const int num_trashes,
+					 const int *ids, const int *users)
+{
+	KUNIT_EXPECT_EQ(test, invs->num_invs, num_invs);
+	KUNIT_EXPECT_EQ(test, invs->num_trashes, num_trashes);
+	while (num_invs--) {
+		KUNIT_EXPECT_EQ(test, invs->inv[num_invs].id, ids[num_invs]);
+		KUNIT_EXPECT_EQ(test, READ_ONCE(invs->inv[num_invs].users),
+				users[num_invs]);
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
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results1[0]), 0,
+				     results1[0], results1[1]);
+
+	/* Test2: merge invs2 (new array) */
+	test_a = arm_smmu_invs_merge(test_b, &invs2);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results2[0]), 0,
+				     results2[0], results2[1]);
+
+	/* Test3: unref invs2 (same array) */
+	arm_smmu_invs_unref(test_a, &invs2);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results3[0]), 0,
+				     results3[0], results3[1]);
+
+	/* Test4: merge invs3 (new array) */
+	test_b = arm_smmu_invs_merge(test_a, &invs3);
+	kfree(test_a);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results4[0]), 0,
+				     results4[0], results4[1]);
+
+	/* Test5: unref invs1 (same array) */
+	arm_smmu_invs_unref(test_b, &invs1);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results5[0]), 2,
+				     results5[0], results5[1]);
+
+	/* Test6: purge test_b (new array) */
+	test_a = arm_smmu_invs_purge(test_b);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results6[0]), 0,
+				     results6[0], results6[1]);
+
+	/* Test7: unref invs3 (same array) */
+	arm_smmu_invs_unref(test_a, &invs3);
+	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
+	KUNIT_EXPECT_EQ(test, test_a->num_trashes, 0);
+
+	kfree(test_a);
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
@@ -662,6 +753,7 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
+	KUNIT_CASE(arm_smmu_v3_invs_test),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6beffa8e7c74..3f270c59f018 100644
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
@@ -1026,6 +1027,262 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
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
+		if (!READ_ONCE(invs->inv[next].users)) {
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
+ * arm_smmu_invs_for_each_cmp - Iterate over two sorted arrays computing for
+ *                              arm_smmu_invs_merge() or arm_smmu_invs_unref()
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
+			WRITE_ONCE(new->users, READ_ONCE(new->users) + 1);
+		} else {
+			*new = to_merge->inv[j];
+			WRITE_ONCE(new->users, 1);
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
+ *
+ * Return: the number of trash entries in the array, for arm_smmu_invs_purge()
+ *
+ * This function will not fail. Any entry with users=0 will be marked as trash,
+ * and caller will be notified about the trashed entry via @to_unref by setting
+ * a users=0.
+ *
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
+			 struct arm_smmu_invs *to_unref)
+{
+	unsigned long flags;
+	size_t num_invs = 0;
+	size_t i, j;
+	int cmp;
+
+	arm_smmu_invs_for_each_cmp(invs, i, to_unref, j, cmp) {
+		if (cmp < 0) {
+			/* not found in to_unref, leave alone */
+			WRITE_ONCE(to_unref->inv[j].users, 1);
+			num_invs = i + 1;
+		} else if (cmp == 0) {
+			int users = READ_ONCE(invs->inv[i].users) - 1;
+
+			if (WARN_ON(users < 0))
+				continue;
+
+			/* same item */
+			WRITE_ONCE(invs->inv[i].users, users);
+			if (users) {
+				WRITE_ONCE(to_unref->inv[j].users, 1);
+				num_invs = i + 1;
+				continue;
+			}
+
+			/* Notify the caller about the trash entry */
+			WRITE_ONCE(to_unref->inv[j].users, 0);
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
@@ -2530,13 +2787,21 @@ static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
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

