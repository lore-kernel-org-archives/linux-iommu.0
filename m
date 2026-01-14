Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D887395DA9
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396642; cv=fail; b=V+hwp+0omvtO30p6a1wMMetIC5baO4lkEQsZyu+VEpsCvJbEHkSEW9bu3GBlK0N+86Bn9HdM9sA/sHhpqD0jDqyNss7A3Ih60exv7BXrmNlW9xz7CTW3XIhnTGxNPunzwNrKw/0XUUwFAKpdf1e9mpQfRpsUwcWNFeMWXjzadew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396642; c=relaxed/simple;
	bh=n6nuqwk0g7FlFTbImxcxnbAKYsLorG79mmq8D2a7BVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CNX9mgo3Rdx18/vXjYwbV5yZa8SdVMY5iUX3/sKiO/sqwQ1cOl3OiB+7RcJEDDMj0SqIbbU8LDzagFOievRQSaIGyDdR44W6z0pvSTCnrDXabprVfGVNeT8lPGN6wzAOclgINoxAFuC25jZ0yI1utoSRKsC6hFf8MVzSs0I3XJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHI6WJ5s; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHI6WJ5s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK00yUgfNf3bxZMHe3PaZMmu7qSKi0HEoEYySRZCrIyPvF9sApJ9eNUAxB93nnObD1VeVum2U5mfU1preiaEfAgbgXcCbPQbfHqsB9n+hyE5P9QlboOG5qPOqJKgMgYkrRp9FzfTd9y+UDBMQiHml4IdIBBtYC/yQJgOoofg03kC/KRb2W9bsMHjy1StWikZBhi5ANbsKTjuo7KfAwipPJ2PBg5yU0I/JrYyvEZQbv4aLejAfV85QgUgEOqhk3f0JyagrpY2rKEin6PFVqtnDLk4K4JtwOASU4+8yNWwmxn1cWM7GRRjUfSo6XQZ/fEIatSiGaCgGMTcFgkeembM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djcRKzKEURuUaOiFuYfL484iHBJfiExehhQoN4TP1+4=;
 b=ih8DtDBolcCLlfri2onJFxw27fl17vIB+mwzICIngO7QfayVX073LjncZkLE7LL3RGJIwWy9mg22ro5zHydw5gt2Pmu+gDRBGoZsRAvwKX82Y7dzro1I4pezirBbsTXFbo8yoXWj9g5cZK41KjYpXMyFXEIc0kqKdqVXdSMBna0jOCfF80P/ODkhsIvykSb/BUvo+ronsG8m/bD8ILZI9lAy+3p/5wYdQF36wgCP3hq9n3TzDItGGirKk/W3Vrgbj0dDrJ78ZvOf5LlxTDmMH4RSoYui5PYUj6kwkKld0NQgs2M9H54pPFUu5JZDoW+xw+bdLYxlMw9Nou6nt+UfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djcRKzKEURuUaOiFuYfL484iHBJfiExehhQoN4TP1+4=;
 b=AHI6WJ5sGUaOKVMz7MBKMoPrbq4nHovu8df3mT0iQSMUjaNLkbgQ2hdmenmtiOsR9si1W9nyhP0hEtZIiaZJde5SY+REaRah+xZHz570iEpyDgHPihkBiM+aFrY4hU0swqm5CQD5AfMPZXJtz8/3p1qpw3Acwbhx64DMx8m/A8EYuy/lm6JrMIJXatS7DuoOOVHlUw52xbaWniT+MRXPkuFwmPVT5wpxJNEpfoA0BX0OZ8Jb4kcmgq+9xI7PggwyDdaEzSionqq6nSFRBI7Q/R8zw3OUThLLOaNiX39vQw9P5dKzenUR5ULn5XXGiNbmUqPjVHL3YeJrMUbSgbuCdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Wed, 14 Jan 2026 13:17:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 13:17:16 +0000
