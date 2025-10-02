Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4442AEE4
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426327; cv=fail; b=ERn53bhkTEEws23by+P+dkIYLsJo+As4YZeXf4Cy6Z69lbogAJXpqRIQdRmnU2SqdtIGYuQ/Zm8Ylna4uhFk6c72tDrQzMQkBKxD+bfcgD72yGipUrwHzCFB+hIIqPZerr4rP8TYkjXwhNWdvnKiRB+3T4Tw+uWQAfQwW1MWgqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426327; c=relaxed/simple;
	bh=+VIYK+J4LbpPgjRybZU126VPoHn6Cn9PIwSEiXgZ7Yw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEY0BkXoCbQnWCiIFeQh9Z3rs1zKB6cF88Ed63YGVY/hHRxrjX0GvK+cECR/Phk76W12P36eh8DcUKBIV/PpmckJCBOsPAhLPiAjnit9LSDTgWjbm1McSx2KmiOPQUvPvUVvCs+fb4ijBVzVn2sOpxM/Ydu/nWtLhbuZCBexkkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBMl3qU8; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBMl3qU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL/USnrZO3pVClfD1CAhOqtzBoeCk3hQLp2tjaLkK+MZ4eIuGBOCU/NK6vf6RgsDSd9pgATC8/NetHdHNmdQMcyxsKZK9HFwtxaCk/P+MSwJ+hiF9jj9m6HHwLQRsz8A/11ZAj0cCvtDFN1cyydZBlesf39C5z0yyebYnyYfW2Q7weU6laUQBX+Wi4MtjFFo0GiomnezN71snNcG9G8HNVCCH2GMaNa+mu/MXQdEGrh0ZDjnQnRI1zeFJdR8o0kuv6QuAIKG9pmQXCEzcGBh8m7BaGte+Di7mb3TXHWuT5nV6PpcWLx2DlYFmlVa+bd8SSNdatyoq5Ms9oKf2q5vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6fVdczp/HcbLhA5+Jbx0/7wsfuTBExeJbAJl5JKmfc=;
 b=st44PomTDow9+PlQHqmU/7n7cJcbCUyOAzoMXBMHxqRa9zR9PorBHgPcLtmBDeJG8wL9ynUc0LKIVq1dfqNQy9Gp/hcACuq4nLpIVyeh/BrinR7rq3t3QlvRRBKeWhyLIcxSP6CkezSWck6/Lu7B1aTV7WhW+oNCo5rdL3mKiDqBUAFSXv7sSDJjgnVg1GpINsV/XYj3XgVM/rOVHTW33S3z04Ny2tgmXrJptudBg51c9Ki+g45ZrtQL80pYbKmM1PlPBCPMEVcC8IRqiZotwhGnY4lTDjvVJNB2CP5zL9jUdCGUuFnAUsOxvbV2GQoa+bgV3lsakBpSyLRUqb9MKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6fVdczp/HcbLhA5+Jbx0/7wsfuTBExeJbAJl5JKmfc=;
 b=dBMl3qU8SSjaWLt0vMqR2v5EpY7BQoTyz0qG2mjKGKY5nMhxrrf32uueITDs0K6Sxhtt+9004coB8+KEA/jtN3ahWwXWNilJDdNuyCEcfaTMI/qYQalU0MDf3u1UmusGM1rsO7uXsrSIvyiTO6jxc57OhDZggMoeJTvPNvzUU/40SUMyFjFclnnjjPl5gh2nFFCgNQzZnFnGyIy2ksC1ZBmoRlt2bCl6mwCpy8E6Z1Yjg97G76S8oXf8xcj0eN1CK3CufACJVn4qkNdoZqaIaa5gjBQSgJoJHFtIs6rBaUMkh+GJhku3Z1Uo+hcWoztGdcZe2DPcOHtnYHT67/4N2Q==
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 17:31:59 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::f2) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Thu,
 2 Oct 2025 17:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:31:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 10:31:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Oct 2025 10:31:42 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:31:41 -0700
Date: Thu, 2 Oct 2025 10:31:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 08/12] iommufd: Introduce data struct for AMD nested
 domain allocation
