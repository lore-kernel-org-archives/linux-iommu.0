Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7E3328EA
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591308; cv=fail; b=Gky2CruL2c3+S+s53GPh3Hh/uYIe2xhcpVRTMGjXgetGaeTQua+sH9mLBfAkHkkyZNthcsvW2pY/z+qi+ftPW0EeoFNpHRJ9g43P19IyOxmFDpQSBQ9mih0lKovKsXZLE73JjET5foMSiJP9sB1zAw/7gEOm1XjMNiT318FAxuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591308; c=relaxed/simple;
	bh=vDhUy1QuD7ORtO2ZKH9WQPVCktF4bK95f97uTOvhydE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOKldFw1MK/wra1hUXu6HIkXY5XxKwCwxZZZNPv6CjE3VUniDho3PET7aO4vQlLu6o5Tyj8CzrpsGm3aD3LZu9uFu38zVyMdsPFW1WownzHi87J1C2V7P/5F5VaH4hQ0Rn4zwHJZCIC6BVwubjD6UOtPoBCcKEAN5LwSKby2hDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TOw0iGpx; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TOw0iGpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dF650fuPRb5ZqIYJCzWi2c0rHaPHiIMrz4izp/9cVMTSlE7zABOtAoY4Mxd/UqBYGGUVAP5SBGdKmF/LPu/wWq2LheOfdayyzlaLXh21lVpGjPkODtzVLUFD5qLMHIhCO0GIX/1QAKeOVEaNl4KZZeiFJgMBTnuHZHMw9cMcjG8VYWFYXRZ3wiH/hQEtbObPA1+e2m3pXknfazNVmFG+KHskMh73kfp0owWfTDrjbqo8rDAbRaC/pMVWF10ITX2Urc2ki1QF8KlQvpTmCEqLUNtVszTrooP30olabTznZRt87NhOLLTFhRTmhZYpghk4nI4gnjj4CQiNQ/RbgbaDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqaQeSq7dvDSH8GZ2oEN5rdu16s4fPSAQ5dktALSX5c=;
 b=HH+A2dqjMhlISdXTKovKA8fuGcmwMqTdmAjCsSJk8gnzDp9nNjLXYKxrWkdXdyUhB6AFluHhL5Z2w+rL3Q+jK/Q2mzamQRkeSCy+B1cNqh25mGjAYLy7qP2Fccy3ie5BAg60jCeHUp8Y54/RWFr2MHylt0aP36uM85QnKhqWH7xdCVyZrj2hpBqM1h0jMjSireUXEY9jh57h4V/7lEYYeVXbxcVe5JaYzxZhrxr0mtXlR0feoW5XMUs3g4TJ0nXc2gYXVyMQJ5rJFP4TLQZ5+V/f2h+aOA1FldFkvOsyorF2zu8NXd4OlWY+uPz9rsh9D6yaTlvRsQQOFzoI36jYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqaQeSq7dvDSH8GZ2oEN5rdu16s4fPSAQ5dktALSX5c=;
 b=TOw0iGpxpxwfIKOx1VhI+wqDP0o9UH5GazDW2h+V0XQBRbzitKFKSxEAzc22p4hIbJm9F/pbK25yhSckcfiUdOY4ub4EOwOMgrYZjexj7N5rBAK3nK0CDlRnVmGWFev16i6OIb0y9Gmnz8qXnPKPXhGVy+5h3H4hs2RVVENV9VLOxTAP34a510bQf1aira0TD3PPbosrS6hkWz+CMizoBBlWal3sSFvIU6C1xuNnNVY6SsoLyzN/08aDuC4GWeFcoILbxcRHSr2tH37qQYXC9soxEkmh33HHPPWm76AnajuDzapiWDl8KnbdCNaRRD33stwIIi/wKOC+aSK0EBNjnQ==
