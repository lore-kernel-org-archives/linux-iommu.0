Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F90F6F06B
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772512; cv=fail; b=FVODlScft6qyI4uwSD9NHV5DNdDF9YLQp5b30mpxy/hcDmH/HJons0Te6Q5A4IJzXBq07CI/AOhlf+VLELgpHQDWMdDUS+D6c418Rl1WnRyJRIdx+eJGkI22kMyrxo//jsSkpbvkVzsz7LNh22B7ls68SxHlby3BxSifkUL9/TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772512; c=relaxed/simple;
	bh=AKSeGYpllqiB5lUeTFFREeL52cuvsiNzit17dYaHDg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C7d7mJSyq3d4PT86N1Usvbav39c0AT1TO+Eyy8nORlPiG14jKA7T5axfTuvsYgyxp7owAu6hdzvQDLPNWdjTd22weVkKijL/TSJYAnE2i/nuQBJQXAgvyU+uSme938Ab6oxZxSgVEle9mRToQ59+FJ7skU5wy1SEP7WQ0W+uCvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EycG6EbS; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EycG6EbS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPADO3o+MkJZYpncgg657Oynlfmspj0Hky2sk7Pugs/NjRhb6YCM/MSuC9179qZqKu+rXBzIuSJ5stcSYaakl1h31TespuyXnZeLt1q9fdZT9HjPgELgKmdFh0DDgzlRd7zbys0DrZG7oA4vld1t+ZDCIrFktk1Rq9wRGrIPhHBPA7h1XsMHr/FUOVClpulmxAR2LQikdgIszebZTYynqHtxldEmGAxxqahMDWVyUTZdTh3NjOY4TMjppKWggFummlkTDCgFuQ4S3HRPV6VGFxRyWIQd/JZ2uJjg7U5ZJlqt6j+zLWyF736jt7r0sMMrXTp3KzdXEkqMsJqqc6q8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdnkRItqj/PQGV40+5QV4hieCuZyLT9vXC1dnPi9cxU=;
 b=Z3tQj3O3jbDWFVp3L+tIi/MV6kx9eg1zvM5vIZjBvI8YVb4yO7NbWS+UmjJJ6EfxID9/whWW5G5jpT6iEEUoGr3EKZcL8xzJtQkODpkn/zfTR18e0dbVcMOFpmTby+ZQ/Jl+f6BlZJDAVW1Fh1r7CZYgPWTyJKq+XgCCP6dezetM+AKe4gtb3vYmgbCg8cfL08lyQLxtFYFFyCvBbxZwwcxCLe7auLkv9GUffnci52xmXCxNIw2/TbqtFnjZHu19yiqWtRDsjePsaHwxRSMNzYwEkZdGDpYgGOMfn5PuZBjd3Alw/gnWf+hpTZuI3PAlgCFcPwRI9WlDL6b4FuNgwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdnkRItqj/PQGV40+5QV4hieCuZyLT9vXC1dnPi9cxU=;
 b=EycG6EbS19upRXwI6gwz7naTJQorMSMbZZI8aRgnorXyRephpg3gBRx+wxFk2/F/ltIKLkzoC4XapC2lAv9K8sJmvYDPULkpELFONvdohgVvELSYg2GUqd631rIrIVsXBduYQ3czQA3GrXwyq1k/VSwWMUvBpdnJOVn4Qnmomho1WrjxGus8GaX0su25IadoKEThyQawoNebzEjahMZtc1FLCVW+OtAGg4lbI3AmuKG/1MLevZ88aWCky5jlPYMe0+lyQBFDkMih5dGkK2ReaO/l39RqRP1eaADSgQuPCJemfdbODSHRrgvndkfRlrD7VkYCSEyeHIZVnt+w00Xhtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 13:41:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 13:41:46 +0000
Date: Tue, 24 Jun 2025 10:41:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 4/4] iommufd/selftest: Add coverage for vdevice
 tombstone
