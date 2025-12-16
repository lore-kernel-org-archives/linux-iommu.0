Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAB38CC96
	for <iommu@lists.linux.dev>; Tue, 16 Dec 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893381; cv=fail; b=FVT8Ge703kIOFokf2tag3UupmOAlyrt4ErEUAKkpOBt/bRbu/RU1oenWSdz1cPQLzodHvjj8GXQsLuHKQrFEsFgURHbVFwQ35tpx9Caekxlugvelz8awQlnH5b145BKGw+q0FAdZNAuMNJvXHuVdt0ufx+KFwtyc/BKI3Sd3RVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893381; c=relaxed/simple;
	bh=oNPxgwKN/CJH59xpty6dwhP/XnumwSJf3fkTbXndfz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5tCp9GNC5TQAy38l3S/94ekOtGI1BxEOJ+dtutVBHS83hotBknYCxo9/qfACk9wK35NMRA9MYlrzedJQ7g+IiBJIZiUnHRgl8PThaQgSmZoG82z9fEj56KUOsyC6wvQsGktBv/GhSPxp3IXu0WZpTa9BBTj5pmWbuaO463HX/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k6XlZwSM; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k6XlZwSM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP07Lid7HNmu1fzYc8Kdd9XpN3Xpsg222+JwQTfvY8CqlsIX+xLumdGfDhiCU/Qg8k0yMo/Hqc6WWJwlNWGJh+sb8HaqLoTRDSC8qbR7pt/NRSL8tFh7bfp6ZwsOm1bPDR/yKW3bzuW0ROmxfEy8etolvCr8nW9I4pxsDI23GzfyYYKGyW0mNwIqRkBhUhAmDXSyExAY2SzjrNxLtE7Vc+5zKZlePNM4jpfXPZhVUYEW5Ze4IT+Pyv3T9ZlqTO9tGWsJGrAcHH/8m2OTvCXaat+2UGTLPrHZSQOrbweckqQQD0BjrHQRoj87ccm2VPl4TTWX9Jp2hzNuU+jsvMJ0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KODuGjmUN6JRLdsI5Yd3uXKBvopSBD/xbBEnyowMZ3c=;
 b=d0FuZZE+hQXech4jMR1cCklkPaPtkrRLaK12EItKN2u/IpDUQJ2Y32rXPn4Zq64q2MJ/BbqwETjGsWSN3lud8a1PGnV4PEo08VpgbHSsaR72oyjhwv1RYE67oNAPWmjwUKyls2mughduPQduXSFbavIgPM1RfOEOWdomVHcxKREdarPKTK5LiOwzkg8cjtiAlFyDtKR9Zkn+raJDt7hTfgsTVJ5iwAJAXx+aSH6CvubZ4u73wqdNHNEwWU5pUG851kxFrRscKMHSUxmXi6fzpZnmz2eT3cwx6DhE55qkxeFLZE2jiUz3Ocq8hFcfdYLUmQXGWETN7y+jo2yAxaRQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KODuGjmUN6JRLdsI5Yd3uXKBvopSBD/xbBEnyowMZ3c=;
 b=k6XlZwSMzGKTx5w2w/uePLZ9jEBI26+R59JXFIau8U0VapZHSuGufTUfWfFrYPchoi8PW5eqFPDaFVBP5AC71XwIGkdfntl3RC6bUBCSaXCOCXGjhQh5Gjh02Jo34037eN7gJ4hfToM8cQVeGjFvfFrOxXsZdPMvw7CLti+kbhcnzM5avttOtLcQT9HJ8LJ6kfBWLem5vjuvVjeiw59F4hs+XD/nNLKxH5J5cguVs57gp+Q89Dpwt7AWwnpCeoQx0kQOA7ljqIVW9yA2bSAiZ+hP5R+ElMdB7xw3UaoUljsjL2urd5YiHUbD0yIPdtikaJZsCOhZnulGaMg08U7WAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 13:56:16 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 13:56:15 +0000
