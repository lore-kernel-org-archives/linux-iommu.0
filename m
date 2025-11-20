Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D133710C
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643402; cv=fail; b=jniPNZDuMRaHdOEpg1NwA2Wa9zcHQ3t3zDDepuunUVQDAzs2S7qMUWvfASZxmTxUgZiRbyZolfQO7CccAinoNLKhHWMkTfFe5KIb3VZHGzPmqvd6aAlCDCdSNyH9lA2WXhc4UppB8Qz3MK9aQkrx6HR2B0rP70High2Cdl17k5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643402; c=relaxed/simple;
	bh=RwgcTTTvfHzNXFxe9R9aknkPVZrR8Tk+RMza9ykc7TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTgwmpV1foYbwSLElcZGqwa7S380usYhS1Fhqk06HkvigIukH+3hapQTeY1aCi9gi4amTSlPRh27q2PxN67Fr1r6TlUWT+71cxKIiDq5wWz2Vhlm3P2KeWMRCCW1wnn+sctPI+cVSRA66e5ICxKBdHHZCxzTUxJsQSfYQrrmfMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kU+8EN7o; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kU+8EN7o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkYGw6awEn00X7Gza17RK4674KljRBV6H4i+Da9OZ6kzW5k+p3KQrRS0ynrgiH/lKHbE+iGbhsCfK+ooxhs1Uj9YUfwn18QTrknstctQ4ADJBbK9d1PGH7XpgJa247wy9bx10c9C8/IAMddWuHK6bBOSkjbS8KVlymbz669NrEiSChkHUEPwVIlCUnDvy+ECzPo5XusL2N8jLFIE5EklAnfL6gDokSmNbAPCthQqgqv1pO8yO9EHOpVFzZUegFd+UeRPEoRJrWPiH6EdwjghBsJjvzY/CjiBbYxWZKTHLZUA1ETZypRrY0ZOM1L6U8qErd/0Tx4wvezbFA7MDdBOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwgcTTTvfHzNXFxe9R9aknkPVZrR8Tk+RMza9ykc7TU=;
 b=HYu+c/fUyjiSodb/MD2AgAFWolNj3aCQOVvhm0wsNm8gNIctwbj1UwrU7pv1HxxcpAMAOx+jw5HyODI3v5ABCi5TjpP5FiYAq7+ehQcOnlVcNu838N5Dfq5jLWkr8Lc7Aypn0hnnn3+agFR7f/t3Q/grGMsHu4pGp0vzst16MA/z/Ix26INt6gZK916gF7Fp1UX/nRmSoDXlkW4a5rAIDe7nAJ4jdPSVDDk9DfbZBCXfkBWVSl9Espv+yQbEKi0nJcQz+WX5z/0f6uVtImzERKPyecDtivGlzLACIkInkTrRQGt0110dJ4F8RtFDL1oLA8ky0FzSuX95OMN8vMN3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwgcTTTvfHzNXFxe9R9aknkPVZrR8Tk+RMza9ykc7TU=;
 b=kU+8EN7otq1KDYDMLK48lPJ7G7Oj3am50T+iZdRNCscurZ8BQGfK9VOpqUjEVAHFsEmcJPxy2NjjNFt5aoBERrrCHJBKQsHwXiATdIoapdV+pRgxYUi/IHeDhX245okm3XWQWhi5Wj65rhsfVG4LEQpRXQOwE3GEWlvVUQ/K41/zntBwrB7fpnRxq58h18ZIVhj5Zg/hMkWovR5Y/bRmgUf+ob1VzXE8ps2TlYlBAJIeThHAHRZULil7iIww1Kthh7VV22O9/qlNF+fTE8jbUq2ubhHfAgN9yX34/X7iXOe9/hNO8BsPL8Q9WkEYrzTwW0eZpvl+dVlRxVckF/ZZwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 12:56:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 12:56:35 +0000
