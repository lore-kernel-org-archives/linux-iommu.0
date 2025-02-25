Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282923A9
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442355; cv=fail; b=USVjeIKUjl6h3WHgqdnz9ZxbHg75FoWQoHFPDoFSC41P6O2BceRF4mGxTx+z8cr2QCSbEXhJlconZaDU9EnWhcpYJN73Yr45ag5KXbq8U1RhNDWn1C3C2BlGcSqX8JeMcyrcuQIUYHhpmzLUnmLKkll+foo805+dKi/iCXxpduM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442355; c=relaxed/simple;
	bh=j4miIY+9aJl/UOIYIZB/AtploEiTciCZT4mLzHxnoFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lRfQUmuW+hrqdoMAd+LTZi/5Kc/g9xM5IFh0rJi+iJ4fMQfHvrVxUIABKsVlY8xUbWA5t+XUW6amV/FXwOa16/TWVNbndMw4uhnoUKoaohUWykrSpnuPLN0mvud32e6FHQ+KSpSPd3PGl6AvLssSBUdy+b4/1xc8wvLNu6k+isI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5sEJzjB; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5sEJzjB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIRJLuS2JZoV2ItHzDQDcSmxfBWnc2fGhW1b3s3XNpmqF9Nir4Unx6lWKpMS2J+A7hpbio3UWjwrBnZJq7GdqOZmDNagFrAUqkq2Td5Wk459G99imZMHYHEFA26g/jcOd5G4Yrgu/5oByUBp9UuWt7tL6L4zzkTYno/iWH8QHDqJpiVnI4pMUuEIUNPbV8HCWQbgx68nkgvONnrJOKhBlcNZ1aYgg3xOlL643ltVGq2YPb1gpuVpEjDfnYVfebaTI2Lbnd//J2tGs1U8YTMnsB9+5sxadGdAO0hcR5eVaX36O7lEBKmE88O8Ht5udv5ixLGQsCc/WgFDsPvlQpEjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdfpz7MgenodtStYd6Uml/IrTuyHNgpiA8Dnr/dvKv8=;
 b=jW2MoL9T8biCl7H8MdMKqf2kEdmJ0VmxiykRUvoSqaEA6hvJFofFflYpyUMc1FUkcWJ7gchvQiS3IVSJYu2YUroyotsiNEspZn63h5HW3YODtCK7NH6MnjM6AY2tyDUOZIqE+dT4zY1VSFe8QlHXwwvBTVuO1bapbyaNveXpiWZEh6zaHE+ucXR63tCzqhUUIt6mhWBYBpNzcMj3nEV5vQUPv5Xqq+tVaURJVF/naj5Dn1P0MN48ZLLmQlbfczYQTc+dBf50aqaDARMdtkS7MXSNmimXc8AZARHjIYeKX7aQ850wPaijL02jQd7LNwWlJgIAvJ57ELO45VEpt/JVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdfpz7MgenodtStYd6Uml/IrTuyHNgpiA8Dnr/dvKv8=;
 b=J5sEJzjBHT5B07C8g3SwIJJ4CzxgkQNpY0xBTf+Pb2wKy7W4L0urupzNHfjYy/hE5KeJtFG5rg3Q+VE0X0b4VPK4AAIKgyq5r/Ig63m3cfOtV6LyVFwI0c+pDatBwSH1D+a5rsMgdzlcYjL+gSeHU/Qv3IaQ3W6sYUkwbFD/Yt2CCaHQUhqy+QijI9Vx13I7FQpSVy2KIaE9Iln4VDqmvkO7qh8MO6YTvPJ6JuRE1almQBlw4flDzkiWRMz5x+0m90neVaO7z92/GAmz26ca7Br8liQZ1qv3pNc4s8BG9M6b45Wx9Ox0iDQ7efulbiXldM36YHqlVOLcrqx3Co+QbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 00:12:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:12:26 +0000
