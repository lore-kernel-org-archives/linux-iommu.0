Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCB359A68;
	Mon, 24 Aug 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593057; cv=fail; b=C0YzC06AjtgUg0+dyIq8p7YeQkZDad/OLUK3iVD7lfqrra8/IZyMX2n4rimooUZebSEqaGIdUewTCSHOPDWTq0Evk5741L8iuMiFZgFRNeF3JiYEEl+8X8BuhhfDouykj68cSOOCzC4574Hl3mTCisXONpqKus5oIi62OhCxxOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593057; c=relaxed/simple;
	bh=Se8cRfs5y8ZMzxYdVjqpNqYVQ8hqKePNv4OVk55CS5E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=me1Jqb9qNTmsudl9aSQL4U3f5UYhzfoWtbXJ/LeahyW3l27GvwxwnfFHoFdqxAX8cqr1y31JQy6Z2EnKs20W0Bf16gmSY4xZLt5QKTD6pzLPfxP3q62EFwtLJl5QOdx1B3y8Smi2tFpkJWfKFpjzkNv1+yCUks7AsQeEGXiAN2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ktyKXM85; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ktyKXM85"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BT+w3hpfiMHYh8DDA+KUsfL0LsnSO8M1dSXebU/Q3ZbUjaqAAQ51FltXYvLA76DnPzbEXeGaqev4DStV5lcTzmqcJdMUQLBxoxSA9Tmz/3IC1lkkOdQhiz/h8QQ0l7QclUdblfVnGncqnxEX0hFS1I8JnyW6h3ox1QGSkoFSoVS4WalVIoyRcRB2mRW1Ofo5a0GbvbO4P9jA3ittzLr4hZwXtMRWx9M8/dX1Z+zMTeDwx/oERIPRkCJuqUKhSCswuzG4Jf9F64Q94GyByVM+vty6ozXCLpIUHFR8wCAlLY1aval4ELjNinHuKJPRgE1A1v6uRI9wFAf5IP9/jXsR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/v4/Ju3TA+grNjG8VSenMc1hAaIAdhudawg5hoWdio=;
 b=huDHUYvATCFSMp/qF0/urKLNm6ZXnXX/LV7vDxSegz/qRWmYQielZW1kf3/audmHeLvm0s6eJxsOlv2HOgeyJZE/mm1ojZcotQkBsb5YILXRrimsPliWSt9uWCalCo+KNKrrP5f8OCtUei3i85gHqhDS7u2Ti3PBQFvWMi1L7YFnATqnvy3C7lIPk6G7Makm3XezbR/4B/p7feC7z4X8+B3DmToAxgMgUhcAkXmmlvYodKvMDBYSfSwm0IMBT8xRVB/0xnUvcOxQIabbB18wdewILsGSzbZkvYMCevdDQxLmtu1ZMwmHl5G80wA4l5MdvquowUe7vufI4vqeijfXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/v4/Ju3TA+grNjG8VSenMc1hAaIAdhudawg5hoWdio=;
 b=ktyKXM85sEOpccectpir4qL5hUZzA4g5mvYP1sGzo6uiO2UcJZ4A+Dx6umFzSuiM6J7TFSyoPkHasBgL/5SzEOby81wJJliFX/op+GJpSy1XMgdQ37t433RxW+NSo+BNeAXrOPHmdKFxYq2SCd3MQeD8rnmO359B7SSWQGHFl8MZ1LO2Gzyehs+gvffotF9H5EQ+/H1+GG2U9Mx6j9jfwS2SZr4XZfiC6H1f0XYLs1jtEMXwYqHCN1M5c68/Wbho5Dup2CQ5l4Gu2CiK11OMK5g5jg0cV1eA8O1goyG4CRz1/TxKJeYPJd9LMEgTKMzmQkWShpXJQGv7OF9GanFJww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:37:24 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:37:24 +0000
