Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163A33D6D9
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175161; cv=fail; b=FusnqV36ofDARBjt0yS/H5E6dGZR7ndXjqn8LhKJelm3wV72kPXPMe3b8uJzkegL0HKZENWUU5g4MPR7er6bd0XU9zNP5mFwlV4mUUn9d07RBIdPTYAedNpOBYUW9gAyF36qXoXdb45KpGmcjIMqWhAAISiIBe+eJg++9r6Ko2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175161; c=relaxed/simple;
	bh=nno5bGOd+SUZiIxB72OQ0+9PnVnsKoKpO/fQw4HOfjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4j8DayxwoTjSlTtVLtwSfMut9MzvSbkU1Ezo5DphO6OOtXNR+3D1xRstr2OyrbxUFsLHpShWroZIkrQhJpwysyaJHMsO2zAxMz79ygiHO1zimuQ9+CtPkbhaRbs4GLkSqBFjhzKs0vI9te6oWvAymAKJfe8Kx+jasLbuMdQ50A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uMlYxAdX; arc=fail smtp.client-ip=52.101.61.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMlYxAdX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7rAgQNhreJi7KQyfh/vr+t5MNx5QvPaU7sMc6IJfQT/8Xe3j91WdLt/ebuG2qZyhFKZwQ4mEm2w12pd+88D/n0PZojEFfy9zUKClV7MDIOWdPaqrSlvcnzQM9JPEm6b1etXweYNvpFeXabV7hVgWQvJ9Nk9GuIvJvqRIxvRd/Yobqr2HeiwRYZWupUdiDyJqx616lWuglVYVS0MkVCxmzAT964V/w+UqY21/zP821g0QxTYm/lSynsvT7yFEcaXqwtUkcYVs2DpPjLOJWpcc8f/ZWt+wzLeBg8OoKJXd1ReTGsNkxn6bMdCoctiL52XvM8KZcEzvenCDaNaiEeRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kExR0Ufwn6o+pqHfZFfxF22xWw9PCwYHyso7/+k44jI=;
 b=L3veUABwZAS7W1OEkzj9SJDxHw8nXKNOD8ebpaSWHY24nxPavMh+1n4x156FYUu7Is7/cC662qPmcsIGdo0kWjuon1bxOlQljF1/Q4g6NDeEkYeGn9cmV/pV4h//XMxS1ExwWhQ98CoYzWI5/ob64iPf0/zmsmqcQlleozY1/nUqQOHgfIM2eynrRuoJehJ4UIYoXSxSKH1rb61OfsR73iDn2M6Z8suPNjT6HgafcBhMxA9+/wO5m8afgGBYDamkbWZQcgP8+DZtmi8huPZuVAc4qu/hnOe2wXaFHJkzxPiLfXkxbbRyaerl2Mo59Qf9pNMq+N8T8cJeEQkFjZX3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kExR0Ufwn6o+pqHfZFfxF22xWw9PCwYHyso7/+k44jI=;
 b=uMlYxAdXmoG2E7QEb4z1+ZigHjDlGTxpKRVckLAGoFYaLcbIgdihDDOY4oTUXQLuzmh0EV4uKy+Oktmoa2sg0Owk1YeQGCJnlt/FIlIug1h9cPzWufPbnhUVq/sp2Ik7HyCaqJQ5qqMmQCoow7Tct5cUtyQEjR0XyLaoJOdRTpx8zmFd5DjRLW5Hxe/49s6nH9b7F8bOZynIIvP/72LpY5wxns1VXw4tY7S++wxJnK9tnsKbW2sJl+ru0rb+ZMqdgKD3iFd5EghQLK+3a7/bVVOymWuCB00O+lsV/eTUxjVhqEbWGMDLPo7CBAGnFO5J9PcGAocmGa5hKQ8SS/C34g==
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 20:12:30 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::59) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Fri,
 19 Dec 2025 20:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 20:12:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:14 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:13 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 12:12:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Fri, 19 Dec 2025 12:11:27 -0800