Date: Tue, 16 Dec 2025 09:56:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20251216135613.GB6079@nvidia.com>
References: <cover.1765850465.git.nicolinc@nvidia.com>
 <f4261c5b30ce3c6942470433033d4933ec5eef3e.1765850465.git.nicolinc@nvidia.com>
 <20251216090926.GR3707837@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216090926.GR3707837@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1ad5db-c2d2-42c7-5d52-08de3caae125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBlyY9OWC6qatvnZu8b2a5Z3tbbAQ/UG+IbdOZD7DKKIERy24c1MBt0X93tj?=
 =?us-ascii?Q?iMXj/byqFBrv8oGbLtt00dCXxVAME9siKWlrz/D8uhYqBt9MariiVSBRUiYg?=
 =?us-ascii?Q?Y+OUyW7mKiKALkrdGgdQ5MHTVTnb7Kh0lx84wwvTUnw62jEhnScKqHm7pUN7?=
 =?us-ascii?Q?XGi7MhyOA4lLq3DcOg80sZqtQNSbuM9kFjCBod6EnismTI/gdoss9SZ1Udk4?=
 =?us-ascii?Q?l91efvhL2CxmnfGxveNcfR8Ve1VHX7WJEMxacVp26O8HahbwuPLGOI65znsk?=
 =?us-ascii?Q?JUHxyMjSBgFUx5l5cBf93rxOj51aGYdt7Yh3b/PFCQULEz1gAjoOWnvqjA9d?=
 =?us-ascii?Q?/P/qi9emcNNOkBSJoZ3Rxslo/llWmoK5/MF4jXC2YwXdC3Gkwe9H9SLu/pCU?=
 =?us-ascii?Q?L4lmxmwXkN6beUh/xp4h+JtpdAHM8hOKHO/yu2WxkgdM89Vbt05ZjN5O0zG7?=
 =?us-ascii?Q?1MZhWiv69fG1A+8V+8Clj5i1bZ1o5WXIex6xZqYd8x8LcZkDUDFdVgTM7YRo?=
 =?us-ascii?Q?diC1f/jR2bIDh9IyI1Lu1u7K9AD4ea9KOta6hpMRuuwcPP0gqbCgOdKMxPlh?=
 =?us-ascii?Q?JT9SYfFg2hkM+XWI6eijSw/epewPah3x/Z/TX9rfaUcib6xWCr3fqgL6sJQn?=
 =?us-ascii?Q?rs0HHDnURdJsrlsVlxm0sDLhUNs2Mal9Rj1H9X8MeFvbSC7hiNHrEMIUmDET?=
 =?us-ascii?Q?96LmmeQxiv+n5DAl6ekh7zxjksWrOve1tX20X8MvQc1KEjd7WKjf2Yvj72W+?=
 =?us-ascii?Q?Mgr5dzwt7qKPG288d8gJipai5r13+td4ZOvYqmbRn3cV4i8w5zWGm6MiQXue?=
 =?us-ascii?Q?N5swZC9pIWPoz8b4VcGuTGs98OaM/JJ1CZNLSLKH9nDlvnDdziHDyQL2DDd7?=
 =?us-ascii?Q?tvDoCfQQBjJGPwouH7YZM+ZjdQCroHJDfX1Pk8kXYWS0WHx6QAQIJwyktok+?=
 =?us-ascii?Q?HSoo8YDhQ1xdSl4owl+jxZKUAMmT1GZZhyFpdu6eejvQJpbvMVRty8hfm5cA?=
 =?us-ascii?Q?iNRgvDzyqR8PvaEnUxWRJ5JG3P2grqrwfOy1dbnjkcmyFoFmGnoIBqB7gB2o?=
 =?us-ascii?Q?gqWvuObsdEck/1QpaLXP2m9ld8Y0tW6YE/iGBYm0aq0IGwgT35x6XYoGxY1L?=
 =?us-ascii?Q?lxmObkg73sDKm77dMbHxQoZTHQwQLvy7AkTasTf6afdecHMkk7MgaZyHop5g?=
 =?us-ascii?Q?qpuCzwKa0kWe3/jQDUAQPcIBbpKVOqEGu/8u2CRKTn7zFPmdn6odqkpce8/I?=
 =?us-ascii?Q?0a+xYczGUR6SV6WjorWPxD8N33qGj/Qh7Xu9aZ8sSVJkN9D5YBduwl0S6Xfq?=
 =?us-ascii?Q?ID7J/+MunucVBxVZZD1Fsgsy/CeV3GDepZ5a4+jjbNfeGp7YBhEYI2FVGEUK?=
 =?us-ascii?Q?E4BANyZKJIFWsxg4WzOu6a5jfjRttkFp5vkOCpYPniDkqg15jJqxBHPmmW+t?=
 =?us-ascii?Q?cRPZQVS/9kQy3Qr9jVH7qkEA3bEfr6DVspCrtS0sEdan3lt1huVyv+G2bRjr?=
 =?us-ascii?Q?u558Q8YarGaEw4c2FvPzS+0zt6ayatJg+vz3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xoAnRNYPmJ9piT2vMplninbAesurSMgw9o2n3k3XY/TZLR8i7GWKKCggl6RY?=
 =?us-ascii?Q?FWGogCbAjOKLdYJ7dtQkhq9hWL5vTJWQRCDJQT7UuLA1wkSrcazsgeSmvwXZ?=
 =?us-ascii?Q?gjxjy42d9f4QqlTYPf74wVWKw+P1tNjlkGQguNcxzVVOmKE5SBQWYrLh+WLh?=
 =?us-ascii?Q?SUq3/IqAqyo21PmBP8DehIY7E4RTDKhihYo373W5d2geLBFDnXUx4P9KesTW?=
 =?us-ascii?Q?WZ1s1ax9SkUQl1KxiXat/M8oEQbQ9J+TZfm6OMWwGa6VvXEeGbA0iHNuD8UT?=
 =?us-ascii?Q?yvo9agbdd6T1ah+Xw5LGyeyMT+Th91S3ZJNyyPOfZTKVfjZgClRXEw0EfaY2?=
 =?us-ascii?Q?UVCaNGU1XkkCjQFudLjNRqRG7nOj+d9rO285MggnFZ7Ovf+zaAl6WYw4+Z5o?=
 =?us-ascii?Q?J71jTDl/be+yaRb0h5uRiHyTIDJF7G8o8cmHnmXf9TD2HLPGl3RMfFS9e4ng?=
 =?us-ascii?Q?Co7rR2/es3uDnldWXDIgkWEDHM2e2WBjL5+X5SP2H4LILF8zsTak8fwwagMB?=
 =?us-ascii?Q?z/mollVqZSLsyEKWQUU0SPi6joREGPh7qvgyBms/0HlXlWQpXn9m3ySc5Vqw?=
 =?us-ascii?Q?ovYpl/UbyE6njMabTCkWwODGbDWSqC/ZSdOM58NMrEDsh2tRv53AERCxK2jK?=
 =?us-ascii?Q?Qhm12b5Zdjfi+hm8t6f+dpM++BejHE2NXPQciUPrCINvIo5sX5Ddex78p2Mu?=
 =?us-ascii?Q?LsUe1a4yxdmGN8+/oNPRXzMrqsyvWQezwmSNTxoLbTRi0HvSa7G5Bd0ti249?=
 =?us-ascii?Q?V0T6NYdvOE3HI6E+5zA2iuJUFv6aDswMeV3QuVFQe0K3+pchqaKFFFeuLbVQ?=
 =?us-ascii?Q?mUN1E6Ip333ZGYfJLyNSC0cqdWBQLwxs1DlFgSLm82B65U6HSvmxIlslV68c?=
 =?us-ascii?Q?Pft0VyspuXfKbADXrx+asRtJ8dgjapu+o5aKCGaC2YkEjVpkG7tsLsNZ4R5z?=
 =?us-ascii?Q?Nni9z3x9zA0f/BXuZy7quFtQigctyt8DTA0xCtHtPFxM/6dEMI7lgp5fcauk?=
 =?us-ascii?Q?KBDi7aKt1mkhKc0eJNcE+6gLGAWeRMQxFAXgs8R8DxTC6mkvYkU6dmNUDlEf?=
 =?us-ascii?Q?Z74R9Bq7ZUutzgx7DNefJAzAjAyDEIUbSfSzTzS4aGYI1OdvbweycoZEBv+l?=
 =?us-ascii?Q?GB2bR69idf05q46JAg4eiqUyoxmgnCRXLYkh6UIvam/+SPpBI/t0mN8494lz?=
 =?us-ascii?Q?/pbp/7cBIWC50TyrERQ1frLnouNe5GaGpZIzTWzM4uj0LjcmaJFkSoK5PRny?=
 =?us-ascii?Q?aWJYyDajLid0HYhd0/wHyhSTGIEwYt87zDEWoN6SOyR6tTBNQ0s/k3Xuk65x?=
 =?us-ascii?Q?L92wnTAIkNFZdHKRSqtdyYAZG3DcTqNZJXIvJA9F6dnYNey3oGEYHjwLUWUZ?=
 =?us-ascii?Q?fGnbAKKttwfwtWPALTTO0x3sY3uWJjT8DZQ+Tg1OkWFeYeld2TlwXmbvOOQC?=
 =?us-ascii?Q?MUWS7gCuc1XQBeILujGEl9rsdn2jxMqN6EfCKz8Ztk/eZdIJE7bck6ZGkHTi?=
 =?us-ascii?Q?kAv1RN+VBNEOhF5rwdJm/CEPTB7jk0GTn6E6KLTW6z8LZKL1ikdgpJ0S1Wvb?=
 =?us-ascii?Q?IjJhMFnzEIHyBvu+Hl0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1ad5db-c2d2-42c7-5d52-08de3caae125
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 13:56:15.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euu2Fzn7/SdLb4TStYS2Rrs2Za3Psm7V3M/u6us7VeL2Ai9Odt+7aAPBFKPkBoDU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

