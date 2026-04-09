Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA43A3E70
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778158; cv=fail; b=OOg+vtTzOt3+E5WaDd8LQ3VFgo8ex8CA8Q6FTqCSTihwV4hRK8yCaA9Zk/FMdXhbdGp60AofD87MjvX8AO81IGiRnAJ+HNgAfe+AtMZk4kr7+UpxzeODrzhh9QXqydKGRluzTJZDavWmFkRGOKG2MQUCHpG41/yYrMuGAISZzs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778158; c=relaxed/simple;
	bh=pLUN9vKcE8Wydh4D4CyAOi52TrPJGzMuMjTGuPVuHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U732nTXNk5NhbdeZD573LUpvH0AW21XTmTa+0GTYtlaO1IAPOTsnhHXEUHDSTEzHRUVyRhQ4olhl4i4R2oZ8Wn/wW36p44y/XMT732QQK+vm07xa2dmnUxQdn/YmqEifKerTytbYRj2NRieYScwO7KwX/Nb7SjJUT+PQUerXdc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=isO4fTFN; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="isO4fTFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKDBFuEzsel9lUVBP5kR02XqAjYrYnKqSfKDRC791THM6+W3y+FEPjfsZC6QESBaF745WfOgdmwMS1aaVxa81f1vi62XcJ4psJ1Ubxyh8i+T77p2b2h50eQvwGg6lqLQw/TRBXKzcCEkcy3ubsMhoUq9km+UNEIBYpUpVU+Dv3Nz/NiHaW39NQYdl4Nv+OQcYLFnRvnMz0A/ZSV1c5yDsVkx9gldGzzNApTUwFnqtsrFwzcp78AmkkuOAxbxUx9CpyS704sLoAdLWL7ILjrvgRoWPIvkyvDS62aB1l4zmxWO2dddDA+YFTPCCZYcXUGA9e586fByw7mVStpU+9OlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCx3FXrDB5TVRB3EmUcwGs+YJvS2zZW3t7ykjIq0ZI4=;
 b=qInLMhSoJtGxx7PI70fkT61yn9leODctLYEH4Z0wQmFgPhlXe/2TmP6GQrXGNfjoPmklio+KsvKAOHLpcJDhZoFzo8tVc59SnoyZ4hWq+w90BtHa/1JrgZku2mxlGEINqaySm6PzKEO2XEScFtBcKApkz+CQ9IqP+Xv/pGbNhCKBYgDqMbKl4ggWgELRjRLgLH4SReWdfJVgF2cgojUHfAazv/Jk+22ERr8KgrOZrxNn/FU1bWD2VdkQglbHo932nt/kovKGX0a0Bv6Wa6HYO9iU2t7QCld0ShTC6QeebswEzO6XTT8RAJY8VP+TmCEz0oT+YoRCh0wXLi8W20T/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCx3FXrDB5TVRB3EmUcwGs+YJvS2zZW3t7ykjIq0ZI4=;
 b=isO4fTFN2+nGWNUseVPG3m/nSvjWEh1aEDLgF8DAH+NMeKkoRUKEYml1CNeEYk0IcrBEqGp9BK9kLCrVu2mITLnIWzGFWo6U8JiywdGEGTluKCQdYgOD9TG1JrmjpxFU4bnuT4pSwAZhfURegu2C/kiZ1RLY+1Yw9H2wZMFhNFTRzlBSbJhWbVEtzhfn9uJwGjpoXA6EyUQu/EpErVphiahISLHwZzhHFAmpr4cNxwoGC62+4P8nQxLoPqcHpYSgovJVwzYWUS2QbAWXR/olSjWVS6kj0q0kkj2YhUtvXw0Zq6d4ReaVFuBvtH94uDYTLGtFwoQFg3EEgJpW8ug9Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 23:42:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 23:42:24 +0000
Date: Thu, 9 Apr 2026 20:42:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 03/10] iommu/arm-smmu-v3: Store IOTLB cache tags in
 struct arm_smmu_attach_state
