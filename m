Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA0239E9A
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128320; cv=fail; b=l7SoBaQ2tPc1JouHrHyLAhsHR5Kb2Y/tMywuVM4Raort5iRb21adq6pyL/OxVEojtMtFrXu5P1aifSsWyi3qV6/RA0iXwH4+Ah+7jf+R0TwHYSa2G/6vOgfdqku1ir3mWJN7l3DcTmRyuYDonNlmF4p9LiqB/mcssgt3Vta4Ego=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128320; c=relaxed/simple;
	bh=+8NFEo9lBJX0qT+OANW0tUxXwA7AlWHEStIaUSdO8I0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aJlozSORDbrWJAHNGSdzj22z/2tAI+CFLDwFSdPIYnBy220sau1vVfTYmj8i2O8uvUHgLXCluMuAotzF7sfXdJRPLeqjLH0NTtpVxa+s+rQnabOzMhNYYuclsz5LAtH6q9eXxMQJfj/aEKUSNdwp1ewJQnyPZck8nmNzdAk8jBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L3kmnE2r; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3kmnE2r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3of8ST9zpcfJv6gcaYqZbQ3ks9ofg3m3FkWSHDFM4bB6OaJ+bsil4iE/HdSDPhjnXGPHuDPr3QkcRWJPHdZVFSStP0GjPKoAWzzh7NSx2X+L/ONUtRsimAr0GVNvRic7UuFpYlRV8bUp6ap3BhRR+P44NBg5TODoTZjB+NaBPMaYAyH4xlZ2m2JsOnxJwuQUI/amau67CzPcUXvDEdM2j3E9TUsUHgMLykfrB47OM97OR2Kt2O7Qv4gnnuY3uR+UORSaryhhQ8fW0disc93gNnNFK87R7XspmwLdebQUXSAjft1a3sBtSQrWp2D36o59HyJ532/1stl7v6R53fQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lxRvpsWK8OpDFH33m3l8aI/6Tmql30BR43PeEVOTD0=;
 b=iLF3UHa8n1ZkrPF0GPOp+WawgqVo5sP4SXnBPtgFZNu8+7hWHF7/4M3/Qd8YQC2EbuSdBspNpcyNJouBw7LaWFrD+Vc6Vk/1RrIu+M4fkC82gbKCupz5Gy6I3iyJ5lgYQrH+Xd+trLq/XjLdlWp+JOYVonLF2L8vIR/CbPKQwUg/cdhfRTgrm1ALvkilMQupS9l8/Pp6yOFWdw0kYneeVQArPv/sf7XIyzHSFa5nTv7owM8GdfUzVj1wJP172TCF4uTyVI3SSxQhdg4RYNK+q5QrOCLQJSlCp2p7e4PuNHnpcLvLl5cuHNHJoll+wc1Ifi/VIMWdYhkisPMSqETl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lxRvpsWK8OpDFH33m3l8aI/6Tmql30BR43PeEVOTD0=;
 b=L3kmnE2r15z7ML/qlsNeHdjnt4psuI3GMtZw5PefCwtMqVj2DzC4xjPM8yYFCVKF76LITBSPxiJtCHUbYS46+0xW9hg4zRi/zRmpXWAg8x8NHDuVGZB6qH8GfjJQI3EFFNQ+CCKiem0c4kM8RnrC1sbfKuWZ1/ySvuYrnD3vXcbxyOFdA4MMHWlc0RzPj40RrxJHd9hD180ov0v7PItUiM6DUV7ora+0XlC2GZxFXwlVkIcJXfZF2jUFq4x1t+FGdqV+Hbdm8+OpaCj/IJkH82JB14NvvhhoORt3m7+YDFlshYVl34o3Y+8PMxlWY6JqcSzs9drbVE/KcySD9xC/uw==
Received: from PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::15)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 20:05:14 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::e0) by PH7P221CA0061.outlook.office365.com
 (2603:10b6:510:328::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 20:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 20:05:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 13:04:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 13:04:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 13:04:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 0/2] iommu/arm-smmu-v3: Two vsmmu impl_ops cleanups
