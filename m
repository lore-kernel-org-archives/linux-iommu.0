Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518C2798EA
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136877; cv=fail; b=VGUUjpnOSA6szhVDcXbS0+gud/YEXwyHNdrrCsjojAyAEbY+uFZDQxiHV+gan0bJzLaFJXXgYRGuNGZx/5TEc+j49POsUIXA4CA5Vq0gYPKuFjcPGi/sigECMp8Nt9k1BmXA7FgK25i3gAwfSqKA2lmafSgE1T+JeIteTHJLwOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136877; c=relaxed/simple;
	bh=CuKEJ14Odv+4gbIofg5VkILCkrOdrptmgwtvLUfMoGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSQmN2u//QcQmNWBlS2KxkL5bgXnzwhVGB7EhUyGaLxjFR2AEOewvZ44M3upp41m3tHk4LtJFEoHAGxQn4fJHSIgk020zuWufyHLbiTQ4+vbOupshnsUaP/nudALbPusjxwIAXjgYa4bt/y2UpWP23aT9E0TkRJd8RZDEEZdYaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krJF0sZB; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krJF0sZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDvH7I4tSnZbHfD2yW78G6m5jNm4hsEbh85ZZ62vajTnAf0KCSFrk+p/TxO0E2GparqNVut6GVpck49HgT1e6ZA9G1tFsZF77ReeKBqg3QM1dkJCgPOre07QeZdRrXdeGAK5gHxaSwAlg3HpfLokvRcwXEIYX8A/GmYGDKBhBqjq1mjwXSnTdcemzHhF8QR0R2sZKTXNZk9DxN/jJ63CRtPHltS5e8WIHWUKNWM7nS8Xy7EhLLXqLoDEQ8+l1nZ7bvsvMPaN2Muf/iW1TBpWGpQCaXlnKbvKo6SEMRVfNmcqOooO2KfTO9Bq7Js3EGab9KfBg/o5Rob0pk5i5d0R2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9RYAyeQksevSFPLbyxiIIQtLaWUb4Jqls8xHCK6JCM=;
 b=Rq47FkHUkSyhK88dWUpUxx3uMyuIr9KPOt5akfOAMnhiECViUmvaQQyQhtpCGdQkv1UfCRqmzvMY5ZwvwaYsKMmAhmkjrdZigKPpIlZRGdV5WeYMyIulh93nLcm6/bWpnIUcB9EP9tmSUJ1DHr98olykebBQKK72LKwb0MEQhLrQakx/UcPAu4O7tcFVCk7/2iyR7axumZZkyg0paDAIys7k8t6KDCiwoUm7kmJOvFYy4LKPayKBcI6tHFBSndHDg/L5MsI1MovfbwCX7hgQ1q3aBsEMMCXPYqEN4VuaX1JCsdoSKw0uf8c/eMYcHjFGEtq3lFBiZA1iZ4k0piF3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9RYAyeQksevSFPLbyxiIIQtLaWUb4Jqls8xHCK6JCM=;
 b=krJF0sZBf0f2NhyisXO3NNbGfevD4rSlfPcLpe/mPAp2wP5b5KgraqeKRXJ+ZW7wauC51jiBsKL1f10YTKu6PaUFBkHuG7pU4KkEYdINH5XMmKSJuBjiG2TjzMuemVMSAqzKChSx5WRJsHrHlmZjc+lUJOemA6qVxT3bm49HzRi7UsWIdmwBSdsqo7aYJD4pDkwXUH8Oyk48VcpHSLWiVQ1mRMSsB1qehB8NvXyRzzoOcXfDWAht3Y5Xr1hXTqE36OqVHryuCGfWuJn1Wu1F5O/3alYxu6EdLCIlFfJWkMWG8mdv/K8hBtcgam/NhEOL1VDq8MRMVvO/Yjm4kwmO8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 22:54:33 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 22:54:32 +0000
Date: Fri, 10 Oct 2025 19:54:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v3 11/15] iommu/amd: Add support for nested domain
 allocation
