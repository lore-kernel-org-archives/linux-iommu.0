Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC42750F9
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693121; cv=fail; b=oEWkUU1NbJ+/fgKP/EjS+/ea6CY1V0VqP2oLPdUg2okZBoOJ0pnzE8m+3qpH96F064Xpi1oUC4LfbLLuzRIl85lQhk8vjImuoAGhyLN5Vo2lvqJ/5my5/tzhatobObKt3TOhHqEPjB70EPz2EjAZHoTrpgXmVjBmknZk55q/l3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693121; c=relaxed/simple;
	bh=GnRXakjXaQ97Q4dRhEerX5sktfrg2AxUKW0J59uueWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOgo+BR/vqOxcXzt2NQC5stz3O9VxZUHlFxIdgSe2aYePDYxCogS0ofP07B5z+CyarNtaJRpKsAFMuAXDMejVDDDR/nvDB8tRabJiPudutRLUzyiH3vGfRlzwuVHF0cSiYHMJYtdZtyjvsQBL9/fSrXZglz0OI0r0UCDDcHD2ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RrD6gWm9; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RrD6gWm9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDKcot8gJ5ZORSFkzVDisUflaBgRCM0e7crLK34Q3csSFDyu/dpOxJGU39zaR1IqPYSHBrxcK4iSaTv8POSS8AM3MHqqCGIUai7VDQ1jzR+3LnZnEZwZQB2SVce/zR2INMrAiuOk1ZVMH4r1nE/g0V6PPCoRal9Q1Q0v8srnhNgdOxbw2Yqc7znD+kTfjmjrxkRQCkuxfS2/wm9z2a5L4Mdw7M+nhEHyHGPzEXTv2udb5xHaN7yprXr7MbhAWSrLXiFVxF82NCXAMlh45v4YcguZwgUFxbdDNR8LKQNytgrN0EAU2MD8l6jyCnsA75QDdy8TKLuVeTqloBVoH1FtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zNqolHNUJ4bV3FUx5ffk//o9/P5bcuqxh/eGDjRgOU=;
 b=PHjKF5ssdBjG7ETqvcW/bVsRuT0gbWJsQK9/NS1eGkX+Sx8Qr5aNkN7KtIWzckqXGDgL2Ud/5QGC4jf1z9WcdSOFeyeSGII2HppqOJ82un2sMX4JxcgJTInZQuqTL/7phmMlAQkqTdgdEODnK77raHja3EEoaidC6Bf8an5RJC7gK51RwcojdzuNtpLgPTpAZmHxoeaeYv0jucN2jvcBRp2f4ILFOW+pRQBb+bP2L9B8TxVzS2lTNaEPoO+eexP7uCjX2AoV50Jm50f/Ay69w3a2LsgsUyIwQoZumzueJIKqFQ1pu9qCPuHXAyRT92w2C3jQUfTOUGxK0TlnuDuKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zNqolHNUJ4bV3FUx5ffk//o9/P5bcuqxh/eGDjRgOU=;
 b=RrD6gWm9/5Vn48UOhQOSX0CbmiF/vAsH88rNIsCJa92W7LiIWfh32ZANyZDEfVD9ziamagMRCin6ZcjFzINS3GJJYt1rghRdynBRNEIhxxrkURomyhWKuhXOQN6Kphql6TpIiFbwavtEumDBnb91ecLEOYIsVost6cNAZ7T/0ya0gE8vP/fbXu0vpt1+vef/wkYxpuWji3wfMJYWwB6JLQGoVn9dabUQi+CIlDgw4T6vsCk+BV0ioCCB7nqIaOaxeIj7/LqVBIFU3uvZMJTSWEeFacO3FMcykaBg09FkfRSXh5auFRctt2WWZOuQf+TsRYjeDwdo837NBEZbcheEzA==
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 04:58:34 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::e5) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Tue,
 15 Apr 2025 04:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:19 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 08/11] iommu/arm-smmu-v3: Use vSMMU helpers for S2 and ATC invalidations