Message-ID: <20260409234223.GX3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <ceb8150f229ee7bd355ec42d23e422ae2185492e.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb8150f229ee7bd355ec42d23e422ae2185492e.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:236::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e9f2bc-6a44-46f4-866f-08de9691a65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DF04+EUi/FM8xqKxNk1IzXlzPZhRhO+meMYkXg0xtaRUPLWWalDpq+vKssyUDOfniUTP6WYEk8SVvoq7bbmt7eB2eebO0Q5V78VFADJmBMAScZ8mfQSCUaIpU/i8cu7dKZU4ZxG0EG0F1n9HGpxugO4y/gwKgBh4Bo1SMMHm/uRyJ13WIkPaw3ko/7wQfuQYXxbNGnK5E23XYtJe0koOCYDXOgCqCe2ndUAoijXaeuhFBcGHcGhzruRz0N1VQX9wznCexScyAiHQ04i6IKFsgHoy5Mz0E50dFOAip7Vq3+6TxOU8LiiMkv4TCj1ZiKHGYaM3hJb8XGBq8y4OnKH9vKxA/FP1D/AUWRauF6RkeXX9GTGahSX4CX1AD53JyeSIbXeXWe8HmEC8tE6Vy86mEzUSN8LsjfkAaD7ErNPuduZj72Uz3wfJJ6fOLhFWSsopMgPeyGt3YEK4v0mIg7KxfREqJMIFUsm+pfbRl6ZNzimA4LnSWOW+Odyl6Nq5BlfKwbvyIcDC5vLxIbTtJN/0kiumooLgMpMuQZXKitX2/4Qd6f8k8/qOPNAIWTqBsLjvc7EOcBhAbCy/J6Z2Pt5ARwon2gE6MSgyq+EhXVvGLWnHxENx5xOIFBo2A/17grR770Mddq/j6+1uqPxg5evBUhScYrqs6uf1mDEvDoAPxxZjVJcODIAR2BImn9qX0XzpdxsAMRY9kYslNlAzUcqKU4j1UJxr6LtQOqfydOtpeQE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFyci1uX6uUQiMO20sydQLFNwytcywXvngP7VXbrDdzPtSV+fTrtH6f+UBMj?=
 =?us-ascii?Q?a9BijByO41gvdcyfswZnGjv1NjQoEg60DDwRa3cnPuJg9JHTJ1LDa5Bpz/+f?=
 =?us-ascii?Q?LTbju3cHT2OFmEPSYFaZykuC5UKvE82X5I6SuLYVvx48O/9flIMUqqxtGD55?=
 =?us-ascii?Q?lvnDHhkjw12k5pUjhkTT5JY7QWYJpF5cvwqxWYi8gRH6Luernn5NkUc/npX/?=
 =?us-ascii?Q?6gY0vGK23Onam6mG2C0bdBA39Bvq9vAtKzpGtuMni2qBjJvVMTBXeu912dIt?=
 =?us-ascii?Q?00utCVY/eo+SSE8SKTmzdvcAF5kdcW/n8RMhUXQWeJR5S8osKwoXYslRUKSd?=
 =?us-ascii?Q?MByCyFOLOpS4MkWqkrF27mjUKigUPYmMKeS/1BUChJ7313fYvNj/TmKmIcru?=
 =?us-ascii?Q?xinzUiBwPCug6KBVDYy/uWR590zPdoWy0NAMOxpafg9kLkygu03CNng2PNFI?=
 =?us-ascii?Q?56jZTyueaoDxloD2CxIEvo0QOi92TU4XXHuTTYxDQRUn5rsghnYmDJXpX5+F?=
 =?us-ascii?Q?UjZQ3nCS0kBRJmr7ssSrJg8mU1ce6+3bwMqoMOAg5DNY0xk9+eoZ12E6GDIe?=
 =?us-ascii?Q?n7xUUMyoS3oIuNNzvqT9XF+4+cr20p54UDeR836iiezZ4gGRqJ2CFW7PGX6Z?=
 =?us-ascii?Q?w24aLnwP6eNSY+P6V6I6WYDLnL2wf3DNAO2mZq5XQn6ArukLQ+AekIvIWNSK?=
 =?us-ascii?Q?rVmvdGgjECq4vVL13TlPbWQF2Bd10pQ3l6AACz06eLPBM6GUb6Y9oFWLO4Qd?=
 =?us-ascii?Q?fc+DV0xaEbRlCrQdR16HRnqFr10PiQnhwwIt3Dnzf2ou0x4XpzXyPGj9QOly?=
 =?us-ascii?Q?2BGO7It/MjsXzLWEyI8k4YTlW6mA8vsnaobONppBdZuGz3xI+fONjGyx0ksc?=
 =?us-ascii?Q?AJ/zINzwOh5oJrw/QRqkVv91zQ7plm5m2ImIIDXibTwDvlc2fEi8+wirbUCM?=
 =?us-ascii?Q?55Jj84TimRfyPVIm1c8GDc8WDFIGkLnPlca3TC1ExOWttYS5BVSqNQ0P6Pko?=
 =?us-ascii?Q?IJ927GofarJlKcP9hejhP/hVKg+s74ceMYEFhlwWC/Foovfwtv8wW3Ucc9ud?=
 =?us-ascii?Q?nIgQsIurBqRQAxZszIIIdGggTrBkOiJBUG52f28WbuDJHhy4TjQlz6drF52F?=
 =?us-ascii?Q?pBz7rTkpGY7JmXX2D7q82b3tVkZ56x7Ut906eiuCBrVMnjKo+8t5g+5oB2R9?=
 =?us-ascii?Q?/LWYx3NxTKqavXFaIHPSb+N8hCZE8aQvvolbDrsUMsAAO65tDLowB/lgT8Zr?=
 =?us-ascii?Q?xuXJsC1eAEqAoKaTLWur/SfqfoKHDYrQkb999SIpvtW0v9XurtHAGowvgUcw?=
 =?us-ascii?Q?CT7lCUv6BXPDv8pcfYcs5rG6pMAaS8pEvv8wTxm5I3VlCOjnb0rfmEKUTSRx?=
 =?us-ascii?Q?tFR5heSkyueDt2PNH1qEYF8TnNK501Rt4Zq6Dw8HP/pOCRzeTCh51nPX9JT+?=
 =?us-ascii?Q?r47miMgmiRe8mWmtoVec1NlUO7v7y/lJ8d6Gwc2I0ocjzB8VunNkjiJCsyE5?=
 =?us-ascii?Q?tCzzoDlNZOaJMUBz8V5uIrAxFEyIbkKZqjsTMayzfaT19qiIOAuJNOzWjjnE?=
 =?us-ascii?Q?B7aLUrlCSVScpNgG2sze4wo1UakCQIqsWV6VgOmCneX2AvjsP8Ux21e8kmmc?=
 =?us-ascii?Q?0mvxCUtRTCVxI4ErWm9L9IRpNdck8DkiJoseBtKUItwRff9ZPnL9CxSZrmlx?=
 =?us-ascii?Q?SttiL6CF59ze4eAq57o12ZKiqf3qM2BsRRnA960ro+m3fJ3a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e9f2bc-6a44-46f4-866f-08de9691a65c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 23:42:24.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf1w322dDvsFmcWnjtihJ3a2PijQe5gH6QeeWKU2NMoc7cUqueBjUVSOlxGLczY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82

