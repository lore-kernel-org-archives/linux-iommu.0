Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFB223328
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195242; cv=fail; b=qIak98M8pjgvFI2Oss8MMjFWUHtTT8NO1+mMYvvXOG87m9Iqu2VV+yiDpWNBuzwgxfQ96uU/7e9is+iStEsZTLz0AE2bdrBUvZszt1fsczb0jB6UChcsTlRRaHhmJ5Azv5HqSf7g2RLMMZlqg5ihxLbhxRhHKK2Y9aFVBjeyCJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195242; c=relaxed/simple;
	bh=oK0TDS3hpMlBY2XtkSor1eqcEA+MbroYXIOLLbY11DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Alyf7TylHXFeW3ZEwlpIQptcX4TCkGdIc2zNMW3alP13nl6eMa97NU27hGs4DLkVLvejtS5aUHy0j8OXREpsHsrRviB9zaWyWcfTOJ2jGXrskWeSL41SL7bnfjSvQxztK1FibaQ4ggqllmzTUPJm93Yaw1kX9ExTaXWMwQwlkec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=glwU3Jvc; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="glwU3Jvc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QazwUxBsbwq9qibciO4xKX4Y/t/A0AqRcgd3fSAnw4zU5sqZMPrkZ64emb6P+SiBf+s1SMQEi5g7QTEhbCwul0gbjud1JjIrqX1AIQ/ETg1LliL2b8GTEfbyW5AzRDDwA58D6wSj9em8sUKd/bkDAVrv+Jb2uBri9i/TkvvqYDA7E3w/t5qsMDDx4KOcrOPUbo1Cv4kbBgKvBH822SysFu8jVW9Bm1XUPidFmq2E4RG3yWYvcFRc6Fo3yxluDG0tZ9tB471ZP00UrBscqvNcRCkgEj4lt/7fFvyUuvNw5MYSy1ZpUTH4ObQ2ie7XgSfWtLZsLfFwcXSsjmrYplG7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSPBxFiBCVV8wSWR0ES8iHy1sws2p6+x2B6MQtKawPI=;
 b=ABmicUtiPmNmWj2K48Tr/0OVZ1RmVg6nX5scMQvXxbDHsT68nMrxDdmYgQgIS6MlfVStT0ie+1Oiovz8LPYpu+jI8VAUTRQXOkVIyO4c8cVz3/HsncfpuwwdyBYytqaCzF5rw+fawi6+93OmBxdk2rygZGM0/3oM5gGM4BeWNgO0ZTUU5rp/xknNcn7iLZRIvyRksM8tks52B6XaYKrgit4o+wN1AytMVspFptHc0+p1VrDtZVN5MsYBOCQ1W2ULkdHNAJWWKWXFqadsJ0a+t7CueQxSD+SOCzasYrhXdleTezLlGMGKEChbE5wyu/7RJhk/L/nl19xRobH0GeCuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSPBxFiBCVV8wSWR0ES8iHy1sws2p6+x2B6MQtKawPI=;
 b=glwU3JvcDxtH6+SEW7Phv62KaGeCwBLMfIYpWjFqfS3JAV+CK5KrUc/oGyzKoawZfJMC3+8XyALRFFs6UnluSA0ITTLEv4daQhRWPmIJUgj0ueJDgFeVaDOElgwq95xIguxixp/mI2xMthgTNwwYj7nmy9XSFkaKvLJbEYjS8vU7Hbzm6Lo19OyNqNJmmRfpBhlHZi7vd6F6d8698m2cyKjUqvQxpKtuQHaS8cPCGCvVGoL1TnlJ1BZH94fMzMVFarhnH231w0dxckmgpnDTu4YafOurkUSfKrsXOh7W6VtU75nqnHZ686rRJ2p2HVvR521Xt1ZJDi/sX18nDy6b5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 19:07:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 19:07:17 +0000
