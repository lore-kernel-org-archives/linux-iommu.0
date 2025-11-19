Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA314F9D6
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763512096; cv=fail; b=ThcP/a1XX59FCXokwB1V8KmbxyILJTFrYi6cVPp0QSgwPDs+h9Fx1KLO6Ie1YV2CwCEImBUESi9L41ZC2ELfe0KPFZG5gApX19ATDB94TXQgua4ALCwmliYUW/0mfg8/jpKnHETkKyAJsRb5Oan63rESWZp4wKOle96fx/weLWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763512096; c=relaxed/simple;
	bh=XW+fDKuD8o05jwGix+ixve6l80gEYV4lcjdafYvkQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLFMHruhYnUD321vICSlAwYYidtsJ3xa2HuSPolHA2PhO/009EaqFNj0CoHdxRil1S4uCSnMXlRT4osbZb/eFpiaCCQAryNfvKaWNfjy1txztuGp6d80JtoftftHqRlsDb8L/Rb+eSuagGTxtyg/Fw0FuYZIDZqGABUL6paIqJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F0RHOqMz; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F0RHOqMz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/JxF4GWRJTqLVV6/BrbguwppujMeQXqSI/BqV2XUTEJ/kZTlC2yXLnUZQWonfN62rtg9dCQ+zp6HszR/+iVdrvF/Q+wXK2Gzexo1DIAdHOz5g4XBp2c9JVYRpIp6plTDvNPjknkh5NbrIy1q9qPQnK6qMSKwyG1mVVrMKpAlFdL30jtc0M3R4mgiPfP2Z9xtNXoJm9etwuauleeXCGF28f5BkjtycPWjjPFZG4PrDO5Wk13EhfRUPeiuVut/5XtwFhYWQbdNaIAFIkdVm7ghfZGwyNOUDznIUT/uOxQGiwMUQk0IIjOyYTuUf435JrekcdK6P0QW/D2e5s0IWr0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pio/s0jYaP81Tuy0D759yvYBihxCBsmovatAQuvInh0=;
 b=eokgxkCVVg3bz4JJyFUANVNxvv4BfYZCxeM7R5k60LmpWr67y/vIf4kHYvP0bs/hD8f3PGqLAEi5rvNxjFVcKDRUD1UvCAd/av0aGFvFN2kDooKKIObCW2xownMz0ZxRcpEz6UgkaAvoFGPS2SIy+X9M8zFzi1JeyGtoHZRxVJoJJtoBCf3ESK3iJ2kldPsKv95mOOvShNj7oIUIlPFRqpPc3zuXzZ3o+AwidrKxTvhRRMq3jxfHQB2siPolNVE+y4jJaUXC0sT95GCY3+bfIRSnKiLkwICRKxJDGmZiBS2x8Ka7Hyf+Uj6Yzbg11W9mq0dUS1fl9O3GJXXAOEazAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pio/s0jYaP81Tuy0D759yvYBihxCBsmovatAQuvInh0=;
 b=F0RHOqMzp7gvVBo702E6CErd1Jkz0EYgQrynYzJ0M7c5xooqgXsXGNZ3E2kyJB+hoDwtxNp/lDWHb+IfyBOyJrjEuVl9dkWI9z6v9AlAaIea8UPgrIogBaNy5SKEpd3/mYNYxf+IOcqzlorFaHOeovO5aWZ9cm3ZzW1UU5zQc/Tss1oG2eELHxMql8/B7bzZ1XBv86ExzvgZCzA3irujgvNNSgU9Y0G0fiE/re5rG7aZEd3gkb3u9XqUq15wPquxxeD+DDoVBmbsQDemBH9OWKybF8DAbeYlmDZG5LRWfnouikKfnEsYEEMshD1HyC3mhEzTbq3ElRdFotM66u4JwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:28:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:28:11 +0000
