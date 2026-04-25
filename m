Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC617993
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079756; cv=fail; b=siJPWrWIJohT6G88eekUJhUEAosTe9Aa32ObQYD+/g/sXX5ujA4/ONAFnW5UrUJNAv67j3WHfDSTfVCiykxPU6ObA1EFuC99R4X4PNv0N0ckpgGwcjqdKmjrpWRwft6K1kGm4IOtIT+J0qunvmztbLiZIPD/zTitvuyH3JMK6gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079756; c=relaxed/simple;
	bh=+O4NDjECkGlsoO3Nq/VWK6STANgCv7nzt9EidQ1YS4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBq93LISgjRFoWjZ4+lgxapHdUmk+0EKHYqE1Nourq//sqnqogLB8XSA/9fX0cW6UFmJCENn1DRmrsZdG5W+jFUa0r1rhEWPcaRTVyugLRgvm5eRlvE6nLb7gM+T6mBNd8WXTRiLBavWajpFC+V5IaBygOU6V9fdAyM1LUInkh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MFGk/f7D; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFGk/f7D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptM/wmURXn770CeOcaSPO3XEsYfaDTN499FoKoOEHML8T4KBemNQgA5DukCOP4xUl9ZmjmBp5lQx1f+6y/LjDay2nHCn//OdZw545JvcLK8fvogxTgkmAidqe23pgkVA6i++8nwjtjU4zi0ir48KMUkVh3FoEj/azSXzo4Qgnls8pUDVRRk5IjGu4tlBYv+7IR+zTitwSgD3krdIer6v4kD0MwG2wV+vyV6ncZmzxmJBL6M/hTgIPADVaklC2blhoqRIpgvq5A4uCTBlSsp+CZZ6iORlU/UO90GBc+zLt3Esm9+UfVUIK30xNj7sA5IPMEi52csjfU6Qj+Ihh7N3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ouLpbNhauD0HxWhrqmjVXdJZdF0qcUI9Zx0Xosz0Y=;
 b=uRSxCSC0WUfFnKhHgGKhcq6TaTMgH667kbl96InRmLS2vbNKA0BFLHtDA7XV5ixezTsCznrd63EkaBT8W9y+XDfQp2ClHcsDXvsHbNIElFCFRPfEgSXXOudYZePyT13ZE6VnDs4fW/Nxs9qe17eqS6jWGPkV6dK1+L7WlERcfY2kwceXsa6fNRMmwDu/rRL+I8bEQDFt+22iQmOHAVmJWUAar7wlfjfy1oIakfCI0BGSDmTtAAP70I+dQG47W2SptDzr9/DZrZ5ga2Y7cwecFrOesPhntsO0lGJ6Qq0JH189oAHNKINd/4oJUmcYhbPdL7NSa16V5+ubU05T9/7HDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ouLpbNhauD0HxWhrqmjVXdJZdF0qcUI9Zx0Xosz0Y=;
 b=MFGk/f7D5NYDhWCl7QgJ1Xvaz5cpE7DAcF0FU1GlzwlScHJqxzp/43jji7tGsARP1qJKY0QSndT0o1aHByctdZDaLUz8GMMj/jQrgmHndeet7OvWgqeH92Qu8fej++dr2/cgIC3MLiahlglEuqkvRtqxT57W9XWD2YANrAZ0hC+dqIV72rvcREVgWvvJWfqiF4eqq/gTrlNYg0GdHH8z2xXKoI2k7Xu2s25idcVvHOu/wDD06skvtNTm/QLQxPAmj6BmrLsBp6Nrl1U7VTXAhSAYQWaDLW0k1a9bALDBxVLlAIXXxAZw25TFnCRAdFFAFWO9mqdRAzDUdRm3PBhvOw==
Received: from CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::7)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:50 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::27) by CH5P222CA0012.outlook.office365.com
 (2603:10b6:610:1ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 0/8] iommu: Fix pci_dev_reset_iommu_prepare/done()