Date: Mon, 14 Apr 2025 21:57:43 -0700
Message-ID: <771891ae889f880832c70d5ed895802732138478.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 609de5aa-7a7a-4c8e-d990-08dd7bda2cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bHUQHTHQ7HBnhqgajtc1xpFa9vBPli7JOcocaNBg6tAKOL/OOsbgBjCrbNdv?=
 =?us-ascii?Q?lkakYgOeNUy0a6AP0gWjQu13Wo3G6kEgtS3cQEP3sEcI1OZv5PR71zDQCuxY?=
 =?us-ascii?Q?WYIHzo7gpUcUcXEnUbCAImIDhA0w6os677YzN4mfk5qzrKXssC3ES7SLA41q?=
 =?us-ascii?Q?kthl4yMeIWEQrh57wB9r4jXsqo8lhicq/7gV6MqhU/mfAjGfo6o+Hod2JcBB?=
 =?us-ascii?Q?lHyBN5NWPvzjf/OT0fA/M9ki7qvjpHSu7oK6pHsxKpSU2Ympd8PRyoXg27Tq?=
 =?us-ascii?Q?vUzyOF8QUh13CWzAZ2QIhmaL7HXftR4a4U+bJ/YqK4QXrBugrHUHqCMLcDlP?=
 =?us-ascii?Q?35+NqERrG+DObsUBPkBb7Adh+Z6+1hlXrAW4iB0WC2FyiaGe3AjPc5g9MwaI?=
 =?us-ascii?Q?IMR+8P8n5JZGUcJXYr3X7as8yxR5Di9V8q5KDU7wS1Fk83dlBHBEHA1e+gqF?=
 =?us-ascii?Q?Q43LSDm17+R+kVbJWMbxLDBResZvmUtuRcCC8MK9D1b2KBCNznRtY/j+I/3E?=
 =?us-ascii?Q?SjEFHu2jyoTm1gNE5ij/0BNsT9Veed033ZfTH57em46vnP/MScgCG/48VfGj?=
 =?us-ascii?Q?4K4uW3B8voy4Ex1ABnyZ1VD4dHyGUtf+tvcunbPN5V2HyT5+WsjaxsRxsN2t?=
 =?us-ascii?Q?WliBcNzhFZEqEelEsN1IwKsL3EGs2jmcGisqRgcZ6vQHJOpyVr0rKhNzBcCI?=
 =?us-ascii?Q?cE9SUrIWgJ+dOpXXUL4SH+nuKVRUI9bUckrlc0ITG5mPCI6rAcQ3k0GEvp4f?=
 =?us-ascii?Q?FV8j/dNkeJL5EHq0D2FJ+oJoZSPmEIHFsHQ68GT6xI0ndV/lZNf7qqUswyLt?=
 =?us-ascii?Q?B6vFab1awxDbibJYKaTk1iBoaP8PAhif5Jng+l8GvR3a2dBY8RpFbV7iWzdq?=
 =?us-ascii?Q?oCGhWpHzroF9EijHllqZHMMRAZkyeSx6WXZxUuG1BdIwM+ta2iVXqB6lbBuI?=
 =?us-ascii?Q?wjKY19wt/HG0HitquyywqslWM7naq0QZjScUlZf8E4W5dPxtrP5e/oCqkY9u?=
 =?us-ascii?Q?4f1zlSkg510w38BoJtT/un95cFMKGBdrwFjsJXn0v4A6jbTflMTOXI0xT6jg?=
 =?us-ascii?Q?GlRu4ywWp/fpkFcyQX1R48ILi2NuF9q6PfD1FikCmm1hu+qUHtAMAEs7fLMp?=
 =?us-ascii?Q?tfKib6L6QVfp2pNpkF0JCBtyG7ZsOpuXHQCcBZfBkDSLMAS5seeEziP40rIN?=
 =?us-ascii?Q?GnxrPD5mvFENQsL3mb6pO4KVXbfCxv2azjt0ZLf1YAefqRyHTt6zy556drIT?=
 =?us-ascii?Q?WxURMCwQ8K4f/bz3B3/6ODom164WdMlkKwEcleH7WVIgB+cG63U+57NsHOpG?=
 =?us-ascii?Q?UPT8DdhwjStrreTUgt7y0GQmKC6qjgAXvmehizRmOhuUZU/bLTlgl8RtdSBe?=
 =?us-ascii?Q?OcNmhd2T3vSIUf2VBi9H1ShZmcuRPlERO/ZnRD8JkQqxImcEJbAyLHM+lNJn?=
 =?us-ascii?Q?ZaXCc16DtQevicbqWRTnODwsDTwSxa1ldWvgAW8SvmftvlTBmuoxLiYA1oOI?=
 =?us-ascii?Q?7/DFybEwZ1Hq/SL+1sg5hjOO7QbGMZEz9LZM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:33.9111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609de5aa-7a7a-4c8e-d990-08dd7bda2cbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

