Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13A1E0E01
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128884; cv=fail; b=Sq5X1GwAjeqfEhYL8DeK1Z0v6+WMi0KiGOF1ZI0HOOYkiaDvZsLy1McV3d/vdwQ15mfePGECz0rskBESK8EtSE05QQtyCMHcGuIq3cDWusDZipl+RovtZ65ROUukULgHVWLpeDDYe+niUrQSl+k6FH6heU0EdGq3lQdicnLYlDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128884; c=relaxed/simple;
	bh=TjH3023wje6FvjH0XArPWoRr20pgy2peVYkAtSlhNgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HUFHRNhRjmLPpCf8s4EAFuq1Fw/u42NmtWCJQBMNU579HI7MU8bYkaiH6jt9fXGXSAsK48SJUdg3IxBoqAnTGcSPQhKcjevmkDt3ZdwWusCH+O4WBelt2jQw80HWnacv4APCdJiP30cAtcrqy4s3OCTk0Wqj+/eBNhH3MWK5iDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kYNS5G/o; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYNS5G/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYEK9f2zl2PTkV+c3JYv07HiLYGBCVJG82mwV9wH4ZWpL5DmyxEG6zqaPMw25KRto4TNbMBUWzbnU7XxehScavC8Apxo0gfVsVTQ2rp6BJlo/VghqeRbu1GhZdIBd7Qr5+jAYbHnra0DoiBG94BcLjCcqJW0cD71RHOLTpertgOY+EO54ntSNXVZv74lSeNPdnFUQqjM5VGLqPlQgu+TcpdfRdSk1a3PUfQ2W/tSswwggSttTZlt+0NrujOykgWxluACQTugr5IHLezt8nqyUsgjAH4boAIltwFjVtzOW8XW7Dr4hrRnCqO0g/pGpUwrxLLr9CjgvIIXLV4VTkMRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLUm+tjBf/b5M34mbMWpPPE+C3PjkDJS4BNYGL4lMl8=;
 b=vzkEqCS4r+nkJ2uzgFu6oEMHaLW0qceU+vZcLbodDzCfaj6HdV29NT0fBHYfsGfjnXlxXi60v5Ua+EV+YDLLXK0voUZkaVRRStBy7Aoah1o1SEvtc629yrnbeZ/Ng9fcDQE2vO3isaxUgXxUPgKkcVuF+m7cJHoerSj3w361akknmS1GqelNSy/Jomb9lFcvLTmqUqxsJX/j89t1c3FFEiWy8TR5L7TZjFC1odRTsL/dpfHn4L+ntSKyskUoHNQDDZNawp8QeW0DSvApCZK/C4G99DNjfQ4RRaR5MiC1Y9S0D1/xn8ZrwczOoEu9dxxI1PviOnMCPfaMaOBeK0z+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLUm+tjBf/b5M34mbMWpPPE+C3PjkDJS4BNYGL4lMl8=;
 b=kYNS5G/ow/NpvBq+hxV7HT3DZ+POtCGf1Gw8CqkslXH0AAAYVDT56SGpsmfZR/ZA8tHa1No5EzwY2XhHdQ/dMAfGecP5QQtzQQ/a0gxuLe3HDRgRHbLxvjafjhRA4yj0zIdqF3glPfUKI3sEamkwG0RNRyl/fuF+5t9AbgdAA3k9rN22etYMeIHYbTi7dQHFi8zUhfxHgG2ojVej6uKJSTgivJ/IAXar4KbOl5v0xLRpfuY2Bafam4Uts0egtRPbh+lS1Aq5zGsKE3cJo1hFn5bkZ7BN0qifLJhbbfrITEzFTUZ9lh+TyXIx0ycq6qMulN2xMJERMq5FKU6XVolk8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 16:14:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Tue, 8 Apr 2025
 16:14:38 +0000
Date: Tue, 8 Apr 2025 13:14:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	robin.murphy@arm.com, joro@8bytes.org, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc v2] iommu/tegra241-cmdqv: Fix warnings due to
 dmam_free_coherent()
