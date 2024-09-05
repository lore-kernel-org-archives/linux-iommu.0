Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411619D07F
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542299; cv=fail; b=IO9eDyVHgopLaski/Jj8T7IcSK5+kqilbxeED4kLWrfyQux2dJ0C+b0RZddwmJ+Et/4lXfZILtAKS7EbBikrQIBmOjU/ofra65KSYX0KdCxDbrj4LQ3XtVQWhRDwkyP4q/fteCVJ2wt+o7XhviqjaVOA5WguGQpoW4x8ECzsY3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542299; c=relaxed/simple;
	bh=r1AlEq5ucmAiDTT0NxSZIMrolOFi+kbS67ZfWWD81MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q6ypFMyxpelec4UwrDdQtvsgn17lvDMaSFHOCGkITNCqAEwlD9Zq1xqfghtkvbcZYIJLyGn8gnbN2qV+lTkBRK7FOQ3gM7+8KYHi7BToSyJYkWWjIu8MCxahQH1UBrunb2OLOxYxnnfGrV8KPAOJZLriyjafXL1LZmUSgFGq+KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sNGkKR+x; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNGkKR+x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqS43+AS1dLtTKiQ7YSGUEC8SZKe504sGDfajYE1a4b5EzKOVeQBDwjHrY/psOJL3MU10UTPdMJZhc+7Ryjb0NFz2d97mwxf2Iy0C0rkZiTcGqx//HidMSE9fcoM+OQIv2SHIrP6rfZzvEP6Whdjgoqi3cXJwzIfXmSEyHJJtxA4Csh7JXwlQndVZovtxL3DvQX5T9NVBfmKrS0njViFjsNI36BcsYvt1sqAsKPzaiiKvaPlCAHjqsGqkTQBz0qVTgEhFCTyeH8c+c66X4CpREmH4aAW3f4v32r9DsAVO+OOwW96/qVsuEnLbwKXIDjY+cvG3SN3SMd2E5uLD6HbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb3bq/MdPrRpAr9bK1qAHrreZM3pBFMMBQxOYTOtRP4=;
 b=Ym4lgFQduxfO5NpGI//m0mPCbdEo5pZnW+zEjFo0cKW7wG5f+qVWcZ98itf8xgkU3Mc2+/JLRkvtirlspA4oURjJ/vYpUfMMb4fxUOW7iOA6K7eKOOx4jS9SFvgPMAclRm1+SuV5p1QiPRZQapTgNXNa67/80uHPsencfqI47xDeN4KfajT67/C6jTLdykjlZocZcaNOAFAEyk7IC9X8LAJeq9yc2vD9XXRuxi/mXKUkkk4Ktwg7o1VEnHf/vmlzbBxorabbct1tMrpHp2qajcFkiYBZrB5tdYVeqi/UUoE8cVugDKtFOn9evvex8cagCRG7ifG628g+Xdj/dwd3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb3bq/MdPrRpAr9bK1qAHrreZM3pBFMMBQxOYTOtRP4=;
 b=sNGkKR+xsts3qIqibKe4ozwXtqTdzUvCNytYDmkCOuf7x5DNMBOvbRRYbosi4bF88uEX7HyVk3iB/2Af+23+7Ma8BTfmfqvsg1pIRSv8oWi3Rhq8TD9Dj4ASn4aDY+YmVQdPwEWTEeWFq4DPoILDwXQYSGLcIaa1S8/eER4FFyawNbLVGZI9gd6NBhKM+PYmZP8qgx1Yk40LtGqkWeCL/pkC6/imlUw9MsCHXebXihfozhYr3297svKGg/N6NFqu711Cuo4DeFOsbVbLNtFWNq+3Uk2g3TigHupeu9PXiUTWhHYpJ9oMuyzKymxgAxj/NSQAIRVT2Cpyfzpj5zlgKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 13:18:14 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 13:18:14 +0000
