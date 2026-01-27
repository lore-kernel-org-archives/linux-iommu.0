Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BE265CC2
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483394; cv=fail; b=LnYRvaDpI4MJfqra00zy8XB2YKZMIjMpkPTCO2+yLxp+s8n8siCBud+2m3ft5kTaMLlVk69Px3Z+oTtHGGEzcEVNJS0ffqhdmZzzbc8lqTY296LgzLvtUqzYwYaZieRgqqQSxYJAPrvGIJBDi0gyVoWrYIT4VzOf+7w6uH9GS88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483394; c=relaxed/simple;
	bh=uwHejIAKgENMtgk31QVWC6hzcFZDiRqrtkB2HicB5zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWt0X6sil8G8l702D4rFRcHIEJpt8BYcTPRtIt3/Ahf3lAEN9bXyIpu6z2dzhmRKgLvBn1I68YigAZSvDjfwVAaXiQVHR0pLWt9dVNeX0MWqmCxeNE5e2yHa2WNGAKctGFi+6oPOKH220kAgVOaFfrSoxQQOhVQ0u2/28eolVK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZxLsPqIp; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZxLsPqIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD1QNelG+IahQaNgqlOdeph4Ggvu/LyyiNA85QybFqWpEKz+J55V9Cxil+YaMKhoSro8FiKvTFgoBmGw0ddsk2ZyvxO6j2fwNSMRGmXCCuahb52z3u5Y4rga7HdoIxW3d+JklKT/U9p6Oh+Mj1g4FYoLY7oG1X9HZSEiBj6RQQ2QmjqXtJQ9qlOmgJcm6NMde1u0kkdDqaIDHLjK7ilN5jXJN/IOCbrHELZ79gfm4piBuoTMurGfd2nzgVAVTxaFh5FfhXp7GZrkC8TV7Q9DDMoc0XFxp1m4tF1Rzen8HvJSReJi80H4V7dhQElLz0vyqAIOOJJFenuxTaieblXSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n461Kx0eJMocvVPeg5efp0FLTkulazUFstAKfq71wwQ=;
 b=uudSk62Riku1714aSiL0lLUtHp5vGvGdM4+dGNuh40hHusJD46IUDPhxzP3DmOQY1wnGBJxsYThE3xmR3ZGgEC8Py0dV7x4nFrUFreIRwoC5KeHM1RNwqvL7VtCUWoSFPigDDj6HJCN0DzL+6wg78MH63v2cnm9ScOs4NW9cj85hR9hRr6tx8hBSFJT1roVqTrtxynseSQZGWDqNRasQjZ/mKogn9RXX4RyHeKgr9B/buLIjgpuVgBvak36CMAYhUqGrO6YKnxaDcufXDP0k/Ai9D7W9cmbEvlHLd6LIWv+WEaBcuQxFz347CwASWaaJngyr/tAuPDp8z/KFQWlMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n461Kx0eJMocvVPeg5efp0FLTkulazUFstAKfq71wwQ=;
 b=ZxLsPqIpgrIqaqfEw7zAX5qTaUlMBnGxSc2MFKxF/wX6MMb2ocIvWdjF9XZwBsq89Gb4TGaMw+LoKVo/HC4o4en5PotVxWUcLQsHch++A07o0NiF+qcYeAHXqDYs0KgU0e96+iQk4OPf+pGPvrBzgq08vbvkRFOxouVivqWgozJgCFE41N+YN9HAHVW8a7a6kqdRKHYjKvbP0mEsyMKPHB+JNyNdG4TRoqNBicXfH2FOuQbpuI/Liq1nlfvO+kOHJIuD6vs8aHwU6fOh3QNak5YfY5EpBuAtohyOOrIdItNpsI155uTKQV3rK5162MD7l2PQG8iax8hewjXptTLtnw==
Received: from CH0PR03CA0414.namprd03.prod.outlook.com (2603:10b6:610:11b::32)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:09:48 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11b::4) by CH0PR03CA0414.outlook.office365.com
 (2603:10b6:610:11b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 03:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 5/8] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Mon, 26 Jan 2026 19:09:16 -0800