Date: Fri, 23 Jan 2026 15:07:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Francois Dugast <francois.dugast@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>, iommu@lists.linux.dev,
	intel-xe@lists.freedesktop.org, Joerg Roedel <joerg.roedel@amd.com>,
	Calvin Owens <calvin@wbinvd.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <20260123190716.GB1134360@nvidia.com>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
 <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
 <20260122133131.GL1134360@nvidia.com>
 <aXOhbK6Ed9WPbz0u@fdugast-desk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXOhbK6Ed9WPbz0u@fdugast-desk>
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: fd70fd9a-0455-441a-3da9-08de5ab2a00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJHLtq+W5lt+CZ5WYNi9JlJU26a2EoyackUOePPmkAOnUou3OSGfMRkOxTOB?=
 =?us-ascii?Q?Gm0I+CKAPDWqC5kGm7AD07M3+8LX1jxJuaw0gIDwQ+ehXlS6XExLQ1gW6yV1?=
 =?us-ascii?Q?xi5l7Alsw46T8NeheOvS1hUGoaJBU6xzK0Y1wgAihD40SwS816hNPyqdLgja?=
 =?us-ascii?Q?qCyM3jhVUzyD7mX/5s89+PyYske84mRB/P6ELP0Ay2yprlWSTszL2SjbjwDC?=
 =?us-ascii?Q?Q14PQYhMTzkMK4k6fnuCKeYHGjAYAgvaGFVL69tkAo9OCBHGe6GfmsT/AU1H?=
 =?us-ascii?Q?42jMp09111uwzc22fLW1xymkxVYtAbaOs1Sw7oz0vlPALBVnkM1O63G0B7UB?=
 =?us-ascii?Q?HE+oaAgaA28GPdvLoN7cfbR3GcM9hava94SuHTCSjQGev2Tq5iozYbEJIxT9?=
 =?us-ascii?Q?DDdF1pEFPMq1s5V9kllsJ7MaFkAPFGPED6xD0I0OwDJ5n5bF4NBicBs7h4e9?=
 =?us-ascii?Q?POpIIdAcNawwO5Um/4MIYgzXYCbva4v6w3lKZx6LXuy2EpT58d+IEiHQXkjB?=
 =?us-ascii?Q?ZH+GWkMjwAhJgXThT3Xh1hhIctb9iJXn1sD1t9A5Jrk23NX2VK87r1wUU2xZ?=
 =?us-ascii?Q?ZmCdurA4cu+Q2CAtSE4T46EAqGzkKHSR95YTv+MYps5jJcrv6qRZkh2/d/lH?=
 =?us-ascii?Q?8v/ZwLPl77KnCBluhvxv+I7k+MLHvoHD4XAS7QjJQtBxZxqCUNvfni513nUm?=
 =?us-ascii?Q?E0bKQHmLKcV7PP2jsL01VF4qO01FfmsJ5Fs9JR9WIoBwPp89JjNbnCh+TJaX?=
 =?us-ascii?Q?Y307MSr6zmXexgnR6pK5uEwz+n9eylvOUvE4YL+a1I6fv/SJWtXeGvGaepNC?=
 =?us-ascii?Q?SHYnSnp01mRDjeuqeDAUL+gHXdRFSZiWLK9EESmB2TNtzxlwWIZupfCFzYMe?=
 =?us-ascii?Q?GsZXpgV9llnXjbza0V8mlj/iKGpfeZjgeovsfCoxb2QYNGwTdJFMn9TMdFuC?=
 =?us-ascii?Q?LXG3YtFGtZybhMmxpJAG3yiJGhkTc//Kwgc4pRKsBgsSJ3bWxnhO74XTRaUK?=
 =?us-ascii?Q?VXK2ymJqK8YySTuzTgrVf0P1t5fszXnNCuaFn1OMAJndXklc0aclavH95QcR?=
 =?us-ascii?Q?qAHwHUYFNlgxC24rdJUqUeFjS+6YvUGe7Bg5duWPkg3coO7VIP8LqJONPRoz?=
 =?us-ascii?Q?tqPz2qx4CPDYACwCljPL5Q3DkMmDvg3osW5lIVnyUcCbz0ACABXoCmWro6EK?=
 =?us-ascii?Q?qtEEU8PxeWI8qWGN8mkvxzkNvPy16/WIfyMpGiPn9n8R5Gvlv2XA66NCdR3i?=
 =?us-ascii?Q?MqqtH5X6VnRZ8DK0BZ9OUnt25/gDHRm5Jze3IrzwRkyeeyyMti/EjccqUFOc?=
 =?us-ascii?Q?Hof2nOOdWES2CCVSSAFMaYrGMDqd0/e5kyJb/YD0ZIGo9hZGN75nLvqG10pK?=
 =?us-ascii?Q?/TbOmOrkEhueJom5DtVajQiStIrgYe1+q44xcmPgJJiqOSkkoqJnx/vjOjtj?=
 =?us-ascii?Q?Q38Zafds3D4RHBsDFgWnz3SCkAbCM3yOifgjsi/uTVlbdSJWJsULbprPRMPh?=
 =?us-ascii?Q?51xs7aMBwd6jXIv7ZzNwCszP+2lF+w/E1I1Op5WiYslzMcv3BoOPRVAfvstC?=
 =?us-ascii?Q?R3aZeW1c1kfcNlV72AA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CHLg+nj8D7BODR/Ss2O6XHTCUCE3/1Q14KlKb87gjW7z0aa3BhQ/bZHwMKlt?=
 =?us-ascii?Q?aNLLnamkjFhXAuYd5TUAM/XudKoZklZt8k6CYlkqZwDA5CaKN5HwrGYiACTi?=
 =?us-ascii?Q?9E2hTVjnDSWKFTo90iN68mOW8S1p9D7mE2Pwa/IDLGRSJtYAIGENnkGvpIEx?=
 =?us-ascii?Q?fGS4nuWgXEI/ySh+iknJsxVfhW1Q6eWN8wrVclFstlSC6WH2GQPEFhO19Ski?=
 =?us-ascii?Q?BpjgVvIyehxLXXFdhJNVFYZVx3tKCnybAmiRVa6QcQA/6/Y7M7RN+bXQqQy6?=
 =?us-ascii?Q?SO2R9dKLMkCpaFF0fyHn+ZjFFQEQz/kiXDEP0SYX1OXXYeDK0zY7cXvgXPKz?=
 =?us-ascii?Q?T3gLGOiDYZ8bBJvY3M1XkZUsjQotZfOiTlpSX9lEwtESiO/ItM1gV/XTC+gZ?=
 =?us-ascii?Q?Wy4jOJ352bEmJMR5LrdMTDmmsOd2hu3fn1boEk2+U0dc6FfbK7VcPrDv1D49?=
 =?us-ascii?Q?yMMilLMJ+E1XkyFzvq+mzP+ZZVM5Sz/KJatfK7wsWCVrF15VVdV546QPPDbn?=
 =?us-ascii?Q?Rk5d/ZOgxueWcTF5u/gM0ND9K+9QodKNJ57VcwheIMGIKX2LYYcyomt2zxTU?=
 =?us-ascii?Q?V0ASjg/3YJhWRV0DV6BZml5aeQap+0WCsz32CdHP2FgzGoYQf9iwljPsjak4?=
 =?us-ascii?Q?we2MnAQVFFNczaN3EwozoUzAa17LkQ45PWWdbuHn/zTM7SxfQz2HIpixNW2/?=
 =?us-ascii?Q?DfRjNwFz7m+9QLKPw4QS/7C3j2pLLWVQ3vxllo4w3jQ0xLg8M9Hsl+JOkhP6?=
 =?us-ascii?Q?HeKEZjK8fbeZvy4cjZOMxQ5ww4g+va/DP+/z6x8dxYKn4iTmCpDj9iLI9TJH?=
 =?us-ascii?Q?aFQFN44gUI9Cu6q4PyQq9YtHa5eqcs4K3Ko6DQv2gO3ZgssB9tERpfzeDjEE?=
 =?us-ascii?Q?PepsqzvEj14PmTuWtClKuQ20AJuQyqsyuVO2P6ADQwr/zFekubUkgZIfsrT5?=
 =?us-ascii?Q?PMFKFcw2MTL5N2Z97E1vt70nIWp35rEtJwSJ7dHhgfQVpdMyWYlm4r4AGkCs?=
 =?us-ascii?Q?G8KDmSG97oRnw96C6XMSO6fyPrG/WEysDP2889FGjbZAQi/hm3i72vytEZW0?=
 =?us-ascii?Q?VblIFh/HGZwNgOE777CUCcpMtf7bnjDA+oX9cLbXC7whh086PkCkUjjwDNd3?=
 =?us-ascii?Q?KcQW9W1GE4kwsLzym0tV2XtXjFVaj16zBGKD/YHEIvwQCz/y3GsFQGSBofxf?=
 =?us-ascii?Q?EwwhCIFenimimaI9FphFSGrSTPJQSXAf46J4BCr12RUks+9pOlXCUW0p1X/r?=
 =?us-ascii?Q?W8/8nBRpbG43wIhDlVSLUHjutiVA6FLxVqHOvQf69sDX0JERYgMdnBN5P+zQ?=
 =?us-ascii?Q?UDxbd9kyocAY9aK9lvxPkuvcOYrQ/plosozFWotE8H4jrrQim51yDkwvo+nH?=
 =?us-ascii?Q?pLpOrNl1YQwFPIcJ62LVPySqeAfbNjN4mKGuXWWnB5+avrjUCyllrpXSTRUw?=
 =?us-ascii?Q?iPrOW8Hir+mLlY6KKnJPEzYwNxlPmsGisaP/l2ehevddLIiiSCpY0wvPT0hw?=
 =?us-ascii?Q?3tZhVVU9mvzIxre8C3YZWTYbuE4ORf8TaiX1AlcAgbI3PcOYzls9uXin7Rmz?=
 =?us-ascii?Q?XRY0bVjr4mxDFDnmYvz2e4TqjbzYRt3DE+1FZIwe4zefWwzduVt3VgK0Puxl?=
 =?us-ascii?Q?Eza5J9AJOtZRTeDEWSbcrZDnnTjtbEmuxywGplKI7hIkv6opUr8djrfqRAdE?=
 =?us-ascii?Q?6sfy1Iv7FEtDCcnx6JLDFWJnUX0N5t5VliUm3GkeiajytUQG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd70fd9a-0455-441a-3da9-08de5ab2a00e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 19:07:17.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txxjLDiJnP3KyTPqO1leiuoqU64e2q1pF7LNn/GZYBrG45TRhTt6njqaWccfxRRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676

