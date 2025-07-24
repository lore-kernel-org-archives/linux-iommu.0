Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBC2367D3
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395034; cv=fail; b=f8jGad5B9A/e2F+eT70c+UCohj6UfSmNqa/58K7AUsg6Eh+QXFYcJpHH61daUQFd55I6OAfe5r6OTvXFpGG7CJczqldD+x03IGz9L3uxqDX9bThGPkLRBOLfSbdjz8X/rfuVJADCSjAmPpBn7JxHUJCa/DxhA/+DuRTO/tqSioQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395034; c=relaxed/simple;
	bh=6VKTmoOKAVySY1du8ueTZPHU6SQn8Fxq/n/W7Ic88Hw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlLdle77ZFsTBWndhV9wEjq5nm/P45KtoDdUkzgBGVzEQ7awwXwCBhyCLof3niE8YDV9JfD2fK/3XoW+ygbfYDDNZyGfdTibTj8ZlyjZZYsPPGOrcZLwnIrJh6C8huna4+UBX9ZIVyDfYWM0zNjUQwSi1c5xyJC8gri2zFEq+gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=csRvqtDi; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csRvqtDi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0UhpM1cHPlWNBXE2f/Gm89LPuCOrNBG2aiV+IoMZqYDSig6NhRkWiQ28/Ngw9QkjDmmJSwVVMfzywHyUEJqqTom91ZLNkcoU8u8JDgpucQVczYy584zsmqDn33HKHdrEqwSQQ4234po8/Lg3W2b9vGtWYs9oPEx4NDi/izNgPKNBq3iaFlkBlsqm/e5poW1XLz5PrMGw7sxKKHbEpzC1+vZzjQxqDkSrbTh4cC75s/MBxKx/H9K/QvIBm4rlmBBTXwWLfBcHaczjbEl3BaRBBo3JO69NThp3JllQ6PHcW3sMgr9cg3EtJhoLOjLZ9HxGBC/+7lCCQYoJFE99RuTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQfLz+HcubL7PY/FcNqWeR5G4tfd3w7BlvHN/akCPZw=;
 b=op+13nsbZ4XJ3Fa+LSDMkSrWt7+kT7W2c4cKks/IgW32vFIJUa2MswjC2JIgHUhvH1qdjSNS5gzOM4IFYPkEyLp2Je9hYrUQWOpDFVRIi3tli3BFjbgI4bfDp+KkMGXifKAj/cmyVW75IsGw7PEqhwHO6D1HY4mgfuMAGD/zt/LlB2F7VHcAdhFt9nJCm2+zW45wmoSV58Oh/BORNzA2fjlECfCLEkStm8c5UaxL5/t9fuZdbKp9GNZMDAbGih6PTaIH5SmtHqdk0A66ANfAAoFfwQzDINt1FT0dmwWpuNzOaGyPA8Vohgs8FpIPLGlYML22HABHa6sXHh6W8t/smA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQfLz+HcubL7PY/FcNqWeR5G4tfd3w7BlvHN/akCPZw=;
 b=csRvqtDio47UrYRRo5y0L9rymcDHR+kQv6gWxwtBWV1HiSEIyz5Lo7VY0c66nY9d2D2xRLlhzcgF73l8L+hqQhK4VcVSC3/cCtsC5nVrIL5WpstdfXdipU3VCTdbs7GvCVuXSsC30OO2P7srf73mS7gOkxHSs38Rb1vnj1ZIQaI6oSqIU6IB0iIXnQdBuHdN/GTUgl+OCHbVzlIUivGYtCj95hzdQHXvJGXYdK/pZUhKsRqPGS/1gu9f0HG1b4W8+jIre4Y3rOjB6D72LAz/QE0/EMFUgZF+tAXvQwLhAZXpjnnNRY+KnGl1UkZoZOdtZW4SrzUVdC3EG/c0YbtSGg==
