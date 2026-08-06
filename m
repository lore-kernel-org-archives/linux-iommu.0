Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848A4B0496
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060769; cv=fail; b=dF3aw4UHfPhC0E63FDG4LEcz6Q2F8AF6nCZrtkJYFLBG07s4RdQR0OrE7qZqqJ8Ef/HXzAR0A1QFvzz19TG9wL8BZhkpJr8FPdtuouMz6++E/8pLbkjH9Kt0kZQumipp1V0jOFB1w5gsIFFUJPUm3bBZwznTcZU1+VDCVlToCFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060769; c=relaxed/simple;
	bh=EZH7ZvE4b4FOFklI2bVpC7mivmULZFcWz9xwtwKJGz0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=psmkoV/kVFj5VqYl33+5upx/FDWNC0v1xvJlEVN3lcyA1Am4rDA71EdKyyjG7SZWGRdCgju4z/7/5J5vfFjOFRigCs5UIaSamfjDSoN6Y2K1s9xcSiPbNtOimzjeoY5KZZhwOGKaE0h+F1Dk4Tp/2nVKUhXlyN2x8/20fG21mEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=paa+zQov; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="paa+zQov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMy6L+A3dzDv73n5mSGXE5wbR/btLojXtoQanrol2GMOh/7m6S8qAWi5dWmVq6kxM68I+6y3l16DD/1IKQYXEgY0gRlsuBQ7saQRYPLyG1J+HGCSq8yjZSqReO31IruP3GLiunC3YyDbbJs5fN6QuRIwqrm5iqmp6dm0n5CAjnlD8BCrN0QekpfAHUGDQvL2lbd/siZRHRKcOB0etNshaLvWqp9JS6qMhxgfMuoz4unFVMjGmBST2t52bN9vpv9WylocXCinV0VyYEmW8eIjoJiNd3Z9xUg4q3jXs6kEtyqMd60REd0j8M7kXXWwhf36EOA6vqnOCgZ1C85l3QL20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqj1J2vrldM6vpWVRbAgTLx8VwlEBpCr+1U7vjHe12A=;
 b=kj8VaexdZ6EZyS+yBTQ/m4h9gQEy8cE+WdEuAU1C8gilMjb77BKrFHeTpe7pTBea+pThUc8aZSLJgL/kglB38vX6bHBwbw0LwB1GM0Nc2KfpG3MbOh2vgnlrtAqi1r+iSPXZpQ6ytGJ0+WZrW2AR3dVxGpksiTUSiQG/JyHV1KBgd+j5u9vHynngieC2fY/LYIsZZ1rDvHUIUJ9kVcR5+sfEccOn3D/YQtXE9lKHCPbBzAtJN3cNmDhfB2DLtcM+F4vr6A1bzWAHawjLQflicdX2Z673QnBqp6ar8vmpIygDZ6lg22Z77KyW3lnv5UlDroSTtE3bHlyT8jI4PboBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqj1J2vrldM6vpWVRbAgTLx8VwlEBpCr+1U7vjHe12A=;
 b=paa+zQovYRuNigUJqYyjEUjogushajJ/fbaEkE/HODoGrfQ8UOzFO03Q3xLkbCb72p+Ai6MA9viy8JRdAx5zgCDAeZggcN6lO/G8zBvE3+wYbw+v2b4gCAJvb7OUkf0BJc3UTgxpeIONzxpQTuvqSyzYC1CYAz9qqUxhUlutBry08F8a5s0ZuX6/K3EK28xUjSDTna4wl1M8FHnqiF/oRhN60g23v3bTnDZqJ81OJBujWwKbkhwCcK+eIK1WvVfELuaiNafwh7e7lWIwmDpoqcQ4s11wPU56gKKCb5iZ609qaiFkYCJTO/s9n8bQlILxiNWb8T9p4ziORz3TP//zhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:59:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 23:59:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] iommu/dma: Restore locking around msi_page_list
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, nicolinc@nvidia.com, 
 jgg@ziepe.ca
