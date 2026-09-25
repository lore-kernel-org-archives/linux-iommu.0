Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D31501F4E
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376518; cv=fail; b=LwNcAUF1TnTkr8EAW38KEmNN6yPXZfvQnu5B5ajn4W14TS0sa6irjdVi1lKFadjxK9JRotXaYbJ0zV7/Qg2edlLRJkzqKmWiKWZo+mm7Ot+4RIXMQyntA8EHR62sJ4Ft7zLloMWOvvrOFMCNVJX+0oA42hodWIph565y0LBZA6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376518; c=relaxed/simple;
	bh=yfD9XMfDr1/snR8qj2GACLSnYcfdIxhNxvOD8Ff2P6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcVmltt9yd3hQRNuVVLkUlRomfV62k3fQ/EV5Oq5uM0kwDdtC0r/z8liT4W36P8hRbVT7vfDdVok6Mto3fyUHbELEOjEoYoPXW5YeA7HQgZHNMMWUoZaTSQfhD58sSvSO1/+LWwoB1c9APRRenzxSTp08490qhVz5PRhQ+6xhT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5huvLzm; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5huvLzm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V36iN/97eVLzChOE0M3l+zOSLZsDROYEWKwawOb3jUlmRr2xQYt+UKCjP6vMJ29OiIBwuFDqLPRWjAoaWhccAMsciIfPs+D5rwcQiyl2l3YbQEP9+t+2NBwca2/Dq2VhMl+UONHJGGdQZcL/RCUyjSr0GRCkzLVcy7HQRf4MiUuIKC8qQB6Sa9DFP0NuiKnamjHTRDmyDhkRB/9xNQ2JDo5mZH5d5uc7VQgOr+O56LztAXPR41VcEThC1ING7fwlKMdCavkAYZbUew0C/OaWCpykWC+3rsI/uY8WhoEu9aVj8qy49y7cdq6KVfFKeoirXT157ax676ZVdsUCJ6THOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDiJhqeP/3eK61Zue18ejXmcZlLg6KE7iWJtrDX6Be8=;
 b=hxdP5xwaI1LrPutyyFMH5ceh0USvDjPVTCuSwHsWT3dZTJWusmqBEnDtxgvLSnc3XB+4Wn9WqnliuFLkpxPQ7EGI099iIxwkyLjs3/5Zkm9x5iWHRRPKJfvTl+kD9pgDai6LE+RRgUJhM6l64ocdB9I3CV9Qierjpbh2Ol8MpNFbdS4uXkb6Zn7sHCpSG2XqKm+7fDhRdACmtAAAexoNJ6f9JP41FBzrkdQsnZiBR5uDMCjnONxmVVytqq2R1Gc57G9bCYDuyhu22jBqUAO6CDKIUT2vbTWK2ipcfjAeK+MC5q1lT5sRXr26L3lxs5Sjh+0aWdu6gCrdhdezvUdn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDiJhqeP/3eK61Zue18ejXmcZlLg6KE7iWJtrDX6Be8=;
 b=r5huvLzm/S2umvj7nQz4/9RKWuyta/VlALYstIRNxf8nO/r1Wl1dr37va1h1FlgIWoC8jQ1FPu41KZQPZlbly03Wt1BZOSIdYcuMr5KUObiIaMk1G6yXm6TjvAm5Pz8ZF994EvA3mABGw9jjjT4zw/xr7pRQ9dwTaZ6mLFiAQgeeR1dobI84ozWBllG413gXfOAt1Unz6j1X1lyBYW6uRUqZzQ4x2xa8hQNfzyYPBEl0eNM9gKQz286YAxn6nuXOynpq0YjlsmLMafoIyk7FaMq8XXbmPJ4UUDiN/lUjkXyWO/Kk7Us2bYlrfa/KjTgSfF3RbMf9cjRiPYzSNzuybQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB8546.namprd12.prod.outlook.com
 (2603:10b6:610:15f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 22:48:31 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 22:48:31 +0000
Date: Fri, 25 Sep 2026 19:48:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yuanhe Shu <xiangzao@linux.alibaba.com>,
	Kyle McMartin <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>,
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] iommu/arm-smmu-v3: Make the queue depths tunable,
 and shrink them in a kdump kernel
