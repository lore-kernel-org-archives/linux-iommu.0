Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9231B101;
	Wed, 14 Oct 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998916; cv=fail; b=jalEBaI8Ol2c5/aPdgtANd8J8k73D6rSeUEfoAXctpPhuOB1X/tgP6l3ckPVZqD46IQ+J/00sKVqJVH5ZpHX1RFIwYP35NsW+zdk6D4MwKCNg4Z2xGxDDcF8PjZuhOGqREBGDQB3yXMIX94trSMeYGMElXyYHxxCB93qrfErH+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998916; c=relaxed/simple;
	bh=Zaxu+xs8/TLfPPS7FJyy+3Izl3KVky4IwKpL0eBNGT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i9gw0xF3mMY7ft8lhJENiuq96ALdnAq0Yz6rvSV8r+TJBciocKYT7Ug3rsosGJiOxuLjmY3jxEX6f0iBhZ3rhttGxpnLP8WLHpbm5Bj4tVXncVK006aaB37swK0/zu0bwu7QVreYy8+6fD/YGWMh0YpCMG6FQoBJ+oBIgYdMjHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2izcVJz; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2izcVJz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPKnyWCpQPbyNgBhI9wjbSy1vAr9qhe/QeM/PNDY9vVHE4L2ISwQL3L/uX9Z+ipM0HN4R8d8WH0IjS/SLPUcI+dX3SasgrKZhvPmtAEi/T15KWUeG9wgKI03V9/bvsSVQdeoeqk74ZbuZdUd9xpHuXk/zfaHWhaANhujaFQF3STVqtLYHrYRDT5tpW3bAvDE+B2Qqd2D22hYFLT4+KGqqMsfJD0tMXEGCQg8XgMhlOPpTq8T1LziPaEdiSnwgzRksG62Hs3yrb3ejl7WRyXRf0zlqXlEdYv8IpGb54s9kA0lSwhqdetE1LXNEJUdT1cgHMEJRAKUpdfvy3sflqWdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zQo6auwQ99hZR3tkVJxqkOS0P8kXOvtGnZ2F3nStuk=;
 b=fQLAnFYUqYa4TCcul6ZoY6wL3ckmZZm9Xmn3rUag4hkaDW+VwwZtymBy9+IYZhye5xWTTthhXbO14MPLbf2hM9LZbeW4PFbW5xG9KjbYD6nST1izQoV5xp0yTtdDN6Iwoc6zauu6kSdioJUczC9trGwsVJ8Q7HB75vaVxh4LB4IG2uEMpdrCQldTOs6bj2K+o2ajBYIBwIzIxwo6Uw+mGeb4XJFKo2oxo5RXPhRVAC3LfVLz5ULHLITvfGtT+B2wwg1FL0SDwVk9rIt2KVEX1ICxSY5fvr2jBPV1iuHgV4Sv7Vf7JLIceCDiznaNew2N+/U5V1x3qNTpIxT83FbHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zQo6auwQ99hZR3tkVJxqkOS0P8kXOvtGnZ2F3nStuk=;
 b=F2izcVJzIjTuCC1rFOQMwT1SrhLNlfIJsH5UPWqlwM0XHWVg6k6UBNQ5izeMd8PWsK+Qbg4mp8KxagGeDmOqWyJBrY4huNy+F3VwDe0Hr8qcnAW++BI+PsOveKr7i60A3vHvfNcUsvPS6cozmH/VuQwZt84H7IZyqxWpyLk4GpoQ+eIGog3c5XA38lMLV8vnZuzTJYC1wCwghW9rv5GtTFBLZdoG7Qn+6yJJL0KWoVhd6G5BySekVykqFBop7cK9xqrxDVyZm1NsPCBZ+fiVy4ahBEAKUSwQiCxtsV5QhZ8sx8fM1JIK3+MOiSCgUmxOr5mJNs886gBHoKgt1fx29g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 17:28:25 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:28:25 +0000
