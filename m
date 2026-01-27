Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B2329391
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540144; cv=fail; b=Q3DiauhKhAkBpIVtjXhKAz5FMiHaeAzeaE5xsxMKcaH0HVPyFWA1zLrlsKSwIOf+HpRTR7FBQpdWwdLCVyr5Ls9RWU3yvR4YrBvY8OftogGIvLQVUiK2jfPEhsRYuy98wNVgnc/Z0mWUIXoPscRg7qq77y3wVJMDmNg2JkFkYdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540144; c=relaxed/simple;
	bh=uwHejIAKgENMtgk31QVWC6hzcFZDiRqrtkB2HicB5zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClSC4Uz7q48BTUKPkHKtOrDz04CSpc3Qs6bTyTW4Qemoq67l5dH8vNwZewvgZG670gTizQMfwXPmG6XLMWWqXO3lEo1/glR4Jzvh6clra9SkUjEqINFTzzSFAvEuG5fOgHytQVfPSL/p0Czke0ORsG/1feK6QQpoogP39fIlhy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f+8ZdJfI; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f+8ZdJfI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAaeVdOXxppOqaVzHbwf8ZkoEhcd7b42dhgb2V8mAl0L5uLDgj/mGaxespNBTRIycPVOusO35Pjaxa+8n/7ALuRfUBTaptn9kFCK1yemzcI9n4O8wNXiGW9cdlYiC8U/RiMx8T20NL05v4LsFvrrfeY5ZJJFIxzsCfdlCVE8HLZuK5eA8tD5d2/g0ppYTS1h4690OJGjOtc0OUNCb/Eo14ENKC2AI4JPsk1tqT15JckATcjo9k+PQ6dirUkxE65yQuDagpb8PeUfk+lyVEkXvz8DOmMjDDjjBBH6PtXvr7I0yMyQG+Ar2hDxTjMFXJzdqa1VA2Be4bCVUK/isLJqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n461Kx0eJMocvVPeg5efp0FLTkulazUFstAKfq71wwQ=;
 b=bL6pdEOEDOFoi9HTxBLF5Ha6GtFDRIl/lAq2yRy6MrzNIF++2pGjxZjaTCiOTFUVAtruPqK0KbTK87IGmTpiLDmUzXoLXevyESBngzKKxJQ+eZLBMq0TOj0YxG/6GwF+QBLRO/rU0a4Xm+qIAbVIs6/oAroA+kTGdaCGF75Ze1qSS9tjVd6Bhocrrm6tm3hL2Z84rISenTSQIAoeDsmy6YB95fTxpL8SJfxc9UzyZ2BvYhyznDcFkBt/uI3NborBqUWiFnQPqu9UasMiThXZBFgjHnHh7gpAU/37dlZ/jX6IR6QvNXDIAZ7rnGLGuGsTVa5VtiIfOKDFIpo5o1KrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n461Kx0eJMocvVPeg5efp0FLTkulazUFstAKfq71wwQ=;
 b=f+8ZdJfI3otNhKBGvyK/YsKlSG5OjWYopd6uNCUVttmewoQXylLhuBW0deHHJ7JCvaIofsnL7A3RyCnTqKj15Z03LMjtk/qKsth558iAOffRjxJNri9FOZN+OCJaBtixMm/HChZ6EtSeZcTEhLEQUYpYxYa9T7sT6ziJKJZWB3H0VT6EYIKauEsae/GqsrPf/T3pyUyiJHy894iL8OtT50Edu5ds7pS+LFrD3Uyajym+HwWks1b2DigxkNv9N/DizcphR5Srl3O6HhewfuK3V1HA40k4IxWmMe18Wcqq9xPB2Fj14qA7KCpK0UQv9qaToPeb17KoPE/PkvGaT6AmNQ==
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:55:36 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::bc) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:55:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:55:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 5/8] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Tue, 27 Jan 2026 10:54:57 -0800
Message-ID: <5270d84e09276a8368b413a2d9ef69deea03474b.1769539310.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d474fe-116f-4aa1-aff7-08de5dd5a802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dacHFWOPfgYHqcrK3PHcxeI2Pduc2G6zTAP5YS1K+xxtJR/Jb/b3wbY1TXDU?=
 =?us-ascii?Q?vjlY2m/w4KS0b77+8WrbF2mLFsfq4ysMuQyEGh3smbt33Yy/iTFHJ9bqTb9C?=
 =?us-ascii?Q?N9zsKvEnuYDZcuBg87/CpKCgbzILdhwULH86I0wv4ZS43CaQP/ya9gYpivv0?=
 =?us-ascii?Q?1QgnK90KRbZoOpdFfuWKIPq5wXRLDp1hV7psXQYSW06/zEXZ0wNTK1tJKDkK?=
 =?us-ascii?Q?9U6BjygInjugyUI6fNZwrP7l21TMuz+WYyWe8MaBZok6E/KED7gFv22B9B4n?=
 =?us-ascii?Q?R/xkVDbhQElz4rjV5SXuVIOaYjtXv4S0PCzUusfApy5JaCsqigPor7XiXeGm?=
 =?us-ascii?Q?JA9EG5Hr3v4O2bYsl1jUOTS7htWj3NHYdmc4yMUnRUwMgpA0lkRIJCo+MLJH?=
 =?us-ascii?Q?IkeN+6aOf2rc+yv5we9+Vj6bqKWYN8D1XU1r4V7/YI1mzZ9SKxI2BBIOSxoE?=
 =?us-ascii?Q?iKgS4XSFtNx+P3xopqJZtzpwddqZ56uDl/fWFd8HdF/BqxFpBrXOqsTLIytz?=
 =?us-ascii?Q?3pLgZ2T+mM33kcG+Z83TxGG2T8ZKwWv1+PtaUutuQ0rhjeWmDZtcbah+74sZ?=
 =?us-ascii?Q?l9sUZ2D+aLEwcogN0V6hejDPodVLLZfJqYxb5oD0cZebuXCkLYmdT6Quwgxv?=
 =?us-ascii?Q?7UrQ1KJhdeYHbFWNbLMww8eUqkKcgli8y0ubMcyTp2n3fprxA1PAV/mFebNw?=
 =?us-ascii?Q?/2413XiGxn4k2WkbKhZ59yKdSMbLyf+fsK1cvlD6d+4hRV64pNO/5NvlkZeX?=
 =?us-ascii?Q?VL/PEBLyMuiPFiLwySzA1bFrADWnQTbVxww5Vdiw9ObBSSK+NH/UVVBTnyBk?=
 =?us-ascii?Q?zmZ2uMdwjvhfhcp5oAfWRfy/GBb9D2LsGL0sGJSh4Ow+btjGLEPO8apQFMjN?=
 =?us-ascii?Q?txSiWz9UKb2R3gw/A+cTn2PZ2qSK26Rk6wKURyIokXRZCSfKRFc7C0zsZWHG?=
 =?us-ascii?Q?nRg2r+uOT4k/vnX65ctEEY9EgWhYw6YbAuWWJ6tMMAP6Zk+ps3HQIEPUYPth?=
 =?us-ascii?Q?g8ow44/Q74o3N8n3Rrts3lcHo28g3VtlRC1C95qXu0g4si6LnLh3wjB9sXhG?=
 =?us-ascii?Q?O/49EA+gi7Lho4rhbrLqeBnXlPTPKpSuy7LzWbmw2Tt5uG3gujygtDQBgwur?=
 =?us-ascii?Q?KmRLB8TNhfavyH3rSFWlw1C0W/y2HhMHadBT3BdRVLl7OJxy3HeakN1ECm60?=
 =?us-ascii?Q?ix23crM6wyzE1fivAqNrWpFxejsYLPk3UmgVPISKbgbfDpDkqDcXbIZVxynt?=
 =?us-ascii?Q?iQRMIqJg6NqysQq+8Y8FNDfZqrT+n5taAjj0Qvlz0yjx3GPQmAtVQbz4B2zb?=
 =?us-ascii?Q?KQ/YDhdxbgsLQUiM1mg/t0av/4Z/d13ITpMQsjZzerylIXkv0QLlg42ALAV6?=
 =?us-ascii?Q?aSbPFd+XaBjdHp+D4Xfm4mPBvanGDFd/GL0jst45h0rOY9ELQAdRGFifgDCV?=
 =?us-ascii?Q?xJj3VpwbMrI6JDWAvK1xhU4x6DNhVABMn7ph2Jx5bzMMOhj+Bhz7Y+HBVLnb?=
 =?us-ascii?Q?7CFikvCffq375/HROdU90v3ieEbahPgWzKG8zgBAdX5gYTmyiWBU6YrNUtPt?=
 =?us-ascii?Q?07IcokY57Y0Le+HWsDcf87m665Vp3grSS7A0LPEawf0vic2YZIlIHYfw3H2Z?=
 =?us-ascii?Q?lRDZo4gYmsnR+FJRsaTf8FtplfgBzG4FTiiG41K/7pjl/FyJDcQlqlVtMsJQ?=
 =?us-ascii?Q?J7nHZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:55:35.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d474fe-116f-4aa1-aff7-08de5dd5a802
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

