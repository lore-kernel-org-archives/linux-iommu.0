Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781EB482F6
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717701; cv=fail; b=hmSQfd17kL+8nraUfMO0kTlESmdfKXg3T0kDIu6F9xfnBdK8T1OrrRj+d7kJt/w4tjuZeDAYzJsMNvaP+rRt1Va0Rl644zfaQlI7WzE4dxzqSAvZQglfPsaN4OOoYiIxUAWTTIT+j7pvEzyvcxcqwxfv0SQXTZjt9wri21Rp/6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717701; c=relaxed/simple;
	bh=1/vfaL5AlTo+6LVMlw0HdJz4YiOYZZhhiKStEOFQtHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L46eOBoVKV1n5csmurkNqNUPkFlFfTp91QsXL6LzDEk/CJDW6xcR9Ugkdg4Vwtn7LBXbqjJstiyRPO2rraG7MB0J3W5Btq0ZBrEZAHoziOv7tRPdk7GZLT56yUGNPvI7SurhaQNNcxhdLUZ01bC47gflSYewHgSpqv8+X2tlBBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P4c9cE8v; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P4c9cE8v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlYSFIwq7FaIgByQzCU528BmzcI5XQU9ea8xqTHEdHBQ7BFTz3ch/+kzUqTonbnHrbe08ZQvJi6r78iNT+92CoERfgz6LRUxplA5+a8jv46iBgYqyJIWA8xMRHE4+eJMX0yRGjWiCdhn0pzQPAj5n3iXFQ3IVL96l73qyeW2jzmlKCXkvf7z31J7stPGBOdCqxfzjK2F7DaV34/c1pbpLmxpIWgCdMu6pacRsldhMQ/ZibjivtY5ySrReq1l0Ih2nK7gwBzdw7/yOM7Ax30Fn9afSkNls3drIiTkYEwg33q4Z8W6SuFufczG0Ad4c9jbO6otgXk0RDaz2Yagc/XhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxJha5IkapjYDu5Wd36VCeRVD80u6WHW7Q6gLdVeZk8=;
 b=BYHI/DTsPLqAp6PXMHkaxiYNNXOgt4XadY/YQXtn9yLMdWBQKs7KTYiH/2asOy8b+DQzxT2XAZqRRRaR5fz4R+20vqGKF+Dh2PrFcgVDModVwO60+bANRkUt9y+8TnGTMMDU4i5JoEjIDK0uZSJ4ZPYknF2Ld2a4vnLn8+8T8FAEh/WEfmEEAjeYsHdLVh0Q3r58zmin1o3oNpQ3gAQbnqchedLApiMICcSIbiEvVKH7lqtE014t6sZR8XDf4wbFwDi08F+E1Hc3BAniQ84LCra9HuN2678+bX6K10qkPdOV5Q7RjZ2awlnmDxDSGhwcWgrLzFsH5YVmcdsfA77waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxJha5IkapjYDu5Wd36VCeRVD80u6WHW7Q6gLdVeZk8=;
 b=P4c9cE8vaC22ZC8SeTy3pctYesHioO52WnrWX+q8SISAxZQFywY4m8JrB2tkSJ7YoTAUBjgDv1uPKyDNHqCysEDIjUSKojQJvYANi2v5zWD/JaMoCT93VsfS/wQf0a8F7btwhyGYaZfxH3TdFvLPtR+sY4BUr9s8atnuB/9Z4KCNVznVdRojU83FhncSyEHpx2La/pSBLJU7b50QM6hcjN7VIqafkIu2/za9lEukWyeWc46fDosqIrZNhoeL0BdnUx+Z43oyvHlTvbgAeRnMt4ytKenVALlWBeZ8CPjS/RZqvBM/c+nZkrvY15He6haYjR5ScT0CvrELOlZm6qdoBg==
