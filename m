Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85B296D3D
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722661; cv=fail; b=PQZdpo7vR7eohPJLfOLRV+HR2lTmszjjmbxyh8nkf7T0BpW3Dzb1S1vhesyCytu5LA1Hou2SqpDy+zIWoZopknsKkBohUZteKuyWoTKrcF2EKvmEzLevxGeXj05ins0qDrmCPjLRNXheqpjv6aQ0VK9NSxCNfwQAEvEbG8E1xTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722661; c=relaxed/simple;
	bh=f7n3X5fUoEOtlEGUlVon3T6cySqZ5RPZsUkDaHptw24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z57J9nu5mkUP7iwU2d6YA/AjtnC9ioR9ocdwdQLHANA9dZDcQ5Xdhi6cMxj5cP3uKEYjmQhjC1Y8H5iItdN1hCfEOHpwvpzk6MIG7HOOTStQd0YN82B7V5z+VVD1OYvB7/z59X++duNsP41MGORUiPJolcmY25sD2xA0z4abVlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N7grkGmw; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7grkGmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6KV5JBNmABorUUJAP4fvqL1HrLMBB7lLYCFQl0TfnRTxzij2e+c8mF3GB972oa5LiJA0RIpIB37r3BVwN4op2yWx6ym8ytobHBaWmltWiUZagNIn26GdemnZS4H+5ySSvVbyPGqnvjx15FEJg4KtIHpbLhxXIj5w9HWjKNCz199nREWxKaFRWbjCbt1PD4UdkmH0oi2/kX92gWT7276ztNSRnWCDIH7Gmnuw/rXjpW+EJPWZ69DMqXZjojK+HnLkVlQeq96nucGl4QinIAxyMx8P+X9V+7cWHMmdRH4IUXK8tMBThVftD25siRKmnr+ZOeaJpNPStv8aC7J3mgVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1P4D7LtRaCD/VTwclnGrzZYZzIbq0BxSBuhNruA/tA=;
 b=KosJVst1Kqsr50ZE3BZIB609QqpceN3QZ8Nef1PHmwCsB405MYWqPUANpUeCr1FboG6Hzsje4TSz+eMSL9hfdJCjoZAd66w1ZnTIoz/yiBWYzg4tKOc+ghwwOzQxS7HDr2tb/JP59q4WzzgFGVx8xYCKmHTi+L/gekw4JaRsuKZeiQ6r4AD75pslaXW4SYcpKr+0ythJG4cw/njcIh6rmoWje2LTqoNPkaBiKhrVgxEM0I0MO/04vJGEFPNpXB0qByVocH6Zw91yK3kwTlClxVcyR5GstpiLM4VVbcihi9UMfwMyisfh2Ogs30p5t1IGEgen0DJKw4ABD3isf4sx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1P4D7LtRaCD/VTwclnGrzZYZzIbq0BxSBuhNruA/tA=;
 b=N7grkGmwXZ4RAFHQHrK5h2fwHdUeA6W7ut5mNlukKFRksYeKaDD2035sU+zGtR9soJ9m1xO1sOAvW1cT1luZKFGyjUFE9vWE0EBW7p3Vlj3I3PaFKe2ImexGX6+1Bz43QhsJwEq4gk5Ncni0SOJ4sETyAjwDDwuxs3krm1eRKBnBNWpfmoKw5P9HUd76bHjYA5+LH82FuAd4ucWGqfdAz0KBJdCrUWwLw9sErkTcWVknUlQSVl6oO14p+AaIVf8OTo9UxsH1pq5Y/S4jZyDX2sAMfVfuvvSsEU/pwH9GvzbHFD5RVLP8LVtUXC8BC2z0ANHEsH7YO1fozTG0xmaYGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 13:10:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 13:10:55 +0000
