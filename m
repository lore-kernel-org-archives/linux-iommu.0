Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03B27D77D
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544525; cv=fail; b=XIEQbDmT9L00eIp9/O8XPjP96vvJuWnLj9hxwVf9leRioqiVdEgnd+BrmEOJLLc/SUIliMiABsIDLxOa4HMkEXb015Xs7mOJhRKiquGPv1bs51LjAzWebSH9+2boUDffAFG8GlmFrmqExZz3YYeitw+mz05uohsMml4lanqwnrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544525; c=relaxed/simple;
	bh=oxMBvVzeKa0QtWG5sDPCcUTKXhghFlptAmEJUmwlof0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aw4dF9fFPQ/6UQkDGVq2PSq6XCj6VfdpSlX5XBEeeJ+IaB1822OSkEi7HnCdAqtN/LcPUi05x/RvvrYsq3CcDtccWjUnRkIA6ySpSEbzbPh3WP4iF6p9+IJqL871Nzkayq52CuP6kWwaxctMfiEDBJ0IBAt5uWqAYQbfj52oOkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Osj8V4Ip; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Osj8V4Ip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlk59HjkiT0NiavK6JmQme+7x/VFNeJuNwDdb1GkJNnHsXWXb1BrQz4+6vdoI1BP4uHgMpXexm9xe/oT9OhI5KEbFANKUYQbntsHRcPfFy+2CRQZPQchTdVqFiWmCBrR2WIPwGKsO3W6W1HjDiAMi5WehCG5loO9+m2z4pTQJd1fyoVRZYNkYT2Wln2/T708eEGsATEun8fUOJjP82Pi+2jXNmhDfST/CjQAB++gUi/7pcho4wZ3dma/Bgp+BgB5x7PdTPKAx1S7ZryQhGWcMoNRxf+QYctupZcakiMgA7ws9CCOYALj5UNo024Hfab2ovA0V+CCim7H9yzeWPdQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqtnPgtF5yctwk76pSe0qteHYUJjfn3HlddK4ffPwEM=;
 b=Sw/AvQjPTYuK9KtwFzR00Zt/56dxjcw9vGv+Kwk57HZkzrPth7VwX9hGfta5EBnGnUh6509FaXlgqQnSrdM+k1pQMh5OWiUDmVIv6YHzBTE/RQSVON9EzVDxEZ+EKnyAvCRtZymZoVBXQCtoP/LsWAUelrr8SpjF7esW9W+43xHnGpOoHboKV11QoHuq3uORlEQd2k9ONs7Ct/dSSiPiv/T7rv9ZZ1Ft3CQ2+xsAPsIbh3LEUCrsLfNheDfvhyPdXxtqIvEpugIHFFi8btmTymUFSEmA0on0c6EExa4koVjxD6p0Ynpc1EBskBgzvc7lKqU3V+GOsOtB4gzMOU58LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqtnPgtF5yctwk76pSe0qteHYUJjfn3HlddK4ffPwEM=;
 b=Osj8V4Ipz755IEGHi7JYDSgCJt5QdN4FwvTCbJY/8dOlQ0jQtKfhi04oVyRhxjcqp0OQUNB1ojim/XJEEQTIY/YPru14oNuz/JrjEbYuZNAZkWKXx2nMoEUN4G22neOntfaTBANJFVA5VEvS1U3pyHTRCFqr7+Ia/O9ZGtXwJTTymW1UvdQEUyaR4TglS1LS/oiUqvC8uTnnBAYYAaBiN2GljER42QdzpKlPa4IMW45M4umauEfP6hWDkwjw6k2PZ6H0CPam4EQcDARRZlFTVSHsr6t4E21VTiQiIrHu1z0bk8mWgyLZfsQkAT/oOSU/orDWNhkWPoEKbqLoemtheg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 19:41:59 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 19:41:59 +0000
