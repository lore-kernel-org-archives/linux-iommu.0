Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021A23BD05
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589325; cv=fail; b=dblpVYC5YHIzETTaTYwchHNAn5FlcaDaDkgA6umPRz1ICJ2kJey3Iuz0S2QV60k9OvaZW/ht5bBCaPzkmqGA761Am7s4tC2yzv7H2rQX8VV7rGV9PFFBtS09pK73Em5mxTVjdAFOJqJa8Lw6YZeFqXdQr8p17yUvRB22U7hTju8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589325; c=relaxed/simple;
	bh=RuSR8VYXJZkAfLUh0qOOKE00uyvzuipUWcrEFyHzHYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPVDsaWF1if7lR0NH+KtxgCwNJNJCNp1tvq/n/YUL7HclkQzT6iMNUIpQfmV1TS+Vmb50nrx3eiykeFQHqs87wM6ipqIXylLg7s3KImLacTHyo1SjXRusQcRIdWhS5zBWDM7GaxKHfUS1UuLYYbjkXYgsu39EGj24Fmo0MQ+WVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SdcOo+Wm; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SdcOo+Wm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mthpx5J77D7hAPeNLcGN9FQW3BDZfhBcaeqt4LUjPtcfBVU/fGE2n2DgcQHTpIq0agbqZdpgv+EwYiv9hgR+hKoXhAePUSRyg9CTbjljuyMgbuZkz1E1EjDzhtrmqUi9ajz03xeIEH4Qox0COIk6+WMENei6r+ClKYmrw7zV8TCCoBkpY3tuOuamHL6D4tVLvbPMabZjFDmD58ITeUixdd6vgh5GXnOSceWvzcyZsBDV/XK8TNYHQDukspYA/EdE7HUBNMmIKQUEf6seNsMrMjiOOla9hewvlVR0E6MmXzPcj4XfgtwPhL2Frq7fwsTYSSge6tfNyvOgRcTpaKpFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jThY2bIf+npU83qxVYZFlf4ThlbG8Y0f10w5VCXARFw=;
 b=oH9YGQ4GhwZ0SiPBWzbP3ArM22TCE+kk1zoId2YbCvCLpxFf7z4tX+RaVMt79PyDmFK2ChEsdqtRdEO6WEkdkk4k7+eFkhRVxQY99M1OWU3krLBgO4uf5MX1SDcB3byu1+ziWmOMHRMPbTjSegf4LsMxlHxCM2i3ROHaZKEIAqihvhwJXQAky8eFxm2dNdvQZ2qycPs+qlUUTPI+bVnu4QURoDlqHdVi9FNinx549yQG9X5uF8AX1rWzQlW76DGWq+EAl7QRTlmrnciiz+5UXjhyyuGnmO9jD7+jKi63WnckyvGrgSFDekiyMkKfqT7+FOkzt5+fEWM9LdjBVXesAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jThY2bIf+npU83qxVYZFlf4ThlbG8Y0f10w5VCXARFw=;
 b=SdcOo+WmBCG7nCYxpRjYhqmL1WT6yUnp7z91uqBVGpTdv+1w35GDomD6mZKqB9CwJhBkl9oEMnq9MB5ZwKB1Jb4EpZQd+80eUuupAqZf2B7ArxZd5+4zpjnAlLvZay0lXRu5GtufleljSafFH4Mwlk5Clq5DSZd74iZeQFAR5kywTpzyhmSsf3HFY1s3M4BJ/DNK/Z97wpsJnadltd4To8AnLb08T1kfbY9SHOglw+in5eqcSyWH3OVnSgflIGTvtZGFCLT3UgJDmRWNVCMuRqISwNCGuRnTlEPCEEJ0SnX+wJTG0Zp4Tejc8hygIe46pFIv/dRYuE0/otB1bpeLJQ==