Message-ID: <20251010225431.GL3901471@nvidia.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-12-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009235755.4497-12-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0629.namprd03.prod.outlook.com
 (2603:10b6:408:106::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 619ef864-056c-4b0c-e34e-08de084ffa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZogMfN8ELZyufrS1a7vDW2nZLyL2N2IKiAyp3zZzxUV+ffWou91I8wBXHuO?=
 =?us-ascii?Q?fnauRkcFqh/U5uFOQe2dWqBpqG8sClNyPJlC5Y21RAo7LGQ0AVLsDBuMv/Hl?=
 =?us-ascii?Q?zbTarwltN9jhsYvxOXljhIQjyib2PcKfUGScpLvlvbomHRXyHFZTkpY909rb?=
 =?us-ascii?Q?/rlEIOKzq11eyOkB+ev5DDWI9ukkCA63HNUkYD8A2El8PKzfU9wiKjzI7Kxm?=
 =?us-ascii?Q?JI/CU+eG3+23LwaLagnODlu6VcKzXzXZGZLz5Q8jroLmHensJRkn8X4Qbet7?=
 =?us-ascii?Q?VDllI3KWPJM6YlBriYpaE2aaukjfh2qWQI2lGELOQGTnl9mVEvcR5UWChqhS?=
 =?us-ascii?Q?se5Z9bPxp7X/n5m0vOJkEC2bU45tBNAL/eXEjm6SAhpnGX93FxeEvFGX84Ee?=
 =?us-ascii?Q?AOKUu/iEKGR6IEYMZOfjCznC4rDCdLMlGCFnSmL4VcqBJJGHrVl78GJQ5dyQ?=
 =?us-ascii?Q?7LYvy5zKeGeIMjkTZckla2De6pWASQ771qvTg5B85P5hhL02nYZDdp1FaYOg?=
 =?us-ascii?Q?pZZVVj5ZDk2JoxbvxUKwKbyHocHqNT1jsio0V5W4EVGlYleG5XM29miZxcTg?=
 =?us-ascii?Q?hmQphHbWz4NjaiS8NRdzLusq1N/jI9m2i6jK+Wch0JdQkdzTrsQAcUwD8aLg?=
 =?us-ascii?Q?hQvN305KxjsHzl0UL+gHn09ELYhjxfSefLQlDwpUHKaZgUDXMcorJ2IrQPvk?=
 =?us-ascii?Q?fGPbPV9V099ivcIHAbB0ARf8ugWGu2uN0cW5/s5bjHSkjqwDtZPkbULVioh/?=
 =?us-ascii?Q?j19f+lQz+6OboWHxokkcoYzT2QtKJgBxZ+CaBoMsZiJ0+FtHHnUaiS4bxqEy?=
 =?us-ascii?Q?Rsqo+7dHHSvfQDHv41bYL3iJcAUq0hFVCMqOYubozxucX5NrTo3xT0qO0wI6?=
 =?us-ascii?Q?4U/6PgHVFmYbEJzo+fg8rIqqQeZQzHbAh0TfJRPpCzv92VrlbzALWF5B/BKh?=
 =?us-ascii?Q?9X6Us6mRmXzNBV5/NYhWpiCOYQp5HDB1RwU1Yh/KfRCSDAbTopRjbxo8wwb1?=
 =?us-ascii?Q?aqa5n/iJCpO+GtIGOEWsqpZyuw89rH7/Nih6Rg58sb1117APojDIBFh7Qt96?=
 =?us-ascii?Q?MZJX5WXIG1mMPK4ZM7WQiyjqr7EpgR9l+qCOEdWLAjnzGsscQt33vMUEdYw/?=
 =?us-ascii?Q?Ph8qdsN65JIyMBrxblBkA/ZO2IbZv3jxdgkiVG8ZV82LxZx26vR7vvexpacM?=
 =?us-ascii?Q?fxVSbXne5UBQB6H0BAAdj3QEGdLzE1opFVtbcR2ZTclBE35MpLNkqjPaZDGm?=
 =?us-ascii?Q?mikaDkGsZsZi8iYWY7xo8iIGJ1B3pC2JykxVMZ77AtMCfgJCciYDHcXe0YI4?=
 =?us-ascii?Q?uoUNGoGWjEG5rKrkkpeVnpFkNYMvEt5yU7NFXFu/LtGUep3R74u8ybinifsM?=
 =?us-ascii?Q?jvxCbRx71UClvZ4ONEbk8WeE1mfZPTI2QSyh4AnTndVUZLUcN9dHrD0SZiCu?=
 =?us-ascii?Q?JTHoAhm+f/ZpRf0vpZCqi79RcX7lT4iH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLyb7HtB9CR2w4+4aZbghiMgDHh5sVXq+jQefg/5Dtv1VtZaFdgPi5o0c/ru?=
 =?us-ascii?Q?oqzM0z0Pn0fBeRlU8whHSCrAvs9CCx1395q9DY3cSAto8vfnaOJO3ByAGJhP?=
 =?us-ascii?Q?WQ5uM7a9T0NPW4Yc8LwRILVEUb6xQkuSqsWYNQWMpx0rckC8hr5JfZqVDca/?=
 =?us-ascii?Q?z8mE3YpQeBHYdHgGFYAw8+5tzJpMRPC64B/A/ookMuJoxXcMh1oA1P0E7oJr?=
 =?us-ascii?Q?wKsrLQnYNntBet5yIod3aMr718In9SkH3jTMO6cJfBQEpBy7fuoFyo1PXLMr?=
 =?us-ascii?Q?mo2LTVkFOUyPdqLcM1PO5vt6nSB1Pw5cIbEbX30KBd9yRK7fqb3k+dYIBIlu?=
 =?us-ascii?Q?2qnyxRyth7r3iYiOnz4I8YGZEPZN7or8zc7wYd/2eqGBcRM51FbnHXH4z/wS?=
 =?us-ascii?Q?oX358GVFtNRX4QoVYZ+oymqHG8bFatyj6HjOcdM9fs+Mt6/Uv+zOGdNCKXmB?=
 =?us-ascii?Q?DnGnSML49+YtdQnswwcGTdTtqIvOPxfdq+dRVOnaFC0mi5CEVU3Y0mxpfSvJ?=
 =?us-ascii?Q?EI4BVl+OkpAjHVY1t12W3QK/S9OtlFTHpP7rIjKYVT0ZQoEkdbc/2GZ34Wys?=
 =?us-ascii?Q?Sp/B6Kubl/dX2bfNV43vHuYGJcnaP69h1E9M7xCFfxQMkweBUzq0978Dl+R5?=
 =?us-ascii?Q?9ahGhYTYVldER5Xku2cscSowYA8FoGnYVTdD85VOma5CDXGYtdlzSlfrXjlv?=
 =?us-ascii?Q?Z1wq8FkyPt4h5R8FcPi8YgRe0JD5sX3/4WTvv1A3XRsG2wHc2LvAfNn6okwp?=
 =?us-ascii?Q?xRWkgbOxmaWXfXDBkqrFaVl+FvsTJq4V2Bjj3sH/btz7Gn02aFxkbbg4jYDI?=
 =?us-ascii?Q?BOlo5NmAE1xGJ/00p5zCMz/vnfaETaq6kvVSUf/OtJhD8DBe6bEvv7fyHkkJ?=
 =?us-ascii?Q?sfixqFRIEtxN1TNTf0L45XQ76PBdEAf6SFHrwWffqDffHXSpE4kON9yn8HHa?=
 =?us-ascii?Q?zEPFRhIQtLCAfjDYcmiRPE881oE1y9Zq3QO4rsqB5m2NFradad3vzdY00STq?=
 =?us-ascii?Q?fiSudbeJpQ99h4d4WUqbiGk6ZEngvYHZKkv5OJg2AtRwB506PqsQYnaL9AzL?=
 =?us-ascii?Q?Wq2gD5AGQM5eO2lKFjYpuanHghc98v+UESL/aSEKqeYV0SXvICjy2ts0kB8h?=
 =?us-ascii?Q?a0HcAVH7pRSHHR6djbHmjZpnNaYfEtiqdvpCBDvIWK/UAETPitazJlnYFnMZ?=
 =?us-ascii?Q?OxqCSmHB5MnFe1NXzQUAT2aoh6aHoEm7jGNy7pFYtSUnPQlylHmuyFc8WdEx?=
 =?us-ascii?Q?InEs0aVNagCcyaK2i702pnIDYRG5x0DecQf3EPy5HbaFYQYi1dP3PaAudA3i?=
 =?us-ascii?Q?lL9QyBvERJzfM+XoofLVo5wccyY4Nvq/gOc8AuWsvENuT2PhhGd6MnX5rhqx?=
 =?us-ascii?Q?igWDZFV0RbrYaMbSNiufmPywozFNe/ZmCz7dgz8bGHWDepyy77+cJI0HJ9Bv?=
 =?us-ascii?Q?52tc081/0mmmg4fmN5bGXcFV1QniOnVDpMZ/4XAhwQw5RBimswcyzfW/Sddo?=
 =?us-ascii?Q?YvHwhDOU4SVin/7vqMx2HhdJtGDd0eQXXJl5QJvjn07F4FaC0k1l0gQB+EUH?=
 =?us-ascii?Q?eoazGsE50EqQnSa7uGo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619ef864-056c-4b0c-e34e-08de084ffa44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 22:54:32.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpa7GAex8Niu089mi+xyISGZK0aJWD+j+MDoR/7bQ4c16Ev7ZHbNROSLiWW9uI6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On Thu, Oct 09, 2025 at 11:57:51PM +0000, Suravee Suthikulpanit wrote:

> +/*
> + * Structure defining one entry in the device table
> + */
> +struct dev_table_entry {
> +	union {

There is no longer a reason to move this, so these hunks can be dropped?

> +/*
> + * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
> + * during the call to struct iommu_ops.viommu_init().
> + */
> +struct iommu_domain *
> +amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
> +			      const struct iommu_user_data *user_data)
> +{
> +	int ret;
> +	struct iommu_hwpt_amd_guest gdte;
> +	struct nested_domain *ndom;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	ret = iommu_copy_struct_from_user(&gdte, user_data,
> +					  IOMMU_HWPT_DATA_AMD_GUEST,
> +					  dte);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
> +	if (!ndom)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ndom->domain.ops = &nested_domain_ops;
> +	ndom->domain.type = IOMMU_DOMAIN_NESTED;
> +	memcpy(&ndom->gdte, &gdte, sizeof(gdte));

You can move the iommu_copy_struct_from_user() to here and avoid this
memcpy and stack allocation.

> +	/*
> +	 * Normally, when a guest has multiple pass-through devices,
> +	 * the IOMMU driver setup DTEs with the same stage-2 table and
> +	 * use the same host domain ID (hDomId). In case of nested translation,
> +	 * if the guest setup different stage-1 tables with same PASID,
> +	 * IOMMU would use the same TLB tag. This will results in TLB
> +	 * aliasing issue.

Yes, but if the guest does this then the guest is required to use
different gDomID's.

> +	 *
> +	 * Workaround the issue by allocating per-device hDomID for nested
> +	 * domain (i.e. ndom->id). This require per-device IOMMU TLB invalidation
> +	 * with corresponded hDomId on the host side when updating stage-2 table.
> +	 */

This is still missing the point - we cannot work around this with
unique hDomID's because when you implement invalidation there is only
one input gDomID and you need to map it to exactly one hDomID to push
the PASID invalidation.

The only reason it is barely acceptable now is because there is no
invalidation support!

The comment should be:

 The guest is assigning gDomIDs based on its own algorithm for managing
 cache tags of (DomID, PASID). Within a single viommu the S2 is used
 by all DTEs but we need to consistently map the gDomID to a single hDomID.
 This should be done by using an xarray in the viommu to keep track of
 the gDomID mapping. Since there is no invalidation support and no
 viommu yet just always use a unique hDomId for now.

 When the S2 is changed all the hDomIDs in the xarray need to have
 invalidations pushed.

Other than that it looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