Received: from PH7PR13CA0023.namprd13.prod.outlook.com (2603:10b6:510:174::23)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 23:48:13 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::a) by PH7PR13CA0023.outlook.office365.com
 (2603:10b6:510:174::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 23:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 23:48:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 16:48:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Jun 2024 16:47:59 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Jun 2024 16:47:58 -0700
Date: Thu, 6 Jun 2024 16:47:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 6/6] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <ZmJKrcPeVdcf3xyR@Asurada-Nvidia>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-7-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606133302.17540-7-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: be924fb1-7326-4cc2-1cc6-08dc86832039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H897/8zbbjM7qelidfa7U0T9tTmyEkMWoWacefAT7ULtI3pbXnbUZd7aJWE3?=
 =?us-ascii?Q?bPhIJAVtTouqNAIgKVC1P5rrSPYb3rlqemywQ4BTWvR038OqseQ+Q04nmisA?=
 =?us-ascii?Q?4wBUBovX73JBhK5+BhyWtGDX6XZ9zCLRY32+6VmxqI+mTvprb9xTFHXhcnUR?=
 =?us-ascii?Q?Sf29AMpxw5B7Gd5D74XD12OFzxpq80GlZMCUHmc36MLsojrtaaarf7YgNXj2?=
 =?us-ascii?Q?yWfYug7sJRnUr8z3+mioeI7O8R6/ZGHaZvtLYsohk89yBe0ClMZc9nJeyYy9?=
 =?us-ascii?Q?6/2mLVSiLnyfRkE5Xx5F42crnFpLRPx4WgPTRsbPJ8ZqKS6fd2AJgxWfI0ic?=
 =?us-ascii?Q?qNLNP9WDWpGq+o2vrhS/rKJ/T8W00rrXNp9taqyX3EwTyQPTG8hnS9JpzZwj?=
 =?us-ascii?Q?p8uYkvFN/FT3JHb0ZwXsI9nhXxdw2V020S4QAVkK49xlYVhZOFDXrmgV59BL?=
 =?us-ascii?Q?P053B6XZTdg1skHW/E6mBC8RDa6OzIr7Auzf8ok7o10dJHKarNI21JRPRbPx?=
 =?us-ascii?Q?PB6J0G+KzkMHAbougwvoAqzsB1EcthvWoVtBnn2DEo0SWWK7lXdTG1z7L0Xg?=
 =?us-ascii?Q?LR7XM32/cPvupAJCnQCWEvfJA7T2LjPArsuxi2cQzKNSoKPwuKaAO9VezTSJ?=
 =?us-ascii?Q?eAscwBFF8vedx+bfES05suS+L9Kb73ARYcrxRaS8yLJ4eZQAHrrWtGPyZNN+?=
 =?us-ascii?Q?zJN/2o1bd4VcSWhW6l4IWwhRYRSj+nNVhgdx+UB1NSB9/6bSekm2mlBJNWIv?=
 =?us-ascii?Q?mpX+Ac9Lz4hM0MWwTJfMY+KKauvzAePj32uNeSJEU7WdQNQX4id4IvARPRar?=
 =?us-ascii?Q?13Tq/2zNJo593XzRrAE3govlPR7LEzuohleXsI65+EICJQHBIvZWarlN25VJ?=
 =?us-ascii?Q?fITqUJQ0CMjnX4p38gfS+CkdcUdykF2t2F8q9dhGjDj0q7MtGbSVVg4PUDp0?=
 =?us-ascii?Q?zw6aKIgUXrQvBKQA0TG8PW5wmDOqXBQ1Fcuknp8gs0eJULYwSt2KOpacIz3i?=
 =?us-ascii?Q?7mghFjIrD5k3zxnpM/qhjjhrIpNnofo1BUo2P1eyg5v6+lTrxJ2WvOrP9Dy1?=
 =?us-ascii?Q?pyRops2vc9HwCn5Xk/Nh2DyN8UVtGV+6aUYa85RjspA1NyxDUj69iVX9V+yQ?=
 =?us-ascii?Q?vXNqv6sHpNp3xfNFD5eL4Cw8tdn9fnzxse01C8piGI3esioIbg98CGZTO/JG?=
 =?us-ascii?Q?nRrS0jr9QVUMe8ax3/PHJ+/0mJpcFnk6hcfYfHSbLVVtgfexdl4ozp8LVq31?=
 =?us-ascii?Q?7vZ3UZ3VdH3fazSaLmhNgTSMOA99kx3EaxczN2ePxuim2opF8jf1kEQjjSU6?=
 =?us-ascii?Q?cZa3NSocKdnKdrzg8vAwZvS3qZVO/jD7gcU44Ir9DeCAz+NOljHWnnipIIRL?=
 =?us-ascii?Q?8MPmgR4FgdxZBXMbfW2UpITO7eQy27ggoEQEOcuZzs3q9U0UfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:48:11.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be924fb1-7326-4cc2-1cc6-08dc86832039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097

On Thu, Jun 06, 2024 at 02:33:02PM +0100, Shameer Kolothum wrote:
> From: Kunkun Jiang <jiangkunkun@huawei.com>
> 
> If io-pgtable quirk flag indicates support for hardware update of
> dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
> bit in the page descriptor.
> 
> Now report the dirty page tracking capability of SMMUv3 and
> select IOMMUFD_DRIVER for ARM_SMMU_V3 if IOMMUFD is enabled.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With a nit:

> +static bool arm_smmu_dbm_capable(struct arm_smmu_device *smmu)
> +{
> +       u32 features = (ARM_SMMU_FEAT_HD | ARM_SMMU_FEAT_COHERENCY);
> +
> +       return (smmu->features & features) == features;

Following the existing coding style in the driver:
	return (smmu->features & ARM_SMMU_FEAT_HD) &&
	       (smmu->features & ARM_SMMU_FEAT_COHERENCY);

And inline?

Thanks
Nicolin
