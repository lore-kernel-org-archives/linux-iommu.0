Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6E26056A
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001101; cv=fail; b=mFOFLEOu44BqiuLok0SBL/BZrfdUi8W8HgHo8PznxK+ojk2DjVv2dLzZRgsuBlZIbRpbKvm3mR7JueWaPtSfqBpeQIK46126aKOlzM3SDW7wuH+r6TXTH2qJ9hMw2RzBaHi7v/7rT+z5z7dTp2tK5+Bbv/y4xYLaAy3/xSgPVzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001101; c=relaxed/simple;
	bh=ItPrXnsHRMfYYixgpW1hZoKkFcc1v3c9ADS9aagwX7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EY4qH6m9RNcqR2f2rE0FJ6iNTLZT51ViBKKem4KjnTA+U8as7i9445Z2Izr2wfrKT3JP2z6At8mahgqSD9qrsbb6d/c6UMJCu92Puwy+ZZU0sAQ1b3C12RaT79KDxR9Sk/GGAi6b2Ri2XHYfEdFZK+OGDOpibaGN505QaeX43zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TAWuhEvw; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAWuhEvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twao6snQcjmAmXjF0Y6bpkRHDjlyQxfYOt2XNRnfUHLpoFTSt4eBP4VkXc/6cZeta2W3bTDg/9Y4G9Ylmo1yKuqh1/Th9BGp6+Ay4cvanMx7gpxMc5enS3zNWB+AN2mp2mzbiVrkMTdRwcYoOQVUnw2dkL2YZF0oZSLWeVZGFw8Df7k6rtK2Yy8puyBSk/0hsqRYy5O598H0vDRwisHZrYOp2tmxggtYgWD53A2DPjwM42ggkXcf4tPLf8m0TR/3t1IxRQ3bFKaI5vfQ0afcKVPjcbEBDzUsSZeC1zh75GLwNLzfiJgQARfGhdeGf6hpwGSvgZ36tqaDmpPwCvecmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeglYF5ZgEGNRGSriRW0JjBtQcJfW9chuDtII1o/DAI=;
 b=ta8nCXIZyA4tHibLNT1UajAabfLQ3B4kSC3z9Pxi/A0+pMRcolVUym/Z/DsR1x/Wceg0ej/+lZ0kOuc6XWwEy32mYJWifzc4DuoNkroBcyonG9E3cOI4FLiWrCo9Y//+68VWpSr9I0myERflv/qSEiTqV8klSaxD/VLkJe1/2OlF83GSNIcUaTCp0NJ+CLOCcqbaRquF+dq2owIkJpmHoelYe6Gsn6UYgYUBKoAtw5dfRKQP9/As5lAIrD+L78/T0ZH938E1NY+TJY1qfGwm16twh7fVX2qKzwE519CZSx6gw7qsBSGO8bYGciLtzUY7KlZIR4zTw5ipeMjIGfTwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeglYF5ZgEGNRGSriRW0JjBtQcJfW9chuDtII1o/DAI=;
 b=TAWuhEvwDVQMTgtHAGvG7NS4y3c86WhEBMKZX8zaX2NcRUiDsTf4FKWctp2MtGrAV4THRzUIFRqGnHckqyZPBGEJVUNccnq6BtDfpDY/FO3lyW2fGIa9W37d324I+vS30p4thJJXwfNm4tcPhw0bqslq2OjohetxCUv00SBO1Y5PvDakfHa4Q8VyU5kP8PLp1omPKxM+asJoYpVyP0W4ZjgcoR5tk/N6QG1mo/dPLRD6R8YraC0DV+j1xHfmmD5PxkwVRj1JO4qhdYVkNKiDs77XFdzNB5YSJW3l/XNbKQnQcWu/23Dn4Ta5Aa63UCEFeG7OGfIiBQUkWKdLWZY46w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 13:11:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 13:11:36 +0000
Date: Wed, 21 Jan 2026 09:11:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Francois Dugast <francois.dugast@intel.com>
Cc: iommu@lists.linux.dev, intel-xe@lists.freedesktop.org,
	Joerg Roedel <joerg.roedel@amd.com>,
	Calvin Owens <calvin@wbinvd.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <20260121131135.GF1134360@nvidia.com>