Message-ID: <2232710c544e9319d8e47b474c1fd1f04b0628b6.1766174731.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766174731.git.nicolinc@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcc76a5-3da7-4bb0-2692-08de3f3aefa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YnZHIdZQ6y3WePEiq5xirMVATeP8cAcBIjzdFyahrWHHyILyolxcTUTjMMFY?=
 =?us-ascii?Q?iYvUlhELv9Lk1W02ziszAbclm/g1xzC0bfvmb+pBETgekTNPv419QoHpY4AW?=
 =?us-ascii?Q?JZwEWnH13YbMBFwVvC8P8oa2z1snVlEqzne5+gr321FUKqn0tn17I5icZEjN?=
 =?us-ascii?Q?QMo6spkxSBOgJGslOiim4HAbnGDag1KJrUw/jo4Pw1RHYGk3XhVfB40BHXnh?=
 =?us-ascii?Q?HfP2Plw3uOrr8ACb7HZrzarj8rQLTkDOWQmz52E1dNhRz/E2pmnMYPIYJHht?=
 =?us-ascii?Q?kQGxNUlM8vm4VLAhJtFQjJF2msfO0swRIhjJC7hWOXZgx7APev0Go5jd27i0?=
 =?us-ascii?Q?QgdLFaRJ72r/NAxtfdVkmGwvvONQIhVmTNIIcFpzXJoLJdJwC1CP7TLGl+Ki?=
 =?us-ascii?Q?NmGGrdBcH2gmHDTJeCtuPM8B+Svrpl5cyL6aFIaalk6patJEac1L2EdJyjhW?=
 =?us-ascii?Q?OztAqhL32NZguI94bhllyt48XgWeJ/W3Jvl8gfmqZA6iicaHLTrXIVuZNFKT?=
 =?us-ascii?Q?/WdIJrmFDkGld5PsIbSyFHdk4hcTUND01amiDsdkOvJS7Yov75xBScczybSa?=
 =?us-ascii?Q?5FrlCbnYkngakj5K+JAvNq+URy8A5BvprClzLWmjV9lX2cP0hbgxYo2/MmPa?=
 =?us-ascii?Q?Xbtfrwg96qW5+IWES5YgaW46RcC5ZChGypqVFCY51pBYvARDtgkIs3qJ3FYF?=
 =?us-ascii?Q?9fAATgeVW+Rw4DckKztV7agcRqnfaNYBgZ3ZQVvF0oKxKGadJOddkR8+Rsnv?=
 =?us-ascii?Q?pWzhTjt2KqAON7eV0ZOewb+Cl0LcWsdVXb6VzdAXowPKUUh1O1F22eE4X+1a?=
 =?us-ascii?Q?C3wGbIVWqv1CbYxl3iIWQRzORVXoFDTYQMRTye7lwc9+qatpcqq4aXonj+re?=
 =?us-ascii?Q?snQ/3eqnfX92CYJBgI6B2xm30KCtR5kJDVi/EuEfXmEnfk2WpwO3Yj5KfKaf?=
 =?us-ascii?Q?vgHVYBhCCS6uR+xVywJ4N0mGQN+4qa3+MqlbAa60EGE2bn5axitbKfKfKts9?=
 =?us-ascii?Q?KLuwIAo7TnoKJrayVDyWiYUl0x3kpFEvEgFLpXJmwbL6DnCnpyPczaUOT5si?=
 =?us-ascii?Q?zkpyIPDp06f5ymEM7HEL6IXZEFEGPqTV5KE4ZlnyNvCoWFV86aP0J9bYGUQN?=
 =?us-ascii?Q?3SmE5RoLCJTDkiwvLCXBUlSKZZTjfHBVLZrYLt23EYFhfwtxNzGAQNUPNSew?=
 =?us-ascii?Q?I0IBiFn1KgAKtR7Rtib6qet4rslPPPCMEm8U43KO9oaJxIS8RZf6mjwyjk9r?=
 =?us-ascii?Q?ta/576qXPGu+BmBqoj0nWX4YXle4gd271O4/SoU45dM6Ncm3Tb6BFC/2T7n+?=
 =?us-ascii?Q?qpHoEXwPsi3LiJEUIsH6W6LjtIkOOjvkIRkQDuLRPsO540I3gniNY1JIdhMD?=
 =?us-ascii?Q?GsNXDmWt/5PimB+AsY6lqRnos4VT+JHuTFTPdqjYurfhizt8tAl86eWL77Cr?=
 =?us-ascii?Q?OYZEIDA061EXtyWHLAMX4h4albYrXbcUz0bIiFc3sbmOb5oUP+2EMlx6UAXv?=
 =?us-ascii?Q?/+LYkjg/RID/qzFUbnM1+9jW5SjSyMpi2HdZH5IrfUfUtCCgpXZmWb7pC9Ys?=
 =?us-ascii?Q?PtFiRpSok5NNiH7GWZs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:12:29.4197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcc76a5-3da7-4bb0-2692-08de3f3aefa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