In-Reply-To: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
References: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 20:59:14 -0300
Message-Id: <178606075443.185669.7581165177456673758.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a4414b-867f-4164-1f14-08def416bbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sIykjfmwVLM8gLGgDIPN/ai6xd5oCwhd143FIzvgwQXAt0Yo/f1McxZ4rU+498lGZzv/bLgQC/tCTLPFUiJgAeJoWRiPTR0pzfTl/9Vbk0eo5+u3ZQvKKNjnPZmdzWgQ3vRrGV9PDpsyD2JJY+IMO5dT3mWmqGCx6ZEsThE69yiK7GLM8dxm+Ow5RmPrZyeLovgaEeIeE7tZdvQiotRTWoJEpSKZu8FfB4eMjT4yIsMB1pMHmmvP0ZUbvTKKRwRD70TmQmWHO6xqtj/WeQIMPaujUgOLdbT+9Z3g+R8UmFBoxPCV3apcRrEhbaiETxmZvVVf5KY9Ph6r3X2TqULhbGA44nh9AFWKxH3aj/YKCeUvHsKX+cTFy1TUS4PD9jx9mls0emTsQ4+24lJ6NggFZOEmFqu1kAuaTC1SuNw4gKXL/PjRTSFRHy7DjSWLvcUY8E4+mI0HMzzkzIrYp8iEJRCv/Z/T/5B3emDJ8aUQXUlnrs6stLI/JATE1lu5Rj5tScEdPL19OJcXIHFon5NOmVLzIgAAjx4B3Cfm8ZE5g1xUPtciNpbGcepr9Wm43SsV9BLDdBidBLp0D+2v1i0NV8zs3fY+pk2dQ//pnyt/DvMZmSbiqUDwSthFfUTQ7ii+U2FP0b7rm67F00HYJVgsOKfz3TG0xs+gKkalG/X6yRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2lUVFlmbi9KMnF0UjBjTTNpYnhiN3czaHVMcjFUWlA1aVJTaWw4VDdtMGZQ?=
 =?utf-8?B?TVZqczdMK1JRMzdKUHo2VDR4bE5mc25CVmNlYTUzcUdyWnNyMkM5d2hRZU5K?=
 =?utf-8?B?SStpZHIyZis3N3Qxb2w4ZlRHK2lHRGFqUEUzdS83VmRyKzJtZCtWdWNrSFMy?=
 =?utf-8?B?cDU2T1VSZU14UENSWDVHdnFrRDBXTkJiUDhtSkFYZHJManE5dmhFTmZJdEZq?=
 =?utf-8?B?THJTZG5NT3lEc2tKZnBUK2Fpa1o2d0N2UWk4Z0dscWZwMFFWOHZZejBoTkxZ?=
 =?utf-8?B?UndNNG1vTC82M0JBZVNGMUtkWVpCSGRsak45a1RpN2JzRFFFQ0huWXBZbWdF?=
 =?utf-8?B?ekVpSDVVOXRWazBBOWgzdnU3akNldU1JZ3d3TU1pRkoyY1FOYmlwK0RGZCs4?=
 =?utf-8?B?Vkl5dnF5MUZlSnorNExveWZ6OVpRcEpPUWJyUlc2dFVOdS9naWFyRzY2ODdY?=
 =?utf-8?B?aUt4ajROZzNKUkhIR0l4RmUvdVdFK2ZpcVRVbURDejJLRU9iZ3p1VG5BbVZn?=
 =?utf-8?B?bGZ3Y3FYaE9oZmV5Vkxram9FYktjRGprWW9ua09NOHhoOG1icDBUaUZEdmZq?=
 =?utf-8?B?M0c3WWNoTGhRaUFFeG41aEgvdDR0bVRnS09TR2tOcm01S3lvOVkyZlp1Wlpk?=
 =?utf-8?B?REltcHo0RnpWNGd5YURxanlFNG80RjlVNlZKYUpMbmFtL1ZIR1IwTFlkaktJ?=
 =?utf-8?B?T3VGZWJPeWxTSFM1dTM1K2lQMTRISjA2OEtoOHBmelhYQ3U1WVF5S1dPQmJ2?=
 =?utf-8?B?ZUpoV1hteVFNQjBIL3pKY1RPcTBxS0VGWjNmV00zdXJZbTZDSkx4L3VPUzd6?=
 =?utf-8?B?S3NibmxGVXVkM2tsTFYwNGNQM2ZSekdNV1VwdU1wanNEbGZLaTlneGhLMmt4?=
 =?utf-8?B?ak1hU3QvbkhaT29GQXJMZWNZVk5ubThkQy92V1hacWQ1TWdZV3ZVUi9Wd2pW?=
 =?utf-8?B?Q1p3RHlLbVg1bUJyeUtpYUpjWHYxNEZEaXdMdTdqaXNDbm1EbVV1aXlJSlY1?=
 =?utf-8?B?bUNuL1RXa3hHSnVtS1Z6b0NKclZweUFBclBiQUVNTXBCb3Q4c0lSRHVTclhT?=
 =?utf-8?B?L3pSQzNiRFkwSFRGeklCMHdScit0V2E5cGR4TW9lWFRqSGJBZjZEYWx4K01s?=
 =?utf-8?B?b2NuTjVreTBtZFFRazY5WVRxWmxWOWpIT01TTHh1bTlQZ1pwM0ZlaStxakNL?=
 =?utf-8?B?MmJwdUtlK2JJVVN0N20vRFRaZW0wK3B6TG9lTzcveGhmUklWRzRrdHJTcnV2?=
 =?utf-8?B?NzNRZENCMmJXWitpa1JZVmZjN01BQnZGRWt4VDZhWmpNa2lFeHU5UDhuQ3hp?=
 =?utf-8?B?U2oxMFdRVVR0V0NQYUdjZWNpWVp2Z1FOeExPQWRwbVUwTWorbnJRWmp2WG9k?=
 =?utf-8?B?d2M0Tml0T0FRS3FqZzNxRW16MDNXNkc3VzhwSnlDanQvWW1lQ3g1T2lYOU5h?=
 =?utf-8?B?L2tac1E2aFpaY1k1ZlBBaTl2TUw1TDh3QzMzNm5kcDBpbWRXS0F5cDZtbFBX?=
 =?utf-8?B?Z2gzOVl0amZvN3FBNGQvMExrUWdZcmlaWU1nSUVWbFpKaEJ3cEdBaVJBWnda?=
 =?utf-8?B?dFppVWZxSzNKZ2VDSmpsU281MlhoSlcyb1ZBQlZ2QnlIVzVSVC9BVlRSc0lZ?=
 =?utf-8?B?UjNhRFNqNUdlZ3JiN3dKMVFmZFpidTQ0YXJzYldEWWFUMTZYL1RnekhRWmZs?=
 =?utf-8?B?ZnZjN2VRVTJWRytlRkcwNFVhc29FKzZKRWVqRjNtendpYnZrMkJhR0RSNG14?=
 =?utf-8?B?YjFndmQ4UU1qd1c3cy9aUGZ0Tkd6K215bUhCNEc3elI0cTBlL3E5dkVaM05M?=
 =?utf-8?B?VTluM0o0NTVQUXlNYk5kek1UTXo4OFBuV0xkOVczRHJaSzdQWnZRYS9aSjdU?=
 =?utf-8?B?SFFZUnRoaElEWmh2ZDB0Zmt2Z1hxT3MxWEpxVFRYWUphcThka2syOE5qK2pD?=
 =?utf-8?B?aUI3d24rU1B5b2FaSkNFcXdIZEs3bi9LWm9yNW83dmd6YWI2aUhoLzNod29v?=
 =?utf-8?B?VmxpSkNUQjhSSHF2NHcvYXJldkxlOG5QbzJBK0tPRVZ3dmlPbS9CSXRRQUN4?=
 =?utf-8?B?VTRKR0cxM2M3cEpGYlNPWUpZMHljUkQ5cnBXZHMxYVpFMlJZbkZVUjh1NHl0?=
 =?utf-8?B?VWJMOHF4RlZZY0hhS3pSRkhuQ0Q4ZzBudlRLdGlRTldzcm1kL3ZBeEFTMGE2?=
 =?utf-8?B?SllzZjd4L2oyNTZGWWtNR2tESFlXbm5OY2V4bm5aQ0UxTjlZTXB0MHNkQXAv?=
 =?utf-8?B?cFZCbDIyVkQvZDFWdEhCUWZKNlFtTjI1cjJiRG9lemEzV1hUazVxZmZTcFRE?=
 =?utf-8?B?RGVPd0poRjI2TEZLOThnYnlzZ1Nsdzg3c1RZNHZZV1NHbzJlZzNPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a4414b-867f-4164-1f14-08def416bbef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:59:21.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GI6EaBo1yaoAxNQFErC2Ob53VU/9EHx9bxqoO7TXyI9d5eG4D3heWiTVb2ZrMBAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065