Date: Thu, 5 Sep 2024 10:18:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	robin.murphy@arm.com, joro@8bytes.org, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	mochs@nvidia.com
Subject: Re: [PATCH next 2/2] iommu/tegra241-cmdqv: Do not allocate vcmdq
 until dma_set_mask_and_coherent
Message-ID: <20240905131812.GI1358970@nvidia.com>
References: <cover.1725503154.git.nicolinc@nvidia.com>
 <530993c3aafa1b0fc3d879b8119e13c629d12e2b.1725503154.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <530993c3aafa1b0fc3d879b8119e13c629d12e2b.1725503154.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0282.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1c0d54-d3c9-4918-ddd0-08dccdad3242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhPMbrNTCCqs8xeNjKvpJEc+/rzwM0F/cj9EZHBXD5yWfafqALyI4feHgL87?=
 =?us-ascii?Q?V49BAfZPJM2AkFI/t0VN55cxbjhuxDwn/9PmOMmBaFZc9OPvX2H0YSCN530K?=
 =?us-ascii?Q?FSkPMHlIKgP4JF1p+8hfCWbQv4I/Jn2/Qij2ONX41BlwOS7hM0ePDHRvTR/5?=
 =?us-ascii?Q?801XLgCgLo1TSy+am3pcrFTCV1jPoVF97PJ+C7/xelx/1AhzfEF3oPk7719B?=
 =?us-ascii?Q?4oO794b+K5lglGbgEhguViQdFm3FehkCcaKopDkN5RpopsJj+4Vse7ld/a7i?=
 =?us-ascii?Q?u5B+mBC1rq+vAHvjawv5xxB6EFIxqnKinaFkKwAHy4CekZb8p3QHEmuPq7dS?=
 =?us-ascii?Q?2LZ2Btd4SgbVsF3zyPdrxd9NZSBvTQcmWGWW0iG3v6AtkJz3hfrqmVlWjtcC?=
 =?us-ascii?Q?bZYqZopWTBLKcbdihAqy3Y/YEive77Y5c3cyl7eSUsmg9s84EFLAPliYS8S+?=
 =?us-ascii?Q?JHS30YYipvMw2A4reAyHLSu4v2vfkapPOvwZXGyYlOyTyRDy0N/QCm2Oh7iZ?=
 =?us-ascii?Q?l26YqhGg2z7VEdNZom6AZRU1Dd6k7YmVzC8nFkbsr7mcUA35O4YJxIuZ8ILf?=
 =?us-ascii?Q?bZCtzaJ5KuaWxuFTWvjKuB2ro8ubS1PvDyKlzjwqCbhSBtuXkHYymwFgj4d0?=
 =?us-ascii?Q?Ivx8e06InloIrMvioAEMbJJ0J4X6kz+vuRzBW0DZRs08ZUfFatbSdOsVs8mM?=
 =?us-ascii?Q?u5UrvL9aiNQt9bt6ytt//Xm6ZEdhOHE8Kzlx27C5/lJhhh62WEXOLt4v9hPT?=
 =?us-ascii?Q?jzxLUJpHCPJZnsau3+enyD34H1Mi3sZZ+7Oyj0lp8Kksv2endTeEVrxQ+Ndb?=
 =?us-ascii?Q?vVTXqU8n9o9CBWn78k8kYSkFo4jBe4cKk9QIOVGGKqFunWgNR+qLRaZwz4fJ?=
 =?us-ascii?Q?p+69cEgaCVwI69EPAqlBIiBZ2lnkzx1Jef+jzwXoTtrVcakyK65X5PMQ/tQB?=
 =?us-ascii?Q?I8Vxt6CFJ2HkU/CvjDFyrjjcx3qhkbiTEUU7ugMdHLFjwutCROEaVkcFdzeW?=
 =?us-ascii?Q?igApDj3M8lBTVbhGWDdUQSPSoHRLFJRTzZosVIc+Ik/HD4AB6F7SlENl88aF?=
 =?us-ascii?Q?ikqooYIPg9aJUryQO37jea5f8fhVb3lla53LUwXklvlE54H3I34Cli5kSoKc?=
 =?us-ascii?Q?2YihUD6YDBRLJWcGjKkplrOQ9NwiFLm5m7K6mCYyuFpxepWEpWpIQoB2t2t/?=
 =?us-ascii?Q?sJa10GtLBKfKk8Wcusb6jjLJEuz3ezQzU2NnvHwBpvyzDtN19JlSZDxjkYAL?=
 =?us-ascii?Q?Ev6o+2fLvnpMfCFAg/BDTbSo0VP3rLmspufxlLbhP0II/PQrJ4/bZ6V3eOzE?=
 =?us-ascii?Q?Q+GOGpNHLHRNPV5Is2Se/FvBQooMSKFKy0SPsh0cyNjn6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nl74i7TSKPwlAZlmV65UQASW1m9sQF8WY9cx0Nhmgqx1+t1REh08olNzuKsS?=
 =?us-ascii?Q?44N0Jc2NnoumBW1W2VoN1+10Fx9uAakiQy2+cM/IMQZ1FMPgJe9SeZNYok9T?=
 =?us-ascii?Q?kCUqryo/QmBABFdnB5YlsHWSoHgQvzaeASiucR/yt/eL+X5ai/JdHWFvZ/C+?=
 =?us-ascii?Q?MbRWaFOHHc1SVgwxTL4Jl0cKN5DN+ZYOWRKXyv54y4AkaxTojvfmXFST7xMM?=
 =?us-ascii?Q?xfgVWtrg/DhmYlmZchj7g3spo5hn/Yr+EOnisST4Cb5KupDqNfBQqisQGox7?=
 =?us-ascii?Q?RY01JuCUkqz9RjL40McIViv4nM4waM00Zmyo34ejA6PvMVNoMD4Z9FlXbWJ8?=
 =?us-ascii?Q?/eAL8+lv6c6mY50eXd7VQPvTL8g9DX0NNY/1JFypAokc/13R1W6UqUfPEGn4?=
 =?us-ascii?Q?IIrQ8Q0ezmcZCc7+9+jhwso1Alhz2kkKCc4yM1F/N0HpCTkZEjft7CNJ+LAH?=
 =?us-ascii?Q?iXyrNDqnk4w/y3ZKY2cJHsayixI95t9MjndX0q5jB6Ik1O4ue+bYkJJm7g5+?=
 =?us-ascii?Q?7s8eZmVWMpY1BbS8zE3NJnmLIXNImmgnaIFg/NEI3rD+bGLvHbRX1b58wGx+?=
 =?us-ascii?Q?UWuZPizvADZbmODzWtifz/V869jR+78M5TS0+8RM4qJONDTi5+nr0nFtPu3+?=
 =?us-ascii?Q?xuys6TshQPNTMQY5EiLR8czzlfcep9xtLGn8PGQ8ywAqA05UhUru8Oo4iS5S?=
 =?us-ascii?Q?0vz+8UlthURaoC21iUe1JkP2tU8aBOsmkLtLQZvPE+NoJ4sRUAEM3FORPrZo?=
 =?us-ascii?Q?yeQfLQn1/8JlU2AoMus5xkShishGnzIZvyaaO8aFaWeItaXIFLB8AuoZqBNW?=
 =?us-ascii?Q?1Jf9MeTpthJCXAFpZ0r95Sk968aojbKYOLDY2D7uePA0Vaea8CNAcYR9Jzbi?=
 =?us-ascii?Q?jgHLFhyhNsAnRZWGl++2YTh3OhACky3Uqq7YMQlh1zVylvCI5glsgxe56/KI?=
 =?us-ascii?Q?STgrvlae5LKoZp6uPBfhsLM8ltlg5YSXEb9vxmWbK5n7eKTgBR99hqcOniHb?=
 =?us-ascii?Q?CkffAXdj1PIlxhroScBT6Lx1mYmCex8QqbNLv4DaOZLXOOlkbKkBaMv6JIIc?=
 =?us-ascii?Q?uL7HystmWwBAfC48qaMJs6fwSmFboWzUscipv8hWLk37y6ud47DJnWYHBgol?=
 =?us-ascii?Q?x+iMrHnnXFJyoOKCTsZkUUouI5zevciOvqgBwcj3VQimCCyxPkkzaC0uUyyM?=
 =?us-ascii?Q?7T/2WNLxdIqkqSaguZs9cIF3DhQz66x+AgLoYyeZGXqMtJxhRJciuAIwEoGS?=
 =?us-ascii?Q?B/K2pa1BsqyaGT+Mbtweugw5XeGzPzPs+8Hs7iq5whefNduGbTxxOiyt36Vn?=
 =?us-ascii?Q?hlI7EdAI+iRdILzYaXNt8Rq1BwgtuBSQ+8WMbFvwOL/96OflRY/20D7BxuQ1?=
 =?us-ascii?Q?VSAqnrxbyu1aoQJxK9rKq/fuIX5PSUSv8k04cwAi4aNrOGtcywyC6GeMtiZi?=
 =?us-ascii?Q?P8vF4ou1slZZvfG8DhqYoADmrx+zn4tjH3syx6A1v3B7TjCakmkAqDUmfUfZ?=
 =?us-ascii?Q?7S+GPzj51pG4BoPYNs0jf5tuzgTzkXK8u6uHp6u+kl5/d940PUDCFpDPAg7S?=
 =?us-ascii?Q?Z5lOA4jBwtIfTg8zhCXpMNnMGXeNCPWcpsUWdDfv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1c0d54-d3c9-4918-ddd0-08dccdad3242
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 13:18:13.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qau//y5yaUoVebSnoGEAO1wKh+ZPvSFbZERzez9sKtiyyvZl8fWaBn/DTeLgdb7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

