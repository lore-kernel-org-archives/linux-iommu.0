Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9E232785
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743409; cv=fail; b=UiQIwWUN2hX/F/stLS2uro2DJLxrv+Io+PfD2JrJA1ssL5TJyjfLUp4GwC/vEPPLLxkabwHVmyIDh0ihpWRQGwHYHI7JIJmqTyNB3xl/kyjk86fawFpXFgXYecTnsmziwU1d6gb+Z43Vg/wvndDYWOYWJrHP+HuXz18KK/dPUgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743409; c=relaxed/simple;
	bh=je9WZ4AkxWDAfJMF7P7ZeCvAIPWwFbSPolGHpHpFRsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1PNCd4pohkNMN2Tw3ppSgxhN+yACfVuwemhtEZYhwAnjCIYoageRghLuM5ucYxsZqDfWIhfO954AO9kS2d7PXZo5Tsvm0cI0Wa4hNraUm/7FE5gWzdy7VR61gOVkOF4lc5QL4u0DHyz6AM+7R+DPCyh+RIQtQWxNf+awVxTVLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mM5ZeitQ; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mM5ZeitQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvs8GuCzwU5JLhRtjqtkQ1VobWbgfwObT6S8mb/0x/NPj6Gy6X0OsC2+1BfNmCmxRQ9FvtnX577LubdUZ6ej9Vy4GMsdwXcBwL/4O96V690Fsn5o316gTUOyGkTp9JEvPbHCxDKIRfTfldR8MtQt0hFnwiHGEW2PmvMdhr1UTh1gEdyi1/uJ4TK94ypZ2HpXV4tZTh2ZpP93D1x3EK6w/sASbPJncXTfxi2TI3MazX5oFIquyJmseV2wn+jwYy2Z935MFCRSEcojbmnvk9fWNudBHm8vGV+eOkEjaDP67BtmnD+JAQfr0Xvc76LdBLmxQK4jzOrF8yToMDUk9D8fzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILqV0En9UQrzW1xudpEGgiKQSzDlDOlURGzTRSeX+3w=;
 b=LDTV69aNHvucaXOurBYZ0xwz1yEkHlDfnR54iUI7z0Sl+yig98PA5pdP1fFxeVGDW04HJP8TxyVfJzl/IXD6e/1tszQtT+/GUX7UhFOiJiWZjbTsnn2LZNGqIy7B2WLir3VxK4R4mJSkdp/Ga4REPkugCSZ2jji6gRvonvMK/ZGIWJKeiTX/kVMqhOkuWBzaSZAbn7d/bhBVCMRzlq5fWCTt9bT3gFd0iuF7DlH7BNV+h/WJauXmovc+PUYfNAhyGJMxzdKrdSsSzUv5jzLZwSjDX1BmpTy4ybgiHL4TNsAGGz0iHvNJVYnIig29vVAIlNgIB+kyV9bmghcWTzZPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILqV0En9UQrzW1xudpEGgiKQSzDlDOlURGzTRSeX+3w=;
 b=mM5ZeitQMaWxqPWO0EI2PjDRCxTUjbzLy73ebGv2ZgM5OBzFWn6G1/PIBZn68pNRY0UWsh1ETcBrRHVwH4x20ANB7S0suR+PmStdV5kqZ5v6WMl/SI6Utk7FVmY6Z6WnDWAXrMwNiVBTvIacIJX2z6zoM8XZ8Ea+t85oMLeouNTPCGZHikmBJysJBSNy1WofU6A6FjUfS8SHRIOiM6Zpiftu3eAxGsnY8ecK/yKAPlt5aNK90awX/Bi+OLsvw9+BLUy5TgNmtD7tpVnFS7mr5QoexkboXNhtuOp/LtvN+O5cmwl0aXrJtpWmXfY/DPageQqdgrI0jl/f5xyoQdF/Yg==
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 18:56:43 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1c) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 18:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 18:56:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 11:56:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 11:56:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Apr 2025 11:56:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <jsnitsel@redhat.com>,
	<kevin.tian@intel.com>, <praan@google.com>, <zhukeqian1@huawei.com>,
	<Jonathan.Cameron@huawei.com>, <jean-philippe@linaro.org>,
	<eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc v2] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids
Date: Tue, 15 Apr 2025 11:56:20 -0700
Message-ID: <20250415185620.504299-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c34037-bbb0-44cd-2a11-08dd7c4f4361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxYx2JLsHP2La7NIZGLAWVxuWS8GYHe6djI8D6DkSbZT9WedJzoZsKsPYayT?=
 =?us-ascii?Q?3oiUgVi2e/gigBz4n51J1GefwH1278kqiqU9tjf77CGYnjUGfFAzQZl6hTLt?=
 =?us-ascii?Q?blToNiDbcBuFa/UVr6sRebeJFjIOvutTXuMqXjjkHbkL8MY/RTMnjkxfJncn?=
 =?us-ascii?Q?RRtXBGS/SU8rEFHcYIBySsWfOWYitoC6Ac+g5xSeXgZQYkvM/mEZb1NMuuxm?=
 =?us-ascii?Q?KpTDcwIEIZc7qId/Bgm+GHj0LzfEy8l4oRKBTxPc/wLyMixzTUtMH3O+oEbq?=
 =?us-ascii?Q?emevMMWqWXcDvuDU8M7XD0oS4SmwSXwqQlXttjKzUTVe5flr6/6ekxZ+IUN7?=
 =?us-ascii?Q?96CuCyRahv0fG9mG1p9KgoyTSZVLvzI2yQ4vamluOJgeYdigW2Ui5RsmXHwu?=
 =?us-ascii?Q?huQg1ktB/jnVyPaI4la4vWM6SMV/vVv2q9PTH0u3CQIKfqjZj4UXDebq7yxY?=
 =?us-ascii?Q?q2JUvS+eOAHQWZ4VpFHCxaM04FLu4vgzibx089keT+95T2U4OqG99IPJ15gg?=
 =?us-ascii?Q?kkI6Y/xevERgL7zaENV8fgmQMPBgx8T+7RGlT7JMzxbeMvu+v2Up0eGwgbOa?=
 =?us-ascii?Q?BDl5xkXkYQ7cnyJOguXVoHlGlk4ylHhNbod2DoLnx2eJ53v3y5snINjjrVpT?=
 =?us-ascii?Q?173fmpRLOFAeRSuHuxzNElWgt09QBHY28s+lrn1hoB10IgmzuFuXFPFKIJjI?=
 =?us-ascii?Q?HOJYFz+LPeE6eXVG4KBF1FpLrx23NxaNkAzrqrhuEnmFGgizl/OuomSkMkjh?=
 =?us-ascii?Q?Xx4obuwnaD3mEeeclhuna9YX0Nhuv6h+Sp6F3hgFvMg+fgdP5apiX9Qtn4GP?=
 =?us-ascii?Q?PsLt3/SKsqwUHiLCAfaFwbtLbyF059tA8uriXHen8wU4AwXGtzMWcmFzxQan?=
 =?us-ascii?Q?hni3zcaCMUOUPluJ9pUWnqGyJ8YRblBtculoC7/GMJhWQ6mwybxAgmdh2Qt4?=
 =?us-ascii?Q?rfp52K4A3KHBf1b5kSV+JptZQAeRXkeBHewWZLivRd2rvGD0eV91gIvOj04t?=
 =?us-ascii?Q?aB5sEP8x5m6cjS2dFQxIeZ0PdJs2CTCM46v+DaWiMt+8JnNVo7XBGmqv7ax7?=
 =?us-ascii?Q?1SEB3HNd2CToFM4bhZqavDMDjQoNgkqhIfVvT7avMHz2TCb5QGzvMFPY0Xj8?=
 =?us-ascii?Q?nidYTUsUQC5cskE9oFSym+DOKPxEk9RUAYyG94o3O9gi73Z6DC3NFjgnSfZ1?=
 =?us-ascii?Q?FZETcDMO0W2XFkCJIjiZnEeYM/LD54I2RjjmhnTO2bClHLGpNSVY6NPyqkb9?=
 =?us-ascii?Q?wOWxLKi3NEePWi2zayTtDzM7NNsQQDRO4sOHriaibNgWixEcTVBE6mQgzrMx?=
 =?us-ascii?Q?LZWqJPmtmWVBpI4jaOp5KvWNUDQlXGIzEvfF4lAjThgXo6gGu84D2q8ARop2?=
 =?us-ascii?Q?6YdBW4EfDDHsq+0gzX7LVphUjs7JOKc9+av3vk1OMkwgF+ym5qeckHzTqV8A?=
 =?us-ascii?Q?iMhtgm0XH5TmWRzJwa47NWVn5HGNos8vw9dZE81JETOy+g0GQzLps0+9NCSN?=
 =?us-ascii?Q?S6VX6P39BUPyEBT6v8P+X6AalG+B7d9oNkfDv3XZrOOvuqSV4ES33SrtIQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 18:56:42.9617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c34037-bbb0-44cd-2a11-08dd7c4f4361
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

