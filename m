Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C301D5176
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373938; cv=fail; b=iXVhGLaUt89fddYMTTOddeIzTMW2iyXoc1s1Rb8YkLXxzIxo1UMvXkji9fUpaq7hNBzpYrSTUQ16rkjpe4PXK1B1BLN4vpEZsXPi0hh9DKKxzzweJfWRzpd3AFV3tJhiZO+2NitFMBYWKFlz4T+g7vD1iCUwm35CA70uUV2Q5uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373938; c=relaxed/simple;
	bh=aVa/BQBTBXmgIABttWIooE4N8VDW82Q8h91Wnq4Y8KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cd5CIFE9fhqld3o2zXtCCHCHsy2/SSsgXKxB47J3L0ATtlyVt/6xmhfNPmPmBFAHriY3LK7B9SmiWPuBhsden8PELETVviRHfdOrjKzBRwR4I4m3AgRqosRrekcftI4DpYD5qgIQ53hTsBsuwCJo9vJj1PbKoGVG6qafX3dMOR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IzKVD2EX; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IzKVD2EX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrxBRF0fUCp9pAWw3Psma8lj0wH+M8KqS7YuXeWJ1Fy6nA8NXQt+QrgxFceW3gqXde1UzbaJFI229TcaxlBIBHqwZHF9guwyWSxovaVjTYvAPX104GCOWlIeVSqG6rvWHgcDIMfj3S945neAW/7j0EY3P8StC/l2ftiLAaW7phHyKIpZZjT4blD6SAr3YOHjFKl3GoD4limW4/RsHg+tsDUmp7sBcJekxNnCWcueuAn22p+rtk5NIqmUWXjkzoSsJ0w+JV7byaEI66KF5+drF1Ocm6WSJ373rQdrc1koMSLQ21Xeg9L/SegvHasRjD8uS3R02UB4fe7fvEkXnAByOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp4DN2FMEYX92BN+O49uXfBzaxT2toOYzPR2AwO4MEw=;
 b=uvBNbrishYFGvpSrqFmCDviVdRiRR5nzchcqXI8AVdQeYNQV7CN8OYq+O+VaHoAsgzy9hgIeA6s+T0y3cjJH3/blYpbVkkDWXZxmk9szqUS2/lQeRQeTCIc1FoAnOpm3MlZrN6y0TgTgOCt+RwG82eJKAto+mfwCrZdmUgup1D/+sdajTElYvKwbEs0Z8Sb8VDucaCRl4DeyScsJ+Cdbnj+xVIAYC0ttRadd4nJ/1fKfeGybbLtEK3t4bulDhelQZWGoiy7rSB6pqrl0DY3oSWA6mrgSwcXTy4Qa+xVy32uzYMuchxRBSDPHngjh7QP44VSm2N9sRnUHb4nUL1f9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp4DN2FMEYX92BN+O49uXfBzaxT2toOYzPR2AwO4MEw=;
 b=IzKVD2EXpO9/BCfASQpl6mmC2FZSGliBc1S5jKnZbd4BTmlFgEFL1cbe6RnVCc0CZBMNb3cPUX/+gR694j3UFp5bMq49nChPFZH3v04SszwhbphSQsGf/E/Znhn9hlqZ/p/T8KHrNav45n6BAunDrVWv7hO9MHo77wV624tl2T/NjdkpV+USDgPXDcLRxAm2uV87iZuAp9x0mFlStUxUtJ1JKB+wWt9MzspoBHr0Gv1bHpCd1q60xes2SgydesTM9EvFQi4z7nFloqUie+EVR1WJMfPyuNTN87c4i3HO6TSBUpqetdttn2PaUnBQoOzcpdxWkTYbhvyBWp2A2R10WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 15:25:33 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:25:33 +0000
