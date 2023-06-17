Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA85A927
	for <iommu@lists.linux.dev>; Sat, 17 Jun 2023 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
	content-transfer-encoding:cc:content-type:from:subject:to;
	s=s1; bh=1v/B2hj0j3HTuSLQVKV/YUxO79Xd/j0e/6+iybZJmkE=;
	b=EIr4RGCOMeTO92aUAIFANAHfC2EkkTTnnnyUKs3i1vM5Zb2M6vxEvqkXD+vgLOEe8ClC
	stQIdStumN/rYj8Ai6+axeJqDbB6W8UJ0iFVs+BeLLaXM4kntjRO3gAANZDRgqX4XYM0Tr
	fivuDHHQUyw8QlRWtd7K3x784jMAg2QAftmI6mgGG2z4GNj/jcaz9DhJ3COKcpWSFnAYmV
	nKn8qTHZqCWaeprUrf9MPfSKZafU77jCrQfWNxN0l1EU8NbfTZObC6xKOjPPxXlVI/FPGO
	PWiObc4NUucsZgy3B5CStxFSFWa2nHVV0Wb7aK5hWukga2ALobgdl2IBlBH7lqzg==
Received: by filterdrecv-66949dbc98-4lpsw with SMTP id filterdrecv-66949dbc98-4lpsw-1-648DD182-89
        2023-06-17 15:30:10.512989604 +0000 UTC m=+3253823.790132408
Received: from [192.168.1.50] (unknown)
	by geopod-ismtpd-8 (SG) with ESMTP
	id aWnhPIHzTwG_wIptYlh9zA
	Sat, 17 Jun 2023 15:30:10.012 +0000 (UTC)
Message-ID: <f207165f-0c16-f81c-9828-1f99b278cabf@kwiboo.se>
Date: Sat, 17 Jun 2023 15:30:10 +0000 (UTC)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] iommu: rockchip: Allocate tables from all
 available memory
Content-Language: en-US
References: <20230615201042.2291867-1-jonas@kwiboo.se>
 <20230615201042.2291867-4-jonas@kwiboo.se>
 <67aab611-29cd-1a80-d0e2-e5b6523b2785@arm.com>
 <0feaf393-21ca-f6ff-bc5d-d179d6169a70@kwiboo.se>
 <7c6558bc-36a2-a9fa-dc66-466b3948f61f@arm.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7c6558bc-36a2-a9fa-dc66-466b3948f61f@arm.com>
X-SG-EID: 
 =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h1EUe=2F9yZyYSreI4h?=
 =?us-ascii?Q?7BamvNrxKANXSMPqojiWOqCtwohJZyUqSEolpBF?=
 =?us-ascii?Q?Qm5cPa2dZoZ25PCdxdR1lqJsGUK1ZjiM6kfoaxE?=
 =?us-ascii?Q?H9kehvkQDcP+GwZdfGXofRbD3PS1EZFQEgosrOM?=
 =?us-ascii?Q?KL8DFqQQkCqYkWu16o6=2FFOH+0M4Onl2ghlHnRf?=
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 2023-06-16 12:58, Robin Murphy wrote:
> On 2023-06-15 23:26, Jonas Karlman wrote:
>> On 2023-06-15 23:25, Robin Murphy wrote:
>>> On 2023-06-15 21:10, Jonas Karlman wrote:
>>>> Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.
>>>
>>> Older ones supposedly did too, e.g. commit 79db45be2b8b ("ARM: dts:
>>> rockchip: convert rk3288 device tree files to 64 bits"). Are we certain
>>> that nobody actually has a system with IOMMUv1 and more than 4GB of RAM?
>>
>> In IOMMU v1 bit 11:0 read back as 0 from MMU_DTE_ADDR reg, so I expect
>> that the old limit for v1 is 4GB.
> 
> Right, that was my point, sorry if it was unclear - on at least RK3288, 
> the *SoC* apparently supports RAM above 4GB, even if it's only the CPUs 
> that can access it. GFP_DMA32 technically *is* correct and appropriate 
> for IOMMUv1, so it's only safe to unconditionally remove it if we're 
> sure that, on all relevant IOMMUv1 SoCs in practice, no RAM above 4GB 
> exists such that ZONE_NORMAL is empty and all allocations come from 
> ZONE_DMA32 by default anyway.
> 
> (in truth this only matters for 64-bit SoCs, since on 32-bit there is no 
> ZONE_DMA32, but any >4GB RAM would already have to be in ZONE_HIGHMEM, 
> so safely out of scope)

Thanks for the insights!

I will keep the use of GFP_DMA32 flag on IOMMUv1 to be safe and only
remove it for IOMMUv2 in a v3 series.

Regards,
Jonas

> 
> Thanks,
> Robin.
> 
>> I will reword this to focus on IOMMU
>> v1 vs v2 instead of SoCs in v3.
>>
>>>
>>>> However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
>>>> allocation of the discovery and page tables into memory below 4GB.
>>>>
>>>> Let's remove this limitation now that the discovery table address is
>>>
>>> Nit: s/discovery/directory/g again
>>
>> Will fix in v3 :-)
>>
>> Regards,
>> Jonas
>>
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> correctly configured for addresses above 4GB.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> v2:
>>>> - no change
>>>>
>>>>    drivers/iommu/rockchip-iommu.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
>>>> index 62be9bf42390..46498fc382ee 100644
>>>> --- a/drivers/iommu/rockchip-iommu.c
>>>> +++ b/drivers/iommu/rockchip-iommu.c
>>>> @@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
>>>>    	if (rk_dte_is_pt_valid(dte))
>>>>    		goto done;
>>>>    
>>>> -	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
>>>> +	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
>>>>    	if (!page_table)
>>>>    		return ERR_PTR(-ENOMEM);
>>>>    
>>>> @@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>>>>    	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
>>>>    	 * Allocate one 4 KiB page for each table.
>>>>    	 */
>>>> -	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
>>>> +	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
>>>>    	if (!rk_domain->dt)
>>>>    		goto err_free_domain;
>>>>    
>>

