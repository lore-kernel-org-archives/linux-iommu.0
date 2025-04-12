Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882B193402
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481246; cv=fail; b=A91BZfUb5Zi6W0d/NjCJaRBF1TbSTaUpv4P3584b9+gkcavr/y9nrg/ir3WlxRoE7QJC1F0T8PCN9FX3m8T7UKY41iuPo4q3W4/EgK/lJtwGHrIgEuJvJspoSeJKqbtS5G6ZficTqeq1pMreSU7fXwmtNC8c9jns+cJRZUHpf9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481246; c=relaxed/simple;
	bh=/VPcUN8ZYcSF5waA4MI/ewXYXwoF6Js+4xIr9YiBo3A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O9USSuQm4gL0zHLLlWL5PrZWMXZRZS9FyciOAijWHUpVE30snRlf0s/Qywl+Bj/OOo61prisKVlsCNbmCuHZ9I9Wc+dySUzu8mPzTsr1pzMJf0nuFy1h8hGq2eHxT2p/3VYTaxNKKnYsUG4z2IDIieFe8oQrt67sdUIc4uxXbU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B56OtsXx; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B56OtsXx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rB7T/7DKQytON/31nyHBP1LgoJueNBIsQt0rs8b8sxXRNp/G4P3FyCeSUwq7I1uUwCTr13VElMx+0p4auwYsJKGSHmSWzfuHekbmKt9nB+6fwtZjPVgPHfWyBPx/0twHx9ZtDOOsEj9INJd8kQxhpBcRzfj6oXoaL5xRD4yrWckeCYu8eyYURcjh4X3sEga+Ca0/PHDNpIvVUlWE6cQ/R1mkCtMcG1qdjsA6RLH4MXPxV5QhwvZo8QVSzEmc025hOOvFpEhRok6PrIG0JM5XG2FDO0BzMWtXzVukkUHBbuRvd2DDhcsSzwFaltUFQLHtQJptb7OFLQakCkpqht5DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KL6ekmYDuGMWkbhVXagFJYjBTfA5XPLziQL+9Mnz+A=;
 b=O19uL4x8rm3OuZ5+dHUIfZUOr/x7LPp3BDwbqit6lwqrljzOtwcofWHGcnUYYIe98rBWeEnF1swuae7fDdTrQjDD+2xMG25IY4m18AI4RZBMz1bf4r9/nQu/upXi64q8vYQ2FQa6e/e5oHoAXCa6s0YlpYdkV2j59eJzegBP8kqmDYzAehpFvhpKVsE9WPDN/+niWV5sOrXyAIfmNmOZhxThcLbjXQAY5s572cvuLOrGMAVtUJ2rvuM54wVAxnp+W++rs1Y7aSEBPq4aDp/bKuMtlK2gYVU1sESw2DfCF7WabAniuMqus2GjwUAUuAE8RkON0t3C0VJKwS+V3+ouGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KL6ekmYDuGMWkbhVXagFJYjBTfA5XPLziQL+9Mnz+A=;
 b=B56OtsXx6t4pIpcaWObt/WxZcGhivcASF1EpvQxXkUsLpUuc9t1MCZs2dzg5ePUIDNK274rfCm8wIGvkpLQTvgD7+932NQJsbeTsxG+MZaKk8svH5amWeRKuTSz+8vx+cdXPlAB+kcyv6mZvtn1s/X7ktV7QC9tdPw7Kz846GKvZaJzPhy2NubsCHI2r90MwAxPMM8RtTG+iO6+9F8eRxrKihQm8DP17J5mraCp88q1bdHPwcsBuyiwJWWHRi3w6uqM/oHm4LYXE82KA6Sg0+qckqQQUw8/IHPSJuqwXv1n3K93pKfENOysQpw1LPDVdSGEdAe3tzL5DPkHf8WtuaQ==
