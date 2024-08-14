Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836731BBBF2
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672374; cv=fail; b=AOnhatNWyMk4FCU1s7vNq+Hnzal9wiOJbW3eGILEzJZAu+4onf6r5z48hVrqcDry3OSLPfQ/6kaByx/8K/5Sy3Qm5tuzuurZGSJ3bEXfGYKuktNMiqtkyw7K0Gn+ua1zNZAkR4ZPmFWNyQQHfY646ZtZ438VO3YM2k7uf4Fgt/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672374; c=relaxed/simple;
	bh=2zj+a6t+rbnLQUCWLlNZ6cRff8V8wcoJNOgWQwlcEiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pj7NCDiPsWmLF3lGdWrW3yKiWrcxCZtlI/YLfctfnn7TPnbbBTk++ICHhydSnIttv+mYG2ZwzA2YZAyO9ocq3ODjHkE3GYLwuRHqbV68zNTW9u+4QcYqLN744oOcEhVyPWGUvSp61XCsqafTjOjLp9gkkl6jSNClH51E0GVhR+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ztn+gsk2; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ztn+gsk2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2KIaCLJNMxpNXE0M/GfJMAL64rYjCpsD/5ZaaPWhmn0yvxMkvTTHIz/DfzBzfVWWPiq3yfTl4IIvUhxZUaJYxa7O5R6+Lho1vXqION5tz2D9iKdidEG8wV2DuhCj8toK+XY1L83RbT42M88o5dxDe8PoYHHYB7zmqCMMPnkkj4i0Mt70BM2s4OC3PIH31X9g3jGaOSY7oawMPrAyi3uF7AMLlcNL5rE+C4/mv/lBSMznCBZI6ia4aih+7XsiupoUsNVayE3qVeeV7xeRnhokVDJKX5bsZcdTjiA7+QFEzBpUC1FRnV0HchiIj9UuK62qNtpUO8kss2ckubyy+jCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP9wTH1HP8yLuZJzoiYPjhQA6BkqxOal2woYoWelczI=;
 b=AMMB6IbEYB+SeeTRP43GZFC5QqMhKEg5dJf9i3hQJSNf19X8mPAvRuw2fuFv/w93WZ41sFn8TZLdOapIRCZJExLglme1kaBuR+GWP7NxU79sZr7VrnqgMuZ2zF6UnBjlPgWyF+zGUt7g/4aVw1wd57TDogdZhe56jvlb/+FWEYC80WNp560jyp9xNbwG59bFB3+/DEc6sN8Jg+lpLP6tOjH3bEZeiPO3wIzcbvZI4QarxuRZtaLYdoLVyGijG9UR/cllPVfkbwP722uUOrENmlkrj3reMy2rFHHjyDd1vJEACXOGyWHBj7TVILAThJ2OEMEpWldwSejp1BViqNPxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP9wTH1HP8yLuZJzoiYPjhQA6BkqxOal2woYoWelczI=;
 b=Ztn+gsk2/s2oTjdpaw49h4pqtkJFCOFm0tYhKIt4pYkUIMOAOdti8VJVnYSTx117iqLKW/c1XxKc7kz4xydm82+kxf6eL967ZhS8ckGZhwWmStHJCVtjazp1zpQikd31g/i7ckk8g0HOhif0gRXNpMOYNlXBlo2Ap7eztMvuqsQ2o/Wl77B2X5TJPd7dy+1Zp1uSFJJHVEJis4ePmSqX3Y0hcBI6of/gpPoymexElrF+2omTtExgMKjPUATAcU2EAA2jQsA+diR+xFDseH+Ut81KFxpaAy+RD3bd7fFpDLIoIH17hW5zYUnPtqYidAvAST5JTCJGAOojZgtC0LbNLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 21:52:48 +0000