On Fri, Jan 23, 2026 at 05:27:24PM +0100, Francois Dugast wrote:
> On Thu, Jan 22, 2026 at 09:31:31AM -0400, Jason Gunthorpe wrote:
> > Try the patches, give me the new numbers,
> 
> Thanks for the suggestion but they do not seem to help, see new
> execution times below in ns, collected this time without kprobe
> to reduce variation:
> 
> # iommu-tip + https://patch.msgid.link/r/0-v2-973a6bdc820f+693-iommpt_map_direct_jgg@nvidia.com
> +-----------------------------------+--------+--------+--------+
> |                                   | 4KB    | 64KB   | 2MB    |
> +-----------------------------------+--------+--------+--------+
> | drm_pagemap_migrate_map_pages()   | 660    | 3951   | 113813 |
> +-----------------------------------+--------+--------+--------+
> | drm_pagemap_migrate_unmap_pages() | 610    | 11136  | 322802 |
> +-----------------------------------+--------+--------+--------+
> 
> # drm-tip
> +-----------------------------------+--------+--------+--------+
> |                                   | 4KB    | 64KB   | 2MB    |
> +-----------------------------------+--------+--------+--------+
> | drm_pagemap_migrate_map_pages()   | 687    | 3890   | 114749 |
> +-----------------------------------+--------+--------+--------+
> | drm_pagemap_migrate_unmap_pages() | 621    | 11180  | 334472 |
> +-----------------------------------+--------+--------+--------+

