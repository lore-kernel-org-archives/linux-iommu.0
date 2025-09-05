Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2A1C8630
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113468; cv=fail; b=O02iYgAajg/Jx7ZQWzHAWlUuwg2z6e47orf+C1vK8syLd/DdSA6LgeRzmB4JUWJAy3x3GhlISfURPfhqY9FU11J2yxiPFRx6FaeatXlQzEApkHkKu2LoJquh28tBIVc/STM/nqwKG01M9YBbigZFDE1a/CqVJrJ1E1JrdmbJxXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113468; c=relaxed/simple;
	bh=5yik+I/VZ1Qk7WGe/i1HTIpKiDo5oZCA80+QvUkOXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GKFv+W14Pgw/7BdqaNUMthz1XYx+Bpk2p/Alzl9d6WaAZG4hGPPJqbh8OG5/oUzVnT1KoPtBXMpMFd793zLeu3TbVJInrEJIWW5ICw4j6Tc1KxgTXuTG9rgYthSFgmpg1GuHb+xCMMRjCZSKUR6L5Da5rdHLMtE9gOcz2zyD3Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRAGteOp; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LRAGteOp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb3EGG6s7W/838Rog8dOXQby+Jrie6iagyh8DLrdNxQOhvtb/tlQiWesYT6YUMUDf7W7VsjZA2k2dETBuZ1i3cN9UFqVQXlGno5igC/Hx27pTO+U/Ee8Id7i/zq4U10TfqkIWGaIuLFtWrCTGeXGNHNdeEZd7os1C4sIA2yq0LnQLFLtzZxvQQtqo5RykaYqSPz+CUXZwNs3eu+6LsOgGw9vLVtDko4oEUdadlqD8RaEpUU8nXkj9XIOEP4aFGXdzCn45RuvWAaiyDS83f8wyfmqUzYryfhe8Qsq93QrLB16pTB/rI/77hGCf5L9Eej+qaUwJxVz1BPD/+WaqTcNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQF4vZcFHuMz3R6RoESyPUrRn0LlxYTjFJXQMMfWilI=;
 b=jw8MMfqzez7JuLIe84vDcYuBMVnFqtOsPnhFQEQ/+m5myf7jOyn07Vry+cwyYn7vsYTWDWGnvSsel6huVxsm/dBW62wk09JurUfaLXVIIhbXhnIc9jW/Qy/rmu1dNUAIX56wzNIie72xnYST8SMQ6ZUbFUsD5YWUuEMFj6SpqagzvLF3jULf3O7qwEcb61o+qJlnpmQg5c1Ub5pY8fyBYtG6PY2waxAKN1DS7z7aDFhpO4RTseJWF4ZGQKbF1nh4aZQkn9/gZrOE3xHSr2OJux0ss6ZM+4TvVA/IyqkszfbmGAYIO3F1cEAoQHUcBE/PI5lBa9B0Qcu/vdJMRdq5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQF4vZcFHuMz3R6RoESyPUrRn0LlxYTjFJXQMMfWilI=;
 b=LRAGteOpJhsns6Hj/3b4Bv82vtw+0TLRLmXQDuHQW/n4G98DRsEb4QyX0qk3Yc+WrNGCyE6ttrvTpa4iQ6ywVKjTiphztQKl5cVFMh3djmqnE6B2S8T4gSxiy1RaC2A8x7SK/HKQLSlV1lsL0ueOKDuDu5Q+C17c5nVEk/+RVExgw3wHwW9wI7SrhLbqi7Kgs1S+k71T47P5CbN9ecp7t+H0Lmc/EOY2zFxuEyzSqFpcVCyTr4HF6/OjuUW5N576oopRRQ9PxfrJ5k8nIBQhqKiFX3ho3eJi0n8rVmDCiCNxbH+KfKoryZweWoTygXhg280ZFbeOCM+BcDtZwpm5FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA3PR12MB9092.namprd12.prod.outlook.com (2603:10b6:806:37f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 23:04:23 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 23:04:23 +0000
Date: Fri, 5 Sep 2025 20:04:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] x86/mm: Use pagetable_free()
Message-ID: <20250905230421.GT616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-6-baolu.lu@linux.intel.com>
 <20250905184115.GQ616306@nvidia.com>
 <04983c62-3b1d-40d4-93ae-34ca04b827e5@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04983c62-3b1d-40d4-93ae-34ca04b827e5@intel.com>
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA3PR12MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6bd19b-65eb-42ad-fe0c-08ddecd08dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27LtBDSEiucwHwmsXnd5Wie2ZFB+41RkOMtq3pqipRbw15JzScqYJifSeQw1?=
 =?us-ascii?Q?xyiefusEwJ7ixmwQX0npbVxldKFUz8ACDsPUcbTeXy+5jR9CyTRvfLw+x8pH?=
 =?us-ascii?Q?pVxibyb9xryCzY1MNX8RPgupojpdZ98KOS5g8Spoqnz8G3B6G/ZDO5tAEG0o?=
 =?us-ascii?Q?js08oPwV2EsFNMLNZhFHc/Z050h2rsx9HcilrxR/7tscEYDR4xvw8IRzkSKV?=
 =?us-ascii?Q?iaskmWByCZP+5RoDUN8zd612QQ7WYBkAmmuGTGje1xGvfpnYymWEwK3etF3Q?=
 =?us-ascii?Q?QsH2bMLW6PG1v3kPSlTTKgpKjwUK2z1KhykDQsehV9CeutprTDX/Km4wwg7c?=
 =?us-ascii?Q?/uTyElleZ20cgdv0QM+7gb3SUPrrUe+RIrwgMpufTDVZtjkE87riaTLAb2qd?=
 =?us-ascii?Q?WuDI44uYYA5qsCjRw4WrSAHIPQeR0MX5skKRmqxockPZjPmzar9z995bZRg9?=
 =?us-ascii?Q?ZRrlkLau/uyHEy3FUKMk8GxLtsTOKNRUKp0jLG3stCtyvI+yB8ku0N/m+4zb?=
 =?us-ascii?Q?D5zXj95qXqpYAaSHT0gTC6fmTZyPE5COWKgLM+ufxPBY4lGRyDQnU1jW5faA?=
 =?us-ascii?Q?Xondef42cx+LIpRYBZ/KyTn55zZif2dP1rz153zDsE5me8J7hAmTMAri3Q6+?=
 =?us-ascii?Q?aZB8Hd8EWV02tZJxazByjPVbfUXe0FHan6rxmvLkBNoua13/2rAgC6k8UA4q?=
 =?us-ascii?Q?JSRk5x3vvvUQwt6hwqG0dXXfgFOnAC8vIY+zkoQmnGI1dE1vw+6k+4xPd4yG?=
 =?us-ascii?Q?RtWGiDqipOjPj6Lk2/+8AuOGTM6vDav3QJPuV4pmO7PflvrTlNYL2of33Eth?=
 =?us-ascii?Q?xbCQkql8HrPxnKMWsa7F15Ms+mDLUQOLdusHaD9JsjiUZCS5Q1eErW2EKGQJ?=
 =?us-ascii?Q?mfXNsoMiqKTeh68c5weFP4lAEAoENtiiQNTomTX8PdzpRQpveD14I3aPWX8C?=
 =?us-ascii?Q?39UdnGiR7qwvMeU2qm4GGdxNXYdp4AOGouuEPM1aMV0NMf6kfwmHttaQuPR9?=
 =?us-ascii?Q?WIvyxci782Dn+AxUurM1tv07aKPvyoqSgJjpzjRDUSmo28YynMl7JCprLV3b?=
 =?us-ascii?Q?2jUglJ6DoFzhdMLypPPqW5D2KB8SHvzStbE2gfGpO6CqIFHlZWg1koYBtLcy?=
 =?us-ascii?Q?nqHst+w0tzVw/96/OXoNHjDx01K7xK003fmqVLE6x30Dw9swWW++TR/w3rgs?=
 =?us-ascii?Q?sYsQoNb6hRWeLIcDSnCgEMKMW0ymW8M7Ek2fVSXhusz5oAYKfNShKpBZboqN?=
 =?us-ascii?Q?0rUPM8l/UNiJG8NpC7H0OzO/sLCXuh+z3myfklLtVXClGPqwolomCsZGJIHq?=
 =?us-ascii?Q?pu8XN7XH8247YLx9wEP3qluxLCGiZ2CocnnhK+SH4T/TqpTjCCtNm6HAVIcH?=
 =?us-ascii?Q?V1CTBM1nSY3PyBiWsfJEhnqW7+Q/4HW3JklbYJc56JPTtNUchqwBSsizob3f?=
 =?us-ascii?Q?ihvFAeFNdek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PF0NpQMHsKPNnXGIGcGiykL0IiQALPlc9VhCQSHE7Pm+FRQlgzw3jYH4AYvH?=
 =?us-ascii?Q?cDvKW6URdDpfizE6ikRBQ5PJsPzlXjZIfpfP9Q772z+pD0lhnyRc4tH9cIrq?=
 =?us-ascii?Q?Eq8JPaoZGQ6a4C/DDso8FIb4EB69t/I5vqXjULvVjmyZx7CkFED+1dRpm+QD?=
 =?us-ascii?Q?nuwovKpm4SkbLF5EPsLN9zBJKfIEe1/ZYJuqZWCHraWxhdjdrQ8NxDEQltDy?=
 =?us-ascii?Q?8iklCcrJYpNCcu9MMBZwI7JmB32r+8ednqMHYACnm2QWEMgOplyyYCWlxtMA?=
 =?us-ascii?Q?WnPwCDjOFAktV6zXYg2BoUiIxssB0FdQ/A4H3IancKf0j8j08X6TaHDKrQvb?=
 =?us-ascii?Q?gnTSzl81oKOamaFC6kC1TWbz3UnjAEWOgLr602i1UfKB+z2KU9ForrEerREe?=
 =?us-ascii?Q?OqKo7x0OHRTr9M25zYo6H2W1Hn8WDUc2Dmz1EWVtDkDZIDym6V1QtaG2dH6G?=
 =?us-ascii?Q?nsBtu70/m/08MkNlBvvWOMoRpsllS5C3bjubWF01z/1dy/veqzb/OyNlmF7r?=
 =?us-ascii?Q?y9Tde26F1vlGhur8HRtaBPlXK/hUJssm4plT45SPxVeO7IhfWFSOSdePvjMi?=
 =?us-ascii?Q?Vbh4f1VZzE4wxxM/hTLyunSOYlC0XM8NFRaPmqEgRDMWF90+sy+B6NNBC0JP?=
 =?us-ascii?Q?FZLSF+Dj43oqjmTbW2+BtzWB9yt7sNDIWWtwok357TCe+wVAMEZ8JgQcnWk2?=
 =?us-ascii?Q?gpxswZZov02hq0KAU9bB8bM2Byc06RKDZPrOEqnr/hkit9nqlTihLV5yuc4L?=
 =?us-ascii?Q?M9Nq+PBn0AgiZwZYwpNipIlToTSBjY6E/pBtpORNTU5DnFf80rAx0Iq3IOj6?=
 =?us-ascii?Q?THQ5dyng66ES2TEurX7NChqVbbbEVq9qQMWvHvntyWoonEg81S2oxYNykSUp?=
 =?us-ascii?Q?G9RGFlC92xDHLLFweQjO3+QTNh2as/PcKl3HOkdi8NJWzCbKZzs98CplW9Fb?=
 =?us-ascii?Q?I3ptrXSJ2fC5z1NfEaehHyDPSyQqC/7vZLktAvAvMPmifCPGkEt4AWh/uNQO?=
 =?us-ascii?Q?Y2N3EuRPt8logh5mfYfSHzfGfVts0LcvjVXoApOsIsOeumKufdKgZQvytpaH?=
 =?us-ascii?Q?iDFE+y1Ml9G0Z5crwoYOT55Eu0IIHDA/SxqQPf/WnpWDPCANGffUz7+1cpV9?=
 =?us-ascii?Q?xbSElBjDfCdhOGA4+xuvAk42KCksmADKXzHx0PgFHQgSYqUdizKltFkMks77?=
 =?us-ascii?Q?cbr844kVmpY9IYhWwFTM0ab2bbXZFvx2pCe7Hwv4E6T+HUqEYM7/uRDm6iuI?=
 =?us-ascii?Q?4hQqvLtmrorsLpOI7qlBjp17Nrmv0VVNF4Ksts4n/XXWNFYH00o1dxMej0Ar?=
 =?us-ascii?Q?l8gzUihS+2D1yxc6wAmmUgZyFbQX23BZuAYhJ2IeTbuoSSIk5fy6rL/p18tA?=
 =?us-ascii?Q?91aaqFTRj0zp34JFgWpIwmDc8aKxKVdsb7YVVaJd6hNSgmAH8AGzKILYOyal?=
 =?us-ascii?Q?OpmOj6l3Z/tG+BsD93ePS/W5EbjyhEhAXVBOp0fG+DJpghri/XQXWkE1cmg2?=
 =?us-ascii?Q?ZTZnMgCxor+wMp5gU9/LKSfhHzFn9zg+0uZud0Gm4m48PShD/LOcDzRux2p8?=
 =?us-ascii?Q?FIffgP0y2J2petITkrk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6bd19b-65eb-42ad-fe0c-08ddecd08dd5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 23:04:23.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9PK3EfxMD2dagw0XYrTeY4LMOQlj8B/Syre40xNgqZ4FBEdb60JHs8pVIvo0vk2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9092