Date: Thu, 20 Nov 2025 08:56:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, ashish.kalra@amd.com,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Message-ID: <20251120125634.GA153257@nvidia.com>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
 <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
 <20251119134351.GM120075@nvidia.com>
 <5167fc71-23e2-486e-b9f6-f11960725b19@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5167fc71-23e2-486e-b9f6-f11960725b19@amd.com>
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 349fe74d-0cd6-408c-f21c-08de28343c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nXyjvpk7TlEb1fFLt+YzqX7UJu+ThECziqVapUlD8hnO4vB+q0WI/6Oyu1Cy?=
 =?us-ascii?Q?0BoqM4ZB25yaHx5atne0bZkk6PUtUBDCJ6qg43cQTTwzE0D4z04hjoGj7QQL?=
 =?us-ascii?Q?GLwnjIlx2UzXrl3HDaUIBMw70pE9+U9N7sIMUE8gA5q01+JvksiBeStlXJ1u?=
 =?us-ascii?Q?BtT82XH0Y0LvyZLqfEftPrHPtIjuTnANLti7NCenn98iFHnt12zJagYyBJ0A?=
 =?us-ascii?Q?9WfzPpTWtxclu9ZGmKOP6Gtz0GTLgpg7eCeUrSb+aDfgD+KabDhAEE8/lH/n?=
 =?us-ascii?Q?4NsWzQ6tnxBk3soMttZKAdrzbKFntdfkyku1Btn77+NvWhYS24rQ4oBUy4St?=
 =?us-ascii?Q?IQPpg21Ju5EVlKD0HVoCvyTeAo4vpvT+pquCxSOhLxZ7hHKUlYA03tl//rT6?=
 =?us-ascii?Q?xsZ2S5lu++YBm9qNPoZHUSzlvjidAuQdh7D57+EiV/0BaumZiljICiJAIE9Q?=
 =?us-ascii?Q?4nMWBDDbmSs4hwg5dgUAfgyGfno5oh5zt4P6gjPkggS4aypPUPvpuDRSi7Wq?=
 =?us-ascii?Q?atbDgMTpiEYMBdhl4QS1/gtXYJIpDQo7B4rmEyDNavOHl0UfPFaGhETciOUm?=
 =?us-ascii?Q?wkWrfX1MMB1nUXZXVgl0tSzpJC9OSqrtFdD9HfRXaiDphUPFX8Y475qqKcXY?=
 =?us-ascii?Q?NI3oNs+H9em859n38A6IFZ0+WDe0Gd9abqv0yll8z6zom51AaB4r/Nbq+eRw?=
 =?us-ascii?Q?9f4NSzd4gykod8dRjo9B1cHOK+cEbvCTufCOk9SxE1xlirz7pTvOwYlvyPo7?=
 =?us-ascii?Q?uwdxaOculBl+eLigkoUzga+DxgOkoiCGFG0Dcc8cDHpYxyoC1VIftVJVPUgv?=
 =?us-ascii?Q?dxz+ozZEMIletuhGOoSWZNB7RLnwtp4Db2DbJohgVGoO6yCzRWqiJwm0WO7p?=
 =?us-ascii?Q?rfb24EClkVbGTOMH9b1Uw/GgfXi0ll+4xGXnFOkR4OLMgRw7z4ShbcxrbgpU?=
 =?us-ascii?Q?HEoZVYKqOWUK5I5W4cMLuVlnP4FIKVPkmalLRohSUZp/MIc9tlO3PQuIVzYU?=
 =?us-ascii?Q?jsKHNGB90RxTXvApdmd8DOK56RweDoKiomoczgHTmx7hxAxv9PwEjxvu3D9R?=
 =?us-ascii?Q?UmFarHSYigBBtd51utLJtEw0PIhyCchArN0dTM/kfzkJw0uFcQ6MulaWNeYs?=
 =?us-ascii?Q?BWLZ5OYwDRyZLO3bBV021ITM30Me2rwMex/KiJ279KJPwshTh6dQY7s5y+px?=
 =?us-ascii?Q?ZpUVBO/GPyB9T7YXc96yDdfooWnJSl0fbn1+gCoV8lGkxtAXZrSgZWl6ILxQ?=
 =?us-ascii?Q?lvD95M2mN+uXNi6j5Uln7925mGp4KrkvXsz0bhAfT6+7HMLY+JO1/DcRXPJM?=
 =?us-ascii?Q?/YIQKm9PrhV7QYF9vkal1JQRWHD9n3tO73/IUS63SIVKQ7+GmTfp5lytbt/x?=
 =?us-ascii?Q?TD51UOkyezqNEtOMK1yugHEvCtCi5F9BXt1J0/hTavLg/ItCT7HTUhud6uCe?=
 =?us-ascii?Q?pscxp6VIjzODkMYoLHQp7flJoz//9S19?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TRa3clf+AQXaSx2PV4KfBsXw6ryt4AZDgcH0cFmeAchr0ZdqoxVlMl3bOFs?=
 =?us-ascii?Q?KnYYqoutqebORUoKI8TAYUz13qVTA36QuAk+KIFFa52RZYiDAf/YXsrvbMVy?=
 =?us-ascii?Q?1qjCtG7GGc1DzAWxB6oXJJMW7nXsmPwqth36oIhD/iqYXiwGkIt1IJMheorb?=
 =?us-ascii?Q?XF8Aq/qTWThDogmNsgxekeJmjbDvY1Au1KAbQcol/BY5+nNgmI2NDC1ssam/?=
 =?us-ascii?Q?Sdq870WBrLkQ+TCZTVTiXEC5k6TVs/aGvhI7KJk/okHF4lsZMtKUUwomJy/g?=
 =?us-ascii?Q?JyjQuxzE5IW0+QVMwkNJJiGxrk+41Q5Aatx5E6Os9SlraUI+yIqlRHuS7ZJM?=
 =?us-ascii?Q?hg5Z8LbXQ+7TVv3yIgwlLF3Hz14w6SVVFG/jpyoXM7RitnNwgujgbQqENLGd?=
 =?us-ascii?Q?7HbYJKgZLFZ8YAU0QFL949uBg9m/D7R01RyZzcLVJdf8K7SmCqGNRZa5ZVMX?=
 =?us-ascii?Q?DJ4XVNiPDIGRI+bTmQc21SQX682419Rn2g8Qc0/beKubtHAscdbeZkHXZqB4?=
 =?us-ascii?Q?xlzaaTLKzwT/JbnslPC6ewwBLWgQHvE9Y2WUw5p0CEyrpsJpQxcofBhRSt6+?=
 =?us-ascii?Q?Z9aXKHLTamlStbxvoJcvBr7TF/SZ+XMDUgpuhR11maD7/4F0iJuKJMdaklMO?=
 =?us-ascii?Q?nnVrRrLxSydAwJsbPl5hNZeNFpoAPgUJFfs6wzTR7hcyBxWqY9EgE6j7tJ+g?=
 =?us-ascii?Q?mxZSEfPrQZ4aJoPu+AUrkXcP1bN2LkYUw0Rtp08G2G3qUk1AkR7uqlcS0zvd?=
 =?us-ascii?Q?8VQ5NN7TGQhJYG2HeHZizXEKVfrhjnhFZ4TMJjx4Ipc7FOIkX1Yo08O+oC0l?=
 =?us-ascii?Q?N7LGOyTCX3SN2SbbQc1OpJNFX8GglNn3lJj7caFqnNDmmD8mE2Fo9Y9tBQW0?=
 =?us-ascii?Q?niTu0dbm9lDw1op0uU3tXaNBZ2kpWGXOf9rLd0BIQdyuF5OV61C2El91k+b7?=
 =?us-ascii?Q?j2xRq1WIFzwGq5t/JwiJu9t/WPmeuuRkz3MWcgIWxjlHdsUpj4p2bgdG5ZC4?=
 =?us-ascii?Q?pf8OdRqszY7pRgmzbWqcRcEWuZlk0h6kgK49S84gAbkv4kFKbhuSVwFtFgoy?=
 =?us-ascii?Q?Bp6Bb822QKFIyeho+chluQwmW1mYLAd8Z66vCAuuqTcnc+VmBT2cSu1voihY?=
 =?us-ascii?Q?PpxcwtpK06y+abRPZdObBYdq/uVjuGGYehzN3Daiam3eRaPY0N7dtwY2rNO1?=
 =?us-ascii?Q?9CoKUt8YAQcrCz0GPjqAwlou4siEy7lQBPN8YBMgvX7nwlEeIemybBu54DDs?=
 =?us-ascii?Q?BDprI4LV96W9FnqSN0CDhSU80NCpAoED0BTL2HZY6XotV6YmGnw1ZXBGK1/y?=
 =?us-ascii?Q?dbb9ygnhMkg6RjHstlZE6cxkaDJ5D8ZDrAvPQ9YGJ3Oh3iX6FJkaWKCYLSa5?=
 =?us-ascii?Q?B+TlFmSPLr9CNB7XU5iATzz3eBHmoTM6o7MrNlhb2OyIDYyEU3y1DlfZzQnA?=
 =?us-ascii?Q?BPa67DKrw2qiGK/5uPaw3LNbLnWeWguBFmBQcO4Ct72MgE1Cr9OCS3FXpfWP?=
 =?us-ascii?Q?nec+KZENtZjtvWb3H2gM+EZMCYqCXRiWk3Ob5gPEwVh09xUCTV6w2dxsqB0x?=
 =?us-ascii?Q?NPU238ZRyynZA2h+9QY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349fe74d-0cd6-408c-f21c-08de28343c41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 12:56:34.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPlqQiv79HXgbi53UGqyqRw7JwXOdGTYFHqE7G3kJ8T5ig9edp9tlbQIrlEK1eAN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On Thu, Nov 20, 2025 at 10:32:32AM +0530, Sairaj Kodilkar wrote:

> No, its not atomic context. My intension was to ensure that the
> memory allocation succeeds. But I am not sure if it's the most
> appropriate choice for this scenario

This is early boot, it won't fail either way. Use GFP_KERNEL because
it is clearer

Jason