Message-ID: <c682982e-a807-43e1-a7d6-5a0bc96d1d24@nvidia.com>
Date: Mon, 24 Aug 2026 19:37:19 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 0/5] swiotlb: avoid swiotlb copy on network sockets
To: Luigi Rizzo <lrizzo@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260824152932.1583506-1-lrizzo@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260824152932.1583506-1-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9564bc-e719-4810-75a8-08df02065bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|921020|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q70u1rohmYr/d/YCgJTr4ZankEgnBEOq0GC6nLf00/Mw/eECM3oSGgMps9ylUDM+4LjXQ0NDOg4BK88bHmdgA+dPl67L2SfjUqlhaKs3031uwE/JWun9ATnAa4/ZeswqZ1Oq4Q/qi0+l1tL8pVLAdvwf8KIB/dL/8OhB1fITxDhBy9MOk28PyS+2TkMmtg/zCi5lGk35EmW7F59HebBI+5nn5pVOi4KdVTIekjtri+8hWrRE/0252+IqSCZ5WHFeSykO4IzjGFUtq2jXgmZAC4xBIi6Vp3ua9EGyLNENZjkSaUBBx7BSQ1oGocWHp3bltakle2DzR1Vr87chWbTt1XInCQdbHP7TCgWehpBQkyxViu/bT1lfVY1Ju2eSY0VQG9GWNewQHIg8fZNEaTgRb+UXfjYoKsw8Tt9MRoqHKCrZuWR5Yu+q+gNfuZMkI58QJJ99+BHs6AMY2kJDMPnmE2HzMDY3/LvZSljsOaXdoiAcIAUcHzn18SPvbG9FQdzcj2W8VIXnol4YMgko4NR9tbTI65twCaVclLwInEGYaX7bwddUA/BaBivNDTvx1mVDRXDHigxSGc4rm6IioJ4JrMuJ/b+f20n9Osrs9oQqNfX7pXwBUQt/1trXxPjTbde0kXCDwNegpgI7iKgL3FbxkhSvad9Xx0T67aSmNpGmaC5d07IETYcDliRF0H/0dLHJDOB7HS9WOj09YYJMZG2gAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJOSERCUmdVOEpOQjg5NUZqL2J5SitNYmUxeWhZamlhNVA4S3pJVHErMysw?=
 =?utf-8?B?YUdDVVFBWW1kRjJ1YUhrTExnb28wWWJML1dPMVJxWEF2RlFVN3g2TkpFRHIx?=
 =?utf-8?B?QUszRktIWFdJZ2ZpaVhYVG1CNVVLSFdZR215bndGbXovS29UUERRNkVVbTZQ?=
 =?utf-8?B?QlJGNlVBZysvSW5yQXc5Rmt3YU5rbDQzMlZLWmVkaXdwTldoU0VhN1RnQXdy?=
 =?utf-8?B?OFNaTU55ZkpiRm5JWENPakFqV3UyblNlTG83TW9icE5xYnVZTXN0LzE3ellU?=
 =?utf-8?B?RG4wa29yNnRHVGVUYldSaThyUEcxdEk2ZnlCSGF5bHBIdmFMdzc4TEdFWGZP?=
 =?utf-8?B?TDA1NEVab25pcnQrcS9RWjZIaTUzMnNOUi9KR2FpL1YwN2h1M1VqL1grOCs2?=
 =?utf-8?B?NHhXU2lZUzBCOWYzeUtmM2RjSzhBTGo0bFV6WGlySVIyeFpXcVVUS29MUWdp?=
 =?utf-8?B?WisrK3NPUm9xN2xYMVdobHcyK2d0OVJPdWxnVlM0T1hyZWg3KzlTalF2bkYw?=
 =?utf-8?B?OWpaVlFWTkl2VzFxYXNLcTlQRVZYaldFcDl2M0xCaHRyQ05LdlQ4K1NQbFNq?=
 =?utf-8?B?bXNxcjExVUdCSWJQRlpNcTEvR29yMkZzU0FwSkJhVkphUElNODRIbHRKTElq?=
 =?utf-8?B?eXBFVTVucDVNMG45REEvcVJjekhBaXVLaW55UHR3MEdFeW4vc1Vwb3U2ejBC?=
 =?utf-8?B?emh4SW1OZ2ROSUNUK1NldjYxZVBsK1VINjRETlhMZWN5NjNPUVVvanFYek5n?=
 =?utf-8?B?QnVQek1OQ1J1a1lwVUE1NEE2Wm5hQ2VsWmFSaWR1OGZFNnRrUU5rVkNpSFd2?=
 =?utf-8?B?QloyRDdRT1E0TktHeVN3OXBMZk5YS0xlcHRvem43N1ozOVQyV3c0eTM2bmc2?=
 =?utf-8?B?cUxwTnNvb3I5d2Jyb3lJdzZ5U01CN1V5c3dxaFp2bHRyVkhGdkNobUtsT2Jl?=
 =?utf-8?B?UzVZQ2Z4M0pRaEEwN3BRbVdadkxmejRVUFE5Q3p3TGhtRUVYSGZPdlRSUE1a?=
 =?utf-8?B?RUdXY24rMElzQlk4NTJtNjlCYVBQLzBnWCtJakY4dmxlK0R6Q1llNGc5eWZk?=
 =?utf-8?B?bHJNMWtQSnRVbWJVdVpHa0ltdDNhenROdnFHQUhjdyttcEduOUo1ODg1c1pi?=
 =?utf-8?B?UVhlV1ZldmZScklsTmJWSCtrTDl1bmRCK0lmQ1pvVi9LZXVLbTJHQzF2QXVY?=
 =?utf-8?B?MU5wU01ZdGJzTDIya092ZC9HRTR3Q1Ezdnp4ZEFKYThiSnR5K1crU29kUVF6?=
 =?utf-8?B?eWdOZWFVTmJ0MUNRUW9RVGlDY1lHWHY5YS9KM2F2OVNwQW5IeWFJaGl4Sk02?=
 =?utf-8?B?LzNTOWhEdnhBVUpVckFiUmtqZlRQT3dnKzZncEJ3TFVNSjh3RTB1VUNBbXdS?=
 =?utf-8?B?RVdXN0F4RWxqTEtuMDFrRHdaWENqd2hwMU43TnVhSnI5aitqcWFsdUg2Y2g4?=
 =?utf-8?B?S0dOL1cvZ1VFbUZrTkxSbm16TVhmQTA4Vkk0RjUvSU1iY1VxUnBxQUkwZnB3?=
 =?utf-8?B?RVZvTVZsVksyYzdoKzBvZ3l2Mk82Mk1vUitBa2EzeEprVDhFdzdUYTkwLzdZ?=
 =?utf-8?B?SjRsYlo4UU41LytobWtBbng3cUh2Z2RkS01YNEg0RjdNc2NDd1Vtbm15cXhM?=
 =?utf-8?B?K2pubnNVdjFYSXVpTU5IdW4yNXRtZGVaUStjdGRPdUVpMEIvNVhNaXh4NEgw?=
 =?utf-8?B?cTIrOVMvcDhnRXl4VHZub2RpZEExU1BsOXhmV2ZxQnJ4RzE5MlBWellpaTFV?=
 =?utf-8?B?QndkSkg5MHNwYXFQYU9DVFhIdUlwWUNXeGpiSS9PSWlaS3Vpelo3bzlLR1BN?=
 =?utf-8?B?bllsYlBhWlBmNnR0ckRpVG5WZHBiWHU3SmxGN2ZGakJuQ0dQUlEwV0FxZUZ0?=
 =?utf-8?B?UUR4emhoaUR1OW5rS25WSVdnKzE5T1U4SHZha0ZDbmhhWlYwaExTa2dSOTc3?=
 =?utf-8?B?SEZGZDExSDg3ZFlSU2ExK0RMek0wbkl2Snh0N2tka0t6UkhFQnJmcEU3dFhV?=
 =?utf-8?B?elVkZktnZzVxSkt1VThFbjdBZ0Rlcm9aQllOOU5TbGpGQW13NE83OVYxNWlm?=
 =?utf-8?B?U1ZtUzQzUGs1dHVwYWRhNHN0WWtiSllnazkrdnFhemtYRFFJelhoKzI5U2Za?=
 =?utf-8?B?cXdmOElRcDdTYnk3b3VqMHBsdTBYblFwazcxQXBSYUNLeTdHWjhmcEFIRlU3?=
 =?utf-8?B?cnk5OTZUMkd6bklVa3dITmxMbGpqWnA5a2tyYXBadEMveWtqbGZVZGtZTW02?=
 =?utf-8?B?WEt6UnlGb3dYYkdQOHp2eWMyaXVyUDAzQTUrWHNYdWp5YmhtSGZHQTNUcVRt?=
 =?utf-8?B?M1lTSG5LWkt5ejRtR0w5cE5rL1V1dDBtZE5ONUxZN0p0OXdOaUEzdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9564bc-e719-4810-75a8-08df02065bb9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:37:24.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NgcRRQzKtg9F1qyE/2goT2Ud19t67hUDknG9EJs9WBlIAojy/egUsA3okaQNytibx5R3+tyH1IgwU0WhVIpYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514