Update the invs array with the invalidations required by each domain type
during attachment operations.

Only an SVA domain or a paging domain will have an invs array:
 a. SVA domain will add an INV_TYPE_S1_ASID per SMMU and an INV_TYPE_ATS
    per SID

 b. Non-nesting-parent paging domain with no ATS-enabled master will add
    a single INV_TYPE_S1_ASID or INV_TYPE_S2_VMID per SMMU

 c. Non-nesting-parent paging domain with ATS-enabled master(s) will do
    (b) and add an INV_TYPE_ATS per SID

 d. Nesting-parent paging domain will add an INV_TYPE_S2_VMID followed by
    an INV_TYPE_S2_VMID_S1_CLEAR per vSMMU. For an ATS-enabled master, it
    will add an INV_TYPE_ATS_FULL per SID

 Note that case #d prepares for a future implementation of VMID allocation
 which requires a followup series for S2 domain sharing. So when a nesting
 parent domain is attached through a vSMMU instance using a nested domain.
 VMID will be allocated per vSMMU instance v.s. currectly per S2 domain.

The per-domain invalidation is not needed until the domain is attached to
a master (when it starts to possibly use TLB). This will make it possible
to attach the domain to multiple SMMUs and avoid unnecessary invalidation
overhead during teardown if no STEs/CDs refer to the domain. It also means
that when the last device is detached, the old domain must flush its ASID
or VMID, since any new iommu_unmap() call would not trigger invalidations
given an empty domain->invs array.

Introduce some arm_smmu_invs helper functions for building scratch arrays,
preparing and installing old/new domain's invalidation arrays.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  17 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 258 +++++++++++++++++++-
 2 files changed, 274 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f98774962012..f8dc96476c43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1101,6 +1101,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 	       IOMMU_FWSPEC_PCI_RC_CANWBS;
 }
 