On Thu, Mar 19, 2026 at 12:51:49PM -0700, Nicolin Chen wrote:
> So far, an IOTLB tag (ASID or VMID) has been stored in the arm_smmu_domain
> +static int __arm_smmu_domain_find_iotlb_tag(struct arm_smmu_domain *smmu_domain,
> +					    struct arm_smmu_inv *tag)
> +{
> +	struct arm_smmu_invs *invs = rcu_dereference_protected(
> +		smmu_domain->invs, lockdep_is_held(&arm_smmu_asid_lock));
> +	size_t i;
> +
> +	arm_smmu_inv_assert_iotlb_tag(tag);
> +
> +	for (i = 0; i != invs->num_invs; i++) {
> +		if (invs->inv[i].type == tag->type &&
> +		    invs->inv[i].smmu == tag->smmu &&
> +		    READ_ONCE(invs->inv[i].users)) {
> +			*tag = invs->inv[i];

This users thing has become to hard to understand and it isn't how it
should be.

All writers *with the possibility of concurrent access* need to use
WRITE_ONCE since there is a RCU reader. IIRC that is just
arm_smmu_invs_unref()

The one in arm_smmu_invs_merge() is just writing to newly allocated
memory so it shouldn't be marked.

Only readers *with the possibility of concurrent access* should be
marked with READ_ONCE. IIRC this is just the invalidation walker.

Places like this have to be protected by a lock or the whole thing is
wrong, so it should have a lockdep annoation.

Now what is the locking supposed to be? It looks wrong, it probably
wants to be arm_smmu_asid_lock, but arm_smmu_mm_release() doesn't grab
it.

But why does arm_smmu_mm_release() need a tag in the first place? ASID
isn't going to be used when EPD0|EPD1 is set, so the tag can just be
0. Probably make a patch with that change early on..

All the locking is important because this:

> +/* Find an existing IOTLB cache tag in smmu_domain->invs (users counter != 0) */

Must be held as an invarient into the caller, meaning the caller must
hold arm_smmu_asid_lock while it has an active tag on the stack, and
that should be documented here. As well as a lockdep of course.

From what I can tell the final result is correct (aside from
arm_smmu_mm_release), just under documented.

> +int arm_smmu_find_iotlb_tag(struct iommu_domain *domain,
> +			    struct arm_smmu_device *smmu,
> +			    struct arm_smmu_inv *tag)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
> +
> +	if (WARN_ON(!smmu_domain))
> +		return -EINVAL;
> +
> +	/* Decide the type of the iotlb cache tag */
> +	switch (smmu_domain->stage) {
> +	case ARM_SMMU_DOMAIN_SVA:
> +	case ARM_SMMU_DOMAIN_S1:
> +		tag->type = INV_TYPE_S1_ASID;
> +		break;
> +	case ARM_SMMU_DOMAIN_S2:
> +		tag->type = INV_TYPE_S2_VMID;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tag->smmu = smmu;
> +
> +	return __arm_smmu_domain_find_iotlb_tag(smmu_domain, tag);

This is the only caller it probably doesn't need a special __
function..

> +/* Allocate a new IOTLB cache tag (users counter == 0) */
> +static int arm_smmu_alloc_iotlb_tag(struct iommu_domain *domain,
> +				    struct arm_smmu_device *smmu,
> +				    struct arm_smmu_inv *tag)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain_devices(domain);
> +	int ret;
> +
> +	/* Only allocate if there is no IOTLB cache tag to re-use */
> +	ret = arm_smmu_find_iotlb_tag(domain, smmu, tag);
> +	if (!ret || ret != -ENOENT)
> +		return ret;

Lets not call the function 'alloc_iotlb_tag' if it doesn't always
allocate.. 'get_iotlb_tag' more implies the find or allocate behavior.

Again the locking is important and the caller must ensure it holds the
asid_lock while the tag is alive on the stack. Mention it in the kdoc.

> +
> +	/* FIXME replace with an actual allocation from the bitmap */
> +	if (tag->type == INV_TYPE_S1_ASID)
> +		tag->id = smmu_domain->cd.asid;
> +	else
> +		tag->id = smmu_domain->s2_cfg.vmid;

I don't usually put FIXMEs that will be fixed in the next patches.

Jason
