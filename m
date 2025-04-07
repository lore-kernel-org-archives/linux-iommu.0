Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1F190485
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057185; cv=fail; b=DrA/169Q9FpMHjm+fwY0GdlfFJ5Akee0pvAIuCCJ+CKHao6LdjzS9WKaORbgrDq55r+i91OkR5ToDje+UZoYj6JqXJKKVEjhxcz7lwLj/ajQbQq0bIzJemhGRczP/nwjzdumH2TtNfivp2oCtMVKmJtMG3dMIIdFAOwzHUhFrm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057185; c=relaxed/simple;
	bh=8nSlrlckgZjQwYfQBH8bfdwCCOUHlxRZ/ggOoW6b2ug=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iPhry0y6gF5TzQBq3H6dnpM8cmu8tX3VPa1I9TWW5HTcUfsmCp0UAqG2tcw3THUTxnhZ5fEl3ujvF2mAdKXgEZCZXRPTQOAtrukOwFCEzUtSL4CLblU+LCVAnqAshwGFTVNvPq2IaaqJAlgcvYz/Awf5Xk2RGEN5A91NPuI3ZI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMoLTM9H; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMoLTM9H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiMOLNZoV3k0yuVJr8ZsQFNnwNuhLjy++oatVArvFzO2K56oYUT7ObiXlTigd0O7kycsaUdHP4U4yjrazhj8eLxxvjIEIot0ye/euqtTJcSednysRTJFWqGxeNTjTku22Nh/qdGvYbXOSVC2oSvOpgucDBQEQ+vdbncqo8Iq7sGQvZZCEQ5bPtBsroGZcVDt6KRuECAfMr/mLZ1kg1mTCo5qEsD4Dj5Vj5FhubmSzN8xwNtH11FpTv19NrWLtIueiS4MunitgnjGVVReEq5mLVFcG+xW0ACWGgUOW+nwD3YNYLGQEJuK/p28ioqWxPiXzF7ZLjQz652S1QSsHekArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbg6Qd3xCJluU1cV8mntruaMRsjUzROwzRL/buEXd9s=;
 b=hUDh5ziqTiZzoW6/LhP8VzMsjzWYRLlY9bpxhbdHCTfzxDfnUxjjo3z97mtZ/CIy+SZY5jCMklLw6c6MsYDPbm9fvICFN+emH071VQp/RDUwKISSqhODCf0r1xBjbmBbplPTRi6v7gZm2eA2KCp2LVjHlq+3MDy4vJ6oI9t+xLhRIHomHXtK2veiW2DXpGM/o+RbEBZL/hyzeJSP9+3Mrl6JoWj5LO72VEtrmt88p03VTlMjp0Ww/RBlCyzryjkjirCI5SSrZbXlhzIARmlsOXk1KnTYrcLpY2ohBaMBhBojQzCatuiVPoMuUoZENogxzAeuykaulu5hKxRAQv0Kew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbg6Qd3xCJluU1cV8mntruaMRsjUzROwzRL/buEXd9s=;
 b=KMoLTM9HLDlbq3/dCRQ8PTvOrutn5w4tT4So+uJj2z0GSo95WVTMYsua2CI8Fksl+M/LQ2z7q95I2jagTTD0lkdTOigcKw1E/rxn3aHZqSwF4whAFFCt0hcO9rzryzS6N4WqFu5zs9654DHWnu4i3PrFSsfdTkrQJJO56RbhKqRZQcaPuyyomUY8g3+56CJkHKygFa5emqflF2zYYyj4g+z8iATj/tfkxNZjXdMzrDFm57IhuUJ8wQFBuwF2MCDfKwJweqf8xABYl10UxX+Myqi71M5Sb33FrA18ubf8vtH8Sfls12Q47T/ydKsFODM5EU20F2tL1L5Ayvl/4J2daA==
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 20:19:37 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::b1) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 20:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 20:19:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 13:19:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 7 Apr
 2025 13:19:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 13:19:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc v2] iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()