On Fri, Sep 05, 2025 at 01:11:15PM -0700, Dave Hansen wrote:
> On 9/5/25 11:41, Jason Gunthorpe wrote:
> >> --- a/arch/x86/mm/init_64.c
> >> +++ b/arch/x86/mm/init_64.c
> >> @@ -1013,7 +1013,7 @@ static void __meminit free_pagetable(struct page *page, int order)
> >>  		free_reserved_pages(page, nr_pages);
> >>  #endif
> >>  	} else {
> >> -		free_pages((unsigned long)page_address(page), order);
> >> +		pagetable_free(page_ptdesc(page));
> >>  	}
> >>  }
> > Er.. So if bootmem happens to be under the table and we happen to free
> > it due to memory hotplug we don't go through the SVA fixing path?
> > 
> > Seems wrong??
> 
> On second thought...
> 
> Yes, freeing bootmem with no SVA fixing is wrong. It should be fixed.
> Period. But, it's wrong one time for something super rare: memory unplug
> of memory that was present at boot. It also can't be triggered by
> unprivileged users.
> 
> As-is, this series fixes vfree(). That path is not nearly rare, can
> happen an arbitrary number of times on each boot, and might even be
> triggered by folks that are less than root.
> 
> So I kinda think we should just make clear that this series leaves
> _some_ holes, but I do think it should go in mostly as-is.

That's reasonable, but also your suggested change is pretty
simple. I'd put an arch hook:

static inline void pagetable_free_kernel(struct ptdesc *pt)
{
       struct page *page = ptdesc_page(pt);

       ptdesc_clear_kernel(pt);
       if (!arch_pagetable_free_kernel(pt))
              return;
       __pagetable_free((page);
}

With what you showed

Also, probably need to ensure whatever allocates the bootmem in the
first place calls ptdesc_set_kernel()..

Jason