Received: from MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 08:08:35 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::39) by MN2PR14CA0002.outlook.office365.com
 (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 08:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 08:08:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:20 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 00:08:19 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
Date: Sat, 8 Nov 2025 00:08:04 -0800
Message-ID: <eea7bffde13574e099212e3b3823a0f192d6aec3.1762588839.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588839.git.nicolinc@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: faaf8171-63df-4f48-b7af-08de1e9e03c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vxMBbYzl6Z2zgnzh3ThaG4hc+7w8lx5eBX71eUpHuFBp6P07mqSVAM5FjljR?=
 =?us-ascii?Q?4niL81Qn+LOwzcK85RhfJuRKMVAudkgPAjz3ilGn6yXDWYQU85MMIQT8Dg59?=
 =?us-ascii?Q?xDZ+iG/p4DnYPap5redrVfSuXAHrByPY96WCOstIRvTBy95Rm7Z/VZD8RK7i?=
 =?us-ascii?Q?aC3ZpcdwSWgx52H640AqRMi9d/ak/6Id1xBRcD72ogiHBCmEsPigrZiXE20n?=
 =?us-ascii?Q?NY893BK1dVv1mhL+xCXT5W0NlBfs+Qc3P9nEHMxmo36CdoF0T87FVplwztYv?=
 =?us-ascii?Q?iWPooVyK+CULGbpnqZ9xj7ZMvv+TOmZQ7zf/ZaOnKPjhTl9KHRqUSQOXVe78?=
 =?us-ascii?Q?kIEunemR+coIAWYOliYyjmM5q55tGsJp5n5TbGEl1jIe4JB1S0ol6QAGiwc4?=
 =?us-ascii?Q?mNC4NIql4ZFy9oWPPy8TEwzARVkWOB2O3Tg1QLdmjxRqex7M+mUfgxhVJkoW?=
 =?us-ascii?Q?hZZ4PEVJC4fK3rdlqGKUiUuiXwVzTGLBRqhHIC15R3fEBDWvL2kqUiiUzfWv?=
 =?us-ascii?Q?zdGN/ZVwptgbgOtkiHd2qMIg45caWPYpvfvaDleazEcn9pAiRojlriDrEXel?=
 =?us-ascii?Q?R0kxNc+e9mveMVkXA/1yh5wfKonvSAoRgVLI8+t711z+32uTw/NQo+OfXGoz?=
 =?us-ascii?Q?EvIoETbPmDaeHgyBU2AXw5nDnrVwuFjEwWtIZyxX8pKxuLB1pZSvtC+GMFpz?=
 =?us-ascii?Q?LONNdg5qDjOpCG5BPjSD95WWSBiooOdExrxqVZfr76qTPjZftkcRhxtFWweH?=
 =?us-ascii?Q?Kg2JQAYHpiLMZ2dqdl758Cr/WMWm1visnwUGKZf0tMpp99aB7rRqvKrPi2aK?=
 =?us-ascii?Q?h2RIdU9sKYn7Sn881JOedeznHM8+DIFkDJdJxI6C5pCa2WYeV91DoNcnobEL?=
 =?us-ascii?Q?JCNG9uiqlSy0N9SLsCR1R+tC3b+Bn8jo083OcHvdBeFEWvvMtow51sPeObRX?=
 =?us-ascii?Q?6frS/DVNwXONRJ3bha08UGvHOihKd17Vd4Bop/CRL5K4u4Tb/ghirLXfoqXX?=
 =?us-ascii?Q?NLG3sItn0dxPbE2p+b6eC6+3bxaucdnCNzssydILkOv+9cJ16DmsJu9oJstr?=
 =?us-ascii?Q?FIT3P/T5JdkBr/sz2JmOgqafobMh/Wp+s+rFt2Lu6Ikd57NONANaCt4VRkty?=
 =?us-ascii?Q?AyIWN9ZlF6BM7bOfTdQKSNIHV/wfN64973Qc32/zd2ozj9PJXbLr+a8kOxGt?=
 =?us-ascii?Q?ICfbVRZRYx07b5jEqa0lfkvVvJLQ4NPCtNFPgjHNzlljyepL+45xtuyEuJUP?=
 =?us-ascii?Q?f7P9CN+FIODXu0o/1z2gskGvQXY/PMXpmHFCW+8H3M7BryK67FrVEBSSEIl2?=
 =?us-ascii?Q?56IOdRlUUvhBFekFqcoRES2d+CBsiA9xVFB+HTFFvpAECjGZWhGKwrULa7la?=
 =?us-ascii?Q?Gedta19gnAvA5csfoThLgNLJbseTFmxV9D/iSxFo5nERM0VoFCO00MWjHSsa?=
 =?us-ascii?Q?zUGDdTTU8uYkXmJmZt2Zur3y7IEHK9/aCIRu1qMB9WBW21mkL9bAqInh56R3?=
 =?us-ascii?Q?dYbGh8Ukw4CzZZS9QdaZPMBxbzs1qdCwjmxkuzEn0XXpEpg7TFQRsHDbfETM?=
 =?us-ascii?Q?u4TdBZi7gen4UcGjlQU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 08:08:34.8381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faaf8171-63df-4f48-b7af-08de1e9e03c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  91 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  93 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 248 ++++++++++++++++++
 3 files changed, 432 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 96a23ca633cb6..757158b9ea655 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -649,6 +649,85 @@ struct arm_smmu_cmdq_batch {
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
+static inline bool arm_smmu_inv_is_ats(struct arm_smmu_inv *inv)
+{
+	return inv->type == INV_TYPE_ATS || inv->type == INV_TYPE_ATS_FULL;
+}
+
+/**
+ * struct arm_smmu_invs - Per-domain invalidation array
+ * @num_invs: number of invalidations in the flexible array
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
+	size_t num_invs;
+	rwlock_t rwlock;
+	bool has_ats;
+	struct rcu_head rcu;
+	struct arm_smmu_inv inv[];
+};
+
+static inline struct arm_smmu_invs *arm_smmu_invs_alloc(size_t num_invs)
+{
+	struct arm_smmu_invs *new_invs;
+
+	new_invs = kzalloc(struct_size(new_invs, inv, num_invs), GFP_KERNEL);
+	if (!new_invs)
+		return ERR_PTR(-ENOMEM);
+	rwlock_init(&new_invs->rwlock);
+	new_invs->num_invs = num_invs;
+	return new_invs;
+}
+
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
 	struct iopf_queue		*iopf;
@@ -875,6 +954,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
+	struct arm_smmu_invs __rcu	*invs;
+
 	/* List of struct arm_smmu_master_domain */
 	struct list_head		devices;
 	spinlock_t			devices_lock;
@@ -923,6 +1004,14 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
 			  struct arm_smmu_master *master, struct mm_struct *mm,
 			  u16 asid);
+
+struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
+					  struct arm_smmu_invs *to_merge);
+size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			   struct arm_smmu_invs *to_unref,
+			   void (*flush_fn)(struct arm_smmu_inv *inv));
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
+					  size_t num_trashes);
 #endif
 
 struct arm_smmu_master_domain {
@@ -956,6 +1045,8 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
+	/* No concurrency with invalidation is possible at this point */
+	kfree(rcu_dereference_protected(smmu_domain->invs, true));
 	kfree(smmu_domain);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd37981..a37a55480b3ff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -567,6 +567,98 @@ static void arm_smmu_v3_write_cd_test_sva_release(struct kunit *test)
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
+		 { .type = INV_TYPE_S2_VMID, .id = 2, },
+		 { .type = INV_TYPE_S2_VMID, .id = 3, }, },
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
+	const int results1[2][3] = { { 1, 2, 3, }, { 1, 1, 1, }, };
+	const int results2[2][5] = { { 1, 2, 3, 4, 5, }, { 2, 1, 1, 1, 1, }, };
+	const int results3[2][3] = { { 1, 2, 3, }, { 1, 1, 1, }, };
+	const int results4[2][5] = { { 1, 2, 3, 5, 6, }, { 2, 1, 1, 1, 1, }, };
+	const int results5[2][5] = { { 1, 2, 3, 5, 6, }, { 1, 0, 0, 1, 1, }, };
+	const int results6[2][3] = { { 1, 5, 6, }, { 1, 1, 1, }, };
+	struct arm_smmu_invs *test_a, *test_b;
+	size_t num_trashes;
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
+	num_trashes = arm_smmu_invs_unref(test_a, &invs2, NULL);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results3[0]),
+				     results3[0], results3[1]);
+	KUNIT_EXPECT_EQ(test, num_trashes, 0);
+
+	/* Test4: merge invs3 (new array) */
+	test_b = arm_smmu_invs_merge(test_a, &invs3);
+	kfree(test_a);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results4[0]),
+				     results4[0], results4[1]);
+
+	/* Test5: unref invs1 (same array) */
+	num_trashes = arm_smmu_invs_unref(test_b, &invs1, NULL);
+	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results5[0]),
+				     results5[0], results5[1]);
+	KUNIT_EXPECT_EQ(test, num_trashes, 2);
+
+	/* Test6: purge test_b (new array) */
+	test_a = arm_smmu_invs_purge(test_b, num_trashes);
+	kfree(test_b);
+	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results6[0]),
+				     results6[0], results6[1]);
+
+	/* Test7: unref invs3 (same array) */
+	num_trashes = arm_smmu_invs_unref(test_a, &invs3, NULL);
+	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
+	KUNIT_EXPECT_EQ(test, num_trashes, 0);
+
+	kfree(test_a);
+}
+
 static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
