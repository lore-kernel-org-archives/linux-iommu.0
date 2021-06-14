Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE78C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 15:34:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF59761241
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 15:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF59761241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A41944030F;
	Mon, 14 Jun 2021 15:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_Rm7gbCuZyy; Mon, 14 Jun 2021 15:34:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B83FD40302;
	Mon, 14 Jun 2021 15:34:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E9E0C000D;
	Mon, 14 Jun 2021 15:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB40C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 15:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60A3283133
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 15:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id esRjU6fnoKh9 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 15:34:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDE8A830C2
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 15:34:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09A4811D4;
 Mon, 14 Jun 2021 08:34:13 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA5A3F70D;
 Mon, 14 Jun 2021 08:34:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
To: Catalin Marinas <catalin.marinas@arm.com>,
 Dong Aisheng <dongas86@gmail.com>
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
 <20210614083609.GA18701@willie-the-truck>
 <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
 <20210614145105.GC30667@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6f897830-301f-3eb4-785f-de446476e676@arm.com>
Date: Mon, 14 Jun 2021 16:34:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614145105.GC30667@arm.com>
Content-Language: en-GB
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-06-14 15:51, Catalin Marinas wrote:
> On Mon, Jun 14, 2021 at 06:07:04PM +0800, Dong Aisheng wrote:
>> On Mon, Jun 14, 2021 at 4:36 PM Will Deacon <will@kernel.org> wrote:
>>> On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
>>>> Coherent dma on ARM64 also can't work with mapped system ram,
>>>> that means 'no-map' property must be specified in dts.
>>>> Add the missing check for ARM64 platforms as well.
>>>> Besides 'no-map' checking, 'linux,dma-default' feature is also
>>>> enabled for ARM64 along with this patch.

Note that the "linux,dma-default" stuff is really only for NOMMU (with 
caches), so hardly relevant to arm64.

>>> Please can you explain _why_ it can't work? We don't need to tear down
>>> aliases from the linear map for the streaming DMA API, so why is this
>>> case different? Also, coherent devices wouldn't need this either way,
>>> would they? What problem are you solving here?
>>>
>>
>> Not sure if i get your point correctly. Here is my understanding. (fix
>> me if wrong)
>> In current implementation, the coherent dma memory will be remapped as
>> writecombine and uncached type which can't reuse the linear mapping.
>> The prerequisite to do this is the memory must not be mapped System RAM.
>> e.g. reserved memory with no-map property and invisible to the buddy system.
> 
> The architecture allows the system RAM to be mapped in the linear map
> while there's another writecombine alias, as long as there are no dirty
> cache lines that could be evicted randomly. This works fine with the DMA
> API (and we have some cache maintenance when the non-cacheable mapping
> is first created).
> 
> Looking at the rmem_dma_device_init() -> dma_init_coherent_memory(), it
> ends up calling memremap(MEMREMAP_WC) which would warn if it intersects
> with system RAM regardless of the architecture. If the memory region is
> nomap, it doesn't end up as IORESOURCE_SYSTEM_RAM, so memremap() won't
> warn. But why is this specific only to arm (or arm64)?

Didn't some ARMv7 implementations permit unexpected cache hits for the 
non-cacheable address if the same PA has been speculatively fetched via 
the cacheable alias?

> Is the "shared-dma-pool" property only meant for Normal Non-cacheable
> memory (hence the MEMREMAP_WC flag)? If a system is fully cache
> coherent, does this check still make sense or the DT is not supposed to
> have such nodes?

I don't think "shared-dma-pool" carries any particular expectation 
itself of how things are mapped, especially since "reusable" effectively 
implies a cacheable mapping for 'normal' kernel usage.

Absent "reusable" to take things down the CMA path instead, "no-map" 
would currently be needed for coherent devices, since even when the CPU 
is guaranteed to bypass the cacheable alias the device can still 
inadvertently snoop it and see stale data. However if the device *is* 
coherent then it would seem more sensible to skip the remap entirely and 
just use the linear map address of the pool, unless of course it needs 
to be shared by multiple devices some of which are non-coherent... :/

>> This seems a little different from CMA which the memory is still
>> underlying managed by the buddy system in order to support migration.
>>
>> The patch here does not resolve a real issue but just open the sanity check for
>> ARM64 case as well as ARM  which reports the issue a little bit earlier at
>> rmem_dma_setup() time.
> 
> I think we first need to figure out what the real issue is and then try
> to solve it.

Agreed.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
