Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5E216392
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752882518; cv=fail; b=QCIV4oquPhP3KsYd0sNPY4LzAiL8A/X0OPxtmZ5iKJr2GOQ/jE4nGCFhiNUkVmGrvyC8GSfMUXeFrTItnKSLE9WB27CgSDdwEJTfu6h+DHaHN6qKY4tV8BQdd+lmEsILSDuiy4O5WrQdQbTjhDzMthCmzuck7dMjBijvJKlOsYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752882518; c=relaxed/simple;
	bh=d/9oPa0WBLNw8JZAPM5QI0hA0cDOsqm6E7CSN/T0YHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXpE+iWM8MUjUZIMKXRp4SATJOjWvWCIgh853W9ulVcuhx3kEb98w5EXVr+XrSlcgN6CmDIKCLhOVnwUZLdh5SWZ7EUkDK92O0zdXEQQ52uDILt7oEJf721Efjt6GvlgDi/gNZjZKgNAcp9J8Z1hljhWU5NtvGa1OYIlaM4913w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4nOqmSo; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4nOqmSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkICzpQG4KsR3dV3Gml7iPgJUr457zdqi16FOjdlJp2msZelSwSt5JvkRYYZQiD2f54CsNhRx0ogGT+EZCpc+yoUhUUwpoSyzYrunPVc7pL4yN33hcKSeK8JW0CzaicdXUb/XrvXyF0uOMTyUGs5bWD6Oferv5gW5AUhxDNcztLvXcxHcWszZiDMhiVVOanfsM7PhrSGqtbiwPyObV3m1LGsm71/6pImD7weux4jk4shnZ7SjZMzLIlHptUmGc5cpr0IrpA1k0YdvfONOWyM8PfZct1QsMec3rEUSmzyXxzMyLbrY3jrvCMrOG0Jco1XJFFqMhyRgNVQ+r6LFsTd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmXEgxVU5OvxEkJQSilKg3XKqJl6Sg9YH6bxPyuUmqc=;
 b=mBIEj59CTD4jrfjouk5MPfNRnph1VHF0jp0o5gzwlYM13qk8Un4UbW1NR1U2x+0FvUqxdSGYwN+5RLf+V8D4u4vSyMVICreHBWHUe+P2Htw/lG3Jl2QAu3GbJ7KbHPNaIeqzglfJT9WTHiNNUsNIZeSqXTNd2+iEV7oykpjBsM1dQLHZQpgdBp0r81PcdjsPnAc/tnYNDsIafcMEdrhCbK1cl4kT9+u8xY8aNTlapS5GVwLOr7yw96gXiCyzJcExBUt/BRPNthm+POuaDgdRI1rbt7aJyC4X/z6SJDyFWH/hM2397qrvrTkb4jnX7ECJ99jWii0ZApafDtScH5gecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmXEgxVU5OvxEkJQSilKg3XKqJl6Sg9YH6bxPyuUmqc=;
 b=K4nOqmSoEG/ENJ7dGkVjyw/bnf8zAd88PfZNS38+bHRg1/pWRpnbhY0PpfHFn8CpeGrEaFV0yt4EYbvpPwf4KoZK64fqF41KwtKVvH7u0O6Ig3exATgZYMXi+5fqFZmHJfiDB8ZFCUIyIFqLuT4qQvQilbr0F7hSdWmBlLlXjGBOO5Z+z9E8xNd+OXkAy6arKb5zA+IwXOI6P0sT0OXxtHDS7TwcWr8bRSSrDjulg/coHOTeuLEp6yaqySWtJeZxNgHZHOxxT8qHr3B6UzmHEOaimnqZvtcgQdmmc9ie5qbX6faAk5nBVZOqaYnOpXMK6rCnSAoOLg8Iy1sLNpaJSA==
Received: from SA9PR13CA0119.namprd13.prod.outlook.com (2603:10b6:806:24::34)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 23:48:34 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::ea) by SA9PR13CA0119.outlook.office365.com
 (2603:10b6:806:24::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.15 via Frontend Transport; Fri,
 18 Jul 2025 23:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 23:48:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 16:48:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Jul 2025 16:48:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 16:48:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 0/2] iommu/arm-smmu-v3: Two vsmmu impl_ops cleanups
