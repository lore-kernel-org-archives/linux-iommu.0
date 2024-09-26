Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1B17AE05
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380618; cv=fail; b=XfXDmQnHjnvz/BAp9A/mWVyLJ0eXt7k0m1JmYtagrByQcM67fiIoLaNhxOEBXuWAznJEMRE22MUNPWHnPp0bGjDip3d331jmkxdpTiDLAeXiOdJTaUOMt3ocpjWCMbNSB8OCQjsWZsW4UBUxWziXlYILUmInXcV9dhYv7N1iWXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380618; c=relaxed/simple;
	bh=PNrtUk/8BTiID8slG/+Robgcp4Pi23d+W1FrhVjvVV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f4FYE3pOb/tXkk7IfbHdp77bPSH2tdObQZg9AtpI2j3t/48880zR+gmBs0toiEX2c+/auY5VcKENuvTCe5ldaFY6ZY3RkD5PCX9i47UG3Rk6/mqWXNjbEZ1joQJENdqQ7b9VFfVgozAXZF27WPuD13mApH/vgC3/mDdgqBNccbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2IDgsWz; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2IDgsWz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3laFx/V0vjtt7dKsJ12UTV8opXwntYIJJtQi/egSVIlxdcUoi0BBYhAUNwQ0fKy3nbaNKuwaGzIXjGbU4pySI5P4vQczoZ1Ts6yjNiMOdvDWfPoMTg6eE/1qlCKFhZOOHK7i6JzMHcEZSBrivB6wtfSRctr3UnttVRQJu3eoDHCvaCe2Lo/tF3xoN37IZeN0RI0prL5XdrAPK4xwf/T2c3XoSZL7fhVu+s2mfc0EoH72HRWPJxoe+kVZTE9S3dFtBNmN+E2a3gKIsX8d4wKNOzSnS3K9MbqROwOZWLi8X6ATxJxTMiYM4LD71tFsPr3IqtGr/zagx+7lRT9qkdnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk8tISsMkIUlp+4WG0o9UVaJ5HwRgpv5CIGl16ILDu0=;
 b=taYAzOXH213ph/5352SY960JXbhG0puIX6FNhO9bByKPhpXJj6/D2cQwSNxOUGHHPaITEdBgnrqASAChir+/JeVmAEcgAaRMEa7GTTeU2foFZSifEzeDqdvEfZZZYcjBOQhBMe1vmEgulJM1+EKOFnuHsXY5aihttFzUe7k3ZhVHksUGwS/Nd6RsH8ixIsNypybfVkbsiKQtouJHPfyk+Lub4v1oT9r3CUXQT9VIqbhMCe8iQtwmYpBiCmI2DQVX65DgLBvUQ4tV4VpHhnOJBWd/4hY7WJfyF2azfIOuqIIJrWfxcj3v816Shxt1td5P87FTp17RMAzoEpdroESzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk8tISsMkIUlp+4WG0o9UVaJ5HwRgpv5CIGl16ILDu0=;
 b=G2IDgsWz4a6ZFui4bOEbxaTNSCTj3iSQoSLkmSUG7lM6ZoPS+DiNglDWyOzEmwo+canl+K7WpWNfn8RRRZWfNzpQNY+Fy+qnE8GIItIlUGNRRvRJ2sT3//yfPlb7/90SnO3SQtXy5Am5CbkuRd25W/s0VbiGGkcGWIcpWZMhHs6wrnieGj58Pl3kiSDxqAOjulfNuuIsBTEzLigEzC6tczmfFzJG4fu1MDhAaE3K1oYzi/qSRtFGjz544JhBiHQK/MiIghscC5bpfa+eRlyr5RiBNSn0QCRfxoI+wcDbZKD+MLVmTp3OI+Ul3e7ZIfyQFxiQTzDJRU6sKOtbI7Kj8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:56:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:56:53 +0000