It is not nothing, that looks like about a 4% gain, that matches the
lower bound of what I was measuring for those patches as well.

There are two mysteries in your report.

First, compared to my measurements:

https://lore.kernel.org/linux-iommu/5-v3-634ccd3efce0+16d38-iommu_pt_vtd_jgg@nvidia.com/

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     53,66    ,      50,64      ,  21.21
 256*2^12,    384,524   ,     337,516     ,  34.34

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     67,86    ,      63,84      ,  25.25
 256*2^12,    216,335   ,     198,317     ,  37.37

Yours are about 10x higher. Granted they are not exactly the same
thing, but I'm measuring the actual page table code as 20% faster, not
slower. So I'm really wondering what is so different on your
situation. Is the cache flushing causing the 10x delta?

Second, it is normal for the map/unmap to be approximately the same,
your results have map being 165% slower. This surely must be a bug, I
have a guess that some cache flush is the incorrect length..

Still, that 10x difference is confusing, are you running with debug
options in your .kconfig? I wouldn't be surprised at all to be told
kasn/gcov/etc reacts much differently.

> > tell me if you have the non-cache iommu
> 
> The setup used in this test has non-cache coherent IOMMU.

That helps a lot. The non-coherent case disables a meaningful
optimization for the 4k page case map case, and triggers a bunch of
hard to test cache flushing code that we can look at.

Any chance you can run this on a system that has a coherent IOMMU?
That would really help narrow things down.

Can you measure directly iommu_map/unmap() calls under the dma API?
Another thought is something related to the gather outside the actual
page table is acting differently.

I will attempt to run some benchmarking here specifically with the
non-coherent mode enabled to see if I can find a bug.

Thanks,
Jason