Date: Mon, 7 Apr 2025 13:19:08 -0700
Message-ID: <20250407201908.172225-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b8e63e-b884-4be9-d844-08dd7611849a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?retCluH7arx1ZeObrJa7k3rB4T3dOzaaLMKwr6xKptZgBWntoZXiQ5iUgX9O?=
 =?us-ascii?Q?KUsXylsaXjNtPJ1su3DrE4rGgIZEjlTgyp5KoejpXZ8HWM7UAezh0rJF3RaP?=
 =?us-ascii?Q?RfjYTjrK5Go5/E+hbcWAdGoABy1py1SrkaUndVsMROjTHyzNm5LcYtzocKML?=
 =?us-ascii?Q?3UecWCi1bgk+vZF11JaDksG5uEIQaVxDnZsJPQ1qmZe+Fiu4xCp8z40+OhRk?=
 =?us-ascii?Q?0eo/VLUh3l5FghjhWeYojJRJY/DKsIS99Dzm+l1A8Cvj2U446DMFdxlqMSuH?=
 =?us-ascii?Q?rHfkrr3KSQedKSUjnPk+RHXA2mMZHNO3nyngBEHAQyP6sheiisYy9zIuXtua?=
 =?us-ascii?Q?vFXFAfMi2pF3TeuELtC6UDTPv3pooSZHRTDAb4eE3dZ4ZSMlEZi56YLEuDIh?=
 =?us-ascii?Q?Op5dgSpk0CunjY1BnPBePTiM9m8g2dLzW33cnE/fedqbbv+J9sSKQJVnYE+k?=
 =?us-ascii?Q?m5CdUodaXmhFnLaqPldpFiWq+tO4DK+4BOyi8sysAjL1RiUaAtbY1W6w0ZaO?=
 =?us-ascii?Q?PFHnKFVuqYH/ptm6NS1dfAEXkEQDLe4AOBeuwsGefjyumnYMpC8EYIaicB4I?=
 =?us-ascii?Q?jzNpjJ7imIMtQ9N4qpiXdP/yxWrfabjPrB1U9YyX6ZW/lIanYOyga8RWdGVo?=
 =?us-ascii?Q?8DDVC7AwRHWRY1zSnDscRIxIJkibHHqDOip4ErJSYTr8FmCME2HaT8/C3iqR?=
 =?us-ascii?Q?EoesosReW0eAnspfjVGS2ikgqHzu6SdZYXZGkiSxPv1ZY8tfKhTG4rUJPalj?=
 =?us-ascii?Q?sPpk5t6L7xuTMcj9huzUA1sYpC6STbsBKrr6qhT01Nk3cOi/PZpZeBbzru9r?=
 =?us-ascii?Q?/qNWYPfhpxHUfBwxYkDq8wqP61UVfwHv/XuO/GSGuYzYPtUW1WLJEq571PDf?=
 =?us-ascii?Q?gz2y4g0YRuW/R+wjkdFhjelbzS6sp3D3FlxBFkL+Kzdcbrj9ovQKELm7kx6R?=
 =?us-ascii?Q?+mUroFEHWA7B+/lzw9Bu8xFkgc2jCJ9JLj2h9SXLm46CgIN6aBwElk5lV7eC?=
 =?us-ascii?Q?BFIIwG6xg7tSL04TgFFM+P3sNuP7Q6345cDq7STT+cVJj3Z0Nt2pe82ounUz?=
 =?us-ascii?Q?FfhBoH3Hgx4UqHkopdWYkhkH+rwAEjH5FNYm5VQEZqAhC3kFvcnXpHTMhv4Z?=
 =?us-ascii?Q?RxrUUAn9bpGsUgZQtEaCZw/BaGICl4O3rRCYyMHV/zmEph8LlRR8HvqpQyIb?=
 =?us-ascii?Q?NveBEea69uw8wEbDhQtzjNfVzv0gfhFG4REPioBshlUrDfFVm3f+yLYwWLoD?=
 =?us-ascii?Q?ImLP91a58eVhPFZzr/vn6R3ajEfjAmm99FimfKYN/ZXCcTaNJnsMzspX1glT?=
 =?us-ascii?Q?0Tcm8AeNQkEeL7bFGOkYvS8pQdjsRQsRDLDH+gr4z+7N7gaE202dX92TjKlu?=
 =?us-ascii?Q?uEye2neOiH1dxEUIbYxiGDKWvmR8Zcfio6OdAP5+Z7WKIMCKb6Y9LqSAafq4?=
 =?us-ascii?Q?vF+9Db58UnXyMc/PCdkOv9bhFwZXLLoZnKv+oMa8IN6VrGErwoL6gL9V2z4g?=
 =?us-ascii?Q?//u4YK994r7aBxE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 20:19:36.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b8e63e-b884-4be9-d844-08dd7611849a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630