Message-ID: <20250408161437.GF1778492@nvidia.com>
References: <20250407201908.172225-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407201908.172225-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0407.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd7c2c9-3ec0-417d-38b6-08dd76b87632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KUTTmu0urGoQa6UVrTXIgB7sj8iMQQO5FpYSIi7AHBnq8sNQA35+tjdGg6/k?=
 =?us-ascii?Q?h22SOdU2NyuuYnh2filXHs6Jn1tbOpZa/LYNjCYfF77P7w406s4NWUm1D18I?=
 =?us-ascii?Q?/kt3OXWzKuunMGY8630i0jbZYleHsWsJkas/jtZ8EAAnA3wr6dlkR64/Ngrm?=
 =?us-ascii?Q?ifQcyZ223lB9If6KRyNXxVhPVtEqkD3JRgBqFQFy6NmQML7EVxgFTjrvVm0j?=
 =?us-ascii?Q?D7LoTf2XH9/ObtSOO5wkjlrKz3H6rGsWLqoJ+Ouziqg7lckOrXoc4epRx45Y?=
 =?us-ascii?Q?29ozfFYLLdKYSldiKbQdJTzUdQRmU3ODzRZGUAy7REGMBUWHreUCzufeWvVx?=
 =?us-ascii?Q?GcD6KknhQZwhceUTee8jD5a86WEs5HMo7jgiYvn6BsRcvbHwXA00LOQpLw4G?=
 =?us-ascii?Q?tlCpg0i0XXQvs9jRbN0uEAL+tCOSrfvXiItrR/knnc3e7M3/DT3yf2H0R6sO?=
 =?us-ascii?Q?ovtjMAQo4icrnuxuuu3scpvPMJp2/XyulMATjaVpNXJg+XdQKUllvTx5/ngp?=
 =?us-ascii?Q?1kZA7QRgrTbZP9z/xaQg3F7bJ82rCeQnRVRSBy2Jirxt0GwXC+NVuAXusTjY?=
 =?us-ascii?Q?pPSn8rtbaeqNgfOTBmmNbaD36d9LxhlrBoEwdSwkIfgTbGMpjWwWcyX0SSYS?=
 =?us-ascii?Q?u31H2J1d0MfM8q7QlblJN7TDxdY8/KX7510WO83rPpL3rNKI9T42TpdphKot?=
 =?us-ascii?Q?lBGraZy146WVMeWyV+STR7SF02FqBPZVwjSQ2fFXIqfuOCP39qDKCY/5tn9G?=
 =?us-ascii?Q?9znZiu85wH2Z4sIFSk9pmofgClV/4r9ctJ7KPHTEneCMx9VZYgvO4RAaVrIj?=
 =?us-ascii?Q?vCsXtg5jLLFbEpJ0ItXzcRMXoJ9n8dQgsGzNAnBnYQMMfnqRHkKBVC6u6/1T?=
 =?us-ascii?Q?CkDrvPe/7SXOxof7/UaT5V+DO2XwvmssKsK0NssBBHsKPXYMQ4j2LfIJyBpy?=
 =?us-ascii?Q?AKSy+8KR8G6ngztPFqycRIkeWSqnx4bocE44t683mbqSe5/euNJjFD5uvW7b?=
 =?us-ascii?Q?M7AsggCQ4l1LcLpvQ0CXzzwKALbhX3NxSCWpb/+55jbYn38sA7SWB6UQppnW?=
 =?us-ascii?Q?jyA2boBLfG+S6kf+Wlot0UKANhg8igWWtZqPDOFYRpE7RRZ36svcSPB+Y84U?=
 =?us-ascii?Q?7widY6Ush89PQq5ZVF8rTxZdxG8XhqZFcp7RajQ/HGDYqUtnfMy0BWMEJ2W5?=
 =?us-ascii?Q?0ye5posCpyNss9iielg+PQDgitHWKaQUxdC78iao1kVq7zajz3MG4EbrVt/N?=
 =?us-ascii?Q?S1DjacRqh6L0YFqmIDntKte1ziRqgOUQRMQvnnfB7xr/RfwQjQ/SyJmysfkw?=
 =?us-ascii?Q?V4yNmfW68L5VPIBuN/7OCtbMvXiO40zqUKLDhIv9CaSOc5utP+aRZynW/y0n?=
 =?us-ascii?Q?ICGAu6JU3y2CXvMl5ococ0xVmmTw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hdrYhvYQJieNSb9r/QfsTuJVrMpl6NefXdIlxWJ7P5ryktrTWKm+cHqcJtl?=
 =?us-ascii?Q?y3NBfwMj2BDy4GPoIhSJ82idGgoYz2k4vpMwpO0RIXf5rtPIqyhfS3L6Z2cT?=
 =?us-ascii?Q?J/lhgU0PLBG1MzGd/B0K54+oiSodH8aahRFlLv7DcMpsWl9BRPyBavW8Tidx?=
 =?us-ascii?Q?ZJtfssQq8R0dcaXaRA5G+v64PetYAKicT9qHg4BClBIzfQBQW5Y9jrewjAs0?=
 =?us-ascii?Q?pzwTKnQWhCTnHiJV0CPPj/o5QjD2SJA03klmqp3GiLwfapeTq4+X27ufeq0T?=
 =?us-ascii?Q?+/7I2UnPgGURN2l2i+P4YyNECmfr+dFxvKZzKRsTRfKEMR6DZlsdV8l85Xf4?=
 =?us-ascii?Q?U5HvuProQBeylDe7vkqTUtUvLKg+VXaGHpWhyx7/BbuxR69Fii5N8X29g+2R?=
 =?us-ascii?Q?tN2SxEn1rQU6Hkp5dShsp9SRCEEeI0/DQ9vjzTtzkRErLy+fqYOVqSStadFT?=
 =?us-ascii?Q?xt5Urcozqln3mj8ZeAzHGaaqdREhzjYsg45mGk+ljwqh8iA5VdDHZo/xDpAE?=
 =?us-ascii?Q?XV79y6LVBZPWLWuCmzzgR2TEJOv/qBVAWEOoYttlYXQJ1hVdMqwhT1Eo5R3Q?=
 =?us-ascii?Q?rQWrJlrPxvU4Vr0/1R5k6eoR80V4RtbDfSgwlANgzq6t3Ag9b4a4QAByRCXK?=
 =?us-ascii?Q?1U3mex3EwTLKyOB36atQP1EihNfHSD7gFcysGLaRC96Qn9UbbPQoRk1IhpuN?=
 =?us-ascii?Q?FXsOfrUJx4664DdigzBZes+uYJTufpGRnRma5FrMOWfvX85rx9041+nLiDFC?=
 =?us-ascii?Q?5u1pgsuKMWV+Fh0z9swgIWnuqGN0WvAHqc9ZOYw7TTlo6pk9U5lNGn5pVUDX?=
 =?us-ascii?Q?broa5R6bLJq9yppaRJq6rmiHimjSv4eF40gPu1BpddpjUnVc8PE60rJehcSi?=
 =?us-ascii?Q?K/V4U5sbfDyRosNH6n0/RY51D6gLgcTDdLUybAHOVAyETvxaD1v+b/kK8j33?=
 =?us-ascii?Q?Kv9DRc2nAygL2d3a2BaiT2q4QJ2V0y5PaxaAsgiteDx5xKMAWGdX/oG7jVLS?=
 =?us-ascii?Q?TjE8kCqu0uqTcA6p/7h4vkHZ8ufVb3VIMRxSYzYjWLtwpxs8VS2MYJNClewf?=
 =?us-ascii?Q?sAIHCEU9JCC5FCXYFmE6HQjJirE1Hu+6UHesCUcoe7R6s7gkuRc6+rzl/mN4?=
 =?us-ascii?Q?iTR1xb+bs9vuKGP/LJnNuLUxMNxrQH5+qcyabd+2orkqJAj6LYw8NoKcyWxV?=
 =?us-ascii?Q?VFxnMhIITzbZvetk655yuF/Ku7ll0kg2JvvsrNjkFUZqmCkpYyZkUd+LtvUH?=
 =?us-ascii?Q?zD0x1HPXnhJZ0YTsCRAfzxSuK9sLBV4UfLW0eyZwOAq/jrz479FZ+8h1fFwS?=
 =?us-ascii?Q?p/P9cGTFcW9gpadQ/YirXaq9XgvPdfC3reQGUzBqtWIwkZMWc1DHK86pB3GL?=
 =?us-ascii?Q?PL6eQ4ESeTMx07IgR+0eHLkOjnWqZlhVvuFQ8YcfSFCGRwVjwGu37a54hJUx?=
 =?us-ascii?Q?nUHuQpL109Vz6lA6Z4ANFZLNA85xZxF2Mugbtksz5CvuSPFI4FheS8fQwbtK?=
 =?us-ascii?Q?1KfGxw91sVjTxASfQ3fMDxtNNNdMx7QbyHtHlpaKh/+yaYNblAIbC/hE2qTM?=
 =?us-ascii?Q?Vp7Qmt9W1a0nE4MnfalocRMz3sDC/RqpBWB1nPK/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd7c2c9-3ec0-417d-38b6-08dd76b87632
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:14:38.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fmlkG6HRRsI/h2sObPFyrCwQLRiyuaNOp4TEtyGdFu7p39jzQ0KtNFoXXl+MSKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303