Message-ID: <20260925224829.GO9354@nvidia.com>
References: <20260925141532.1274962-1-kirill@shutemov.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925141532.1274962-1-kirill@shutemov.name>
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: ab966ada-d3b5-4505-2612-08df1b571f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	KWNmDDlXxKexecToWvC5BZUb3Xr3PO7v1qKODunslHJatYqLzHdplui3OvSOmJUQjKlT6lqaoksdGH/eLXjFNlnsKg04VJHx8VtQt45fGQedQzvv99r5muEZ60Ek3RiJez2/WVzKH5emXykfFw66CXgoR8pn7qL4tRz1oKDMGi3sFzCLDtQz/wCOb2x0MdxR8aA/ti61UGSTganYC1Y1Rsj1CnixDwDLWxdmm/5IcdWEpSLdFMZkGQwIvagDV9LlTUEA/tHor/Yqc5jPvBxel35/U94A869J6Z3rdOsXJXKHyzaysYeDfj3k7sJCmvkqpSq4dwJmcqTYg0rAcc+w4rS/NMKevusYoCE10U3IUmeTHVF6dVHLU2Rd6ImrXFZ2n3ZZbJRzW52a766I9L3SrutGwBUhDWwbsg9XZKp0Pz+hpv7lhbUvcPeodkeXxzPyEyc9nEZ7YaLZJ9Qad5HhCz1tBH7JsMkVNI++wlEJHFyqYaPY1EMD4dKKoi3UCl/YMsjajUscg6YXVOKrKg20cXuXDS5VENG5bKoEf/oQLGrqcHxGQCzV/CJQcnugGs9lr3o9jQxgWT74hEaWt+VpbRSdVOZv899XB87iqeYRVOvNgSAffPeVNRUnGVhxXRGvOmbNsbWwvqwQYo99dv4mykOhc3T15JZ5JvNrl65aesY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oaJ6XXKnH5MxHQpLbQhF0uQ4n94+NAwMc/6N+qBjVoBIVzQ5+iK5Mlop0N5R?=
 =?us-ascii?Q?luHrYLqjwT9Pn6ezwwZoe/8EtztbvzjAnA6QUnbl8qQtQ80chLAlmq03z+6p?=
 =?us-ascii?Q?K14miclQkr9tZYdpJd7bz41JFGwaIMR1Qha4WlG2fyOgaW6lbH/vOpr4m4hC?=
 =?us-ascii?Q?ExcgRa7HMOA3qPwEywPujH8l2fc3ABiNNCCDzlxwvg3YmUhHW3KvwmxQOD7y?=
 =?us-ascii?Q?w/PB4n5UVWJv34V+mR5neCcYf0JO6ofNb4ep5pH/HKfnNK9VLwDlU2N2YODk?=
 =?us-ascii?Q?wzWD8pZBZNNqNQQTPwbvIJHmXCOVmJViLVZlf9B+ketlHzhRGFPo6zjUsi7C?=
 =?us-ascii?Q?TzV2IIg/AU20MbXZBshvonR3Y53iMyOvG9CgPfaaivNRN6kjzSnRT0WJGWFi?=
 =?us-ascii?Q?zhj9APXFGgY+fY5RcEMeiddlCIpbW1lPtdID65Z0FVNvk2z1dTuSDYTamzpU?=
 =?us-ascii?Q?gka7HFaW1WtupMi9ALo9Dpws+mXEXD3fV5gVfHxW+/usCj027ABpu9+uaC7L?=
 =?us-ascii?Q?LZ0qog2aCautdbbxz+jKfEC49GiqYqy72PkkLJtOFjFNA/thX4l1yv+6UX/h?=
 =?us-ascii?Q?Vkv/oJifEAEkHBtjONJoO+apZgbjJKb1jQRMwk6yONYt0HEZjhnmPpoxOH+I?=
 =?us-ascii?Q?vOihEnrUxk9yaNLW7aiwu7v+CvWcJF/iqsy7x3qChF+dnpHSPf/pErTx3T+s?=
 =?us-ascii?Q?uVYvdYSxTQPe5tCyg11Cq3mJhSS49Sqq6TjppPC1xoKtm4CUwtxczl3oEAK7?=
 =?us-ascii?Q?ZXacEvK554gInExwJvjVrViz2qgf9F2Mj4c9sfvgezrZ5CmQxBaR7R4usCA3?=
 =?us-ascii?Q?w4Tx9pLd7IKcVzEtVD/q6Fb9XunFv5Gk1BqIh2OuxgKDcGPMcVxGSqaHn1Tu?=
 =?us-ascii?Q?13cnkP1oW70buNLImos3S+dVfDSZr46iLcx6hoZLvPMCDq0KnqdlY62BLMYf?=
 =?us-ascii?Q?h7wH9COZdJSeys17ZfobS1xnHy3pqd/5qImhd+AxaE8JXR6zamkjtxhxCRFh?=
 =?us-ascii?Q?nY9AJWodn8REFJJx/37c2H0sLgvbfdDz/j3lzNUQWaqBH6c03nSyLlJg7bWo?=
 =?us-ascii?Q?xWYcGgDP3bEEDmarDlFBYqmVKNskQ7aiFEvpiON7yJw/OQDrafEakdaENZni?=
 =?us-ascii?Q?VD4fKuJqKV1Yz9KkiPC/wyGpV5U2Jwhn0xoA3KXy8yjjqfBxzPicr8Xrk8OA?=
 =?us-ascii?Q?iTsgMlHQlaucEzQwLuLPe+JEyJMytaQKiDz2jA791Udv8RsYVg+LQQwUEeMT?=
 =?us-ascii?Q?BVET2PqvYhA3gcdo/mM2OOH/sODUpWRcZpRt/nIW5q5RUVueL60nV38tpzNX?=
 =?us-ascii?Q?RcOP4Sb4CsuGQuN5a1psZuVCEazm4QLFc57oGO/7/GAV6y5G7kOHbjHhG2kC?=
 =?us-ascii?Q?bbGD2zzCWaUcf0wir9La2tIUivcx1jSL4EAXloEUjttqE0FPRlgBUe59w2vR?=
 =?us-ascii?Q?NeQjCY4vixfJg4FoWkUBLIFXM7bX4eZ2wHEKhDgTv18WVkT87/jIPnSEs6BV?=
 =?us-ascii?Q?WTzPaQ6oXl7mLVLqJ4GWpMrh+KlA0CztPfvyTQ3JtJlE0qwk3cc7XUOvrFiS?=
 =?us-ascii?Q?NlUk7sL8P1SN0acM93jpqhLejcxsNFRo6ZbdjESl/sNCki0jDnSrQUZjHC5g?=
 =?us-ascii?Q?gCKmMvDvb0jixuXPErMD2tQsyhHBhl+jUc5NP//h26AU/g/FAVbmTbL6PHdr?=
 =?us-ascii?Q?IIpqml4dJOlXUDsBARm+VGKiVUqJo5sfSewKOS3sHHEDOmbj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab966ada-d3b5-4505-2612-08df1b571f2c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 22:48:31.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J6wQOPVfE8MXaTZRpZmg1MKMjNZxIW4PcnD6dA7YvPZOOD4SiHmOYOgVwIqdJdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

On Fri, Sep 25, 2026 at 03:15:28PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> The queues are sized from the IDR1 maxima and allocated at probe, costing
> megabytes per queue per SMMU instance. A kdump capture kernel pays that out
> of a small crashkernel reservation, for queues it barely uses and two of
> which it switches off anyway.
> 
> Patch 1 adds a cmdq_max_n_shift module parameter, decided in a per-queue
> helper and floored at one page. Patch 2 has a kdump kernel size all three
> queues at one page through the same helper. The parameter does not apply
> there.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