Date: Tue, 18 Nov 2025 20:28:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 14/14] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20251119002810.GL120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-15-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-15-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: a38332e4-1635-41c3-1221-08de27028501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6r8XPsRm4Y8PoLUCUiMSLowitiZzFiBeu55/TSiF4ohwNijUZg2ocmB3UL+2?=
 =?us-ascii?Q?d29NLJRxD+wxprfLPCbCe6gZm0K8rZcvXN2Q7R9eG010rkw5hc21HzT8vmFD?=
 =?us-ascii?Q?IHDRFsJzS18KVbFVdXnQpWwcysmRhwqnlooFb6uvbR3mLEYbTC37KkrkZWS2?=
 =?us-ascii?Q?x1Y2wZzXezD/8/9EyFof1jvOUbtkjO0pmTQ53Xmp2YeG6r1jp+hNmYDHPhHF?=
 =?us-ascii?Q?qaGzddSsac4jKX5d4wlj5UQ5zKYPYXIE34RooIHvCtMrHvLo2C15L9itt0QT?=
 =?us-ascii?Q?I9nb9oJSdfajEjRDo06koRaL+oEuUtE0blrnNwccbxIQrgX7yesB1uD0GerR?=
 =?us-ascii?Q?cMu5QosHlJQ6szOd7L2yyyRxfwql4qtmVlGz1y54IgT74ZFcagdFYke4dw6L?=
 =?us-ascii?Q?QT0nbhz9m9ZAt1XN+kJqjN08/6IdiNSnXjfvSD+3hC91+xKrT91wWQJ5rAiH?=
 =?us-ascii?Q?W4edr/jJOh5dXYg8JbSoCCBtZvHYhkC0n6pYyKrTElCYb8R+eNuUh//LvP1o?=
 =?us-ascii?Q?6ZXK/M2iX2dhqd6eDs5wY15vfqeySDZDAqaD6wjLJ2L4LxnNDhcW+KAE/O3B?=
 =?us-ascii?Q?qgBVA1Py3WXtvTC6cqdsaeSonrQXKQvQNtXC0+wPDsev4NM+4ZBoYHj3fETC?=
 =?us-ascii?Q?eRh7IDYKIs/5IkoIiCKWDIfyiMNRfQF52umnip3jUwfMtZu/IK9qYV0M6GNs?=
 =?us-ascii?Q?UH9/g7wEJhUB4VKpOPhQ5g/+RJxNRFjHLwktmGHsKa1p4FCqwymG4PrIt3eF?=
 =?us-ascii?Q?3WYjGxAaj+yX48f1ySExJRIjLTKG+dSRrKKAgGOJxNxdemtXk7XGxpYUzPW+?=
 =?us-ascii?Q?VlUjRLwi/ajZM5zqyddx9Gn/xjQEa+beoPsbgppAf4S1DLVD+DIYgcTyXpIj?=
 =?us-ascii?Q?+/5MJZzZOn0MDTWWhD4xRDP93q6SGp+erjwEmMG1fFWeFmPMp7yPF+KfpMwm?=
 =?us-ascii?Q?HI4Oqd5ZxyOIH+cdGX4ULk/Cl0MdgAv5VCaNm7nx0f6OnPxuw6L8GcmoLzNS?=
 =?us-ascii?Q?gTLr6zUerj+UDfF/BXrpRv+Srk0Plfja91GR1e+Wu8mm/IBc69fDpQVCJ/3J?=
 =?us-ascii?Q?FnrmNxHeE9iLWeJkd1ifzXudqGHMzv44Dnk1M58Jb57x++jhGxI8aCd7DGdT?=
 =?us-ascii?Q?p/tgXX/QQ01KYTOUGAeBl5IWatZLRshtv3UKUt+hiI2uVlPuM7DNAtyvY9/H?=
 =?us-ascii?Q?9Y8GLcJSBZK5wsfs/hjs0U765MrCb7wE93BIJ1P+EKa8UCg2MJ3+vLrIjceC?=
 =?us-ascii?Q?0n4xn95sTQp6OG464maAgCwpgVEiIjtn36cvEbRTr0R0kbPYaakKJgKiX759?=
 =?us-ascii?Q?PRJSyb5W9PYJu8FOGN1MfN+mu7B0gQfqD3wefl1mzRHcWAPV2Hc1+1h9fh+/?=
 =?us-ascii?Q?Qo6C4kA/GB1Nu+oz0uizv7gTOdYJlZxovPhhEwmbj39Wtgs+o3Q085HJJC/J?=
 =?us-ascii?Q?ORARgOp82mlb2OYuHwfa9wvzKGMvlkGN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zBOsOFaJpfE4jocAzY9PCDLL3mBWoW50Anh648ubIqQnCgSxuzAe0ZHhvU0t?=
 =?us-ascii?Q?AD2bhHTNLvMPvWGC1te1WdWa7HsDlVix3ndBwWnCQ6Y6i1vXlhOX1RG8+b7x?=
 =?us-ascii?Q?MOVXFRktTp14cw6uXA+yH2PIOfyXzlm1clfwLtPbg3WUb9n0h5l5bpuNkpK9?=
 =?us-ascii?Q?snJU0zno1sptXNrBBsxe72svtlCC5bcAxpdpl3ieqKd1uVdOmrmByWNGYTF7?=
 =?us-ascii?Q?qHMHvxEsQfBp6sC28ev+iWTghlajzmkoGWxSqNSNexUrIkEKY6NdvBRQCQOn?=
 =?us-ascii?Q?n1zt0RMINAEHHs2BFowJ4a/b3gNh2L3x7ZgfaD2ju2Yq9ljLtaURZPys6Tnq?=
 =?us-ascii?Q?OhFTjfIG+p1lVIkSQVN87UVl1WfQoJw7PWGmhdivK/u5r5ccYIVsw1avsOIW?=
 =?us-ascii?Q?Qh0pO8OkaIgz9FkJ+dIPzSWSJQPiuDWOUjCthwxsstxnAjgRTxPFoLb8AXQR?=
 =?us-ascii?Q?BX34G3oFaDqQqwh7xwxbxVjzqZIzlNnkcuHjJDkjMcywBi/0vI5AK5rSuAIW?=
 =?us-ascii?Q?oNnA7WDKnqjCfKapy/qm8uJFJn7qvSOFFvZSItTsRzxshRWULPNTQnqiuVb4?=
 =?us-ascii?Q?EwamjTfki74fguF8eIa1z5UP3+ukYvGxDdp+Z7KFZQq7spCg4kOTf1K+q3u9?=
 =?us-ascii?Q?s3z1+BcSzqwqK9r2LefJ2+eSNby1x54ax/7dJ4H5Yh2o17lzCaJ1yRj2Ox9G?=
 =?us-ascii?Q?Cz4U9BZNX5/ELsK5TLHmDedHWrGsCpc21t5EelzMaUNYrGfkb5iOazX4zIPk?=
 =?us-ascii?Q?NWv3pE/mgGjYoYOx701QFQ+nDEIz6i6QKMWVV2zbWdpVX+UFDub7rGx3zqS9?=
 =?us-ascii?Q?OooF3D1PmXM3EH2cm5eVQqkecVO+HTIkH7woSuuC7hAygcXaBCFTBJTLe/1n?=
 =?us-ascii?Q?j7FUAFktbrLo4UjPAzwHGWJPCVcSBU0wxt6yy9mdgTVmZUXKfWpe0D5mx+rs?=
 =?us-ascii?Q?q4Z3GnRsesf5Gq0cn54DUiDw/5utP53ZNF/vpcBV2KoMGixW5xOgK+4HSK9L?=
 =?us-ascii?Q?lAN4enL3Kyx1fBWDKyWF5DxG+TNNQoSIxukapgpZkvERf8/fRQFhYD+cnczi?=
 =?us-ascii?Q?7m6QqHETU1gVtK+h28ysaFwtZtEyFNMUS7Lkn/2Nmg41HrlUjItpI1/J7HNB?=
 =?us-ascii?Q?Y6K1MbmtaHzBMrcYvQ82tn0K3EBuAnHYLNuY1RwdNGkTE5awcC1LQxc9bAo5?=
 =?us-ascii?Q?3GN0cUyUkZzDSAzxU+dQEMqYAaTAyCNnSwSuPD6+PGiORsEfamWHl6zdyKyS?=
 =?us-ascii?Q?nubQciEAFrZrDptRH+0bWYgF5wsw3k34is6q+6FsxrgFVwNIanrE9clvs08x?=
 =?us-ascii?Q?7Yvoani73ZjmqtxREZB/2x9kb4IMVqOcsP0+Cq6lmd/dSuA9VsevzrhkwcHy?=
 =?us-ascii?Q?BmqwOeqFTk6SHEljWc5pWwLoPM9AzePQjGvz3NCMYoEvXigaUNiQLgv6EU9E?=
 =?us-ascii?Q?qA8Rcxw2v11RxjscZPv4z5WBZFdT+LKPZYDaLoMoL3hWUJQntOj4AXnVRcT/?=
 =?us-ascii?Q?2AxI0xpcXDaNiDDa9y/xfxuEPAU+3LN0s5slwSYiA82Ij+6A16hn7MKfekiJ?=
 =?us-ascii?Q?3pFuCrD2LHiJDggScMg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38332e4-1635-41c3-1221-08de27028501
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:28:11.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJIJMt5OXRo1lPOQEkj4Sr/yXgf8NswQ6ek7JKIWekQZ/2YpojG+IrK41/f0mxAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On Wed, Nov 12, 2025 at 06:25:06PM +0000, Suravee Suthikulpanit wrote:
> Introduce set_dte_nested() to program guest translation settings in
> the host DTE when attaches the nested domain to a device.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/nested.c | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 1bbcb16abecc..eeb5d9b3a58f 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -153,6 +153,74 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  	return ERR_PTR(ret);
>  }
>  
> +static void set_dte_nested(struct amd_iommu *iommu,
> +			   struct iommu_domain *dom,
> +			   struct iommu_dev_data *dev_data)
> +{
> +	struct protection_domain *parent;
> +	struct dev_table_entry new = {0};
> +	struct nested_domain *ndom = to_ndomain(dom);
> +	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
> +	struct pt_iommu_amdv1_hw_info pt_info;
> +
> +	/*
> +	 * The nest parent domain is attached during the call to the
> +	 * struct iommu_ops.viommu_init(), which will be stored as part
> +	 * of the struct amd_iommu_viommu.parent.
> +	 */
> +	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
> +		return;
> +
> +	parent = ndom->viommu->parent;
> +	amd_iommu_make_clear_dte(dev_data, &new);
> +
> +	/* Retrieve the current pagetable info via the IOMMU PT API. */
> +	pt_iommu_amdv1_hw_info(&parent->amdv1, &pt_info);
> +
> +	/*
> +	 * Use nested domain ID to program DTE.
> +	 * See amd_iommu_alloc_domain_nested().
> +	 */
> +	amd_iommu_set_dte_v1(dev_data, parent, ndom->gdom_info->hdom_id, &pt_info, &new);
> +
> +	/* Guest PPR */
> +	new.data[0] |= gdte->dte[0] & DTE_FLAG_PPR;
> +
> +	/* Guest translation stuff */
> +	new.data[0] |= gdte->dte[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV);
> +
> +	/* GCR3 table */
> +	new.data[0] |= gdte->dte[0] & DTE_GCR3_14_12;
> +	new.data[1] |= gdte->dte[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31);
> +
> +	/* Guest paging mode */
> +	new.data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
> +
> +	amd_iommu_update_dte(iommu, dev_data, &new);

The functions should be consistent a "set" function should just set a
struct dev_table_entry. A set function should not call
amd_iommu_update_dte().

So either lift the amd_iommu_update_dte() (I prefer) or change the
function name?

> +}
> +
> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
> +				struct iommu_domain *old)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	int ret = 0;
> +
> +	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
> +		return -EINVAL;

This is not needed, the ops are for nesting they are only called by
nesting domain types.

> +	mutex_lock(&dev_data->mutex);
> +
> +	/* Setup DTE for nested translation and
> +	 * update the device table
> +	 */
> +	set_dte_nested(iommu, dom, dev_data);
> +
> +	mutex_unlock(&dev_data->mutex);

This needs to make sure there are not PASIDs enabled.

And similarly the PASID attach path needs to to check that a v1 or
blocking domain is on the rid not identiy, not nesting.

But overall this looks OK and I think the series a whole is looking
pretty good. If you fix these little things it can possibly make this
cycle?

Jason