On Mon, Apr 07, 2025 at 01:19:08PM -0700, Nicolin Chen wrote:
> Two WARNINGs are observed when SMMU driver rolls back upon failure:
>  arm-smmu-v3.9.auto: Failed to register iommu
>  arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
>  ------------[ cut here ]------------
>  WARNING: CPU: 5 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0xc0/0xd8
>  Call trace:
>   dmam_free_coherent+0xc0/0xd8 (P)
>   tegra241_vintf_free_lvcmdq+0x74/0x188
>   tegra241_cmdqv_remove_vintf+0x60/0x148
>   tegra241_cmdqv_remove+0x48/0xc8
>   arm_smmu_impl_remove+0x28/0x60
>   devm_action_release+0x1c/0x40
>  ------------[ cut here ]------------
>  128 pages are still in use!
>  WARNING: CPU: 16 PID: 1 at mm/page_alloc.c:6902 free_contig_range+0x18c/0x1c8
>  Call trace:
>   free_contig_range+0x18c/0x1c8 (P)
>   cma_release+0x154/0x2f0
>   dma_free_contiguous+0x38/0xa0
>   dma_direct_free+0x10c/0x248
>   dma_free_attrs+0x100/0x290
>   dmam_free_coherent+0x78/0xd8
>   tegra241_vintf_free_lvcmdq+0x74/0x160
>   tegra241_cmdqv_remove+0x98/0x198
>   arm_smmu_impl_remove+0x28/0x60
>   devm_action_release+0x1c/0x40
> 
> This is because the LVCMDQ queue memory are managed by devres, while that
> dmam_free_coherent() is called in the context of devm_action_release().

> Jason pointed out that "arm_smmu_impl_probe() has mis-ordered the devres
> callbacks if ops->device_remove() is going to be manually freeing things
> that probe allocated":
> https://lore.kernel.org/linux-iommu/20250407174408.GB1722458@nvidia.com/
> 
> In fact, tegra241_cmdqv_init_structures() only allocates memory resources
> which means any failure that it generates would be similar to -ENOMEM, so
> there is no point in having that "falling back to standard SMMU" routine,
> as the standard SMMU would likely fail to allocate memory too.
> 
> Remove the unwind part in tegra241_cmdqv_init_structures(), and return a
> proper error code to ask SMMU driver to call tegra241_cmdqv_remove() via
> impl_ops->device_remove(). Then, drop tegra241_vintf_free_lvcmdq() since
> devres will take care of that.
> 
> Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v2
>  * Fail tegra241_cmdqv_init_structures() and let devres take care of the
>    lvcmdq queue memory space
> v1
>  https://lore.kernel.org/all/cover.1744014481.git.nicolinc@nvidia.com/
> 
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 32 +++----------------
>  1 file changed, 5 insertions(+), 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