> @@ -2204,6 +2204,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	dma_addr_t iova;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  	size_t size = cookie_msi_granule(domain);
> +	static DEFINE_MUTEX(msi_prepare_lock);
> +
> +	/*
> +	 * Normally a device's default domain is only ever attached to that
> +	 * device's own group, and the group mutex held by
> +	 * iommu_group_mutex_assert()'s callers is enough on its own. A VFIO
> +	 * type1 container is the one case that breaks that assumption: it
> +	 * can merge devices from different groups onto one domain, so two
> +	 * devices' group mutexes don't serialize each other here. A static
> +	 * lock is sufficient due to the expectation that this is a corner
> +	 * case that will never be contended in practice.
> +	 */
> +	guard(mutex)(&msi_prepare_lock);

It looks OK to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

But I wondered what the original comment ment:

-       /*
-        * In fact the whole prepare operation should already be serialised by
-        * irq_domain_mutex further up the callchain, but that's pretty subtle
-        * on its own, so consider this locking as failsafe documentation...
-        */

I sicced AI on the question and it pointed out that when this was originally
done in commit c18647900ec8 ("iommu/dma: Relax locking in
iommu_dma_prepare_msi()") there was in fact a global irq_domain_mutex being
held in this callchain.

But that was changed by commit 9dbb8e3452ab ("irqdomain: Switch to per-domain
locking") and it became a per-domain lock

And then this case probably has multiple irq domains for all the different
VFIO devices.

So the comment became out of date and I didn't double check my self it was
still accurate when I removed it in 288683c92b1a ..

-- 
Jason
