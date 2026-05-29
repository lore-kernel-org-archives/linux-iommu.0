Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B046318BB5
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045910; cv=fail; b=qd9YodvHp/fmnnPzLpDmj1enggNfXx5gUIYzj1Izk4SKX4+LaNp7OpEmaP0mjf+YBzofjPRu0CD3o95utlrLb4wPciorMo7PCsByXIhRTVhAgqj613QTZZdwN0jViRBXXV/FsMfIEHk4JN2oUySGHAjDeR5UOdV41xfglk1zqMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045910; c=relaxed/simple;
	bh=lB29jDG4gtVYEHHyrtBkWCODPB3yoZhIPLqyD3U/0cA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=idVHK9rxZZ7gtTDqJrjyUC1SYB5ZRIs+sftvNRBgcn1aLZXWUhOla1WRKpYKhgeX+RCdJAkLgDiu3AElxeSwuLPrpXEaUqqVOJGiUcADXiigcyE0Tunr67H1/O2pprAp6NT1VFSvGBrHt6MfW9ED9i32A8YXFy+eNFpo+5T+gzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6elDilQ; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6elDilQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxYTCYLgPk5WQ1sKaAudfX9i/Z3REf49f/tnD1CUYLsDDrEOGCwVB6MWeijAxPv+5dkfaQ9hccrVa/NNhfOEBF+cnSJRklaSu1kEBjifLtNiTFDaBZ2BJfdimgRJM4AomETOpH90p81wb8aTyznrn/Arfmy8k3nnYv0QPN4mkp+n5JW2AjoIEFtJIDtoUCuUOSkWeEcOjlgYlpTaoIt08si4Fwx5MnbLrzLC3Mq7vK/zBsXGLu0LOuneTJkKv2fA1JuxxbD0Q1JuvpWXHXEGfUkWL13lGKnbWGuSdXqNCKeA14YFvK9VlBoxgnvqpEzhs70v+CLKc6EgtwkKbHnRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqAuhOzE2ps9eOoFTmvVyRq00kM+so5XUon7eW0uSAg=;
 b=AJv0tyq2aUgSepRo2+PvURHYm/buNHYRbhxmsD+RSjyPDgCCoW/Xzh3gTDi9yVhuRDV00e0zINFf3gkIAPdS5IYVpecba8RYFWbGLlYDzfq73qL8DXxzlpXdCnj+/jQucksMWX8VJi5KnJjiTrnrZtjG5juCu/397eH8984I+B/nNmS2AuaYCtEbfMiNo4ZoOFDYuRyCAp1531N8GoAGDqEWRbT6fu1tlYXgytcV2CeqcI5W1pGGPTjnRiXhHoQlPaXqvOLHLQajc1R7Rr45HXYhr0XRj1rlf7YumFfLpkOtp87nZcSFaYlzXaL9cYTaSxTd1EsrB51TT7J5R3fmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqAuhOzE2ps9eOoFTmvVyRq00kM+so5XUon7eW0uSAg=;
 b=D6elDilQ1LmrGUh6cZKUiQUUlpFRkb7m+2OtlWGjFSzruhCQ69BmQsV780jUBOBqBJopBsvUyZ95qKh2IH0MkCILZKpcJwk2yv0KgHV7vg6UgZJ/Zbzzf03qHx9sTypN6/XzxE7xxMUnCSScazUaTOdejZ2xLiSGlKXjRiReVFUnNuECnHykIobDBCeJ6zwoz6RGBcHFMFXMug1f1/bKxc5oK02kcMVxXEww5r4A5TUwDhNpivWha95Tg/GLGgweUkEJ3GhuJEiwhNObcEkvYpcGiAEAndz9e8i1TEnIIyRRiZXv5GaG7IU0pukdZPzGQuAIMfL+/u9pRi7DJLBmXQ==
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 09:11:41 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::30) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 09:11:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 02:11:25 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 02:11:22 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <nicolinc@nvidia.com>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH] iommu/tegra241-cmdqv: Skip CMD_SYNC flush during remove
Date: Fri, 29 May 2026 10:10:52 +0100
Message-ID: <20260529091052.317102-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7e7e13-9444-405e-d060-08debd624bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	1cKt66UY7xiCYC0YzaWQSVpMTl57Lj/5y6rVAKEDu+laeQy8Qy0XA3KeEJHqZL5sX/qmyIEGjb12krClgJpUphwe2e+nii+zO7Pg9RR7LqKvW283yiff/qRYT1ccft0xovas6U18ndE9KjPuJTM6QNRTmpG7juH3jx4yTR762vFZrtRwC2Wc88fe96taByck+Hc18DEFXPUrX2aNMe2xWgaba8BubUCAWJSbRKm3oR3Mcxr25HU0J2x+KuIh4JQSYGLl04tyJw+UehWLWo45/O+GjI+W/XpmhgP+n43/MlKU/WyEnLrjy344AgCxq/COcPRofTnzepN9zZ0/H7zx/76sA7YQAoO/iDXFgAirh91wUoCOOQzfNIhO245BNUpD8itEYPoTGnwkIQ97SHVCVr5DCQwwbvolPvfvuQoAdokcYjg5u1lqTxb6fqUt9qNkW1ONqbOrDwq7eHWkz/+apQXd5gO+48h6yfkH1VEjQj/fZUSDJot5KJ+lwZOI6qtYTnvRLuwY3xfqg8EGbiCa7THD7GwuA7mrRqtcqzxjVKwO2ib4yipW/AGMRt7tPBk94kMDvO0RU9bV5XedLeh1ad8PBezqlH384cnSG6NZUWO0+T3YaM07imrqzhIIGUzgrpNPoDmi5enAvp3D4yihtb578JujTrsBFR1mHreAafECoTQ2jgwoN1HG3ZYIZAXqzfmfVbKGWKvvdkRpbCuFI3w6Ptq59m3TwlG0HY2wkNY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rcBZY3Yu6Qu51SyK+y2YhbCFvhXnwW7eK9budV1thNNw7l043CszwoB8VJfZeZms23ROC9E1WNejzkblzNkkcRtvA7khRkvnXLliLUiy2XQFR+fZCW5okdpUiuIO7sBB+OpMGGcNulCPBB9iFQ47tZD3VjuYoQFNgV6dzQ78oYN1C/+V6FyOCCGWHpZwnNLfR/+ilNVyLkDrAqjJQOm//hDY08S9zO8Zsm/FXn64B5b+QnvNPfHeq4Soj/h5Y4c7DvUj3FwjjGsa0A4n6cFztzMKPKgGUsFX5tuKSvBVdsdaZoYkzLtwIVghjwtR0r0ZNWzKeoSKkYoZ4I1jZlTb8Bw06a6ndF+Ecr/muk+qW8ZxWJUcKoqOKYopt/uz48ZceAipEKk6bhsJ3WRqqWZkA7/rvL3WBWgaPrDtI3kVfJ91nnl9dtoPNSvxid2Txv+D
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:11:40.7291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7e7e13-9444-405e-d060-08debd624bbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