Message-ID: <20250624134145.GB150753@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623094946.1714996-5-yilun.xu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0267.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 004fcf9d-23e6-449c-5bd2-08ddb324dd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ILTZvIAt1a/kpJsFzdpaQ3g1iiVdyRBsF5YGoTq2V2KWl5Fdcw4Hz79mGfIK?=
 =?us-ascii?Q?G/7MyKbbPWQv0zTt0fgjddwSKDV450tJ/j0berKqeCOv6TQ5quLdTwgI8eep?=
 =?us-ascii?Q?al6+zxJY+1s4nVSx1FHWAXDh0881Xk7ypvLOgVhHr/kV5WqAzy3/Fj47nzMH?=
 =?us-ascii?Q?Akoo83P3EvlPNeUTHjV4CTGAv3uChA9KHtfeEgEsN3vHr/v67+X8t706W8o1?=
 =?us-ascii?Q?o6KcyfKM2ISYGbrVlqcuc0WRynaEuXgC9b2/JICw/G1EBU4t3+BD8rdc8HVx?=
 =?us-ascii?Q?bxYRi93O0i2MF6I2lSyloYraFjuhjf+h2DfRr9P1FM9uM1GVkpV+u5+tp2Vu?=
 =?us-ascii?Q?yvqwmO+yAdX6fm1iZnQMch4C+chkdJHW2fqJ+lBvVDxOHmuGWPoryosUzqn9?=
 =?us-ascii?Q?eP/YNnsjW2bOUoUfxpnx5tibYPUEQW4+vG+dM8KeUcpu05q++Ou2JA4thZUv?=
 =?us-ascii?Q?g3F1Ej/+vh9DyrviQrCaPN1Ctaa4Xc6jVnJeG0iMrbH2a8Wrj1hXogYBXrbg?=
 =?us-ascii?Q?DUdo2JHuhOJRDyenn62GbdykiskpHxyIEvemwBK2cTbGF03AjtYd2CnO8AG0?=
 =?us-ascii?Q?T7aWchE+4lu8KlX/lLeaubmZMf/dnuwe2c4aUlf9+cBoLeN3kRIiYckXTbDv?=
 =?us-ascii?Q?iLvMj0SdgN38Ah3vPGYFZN5y7mMeELYSlc+nYRm2JIpbwr7yvh3tMEIbwqu5?=
 =?us-ascii?Q?npmy5Ll8pFJSHZQ7nI0GI2ho4KVgSuWU6yDh1yFKWX3oniNYj52LikWQYgPj?=
 =?us-ascii?Q?bcWGRQFLMYyg2WKcuidqdE8r2E+W/ghx5rDbcN/qa4yAZwyjcBrtOukoie+h?=
 =?us-ascii?Q?i3c7Lq/DuMXsP4RFSjKGSzeEMoOVlw1GBVRfGVo7PQj247nBjS5sQy6ToZVQ?=
 =?us-ascii?Q?WgTz6qQu96QreW2HWYgMJZrS7BEIH8+/17SFUHWcOr/GRHe3W67g4HzcjVtu?=
 =?us-ascii?Q?gCJZyEZfSusd9v8MJG/6P+rP5Fxeuh5xPKU3fazfcxrRFwQ9AFaHqbV69t9K?=
 =?us-ascii?Q?CR++zBELMGGETjU+0HWJc4FCLT7QOJposyrC8g4CujxLGLdF0/aLHuUikXpI?=
 =?us-ascii?Q?/SDOCwNWtvwpboO6oP4i5lYWFCrFLii35DUD8Y9xzK9T/X5+5MtTBiHgf/z+?=
 =?us-ascii?Q?3Bnx06MKiKKNY4JSwmPUau2vlNetiVTjJI1O1XvzNFk0QpSXYO1mVe//z9t7?=
 =?us-ascii?Q?5ZAL7Ay4fN/hZpwo1rtxHKp6onA7ncDwsjzo3CSlIwio8R9zAHrOPQWca6cB?=
 =?us-ascii?Q?7Nqwmi3RegZVFvTyHPCgeKA1GMDKTUGroqsMlAJrNf9ss8gHn7uFpikt7l58?=
 =?us-ascii?Q?2JptJaCO98QMWwoQmoS3lLXLlPvHNTN3Ga/kLManhXhVvA4U9023GqbdaWnj?=
 =?us-ascii?Q?TbDaXmYf71Mm/IVCH0TQNFohSlMH8cfYbgjhy7un0PvLSgiLlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rF2odKaiA0f1bNx5a1hbKWmr6iBbyjngn8jOMxShrRM2sNSFVUiUNo2VqmG1?=
 =?us-ascii?Q?s8YleIsku04d6OOuDmaz6VdTJgnChdjZJrittMOa0Ftj/tDs9cuIqHwp4KxG?=
 =?us-ascii?Q?IIhkZeWvCCCU6u1CbYFOIqMRoB1x/I4BvdHn0Z+XEEdKHRVazKxC+UKp5AXh?=
 =?us-ascii?Q?+B8mkjZbteX2WHraB6pszOo+IiErEW0vGgTJQEwA7JAAdhAAMiHlCSCfJS88?=
 =?us-ascii?Q?tFByYwvyYbPzckaKBBhJV16XuaOb+s0t3FmOXAhx8DStiLaloA0XyV7/51Fp?=
 =?us-ascii?Q?LDILOQzml429JiVfQRNn4RSOMtX2fMpCHeGAwgY2SC1A8fLExv+bpRit+YgM?=
 =?us-ascii?Q?SU/icVnmm6Fw6uYa3upI/PU4Z7BVZXgbcCHwP4UOEcKJYTq8LNXSOkfdBR0M?=
 =?us-ascii?Q?MUBR54TPCnJLi0FY/5FCBMLFcCUNt98uWuNnOZCn7ycb4yMunjzMdIO3yPUH?=
 =?us-ascii?Q?bRm2fNz3FHbXMTPhlFkNdEWuUTs0FNx2CQjYn/AB28zDufKScJtDFzESW07h?=
 =?us-ascii?Q?4b2uZ2O6Dfr4eWEosXEuy7Ub1JsKH9a8trStL7IUnnRt0jYFpfbgSfODGj7c?=
 =?us-ascii?Q?pYzrkfuOVsZR4012JE3p6fJr62Ae1Gl60inmUvI1a1K+OJVXludM2+bD40EL?=
 =?us-ascii?Q?Nr+pWBNJn5Pql4h6ocbcW2IZiuIXzdqKXAhn/AZGWE+Y2n2Qd1zY6xWjGSZp?=
 =?us-ascii?Q?tbxRAFUNkWuIHfk5GzOSEbVtudB/9gcMfkCTRIE3WIIUG7BBBWRnumaBclu1?=
 =?us-ascii?Q?Hgd4xxywYV9i0TIME59ehiGCWAoCTnAOpIlpEZ0o+5WEsmXkalp60glEDvA5?=
 =?us-ascii?Q?pXYk2m+X0nPfsIl9nyi54tpRsx0x9okMiNgI5d2LtI6Th+jNaYqoIDl+08/1?=
 =?us-ascii?Q?B0p2Ya2XzFhw3c25FNsOhxtpTKLbwjvc9m6aFIuJ9bYXXhbBkOfH2CYFjHdQ?=
 =?us-ascii?Q?whnGqD2UbLLVb3mIM65IakRfGQvEkOFLbGyWsho98TXlUPZfC7zhfEZZcVw2?=
 =?us-ascii?Q?PN1A6iyUjIgyJ8DqpiQhee/GBsUpCGYMmPO842xdRuk2yyg/96kOJX32+piA?=
 =?us-ascii?Q?hglOsHU0jieakBoB8t8ea3+RL3lVyW0Y3UZtME208Q99xS2x2qIm5QxF253K?=
 =?us-ascii?Q?07swdjojy8wxWpegzyRnNpmNsR9gb/rClpovV44FLUMpWq4vXXKHv2XZcNTM?=
 =?us-ascii?Q?8gtXAmzPBl/+ze95MqFrdE2UMolVQuo32c2v3/Xi1lNwP2X2s1xVxwt89GLe?=
 =?us-ascii?Q?cYFbf5+6hE5bknXIKKpxUyb/XsvT1pHmsuzRGP1zbBQ+sZN0DEeIHmYbjhMx?=
 =?us-ascii?Q?PC6AQ6S73DRrImI2Z6eX4+jDK14wTU8XBy6MiI4msccGT6KmpowKTA57Z4PA?=
 =?us-ascii?Q?w0VyEy4DbYFMbkYIIALZqI7h9JhNQ4aSKeIkXGFHDY1/CH5jfe6t93uRRiqf?=
 =?us-ascii?Q?X8mCv8145B2rUZW82LFyIMFAfi/91Hlp2AWrPMVVz3RV0dXpoU88s2uwgYDM?=
 =?us-ascii?Q?Jumiho5n5EIa6E91BAn+ZNSV+aHNHZ7h48GahFIfB1jo+HNsLycrPDWIHj7I?=
 =?us-ascii?Q?d011aJN6YRk/rI91I8LrTHL3UM7I67ilJqFyUJW4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004fcf9d-23e6-449c-5bd2-08ddb324dd02
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:41:46.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJmn3WRGd9fQnx8TqynpagMcj32HkSAroL6jEv9iqT166/rqqHbCKDhFiPenrI2h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On Mon, Jun 23, 2025 at 05:49:46PM +0800, Xu Yilun wrote:
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 1a8e85afe9aa..092e1344447e 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -3014,6 +3014,19 @@ TEST_F(iommufd_viommu, vdevice_cache)
>  	}
>  }
>  
> +TEST_F(iommufd_viommu, vdevice_tombstone)
> +{
> +	uint32_t viommu_id = self->viommu_id;
> +	uint32_t dev_id = self->device_id;
> +	uint32_t vdev_id = 0;
> +
> +	if (dev_id) {

Why the if? The test should work or skip, not silently skip.

self->device_id is setup by the fixture, it can't be absent.

Jason