@@ -590,6 +682,7 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
+	KUNIT_CASE(arm_smmu_v3_invs_test),
 	{},
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 00d43080efaa8..8266d0839a927 100644
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
@@ -1015,6 +1016,245 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 */
 }
 
+/* Invalidation array manipulation functions */
+static int arm_smmu_inv_cmp(const struct arm_smmu_inv *l,
+			    const struct arm_smmu_inv *r)
+{
+	if (l->smmu != r->smmu)
+		return cmp_int((uintptr_t)l->smmu, (uintptr_t)r->smmu);
+	if (l->type != r->type)
+		return cmp_int(l->type, r->type);
+	return cmp_int(l->id, r->id);
+}
+
+/*
+ * Compare of two sorted arrays items. If one side is past the end of the array,
+ * return the other side to let it run out the iteration.
+ */
+static inline int arm_smmu_invs_cmp(const struct arm_smmu_invs *l, size_t l_idx,
+				    const struct arm_smmu_invs *r, size_t r_idx)
+{
+	if (l_idx < l->num_invs && r_idx < r->num_invs)
+		return arm_smmu_inv_cmp(&l->inv[l_idx], &r->inv[r_idx]);
+	if (l_idx < l->num_invs)
+		return -1;
+	return 1;
+}
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
+	size_t num_trashes = 0;
+	size_t num_adds = 0;
+	size_t i, j;
+
+	for (i = j = 0; i < invs->num_invs || j < to_merge->num_invs;) {
+		int cmp;
+
+		/* Skip any trash entry */
+		if (i < invs->num_invs && !refcount_read(&invs->inv[i].users)) {
+			num_trashes++;
+			i++;
+			continue;
+		}
+
+		cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
+		if (cmp < 0) {
+			/* not found in to_merge, leave alone */
+			i++;
+		} else if (cmp == 0) {
+			/* same item */
+			i++;
+			j++;
+		} else {
+			/* unique to to_merge */
+			num_adds++;
+			j++;
+		}
+	}
+
+	new_invs = arm_smmu_invs_alloc(invs->num_invs - num_trashes + num_adds);
+	if (IS_ERR(new_invs))
+		return new_invs;
+
+	new = new_invs->inv;
+	for (i = j = 0; i < invs->num_invs || j < to_merge->num_invs;) {
+		int cmp;
+
+		if (i < invs->num_invs && !refcount_read(&invs->inv[i].users)) {
+			i++;
+			continue;
+		}
+
+		cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
+		if (cmp < 0) {
+			*new = invs->inv[i];
+			i++;
+		} else if (cmp == 0) {
+			*new = invs->inv[i];
+			refcount_inc(&new->users);
+			i++;
+			j++;
+		} else {
+			*new = to_merge->inv[j];
+			refcount_set(&new->users, 1);
+			j++;
+		}
+
+		/*
+		 * Check that the new array is sorted. This also validates that
+		 * to_merge is sorted.
+		 */
+		if (new != new_invs->inv)
+			WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);
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
+ * @flush_fn: A callback function to invoke, when an entry's user count reduces
+ *            to 0
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
+size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
+			   struct arm_smmu_invs *to_unref,
+			   void (*flush_fn)(struct arm_smmu_inv *inv))
+{
+	unsigned long flags;
+	size_t num_trashes = 0;
+	size_t num_invs = 0;
+	size_t i, j;
+
+	for (i = j = 0; i < invs->num_invs || j < to_unref->num_invs;) {
+		int cmp;
+
+		/* Skip any trash entry */
+		if (i < invs->num_invs && !refcount_read(&invs->inv[i].users)) {
+			num_trashes++;
+			i++;
+			continue;
+		}
+
+		cmp = arm_smmu_invs_cmp(invs, i, to_unref, j);
+		if (cmp < 0) {
+			/* not found in to_unref, leave alone */
+			i++;
+			num_invs = i;
+		} else if (cmp == 0) {
+			/* same item */
+			if (refcount_dec_and_test(&invs->inv[i].users)) {
+				/* KUNIT test doesn't pass in a flush_fn */
+				if (flush_fn)
+					flush_fn(&invs->inv[i]);
+				num_trashes++;
+			} else {
+				num_invs = i + 1;
+			}
+			i++;
+			j++;
+		} else {
+			/* item in to_unref is not in invs or already a trash */
+			WARN_ON(true);
+			j++;
+		}
+	}
+
+	/* Exclude any tailing trash */
+	num_trashes -= invs->num_invs - num_invs;
+
+	/* The lock is required to fence concurrent ATS operations. */
+	write_lock_irqsave(&invs->rwlock, flags);
+	WRITE_ONCE(invs->num_invs, num_invs); /* Remove tailing trash entries */
+	write_unlock_irqrestore(&invs->rwlock, flags);
+
+	return num_trashes;
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
+
+/**
+ * arm_smmu_invs_purge() - Purge all the trash entries in the @invs
+ * @invs: the base invalidation array
+ * @num_trashes: expected number of trash entries, typically returned by a prior
+ *               arm_smmu_invs_unref() call
+ *
+ * Return: a newly allocated array on success removing all the trash entries, or
+ *         NULL on failure
+ *
+ * This function must be locked and serialized with arm_smmu_invs_merge() and
+ * arm_smmu_invs_unref(), but do not lockdep on any lock for KUNIT test.
+ *
+ * Caller is resposible for freeing the @invs and the returned new one.
+ */
+VISIBLE_IF_KUNIT
+struct arm_smmu_invs *arm_smmu_invs_purge(struct arm_smmu_invs *invs,
+					  size_t num_trashes)
+{
+	struct arm_smmu_invs *new_invs;
+	size_t i, j;
+
+	if (WARN_ON(invs->num_invs < num_trashes))
+		return NULL;
+
+	new_invs = arm_smmu_invs_alloc(invs->num_invs - num_trashes);
+	if (IS_ERR(new_invs))
+		return NULL;
+
+	for (i = j = 0; i < invs->num_invs; i++) {
+		if (!refcount_read(&invs->inv[i].users))
+			continue;
+		new_invs->inv[j] = invs->inv[i];
+		j++;
+	}
+
+	WARN_ON(j != new_invs->num_invs);
+	return new_invs;
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_purge);
+
 /* Context descriptor manipulation functions */
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
@@ -2462,13 +2702,21 @@ static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
 struct arm_smmu_domain *arm_smmu_domain_alloc(void)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_invs *new_invs;
 
 	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
 	if (!smmu_domain)
 		return ERR_PTR(-ENOMEM);
 
+	new_invs = arm_smmu_invs_alloc(0);
+	if (IS_ERR(new_invs)) {
+		kfree(smmu_domain);
+		return ERR_CAST(new_invs);
+	}
+
 	INIT_LIST_HEAD(&smmu_domain->devices);
 	spin_lock_init(&smmu_domain->devices_lock);
+	rcu_assign_pointer(smmu_domain->invs, new_invs);
 
 	return smmu_domain;
 }
-- 
2.43.0