+/**
+ * struct arm_smmu_inv_state - Per-domain invalidation array state
+ * @invs_ptr: points to the domain->invs (unwinding nesting/etc.) or is NULL if
+ *            no change should be made
+ * @old_invs: the original invs array
+ * @new_invs: for new domain, this is the new invs array to update domain->invs;
+ *            for old domain, this is the master->build_invs to pass in as the
+ *            to_unref argument to an arm_smmu_invs_unref() call
+ */
+struct arm_smmu_inv_state {
+	struct arm_smmu_invs __rcu **invs_ptr;
+	struct arm_smmu_invs *old_invs;
+	struct arm_smmu_invs *new_invs;
+};
+
 struct arm_smmu_attach_state {
 	/* Inputs */
 	struct iommu_domain *old_domain;
@@ -1110,6 +1125,8 @@ struct arm_smmu_attach_state {
 	ioasid_t ssid;
 	/* Resulting state */
 	struct arm_smmu_vmaster *vmaster;
+	struct arm_smmu_inv_state old_domain_invst;
+	struct arm_smmu_inv_state new_domain_invst;
 	bool ats_enabled;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cc85e7a10ea8..fb45359680d2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3068,6 +3068,121 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
 }
 
+static struct arm_smmu_inv *
+arm_smmu_master_build_inv(struct arm_smmu_master *master,
+			  enum arm_smmu_inv_type type, u32 id, ioasid_t ssid,
+			  size_t pgsize)
+{
+	struct arm_smmu_invs *build_invs = master->build_invs;
+	struct arm_smmu_inv *cur, inv = {
+		.smmu = master->smmu,
+		.type = type,
+		.id = id,
+		.pgsize = pgsize,
+	};
+
+	if (WARN_ON(build_invs->num_invs >= build_invs->max_invs))
+		return NULL;
+	cur = &build_invs->inv[build_invs->num_invs];
+	build_invs->num_invs++;
+
+	*cur = inv;
+	switch (type) {
+	case INV_TYPE_S1_ASID:
+		/*
+		 * For S1 page tables the driver always uses VMID=0, and the
+		 * invalidation logic for this type will set it as well.
+		 */
+		if (master->smmu->features & ARM_SMMU_FEAT_E2H) {
+			cur->size_opcode = CMDQ_OP_TLBI_EL2_VA;
+			cur->nsize_opcode = CMDQ_OP_TLBI_EL2_ASID;
+		} else {
+			cur->size_opcode = CMDQ_OP_TLBI_NH_VA;
+			cur->nsize_opcode = CMDQ_OP_TLBI_NH_ASID;
+		}
+		break;
+	case INV_TYPE_S2_VMID:
+		cur->size_opcode = CMDQ_OP_TLBI_S2_IPA;
+		cur->nsize_opcode = CMDQ_OP_TLBI_S12_VMALL;
+		break;
+	case INV_TYPE_S2_VMID_S1_CLEAR:
+		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_TLBI_NH_ALL;
+		break;
+	case INV_TYPE_ATS:
+	case INV_TYPE_ATS_FULL:
+		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
+		cur->ssid = ssid;
+		break;
+	}
+
+	return cur;
+}
+
+/*
+ * Use the preallocated scratch array at master->build_invs, to build a to_merge
+ * or to_unref array, to pass into a following arm_smmu_invs_merge/unref() call.
+ *
+ * Do not free the returned invs array. It is reused, and will be overwritten by
+ * the next arm_smmu_master_build_invs() call.
+ */
+static struct arm_smmu_invs *
+arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
+			   ioasid_t ssid, struct arm_smmu_domain *smmu_domain)
+{
+	const bool nesting = smmu_domain->nest_parent;
+	size_t pgsize = 0, i;
+
+	iommu_group_mutex_assert(master->dev);
+
+	master->build_invs->num_invs = 0;
+
+	/* Range-based invalidation requires the leaf pgsize for calculation */
+	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_SVA:
+	case ARM_SMMU_DOMAIN_S1:
+		if (!arm_smmu_master_build_inv(master, INV_TYPE_S1_ASID,
+					       smmu_domain->cd.asid,
+					       IOMMU_NO_PASID, pgsize))
+			return NULL;
+		break;
+	case ARM_SMMU_DOMAIN_S2:
+		if (!arm_smmu_master_build_inv(master, INV_TYPE_S2_VMID,
+					       smmu_domain->s2_cfg.vmid,
+					       IOMMU_NO_PASID, pgsize))
+			return NULL;
+		break;
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
+
+	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
+	if (nesting) {
+		if (!arm_smmu_master_build_inv(
+			    master, INV_TYPE_S2_VMID_S1_CLEAR,
+			    smmu_domain->s2_cfg.vmid, IOMMU_NO_PASID, 0))
+			return NULL;
+	}
+
+	for (i = 0; ats_enabled && i < master->num_streams; i++) {
+		/*
+		 * If an S2 used as a nesting parent is changed we have no
+		 * option but to completely flush the ATC.
+		 */
+		if (!arm_smmu_master_build_inv(
+			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
+			    master->streams[i].id, ssid, 0))
+			return NULL;
+	}
+
+	/* Note this build_invs must have been sorted */
+
+	return master->build_invs;
+}
+
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 					  struct iommu_domain *domain,
 					  ioasid_t ssid)
@@ -3097,6 +3212,131 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	kfree(master_domain);
 }
 