Now the driver can do a per-vSMMU S2 cache and ATC invalidations, given a
pair of arm_smmu_s2_parent_* helpers. Use them in the arm_smmu_tlb_inv_*
functions, replacing the existing per-domain invalidations.

This also requires to add/remove the device onto/from the ats_devices list
of the vSMMU. Note that this is shifting away from the nested_ats_flush in
the struct arm_smmu_master_domain, which now became a dead code, requiring
a cleanup.

Move the arm_vsmmu_attach_prepare() call in arm_smmu_attach_prepare(), out
of the !IOMMU_DOMAIN_NESTED routine, so that it doesn't need to revert the
arm_vsmmu_attach_prepare(), which wouldn't only require a simple kfree().

All of these have to be done in one single patch, so nothing is broken.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 +++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 27 ++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 45 +++++++++----------
 3 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d130d723cc33..c9b9c7921bee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1104,6 +1104,8 @@ int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
 			     struct arm_vsmmu *vsmmu);
 void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
 void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master);
+void arm_vsmmu_remove_ats_device(struct arm_vsmmu *vsmmu,
+				 struct arm_smmu_master *master);
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt);
 
 void arm_smmu_s2_parent_tlb_inv_domain(struct arm_smmu_domain *s2_parent);
@@ -1130,6 +1132,11 @@ arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
 {
 }
 
+static inline void arm_vsmmu_remove_ats_device(struct arm_vsmmu *vsmmu,
+					       struct arm_smmu_master *master)
+{
+}
+
 static inline int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster,
 					   u64 *evt)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 4730ff56cf04..491f2b88e30b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -182,11 +182,13 @@ static void arm_smmu_make_nested_domain_ste(
 int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
 			     struct arm_vsmmu *vsmmu)
 {
+	struct arm_smmu_master *master = state->master;
 	struct arm_smmu_vmaster *vmaster;
+	unsigned long flags;
 	unsigned long vsid;
 	int ret;
 
-	iommu_group_mutex_assert(state->master->dev);
+	iommu_group_mutex_assert(master->dev);
 
 	ret = iommufd_viommu_get_vdev_id(&vsmmu->core,
 					 state->master->dev, &vsid);
@@ -200,6 +202,12 @@ int arm_vsmmu_attach_prepare(struct arm_smmu_attach_state *state,
 	vmaster->vsid = vsid;
 	state->vmaster = vmaster;
 
+	if (state->ats_enabled) {
+		spin_lock_irqsave(&vsmmu->ats_devices.lock, flags);
+		list_add(&master->devices_elm, &vsmmu->ats_devices.list);
+		spin_unlock_irqrestore(&vsmmu->ats_devices.lock, flags);
+	}
+
 	return 0;
 }
 
@@ -220,6 +228,23 @@ void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
 	arm_smmu_attach_commit_vmaster(&state);
 }
 