Received: from SN7PR04CA0093.namprd04.prod.outlook.com (2603:10b6:806:122::8)
 by DM4PR12MB6110.namprd12.prod.outlook.com (2603:10b6:8:ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 18:54:53 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::ac) by SN7PR04CA0093.outlook.office365.com
 (2603:10b6:806:122::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 18:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 11:54:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
Date: Mon, 27 Oct 2025 11:54:17 -0700
Message-ID: <b7560a95f474bd642e037d5a43cfe5be76ea3fe7.1761590851.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761590851.git.nicolinc@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM4PR12MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a103df-7c44-47f2-2378-08de158a5088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aAvhL96BavKrB6UwhiD+wG6JFg3QTRoI5REohecHjucIyo/qpxCphN9aC8f8?=
 =?us-ascii?Q?U8vmRlG6F9PuMghkPGTAZi6ogywLoNvrZbQJ/emzq2Ba9h9/Z6Run8KT1ajU?=
 =?us-ascii?Q?dspsEOm+WgdMeDAumSuKeim2LowYXWjVELZm767ejXcGn4enu5MRRYtMNNWC?=
 =?us-ascii?Q?/pZmKzwtQYFyev1EkmBmATig93kWgkgQDWsdFHw7ZnUJMuhV+TuWBKo/tulX?=
 =?us-ascii?Q?7iueLPZwJGnWZaEdyv9UjyiWmSavaYbs4POW/LDBbnqyR0XY6EuPkMc+abIt?=
 =?us-ascii?Q?kl/f8k5/+fN/1qAM7ZgmFta55Yn5a5ILfHIgH30TznxRmz4g1rrYCwIqycB1?=
 =?us-ascii?Q?s2MT45diZvLznlVjDsDhF8tLdkENTFFI22D4tM20aex1biRGpBEPVQuZ3rrd?=
 =?us-ascii?Q?pInFk6QDAwSHqc6Si0rJpwUa4i808ynt8B2oZPIK476lJ6wRZFZbJAOPk2R1?=
 =?us-ascii?Q?tCgaMqVRRtnl2HYJEJv6yk0mPOZiDlrqerHOF4lsAMmWsoHHce2u4T3/LTV0?=
 =?us-ascii?Q?//u4un3nrQhua7zUx3a+1SljTYbp2ae4liNNF8DvHnAG86faMGLC5uxkkHd5?=
 =?us-ascii?Q?n176tL9sNXP4kDzORMFiC5n7+/swCUlBgh0pDyobJYy+74Mrmt7wRo9EUbbj?=
 =?us-ascii?Q?3Pxk1ZWyUSmdgTEJYeKmbaAq2pXxIxBOn8uytS02lxPIphcsERi341OqNCrl?=
 =?us-ascii?Q?cgSlxR4goO/BJj8StA7meDYoXo90Mdr5ahzIjd+RYdrsOqqf+7qchkxupO/J?=
 =?us-ascii?Q?sDEXxN0T8Jw+IiPi6A65PTW1KkEdCTIB9ZB7Yr/pHuTKcOH8xEtZIjXJq1Gn?=
 =?us-ascii?Q?vKc7SGXQ18et8X0xrnFWwZMa3W49/moY6+gSpXS3rC8VTfBzk86Txgs1Tlq/?=
 =?us-ascii?Q?QjlY9u2/CHxD7L+HWaa+MTni3QNH5onH6lpM+ZzJrliCYj+YjJOvZ3OGIEMC?=
 =?us-ascii?Q?qkh39OW+LJtH9o5uC1KuSO47sO1MHROqOZgZJFEnDYgI9yo+1LQ/7uhRE2wz?=
 =?us-ascii?Q?BrBEY5CFa8mbX1rEqtfoDYqzn8lBiuy37f/nxKc/PF3JHXaqZ8Dn00bqkOV3?=
 =?us-ascii?Q?sj0nTGNCH2HvT9XPYm7eksoxupBMWmSJhT3uy5e/Ggy62JFI/nCnTP7k4TQ8?=
 =?us-ascii?Q?aP/BSI9hB4n1XeTaXTMRlduh+QWE7HojohQLsRkXIkoMSV+Mypz3/4I28fYA?=
 =?us-ascii?Q?uR++T27iUb/4sqtCFqrCXhfPax6IFMc1BIGZRH05yZlBUs57Tp3h9eY/sSqy?=
 =?us-ascii?Q?M8K7DjSlP2EEAaeLbIbSyDLuu5xna3vrbMM6F+bvSH9b64QVlrlKFLLonxia?=
 =?us-ascii?Q?XBU4Zcr+jgop4ttlgyDyIuriw0fn18RrikM4RP/H5PhXtYSf81njKTetHDNc?=
 =?us-ascii?Q?ShObt+HmV3uvG//0JKmZs7vafpaQpkYzPk9eka28NJF/JuR9SS67vF3jA8aR?=
 =?us-ascii?Q?AiEgoCF6c6udcsccfyqeL+y7C1mOFSKNEII0/dSmf3bR0QaSZZ7XMAhrznhV?=
 =?us-ascii?Q?JaimCyobJQhfKgqmepC3PAOKvKsgWH/lwRfHLEPlLyWRT3tMq75Rkhk7xVi0?=
 =?us-ascii?Q?8Qd5IeK4IdefsrkACEc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:53.2638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a103df-7c44-47f2-2378-08de158a5088
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6110

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
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  90 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  93 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 241 ++++++++++++++++++
 3 files changed, 424 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 96a23ca633cb6..43df0ae89d96f 100644
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
@@ -956,6 +1045,7 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
+	kfree_rcu(rcu_dereference_protected(smmu_domain->invs, true), rcu);
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
index 00d43080efaa8..cc266b47810b0 100644
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
@@ -1015,6 +1016,238 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
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
+	if (l_idx != l->num_invs && r_idx != r->num_invs)
+		return arm_smmu_inv_cmp(&l->inv[l_idx], &r->inv[r_idx]);
+	if (l_idx != l->num_invs)
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
+	for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
+		int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
+
+		/* Skip any unwanted trash entry */
+		if (cmp < 0 && !refcount_read(&invs->inv[i].users)) {
+			num_trashes++;
+			i++;
+			continue;
+		}
+
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
+	for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
+		int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
+
+		if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
+			i++;
+			continue;
+		}
+
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
+	for (i = j = 0; i != invs->num_invs || j != to_unref->num_invs;) {
+		int cmp = arm_smmu_invs_cmp(invs, i, to_unref, j);
+
+		/* Skip any existing trash entry */
+		if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
+			num_trashes++;
+			i++;
+			continue;
+		}
+
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
+	for (i = j = 0; i != invs->num_invs; i++) {
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
@@ -2462,13 +2695,21 @@ static bool arm_smmu_enforce_cache_coherency(struct iommu_domain *domain)
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