Date: Mon, 21 Jul 2025 13:04:42 -0700
Message-ID: <20250721200444.1740461-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff4230a-973f-4ee2-ed92-08ddc891e7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i7z2lG7RYvv7LdlXVLcPsRK+MIrcBEte93nMlN+tYGpP6efZVbygRrl6ywxX?=
 =?us-ascii?Q?za0kimG69+UirmkzQCGfNMnhJm9d2OK36qsccr8PrOH5bvrE+bNawDPrGK1y?=
 =?us-ascii?Q?m1dNWo7m1avmcQCgL845Up2YVR+nq9rAzBgF2+Lz0l0jUr7MrLrc2jFHMHzp?=
 =?us-ascii?Q?m/t7JxHTewfjWurrmNJA9T9SKDo6ETQCbSS+11prHGBSjbp8ujuHX6Zv3Ibc?=
 =?us-ascii?Q?VbeTH+UjJ8dFQ2IrP+Oc0UICUzvZtna7+XvicR83WdQ2Hljx1M9zTD5zO4VS?=
 =?us-ascii?Q?MmLhcZulG8SYNHfLA4GgZU/az8h8JuNKCfRR6qwi93zEUragzT6uFFiMQUlK?=
 =?us-ascii?Q?rqS74xKhqmf8YbllnkZSvjkiDA/Yu3DLDcx3ao2Rr3Ti+lLPM37jXbSDeCV9?=
 =?us-ascii?Q?c1ebHFDZs2XFJkON/OGxDbxW9zOMCNkBTTvaCwpNjGqQz17NapV/eVO2Fd/A?=
 =?us-ascii?Q?99D3z6d1xIB2KkqAXj3WM2ImKj8HDX1rUkqx+rd+9WEu8nn7kJMCXavi8/fa?=
 =?us-ascii?Q?tY1mQqqa2SRS8ygdSrH15cIONsr1nT1K1xmOpIwZvZiC9ul87VKufb1VBk4A?=
 =?us-ascii?Q?r59MLD+7yjwrfyT+bGCikeFwPq/zSVZXhrzigfLPTKSx4JljgaMe4YzBgjdT?=
 =?us-ascii?Q?bbotXE9ExN2uUyw7N0CzbVRCkvJPPeePQU+eClUo/cEfyqB/L48t+5+FA4wT?=
 =?us-ascii?Q?LsfiqyUZ65vAaruHaO8sfxoa43XHOzmz55rsKCMTWHiIw9jnfxMp0TIvrfI0?=
 =?us-ascii?Q?osulCHeNKTOe+huPITuHW2q3z2foJzy++Zha1faU9XVyTZrsm7XDU/GF4np3?=
 =?us-ascii?Q?dxP2JAfszrwuWn6XoRwQPXy4rfTahcDEEuKLa5M5ewQ8B9CcPjOxUF9RxWnW?=
 =?us-ascii?Q?HPCMLOXV29+Zl/1CVUZMSfgUJRvoD4JhWRkio6dsmtFZRxl9Croze6ZjOjjI?=
 =?us-ascii?Q?Dtb0g+XadQWzQo8RwXPfyvpAEmvezkXN9z+JuO6WtNXDQNSi8MlbLkDrx9BB?=
 =?us-ascii?Q?OOOUAL0PifOp8pmtGUDnnSGXkeac67utO6g40MyY4ZzrCpd6iY0tJk7hSbim?=
 =?us-ascii?Q?qI0mqX8tJa1vA1nq/iCsJLCRy1LCbxXYxbHQRzb/bmMutb6ifI40/QR1AqTG?=
 =?us-ascii?Q?nbnhnPrWWR0lsVBXOdiQkipKEL6kaO0L2E8NX11ZMwHqz+TSH8QWCLtXO+iv?=
 =?us-ascii?Q?b+JyRoVwEs0ER5r/YfZnZL39cici7TeQl8hD6D6+X/y029RqI/j/prBktjdP?=
 =?us-ascii?Q?Uzu+f0Vry3tn7r1Vf1uh2dWFUPhe70OBRRTJWSrF9QMgNyL348tetFXk9tCr?=
 =?us-ascii?Q?Py6ZUl50sPSlqStSi92tfcvcZDAHEOqvvxsXF4m5qOHGWxpjy5i2lFXceNun?=
 =?us-ascii?Q?8jv830+FniIK6JRKaKt2vl1CFC+BqXuGRpc9HnIVDH+ixS11o5jpKHmerF0w?=
 =?us-ascii?Q?K6l29C6nV7gS1EU+ompOYm+yaD5aL1LirN6AUZZbGnKJbsDx/4LXg+F9YKCa?=
 =?us-ascii?Q?msrpUKC52f/7CbMZIK/YbR9FYr9kBiwLnmnPngsJ9Wz9cxqcJr6FLppuvQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:05:14.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff4230a-973f-4ee2-ed92-08ddc891e7fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

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
v3:
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
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 14 +++++++++++--
 4 files changed, 36 insertions(+), 15 deletions(-)


base-commit: ab6bc44159d8f0c4ee757e0ce041fa9033e0ead8
-- 
2.43.0