Message-ID: <8584c31e-fd93-4f1a-9929-e71c5d9ccd0f@nvidia.com>
Date: Wed, 14 Oct 2026 19:28:16 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Luigi Rizzo <lrizzo@google.com>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261003212241.3432303-1-lrizzo@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: cee8ed33-c83b-4a81-c6b7-08df2a188da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WHDcgCEWzJkPrqq20DZDeJl45jpjkxTcIefoS0OJetAZqU1JDeHmRkEA9J1JzEwllj749VARwtmK071Td+OUmtNbd5K9/03sn7Dhv1xZrZ5G7i/88ud1v56oztYl5GNYaS4m7Fm8OltURzv7i8qSaZrrh/xwGSoNNRRjFMl8rDdJuR4ehFmtPGY6JdjgFvhfZ/IYkjxAWguwwGomsXsdDC44jVixzAy7W3yf3r6Z4NmFO9ldBN4kUvLkrD863SjCyXOu821PyRrNu5z02pwndIQHDbabbRVCm465orT5qS8WhKhFNhDBmmsF6ybJZZdDm7hCYqPiBUu1qjWO1jOkdiQdA1DCe0FarEjJNgze8BHmuFrxrk49x15WVYBaDAtwae26H1rOkADTW2pZsgt28wJ9asc4V05B6WmzPnEuFb5Lzo/h04B59ovBORpDoppWFBgpEsy0ElAxTWAmsNk1d9Mi6G8US4pkWqZR2fKOujZM/A8zo3kdF95wAYPGvIgzK5BpZUrnWnAqVP1K+74PkjyZTWXgslc40lOlmp4oPMBr4B1oK4pwiRIXmAuA8eJGhDNlYYj/y5NqjlVPSy6MbUIjmN9nJcw3f1OaSoLaiI/aTBLpj/he1JaiBcBfsU/wz9yYHJ92UltkLgqkttTkmR/adTeiyMtkQ5/E3MVi37bzr56/jqxkYzi9vBv3mluYlGPlZq95KDVEBL0Lmhe24g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTFlVndZYjZva09QS2ZheVA4NFFlWGFXWm9IZkxYV0xPY0t2Tng3M2xUQWg5?=
 =?utf-8?B?ZHFzeTFqSEpCSFRrNFlUcWt4OEwxdkdHT3p4ZWxPYnRGejVRVjAyRmE0emV5?=
 =?utf-8?B?em90L2xPaXJNZUVQdFpva2Zva0ptaHhXenNacGtzbnNtSXpjV3A1aWdQdENm?=
 =?utf-8?B?NndmcGhTOUYrMUs5cGVwY3VORE94UzFndjZYdURWZjZTRXJjbFhEWkJ6Mnpz?=
 =?utf-8?B?SDNEZXAyTmkxbXhwMWdKQk5xdTArZ3hoN00rUnQyZ25raVlMS0c3WmptaGdH?=
 =?utf-8?B?cnVqL1pYRDFhY0FKK0RHMnpTZzlML3VYbUtHeERELzVaNzI1M2Nka2ZIdVhy?=
 =?utf-8?B?LzNjT3FiSG1oRjNaa3JiWXhuM05VZGhvdjdnY21LSWlWV2g0TWhZT281MW5V?=
 =?utf-8?B?ajRJUXh5cFYrejhma1NBSXJKR05NS1JsRXhhRjR6SWxmd3AvK2t5b0VHS2NN?=
 =?utf-8?B?STFsNzdTeEhmcVF0OWptKzZ2ZmZUMWttamdreENYY1d2a3B6RVQyaTVtVXpm?=
 =?utf-8?B?Z2MxaGRxZVMxK0lrcXBqSkQzZGNiTndtNktmTzFBa2MrMCswUkh2ZUMwYWF3?=
 =?utf-8?B?dUtPbTh2UFhFWnRveEM3dUNwc2RRdmNqcVBEWko0QW45ZXlCbzJwQ0FZRG84?=
 =?utf-8?B?clFza0s0OU9Sa3J2TXdWMkwzSjRwcG5RT25TQ3QxbWFaTkR4VmZYcmdrRmFD?=
 =?utf-8?B?MGMxY2YvbU96UHlMUVo5cHlIN05TZ0FZVUdpc2F0dFUyMlZSbUxXLzNHNngv?=
 =?utf-8?B?Y1JCU3ZodHpaUDduNC9wMElyUTROYkFCRysrMUJOVHM0blVSWDYvNTV0S3Ro?=
 =?utf-8?B?NDM0Q2ZSUmlhR2tLc29SUDQrNitpYmNhY2c1OThvVVpWRGZnYklIMmVheTdx?=
 =?utf-8?B?QmhLMlJvdmJxdm5hQnBNSnhUNnI4Z28yVm13OXZuejU1RlhwQklCNzZOMGZu?=
 =?utf-8?B?bCt6ZVdubWpwZzJFaWx4d2l4d2c3cU1YdnV1WjNZSWc0MHFMVDNRVUxaaVN6?=
 =?utf-8?B?TGtGSTdtMDZYcHZ6cUxYbFcwNWlKb3JwdXdWU1pDNHdsRllZRlNBc0xqd3Yw?=
 =?utf-8?B?NXZ6cVF6eEtJZG1JOHZ3Y3E1VHRiUkRrTHowRG1WY0UrdFJJZjV0K1NST0dN?=
 =?utf-8?B?WmszSWc5YXEza1NwS0pnT1pGM3YveEZDY3kyWTROajVKZE1jbHpEUCtKUGpo?=
 =?utf-8?B?ZHdmUGpvU05sTnB1VTcxWG9KSmhBa1NrTjBUN2poalpRaFlwSEx0dFlLVUY5?=
 =?utf-8?B?UjdqeHhwVzVBbEhPVlUvZnRSYmVNU2dXU09tellhTFkxdDVDZEdkWWcvcmNx?=
 =?utf-8?B?MmJ0bGZoZ1V2T1ZRUHczUHl2VzBDMmQ1QkNYRi95UzIzL003OUU5S3ZFVmg0?=
 =?utf-8?B?aHlRM0xNdm94bE5WWUlJaVZZbXRWbGxBZjNwb2hZY0RxQUk0aWhlcEFub09E?=
 =?utf-8?B?N0dIVFRZL3UwOS9PYnJ5aGRUQ3hqVXlrVDJLL04vSFYzQTM1djBYQStOS2ow?=
 =?utf-8?B?L3pLT0RWL2l4Q1RMQkZPZlBUSVREZllhT1R3UGVXM2g3eHBUNFJZSTJ0WTJK?=
 =?utf-8?B?aEhYVnpORHlQUnRiUmlGakRMcVhYVHVUN081NlAxMFpSbEQ4cVBzcWJNTUdr?=
 =?utf-8?B?NWM1YnZMNkNPNnNGdHBxTDBlY2JvWjB5MUR0RHNzWTI4VEkzM29WWkRzazZT?=
 =?utf-8?B?YnZPOXhZOHh5MVk5cWk0ZGRpV1VOZmpIYTZNaW9HWGVxalNndmplTjJLWEtG?=
 =?utf-8?B?aVc0RnkvcGtPQkJLN2Y0Z3pQMm1oVjVmR3pKUkwzMmk4ZndjN3UzZm5tbWdz?=
 =?utf-8?B?NjZYM2p0MnlCRmkyYVdnbERRdk03UDJEeERtNHUxLzQvYi9SNE5obS90c25p?=
 =?utf-8?B?QzU1elZXaGs3Umc4S3h5VnJDZXVVVlZwR09EbCtLcmk1UWtJSEsyd05uTmF3?=
 =?utf-8?B?QWUrWDRyU1NpNTh0YlN3N1F2VlJDSnkvMmdmd21mS2dsWVpqWmFWdU9DbHZu?=
 =?utf-8?B?RG9ZMU1OcllEckFrd2h3M3IrZWRic0tSWFJ4TEFHUzVZSWl2TTd6THM5ZUMw?=
 =?utf-8?B?Zy9FWW1sRk1TWUdTbW9zanlhamd1ajJ6ZjVDUmh3MnlhUXZuVWY4dkZ4dEN4?=
 =?utf-8?B?YlhEYUh3NSthY2t0U1JzL1ZnZjEwVXhnZ2tVQnNJREdhVWMyOFRtNTVScllZ?=
 =?utf-8?B?blZIWmVHSFYrYjZtUnRjWm90NElmczFidDdBS1JVM1M2UzhoMFl4OTZWSHBK?=
 =?utf-8?B?Vi9OSXdORlF1cGw5c3dZZ05zaDRpa2Z6azU1Z01McHB6UktvbHFwbnpWQTd2?=
 =?utf-8?B?eGFDdkVJMWgxb01Oekp2UGNhRFFEVmY0MkEzZ2JiRFV3U3lYT2krQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee8ed33-c83b-4a81-c6b7-08df2a188da9
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:28:25.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVM56snw1CO5qN98Evi1gsNXrsRJZT+R+KFGs3aagD4cTw/C+2q5E/16Kdj+CCKXHJE/gtvah9pD0b81M/+l/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