+/*
+ * During attachment, the updates of the two domain->invs arrays are sequenced:
+ *  1. new domain updates its invs array, merging master->build_invs
+ *  2. new domain starts to include the master during its invalidation
+ *  3. master updates its STE switching from the old domain to the new domain
+ *  4. old domain still includes the master during its invalidation
+ *  5. old domain updates its invs array, unreferencing master->build_invs
+ *
+ * For 1 and 5, prepare the two updated arrays in advance, handling any changes
+ * that can possibly failure. So the actual update of either 1 or 5 won't fail.
+ * arm_smmu_asid_lock ensures that the old invs in the domains are intact while
+ * we are sequencing to update them.
+ */
+static int arm_smmu_attach_prepare_invs(struct arm_smmu_attach_state *state,
+					struct arm_smmu_domain *new_smmu_domain)
+{
+	struct arm_smmu_domain *old_smmu_domain =
+		to_smmu_domain_devices(state->old_domain);
+	struct arm_smmu_master *master = state->master;
+	ioasid_t ssid = state->ssid;
+
+	/*
+	 * At this point a NULL domain indicates the domain doesn't use the
+	 * IOTLB, see to_smmu_domain_devices().
+	 */
+	if (new_smmu_domain) {
+		struct arm_smmu_inv_state *invst = &state->new_domain_invst;
+		struct arm_smmu_invs *build_invs;
+
+		invst->invs_ptr = &new_smmu_domain->invs;
+		invst->old_invs = rcu_dereference_protected(
+			new_smmu_domain->invs,
+			lockdep_is_held(&arm_smmu_asid_lock));
+		build_invs = arm_smmu_master_build_invs(
+			master, state->ats_enabled, ssid, new_smmu_domain);
+		if (!build_invs)
+			return -EINVAL;
+
+		invst->new_invs =
+			arm_smmu_invs_merge(invst->old_invs, build_invs);
+		if (IS_ERR(invst->new_invs))
+			return PTR_ERR(invst->new_invs);
+	}
+
+	if (old_smmu_domain) {
+		struct arm_smmu_inv_state *invst = &state->old_domain_invst;
+
+		invst->invs_ptr = &old_smmu_domain->invs;
+		/* A re-attach case might have a different ats_enabled state */
+		if (new_smmu_domain == old_smmu_domain)
+			invst->old_invs = state->new_domain_invst.new_invs;
+		else
+			invst->old_invs = rcu_dereference_protected(
+				old_smmu_domain->invs,
+				lockdep_is_held(&arm_smmu_asid_lock));
+		/* For old_smmu_domain, new_invs points to master->build_invs */
+		invst->new_invs = arm_smmu_master_build_invs(
+			master, master->ats_enabled, ssid, old_smmu_domain);
+	}
+
+	return 0;
+}
+
+/* Must be installed before arm_smmu_install_ste_for_dev() */
+static void
+arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_inv_state *invst = &state->new_domain_invst;
+
+	if (!invst->invs_ptr)
+		return;
+
+	rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
+	kfree_rcu(invst->old_invs, rcu);
+}
+
+/*
+ * When an array entry's users count reaches zero, it means the ASID/VMID is no
+ * longer being invalidated by map/unmap and must be cleaned. The rule is that
+ * all ASIDs/VMIDs not in an invalidation array are left cleared in the IOTLB.
+ */
+static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
+{
+	struct arm_smmu_cmdq_ent cmd = {};
+
+	switch (inv->type) {
+	case INV_TYPE_S1_ASID:
+		cmd.tlbi.asid = inv->id;
+		break;
+	case INV_TYPE_S2_VMID:
+		/* S2_VMID using nsize_opcode covers S2_VMID_S1_CLEAR */
+		cmd.tlbi.vmid = inv->id;
+		break;
+	default:
+		return;
+	}
+
+	cmd.opcode = inv->nsize_opcode;
+	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
+}
+
+/* Should be installed after arm_smmu_install_ste_for_dev() */
+static void
+arm_smmu_install_old_domain_invs(struct arm_smmu_attach_state *state)
+{
+	struct arm_smmu_inv_state *invst = &state->old_domain_invst;
+	struct arm_smmu_invs *old_invs = invst->old_invs;
+	struct arm_smmu_invs *new_invs;
+
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	if (!invst->invs_ptr)
+		return;
+
+	arm_smmu_invs_unref(old_invs, invst->new_invs,
+			    arm_smmu_inv_flush_iotlb_tag);
+
+	new_invs = arm_smmu_invs_purge(old_invs);
+	if (!new_invs)
+		return;
+
+	rcu_assign_pointer(*invst->invs_ptr, new_invs);
+	kfree_rcu(old_invs, rcu);
+}
+
 /*
  * Start the sequence to attach a domain to a master. The sequence contains three
  * steps:
@@ -3154,12 +3394,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 				     arm_smmu_ats_supported(master);
 	}
 
+	ret = arm_smmu_attach_prepare_invs(state, smmu_domain);
+	if (ret)
+		return ret;
+
 	if (smmu_domain) {
 		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
 			ret = arm_smmu_attach_prepare_vmaster(
 				state, to_smmu_nested_domain(new_domain));
 			if (ret)
-				return ret;
+				goto err_unprepare_invs;
 		}
 
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
@@ -3207,6 +3451,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3226,6 +3472,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3257,6 +3505,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
@@ -3438,12 +3687,19 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attach_state state = {
+		.master = master,
+		.old_domain = old_domain,
+		.ssid = pasid,
+	};
 
 	mutex_lock(&arm_smmu_asid_lock);
+	arm_smmu_attach_prepare_invs(&state, NULL);
 	arm_smmu_clear_cd(master, pasid);
 	if (master->ats_enabled)
 		arm_smmu_atc_inv_master(master, pasid);
 	arm_smmu_remove_master_domain(master, &smmu_domain->domain, pasid);
+	arm_smmu_install_old_domain_invs(&state);
 	mutex_unlock(&arm_smmu_asid_lock);
 
 	/*
-- 
2.43.0