Date: Fri, 24 Apr 2026 18:15:19 -0700
Message-ID: <cover.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 732a332e-24ac-4f99-50e3-08dea2683005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3PDvYrnfsD0kNCEhLHh6vuSN5ssKm362f3Z3RWciVdqoR8ljgbuQkViyp6TxyYkuxjWJ2oB2dCb7wS3LX3CZWEUWgx3xriJACivCY2tbXquRVbnRI8PtVH+dq1/fop4R/euLG0j1T5B7jQzILAENIZKsqN6CJ7lzPZ4RHRgBJHCMcYCtuuRdFCFczlqji5JRCFe0hiMZX0CFKrufgkIhDBtJcnkTHXtg//HicRHFN0+v5v0PBf3hlrCyrW6LR1oBsdRsF96oRABe9I64HatyZxSIBzcUffnWrIakfVGC9sXLja+klMzOHr9KCK5H/syO3sHnLiwyCM84bv/e7Y2EPcgrXs8u61iCv7QfE5GtUz1fdaQ7Ruwp8als0E+RrpjCBFtvnLlPLa21RjzeojsGP3xzpysSpXVG7EVMbVmhiRAgkHdzDDcXLN9aiTM+8sIht86tfMLy7tbkktFW6KEHvXIe7r9i47f6CfnkMwvDslbFzhEpf7PZIyy3gldZd2Fv+pSw1IbCdby1AUMTr5XZSkEC/Ttq7TstGCaMiXEee7I4nTq9Zr4CHwcnBOndBTh8aovB6W0MB9tBf5zdUvceyVJFFBEDgsizOEEuEFTNOn9TYgLODM78H+0wP4jN0Gsg0j3+yjhyhkg78Nr4WR0y6paqrmfCwmP8HxK7U0n4QCMCiRTRcpCq4ZAjTbgPeoUO7rNfNUYUN1R9TgAFVoWCoxMqzSlSo8O1KDIE3dz7KBpifXUtoEoPeZG+1fsjVYp6vRXMmXrFf8lxMBdfPDDNDw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hI7JC/ENQSW0yFmEQoChpHUoh/02ag0q8Hb+U9SWHZgMvnPwpsSFUOSb535oR1W1A4UMAqB4oUbufSGgK1BPEkUI5CpCxVj9vrVYZYcpC+YVEhRcahczrQQJxJFEEtD2J8q8RJ/OzRNYOcq80kPKt6O4rWzhqFFlYPYQjb0mPdv6MZ5mWEJ1ENh7+TGY0KByZxCYMr3VBdpChjVWZt0bqb8yidWd0Unagd23zwqWgnt/XMKspn+/Yt4/TzQX1slwnF9UEuSLFw5JH1EAh7re3uZOJte10x2lWvqBZIMMgkDSBHFSRS7qpMF8RkIk4mP544booysi+OxO7P5EK3klrg3MuxiELrUU1G74FB0tiDap9wudeyZ95QddoV3RL4uNQv6vNmFfn95Vr8wjMZc1oes1Lg/xRsmW8AAJARlelgdYHzXy7qpfB6Xol/0GY+L/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:49.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a332e-24ac-4f99-50e3-08dea2683005
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

Shuai and Kevin found a few bugs in the pci_dev_reset_iommu_prepare/done()
helpers when used to handle some corner cases:
 - Nested callbacks
 - Multi-device groups
 - WARN_ON/UAF due to concurrent detach

This needs some substantial rework by tracking device reset states on a per
gdev basis. This series includes a few patches addressing them. Most of the
patches are reviewed previously in a single patch v6. As we found more bugs
during the reviews, I split that v6 to smaller patches so each of them will
be cleaner.

This is on Github:
https://github.com/nicolinc/iommufd/commits/fix_iommu_reset-v8

Note that concurrent reset of two DMA alias siblings (sharing the same RID)
might prematurely unblock when one device is done while the other is still
resetting. And it's a bit convoluted to support this case. Given that it's
unclear whether real ATS devices might share RID, for now, add a warning in
the done(). A future work can fix it properly if someone hits it.

Changelog
v8:
 * Add Reviewed-by tags
 * Fix NULL group->domain in done()
 * Tidy goto cleanup when using guard()
 * Update patch subject and commit message
 * Add warning on premature unblocking in DMA alias cases
 * Drop unreachable skip in __iommu_group_set_domain_internal() error path
v7:
 https://lore.kernel.org/all/cover.1776551790.git.nicolinc@nvidia.com/
 * Add Reviewed-by tags
 * Split v6 into smaller patches
 * Add one patch to fix UAF during detach()
 * Add one patch to fix unnecessary ATS invalidation
v6:
 https://lore.kernel.org/all/20260407194644.171304-1-nicolinc@nvidia.com/
 * Update inline comments and commit message
 * Add "max_pasids > 0" condition in both helpers
v5:
 https://lore.kernel.org/all/20260404050243.141366-1-nicolinc@nvidia.com/
 * Add 'blocked' to fix iommu_driver_get_domain_for_dev() return.
v4:
 https://lore.kernel.org/all/20260324014056.36103-1-nicolinc@nvidia.com/
 * Rename 'reset_cnt' to 'recovery_cnt'
v3:
 https://lore.kernel.org/all/20260321223930.10836-1-nicolinc@nvidia.com/
 * Turn prepare()/done() to be per-gdev
 * Use reset_depth to track nested re-entries
 * Replace group->resetting_domain with a reset_cnt
v2:
 https://lore.kernel.org/all/20260319043135.1153534-1-nicolinc@nvidia.com/
 * Fix in the helpers by allowing re-entry
v1:
 https://lore.kernel.org/all/20260318220028.1146905-1-nicolinc@nvidia.com/

Nicolin Chen (8):
  iommu: Fix NULL group->domain dereference in
    pci_dev_reset_iommu_done()
  iommu: Fix kdocs of pci_dev_reset_iommu_done()
  iommu: Replace per-group resetting_domain with per-gdev blocked flag
  iommu: Fix pasid attach in pci_dev_reset_iommu_prepare/done()
  iommu: Fix nested pci_dev_reset_iommu_prepare/done()
  iommu: Fix ATS invalidation timeouts during
    __iommu_remove_group_pasid()
  iommu: Fix WARN_ON in __iommu_group_set_domain_nofail() due to reset
  iommu: Warn on premature unblock during DMA aliased sibling reset

 drivers/iommu/iommu.c | 223 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 181 insertions(+), 42 deletions(-)

-- 
2.43.0