Received: from DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52]) by DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 21:52:48 +0000
Date: Wed, 14 Aug 2024 18:52:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 7/9] iommu/arm-smmu-v3: Add struct arm_smmu_impl
Message-ID: <20240814215246.GX2032816@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <8f6fd78b4c4358e65e9d171d90aa4a3dac392f09.1722993435.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6fd78b4c4358e65e9d171d90aa4a3dac392f09.1722993435.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::27) To DM4PR12MB7767.namprd12.prod.outlook.com
 (2603:10b6:8:100::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7767:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 0579e5df-40c5-4faf-d077-08dcbcab6f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WOvbjB+N3znQRtI30EU2WRBssd4O4WlofQn+xIQ32kGC3vBN2M+qntQBKXFw?=
 =?us-ascii?Q?OT4ST5BLxBGN+aPcALgYM/+AfZfUaZaypep2kaoIESE1ezDV8iFqULO+UfN/?=
 =?us-ascii?Q?l/QB1OX2Bhii3uDtnBY49wgQrYJdJSm03aPNpZQs5uxMQ+3iR4xqCfDGxaC+?=
 =?us-ascii?Q?kNGZ1MF76GeUqOuvOGj7yyrc770eEIVhe4fOkj1F/SMuemsfnitDbedONzgD?=
 =?us-ascii?Q?vitEaWIpib+mBCrYQlI050C7LxpRRqReSDpW0ySurPWR8ryvhog+aEVkOCwQ?=
 =?us-ascii?Q?nPTlXVrMG2e+tGKhDTPyLkRV4DKd0O7IlCNTAMPOLS/dlv7IuRdKDFhhpQAT?=
 =?us-ascii?Q?chbGcAPwAn6hkt9OJWtoXD6LS63RYM5fqKZgxbEVquJ3jGDCPFCn+jjD2V7p?=
 =?us-ascii?Q?6f5nc/MOfHnuOwkyRIm6XJiimMv91nvoPrh/5Z8dFjpDEd3Zn+W/KsAXkNAh?=
 =?us-ascii?Q?tpxnz91Sf80H6nMWxiheYY5jHnBKgFcW7Mb2cge+kkgbpDQMXrIthTNETK9C?=
 =?us-ascii?Q?sTbTHen5wRkVvKA/taupvr8XUbJO5KXav1d6xlKw/mUENUjsKZ3yAoy0DAXN?=
 =?us-ascii?Q?cM5Kpe2BZ3r80LeYatM6XHiH2zVkcxVZGUaGjGhyJnRIpDkuawhImMOapaq3?=
 =?us-ascii?Q?arakmgYHF+7fCp9NPsqhD4g5A3z+03Cxw8c0h9rOTWAKe6yi3zTI5Wpj11E2?=
 =?us-ascii?Q?GAzXIQk/tFz1L6cxifmxOwqOQfBD7qcbbSXoHDiUtDZxlcHikoujj3hnBppJ?=
 =?us-ascii?Q?wUEeVkVefuMrzOw0BKqt1l1O2dbqUMpqfQmfGZQRFy7igr/oJWw4TnsvdlVK?=
 =?us-ascii?Q?DXwIhmJddkdLhxsi0VUvmYVsDxmGuSj04UayPB/4DlbAIUVUsyYWfGbp88y3?=
 =?us-ascii?Q?iAwS/d81Z0ytII7qt0ZfhYfPtTB7zZYjlNsWq5DQ1NzvP2DoJnkKrOKB831r?=
 =?us-ascii?Q?wj2gsRFe+/5WhPpRm9FAXrERhGiuPouNh1PmjQc5/cYgROTv6eU8sFNFd8F2?=
 =?us-ascii?Q?jLrK0skE945QB3CVuFSvPkaX9Lx6RjjoTw4ypfMKRHWMUfjyH2baZ4XWZLmz?=
 =?us-ascii?Q?MwaAJBnrA7FFNTODxQLtdXA69/djL7nIqxf0r2XWs02M/45taDjAjfxcsbR6?=
 =?us-ascii?Q?t5xue1YjsTYclDXW/XcVnLBDCO1t4YMzz75YAeSLcfPe3OEY1vQhpb971UaJ?=
 =?us-ascii?Q?5OayXI/GJd+eDgQdUnZCXj5EyUc/7H/dACKRJW4EMe3AkkzDgzEsWZ7wJgTf?=
 =?us-ascii?Q?R+k0FVc4W9/nvRELHHQQOveUH1no6YRv8Ogq2BcjpkYQhMwRKu+NyZxIn/Gd?=
 =?us-ascii?Q?iFGMkeh3PzPDU43Nwf41BUx2CtUrvi81KuPkXZfSCdwEhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCFPkf8LcdJDaj+5ZjoSdKDz2gDmAA+wxUiA/eUzzQgxoyzWvJElc8zrA2ZO?=
 =?us-ascii?Q?34sIX41DQxCYy4LEmpLHgYHi27HqmlJdXE4EtC4mgcnGYGC1eCNn0LBW5WZC?=
 =?us-ascii?Q?MjZFk2q/66+BknPgigZRYiG+/Fh3GEiOFuBhmlsV1uo9va1JCw0fZBrT4xv7?=
 =?us-ascii?Q?QCWbakd3rrNyGZWbBuhuFGaGPLBK2CAFrhtbSFTUwAwoY3g3E0LwiG7PC+QL?=
 =?us-ascii?Q?AyQj3fVC4GCir1HGhV/jNpA3FU0ATKwG5TvE0BdfIQXfobPQt5Qj/a3jRq8a?=
 =?us-ascii?Q?hYgcu03MhIWjECI/ZvV/ACUjO1r7TecQS77QyjTvQ1XqQp3hEfmym5NSMl68?=
 =?us-ascii?Q?FRtWxSGYnUuQStlOPkWcXTMLjuYQe6sqDuNdE1YmNs6tdr5xWQcPkrAfnD5v?=
 =?us-ascii?Q?zAIHs4jpGzkh+dDOrE2zX7LJaDD7TCs+DWBRGbQbXvcjnhzBbP/OtCuvkc0A?=
 =?us-ascii?Q?bL7tjc4zN977Zns7lzuAQlhnMhF1hfhdFf/TXUJbUAfP4sIcCQthB0BxgSFM?=
 =?us-ascii?Q?1S6gZ5cChzUST+u0QuHBmfULBP7THsZ/f49GiRYM7hDl8Uf4mATjd5Mqzc+w?=
 =?us-ascii?Q?gVHeY6J+DIof3fAxBPu4c9XTb3PyYW6jXIqqz8ZT2zL7+zcWcnrT6G1sA3fW?=
 =?us-ascii?Q?wIOVC03vHB4k+73mRl/dvFkCujah8aBTGN7AkNXnbtCf6QqzX8BgyvLiVlz2?=
 =?us-ascii?Q?Q7euSzU5FfmlXm/jWjTrS93lx06uEdD47Jwzh8Av4uVqrQfjCiq3EY3Tubhg?=
 =?us-ascii?Q?k4aripoZkSVZfUOYIPhPVMwgwkQ6sK75IDWhkHnR3gUR+qrPmtaf4a/fo10A?=
 =?us-ascii?Q?6/TphpBtGVSRwU3wAPP1RYcAvfzoHdxXBzE3MTWYXE7dweLE9FGjbFe2H8pA?=
 =?us-ascii?Q?RzCNs5x0Y15RHGkPZVDaMKNJpzBow8HyuTZRAl8i9r6j3LI7oTSiICbXMZu4?=
 =?us-ascii?Q?jVDWqHB31R3nm4qW4FsfaNuqIcd76WOMRAUce/wXcmJwwRnMBUNGbZ2iu9yg?=
 =?us-ascii?Q?3XBng+UI4SdXXyXK1UXZQRRC4IJ8pq5AteCDAVbLrcC2yq+3UDnuWhtoIuiI?=
 =?us-ascii?Q?zDDGXtXBkFZctc0LJ8Pws/wiwAoARkjdxvDOesiQ6BtZ45ylKaMy6ZZ0o2bh?=
 =?us-ascii?Q?YHuu2p3AZ0KXvfvOUaLjDw0o1PcMwsfJXKR4SquXuV87vTJtfQiZX2RPoCmq?=
 =?us-ascii?Q?xQ3e0M2OvrsNy3+AQbDLCImYXIaQZvN4243eTF0q4hmHSdH/GX8sP9Ombv19?=
 =?us-ascii?Q?AGzihu3ecZkEalTWyBVbQh8R5I3osmjQh+kHYXgeG10NeDrp4xU28VkCwpfa?=
 =?us-ascii?Q?ilpMN85/v8e3r/9Zu7uB5UgoYQHuvQrm0zHRxXDvlSgKFrz9A2/dJfT7382C?=
 =?us-ascii?Q?BPVJ/RYkchIxaHuKNGSk+SGx7rdsVlqOjQUdkgqSJwQI5t3SR/7M78b9JlKC?=
 =?us-ascii?Q?t9tDin+T+MmcvWpwG1Gi8wMnud/ywYnlYaNdUsy7y6ZQ2+DM4jgk97qHJmAY?=
 =?us-ascii?Q?i79rjTbgirs3lK0AeTngxkwiZqHIdlJF8GSpqdHr2dWAo+ZNra4R1uyF1xt5?=
 =?us-ascii?Q?1paXotkuaL1HxBpFRCg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0579e5df-40c5-4faf-d077-08dcbcab6f9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 21:52:47.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPOSKwfrsFbitB2Ro3FEGYuaXto2WqLevE9kPc/g9VQ06Q6Vxx7lYRJnj0JrDeNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812

On Tue, Aug 06, 2024 at 07:11:52PM -0700, Nicolin Chen wrote:
>  
> -static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> -				      struct arm_smmu_device *smmu)
> +static struct arm_smmu_device *
> +arm_smmu_impl_acpi_probe(struct arm_smmu_device *smmu,
> +			 struct acpi_iort_node *node)
> +{
> +	/*
> +	 * DSDT might hold some SMMU extension, so we have no option but to go
> +	 * through the ACPI tables unconditionally. On success, this returns a
> +	 * copy of smmu struct holding an impl pointer. Otherwise, an impl may
> +	 * choose to return an ERR_PTR as an error out, or to return the pass-
> +	 * in smmu pointer as a fallback to the standard SMMU.
> +	 */
> +	return arm_smmu_impl_acpi_dsdt_probe(smmu, node);
> +}