On 24.08.26 17:29, Luigi Rizzo wrote:
> The use of swiotlb, common in Confidential Computing, causes an extra
> data copy on each I/O. Focusing on network sockets:
> - on tx, the copy has a high chance of happening in the tx softirq handler
>   (especially with greedy senders where the device queue is often full)
> - on rx, it is guaranteed to happen in the rx softirq handler.
> Thus, on top of the copy cost, swiotlb concentrates the overhead on an
> already constrained resource (CPUs processing network interrupts).
> 
> Reduce or remove the extra copy by conditionally allocating socket buffers
> directly from the swiotlb buffer pool.
> 
Isn't it dangerous for RX to expose kernel structures to the HV? If SKB the
linear area is exposed to the HW, the headroom and tailroom are up for grabs
for the HV: the HV could modify them in a TOCTOU fashioon.

> The feature is controlled by runtime parameters to set the percentage of 
> swiotlb buffers that can be used for this purpose. This avoids stranding
> the entire swiotlb pool in socket buffers.
> 
> The implementation is made of four main parts:
> - introduce a swiotlb page allocator that can be used instead of
>   regular pages, and teach __free_frozen_pages(), free_unref_folio()
>   how to handle them
> - dynamically track the leaf device for each tx network socket,
>   so we can tell at copy_from_user() time whether we need to use
>   swiotlb for this socket
> - modify skb_page_frag_refill() to allocate from swiotlb if needed.
>   This implements the copy elision for the transmit path
> - modify __page_pool_alloc_page_order() to allocate from swiotlb if needed.
>   This implements the copy elision for the receive path.
> 
> The savings are especially visible with fewer queues. In synthetic
> benchmarks, senders with 1-2 queues would cap around 50Gbps with
> conventional swiotlb, and reach over 170Gbps with the feature enabled.
> 
> OPEN ISSUES
> 
> Currently the swiotlb allocator looks for free slots using an
> approximately linear scan of each pool (with some hints to likely
> candidates) and then does a linear scan of subsequent pools.
> This works extremely well when the number of pools matches the number of
> CPUs, and there is plenty of memory available. In fact, it is almost
> unbeatable by any more complex strategy.
> 
> Under high load or buffer fragmentation, a CPU might repeatedly do a
> full scan of its starting pool before finding a suitable candidate.
> Even worse, with multiple tx/rx queues, what happens is that multiple CPUs
> will trail each other on the same sequence of pools. The effect is that
> some allocations will end up costing O(100us) and more.
I encountered this as well: even with maxed out swiotlb memory the
page_pool will suck a lot of pages from there. And TX allocations are left
scrambling for scraps.