Message-ID: <5270d84e09276a8368b413a2d9ef69deea03474b.1769476588.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>
References: <cover.1769476588.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: a77b1f4b-bd76-4926-55b4-08de5d51878d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mjDPT1iLFzcdP+Mgt9N1CWV1IMViVGoQ8BuLVouEFcpia1fjxjJBb9Z29BI+?=
 =?us-ascii?Q?a4QJk4OHOj8RwkGkKCvut3ecRVwPHEIhmB78VQyh+2csqwLVkBvsgUisC0MF?=
 =?us-ascii?Q?FpwkUVcI4PRFpnQANnLA+cMudwRpmG/V3K49KFzriLwOWlJx+oeFqPVZiIxv?=
 =?us-ascii?Q?Sy7HbMZcZJ+0fc8UofyX3ChPRZJ9e98L0iT0eot9Zr7gss+luHMoaI6olGay?=
 =?us-ascii?Q?Tl8Oi/SWtpblqPZRD8snRLafE2cef0VVQ+CrgDkwzArHN3+AiuBSXvXwB0DB?=
 =?us-ascii?Q?aCwWvkPO14TM1uBtz+E1m041Cj5+8klD2AnA2etXha7dZXpPCfCt5dTgf+yF?=
 =?us-ascii?Q?pVxYjiUckZfHZTa1LI5ZIQAwi8smCJ5aFLKz83PbMLqcboz9/0WFJuMhpLNm?=
 =?us-ascii?Q?llxvnjxPVB0W6g7KipG/lzLWT90ltnK13yqzov+wdgj4R/YlVjFARHRrW8kF?=
 =?us-ascii?Q?2YrnlT8mXU7IQp4eaIg+ZroUCy89IPEKsf/w92H3qD+rzh3HhuVyZTtOiurl?=
 =?us-ascii?Q?YYknM+4+x9KLp4G6re71zuydzyIGwadTKBY15DqHBxXqM4RosiLcIAdA/5vw?=
 =?us-ascii?Q?2+jsiBnOoxEGuo9+Wz12HD094TIzo4RPQaYLs9PMBytiZQ93zs9b33PcR7CR?=
 =?us-ascii?Q?XkMW+gnb+dtpCRBkmF4Tr4FXrmswmgwssa8DOHeuPwuVDCokFT4bHyKes2Ns?=
 =?us-ascii?Q?5MuqZeAz30/8RNAcsv9IS5jVJ9dCga57WybRHiVMIjSv+Nh4dwJH9CTx+Nnx?=
 =?us-ascii?Q?3OYoWtOT0GGLt7HtoNuF8to7qr+spfTS6T/YS7k5jo5pjW6NwSPpI7V7FLyL?=
 =?us-ascii?Q?FcTAx2PUDR8xIkzRGVPvLaLiDRMm+ey/8XLcSjH7tIKdoW1kdv+FNztHrxZO?=
 =?us-ascii?Q?VeUwwIrP8SgrkwgAucsG6V3gDKGb55AvSgEnxutaujoDPmEdaQQ6nme5wqzl?=
 =?us-ascii?Q?ef+sgERoeIG7ssr51cM6ulOLeQhQ0uckZf+PYW3Ody4MttW/2xJUsIYTr6Kx?=
 =?us-ascii?Q?eKy64lQ3wGI6huwHLaMQ5ioZLI8uDpBma69OPZq8CI52BxxwZiQrTxRJJbIV?=
 =?us-ascii?Q?BikF9yGOQZ+OnACtAtyjaDLig/KStTnsBGJ2+rqnhjxx8aEvGR7CuNZa9WHE?=
 =?us-ascii?Q?NcCHq8f7G76xZXOvOfG3SoHW5dbvYyZA4xZQL6seJtuz0d5tPRA8BpA5doJu?=
 =?us-ascii?Q?QOW8j73ITZCo8W7kBcB7fQ7ezaYIRk0lF0qxkh7RJ1JXdfza8y5nk2ggybhG?=
 =?us-ascii?Q?ZNMUo/tKUn5FTZFNkZr9PnG4hhSe3Ol3/vDi9brfUX4rK50uNhwRTYV9Agoy?=
 =?us-ascii?Q?4RizCdYftJ8swOdc+DhDzh0MvnqrQOakBW0yOYXwnew5cdg2O/ibi+DK6WxB?=
 =?us-ascii?Q?9VLJIjtn0jiOktIVd/mtoZY1PaSplj/IdN8nFPa9Ru+uY/VunTMJ5/e3wST7?=
 =?us-ascii?Q?FJpcFlYFG97iW4+EQCOm//6EWd+Kiizksn5kd5FsMUNhULF2cCmsw1WPod11?=
 =?us-ascii?Q?e+tQiuMHmMJhI1iiad3mXSkOsXzBh7dy36TpN7a4gQi6rwIQa99yM5bJ2xZ5?=
 =?us-ascii?Q?hyMfjmTOsHVXDrtBGChLwVB/2sN6cOOqycs2/syAYZPmlFQMSP9jnAA1kZ66?=
 =?us-ascii?Q?lWiYHFj+Z2PlxC9VjR+7Mf0PSTQN94dNrh7SQD/NTUO0WKA5mIoJo1nttL0x?=
 =?us-ascii?Q?tWwtAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:47.9629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77b1f4b-bd76-4926-55b4-08de5d51878d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

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