Lets generalize this a bit more and have the impl mechanism work for
DT too.. Keep the main probe the same and add a new function after the
dt/acpi steps:

	smmu = arm_smmu_probe_impl(smmu);
	if (IS_ERR(smmu))
		return PTR_ERR(smmu);

Which is more like:

/*
 * Probe all the compiled in implementations. Each one checks to see if it
 * matches this HW and if so returns a devm_krealloc'd arm_smmu_device which
 * replaces the callers. Otherwise the original is returned or ERR_PTR.
 *
 */
static struct arm_smmu_device *arm_smmu_probe_impl(struct arm_smmu_device *orig_smmu)
{
	struct arm_smmu_device *new_smmu;
	int ret;

	new_smmu = tegra241_cmdqv_acpi_dsdt_probe(orig_smmu);
	if (new_smmu != ERR_PTR(-ENODEV))
		goto out_new_impl;
	return orig_smmu;

out_new_impl:
	if (IS_ERR(new_smmu))
		return new_smmu;

	/* FIXME: check is this ordering OK during remove? */
	ret = devm_add_action_or_reset(new_smmu->dev, arm_smmu_impl_remove,
				       new_smmu);
	if (ret)
		return ERR_PTR(ret);
	return new_smmu;
}

Easy to add new sub implementations. Provide an inline ENODEV sub in
the header file for tegra241_cmdqv_acpi_dsdt_probe

Add something like this to the header to get the ACPI node:

static inline struct acpi_iort_node *
arm_smmu_get_iort_node(struct arm_smmu_device *smmu)
{
	return *(struct acpi_iort_node **)dev_get_platdata(smmu->dev);
}

Since it isn't passed down

> @@ -4560,6 +4602,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
>  {
>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>  
> +	arm_smmu_impl_remove(smmu);

Can't call this if devm has been used to set it up, and this would be
in the wrong order anyhow. Just remove it.. I guess the devm was put
for this to avoid adding goto error unwind to probe?


> +struct arm_smmu_impl {
> +	int (*device_reset)(struct arm_smmu_device *smmu);
> +	void (*device_remove)(struct arm_smmu_device *smmu);
> +	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
> +};

Can we put the word "ops" into this struct somehow? That would be a
more typically kernely name.

arm_smmu_impl_ops perhaps?

>  struct arm_smmu_device {
>  	struct device			*dev;
> +	/* An SMMUv3 implementation */

The comment is self explanatory

Jason