Date: Wed, 14 Jan 2026 09:17:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <20260114131715.GA961588@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
 <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:36e::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 086075ee-3f6e-4c87-5416-08de536f3cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eP+Box2YSZlCOygHJcSL3shnTBz6oK/wXpVJnNAwxdjSrNKh8L6yx5t1O2zV?=
 =?us-ascii?Q?rUIewHULq5WNWQ7bi1ZRFIwLkLRzXTqjmU4siKGfP2DXWHg/I6+LWRsA3BfU?=
 =?us-ascii?Q?27ZWeS9AfhENVpa7q4MRJggWiUYEFjVykg5k8IT1gfwMTVAgXlJcAm9HD+jC?=
 =?us-ascii?Q?kFXRLOgLxmFVTf+hhw5wVTRY8mgKf6iVGLj/c7wHhtGsl5zoWzjlak4xsg4I?=
 =?us-ascii?Q?1oxBfNQqlHb/ZxewEfSG9spv4W6q1ikH7DSVtzjoSdqmJaDpbCYo15n0LM5/?=
 =?us-ascii?Q?NHKFvGJkxW7exP5+P+dqRy562hpd6tjfaRB2f7oPDiiK+84Y8FyF+wkGtXxh?=
 =?us-ascii?Q?XEwaAVT7f4NUQ9yICO8i0mtASxbpW33svny043RUMr4+lBpCrqswhYf8NcS1?=
 =?us-ascii?Q?0adHOuD4RosWOk02uWTsctpDB4Ga5dScWgmpxIfMuGQYWkk+JwTbAcxOD2YS?=
 =?us-ascii?Q?4yjXJIE7yvtddYlZFieZQXFJ4i2En1v+3mXjuR2GQOE4fn24RaFHzDSe3pRH?=
 =?us-ascii?Q?PF7r7Z5FSrMLjHam+5LvmK1txAYvkmiT/eFMbxGNc5uD7UVxY5GUgRA0nWGj?=
 =?us-ascii?Q?dXyKTjJzevIRSeK2i038I4WLevbueKDpziTuzF1dcAmy8Spk32l0SoR3To4b?=
 =?us-ascii?Q?6Gb7FkfKIc1ejOcyzi7JPn+Ly3GcNhY57T91e3b1vcafxLXOZpZonhoRgHB8?=
 =?us-ascii?Q?Vd9ZWFzaocwsc4HQJbEPoJYL4F1RiI+8rljlrKFFikKUZhEt20IJ9xa5WOlm?=
 =?us-ascii?Q?CquJiE1i7PNIjN2Py+tjEyvv+ENlfuOalLmvqrBJDdybSuxccZY7BW2BosaQ?=
 =?us-ascii?Q?QU2MI+izkx5XpaNZBz8ZxKDZXoUgY5Zm8LKN9rikURl7+kZe5pDgVr/UskcJ?=
 =?us-ascii?Q?t0Dj22NPdrMUuUzsaI6IpUPxsfIzQoRgSxM728gEjv78gZPo5AzP5T2hvQnV?=
 =?us-ascii?Q?z0jHSg9wjE+7ncGT9I2DeQWvjl6zekn76g8LnQ1mBiQwIgg2spL9+nQfwsBe?=
 =?us-ascii?Q?lDG6wCEVWN9rmN/ZEtwwcyUUG1/p/VCWpc8AkBUWMIAuvQ/zjf1SnZBvCnzW?=
 =?us-ascii?Q?QIxxae5rqnQ5wvwiOcB4BJkypizq4psMDojPrN3lA3VLlENkOopYOusbrr2x?=
 =?us-ascii?Q?8Lz1ggkc/JWSS7wXezy5eTto6jjawroPgo8o2MfdInZgc/+Tu6ulH9fvyPbz?=
 =?us-ascii?Q?q2QNbhI2dbJFuyXP5Ple9sEgL8xMm2GvXPEveHtmMXurLQGyHQtsISz+Wj7e?=
 =?us-ascii?Q?DWaeVQthIGB8ex1HZNZZA889YSfZTyl60/tdqXJDvd9meZrzByAaTSKX62vg?=
 =?us-ascii?Q?ev06d+Ot7ur7Lf6DWEGFPjj+SBHlkqRkFMNRNZychpFpCWNMLmvwz1g5B535?=
 =?us-ascii?Q?JZ74oGap7QxmwTwSClbKS5XHz7vkNucYufEjB+dWgfR13b+u65rlPhqk3Tvh?=
 =?us-ascii?Q?Eq0YUgDjOTOVl/WyvKFnfptGv/y4Rf9tXc0Osnbvaqn4BF6B+YDuGGDmc4aU?=
 =?us-ascii?Q?JXyZpcG3rtU1pSj/RAbBFYecvKJ51ukvfWKPPnmWPvawGDar91Rtjj2YMuZY?=
 =?us-ascii?Q?o3G7t5DqPtbsz/pBI7U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9k9NxAmJevcnIqP/Zg7SfTb5vIhLaFTR5c2KOprgYvwRxsOJw62/PlpOTNcu?=
 =?us-ascii?Q?lCtDCUc4Sj9DOdY6cWX5DTr6m6/NQlxR9nlGxUeMBvLLwlhQDT8d86by0Fvt?=
 =?us-ascii?Q?Z8mbS5gRQzEbsOld8tJ9XaRl1WaaHKwP1UJEfP4opNzWrt5UjNLzSAsdkRHf?=
 =?us-ascii?Q?55WPRmB2UNLwNQkAETwsUxqM+kzQjwCUcnxfkpF/510OPMm3QJ6nRHSPO2CP?=
 =?us-ascii?Q?ZkpAlOWoeAo4V46pt5OUZ4NyaA2IcQWWwPFyKF/N3l8L9uv4rkCdUV9ZANXd?=
 =?us-ascii?Q?Salp/jQ67BRqiB+TuFconkBvftW7syyCd0DSAaDg9QHSk8Y6EuUEpQhtQsJB?=
 =?us-ascii?Q?RhQvaLbKz5FbP4BOFni5jEWce3S3eQEmXx7b/yPsS2WnLrtb49ZAIW9RzrwE?=
 =?us-ascii?Q?vPemlQ4/MJerg8PSPS87/uQzI64ul40sS3uH/ZwvXJIrGqI/sBHSWDorp2G/?=
 =?us-ascii?Q?Sxul71f62isyBBwo8iI2EMM8Q52U+NZooip3z/8fdQcFu0Pj7xs5VbGnFX+X?=
 =?us-ascii?Q?FJ/PYbFNiZjk6fjRSJoSFBRhYvttwvAMBaszLxYDM+HdtlcD0Hh64lr4tHoL?=
 =?us-ascii?Q?tGBetn7bIpZUMrdKf+ft2BdCgkTy2n19krCeeQpSVg8Cx0HL4E4KZ4BXdSq3?=
 =?us-ascii?Q?FzjDnXG1L45BHFxgwnisGIbrxG+IndsavbKfkmuOS/4LHhx3VvM8AJeTnBRl?=
 =?us-ascii?Q?tUBaZYdpdI4yCATFWRfFyi+Xf5FyxzN5iH77oPEj+TjyPp+Da+POzgXG113e?=
 =?us-ascii?Q?7jB3hEz6s09DiIL5XToiCBiUmdhmahr8wQakUWIftqTn1IKkKcNHxRTHiKUV?=
 =?us-ascii?Q?8XJSFDMmoEc+4YRW2RKyeK6BNA+Dprp9h+7VHvWubGYREb5dQyO7HqgLBHTJ?=
 =?us-ascii?Q?LlmhDhI0TEhhs8jI8i2FYERfrrrUWevCeJUvxfkL9jJnFMtpNkfVgqF8BjzE?=
 =?us-ascii?Q?y7JOXxpDmfDmFkqGuD6aCMIi/3rqSIXaztYNUvRM1yxaxtv6GVe1wN5Oj6LT?=
 =?us-ascii?Q?o4Ud8haVFmoRpigyREyxaDog1TA/vifNmvVq9W97Ncqd1y+re4Yu1ryEDxTD?=
 =?us-ascii?Q?0MR2rMDu79cNUSMB0RpB06lj4AF6wRFGSepuJffMiKmrVzW4FIWWqEETgKDB?=
 =?us-ascii?Q?owQJvB4GP5Vqxa2larhpQO2tPFaSvT83UMNf5ZQrGudtpfdllydvtUx7anC3?=
 =?us-ascii?Q?/hT2TNV/fWaM1SzBxam3DV/FWZ66cWuIdUCMSNq51nOziNivUv74i2FVan43?=
 =?us-ascii?Q?zTmqRysxD0RkS0K/Yw80uTJTY3LObp8j/xA9ltI65MyTzJ/GTCdiUNoq2Ps4?=
 =?us-ascii?Q?7GB47oZJlyiTWHCBI5471PrBmw4nTrySfsM7lPHL46ag8wQA9RUWEq4QjWPM?=
 =?us-ascii?Q?dSVUK5kTSvgoxMABFO0zIVnuvY1RXbc9Aaie5QFSEjv8ZuTeL3YU+A+e2Dlt?=
 =?us-ascii?Q?RiUdIa0Ec4EWW/j0SuJla1AXulIpraBbd3WKKjOzM1GaoxVXTo+goavj/AxY?=
 =?us-ascii?Q?O2NPF4WvHfn4rzoTc02JXxJv7w2P4osOoxWZDCTc6gFZDneu/zE47kF5j8vk?=
 =?us-ascii?Q?fjPREStkDwYpwJmZPgUXpzhaTJsyPlJbBhmSS1zSmQgqcHrSTWJIvJRvvE+l?=
 =?us-ascii?Q?kbAO3Oq/LRPh0Uc80PW1ho3S0VU5sSTGBD3srC/qmIb9dwJRvqDFBY9wey/p?=
 =?us-ascii?Q?bOCDClAQ0rMF1lbmFFlnRldojzJaMzZrKYCAoxod4p8B7zyIGnwMjV0I2StH?=
 =?us-ascii?Q?Us5zEYfKwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086075ee-3f6e-4c87-5416-08de536f3cca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 13:17:16.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc+mAuSJqCPDK0WuZ5p2jEWSAPID1kT5daGFrSBB/9hwVi2zSUWjVllrHWbP7wFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