Received: from BLAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:36e::22)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 22:10:26 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::2f) by BLAPR05CA0016.outlook.office365.com
 (2603:10b6:208:36e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.6 via Frontend Transport; Thu,
 24 Jul 2025 22:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 22:10:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 15:10:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 15:10:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Jul 2025 15:10:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<praan@google.com>
Subject: [PATCH v4 0/2] iommu/arm-smmu-v3: Two vsmmu impl_ops cleanups
Date: Thu, 24 Jul 2025 15:10:00 -0700
Message-ID: <20250724221002.1883034-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 56579efa-57c8-4449-9fad-08ddcafee505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8qec/urV8JMjMG35xIaBxkePkIt0RhaFpDVMLe5Z0lXzp1Zd7hJI3CpM+QYD?=
 =?us-ascii?Q?qMv+aNP2bnX7jbCLvSiy5bo/Nva2yEMwI0HU2BDbQppJGXmB2egiQv1HrRee?=
 =?us-ascii?Q?w//FUwxC9VZE2QMiYo0lGxQHVu6KpQvtSrEgM+63yDlbuM9PQMziMJ0FP/qk?=
 =?us-ascii?Q?cfFkUHdAqeQRLQK9m4SXGNvgDraVOZoLPziO2eXtzjKs64KpxGTi/3cSLyRR?=
 =?us-ascii?Q?lCkEDyBaoNbmjXJ0waLYtHzYB5M6h4WCtMbXoKfDEX8aH1iAwwfiKrJA97Jg?=
 =?us-ascii?Q?uSRf3VA0fKev8VC/C5eUR9YJjJoS07gYfb2HpOTcM7WKHI216b4zjnUoOFc2?=
 =?us-ascii?Q?kaPQI6Z3buSRoLTzwdYIgBJLoinvcitDNT3l5uRpu9ATLHwM73b2r7zQVO7c?=
 =?us-ascii?Q?am1P40UFYvn+XDsF91BARBDW2proAy5WTLFatY/Vl9PR/wFeuuKM98TAGYYQ?=
 =?us-ascii?Q?AcLnzIN2/U/5xvg+5JcyRZdOi/JmyLdD6QN1+vAasJwMCqKT+QYXPXqH0hWL?=
 =?us-ascii?Q?Z3YXgZX7c9Oi4mj6yegqv1InRAWAxQTq6WegxSHnHirmthbQqccrLRFv1iM+?=
 =?us-ascii?Q?CXcukBWFh/E7zB82pCFy/ys9rmYlywXJG5XbM36GIfIV/Tm9q/zdAnFLiWCX?=
 =?us-ascii?Q?chxcLF0am9yyKxaGsns8zO5SW/EoWEBnWDLdaxb8KgOVhSvDiDHs/HYLwgAx?=
 =?us-ascii?Q?ySRLCbzo0193E6Ko4uw1yijqPMFPslYiVj8P3Ja7TCjTXcyLBKEPAbDrFm7e?=
 =?us-ascii?Q?pcnXGIV8833a5U6+/KXVxaf1ofj+x768XOgtenI3mq7+rBCMqT4L8uubUXjd?=
 =?us-ascii?Q?71HKTnSCmlZQ8dbAXWDQSHC3tPLqkfBhaR1UXx/ZvEkBKkj9b/Q160HP9AJD?=
 =?us-ascii?Q?KnMLjjUb0TQjF16zZT9E0YNn4X3AQK823mjwl8y/KpUBkf46HjvJ9z2nFijC?=
 =?us-ascii?Q?9PEc+NKBgsUCBn/bgOFj10G115O0ty6nDEEM3qDKT+QZ4evPLUTtBFk1L/Ji?=
 =?us-ascii?Q?0Oy0Sp3kAXi4lAFq7zED2wcCgTDmKWZLOTfW/AHDzVfVYLvZ9rG6KkE15ysk?=
 =?us-ascii?Q?+wXil4+cMd2fFzf+vC540rAJtMnDCvQPfatzuVRmIuvqxAeysT5cb1V8rNd0?=
 =?us-ascii?Q?6xcQ7yfWXMzZQDqzjdsKZ2PZzecYbvcC7pMZ6egZXC6XXhyvSBaRf3hVl03z?=
 =?us-ascii?Q?dzS/l45XreZPuLBGbyLXUoiNyY5K6cNWGd9RYYgE1+Gi9WHE6kLxwGUEduE5?=
 =?us-ascii?Q?dPibkBt5K4Hq5tdV/6n7BTAJWHBUcj3i9c9JBzGXDkUe+sXajZ0hhS5w/lhq?=
 =?us-ascii?Q?e9+jfaJGuYlg7e6+++90WxEZL2wDYtjJGst68z9//Sv2EYHuEXKZisUAvwPX?=
 =?us-ascii?Q?W4nmNt3clg5HzzkBGeJNnzsKpnKUKOXbn1zTGJgz0Z5d3wRSw8GnTD5d8wr+?=
 =?us-ascii?Q?VKFSo/Ie/7ohO+qRf3ne5JFUou4tlbaisu4CUlCCo381cF3gPrgIwnTxR3v1?=
 =?us-ascii?Q?eZkG++8ydQNoU+era/XVP/rPHBe6lALxpBvnuNELKFKqEkxwy3oaHmgcgQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:10:26.7398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56579efa-57c8-4449-9fad-08ddcafee505
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

Since the vsmmu and cmdqv patches were accepeted via the iommufd tree,
this is based on Jason's for-next tree.

Per request from Will following the accepted latest vcmdq series to clean
up the impl_ops:

https://lore.kernel.org/linux-iommu/aHE4Y-fbucm-j-yi@willie-the-truck/
"
 It would be nice to avoid adding data members to the ops structure, if
 at all possible. The easiest thing would probably be to add a function
 for getting the vsmmu size and then pushing the two checks against
 'vsmmu_type' down into the impl_ops callbacks so that: 

   1. If the type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, we don't bother with
      the impl_ops at all in arm_vsmmu_init() and arm_smmu_get_viommu_size()
 
   2. Otherwise, we pass the type into the impl_ops and they can check it

 Of course, that can be a patch on top of the series as there's no point
 respinning the whole just for this.
"

Add two clean up patches with the first one doing 1 and 2 to prioritize
IOMMU_VIOMMU_TYPE_ARM_SMMUV3 always, and the second one dropping static
vsmmu_type and vsmmu_size data members.

Changelog
v4:
 * Add Reviewed-by from Pranjal
 * Update inline comments
v3:
 https://lore.kernel.org/all/20250721200444.1740461-1-nicolinc@nvidia.com/
 * Add Acked-by from Will
 * Use logical "!=" instead of arithmetic "^"
v2:
 https://lore.kernel.org/all/20250721191236.1739951-1-nicolinc@nvidia.com/
 * Add Acked-by from Will
 * Move get_viommu_size and vsmmu_init validation to arm_smmu_impl_probe()
v1:
 https://lore.kernel.org/all/20250718234822.1734190-1-nicolinc@nvidia.com/

Nicolin Chen (2):
  iommu/arm-smmu-v3: Do not bother impl_ops if
    IOMMU_VIOMMU_TYPE_ARM_SMMUV3
  iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 20 +++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 17 ++++++++++++++--
 4 files changed, 39 insertions(+), 15 deletions(-)


base-commit: ab6bc44159d8f0c4ee757e0ce041fa9033e0ead8
-- 
2.43.0