Date: Mon, 24 Feb 2025 20:12:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
Message-ID: <20250225001224.GH520155@nvidia.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221143335.49874-5-yi.l.liu@intel.com>
X-ClientProxiedBy: YQBPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::44) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ea07bc-3bdf-4866-7eb2-08dd55311593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dv3T2SYrU5YRsd+KA0dhpEong2+mfqd4DCxfUiJgnMCjfb/8Q2wGSG1ZVAPD?=
 =?us-ascii?Q?5VREZZOh4Qu5lP6YXeFBj7PE3At+qHaPV6xRBPPXFKrg1Sgcs+/gfMRYyDSb?=
 =?us-ascii?Q?tqDfCKlHqDQhCma/Ke55NLuziA1MmiWRM9BnNkl0Vy0JmAbOmEt8R2aE428K?=
 =?us-ascii?Q?V6xDgxFlsGLVTtQuQefrGqwujSbzpYo3FcxnKUeHdx1kGsbzn24ksIXhGspJ?=
 =?us-ascii?Q?lsrtoTVfKqnyU82jr/8zYE6j35kZWzu+k8EtT2gc7oQhjPhNCQ9P+OSaaUF1?=
 =?us-ascii?Q?gRQZHdPmklhbiULMIaPfbf/DiTt5Z+VcYZqrKnpDo3CnbHtpbh8F0k26O46J?=
 =?us-ascii?Q?IwAPkdkNah3Watodh+g16gY9KqEHSUXCoSDVsviGdIpybzh2HlGzf7K6UHKy?=
 =?us-ascii?Q?0tOvuBCWeSKACqGnjDh2LM/b2r2MWw6kuLVIV1xkFhahCaV1ycsuHl2cjHV/?=
 =?us-ascii?Q?utcFggcnAQzmAx4PYZiSd5p/UuCekyRcpSbe6P1rNhD0wj07s74pCzrdWtz3?=
 =?us-ascii?Q?6O3LF/5zdX5zASuaeVKnNq1lKFkxKi4FtUcRZuE2l+rv8VxUFz+aR6/PBI4d?=
 =?us-ascii?Q?jU80ZwxZwkpEHs6kU6AAV4ojjYnmfYua8xxDAxOP9R2fIvAarYMaJsQa0MMU?=
 =?us-ascii?Q?EKXPri3BJf3A6cw4C6UMc8pIInQQUh3Wp5EFxwOATlAll9H8jBDsdoNCwe32?=
 =?us-ascii?Q?cJkGBIMguKEUvUJ6TPuu8ll0Q/HKgJyI3maspm9TddC1qb/2d5u/AJtG2vSE?=
 =?us-ascii?Q?UVMfJEyqNQ2GGQF9hGTP8xV+YP6Q222Ozd54vm/CdnxGB8VGYfxewI1gsZdk?=
 =?us-ascii?Q?PRNhDVb1zWLg6qlVMWmV1immIT90DaYubke2QmL1ZH41tCMZDj+uous3QJ1V?=
 =?us-ascii?Q?J6h25DQFi2o4G7L/nRJgUzA2TY3VTrqM0o3GlbSNTXoChZWbjuE4vyX6rh8X?=
 =?us-ascii?Q?89GLDW3ixPqFA1NpyuP5ffGgc8tn8xqaEYJsH6P0QvfJ0dbFRRCJq1lS71sR?=
 =?us-ascii?Q?WbbNbqQEpMFzQ1gd8fUA7yhOIvq22dNOPIavDnILeLHv50SCXHfsCqNVJ3r0?=
 =?us-ascii?Q?ebndqFJAwrWqRC9JCIst6GYOsNM4Y15Go7TVI0y4p1NHtkkstoGr96WEWiqa?=
 =?us-ascii?Q?bPZFDEbJv2bkp4XEd6NfZDc7Z6ugr0GxbY613JQAGHi4O8Uhj2yzIwrIm+j7?=
 =?us-ascii?Q?X2iG3Vk8O3t9uYV8ntfrweFxrosNNyWf2xvbZoVlpZo7OeQXzBGjddtoflhK?=
 =?us-ascii?Q?BJGEG9x9/rlABXJiaHrofw/FsPVUz7gulcHfWOIOZYvcMrHMeVyDKBka/hNv?=
 =?us-ascii?Q?ld87dEpiuVq1L9rc+QBI+6/fpJP5xdSWqsgG0T7vqp0BnCuP1BwkiqLmR7es?=
 =?us-ascii?Q?upGovopGomZXfzjtD/KcfxXRYY6e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qafdr8Kfi+J6ltb+sPTTgSOBQ4pun1JhWa+hqbMlhsy5CY8vhTJEpK3SNRi6?=
 =?us-ascii?Q?VymMzOg9N3qYLqlgGMMNwXSWf+xrBzJWeeBi3/0lvkeQMeeKHvSuTv4u2yZI?=
 =?us-ascii?Q?HVb6ecFhibuVUHZ2LlFVD0R8xThEQtuWZnZ/9BhkXFEG3EV+OgRehoIAa6v9?=
 =?us-ascii?Q?epz3oGN+lSm3assl5K9SY8F6U0GNxOgeX0hbKAhY931FGlpZ7I+wMeX0jy61?=
 =?us-ascii?Q?dtxxwT68t2rX0ONWwbuqcIhTnjKa4Ea/mNVInl6lwY/l9hTbBUE51yH12CNf?=
 =?us-ascii?Q?A5P8/OZfjKENewZJs3nkK7ETd+AZLa75vgdkl0cIYA4ONnFkZLhalrqnwkK6?=
 =?us-ascii?Q?j2sx+V/7lSQGo1f9diyBJsdbZ0fXo2Lq+NAkmDQOew5i0NiqxT0t+TWQAI74?=
 =?us-ascii?Q?pI5p9QynMHuZ5CcGgs5H5wxQsU8iPVd01pNWT0ZMj+KJ7tFkM0+FXQRXdLVW?=
 =?us-ascii?Q?VKdqo363SGn64DtDi+A1STj7m3Jj0sTchaDWdvqK6KSjvJUg7glVwbT/FnLd?=
 =?us-ascii?Q?NHVZo98zfv53NAqIVZe93kvTuR8miu0TGapd7tK9O8xDjpJCLZWFDcBt4k8W?=
 =?us-ascii?Q?BoZBMLhW7bdNPez2TcpNlYf5TMqMbQp1gg/3pXkxGmxd2LhimszWhBNHs0Mk?=
 =?us-ascii?Q?cP1Rj2naRUXoxm6+nLlrjXGukTtW0BIxZ52fv+iL42lubfolFIlFDwWgwQIF?=
 =?us-ascii?Q?JmdIdqnEbm4s9l13T34fTIMbRQ98VH63AMSDdt7l0gxdIY580H5/TQwfbAkE?=
 =?us-ascii?Q?DGrRnaTgPfEzT5Chrpo1C32WkgqnW8n9nIEEmBwYoj1jCEBagtacIpMN1zvx?=
 =?us-ascii?Q?AaVMIi7RLg3YJJyITTi3Vim0cIyQrRP3/owIljJ6N+15dnhjczAqYSG54DAl?=
 =?us-ascii?Q?SxvqRsmoMzVtSCdvr2d9X7Fj3SNj9GRqQ9mbAokIyNOjTdXJVgOgB2CjLzy8?=
 =?us-ascii?Q?zTH9l5F5U76SKIi+tveBYCgXGFiAZxc6OsuSYfHZ6So46hOWvDJIm8XbYEcA?=
 =?us-ascii?Q?3F4sWU+rjpWl0FOpb0iITXKPboq3Ss1GawhpwLWHUvgw6DrH4oBk4IUJTIoO?=
 =?us-ascii?Q?+coPZO7xNYPwarHgaKY1QpyMv/QChm+cluevAy1gbvL6RMHfcr1ZEQEKAo4R?=
 =?us-ascii?Q?aDdMZ3OoUvMg9oEXF96Ti0mXeyZ0baqBB2qmkbfV6dA078fBa+ECpfD5QW2L?=
 =?us-ascii?Q?s3CPBZcM8LFufYLwpa1dUL03Zwxf3JznEa50XonpjoPxM4q4YB9SCcRq6CkG?=
 =?us-ascii?Q?hs1OsheyDavKsImtpcDCuGbpV168z2AMvi5S4UhzL41t5SWjkysII7CD1mbO?=
 =?us-ascii?Q?pvianQBmqY4YLp1ekK1CgF5k8ykUwR+yItJQtW9WVYs7EmFI4UN8LdiNcqcy?=
 =?us-ascii?Q?4ggEfatdJSMZuKCdgflub9f17Qd2b6KXakGjEJdGoA+bihVf/jA9LyHYOFGk?=
 =?us-ascii?Q?nHQRlipYR9fFZqJDJ0QPynHVY0fUbDeKKizmArPOutAqf/JjhWgsVUflDIEO?=
 =?us-ascii?Q?K1dZQLGnDapQqrjLGlsZWhXPEAdjJNEEhJ+Vp4sX5CZp1uo2B1QtkAi61hyr?=
 =?us-ascii?Q?5gFbpS6Se2TjavbYOam4xt7mVC2iAYAQxXoEe93c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ea07bc-3bdf-4866-7eb2-08dd55311593
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:12:26.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLCeEI57SiZJxe1GEwcXia6KazyGjynn0S8wVlCBuMmKx+W8N9UZ9GV2EXnyf1Mm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
> The current implementation stores entry to the group->pasid_array before
> the underlying iommu driver has successfully set the new domain. This can
> lead to issues where PRIs are received on the new domain before the attach
> operation is completed.
> 
> This patch swaps the order of operations to ensure that the domain is set
> in the underlying iommu driver before updating the group->pasid_array.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