Why can't we create per device pools instead on relying on the swiotb?
 > 
> I have tried to implement two improvements:
> - a buddy allocator on top of each pool, so to make it quicker to find a
>   candidate of the requested size
> - make each CPU use a different sequence to explore other pools in case
>   one is full, so they will not end up queueing one after the other
> While they are very effective on the tails, for low load scenarios the
> current linear allocators is better. Thus this will take more
> investigation.
> 
> ---
> v1 -> v2:
> 
> - split components into separate commits
> - simplified allocator, no need for a new page type
> - many code cleanups
> - also implement the rx side
> 
> Luigi Rizzo (5):
>   swiotlb: enforce pool nareas and nslabs invariants
>   swiotlb/mm: Implement SWIOTLB nocopy page allocator
>   net/swiotlb: Track bounce device per socket
>   net: Divert socket allocations to SWIOTLB for nocopy TX
>   swiotlb: Implement RX nocopy with fast recycling eviction
> 
>  drivers/base/core.c       |   1 +
>  drivers/iommu/dma-iommu.c |   9 +-
>  include/linux/netdevice.h |  21 +++
>  include/linux/skbuff.h    |   7 +-
>  include/linux/swiotlb.h   |  63 ++++++++
>  include/net/sock.h        |  46 ++++++
>  kernel/dma/direct.h       |  11 ++
>  kernel/dma/swiotlb.c      | 296 ++++++++++++++++++++++++++++++++++++--
>  mm/page_alloc.c           |  61 +++++++-
>  net/core/page_pool.c      |  25 +++-
>  net/core/sock.c           | 101 +++++++++++--
>  11 files changed, 617 insertions(+), 24 deletions(-)
> 