On Tue, Dec 16, 2025 at 10:09:26AM +0100, Peter Zijlstra wrote:
> Anyway, if I understand the above correctly, the smb_mb() is for:
> 
>   arm_smmu_domain_inv_range() 		arm_smmu_install_new_domain_invs()
> 
>     [W] IOPTE				  [Wrel] smmu_domain->invs
>     smp_mb()				  smp_mb()
>     [Lacq] smmu_domain->invs		  [L] IOPTE
> 
> Right? But I'm not sure about your 'HW sees the new IOPTEs' claim;

Yes, the '[L] IOPTE' would be a DMA from HW.

> that very much depend on what coherency domain the relevant hardware
> plays in. For smp_mb() to work, the hardware must be in the ISH
> domain, while typically devices are (if I remember my arrrrgh64
> correctly) in the OSH.

The '[W] IOPTE' sequence already includes a cache flush if the
inner/outer sharable are not coherent. If a cache flush was required
then the smp_mb() must also order it, otherwise it just has to order
the store.

The page table table code has always relied on this kind of ordering
with respect to DMA working, it would be completely broken if the DMA
does not order with the barriers.

For example:

            CPU0                         CPU1
   store PMD
                                        read PMD
   store PTE 1                          store PTE 2
   	     				dma memory barrier
                                        device reads 2
   dma memory barrier
   device reads 1


The 'device reads 2' thread must be guarenteed that the HW DMA
observes the PMD stored by CPU0. It relies on the same kind of
explicit cache flushing and barriers as this patch does.

Jason