Received: from MN2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:208:134::16)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Sat, 12 Apr
 2025 18:07:17 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:134:cafe::e6) by MN2PR16CA0003.outlook.office365.com
 (2603:10b6:208:134::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Sat,
 12 Apr 2025 18:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 18:07:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Apr
 2025 11:07:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 12 Apr
 2025 11:07:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 12 Apr 2025 11:07:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <jsnitsel@redhat.com>, <kevin.tian@intel.com>,
	<praan@google.com>, <zhukeqian1@huawei.com>, <Jonathan.Cameron@huawei.com>,
	<jean-philippe@linaro.org>, <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids
Date: Sat, 12 Apr 2025 11:06:58 -0700
Message-ID: <20250412180658.439499-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 69979cd2-b54f-4099-55ea-08dd79ecdc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/DKkZP6hycpB5zGuknKMfyaTlwgvqJfKzBB9zVMahBmZnwtpzfDgAxRznDG?=
 =?us-ascii?Q?Lg0aBsbqRF9XXbAqJ3RKMb2XM1LTr/SmpGG3mkepmVK0AgC1CjrpZF4TpHJq?=
 =?us-ascii?Q?KskgEY0td5ygC/sNn2CrfKn7DG0l6M0N4K2PJgEEL5VtfSKL1dWDvKNRlabj?=
 =?us-ascii?Q?FVGOMiheEpULjravxQt02TM8GiZL3J7hxhzlSCCtWo1/SgrzNpNQdbeqKl4H?=
 =?us-ascii?Q?v8sSqMqkaNIAS6oDPD9QqJ1hpip6nAnbExPefq1NPSUEUF+qKx6bzad7HixX?=
 =?us-ascii?Q?bwcK2cPOOidSY5SuO4XqqjF3dCUqfAs/MF+YXxAJrGZGjA5LzZbYGssizEyk?=
 =?us-ascii?Q?eefsAnDVTNhYS3vvYGJsWFSodkLjKd6tlCV6lz2fo12j0mdSn0yVg729YbQ7?=
 =?us-ascii?Q?D6LrcoX5j97T8Tsjl6oW2ILtlzJBcj5OdZ0++TNTSh+zOccJi/1WjFPqXLwr?=
 =?us-ascii?Q?HcnlhwILL4PKiCmtFq80595j3UYL6d2G9MdIi2E8oqGqlRiyp4Y66h3/QJpk?=
 =?us-ascii?Q?SqMjYqxfa69tSrPgm55SI2JbQgaHe7HiOQATMDxsx9se09VUlusoPJ9bLJ57?=
 =?us-ascii?Q?sIcwqliYndvokkLqp7llGcipD8AN15mupyDm3ZLGimFU3E8UnuJ4JPG+7xw2?=
 =?us-ascii?Q?VUhLkQtWiscb2Dfyb8ulr769R7PmcHFZgAsiI8McScmgrRgGFJylMZ7Sfkf1?=
 =?us-ascii?Q?PBjV1BDR0XT7LgXGGlUphsPiL52ajUxTANdKNnrS20CChwVbjKOIYaup/hq+?=
 =?us-ascii?Q?6bj9wVa5A/t7tyqiZVwuj4/ADaGtRHvky28yBG+nVhAsKBYFISt78YMIuOaP?=
 =?us-ascii?Q?KwlWvhH9ctt78AeRg2NndAcIXB3c+ndmJBVTtkIsIyN4CDV5UxRBgwKY9u2s?=
 =?us-ascii?Q?Yfq2eoJaTh1G+uyJMm9akd1fDkD1kvdKPXly8bwXVEjCTSBo+PTYUbtD3Tdv?=
 =?us-ascii?Q?exnK0+IpMIyF1RTrd/OsNNO/nV5y27mVbgeXb7knWbRTXGGDyqv5nKBqYge7?=
 =?us-ascii?Q?ffRj8V7goU+fKh6uRHwic9veNS8Xex9OXerbJB6VmVeDPGF4jBqpPJ2+MBxz?=
 =?us-ascii?Q?QYgvRuZE0qpJwtS489aAfd9uW2nJffdGDcXzXsmZ7TFwrFBRbEUhOkOlwoMb?=
 =?us-ascii?Q?wRab1BuJXF1RvnyQfsVhK7KNvO9hc5+MCnZFeeJ65Gl89nVBU7/01EiCdTjb?=
 =?us-ascii?Q?wD8AbyxPXl3oC0DAKS/1CQC/uwM72grSidwnJo1OylH/i/04YFZPrKjxyhoi?=
 =?us-ascii?Q?BuIeq8ydo1V9jg/BAHsz7wXn1Vy/AnexGh9uGXvMqkJq3A5W9rX+npgXBBT9?=
 =?us-ascii?Q?aTRP3HcMVo7+/LgIjytmFy/+YfY8bGu+LSDubO/3ckQ/bvEoIZtVza3kZgvX?=
 =?us-ascii?Q?NxgdrWM5XFQs3qsGGWqcCMS2Hf3rMmaPq2OFP8xjcRZMxrwjmilOkE/Sma7e?=
 =?us-ascii?Q?DqZk6mfGC9RefV+ugPXRwtFcddOFmbESHe6W6akVmqROz1NHq4SYPOB/q2ju?=
 =?us-ascii?Q?AljtSM0mJJ8Rl4dmZPk/mHNAIg5bwMLoczJN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 18:07:16.8263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69979cd2-b54f-4099-55ea-08dd79ecdc34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

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
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
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

