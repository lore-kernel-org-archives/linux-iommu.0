Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415E27BF7C
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137746; cv=fail; b=qnVSeJX9U5tp3LDNO6C3DY7STqLFZ9yyFfPvWkzBoc+Jf+pfJfmarj5vbNS/7FI9niQ8dVLYD84inHhrINUAOn1Qx09HJUMsIU4o90toBC2af2d56aJB+zfUMfaRWAhD8zu4vaYHPtJ91J9gVxI5AelOEscpsf2p4vcp0b6DsQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137746; c=relaxed/simple;
	bh=u2wTRHElMg9ahLF3jpnI/YTKbQ8ggkT8Or9seWFpoxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQGZ5DoG2L3VOLWFjfTC2Sqgjal9GlE4YAVOVeHnrEECdMLXT77p2W8tm551V/0tw+1mPdgm7qTyl5EWNafxVwtE1ZiOdpFlEAkPx7Z6q95U+H4JnQZtu3kmzi6aJxJUPYprOjTPCTZB2HfY8XbUt42Qlrr1iChHyZVAdFfjUbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQrun56g; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQrun56g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euxIQLz9rGiDdcletuvEjV8dKeyjeKG6wzWNxXY2W/ZlZE+eTjdxYF8yFUHSaDAM2uC2rfQfrQ/2z1kBLtPNOQISZ/xdm77a9C4XdK4E2ueJW9dgejktAzBf0b/FNqhRl5JJuIBcdQhsTmpMD7gfdz1u0sbJ0vvp0Kf43KKIS3QCCR56yWUadc5bQC6vT9anNneaHzRN6+NnunBwyuwaEL0lRpPenBcAdLQAVuGpXjJ885R52QRlmyd6qugSX1I5cb5/FDNUdOsdso0akYxF4kQoiQrriMTe0Z1q0lJd8HG9670SnqRTCoVmNdGKBszzXORLsoYQ4kPYhxaFcMt2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKO7XyVJmWHWHwXt2Ih6rnPhnqYa155J98uiY7H3Iro=;
 b=wbBVCQCQ1O7D1yYeWkhBVwS47AC/oDV7bwD7ZwVSAEkz24njm2P1sN6GtxK0O0e+5WP5jBrKLMB+oVXvJeKb8CW2aHI2lr0Hz2fzWyIbHepqKDstydFqvAcDF2IAjK08ChzoA9sQH2y4SowVvvKyYUK1Y8t7Ru5YnBACmFe0WirdugHawrkZEBh4GTn2JRKAAhOtzCUkCZocno5bvJl7DTzF5em03XO3Y4UhYVB9Q/9LSGq7KVNUangGiB9bbBPXl4i8xs0afKBU4Ycj9UFlbeIQPdTqDUxovpTi5HnHEBOKixj8DPNrIARlrIC1gn4etfzwJQqDbpbsv4/i0HNgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKO7XyVJmWHWHwXt2Ih6rnPhnqYa155J98uiY7H3Iro=;
 b=GQrun56gleFNzWPFJAoTno/b74zj2y4ZZ5EnjSYbrFuRbK86Oa8xqwSK6GbGhNURYBi65RnVz+WrfeXloLQZPGLF4+mqRl5p3iKbuC+bFDmYyG7Tx0oZIg6jRphCaJY6SewRNKsZFSoV09dgjkDTUWMO/MFcewg9FboX6UPDiAY/CpyjhAzpuWh78Uiz5hnMP4Zbc+vi9P4hWTZjU5B5YPIMP9ipIV74Lxr76ME8queOrgnAHqvC85yVzqoFWC5tgUXb75js1yb48UqL75x5Ysj1U06HMafQLMapesuviaCyWGQPC6cyQh+tfuJMof1ttxxYMaqPHck3JozMnx/O9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 23:09:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 23:09:01 +0000