Date: Fri, 18 Jul 2025 16:48:20 -0700
Message-ID: <20250718234822.1734190-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: c1184beb-d102-4a48-f84b-08ddc6559b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okOGhlYqhG1DRCB+R6hsd/yR3X4DvxG+5QKGIhVKXkTsiuienzODQt8RJaCG?=
 =?us-ascii?Q?6XMybJrwwOPcN8u9VeiB1PP0VGCJJjpyo7tjFAy9YCupsoIVPxvrUU+V7RWD?=
 =?us-ascii?Q?TPj30QZHLMzJ5rrLMxUPGQH/hT8Su4ASOas2JuZ4OZVJ027laBishns6ZB67?=
 =?us-ascii?Q?YGWFopXhE+APAQtyDN8SfrX/11thYWMBfqE64TufQOPrPmbesRwgt5QGV3/U?=
 =?us-ascii?Q?zceu5s2CbDDNsfjocXC1+CvTXyCaslfEG4vuCGMMMNdkSHvdII4qFTZmEDK+?=
 =?us-ascii?Q?YXc8uQZ2uwrsHyxloeMG07zwqSXWF7G8zt/LlcZ7MF+fk6TxtIsd/slYQpWH?=
 =?us-ascii?Q?miHho1FfagZsAYsP0E1po91QZ8jsoXpT6NC2hsEk9wsHNWobDeZSBlJiQkxf?=
 =?us-ascii?Q?9LECJywtE1SIovB3c8ZkFFbzC8hZsLO8TVoVlIBezu9D3XmjEufRcnFXzRpk?=
 =?us-ascii?Q?P2nLDvT9mHpEAug0W2VqS5/y/LWpQmFCxcYzBYqJPoaMLtLVNffACK+OYmBM?=
 =?us-ascii?Q?vLDjFAsf0PScu0Az75EH3IC/qQmG/y0wyJriwNFUz7V/JbKyYgfj74kAT/0G?=
 =?us-ascii?Q?EBwZ+ftHECMLgyxIFq3NKAL19I+9xkYEB0In2rtCnn7B8xsngxjtwhSYFFkS?=
 =?us-ascii?Q?RybXxvpQaswv8V04BZT6JmYsurATwSiS1+SbHlSYhBUd9RY4reTuwppvIEtg?=
 =?us-ascii?Q?3LM+BNoZ1cAH4jisAdkMhWsbbXpB3QYGdG7jC9+MnReQxr7vNCiqEbhZeTN5?=
 =?us-ascii?Q?waBtrqvsvziXfR7P0TpCyV5eyKKSQh/So6XEPDLJPyMgOxq1NPCRvk8tTZzq?=
 =?us-ascii?Q?kIXj7X6RySWirRSGFlGUSvbtjJKRMIxZsr/LjbPD5zwHuk8ODmlt80wWHFym?=
 =?us-ascii?Q?vrX5a5krq9nZ43FIdLprAW5qboXbe8kM3Nkse2iFz/mHp4um7PH3QPe5lgM8?=
 =?us-ascii?Q?AancgKM5JlXZVOalkhs1XY/TT+S19CWkj2IFtuc6brCAjbGco+yDDLQctg2U?=
 =?us-ascii?Q?BDhZp5zGIuApty1NOVzfomd4ehomZoEnuFSsbM1rejGCOoCaYdIy1TWeLlsH?=
 =?us-ascii?Q?0TodhFW6rYvbH4iIo1jcBaPDn8R/QIYhioInFyCPNkm5reNGzDKSXVCQD9hb?=
 =?us-ascii?Q?fOfEI8zqth1/GGE3iCNlDvVjAaZcH2KIVf5FEhbac8AuK3KrxA8ErXqYnjXz?=
 =?us-ascii?Q?YKskvwDUED41ogmZQAQMkq3C/SwD6ldgO8khRl6BIcO/8KRmDAzT68PAZHi6?=
 =?us-ascii?Q?QZS10Bk2P0dLyxrS6ysUPTG7FknnQqd9lIkEmchFeUazmHA708OEVwcq+fOw?=
 =?us-ascii?Q?c4+6VPRnUegCEqePrnvUrq23UaA38bSLTaJWazLTWu5hf4t4QBvBdkJBVa7H?=
 =?us-ascii?Q?OSYr7LoMDlmnED1vcvjQC0oN+hCbyqOmWWfXD6w4N61U1wTMmhcQHCSy9Ccf?=
 =?us-ascii?Q?FvhSx4ppQWK5oPbfaMNEMU5YklJn+frBrwrDdPHDNezQIdWjcFCnoe1S/5PG?=
 =?us-ascii?Q?xmny+gzE7zC5hJ0MQmKjuDy6zbJaRynbQrJbZbLg6MI+oa3OzWrH+91yXg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:48:34.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1184beb-d102-4a48-f84b-08ddc6559b98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

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

Nicolin Chen (2):
  iommu/arm-smmu-v3: Do not bother impl_ops if
    IOMMU_VIOMMU_TYPE_ARM_SMMUV3
  iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 26 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 14 ++++++++--
 3 files changed, 28 insertions(+), 15 deletions(-)


base-commit: ab6bc44159d8f0c4ee757e0ce041fa9033e0ead8
-- 
2.43.0

