Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8972F60A4
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119473; cv=fail; b=RDaSg8Zg9KRl/BkcL0Pxn+dXuaCsTTGQKyQLMCHDzusNBpvCeD0820797V2QZ9WkAoEjWiJFLuh2EiRlt1F/ezayY/TId0wCzhchaYgHJYxwHgcmSgSOzE4Y7EqaXFwriryvPJGdgj2DQGoN4kLin9Zszzx5eKy+oc6zYWj0EwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119473; c=relaxed/simple;
	bh=oDZP5/zSctMA1LZuRSx1TyK94F+LqITDUKuSPu74cs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWzYukjqGFGXAdy55wegnWZaxdwJ6TnhojJ4J3dzZWVyAqscqBPnbHwDdJ6vZ+z6pbALqsLR75hz0bShvqE8D60hUteflj5PaFZgT+nM4YstmTGUeytfd8nu7m47J2FbisfyLtMOY3FaPYMhq4xgvUjAzNugrOiFDKSMxf/JV8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyAnKDR5; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyAnKDR5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duQEgy0NK+UK+v88EQTM1JrnLfe99+mjvDOxxmNnzsfkSyLGfN0hC2GG111ezBu2sV6emOCxhdp27YMctwkwtP5pfcofK0DeUkELtiWKLz14kA3x26FBKkXIHSVJ80LnLOWaVZgF2IsHODReh7JpfOqSkelvXr127jhLiKHXhQo3RRWxTGzv3tuG6T5rUZhtSB2fu+yw+8sGnqDcmUlNNDZ/iAPK7TCuM2gbScaWw76IN68s6mNteIJB3K0Q/7DY1gF2SuBOpNxlxGbkFLvJuYEdZLcs8SsFNV7wIM5a2JcyPR5mMegfphOKY1zQ7P10VRMMk675NTf/PYdUdhnFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MShi33/0hKwYI8ZTHmZm56fA+7N21P1/6JDU/MJfH20=;
 b=NhLXk/13VA+7UDzYzFV3gbxct4bay/oC+bkvdZucvKpfRZnBhzclyWjUlZg5paGJ/i/qoNUlAvrgOF+Mf89RNTxBwIFf1DuFQUMCBIDZJ3nIhapmyiip3qF1Z/ULtypWNaLGnZjNsjPADTwRsEmnszj2vTkQFc+LKDO9EOY3T10uSIitSo2+sZpPDHVietQHMlWS69hMM8PHZrEXGj/uTf8WOcdaSPDksmp1Ef1i3pbsjtyCrMWWVtpL4fWuXQpklyZp5rjbUNTS5GVoiqkmu+tERlvdilesWpuNO3ZcYAd6N4EBPaHzccx5k28snBisgKry1V49h2XGOcsh0fzaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MShi33/0hKwYI8ZTHmZm56fA+7N21P1/6JDU/MJfH20=;
 b=OyAnKDR5cMdHy+E8jnV3TiTl8CfDfnHNlC8dNfDdmRxfiBUsRccBWYC6l66TT2wpeGubXgscFflrbkMsznzGG1ss3/r5SEWzNjnU1YI+66Z8YkOECYvJNJqIgrzEG3r8IaU5k+N+RVtg6F7FQygg5CogtjNRnGVcZgtSbnhOuOrmlz59VvvCNh/ASXMDR5Pufh/t2se2jQFknPsxn+c30S+/aRAeEF/uPSYoCZdRj29hbpWSp3LrGePBUl8JwvyRhh+XHk1DFeeTp67j+jPt7ns1VHGrdgDVRIkShV5wCUTXc2Nf2SD4DTWXfehyeUZwgL0xuI8SVvLtjOwZ4FlvWw==