On Wed, Sep 04, 2024 at 07:40:43PM -0700, Nicolin Chen wrote:
> It's observed that, when the first 4GB of system memory was reserved, all
> VCMDQ allocations failed (even with the smallest qsz in the last attempt):
>     arm-smmu-v3: found companion CMDQV device: NVDA200C:00
>     arm-smmu-v3: option mask 0x10
>     arm-smmu-v3: failed to allocate queue (0x8000 bytes) for vcmdq0
>     acpi NVDA200C:00: tegra241_cmdqv: Falling back to standard SMMU CMDQ
>     arm-smmu-v3: ias 48-bit, oas 48-bit (features 0x001e1fbf)
>     arm-smmu-v3: allocated 524288 entries for cmdq
>     arm-smmu-v3: allocated 524288 entries for evtq
>     arm-smmu-v3: allocated 524288 entries for priq
> 
> This is because the 4GB reserved memory shifted the entire DMA zone from a
> lower 32-bit range (on a system without the 4GB carveout) to higher range,
> while the dev->coherent_dma_mask was set to DMA_BIT_MASK(32) by default.
> 
> The dma_set_mask_and_coherent() call is done in arm_smmu_device_hw_probe()
> of the SMMU driver. So any DMA allocation from tegra241_cmdqv_probe() must
> wait until the coherent_dma_mask is correctly set.
> 
> Move the vintf/vcmdq structure initialization routine into a different op,
> "init_structures". Call it at the end of arm_smmu_init_structures(), where
> standard SMMU queues get allocated.
> 
> Most of the impl_ops aren't ready until vintf/vcmdq structure are init-ed.
> So replace the full impl_ops with an init_ops in __tegra241_cmdqv_probe().
> 
> And switch to tegra241_cmdqv_impl_ops later in arm_smmu_init_structures().
> Note that tegra241_cmdqv_impl_ops does not link to the new init_structures
> op after this switch, since there is no point in having it once it's done.
> 
> Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
> Reported-by: Matt Ochs <mochs@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 83 ++++++++++++-------
>  3 files changed, 60 insertions(+), 33 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