On Wed, Jan 14, 2026 at 07:26:10AM +0000, Tian, Kevin wrote:
> before cache is flushed, it may contain:
> 
>  - entries tagged with old DID, with content loaded from old table
>  - entries tagged with old DID, with content loaded from new table
>  - entries tagged with new DID, with content loaded from new table
> 
> Compared to 2nd-stage the only problematic one is old DID + new table.
> 
> According to 6.2.1 (Tagging of Cached Translations), the root address
> of page table is not used in tagging and DID-based invalidation will
> flush all entries related to old DID (no matter it's from old or new table).
> 
> Then it should just work!

Unless the original domain is attached to another device, then you've
corrupted the DID and corrupted IOTLB for the second innocent device
that isn't changing translation.

> p.s. Jason said that atomic size is 128bit on AMD and 64bit on ARM.
> they both have DID concept and two page table pointers. So I assume
> it's the same case on this front?

Hmm, yeah, ARM has it worse you can't change any ASID/VMID
concurrently with the table pointer.

You could make a safe algorithm by allocating a temporary ID, moving
the current entry to the temporary ID, moving to the new pointer,
moving to the final ID, then flushing the tempoary ID.

It avoids the cross device issue and your logic above would hold.

Or maybe the case Samiullah is interested in should have the new
domain adopt the original ID..

Jason