+void arm_vsmmu_remove_ats_device(struct arm_vsmmu *vsmmu,
+				 struct arm_smmu_master *master)
+{
+	struct arm_smmu_cmdq_ent cmd = { .opcode = CMDQ_OP_ATC_INV };
+	struct arm_smmu_cmdq_batch cmds;
+	unsigned long flags;
+
+	arm_smmu_cmdq_batch_init(vsmmu->smmu, &cmds, &cmd);
+
+	spin_lock_irqsave(&vsmmu->ats_devices.lock, flags);
+	list_del(&master->devices_elm);
+	arm_vsmmu_cmdq_batch_add_atc_inv(vsmmu, master, &cmds, &cmd);
+	spin_unlock_irqrestore(&vsmmu->ats_devices.lock, flags);
+
+	arm_smmu_cmdq_batch_submit(vsmmu->smmu, &cmds);
+}
+
 static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 				      struct device *dev)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index df87880e2a29..483ef9e2c6b7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2255,6 +2255,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
+
+	if (smmu_domain->nest_parent)
+		return arm_smmu_s2_parent_tlb_inv_domain(smmu_domain);
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
 	else
@@ -2342,6 +2346,11 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		},
 	};
 
+	if (smmu_domain->nest_parent) {
+		return arm_smmu_s2_parent_tlb_inv_range(smmu_domain, iova, size,
+							granule, leaf);
+	}
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
@@ -2353,15 +2362,6 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	__arm_smmu_tlb_inv_range(smmu_domain->smmu, &cmd, iova, size, granule,
 				 &smmu_domain->domain);
 
-	if (smmu_domain->nest_parent) {
-		/*
-		 * When the S2 domain changes all the nested S1 ASIDs have to be
-		 * flushed too.
-		 */
-		cmd.opcode = CMDQ_OP_TLBI_NH_ALL;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
-	}
-
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
@@ -2765,8 +2765,11 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
 	if (!smmu_domain)
 		return;
 
-	if (domain->type == IOMMU_DOMAIN_NESTED)
-		nested_ats_flush = to_smmu_nested_domain(domain)->enable_ats;
+	if (domain->type == IOMMU_DOMAIN_NESTED &&
+	    to_smmu_nested_domain(domain)->enable_ats) {
+		return arm_vsmmu_remove_ats_device(
+			to_smmu_nested_domain(domain)->vsmmu, master);
+	}
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	master_domain = arm_smmu_find_master_domain(smmu_domain, master, ssid,
@@ -2837,20 +2840,17 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 				     arm_smmu_ats_supported(master);
 	}
 
-	if (smmu_domain) {
-		if (new_domain->type == IOMMU_DOMAIN_NESTED) {
-			ret = arm_vsmmu_attach_prepare(
-				state,
-				to_smmu_nested_domain(new_domain)->vsmmu);
-			if (ret)
-				return ret;
-		}
+	if (new_domain->type == IOMMU_DOMAIN_NESTED) {
+		struct arm_smmu_nested_domain *nested_domain =
+			to_smmu_nested_domain(new_domain);
 
+		ret = arm_vsmmu_attach_prepare(state, nested_domain->vsmmu);
+		if (ret)
+			return ret;
+	} else if (smmu_domain) {
 		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
-		if (!master_domain) {
-			kfree(state->vmaster);
+		if (!master_domain)
 			return -ENOMEM;
-		}
 		master_domain->master = master;
 		master_domain->ssid = state->ssid;
 		if (new_domain->type == IOMMU_DOMAIN_NESTED)
@@ -2877,7 +2877,6 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 			spin_unlock_irqrestore(&smmu_domain->devices_lock,
 					       flags);
 			kfree(master_domain);
-			kfree(state->vmaster);
 			return -EINVAL;
 		}
 
-- 
2.43.0