Date: Tue, 15 Apr 2025 10:10:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix pgsize_bit for sva domains
Message-ID: <20250415131053.GB517881@nvidia.com>
References: <20250412002354.3071449-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412002354.3071449-1-balbirs@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0928.namprd03.prod.outlook.com
 (2603:10b6:408:107::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2480f8-9926-4267-8868-08dd7c1ef490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/HAodMFDTEu34HV2Xo3vIgEI2ItQDncpsRhB/8vVDuLJkXVK2nzRTtMJKQs?=
 =?us-ascii?Q?vqbjkvefC2DJHq5BoCmIj/00ELK5bw8V0othd/I8fd9yVNCFqL53BkgXZdXr?=
 =?us-ascii?Q?sKjwP/D5CRr6esHrHYtS56rUjnwtLsc10Nw46TurCg8Ah4xX/DlCfkPWT+ay?=
 =?us-ascii?Q?iKHitlZlU7fi0VcEzOLjKVmd7fAT5eIEajbTSGZD7bPzKb7vjh1M3PcRyFmN?=
 =?us-ascii?Q?SAS0XBtzQ2S7hwI3qV6SxoHoRlOyRYF2vYhYq1oz9qwYNfy9LyDXoyXVqWms?=
 =?us-ascii?Q?4SfsZuszYiL+NeituuvLRv7sKVCD9c8Y4MzQIBcsMmvY6wGSZ5OTVkX5gkQh?=
 =?us-ascii?Q?7sZsf5CEAyoSrGRS3A1Dx4pKVdiCErh8XupWSWcBOs6lCN5SRQ3kPxtFAMiw?=
 =?us-ascii?Q?Q6WHubzKrf/gCmjNMgq9/ZnfGBf0gJgmVo3TevmNc8BdybcyUTQS+VgXDsbu?=
 =?us-ascii?Q?S9gfitqcS0D38RioBQaZ4OiPMxfAoltb4ejB8zlKQV4Hgz3lNVw5daWd8o7x?=
 =?us-ascii?Q?A0e/E+jXnjQdbPjc63w3K9rZRSO4hgcVh6mjnM2CKYugQjCjhXDQY2q8HsVX?=
 =?us-ascii?Q?UrDFte6OpX4oqAk7LLvttSieLEmhBOis6iJq3YeZMYCSEFK+S9i2wWB+7AgY?=
 =?us-ascii?Q?D7IveGyvIByiCu1aPCSSNqYIigOlO3LsmrO7Oq0omRUm6oZ18zdV23uJUUwD?=
 =?us-ascii?Q?vIE8svUel2+YInAjCshoSprd52GKWjkp7OcSS5OzyviPkQ7b/ogeBsot/KAE?=
 =?us-ascii?Q?0MWE6WfYqQ5Ulskwkcv4vKhRSqI+sMB7A5QaEVxpDqK4g9c/y67GN33Qs9t2?=
 =?us-ascii?Q?8FJW+nHE6q4FHC0n/RI7CYyWHNU1jJ8OhXu/0zJKt69joZgt79qJ/4lSE0hX?=
 =?us-ascii?Q?kaeFrD/TX0rQPYkY39gpWydMLQ3GBdSZg+rRznj3wZs6fWQR43TnU+l1UpVo?=
 =?us-ascii?Q?x0mo0gwVxM8O4PTjHSiq58FhmzL2uTIjhWpff7XJAENP4qlKP6ihRe+O5Ibh?=
 =?us-ascii?Q?6saVVhREfJ5uiyIyw2G5prO5ZV6OAmV4dgT50K47XzAyhggHllZF58IMIHvA?=
 =?us-ascii?Q?5ZuNCDqcNXIvcXSspTC7JMAUcupwBzqXFI3/Et9dNvbe3d6j5opGSy+q9vte?=
 =?us-ascii?Q?UVUa1GE/TPiRyeTAfmJhaFhabqPOdMRbuczZSc8nrwhBMpQwt1GpLyztAhUH?=
 =?us-ascii?Q?TZT6O+JtuBPArz6k2JLQOWWk7obDUITuP/q/uu5InkbizaJC+SipYH6iLYW2?=
 =?us-ascii?Q?EXgqf/qFwyKxrnY8y5BQ7S4InSAvT1GkYfmOZl9YzojHlZTHQ5K7cfQ+P8pg?=
 =?us-ascii?Q?JPCF6ZC/u96Ld3SSfl7YsJL+9RfNdBu1HRI91bGA7xAqpSl7qSZyK8OuY0sq?=
 =?us-ascii?Q?RUvm8ckpiXraN7s2XwqRWnLGqJz8mR31nZyNtvWkfYYHMRzqCbi/TBrzSjQZ?=
 =?us-ascii?Q?axomwBZuAmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S+ktolz/s5kssg7Js9d8PWENKpMd+bRwVLbqkI+QDvL7mKU9nK31nTmVvBE3?=
 =?us-ascii?Q?DuS8Ht/pvLDIuYK3FBmnr8Ek4SbPUfCi0vNQLuzg0jLfRPTxXQhaPn5HI7e8?=
 =?us-ascii?Q?SDZrhF5Q9Aji+ZCdp9utvhXVln1s34NUWH9uwMYPGTTSe4OaN/UjkcnQ89OD?=
 =?us-ascii?Q?YFdZtVz6ZSzcUx7WlqI/SPCbHQkLPB+xGK3Mxsf0m266MQ7W8B3J+p5rtHS0?=
 =?us-ascii?Q?xij8m7WuDnR66jMOGxT3Z8UhzK3k7t8VmshVpHE0yxuJaO+V+s2ykpNapjaq?=
 =?us-ascii?Q?NO48N/eniiTtF7Kdg/zvp0vHKo1Lo3GSzNu/Ie7n2DqJVyb8SsmwJeYlTz0V?=
 =?us-ascii?Q?MNTzKeaHBwG5R0YzOhjqQ0ATFlCs7ZbX8s6sCbv85SW2gJesfKvMJKsG6eSK?=
 =?us-ascii?Q?tvfHUHknMnSaBNBY/ZoWthtvIg6gFfpiLXHj5TwUEK1+FyAi44osZGIe86k8?=
 =?us-ascii?Q?BIKaXVk1FgzdDBF2iEPu5G0Kxiueb9hTMNE7HkhZXI67isdWIInrRx0S7bpK?=
 =?us-ascii?Q?yNxdJS+3sHz5wyVytgT0V8U/KAaZzduSALjGID3+5I9EgJdMmhzAA0DIraRi?=
 =?us-ascii?Q?+Zkd0fIYdeW/s5O/kc+KvS7w8bvnmKKhq+OelbD92ea0nHOh43GxX8QsSMiJ?=
 =?us-ascii?Q?3UNaDYCEd1Mp+XV2eUz14mVqjvunZwouWxvoOYEHYUYF3innsxory6el5MH8?=
 =?us-ascii?Q?NIHvqd1l6VJsOEc/rr7kNCcZ+SjNikbhwiTQEGHs6yUBaZRIaVcTNMhLp8zz?=
 =?us-ascii?Q?dvajbPkhvOwn4ukFlduYTHIqjExZAhXl7lY1rgGWVqyv5mwedDZxDVjCowfa?=
 =?us-ascii?Q?rTq+MOG1mp5ChRx2BfCudje6cWbb9BqkjIgjgj8xElwS4m2nE4pZYG7A1Ls4?=
 =?us-ascii?Q?e/yKWbrbtWGiW9bCRvF6+tlguUUQsQP57u771S/1GN52mrhaQYlQKqXDz/3G?=
 =?us-ascii?Q?TNEk5+Rm8DwekcI7/UZy6m7XuzHhYSV3+tmLLcjO/H+yJXmeZ/c3qY7iBSAl?=
 =?us-ascii?Q?qUKBvgYsEOKzxOpXXK+acGnC26UwLC43XDAtVHCCKVAeKMds3PKjYrFKVL0q?=
 =?us-ascii?Q?LrdeUz9l63rwP3v0AFhWydcmZwqYJenzHtZluWcKJEaRfucvT9tItUtkMAne?=
 =?us-ascii?Q?pyOf5HIppOiMKNGeSzyf+Zl5tsKZfhiwZE1/Ybzjj24W+YBFyfoTiYmNNHZc?=
 =?us-ascii?Q?rNVriT2DUUleMC9gfSDn8j+ZAcCGZcNbc4nhC1lnrzG5WNTphRpum2iGGH4n?=
 =?us-ascii?Q?TAP3cEx2t2SNnmqgOWUsCUpv9dIXwJnKu/X/qJdl8ECVRPYywNxkhyXRc6Gq?=
 =?us-ascii?Q?KVeAOKNjUhYbOSRyEelRF609n78+rlHMtuqLbZ4q9wb1ZJjCk3s11AAArdB0?=
 =?us-ascii?Q?WcQnKSvzpgj256bo86iF314KBbMrGKUBfe6zvAevNJTyhNJjW/Z6gCAL0drL?=
 =?us-ascii?Q?Ql9YKauRu9hk5ZzPn9B4jDtPxGBsrS9pHV6YaTf2JyUrmUVrHAJYYRgUN/47?=
 =?us-ascii?Q?z5mpr2tlFut/9MWnJ2vTgwGRygx8e03FdYWY4DozudbRNXAzYFhqG5O9twMh?=
 =?us-ascii?Q?F0CTmk+/+I4npgaM8HjQxE8DNXWBv5u+i73AEjzt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2480f8-9926-4267-8868-08dd7c1ef490
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 13:10:55.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl1ed5j8Iuyf64fEqk97uxgURd3tFyLj/57Cs37+ca4z0sjju1A86N9XGCWGLGSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

On Sat, Apr 12, 2025 at 10:23:54AM +1000, Balbir Singh wrote:
> UBSan caught a bug with IOMMU SVA domains, where the reported exponent
> value in __arm_smmu_tlb_inv_range() was >= 64.
> __arm_smmu_tlb_inv_range() uses the domain's pgsize_bitmap to compute
> the number of pages to invalidate and the invalidation range. Currently
> arm_smmu_sva_domain_alloc() does not setup the iommu domain's
> pgsize_bitmap. This leads to __ffs() on the value returning 64 and that
> leads to undefined behaviour w.r.t. shift operations
> 
> Fix this by initializing the iommu_domain's pgsize_bitmap to PAGE_SIZE.
> Effectively the code needs to use the smallest page size for
> invalidation
> 
> Fixes: eb6c97647be2 ("iommu/arm-smmu-v3: Avoid constructing invalid range commands")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> 
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should go to rc

Jason