Date: Fri, 10 Oct 2025 20:09:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 14/15] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251010230900.GO3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-15-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-15-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0441.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fef6d6a-d651-4f51-f005-08de0851fff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nj1Szs2NkV8poW+rN06t51OfRDCtPd0MNKYGpPIEdeB5aZ5C7UFDg0rDkagG?=
 =?us-ascii?Q?jRwoLZe/p8v3Gs8tKf256FEJZ269nbdKcuECNkiaEfuRNKSXAo/qB5cEzS+P?=
 =?us-ascii?Q?ayCxB34NPCrte602x3bfzyQxyMRzy2h4CdAZl0JoG+mMNzDqigkJAo6r+ZJI?=
 =?us-ascii?Q?7H8mioe9Y4IlLDlQH8c5DA51SpCGASySgFryqpRAM74AMBBNcSd80c65l6ru?=
 =?us-ascii?Q?zkUMNVqu2sLHWFSRmAnGF/8bktG1DNjAN9qN70H50M3WBbfbSWjXakRkJkGc?=
 =?us-ascii?Q?h+Ma8sTB6gOJ4X2j1J9JDnhsRFAImOcqnxOhlbMhLR4tjLGA7byeWX8Y6RoO?=
 =?us-ascii?Q?eSLSrUhu5gp8KhpNb8CfthpgbVqivj1gksOF+zuGDr/URFWcv2YoarcVw1SW?=
 =?us-ascii?Q?G3mvF6P4Waksy6mipjsYxz69SDTXM/ISN5DitoUTtHaY3Dr7l7N+4apk9RIA?=
 =?us-ascii?Q?jYf1HbmUJKlp0+I+E+WBsFnDyYM1dbP4SFLy2NcKcOcCLIn1Hcb99F7Bj4fo?=
 =?us-ascii?Q?Rw+xXIYa8D8H6vGHDlDrlezPCjQZkySItwYfCYUZFChmjDAszDJT5peJUTKJ?=
 =?us-ascii?Q?slkNKw+UpA3v2k1a4SOjMIEvtKncHdhIWZXYf+Sr26E8AgInlliHR6wJHhbs?=
 =?us-ascii?Q?PYzppCiuGNUftQjTUCKZldHkghJmhlyHZX64b6n9d87X9ZmrDH/lQDoVSg+M?=
 =?us-ascii?Q?m4aNGUiEU8gmhwit2Mnv9Pc0EllEOVTl0zlGK/S8R3rP/mvh4lpUWrYGguAQ?=
 =?us-ascii?Q?mdqnQE7+Z85U4AkDHFrijsfYeyBHEBNXjaTYodoDaOxGOvUtlCnPGGaciF3v?=
 =?us-ascii?Q?oUmpstTh25k/CcJdg2hRf3XDBzfjClhpFeJ2ZkDxbQakQThWE7A/0CP/8f0c?=
 =?us-ascii?Q?NyHFMMTTpw62DtFK32hqctuQbPkG7PjRwoVleEJEfz5UB30D7eZM3taqfiTd?=
 =?us-ascii?Q?6kKDHdMtXjIQP9/DbzlkwMOyutaZFTTHfAbYWLEUePnk3l+8qwo1iXDJyCtt?=
 =?us-ascii?Q?gHgHggeq6N2WIG9JPZVtOPSAyCwpxxUQLlo5pPZmIO9ppA8Zr6Acjx2Pz2vF?=
 =?us-ascii?Q?RpcxLQqoB7yh4HbZo1JpBDPtQPC+dzQVytGiX6FhfMUZWoqWZWmgYdEUziDo?=
 =?us-ascii?Q?88TuHI9Halgz0mc1Jkchec21SxjU0ZmkYa/5U6hRYwH58mD7PMePfN1hzSLc?=
 =?us-ascii?Q?nEVFLg44pz2sibbO7LmI8VMUz+g4J6ic2AfhBQJy+Rka+c1ZEZzJTnycEzDD?=
 =?us-ascii?Q?KbyEuAL7hhwH0voEOzjTquXtI6WclgLpu17QNqY74NwynrMhSahmuwtEkdNp?=
 =?us-ascii?Q?iCXmbJI7DMJ1UIl3gr0igkcaENCrkFXOTJMVo3sXFTf/GXcHdR5bcVzXHOru?=
 =?us-ascii?Q?XNwOwQxaotsK+6wa0MSJWvzyvGAVYDEKf4RBF0jEshWm0olV9Vc4ic7wjhrq?=
 =?us-ascii?Q?HRBgLFkUluVf2LMi8GgOkx9fKaHFWCWN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7KqpV5k7AnI1KcySGxC+DpkgfQKBaHL3ARRfuVFjszU/dCzjSd4ASCsdkJTP?=
 =?us-ascii?Q?Zpz9sXik1X0FaF3UMsfKpfZfNRpA1/5GFRyJ+X6SmAxFGnU4FXYeEYvVgnDj?=
 =?us-ascii?Q?e23zei4FGt3BL/uX6MGsdVHljdW4voBKJjQYFu2x8olf8VF8lb6AOmRIH3Sm?=
 =?us-ascii?Q?RVcUU9DBKtJKNu3CvbqZvMh4pcoAT7tVXVN8cz2AMfP65q3FpO5I/IQv+oSQ?=
 =?us-ascii?Q?yVxMVfh8oFImDhVVi9AScU4ZefKr5GGIOByXpu3t/8FK8K80XNhWAVRoEI4w?=
 =?us-ascii?Q?iQGbzKs4Yk4tYG5UJmKy4mcAfsmsKQX6oNqvvKaytFafogE3M3+7xyfipjTA?=
 =?us-ascii?Q?5XJdJSftTSOxmOMHqBlI+QVSFPCaHihp+PgN+YFcPtziRCjH1rOneDQ3uyau?=
 =?us-ascii?Q?jh+ycrq0DhQTH00cWp5DamSPhxV5Eay01M+bO0yj3WyoeXIfrJQr0dTyg9yP?=
 =?us-ascii?Q?LHzJgQ1mf5SHdq/xYbsCeAP1+nw1SpWqPfsmh9s7FuqLS6KuTP0GsO3ouwiG?=
 =?us-ascii?Q?X6Zw2mfWazPgzXv019B12jXez2Ng19LpXIkkrXyw3aujEgDmLPog1kjKKUTN?=
 =?us-ascii?Q?gowelacWIoUN0ilFMWLX3uvN2uQaYj0O5IwY0nwDse0GmRMeDmDOXKp8U4j2?=
 =?us-ascii?Q?TM3rb6F5GLYIWV/lNFT75M/FV8zK7hU4UaU5uLiom3+K5wCvZ/JVip2qxCQx?=
 =?us-ascii?Q?OcW2nRSdZKVKXtViex83cS7hor37NxVzLCe6qUy8DG2ayhJkARDDpFbrLPwg?=
 =?us-ascii?Q?SQG8Fv0q+A36y8Uz7L+9sCxFDX+5ECr//zlH8uuvsbh6IywVrC9fCUsOQRaW?=
 =?us-ascii?Q?kbwF4iX0ON1zwLW0ttqW/8p3HUeLLA+L64+FiFRYWdE9ucuGCNP+JM90Kmdl?=
 =?us-ascii?Q?jt2GFiWfl6Maiak4OeMpjqWlDUEHJY+EuAtXN3OEOQkPpE15qdxyeLTR41tB?=
 =?us-ascii?Q?j0Z7Uf2nfb5PLNrhojcpRd82KOtazNgVLMM3gGxEa4xixbV1CK5UmvMTzbcU?=
 =?us-ascii?Q?DujU4chTxDqhWM13H7l7oK2qzUvRFkrmonYjSrSIbmEGCQcVi0gfVtabCedl?=
 =?us-ascii?Q?DdTwNEiEqWBWu2RcuJjRdUONdyV00U3Y0l0LEb+Sqp4/bZaiJzsjF1xXgUVJ?=
 =?us-ascii?Q?qpsRT427TI6bQxES8IcgJHfRf8MX8xGXSh6GDtRbBhZnI9bcn18VlckNc4mr?=
 =?us-ascii?Q?S1PvFoiWIMy49E2Jy/fV83mBjtXtQy/LsV3T1Cl4s3W0ZLrSMjEUwAEmeuih?=
 =?us-ascii?Q?dJ2ydWq0J4R45aiNl0UbZ4qCCXCy52mtia94gBobhwwEH2OxOiEGH21sMXZd?=
 =?us-ascii?Q?l+ViNFJBe/1xX1Ky3h+3RwwOGOUCdr80K+PendcbBwtenO2GL5coa4L8Q8J4?=
 =?us-ascii?Q?dfaghucMfiIpf1RsKZfs28SrZ40V3FVzwk/RxFunWdM+/RnWpB5Xkfp4VQ3T?=
 =?us-ascii?Q?ZKjddsUxngmYT7fU+YeephsUSDo9Ctb9MNwJ+ap7rDO8Ik4AHHZGcZXNwiqJ?=
 =?us-ascii?Q?lFPhmGsIDsGMaau7RAIvmuLvpTGtCZptIxj0CXHSgWaEzjoCS/D0Ij+wAFb4?=
 =?us-ascii?Q?BSf5oVNdcJp0Sb07lqY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fef6d6a-d651-4f51-f005-08de0851fff3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 23:09:01.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdcMEVp9mYGGdTQWI+gAAjwKtBgdqM5/rCHUOADfif6ROByT1IClnH7J1molzC4O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