References: <20260121130233.257428-1-francois.dugast@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121130233.257428-1-francois.dugast@intel.com>
X-ClientProxiedBy: MN2PR14CA0029.namprd14.prod.outlook.com
 (2603:10b6:208:23e::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 947449f6-4d86-4de8-44bc-08de58ee9b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/qIE4poW7kNn94+aR2ConjQn6HbLaOZ2Y9E+08kahnXmIPOSZ8bIE3AqFPh?=
 =?us-ascii?Q?647K0cXp/BBWKR78TI4ckSmnfVhxhEWe5L5uxjPp4HtwOm43xstzbimViTL5?=
 =?us-ascii?Q?4LXTTOYAO9eh2u/w3Ragu6jG7N/QyiwyxaMs7F+WNFJBjkaUNeB8bAhnDWHu?=
 =?us-ascii?Q?N3VA1LUnNIJxeHOooDTuL01OhU1SQHopCEMrgv6u5pwl6+MIn/4ncKk/ENTK?=
 =?us-ascii?Q?qMY0/rp4Gmz5Zaq3C/9wy8UnY2AxwfkfyICngrAwsO8fL4t2zHSLM7DUizl6?=
 =?us-ascii?Q?LEHFOmQ75D5U6+u7E2+JiC/JAXgWcg98RNUS7ygOlvnrcRoi4H4FMRWQOz8E?=
 =?us-ascii?Q?L4vsP/Q3UwWS3HussLChoR6BR4N/sKKgbAEyVLZWwFGGjPKGd6x1mqwN65JZ?=
 =?us-ascii?Q?DUGQd01JyW2Ja0BxQcvZ2JTnIuYZ/Z5cC5v65527COUbIhNRJL4O8qdkcO/U?=
 =?us-ascii?Q?xZO4Ua3ctSW7jWhBnxpFhplm8nbtGiIcAKD1kTBm6D7sbQ3Sghz0ugONR3ov?=
 =?us-ascii?Q?WnO5bsrglsDkj0TJ9yD4dOuNTU5Negkf7g1ceGwLUxAXFAALW2f5T+fGbLpg?=
 =?us-ascii?Q?pSrW1IyP/Uq/PE491ybt77Y+bbn2ANwRhZfpLmENScgxVGTd0w3fIeDHYXEg?=
 =?us-ascii?Q?7FpewGMwppm6AAbDswu1u7ekmXz+rbaWaODA5NtdivniBkubclYEPMSsApnX?=
 =?us-ascii?Q?RMlCmaxncabCcK7ABYiRrLHGjckBVygDu6X0kYFkbK0AcXVgVigJJ9F7HxZf?=
 =?us-ascii?Q?87uo7mDyTmoknCa/TFau0N/dbv6xAsl4ag7+wobqwqN+CXI9s7peq0P23R0m?=
 =?us-ascii?Q?eAVXOCptM4xbwQ222cnHu3FjajPTGmJWLd/vEZ3HDWc/9n7fAqr/S4+71SfO?=
 =?us-ascii?Q?fuPM6Pbd0sEwqBiPZBPDAmIEjam2v1oNISbS98yqdhm3eDxlb4H31hCw+64M?=
 =?us-ascii?Q?ZWcI18R/h2CxfUi4UrBAsUk1YUhW03x38InSOjhajzND1R9tRmgQC/n2bYfB?=
 =?us-ascii?Q?4pa2WsjJwWjut0AZLZVoGEMUyk+OPmEzXjIWbEfKurEl8LD6uKkTt1WtxvJI?=
 =?us-ascii?Q?OWGDGnljBJhmK4mV9uzUhCu28LtjT2SV3EScK6HebF0efk1QpzQahYHGspX9?=
 =?us-ascii?Q?A8ZUZ9Nu9fbh040z518cuuSxk7+uC0YfVConnACu1lJ0bBpeXAhOY+SjQmZd?=
 =?us-ascii?Q?qxSr2B8ewhWO/GPG/zqVcWPODKW4Nhhv8eGNlCS1kINMz+ZDhLFXXyPotrwM?=
 =?us-ascii?Q?GqFBrKSLztH7xxdxDrsYdKD1yJcIJnIluV36R/WlLR6gbs6AHq2yI8hbpg1M?=
 =?us-ascii?Q?qMM+Hhkks1BnmRd59Nh382lDfaksH2JT2kAE81IR+VDjBpvcovK09oSHWk/g?=
 =?us-ascii?Q?ty8g4d8aMZ0sql/aOHgEV4CvuDNi6DUQ7k8TlUz4fl1eN9yVZPBuqG5xt3/C?=
 =?us-ascii?Q?q95AnPaU1PDrzop+sNc8Sv12fDKsJafQhSlc2ordoNnMBdX0GzlOyWK5aEy8?=
 =?us-ascii?Q?QRyAmHH6TwdVhXSRf6VAkMJHhy0UAXD9xO6GTxFsdaeaWHM9qXAvx9dX21u1?=
 =?us-ascii?Q?JN4/8+pKX6smrqP7KlI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1QBWgT1m/FZJiobkL28FRbmnRKVuoiD6ZQYCc1mwQKY8YdxxZEAYAEgMeJ/N?=
 =?us-ascii?Q?LsVTseSfcrE5Io3OkUDt98psH7IejBbKZvdSn1++CVWlNNwx6CvWkQhGMitr?=
 =?us-ascii?Q?LF5WfHwt1kXpdIglQuN1HD3H1LteXHV/OGS+nPCrKQey4RAYik9TNE6eeIM/?=
 =?us-ascii?Q?Pi907f36RXCqAkhM7O1i5jy9lGSuiEKaOFcmunPAoC3P8/WCT6HlQuhZMdI+?=
 =?us-ascii?Q?nLFZd8RQI2LCmOdSMBstDvhHNOn6dmaDB6cOEfVL6sjy4dXNlWFy6V4p72bc?=
 =?us-ascii?Q?dZReIhvhy4wlwafsFLJe+IW8/2KarfNylxDp9Cz9ri9fh0vLIZVrDWQp/2Xp?=
 =?us-ascii?Q?FLFVT+2ge0Jc9hM1Q9TUJ+DGKgYD65i2MjikPQZOKMn4n3nClnjbVwl7ESPZ?=
 =?us-ascii?Q?BTHNGCKFfLga+CJBdWeWSeC46/nPTeFrZsc8bHW5Qkgd+ldHuXZjmUyvwSuh?=
 =?us-ascii?Q?kpohwTsXHdLS6tWNP30TN2ukQN9qrhbUEcNJxoJ1hwc4V+tTOEdnM93MLreX?=
 =?us-ascii?Q?+jZQg2dlj33A/6fFjIIflccdMCUtrf9h9ZvUR9Y/JFxjJqOLvZsgCx07ZlYE?=
 =?us-ascii?Q?qJQ7LNV+CjjX+RaSSeSWaZnKOVyX84lb+h8t6Rb3Z+JWzg2FJACr8FyyJx2R?=
 =?us-ascii?Q?Wz9tDj5sSQ1Em3/VbKC/i6t5ksGuW+R+8L+PxXztjrFOxyHvIhPQxnya0KhO?=
 =?us-ascii?Q?bFOvLoEtfl5Uarsa6dkhQlWDl53B4JJ1cB6uQ375BZTkNmB1S3QVtvNVVLoN?=
 =?us-ascii?Q?DxWb1BTuRMjIropewrKkpcp36iCNgcvNy+UyscaHImY3PYlLobmwt1G3sx2D?=
 =?us-ascii?Q?cuYsoD1dE7SBb7BDCSamCziBD6E6Yx+7J8t0FdcW2xvenIUIC2bNwQjUebH1?=
 =?us-ascii?Q?FUz8HUU7nIUM3tODD1PamAitQSOcFuWkeaWjjPBJxMHvHJ4DewWTf9cgn3ex?=
 =?us-ascii?Q?QbadHGlEkrMGEu5qEiNiClVXXLuYE23K3TxLJHEpNFjYECcB8N+d/jYlo0K3?=
 =?us-ascii?Q?ZuqMjdkH9ufIjBtsj/R9ma7rrXYe2ty4AX+3WX5pq9BVt2jWD1h8UjUJWZyN?=
 =?us-ascii?Q?00csvXu6CITQwgPe9DNdQ3K54iHrPJGBjOf9pQtm7NW4GcIhfJoDYWIxjW3o?=
 =?us-ascii?Q?T5K3+hNokmhT1XOpTGd+hT2t0CFnZEcDsKXkAbQu3iw7MVJ4PgxHXjMCILbx?=
 =?us-ascii?Q?ob5XlPPDz/MUmtlD6UQ+GQT9u28YHgapucqXGvOOs8jjFBnXzgMHGwhVNte0?=
 =?us-ascii?Q?A/d/MkiRJVYhXeqiWPXm+VX0eTpshfECezOYqz64vV77QtykLsbfelQ57Txm?=
 =?us-ascii?Q?8pMDgBbz9zyLDbvPcfr+FNdeDCy/qPYMNz7Ca+1/WIzYUPBka4fV80eMGdkq?=
 =?us-ascii?Q?Q6QWMSom2SYhubkzRLEqRgRiWcchPTMzxvoMoYMm/VP424Q+EFsKwEZcu/YF?=
 =?us-ascii?Q?xZ70zIvNoUJhouAuHOjCKQqu6eGhaZAdKa5Fak+6nABUIYlcskwozIaXokHe?=
 =?us-ascii?Q?ZqEewn/inUbxtN7XpBgjnHIFoGLJVjpgGG9VBFn0yaiv7Wx051l+lJvt5rHC?=
 =?us-ascii?Q?83ylrQig95A8xXofUQaBaGPSM45OltHE+zoGTodp+glmLxxvPupW4PuJoDRQ?=
 =?us-ascii?Q?Q9YTCc4nAvCZhp8Bqlawi4sR2d1XCiEQdqoAYrgGOzvgvVsH5715PbJTUJ2J?=
 =?us-ascii?Q?O75CyYOfy0Ewu/xP1NcbZcnRudgIsaLBxGYiIiu0G/TqJtnX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947449f6-4d86-4de8-44bc-08de58ee9b55
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:11:36.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bca66EsokQqm6YZH/QaxRltKcznKDH1HffCkbORWRJavQuvQRHf7aLY+uE15k0Dl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695

On Wed, Jan 21, 2026 at 02:02:16PM +0100, Francois Dugast wrote:
> I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
> can be observed during DMA mappings/unmappings required to issue copies
> between system memory and the device, when handling GPU faults. Not sure
> how other use cases or vendors are affected but below is the impact on
> execution times for BMG:
> 
> Before changes:
>   4KB
>     drm_pagemap_migrate_map_pages: 0.4 us
>     drm_pagemap_migrate_unmap_pages: 0.4 us
>   64KB
>     drm_pagemap_migrate_map_pages: 2.5 us
>     drm_pagemap_migrate_unmap_pages: 3.5 us
>   2MB
>     drm_pagemap_migrate_map_pages: 88 us
>     drm_pagemap_migrate_unmap_pages: 108 us
> 
> After changes:
>   4KB
>     drm_pagemap_migrate_map_pages: 0.7 us
>     drm_pagemap_migrate_unmap_pages: 0.7 us
>   64KB
>     drm_pagemap_migrate_map_pages: 3.5 us
>     drm_pagemap_migrate_unmap_pages: 10.5 us
>   2MB
>     drm_pagemap_migrate_map_pages: 102 us
>     drm_pagemap_migrate_unmap_pages: 330 us

I posted some more optimizations for these cases, it should reduce the
numbers.

This is the opposite of the benchmark numbers I ran which showed
significant gains as the page count and sizes increased.

But something weird is going on to see a 3x increase in unmap, that
shouldn't be just algorithm overhead. That almost seems like
additional IOTLB invalidation overhead or something else going wrong.

Is this from a system with the VT-d cache flushing requirement? That
logic changed around too and could have this kind of big impact.

Jason