ASPEED VGA card has two built-in devices:
 0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
 0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)

Its toplogy looks like this:
 +-[0008:00]---00.0-[01-09]--+-00.0-[02-09]--+-00.0-[03]----00.0  Sandisk Corp Device 5017
                             |               +-01.0-[04]--
                             |               +-02.0-[05]----00.0  NVIDIA Corporation Device
                             |               +-03.0-[06-07]----00.0-[07]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
                             |               +-04.0-[08]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
                             |               \-05.0-[09]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
                             \-00.1  PMC-Sierra Inc. Device 4028

The IORT logic populaties two identical IDs into the fwspec->ids array via
DMA aliasing in iort_pci_iommu_init() called by pci_for_each_dma_alias().

Though the SMMU driver had been able to handle this situation since commit
563b5cbe334e ("iommu/arm-smmu-v3: Cope with duplicated Stream IDs"), that
got broken by the later commit cdf315f907d4 ("iommu/arm-smmu-v3: Maintain
a SID->device structure"), which ended up with allocating separate streams
with the same stuffing.

On a kernel prior to v6.15-rc1, there has been an overlooked warning:
  pci 0008:07:00.0: vgaarb: setting as boot VGA device
  pci 0008:07:00.0: vgaarb: bridge control possible
  pci 0008:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
  pcieport 0008:06:00.0: Adding to iommu group 14
  ast 0008:07:00.0: stream 67328 already in tree   <===== WARNING
  ast 0008:07:00.0: enabling device (0002 -> 0003)
  ast 0008:07:00.0: Using default configuration
  ast 0008:07:00.0: AST 2600 detected
  ast 0008:07:00.0: [drm] Using analog VGA
  ast 0008:07:00.0: [drm] dram MCLK=396 Mhz type=1 bus_width=16
  [drm] Initialized ast 0.1.0 for 0008:07:00.0 on minor 0
  ast 0008:07:00.0: [drm] fb0: astdrmfb frame buffer device

With v6.15-rc, since the commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing
into the proper probe path"), the error returned with the warning is moved
to the SMMU device probe flow:
  arm_smmu_probe_device+0x15c/0x4c0
  __iommu_probe_device+0x150/0x4f8
  probe_iommu_group+0x44/0x80
  bus_for_each_dev+0x7c/0x100
  bus_iommu_probe+0x48/0x1a8
  iommu_device_register+0xb8/0x178
  arm_smmu_device_probe+0x1350/0x1db0
which then fails the entire SMMU driver probe:
  pci 0008:06:00.0: Adding to iommu group 21
  pci 0008:07:00.0: stream 67328 already in tree
  arm-smmu-v3 arm-smmu-v3.9.auto: Failed to register iommu
  arm-smmu-v3 arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22

Since SMMU driver had been already expecting a potential duplicated Stream
ID in arm_smmu_install_ste_for_dev(), change the arm_smmu_insert_master()
routine to ignore a duplicated ID from the fwspec->sids array as well.

Note: this has been failing the iommu_device_probe() since 2021, although a
recent iommu commit in v6.15-rc1 that moves iommu_device_probe() started to
fail the SMMU driver probe. Since nobody has cared about DMA Alias support,
leave that as it was but fix the fundamental iommu_device_probe() breakage.

Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v2
 * Add Reviewed-by from Jason
 * Respin with the "PATCH rc" tag
v1
 * https://lore.kernel.org/all/20250415132401.GC517881@nvidia.com/

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b4c21aaed126..c32c0b92dc69 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3388,6 +3388,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
 		u32 sid = fwspec->ids[i];
 
 		new_stream->id = sid;
@@ -3398,10 +3399,20 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			break;
 
 		/* Insert into SID tree */
-		if (rb_find_add(&new_stream->node, &smmu->streams,
-				arm_smmu_streams_cmp_node)) {
-			dev_warn(master->dev, "stream %u already in tree\n",
-				 sid);
+		existing = rb_find_add(&new_stream->node, &smmu->streams,
+				       arm_smmu_streams_cmp_node);
+		if (existing) {
+			struct arm_smmu_master *existing_master =
+				rb_entry(existing, struct arm_smmu_stream, node)
+					->master;
+
+			/* Bridged PCI devices may end up with duplicated IDs */
+			if (existing_master == master)
+				continue;
+
+			dev_warn(master->dev,
+				 "stream %u already in tree from dev %s\n", sid,
+				 dev_name(existing_master->dev));
 			ret = -EINVAL;
 			break;
 		}
-- 
2.43.0