Date: Fri, 7 Nov 2025 15:41:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20251107194158.GB1932966@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
 <b7560a95f474bd642e037d5a43cfe5be76ea3fe7.1761590851.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7560a95f474bd642e037d5a43cfe5be76ea3fe7.1761590851.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: afc48fb9-2583-443e-09bd-08de1e35b752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nlq45Ylt9ADmvigiyAOvcyxkpSltEmz+Slo61nMdJMvFiPxkfylDyotwh2Y2?=
 =?us-ascii?Q?LyhzGbjp/3o70stsJHrZiPtmeRWDBC07qyKkaZi1Dze6FhJ4Ljrf8I88MueR?=
 =?us-ascii?Q?irk2KAaQJs9qwZcUI86eGuETMNAv578klGdjgOR9Ih3yVb4b5z6+ROAk7YKL?=
 =?us-ascii?Q?mExXi85y5p+Sf9fcT2JiTNwrhGT1Gp/lJhNL2NMknMjYdFowXw+/Dafs8TLh?=
 =?us-ascii?Q?FrYyvyRH50RvhwXuu8zgw09uyo+/JtzLmunHN2Ehf/SFyh1lI5g2/qwV+bcx?=
 =?us-ascii?Q?dBDXDLjQ3vvdFXzaOcV4w6Otav/pTiuCdrTZRAdHbZ60228tfBJsjvxw7L+t?=
 =?us-ascii?Q?0SRB4cmw++o4qTcBCJm17sQAz9TbaJm/BTiNeQFOzBkaemvZz1DZFBxhe+TF?=
 =?us-ascii?Q?CddQowKMPSHN8XZlMSNi0OcSjyLjFWXbUBP+D7lJ7rFo5TFW5J4qm/PGb3cO?=
 =?us-ascii?Q?zQOMyU/sk8yyAYxMOmtwoa1iLkvIOM09ufbq8pHQx9IK1i60obUx5T8lGLSn?=
 =?us-ascii?Q?q5WvIMnZPbQqUPjg+KcQu6GHDobyJ8R+faDLFYomYfsh5js6rKhXc6Z+Wkr6?=
 =?us-ascii?Q?QYhinfW4LX6VI3ALaQ1/xiUT7M6b3PQf0ty1AgDMgBqvnhkOvXr1oNpGs3Go?=
 =?us-ascii?Q?aqXWeRda/FveGRPV6rF7AJoG4J8+CKBlV5DZxnWx2y0arog0kmMFEPlJl2n8?=
 =?us-ascii?Q?HK+Lqqo7xafoYPgAVGsPALGkUl0wpmpF4saKLgnqvWoSOB50ZUVCfZooQe6f?=
 =?us-ascii?Q?cyfBYgMaDG5sSY4LDUSmd8R6YQ9dCBRNaPMqUG+1h57MtwwPmgGyLxIVRkSB?=
 =?us-ascii?Q?tdv1InzE8FSNmkv3DGHZJZKZG8tmzFYLmKRsTCUDbr9Go0UdjgkuQGTGHyBM?=
 =?us-ascii?Q?pw0j+QaJC3tYlwyfjl7wWbgQ7/uxTFF7iva+2BdfTkQKW65jbZZqjpvZPD+s?=
 =?us-ascii?Q?ghwOBPU75XUwNDURk8z7gqqOyZNkmWbF6pypYd4UYWlLjLNr8XoAX1RBfrwl?=
 =?us-ascii?Q?aPSE2u6Bsct2yAi6eOjfiWQT3HSXMfawt+hwBzejTEaoZ7L/kF8ih7MNLMZu?=
 =?us-ascii?Q?yisIrIcyGpULoZuKiPmWaTpTgC7PvEDxWLJQNv8QGg1vvhrxMZZ1wBXBaeoi?=
 =?us-ascii?Q?F/xTNIwOgvFx2IbE8jtOqS3StmEjTsq+cu37xRI9iB/+SANZa3g1P5o1JJaZ?=
 =?us-ascii?Q?tcQ4FC2urqvS+nePYPAnosqLpX9xY8EDmopYqJKmRxbw7Eg8AMTC1XccTBcG?=
 =?us-ascii?Q?d8oA1Asj1vICeC0hUy22gx09+66PjnGGEAi3fIpmbJYtEuZxG4D0mPyjUpLW?=
 =?us-ascii?Q?HWoNCglGUle7aA22QKjICATF1ynkp8PQFGiL/sTp7Vqn4u/6rqXDlGKcYW3D?=
 =?us-ascii?Q?nvbJxEFqH6DgeHIifhBRFJbsMbmQooTDw56pyt4spq3r5zS4gomzlUtNttBN?=
 =?us-ascii?Q?Cu0fjTPUeCDfrO1RRLUFpUneYCQ/OsLt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TLcYpZx3i0pWxFNTTAxib9+QhptW5q6QUdpaKc7pTYJgprs/ExL9pCj718h0?=
 =?us-ascii?Q?tSyQpwa/6sygJfitek/BOgq+HUu0ZmSIYWYvO6/4ABJ6/5A7R0M9WduP+MKs?=
 =?us-ascii?Q?TBBPkDovyOnhmmB/YyOWlw0T3JEfP4U1EdOhBAIexse6hmS52Qmya3FSC4W8?=
 =?us-ascii?Q?01nMex/b7ORU89e68D7nYthgEo+AMqfnRHJT39vlU2mEeFEOKO0jZMjnoNVW?=
 =?us-ascii?Q?EoIbI/8cXE/hpF6x/kAJXaWtKiSNjK/j0VdKxN6u8UTnpaDi4pvMO5w3ol/s?=
 =?us-ascii?Q?iVb1U75dbbAGX9MPhucNvjQNSTLvdAWw2x9AD5RQ9AIKkFZd3WrBXP1e8OVz?=
 =?us-ascii?Q?LSaoktI5Lgk/qXQ87kKBKm4oe4C06fLPJLDuYdXh6YOSPKh5xeE+bLvT9bc0?=
 =?us-ascii?Q?h2aoSmkwIq5BhkGMERQ1uPq4tXxOTq1MBedUafHtH1eZGikiDnRdTDfgOWfN?=
 =?us-ascii?Q?4pAPhNoVAvEXpjsljdHthJCG/bf2LH9GoadqbGnbTd31NlssegOxcHoquRK5?=
 =?us-ascii?Q?rtl0JZzU2U6AMNmnulMPcxdrRU7jB2qiQc2UoVPilXbNw1jSSzQcYSUNcWDE?=
 =?us-ascii?Q?8yHPXffaOx7M8oZMJFDdcq9eehzUuCtNDXGGvPyQwEFjbVzN6Qq7fX763waJ?=
 =?us-ascii?Q?6MJiWMCTYCNNkh3Q70A5MOYcjsp4h64n+UbiUyTFH+paCKW+laxzK5x/iC70?=
 =?us-ascii?Q?PxZD4ANM1ULwvmW5RMbFAqPM4sJ7zmn8AHSs2p0Or0W53OeaJvH8FiotKEf2?=
 =?us-ascii?Q?59dN9Cn4T7J2+wqMxUduZMhf8mGsO+49/024e13jdeKZ0DlqoBSxjDllWg+8?=
 =?us-ascii?Q?e49UYzMr+oTO4/kDofUcdFw1PxiGboSOU90e4FBpNjJ4DoFs4gtarGuKeasZ?=
 =?us-ascii?Q?gVZ7tx3TwTytLDGRylgIZgaT9Zam1V60hR8oBbv3rpFlFhMPI+t/ZInjTDrK?=
 =?us-ascii?Q?gq69vHMm1iZoqW6GGy4Ds9IA1YAqKqLb1mVAC8BwVDkvNy/2zpek8S4MEprJ?=
 =?us-ascii?Q?isYKM/AmpPEBfI1t6JrifgDZ722TIVU7UgY2k4C7guXn0T3sM8DumEnlJ1TN?=
 =?us-ascii?Q?4fj9j3AAQ5XRtmlyfpLUFHa4HtNgwndza21WAXFO2XKK8kKZKKPCZdv+XFTy?=
 =?us-ascii?Q?kdFbBf0izxVSzM+eYx9/Qn3GWuWIafX2+tjqO7zAeh7YzZuBskcDlQ1MIOFt?=
 =?us-ascii?Q?H8IWzgr+9L0nz2ilgohaTSAUJ12eWKSPTtQZh4F8Drfm2OTvLJsI2WSJe8bO?=
 =?us-ascii?Q?XzzZ1x+AL0pK0OH8H0wHwQ4tpEij2SMYmsoy8+SnN6c2IcQOsxgQznBvttJp?=
 =?us-ascii?Q?JZnPQa7AVLin4yE5y+bYIBGR52ZxCtGcaiuw6DOy/HPaNuPVpSnS0lpBR/SX?=
 =?us-ascii?Q?XwRZx2Uph9JidkzWK2cv3tyGlA1pYnNI0/ds9tnK0hS/gJnPO2j+Lhf4X8iC?=
 =?us-ascii?Q?k3SfVopqaQ9Bp2YhxlZhLIBMtQE8CWpKlKF5OvsPo0rldsqq9um29F3zIeIY?=
 =?us-ascii?Q?+sxCL//pQ+rRydwNIcSXXbAGfMo69SrwUIiLfwFE+SfDESWC06pXcp9SjhWN?=
 =?us-ascii?Q?l9IHVb70BgUKoCkvlO4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc48fb9-2583-443e-09bd-08de1e35b752
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 19:41:59.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6THDymQid7Ho9jN2HhajswRo9kjqstLdeDMFFD4PcBzUoC3nUzVD7wY7iET6Ck37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280