tegra241_vcmdq_hw_deinit() unconditionally issues a CMD_SYNC on
smmu->cmdq via tegra241_vcmdq_hw_flush_timeout(). When the SMMU is
being torn down (eg: probe failure), this CMD_SYNC hits freed
memory and UAFs. Observed during testing with a QEMU hack that
fails tegra241_cmdqv_setup_vcmdq(), so the guest sees the VCMDQ
enable as failed:

 platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: failed to enable, STATUS=0x00000000
 platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: GERRORN=0x0, GERROR=0x4, CONS=0x0
 platform NVDA200C:00: tegra241_cmdqv: VINTF0: VCMDQ0/LVCMDQ0: uncleared error detected, resetting
 arm-smmu-v3 arm-smmu-v3.0.auto: failed to reset impl
 arm-smmu-v3 arm-smmu-v3.0.auto: probe with driver arm-smmu-v3 failed with error -110
 Unable to handle kernel paging request at virtual address ffff8000891e0098
 ...
 Internal error: Oops: 0000000096000047 [#1] SMP
 ...
 Call trace:
  arm_smmu_cmdq_issue_cmdlist+0x320/0x6fc (P)
  tegra241_vcmdq_hw_deinit+0x98/0x168
  tegra241_vintf_hw_deinit+0x5c/0x1b0
  tegra241_cmdqv_remove_vintf+0x34/0xec
  tegra241_cmdqv_remove+0x40/0x9c
  arm_smmu_impl_remove+0x20/0x30
  devm_action_release+0x14/0x20
  devres_release_all+0xa8/0x110
  device_unbind_cleanup+0x18/0x84
  really_probe+0x1f0/0x29c

The reason is the devres ordering. arm_smmu_impl_probe() registers
arm_smmu_impl_remove as a devres action before arm_smmu_init_queues()
does dmam_alloc_coherent() for smmu->cmdq.q.base.

devres unwinds LIFO, so q.base is released first, then
arm_smmu_impl_remove()
 tegra241_cmdqv_remove()
  tegra241_vintf_hw_deinit()
   tegra241_vcmdq_hw_deinit()
     hw_flush_timeout() on a freed q.base.

The flush exists to drain a guest-owned VCMDQ's pending ATC_INV
TIMEOUT before the VCMDQ is handed to the next VM (see the comment
above tegra241_vcmdq_hw_flush_timeout()). impl-remove is not a
handover: no VM is taking the VCMDQ here. The next time a VM is
assigned a VCMDQ via the IOMMU_HW_QUEUE_ALLOC ioctl, this host
kernel driver's tegra241_vcmdq_hw_init_user() runs hw_deinit() ->
hw_flush_timeout() before the hw_queue is returned to userspace,
so any pending TIMEOUT is drained by the host before any guest
sees the VCMDQ.

Mark the cmdqv as removing at the top of tegra241_cmdqv_remove() and
skip the flush in tegra241_vcmdq_hw_deinit() when the flag is set.
All other hw_deinit callers (in-kernel hw_init reset, vintf_hw_init
failure unwind, user-mode lvcmdq destroy) run while smmu->cmdq is
still valid and continue to issue the flush as before.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 4915ed96baca..b336b0bffe96 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -208,6 +208,7 @@ struct tegra241_vintf_sid {
  * @num_sids_per_vintf: Total number of SID mappings per VINTF
  * @vintf_ids: VINTF id allocator
  * @vintfs: List of VINTFs
+ * @removing: Set while the device is being torn down via impl_remove
  */
 struct tegra241_cmdqv {
 	struct arm_smmu_device smmu;
@@ -226,6 +227,8 @@ struct tegra241_cmdqv {
 	struct ida vintf_ids;
 
 	struct tegra241_vintf **vintfs;
+
+	bool removing;
 };
 
 /* Config and Polling Helpers */
@@ -452,7 +455,9 @@ static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
 			readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR)),
 			readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, CONS)));
 	}