Date: Wed, 12 Feb 2025 11:25:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 0/5] Misc iommu_attach_handle enhancements in iommu core
Message-ID: <20250212152531.GA3849539@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3ef340-e62f-48f2-ce31-08dd4b797db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2/6MNRPplTrta2PPzgj+IF/+zVvO3x3KVZCVVAr9ttGbkV/hsAvKVux0WA8?=
 =?us-ascii?Q?HUJBWNu648lZPsTqSwdgs6hzpzDq3/f1k7t22KR4tp9TlQCKFANMeQImeZ7P?=
 =?us-ascii?Q?21C6UH5n8NQMDq8q/7wqzNxjBsEym/Py+a8qzSxrClGfoDEU1oFMHJuBH5dz?=
 =?us-ascii?Q?JOauZZCuzNNPe+xHeUOiXKonatmOv0kfIfa1GCVmaHhkZdmApz7IPj2d1Xhu?=
 =?us-ascii?Q?PjhRUGRMNLCVYN1x46l8UN2DvzLR7Hu4ZdsIKl0r6mfA+47w69yiTYDvnmyI?=
 =?us-ascii?Q?SLk6TULzB0pg4dDegwK/GlzJNl359ve3uAUcKBulpPJMPOCxM9C2Ya8DjzQF?=
 =?us-ascii?Q?w/Ch5n1F8St5wNZtG7hJRz3POMrEpQj0UFU517ln/GzgJRXImEX34yRurpL7?=
 =?us-ascii?Q?Ex0QhDF37owXwMDlVN0fGmJQIaQojU1jyY4LPs/2WbtXQalgXc8a9z9dYg35?=
 =?us-ascii?Q?12tsml3024S4tK9MbalHYs4PRfUgPGTfnrCnLqMsMTKqoAEqCdpXOXBbuK1M?=
 =?us-ascii?Q?ZGrIre160xQ5GrQW51g29XVQWRkb21sde3fd6ZKTvdh3e6GSeculg7GJsITl?=
 =?us-ascii?Q?0445nGwJvl7jvUOnwbTriuOoZfr8XmDYhJmbk+fHo8wMuMiow9u7LjPdv4+w?=
 =?us-ascii?Q?+seogFYFp0SSFlQg196zBD0hqvjQmA9lw+HmV2aHreKlYhnppaTCSDfms/aA?=
 =?us-ascii?Q?fmJM5uwD37HV1vR3TlHTf3bDNRJSB9N8zzdFqCazAZiElBVV5GEBU7XHNKl1?=
 =?us-ascii?Q?oSAY6kgw5V0LhFTBcOmIT1QK3LOTmPOosdMSznr+mj8mqlPhyP9lV2rHobgD?=
 =?us-ascii?Q?cZGRCY0sP0s8jxmOtcBgrpWFzKlPRXe+NcJhD/BTdzmAvFlonChfKwYLNQHI?=
 =?us-ascii?Q?Hms4LJEvbR8G7TRZSjFK+oliSKxliJBQhPA3bYLGyHKqZ1uHXRTIl+Bk8Zwm?=
 =?us-ascii?Q?J+cApkpJ9yvbecusvU42mtvBfQ/AD7ScGzWG9+eNWJn3QFzauEfYB2EHE2vi?=
 =?us-ascii?Q?A4FbiF3pUt84fgL3kQE63A3o4gceFPrw68BgrSMypJBVbyGhjiGm9S0aJV4J?=
 =?us-ascii?Q?sUCkCtf4sn+G0xpjaV25Tb7A66nI7zjRxRiBzmB+zeua2Y/279mEQtaK7NWe?=
 =?us-ascii?Q?tMs8lWt1+5S6F7Re47paNvLfCXBgHybxnWA/ar627D6P7nQCnI699eX0TOBy?=
 =?us-ascii?Q?uAAo92EouQccIXItfH9aOEpWRdHknkFf2A4EnqjQ1gJWOuyiWXf1EH1Bn79N?=
 =?us-ascii?Q?tuPvGkCCstYERkqLhgnCGd+GAfHlFcLNCHRiMYw6Qop7+Hs1T9sQnKBceA1I?=
 =?us-ascii?Q?Ulw3PvwmXd1XyMb/l8QwJqbAy9aZIrSxOtKLUuzSKg3q/1DqZmGx3uEs9O1f?=
 =?us-ascii?Q?ZfaSd3gw0cd6gvdjo7b+a7xZaJMf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6DqzfyxuM7NhwSAkBblxp6FtI16YkuN/C2v9atR5YcWg7L+e/c31uAx9K8w?=
 =?us-ascii?Q?LCvxvZHfqB3hD7aTVeisJE4aoHz0rkJYYOeBsO1PQP9kz1ec77DIUjXxx8+a?=
 =?us-ascii?Q?70/kldKzcqjCvKNhHU0zYetlsGiPfyNHqpaNBZaBlE1j0M4WpNRGesY3cAo3?=
 =?us-ascii?Q?jaeE7UPFS0XmY2SDdhvBqZHW1H+kDaYAjtXotWIO8UcDo4OHNrOyE8/NabLF?=
 =?us-ascii?Q?k4as9DLiWxOdRDWTTNUCdvnddtFBiZ98iCqj/SG0wmymD98cHdfeoJf+QpSm?=
 =?us-ascii?Q?ew8VKDzJhvtAhopSu0IfMx1kKrdBFZ22Yeg8B1JXliZlyP91Xxr6aAs9GeCB?=
 =?us-ascii?Q?+AyiIDNgubglKkeWim1KULCsWNCQAAndAuldh2OE7tjgpJN2t6l+hFFbXEot?=
 =?us-ascii?Q?QM+DnLzuZi3diCUNVsOcCXCv5plzi2MGWIwJRP5eRPHt238PT1Wbp17rvN/d?=
 =?us-ascii?Q?6XWMGRKtAmsQk3ZTexK0miTMv4MxlprivUCkk/MTLSncVSlKD7D8BxU9wyIa?=
 =?us-ascii?Q?m1nX/XKBtZHyJVjroyRg42nJ4mR8VpZyNJucybjuupWLyKVz3ARV/ujCGhWV?=
 =?us-ascii?Q?O/cFV3YDyG5xWLPMCK5hNjHvIC3kTvmODtDtfD+bfF8Sf6eXzYPYYbcP8/Ln?=
 =?us-ascii?Q?kid/6U+y8/S4iSpxA0LHwzhEAiUW7yQuJhzj750A29fL+ZpGNoER4sjyDHmQ?=
 =?us-ascii?Q?OWY3WqSs9+pgXh3CqLKydSWcBXrgBBLH6KLx8cq+ydqv3jc3u94IAQLeDkwQ?=
 =?us-ascii?Q?H0Wr2v31ziTOIdQncbS6uTIteplxjN3IaQJufR3zBgyu9kVNDJes3Y9KXfwV?=
 =?us-ascii?Q?z/dYdg67Jsv1EgDewggkSDs5F5qNr6LPvstuR91mMEa9Vx03ch1RSp2bAr8H?=
 =?us-ascii?Q?NdGE4fe/Qi+150qhHwj2lHZIII/zV2IOWsw3FtH082nTfbyGL0vhEs0+I8P8?=
 =?us-ascii?Q?vMkwen1R1f7tiOI5B86nwUcx0scjypqCUQyVOzIFXxyu4nG0DAtZ3QYnzZqj?=
 =?us-ascii?Q?Eh+zH0sDsX6mgKOa7yeDuUHAYuQI77ctfHvmcSTr0Uhdb9g/nVzL01FxHZP7?=
 =?us-ascii?Q?yyqD3uGCT+zicHhT2DblBrpS82ISwOGoB4R/jd+N9ifHnOatWTXqPVVwKmdY?=
 =?us-ascii?Q?E+h4GkVwwBPue5m7Ycefd0Wv0NmQmg3mXWWngQz2kP1JzmdTkPmf6xuuEjcM?=
 =?us-ascii?Q?eH883hx6J0JsNY08qn8NjYMqoYDxIopv75M0CjDZr2Oevtw2ggh+Jw7J6VmL?=
 =?us-ascii?Q?UqMDLPYpuVpXvslOVBEolu4fF/8ZczP5pbWk4WcdScxOIDXCtn89sRdw30ed?=
 =?us-ascii?Q?mcZ7VX62UY6FpFusHRB5c6k5N9yBgHj/YoWy/OFnzDR/MJA1MSqKJve+TY91?=
 =?us-ascii?Q?ahbkGV5czeuZDh3gvh2Qc/BdaR74vM/toKUkrO+iv28A9PiIdoCpU0Uj2xzT?=
 =?us-ascii?Q?UlgdQ6T0phAZVGFND69QlZ4a6fWXFZnNjPgccz05XJVweG+Dl2M49JZl+IWq?=
 =?us-ascii?Q?Nt3qGPzNWsF5vyizhJTjOydc5R1r155E97hV2DF4eahCNjuobbdo6VfGwDaJ?=
 =?us-ascii?Q?kseGcaEHDPFEIlgKfIv03dnxGEaKU7yoFw5Y2LVk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3ef340-e62f-48f2-ce31-08dd4b797db5
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:25:33.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xk8u4GdKKDnoRPruUhAj69z5yMlERCg1U7iAQyboWF+twFT+UsCstM/l/fc2nBKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

On Tue, Feb 11, 2025 at 10:05:35PM -0800, Yi Liu wrote:
> This patch series aims to enhance the iommu_attach_handle-related APIs
> in the IOMMU core. The changes build upon Nic's previous series[1], 

So it needs some branching help to go into Joerg's tree ?

> This series also covers the prior series[2] which only takes care of the
> iommu_attach_device_pasid().

Is this a pre-condition for your iommufd PASID series?

Jason