On Mon, Oct 27, 2025 at 11:54:17AM -0700, Nicolin Chen wrote:
> +struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
> +					  struct arm_smmu_invs *to_merge)
> +{
> +	struct arm_smmu_invs *new_invs;
> +	struct arm_smmu_inv *new;
> +	size_t num_trashes = 0;
> +	size_t num_adds = 0;
> +	size_t i, j;
> +
> +	for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
> +		int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
> +
> +		/* Skip any unwanted trash entry */
> +		if (cmp < 0 && !refcount_read(&invs->inv[i].users)) {

Do we need cmp < 0 here and in all these other similar ifs? Can't we
just fully ignore trash entries no matter how they cmopare to the
other list?

If cmp ==0 and we do num_trash++ then the next iteration will see j
ass cmp > 1 so it will do num_adds++ and the two will cancel out.

> +			num_trashes++;
> +			i++;
> +			continue;
> +		}
> +
> +		if (cmp < 0) {
> +			/* not found in to_merge, leave alone */
> +			i++;
> +		} else if (cmp == 0) {
> +			/* same item */
> +			i++;
> +			j++;
> +		} else {
> +			/* unique to to_merge */
> +			num_adds++;
> +			j++;
> +		}
> +	}
> +
> +	new_invs = arm_smmu_invs_alloc(invs->num_invs - num_trashes + num_adds);
> +	if (IS_ERR(new_invs))
> +		return new_invs;
> +
> +	new = new_invs->inv;
> +	for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
> +		int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
> +
> +		if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (cmp < 0) {
> +			*new = invs->inv[i];
> +			i++;
> +		} else if (cmp == 0) {
> +			*new = invs->inv[i];
> +			refcount_inc(&new->users);
> +			i++;
> +			j++;
> +		} else {
> +			*new = to_merge->inv[j];
> +			refcount_set(&new->users, 1);
> +			j++;
> +		}
> +
> +		if (new != new_invs->inv)
> +			WARN_ON_ONCE(arm_smmu_inv_cmp(new - 1, new) == 1);

I'd add a little comment here:

   Check that the resulting list is sorted, this also checks that
   to_merge is sorted.


> static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
> {
> +       kfree_rcu(rcu_dereference_protected(smmu_domain->invs, true), rcu);

It is working as is, but maybe a small comment

 No concurrency with invalidation is possible at this point

And you can just use kfree instead of kfree_rcu.

When the domain is destroyed the caller has to guarentee it isn't
calling map/unmap/etc anymore from any parallel threds or it will
UAF. So we know there can be, and will never be, no concurrent read
side cricitical regions on the RCU.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