-	tegra241_vcmdq_hw_flush_timeout(vcmdq);
+	/* In the removing path, smmu->cmdq.q.base is freed by the devres */
+	if (!vcmdq->cmdqv->removing)
+		tegra241_vcmdq_hw_flush_timeout(vcmdq);
 
 	writel_relaxed(0, REG_VCMDQ_PAGE0(vcmdq, PROD));
 	writel_relaxed(0, REG_VCMDQ_PAGE0(vcmdq, CONS));
@@ -789,6 +794,13 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 		container_of(smmu, struct tegra241_cmdqv, smmu);
 	u16 idx;
 
+	/*
+	 * tegra241_cmdqv_remove() is added to devres at the very beginning. So,
+	 * at this point, devres has already freed the SMMU resources that this
+	 * path must not access to avoid a UAF.
+	 */
+	cmdqv->removing = true;
+
 	/* Remove VINTF resources */
 	for (idx = 0; idx < cmdqv->num_vintfs; idx++) {
 		if (cmdqv->vintfs[idx]) {
@@ -932,6 +944,7 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	cmdqv->base = base;
 	cmdqv->dev = smmu->impl_dev;
 	cmdqv->base_phys = res->start;
+	cmdqv->removing = false;
 
 	if (cmdqv->irq > 0) {
 		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
-- 
2.43.0