When a master is attached from an old domain to a new domain, it needs to
build an invalidation array to delete and add the array entries from/onto
the invalidation arrays of those two domains, passed via the to_merge and
to_unref arguments into arm_smmu_invs_merge/unref() respectively.

Since the master->num_streams might differ across masters, a memory would
have to be allocated when building an to_merge/to_unref array which might
fail with -ENOMEM.

On the other hand, an attachment to arm_smmu_blocked_domain must not fail
so it's the best to avoid any memory allocation in that path.

Pre-allocate a fixed size invalidation array for every master. This array
will be used as a scratch to fill dynamically when building a to_merge or
to_unref invs array. Sort fwspec->ids in an ascending order to fit to the
arm_smmu_invs_merge() function.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ed8820f12ba3..5e0e5055af1e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,14 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	/*
+	 * Scratch memory for a to_merge or to_unref array to build a per-domain
+	 * invalidation array. It'll be pre-allocated with enough enries for all
+	 * possible build scenarios. It can be used by only one caller at a time
+	 * until the arm_smmu_invs_merge/unref() finishes. Must be locked by the
+	 * iommu_group mutex.
+	 */
+	struct arm_smmu_invs		*build_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3f270c59f018..5a0a8b136352 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3784,12 +3784,22 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
+{
+	const typeof_member(struct arm_smmu_stream, id) *l = _l;
+	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+
+	return cmp_int(*l, *r);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
 	int i;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	bool ats_supported = dev_is_pci(master->dev) &&
+			     pci_ats_supported(to_pci_dev(master->dev));
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
@@ -3797,14 +3807,35 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
-	mutex_lock(&smmu->streams_mutex);
+	if (!ats_supported) {
+		/* Base case has 1 ASID entry or maximum 2 VMID entries */
+		master->build_invs = arm_smmu_invs_alloc(2);
+	} else {
+		/* ATS case adds num_ids of entries, on top of the base case */
+		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
+	}
+	if (!master->build_invs) {
+		kfree(master->streams);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
-		u32 sid = fwspec->ids[i];
 
-		new_stream->id = sid;
+		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+	}
+
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort_nonatomic(master->streams, master->num_streams,
+		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+		       NULL);
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
+		u32 sid = new_stream->id;
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
@@ -3834,6 +3865,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3855,6 +3887,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