Received: from SA9PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:6e::6)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 01:11:00 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::ae) by SA9PR11CA0001.outlook.office365.com
 (2603:10b6:806:6e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 01:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 01:11:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 17:10:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
Date: Tue, 25 Nov 2025 17:10:10 -0800
Message-ID: <d24431e2c925b0416df419acc43042aff5b62f5a.1764119291.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764119291.git.nicolinc@nvidia.com>
References: <cover.1764119291.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: b46064d0-4e64-435b-4acb-08de2c88a96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Q6iFhbc7aW1kyIhw4lo2dW21HiYYw9Nd188Pr5DFEIYXvcadFlPyVg1lq0C?=
 =?us-ascii?Q?FjK9f/GDJjwMSVCT3Wy9T9a9MkHZcGmGUX88cNLihheOrWXLIhVPilbd1VbU?=
 =?us-ascii?Q?cBP8ZMtoXzKRsnavGmKJha8CqHoCjskAXAz51A88e3xL7o0PYeuRe3l7o3TI?=
 =?us-ascii?Q?4iG9l/zkUAa8OrBjc0kRFuWFCu3+HXoaO2sollK4gdbK4Tb8Y5zH+27opRFX?=
 =?us-ascii?Q?uZlFLJ42x2TLECC/RtevvPY/BRv2QGbv0lmR4vER8ilUebylBGC1d4P8p60S?=
 =?us-ascii?Q?kQ/mBEzordpgCUzyGE3ylQO+laq57XFU+TIX66VCR7NPOQN3ez51qEul6Adt?=
 =?us-ascii?Q?qNgL+Pfc80bUil2BKY4NwLEtTITdKcvOU0xZKZELLHeUA85DF3mJ31pLc3j8?=
 =?us-ascii?Q?s/AQqIxXFiW/WXk8ZOsQBAMbVbIhtfSjvEbTP85ExzM9lStX06BitsaRnHx2?=
 =?us-ascii?Q?ZQiyn78oAZ4uzHnaygNWH7bvzQXr9bJHO7KD++tq5GHbCmFJLEqR6BbfF8fH?=
 =?us-ascii?Q?W6G1BPo/YSYzuc/UkjeD+yo9Y8i6btOB88GdfAJFKgknv5l/3CDazh8dRyCW?=
 =?us-ascii?Q?ej9rh+UDpHcwu+LEiRatVo6sHsa7YXe8VjLWDH2QV5HOr8g/Rnk7EYBfzPhK?=
 =?us-ascii?Q?cCyxXicoSpfmRdg05snZXuOqQhHlD42k1TaiaYtA9pjG9419CuCq2phL4LVc?=
 =?us-ascii?Q?KTKcRhP+1QwJj4dUaDx5IaDYrWi/PyqkyntD5ghqJPFk5MfiyxaBSRuZx9Z/?=
 =?us-ascii?Q?sq8nTeB/Xtub8bdNCBX7I/655gEsWqHWXnxrrFeups28nH+q5epi10uOrR3f?=
 =?us-ascii?Q?qsgv5z+6qg8uXfeArBP5/28HqHQC0xxIFpOtnuQj7wr1P2qyXCMl2ghb9lnm?=
 =?us-ascii?Q?5Hi6hRYV6j3Nkd/GFS8txJbOvfi0srFG4hI3d9CztDHLOpPv1z9GBgl0EJZS?=
 =?us-ascii?Q?PgbsdVoZM62MMCkNgN7K3eumF/yRD8rLjuD7QwmVTy6h9UN/ozNuSjXUaa6f?=
 =?us-ascii?Q?jZ088CCTnWg1+r/+pvOnoC+HleVNQXsnxhjOn39er1XzTRRufaK4SBQDJUyG?=
 =?us-ascii?Q?KARCCm3RIfDNCzGw+DoL6lxYVf9XMPdiKKExLxphUgsQVzu2DSelbE9oqpDH?=
 =?us-ascii?Q?ZYy2zYGkt7Ot+wddt7+OPP4Cd/aXr22fr6j8DKSX79zXB2cOqlwfmqfZeW9V?=
 =?us-ascii?Q?QCRRWIt+BP6kKQpQNvjniBDqbtu0eeTAVWAyeubm/wXKamLlash/iqaqlgd9?=
 =?us-ascii?Q?TfspVVCWci01JPBpDjm8WnU5+ZWvhSZADQZEdeb5mF+IqLBJH94LuYd5Q46p?=
 =?us-ascii?Q?sRghpn134kMvy56o5HCNG0ecbbbY/+iJZRqkW3tHvt6NovcwI8F6P0/jvl7b?=
 =?us-ascii?Q?mYXMBIAsALn71z+vHRt1mT2eL56pLitd4LZIthC+BLqlvM5twZ4Tjfntv6Cn?=
 =?us-ascii?Q?Zl9fV9F1YWyM9n9XICWp0YvhLIELA8/xw1717xOVFv/36rboqhi7hOcPi4xL?=
 =?us-ascii?Q?DpcSW9GbCyYZci4NbLGWwilzPepyk36YtDoHHtt7QX6WaYmhYHSQEGJCcAPN?=
 =?us-ascii?Q?BgpmEOv0e10ZeIzNLHs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:11:00.1166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46064d0-4e64-435b-4acb-08de2c88a96b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 246 +++++++++++++++++++-
 2 files changed, 262 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 922a599ce0f1..cfd5036e3da6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1100,6 +1100,21 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
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
@@ -1109,6 +1124,8 @@ struct arm_smmu_attach_state {
 	ioasid_t ssid;
 	/* Resulting state */
 	struct arm_smmu_vmaster *vmaster;
+	struct arm_smmu_inv_state old_domain_invst;
+	struct arm_smmu_inv_state new_domain_invst;
 	bool ats_enabled;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 81b5e28a5868..d14894b99028 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3066,6 +3066,116 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
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
@@ -3095,6 +3205,131 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
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
+	/* A re-attach case doesn't need to update invs array */
+	if (new_smmu_domain == old_smmu_domain)
+		return 0;
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
+		invst->old_invs = rcu_dereference_protected(
+			old_smmu_domain->invs,
+			lockdep_is_held(&arm_smmu_asid_lock));
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
@@ -3152,12 +3387,16 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
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
@@ -3205,6 +3444,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			atomic_inc(&smmu_domain->nr_ats_masters);
 		list_add(&master_domain->devices_elm, &smmu_domain->devices);
 		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+
+		arm_smmu_install_new_domain_invs(state);
 	}
 
 	if (!state->ats_enabled && master->ats_enabled) {
@@ -3224,6 +3465,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 	kfree(master_domain);
 err_free_vmaster:
 	kfree(state->vmaster);
+err_unprepare_invs:
+	kfree(state->new_domain_invst.new_invs);
 	return ret;
 }
 
@@ -3255,6 +3498,7 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	}
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	arm_smmu_install_old_domain_invs(state);
 	master->ats_enabled = state->ats_enabled;
 }
 
-- 
2.43.0