Message-ID: <aN62+4QMBV8/a4Xy@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-9-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-9-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3735f2fc-c934-480b-d7bb-08de01d99776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVDLLKh1fKIiYQwDBg9U4o8O6YR5n7mgOsHIVKez39gRm/u3NpU/35WgFSEV?=
 =?us-ascii?Q?1rSsblpfPvvYVLQpIpcPrjx+e1r23b4a8MOHQUvoiIFhKaaw6xltEuBG81H2?=
 =?us-ascii?Q?C1Dt6Ln92LuLK+qkZmlTISjPinA304xikfJtoIsBU1pH37YS4ns6RJOYvJBL?=
 =?us-ascii?Q?DK/aZ218nXknYfK7p4uDF2BWn6Cy/wHd4KE2Z9S4cwvIgMVR7/fT5JGjhqx8?=
 =?us-ascii?Q?JNFFZYC+/nIX5PgsyeOSuOW/GHFDFoiqQnCXctT4a0QEwjeFFZd02ACf8ZU0?=
 =?us-ascii?Q?ea7ZWaV6vE0eENjSUdHmjf/5msQupzWV74TenFyQJgtiC+oVRZ7Gfe1MMK0S?=
 =?us-ascii?Q?bQyWvdbbTIzXvLeVi2ijMPcvVIsPS7JM0if30+zvE5x2JGF+NzV/g2Tb33lR?=
 =?us-ascii?Q?gUV4d0WPwfRzQIjm1jdO3kcLe+AIT5+ytOJd3jjgliyd17+gkAHjBZjePh7l?=
 =?us-ascii?Q?qyN/vHbwpxLfwHWM3KQ4BDuCEP/AcQ45ch+pfIiLbFysNrZ14vj5ZUFdXD1T?=
 =?us-ascii?Q?BYDBjMuNk7Tg4Xm50ax652+KDNXkyvDRmiZtiWJuLnBGJjpOPnSh/+SrHRdU?=
 =?us-ascii?Q?Xh9GK90X/wICjTNcswekCfrWc35O60Ht0TpfuogMDBoVWTjqrYxv31H1yYSj?=
 =?us-ascii?Q?WqmtJ+5njcm/dV1E1u90QQRToYOXxYHaGAjZHA+l6Slb+/0+sjBrCsvqFNtu?=
 =?us-ascii?Q?NtBGrrJClwwRqEYKxcDHqPnNcVuQtMo5PyDv2tg3WbVJggodH0eiCES4ddL+?=
 =?us-ascii?Q?zBlG2mvy9rGNcDtQex3I1Dl+VcCyLTWkGZIBGPb4tnBADoJQtRPhs4RkNtYU?=
 =?us-ascii?Q?/7Cl36DkRggtxaIXujXYNOQPwEy8OtcijrXUxhBgZ7REdkdNMnJdpnrzv8rU?=
 =?us-ascii?Q?UrMHfHuI+w2pHxHSfeL3l33Kv6dWLR7nyo5cu/UlQtgmsFCHYFeoLD7tPPGQ?=
 =?us-ascii?Q?NaFCZKLkWPtOpA6/TiLxA/GP26+uoqSiP5Q1yw4JuMAwvNA9qkDtMPIQH7HC?=
 =?us-ascii?Q?zYz/JzRGcrlLzEo7JaokmaqaUPP9OBVW2o+h31ZNaSrxhTqCrel130B5BVL8?=
 =?us-ascii?Q?TZh6hNY6gyAIt9iHUOYdChIRibIvYxyXAGCTtpX5W0j4tUoWls/uWT1nv8iH?=
 =?us-ascii?Q?YD+xEztdoOXheNd0uDqf37YDfjfYqiVAnXQHgBPNKwuqs7Fv+c/ySZ2oU8aB?=
 =?us-ascii?Q?QJc6uKD2K0teuVCFK8agY9LoGkKjoiWMWsMYsdX9x90LMxPJd9LgkyGeHTPz?=
 =?us-ascii?Q?pI+cu3zYr/N2LTh2qoNCqfXgZsprD0kPASH8QGqPHKnCf8ErxgM573B6e9mg?=
 =?us-ascii?Q?S5XznfVuQUYSMM5aZSr/3ghrCV5SqtYudmXd9SMxR8QI0jFSDLZv3faxAjNA?=
 =?us-ascii?Q?0bbG2Jd6OON0pKAoJL2Qtb4VqXUKWaqPwzafv/YXDOCkMEGFuSQSe3iTbuWu?=
 =?us-ascii?Q?AHhaCpaTi2R5CSjGz73NS9LM5PIIs5XIpuWwx1og9IcbDNvq157DedO0Cabj?=
 =?us-ascii?Q?8OPBpToBsaDYyIA1Aj3RK/so4J7zDNulVFknzxRnkBq4E0BS2KrLoMZ2fq0A?=
 =?us-ascii?Q?Fmb/FnJZmqyntBoft08=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:31:59.3611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3735f2fc-c934-480b-d7bb-08de01d99776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

On Wed, Oct 01, 2025 at 06:09:50AM +0000, Suravee Suthikulpanit wrote:
> Introduce IOMMU_HWPT_DATA_AMD_GUEST data type for IOMMU guest page table,
> which is used for stage-1 in nested translation. The data structure
> contains information necessary for setting up the AMD HW-vIOMMU support.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With a nit:

> @@ -455,16 +455,27 @@ struct iommu_hwpt_arm_smmuv3 {
>  	__aligned_le64 ste[2];
>  };
>  
> +/**
> + * struct iommu_hwpt_amd_guest - AMD IOMMU specific user-managed
> + *                               guest I/O page table data

Following the pattern of the other two types, I'd prefer:

/*
 * struct iommu_hwpt_amd_guest - AMD IOMMU guest I/O page table data
 *                               (IOMMU_HWPT_DATA_AMD_GUEST)