Two WARNINGs are observed when SMMU driver rolls back upon failure:
 arm-smmu-v3.9.auto: Failed to register iommu
 arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
 ------------[ cut here ]------------
 WARNING: CPU: 5 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0xc0/0xd8
 Call trace:
  dmam_free_coherent+0xc0/0xd8 (P)
  tegra241_vintf_free_lvcmdq+0x74/0x188
  tegra241_cmdqv_remove_vintf+0x60/0x148
  tegra241_cmdqv_remove+0x48/0xc8
  arm_smmu_impl_remove+0x28/0x60
  devm_action_release+0x1c/0x40
 ------------[ cut here ]------------
 128 pages are still in use!
 WARNING: CPU: 16 PID: 1 at mm/page_alloc.c:6902 free_contig_range+0x18c/0x1c8
 Call trace:
  free_contig_range+0x18c/0x1c8 (P)
  cma_release+0x154/0x2f0
  dma_free_contiguous+0x38/0xa0
  dma_direct_free+0x10c/0x248
  dma_free_attrs+0x100/0x290
  dmam_free_coherent+0x78/0xd8
  tegra241_vintf_free_lvcmdq+0x74/0x160
  tegra241_cmdqv_remove+0x98/0x198
  arm_smmu_impl_remove+0x28/0x60
  devm_action_release+0x1c/0x40

This is because the LVCMDQ queue memory are managed by devres, while that
dmam_free_coherent() is called in the context of devm_action_release().

Jason pointed out that "arm_smmu_impl_probe() has mis-ordered the devres
callbacks if ops->device_remove() is going to be manually freeing things
that probe allocated":
https://lore.kernel.org/linux-iommu/20250407174408.GB1722458@nvidia.com/

In fact, tegra241_cmdqv_init_structures() only allocates memory resources
which means any failure that it generates would be similar to -ENOMEM, so
there is no point in having that "falling back to standard SMMU" routine,
as the standard SMMU would likely fail to allocate memory too.

Remove the unwind part in tegra241_cmdqv_init_structures(), and return a
proper error code to ask SMMU driver to call tegra241_cmdqv_remove() via
impl_ops->device_remove(). Then, drop tegra241_vintf_free_lvcmdq() since
devres will take care of that.

Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v2
 * Fail tegra241_cmdqv_init_structures() and let devres take care of the
   lvcmdq queue memory space
v1
 https://lore.kernel.org/all/cover.1744014481.git.nicolinc@nvidia.com/

 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 32 +++----------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index d525ab43a4ae..dd7d030d2e89 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -487,17 +487,6 @@ static int tegra241_cmdqv_hw_reset(struct arm_smmu_device *smmu)
 
 /* VCMDQ Resource Helpers */
 
-static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
-{
-	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
-	size_t nents = 1 << q->llq.max_n_shift;
-	size_t qsz = nents << CMDQ_ENT_SZ_SHIFT;
-
-	if (!q->base)
-		return;
-	dmam_free_coherent(vcmdq->cmdqv->smmu.dev, qsz, q->base, q->base_dma);
-}
-
 static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 {
 	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
@@ -560,7 +549,8 @@ static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
 	struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 	char header[64];
 
-	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
+	/* Note that the lvcmdq queue memory space is managed by devres */
+
 	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 
 	dev_dbg(vintf->cmdqv->dev,
@@ -768,13 +758,13 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 
 	vintf = kzalloc(sizeof(*vintf), GFP_KERNEL);
 	if (!vintf)
-		goto out_fallback;
+		return -ENOMEM;
 
 	/* Init VINTF0 for in-kernel use */
 	ret = tegra241_cmdqv_init_vintf(cmdqv, 0, vintf);
 	if (ret) {
 		dev_err(cmdqv->dev, "failed to init vintf0: %d\n", ret);
-		goto free_vintf;
+		return ret;
 	}
 
 	/* Preallocate logical VCMDQs to VINTF0 */
@@ -783,24 +773,12 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 
 		vcmdq = tegra241_vintf_alloc_lvcmdq(vintf, lidx);
 		if (IS_ERR(vcmdq))
-			goto free_lvcmdq;
+			return PTR_ERR(vcmdq);
 	}
 
 	/* Now, we are ready to run all the impl ops */
 	smmu->impl_ops = &tegra241_cmdqv_impl_ops;
 	return 0;
-
-free_lvcmdq:
-	for (lidx--; lidx >= 0; lidx--)
-		tegra241_vintf_free_lvcmdq(vintf, lidx);
-	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
-free_vintf:
-	kfree(vintf);
-out_fallback:
-	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
-	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
-	tegra241_cmdqv_remove(smmu);
-	return 0;
 }
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.43.0