On Thu, Oct 09, 2025 at 11:57:54PM +0000, Suravee Suthikulpanit wrote:
> Introduce the set_dte_v1() helper function to configure IOMMU host (v1)
> page table into DTE.
> 
> There is no functional change.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 54 +++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ffb1adfd75c0..2a536d02aeab 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2044,6 +2044,32 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
>  		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
>  }
>  
> +static void set_dte_v1(struct iommu_dev_data *dev_data,
> +		       struct protection_domain *domain, u16 domid,
> +		       struct dev_table_entry *new)
> +{
> +	/*
> +	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
> +	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
> +	 * do_iommu_domain_alloc().
> +	 */
> +	WARN_ON(amd_iommu_snp_en && (domid == 0));
> +
> +	if (domain->iop.mode != PAGE_MODE_NONE)
> +		new->data[0] |= iommu_virt_to_phys(domain->iop.root);

Use a FIELD_PREP here too

> +	new->data[0] |= FIELD_PREP(DTE_MODE_MASK, domain->iop.mode);
> +	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
> +
> +	if (domain->dirty_tracking)
> +		new->data[0] |= DTE_FLAG_HAD;
> +
> +	if (dev_data->ats_enabled)
> +		new->data[1] |= DTE_FLAG_IOTLB;
> +
> +	new->data[1] |= domid;

  new->data[1] |= FIELD_PREP(DTE_DOMID_MASK, domid);

> @@ -2061,36 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  
>  	amd_iommu_make_clear_dte(dev_data, &new);
>  
> -	if (domain->iop.mode != PAGE_MODE_NONE)
> -		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
> -
> -	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
> -		    << DEV_ENTRY_MODE_SHIFT;
> -
> -	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
> +	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
>  
> -	/*
> -	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
> -	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
> -	 * do_iommu_domain_alloc().
> -	 */
> -	WARN_ON(amd_iommu_snp_en && (domid == 0));
> -	new.data[0] |= DTE_FLAG_TV;
> +	set_dte_v1(dev_data, domain, domid, &new);
> +	set_dte_gcr3_table(iommu, dev_data, &new);

This seems weird, I would expect this to be written:

if (gcr3_info && gcr3_info->gcr3_tbl)
	set_dte_gcr3_table(iommu, dev_data, &new);
else
	set_dte_v1(dev_data, domain, domid, &new);

It is nonsense to call both gcr3 and v1 in this function that does not
setup two stages.

So, I'd just put this code in both the v1 and gcr3 functions:

 +	new->data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
 +	if (dev_data->ats_enabled)
 +		new->data[1] |= DTE_FLAG_IOTLB;

(does IR/IW apply to GCR3?)

And then WARN_ON(domain->iop.mode != PAGE_MODE_NONE) as it should be
illegal to call set_dte_v1() on a domain that is not a v1 domain.

But this is overall the right idea and direction.

Jason