Date: Thu, 26 Sep 2024 16:56:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20240926195648.GA229871@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916171805.324292-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 18571ed5-363a-40f6-935a-08dcde655e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AI3uDf5NgbFgwGHioiuv5VEdhXkKIyKCPlozvmM0HbB68V1gX8QD4/qIWoB7?=
 =?us-ascii?Q?IWqFlmBilff6wmSKr3SX+7CASZEET/K33op7kv7QiNoL3VVXddSmaLkVBMTm?=
 =?us-ascii?Q?Kzjmlz7Qio6hamC6rDG3dL9h6sxr4TBgM/ZrSKvO7/jBDeABXSgiFs3ZFf+Z?=
 =?us-ascii?Q?MIAPm4nc/KyIeb8iXXqxJ9h4reVgsLS4fxsbciBX6X3JBcWEC/SsBUDOtPVn?=
 =?us-ascii?Q?17LtSeZy1Pmjnc0DDNq4ruqs+TcvzD/Z9oKjpne/hpFbZLMUFmPcoMJCEyUv?=
 =?us-ascii?Q?r7FZ2lBtfGoMpyPN9176Szg1F5SC8Mj5dgvrcJgWFcmS43PuK4tpEzKkpzii?=
 =?us-ascii?Q?L+84GP0JgM3HBIgiIsV5x/ZNV9OKrwxgBpRKgdm94VJ/7NTy3ROcPqQmsCEF?=
 =?us-ascii?Q?X1C1llQs707E/ip4EhWgWZ8LeH2YVUirqRfYQ3a5HdAK/+bXNls4WSN8m+VC?=
 =?us-ascii?Q?LxyaJnv76UoLkqmSOb2K/0liPBGaDhzvk2seGLZtEaBflx+Kg/6jH3uyhyJc?=
 =?us-ascii?Q?s2LMpC8BgfXQNWr/6LEYVMO0lMsOaKGwlTaqD8uTjR3GC/0sRY1/8mXS5HWt?=
 =?us-ascii?Q?VUlB/sAOlPEzlfbwUd1jC+e0KfPwExgXOp6MLx5d62p35DMHcYueVFm9UdnK?=
 =?us-ascii?Q?xrQkTsT5lD8eSjgwObWTXZozlUaNrs+xbyXgWo2pyxu7qGyv0UB4laNNUjjd?=
 =?us-ascii?Q?+Enz6EbcOZzctQZ4crNh1WMRw2uJV7eoqz9yeRQ3+ueTKkFlOu7VM3XtuUYV?=
 =?us-ascii?Q?DcruuJdkPUyUCT8klAba2dC32qK+PGB9MMhVHddAPiZAFALEQRyT19cgRHgL?=
 =?us-ascii?Q?oER598VEXUdoeYWW2+55mKbPHlXhbZtBIywVyexPtymUN6e6qe14nwmsqkJ9?=
 =?us-ascii?Q?oMsll5/1SxZnFw9knwgNGaZhnXWNqe+Y2uhcOZR+GpqQMr5OgXbLJ2HMmde7?=
 =?us-ascii?Q?TGosXMcz3fYMkbW+ufY+DQdv2cDFtO1tncVjDFp0qAQVuqqKgzeZ2VRETCQW?=
 =?us-ascii?Q?pPz7m9Gc+bBHggWabRPqnwFKzQ/pqOkqboQtDpzztSDPbhMU8bLQE2tSgTnT?=
 =?us-ascii?Q?1tYa71MmCi9AwIofRG8FAzqH93pujoW91j3SDS23oBOr92paHtIKlpT4c552?=
 =?us-ascii?Q?7E8vLMBqHV46Vu68jUU/qT6QlR1JgQnPeYv2Z2VJjCqL6G+J4RBwYWeOBvvz?=
 =?us-ascii?Q?fG2ysjkNmxPbgudlaGQG9qFgnVzNC73KUIJHEXoibHt6hzZ5kJQQvrotSfdi?=
 =?us-ascii?Q?Rh0E4tFmkp0Me+joLD6yA4Sb/hmq8pkVdiws/Ty+WQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c3dYRuMYtA599bj+juxbWhWHRulIRZd7EpHAlDHXkryRnzoUWaG0MR3bT4Qi?=
 =?us-ascii?Q?frBs8OaSXsa8tQY0f6Bj8XiHdPNYu2nWYK8PpxIFIh/RywHIrnh6eHipHyu6?=
 =?us-ascii?Q?hxm6JQkt4BwHUZFBZAWaPkQ3YMv9ap/46U0RHH0t9l/wYs2ToHierCQfcRZR?=
 =?us-ascii?Q?ekJLypYjxrJLrUWbOjiEMbOcmqYVbuJnLIgk60CKBGrrU67h2tIbGtqS3kCw?=
 =?us-ascii?Q?utRxvW0Ai3hh8ErWr+fYCtaLCnsaqkCiM34VnCK2QSUFilshm+bzq3WJSmgg?=
 =?us-ascii?Q?q5QWiYYS7se/ue3cb5fss+Owr7KZ1RS1xkCzEfuoi1kWQvtCKya0HMUQ1v0J?=
 =?us-ascii?Q?bu1MkSz6r6xEyUowK7PYDBjGf+mtA3fc20fBeOSBFU0MSCNCrAtoxFnQPOUg?=
 =?us-ascii?Q?NgpBz5sEOX0BNuMY/H3VrCMgHC419cDi0pb1EmsS20jfekJwah+aiXC1J6Yh?=
 =?us-ascii?Q?+gxgfJKDEq9WhJlnipN+6nC+8HwSB770lv1/2YdmQp5ecirWAFt1rPxeAzQP?=
 =?us-ascii?Q?W/ASGa8PU+/3oZYpAwTn9bj8fGAlMJ4pLgrAJGQ2QwrH8W/JLw982EeIfVrc?=
 =?us-ascii?Q?wAzQPn3Dzf0tH78Bm5F2FZGdf7ZUMyDtF2keHwo9Ms7EiG1pASS+BqIOgowe?=
 =?us-ascii?Q?/vRbcG5kGEJQYXfwgn8L6u9x01qYwVv4aYpv6CUQQ1TaSY1FYHME+vO4h6qY?=
 =?us-ascii?Q?LtpaPRdzdG1CQ9DA3yWllKYBqTkG+01ZDMIDw+orkoQh8KtYCWt/9q89BtvJ?=
 =?us-ascii?Q?lx7QAEc0zKNe5rcdozS8e5jdFm0xFMMIyjbXob64V76ezyAcPTIgQjK8PfOo?=
 =?us-ascii?Q?Zq7jGkfHA+YmnHeU37Bjpt/Uk5iJUr1mMU2pROsXDBZKjb+GMYLSQbV0Mq3C?=
 =?us-ascii?Q?M+km/ayXIdEQ/FnjL4e1JrvA0fsL+iMhSLr9HdneZYaystTi6hhdpK9rIOI8?=
 =?us-ascii?Q?1Ayd01azf+gC3n+t58lXqc9RIdjg0QIeGFCuSmJH2AClbE2jldL0GPknyK5T?=
 =?us-ascii?Q?X+bKG3Y4UI+bAhSsLeVpS/p6ePs5bTKxswpQeakj4cdOEj91n+zvII8/ogDP?=
 =?us-ascii?Q?N69S4zs6I97XizuYNZlTGGUTLijyRHpW9/1eXhUBbFTjal6++RPm6eS2mPz4?=
 =?us-ascii?Q?zE6EQKtoGBH8yXsZy88f2Md9llUMX5jScL6IMHm091+bpi+adcOtL4loXD9G?=
 =?us-ascii?Q?41L9AncGJ1YbjrMELE7eqA7h/rQ4EP8dbgPZof4dIuWuK7oVVfOGkFjwlSFy?=
 =?us-ascii?Q?SUdX8P6isAhQQVjnE72PLfldjF+N6iZs4IBRRY2fU1n6imcJIQLYVayjeWiU?=
 =?us-ascii?Q?uWfy6/uqHbvT3ONTaoYVjhwBaGErbEuuHgjDv45twKWvdGTUrFVhtk/f4bJu?=
 =?us-ascii?Q?bLWt8TJSnWhRuJP8OZd61dGgKwdRG97HiIGyNlgC007gqzvPEslWxftBZ7z5?=
 =?us-ascii?Q?biuWN//L9IQOuzcyOM9iwpKXsoY/+MJ0CdwW5bE3p87ukbTShWZ/r7B3Uw1S?=
 =?us-ascii?Q?AVevxA6uLpszk9ch1SOeQRIWV4m7HV0utNcdr9yATeeTuhaSh/MXw6weJPCU?=
 =?us-ascii?Q?5ov/5dlnBUjTPhIJ0+zAD0RazIy+InKXuIEjnocp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18571ed5-363a-40f6-935a-08dcde655e3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:56:53.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkTSHBbRlI1jsGDgrz4fpI9NYDuZ0W1ZVxkTwFu75ZOkzJt2lStdBJ3g++aUq13f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Mon, Sep 16, 2024 at 05:18:02PM +0000, Suravee Suthikulpanit wrote:
> Also, the set_dte_entry() is used to program several DTE fields (e.g.
> stage1 table, stage2 table, domain id, and etc.), which is difficult
> to keep track with current implementation.
> 
> Therefore, separate logic for setting up the GCR3 Table Root Pointer,
> GIOV, GV, GLX, and GuestPagingMode into another helper function
> set_dte_gcr3_table().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++++-----------------
>  1 file changed, 65 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 48a721d10f06..12f27061680d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1947,17 +1947,58 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>  	return ret;
>  }
>  
> +static void set_dte_gcr3_table(struct amd_iommu *iommu,
> +			       struct iommu_dev_data *dev_data,
> +			       struct dev_table_entry *target)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	u64 tmp, gcr3;
> +
> +	if (!gcr3_info->gcr3_tbl)
> +		return;
> +
> +	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
> +		 __func__, dev_data->devid, gcr3_info->glx,
> +		 (unsigned long long)gcr3_info->gcr3_tbl);
> +
> +	tmp = gcr3_info->glx;
> +	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
> +	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
> +		target->data[0] |= DTE_FLAG_GIOV;

When does this get called to install a gcr3 table without a v2 domain?

Other than my remark on patch 5 this looks Ok to me and making a
helper function for the gcr3 case is a good step forward.

Suggest you follow up with helper functions for blocking, identity and
v1 as well :) Then it will be really easy to follow.

Thanks,
Jason