Hi Luigi,

On 03.10.26 23:22, Luigi Rizzo wrote:
> Here is a subsystem called DMA_PMD on which I would like feedback on
> architecture, possible enhancements, or kernel components that could be
> reused to avoid duplication.
> 
> I think it can be extremely useful for those affected by the HW/SW overhead
> of IOMMU (especially IOTLB thrashing, see [1]), or confidential computing,
> or preemptable VMs.
> 
> The (not too exaggerated) pitch line is
> 
> DMA_PMD has the performance of identity, guarantees that only IO buffers
> can ever have active IOMMU or IOTLB mappings, removes the bounce buffer
> overhead in confidential computing and preemptable VMs, and integrates
> smoothly with existing kernel APIs.
> 
> === ARCHITECTURE
> 
> DMA_PMD was initially designed to address IOTLB thrashing (details in [1]),
> but turned out to also resolve nicely the strict IOMMU overhead, and avoid
> the bounce buffer overhead in preemptible VMs and Confidential Computing.
> 
> It works by combining several known techniques:
> 
> - transparently feed allocators of device memory (skb_page_frag_refill(),
>   dma_alloc_attrs(), pagepool, ...) with DMA_PMD pages, i.e. physically
>   contiguous PMD_SIZE (2MB) pages mapped via PDE_SIZE IOMMU entries
> 
> - heavy recycling of DMA_PMD pages (like pagepool) and lazy IOMMU unmapping
>   (like DMA-FQ), BUT:
> 
> - like strict IOMMU (DMA), safely release memory back to the kernel only
>   after destroying all of its IOMMU mappings and a synchronous IOTLB flush
> 
> - on allocation, DMA_PMD pages can be configured to be pinned in the host
>   (hence suitable for preemptible VMs) and/or unencrypted (hence suitable
>   for Confidential Computing), removing the need for bounce buffers
> 
> - there are global and per-device optin /sys/device/.../dma_pmd_*
>   and /proc/sys/net/core/tx_enable_dma_pmd
> 
> NIC drivers can typically use dma_pmd with no modifications for rings,
> tx buffers, rx buffers (if they use pagepool), and rx headers. For tx
> headers, almost all drivers need changes (see later patches in the series)
> to implement cheap bounce buffers and avoid individual 4K mappings.
> 
> The series has the following main components:
> 
> - a sparse array (similar to pageblock_flags) to quickly attach metadata
>   to a 2MB page without fiddling with the struct page. Cost is 128B per 2MB
>   page used as an IO buffer, totally negligible.
> 
> - dma_pmd_pool, a replacement for alloc_pages() that can be instantiated
>   per-CPU or per receive queue. It handles the split of PMD_SIZE pages
>   into order-N blocks, handles dma_map and unmap, and aggressively recycles
>   entries. It is used to feed skb_page_frag_refill(), pagepool, and
>   receive buffers for drivers that do not use pagepool.
>   See [2] for "WHY NOT PAGEPOOL FOR TX AND EVERYTHING"
> 
> - dma_pmd_arena, is another allocator backed by DMA_PMD pages and
>   is used exclusively as the backend for dma_alloc_attrs().
>   Used for longer-lived allocations (descriptor/completion rings,
>   rx and tx header buffers)
> 
> - glue code to hook DMA_PMD into pagepool [2], skb_page_frag_refill(),
>   dma_alloc_attrs(), dma_map/unmap...
> 
> - per-driver patches, where necessary (e.g. tx header buffers [3])
> 
> === PERFORMANCE BENEFITS
> 
> Your mileage may vary. Enabling the IOMMU may have no throughput
> impact, until it does when some system components (bus, IOTLB, CPU)
> become overloaded.  Aside from throughput reduction, one interesting
> parameter is the effectiveness of the IOTLB. Here is a sample of SMMU
> performance counters for a large ARM system with 2x200G NICs doing
> bidirectional traffic:
> 
>     === DMA-FQ MODE (total throughput ~440Gbps)
>     25,757,488      smmuv3_pmcg_*/event=0x80/   IOTLB lookups
>     16,634,941      smmuv3_pmcg_*/event=0x81/   IOTLB  misses
> 
>     === DMA_PMD on top of strict DMA (total throughput ~745Gbps)
>     22,693,218      smmuv3_pmcg_*/event=0x80/   IOTLB lookups
>         30,536      smmuv3_pmcg_*/event=0x81/   IOTLB  misses
>     (not a mistake, also lookups went down despite the higher rate
>     because the tx side can use larger segments)
> 
> The 2MB mappings made IOTLB misses almost non existent, because
> the working set is reduced by a factor of ~512.
>        
> Note, the code has more verbose comments than I would like.
> Several of them are there to avoid Sashiko getting confused and
> flagging false positives.
> 
> === NOTES
> 
> [1] IOMMU IMPACT AND IOTLB THRASHING
> This is documented in more detail in Documentation/core-api/dma-pmd.rst
> but the compact version is below.
> 
> There are three main costs involved with using the IOMMU:
> - CPU cost for dma map/unmap
> - CPU cost and latency for synchronous IOTLB flush (required for strong security)
> - IOTLB thrashing, shows up dramatically when the IO access pattern
>   exceeds the IOTLB size, and IOMMU page walks slow down bus activity
>   up to a point where we see over 30..60% throughput reduction just for
>   this reason.  Some relevant references
> 
>   https://lore.kernel.org/all/4b42f2eb-dc29-153e-ace9-5584ea2e5070@redhat.com/
>   https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10280580/
> 
> Specifically, NICs access 4 or more pages per packet (descriptor queue,
> completion queue, rx or tx header, one or more buffers), with very little
> locality especially for data buffers and tx headers. Each queue has 1-4K
> entries, a fast NIC uses 16 or more queues per direction, so just the
> data buffers cover 32..128K pages. Using 4KB mappings makes the IOTLB
> ineffective, as shown by the performance counters shown earlier.
> 
> [2] WHY NOT PAGEPOOL FOR TX AND EVERYTHING
> There is some overlap between pagepool and dma_pmd_pool in that both
> implement a cache, but pagepool is missing some important features:
> 
> - pagepool does not handle splitting 2M pages in smaller chunks, or
>   the mappings. That would need to be implemented (and is what dma_pmd_pool does)
> 
> - pagepool's provided pages cannot be cleanly managed by
>   get_page()/put_page(), which is what all the consumers of
>   skb_page_frag_refill(). Fixing that would require dozen of changes
>   with high risk of missing some paths.
> 
> - even for the receive path, a provider for pagepool has more restrictions
>   than alloc_pages-supplied memory, so if I wanted to wrap dma_pmd_pool
>   as a provider I would have needed changes to the provider interface.
> 
> - pagepool requires a device at allocation time, which is not known when
>   skb_page_frag_refill() runs, hence the IOMMU mappings cannot be handled
>   at allocation time.
> 
> - page_pool_alloc_pages assumes a single NAPI consumer with BH disabled,
>   whereas skb_page_frag_refill() runs from a preemptive context.
> 
> - and last not least, we need to handle the dma_alloc_attrs() allocations
>   which don't match pagepool API
> 
> Of course all of the above could be modified, but the complexity
> would be similar to that of implementing dma_pmd_pool, and with a
> huge risk of breaking existing functionality or missing some path.
> 
> [3] DRIVER CHANGES
> 
> Most drivers need no change for rings, transmit buffers, or receive buffers
> (if they use pagepool). Tx headers are generally mapped on the fly and
> that is enough to trigger IOTLB thrashing, so most drivers need a small
> change to implement very cheap tx bounce buffers backed by DMA_PMD pages.
> 
> We could avoid the bounce buffers using DMA_PMD for the skb->head region,
> but that memory is contiguous to skb_shinfo so it would be exposed to
> IO device access, which may be undesirable for security.
> 

Thanks for the RFC. Here are my notes (some points rephrase what was already
said):

- On CoCo VMs it seems that the only way to opt in the IOMMU optimization is to
  also opt in the copy avoidance which is not always desirable.

- Having the pool generic opens up more visibility from the untrusted host
  side. Having device based pools at least isolates one device's memory from
  the rest of the system.

- Also, device driver could help with provisioning just the right amount of
  memory that is needed. And per device control also means that probably
  you don't need to map everything RW to the IOMMU.

Thanks,
Dragos





