Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F4AC4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 16:30:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6585161447
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 16:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6585161447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 232F86087E;
	Mon, 21 Jun 2021 16:30:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P_1IC150Xrtr; Mon, 21 Jun 2021 16:30:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19FCC60872;
	Mon, 21 Jun 2021 16:30:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE3A6C000E;
	Mon, 21 Jun 2021 16:30:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52B7BC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3468E6087E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jei2gum4LQnR for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 16:30:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A5D560872
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:30:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1FD1042;
 Mon, 21 Jun 2021 09:30:33 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 901683F694;
 Mon, 21 Jun 2021 09:30:31 -0700 (PDT)
Subject: Re: [PATCHv2 2/3] iommu/io-pgtable: Optimize partial walk flush for
 large scatter-gather list
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Doug Anderson <dianders@chromium.org>
References: <cover.1623981933.git.saiprakash.ranjan@codeaurora.org>
 <150fc7ab1c7f9b70a95dae1f4bc3b9018c0f9e04.1623981933.git.saiprakash.ranjan@codeaurora.org>
 <CAD=FV=WA_mBnxv-D3YOYUkDAAcYgktFgnw2zeTkMneqFxBg=yg@mail.gmail.com>
 <716fbc51ec73434e325d84752a471e89@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <291a733f-0693-cc4d-7499-28f619b2027d@arm.com>
Date: Mon, 21 Jun 2021 17:30:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <716fbc51ec73434e325d84752a471e89@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On 2021-06-21 06:47, Sai Prakash Ranjan wrote:
> Hi,
> 
> On 2021-06-19 03:39, Doug Anderson wrote:
>> Hi,
>>
>> On Thu, Jun 17, 2021 at 7:51 PM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>> Currently for iommu_unmap() of large scatter-gather list with page size
>>> elements, the majority of time is spent in flushing of partial walks in
>>> __arm_lpae_unmap() which is a VA based TLB invalidation invalidating
>>> page-by-page on iommus like arm-smmu-v2 (TLBIVA) which do not support
>>> range based invalidations like on arm-smmu-v3.2.
>>>
>>> For example: to unmap a 32MB scatter-gather list with page size elements
>>> (8192 entries), there are 16->2MB buffer unmaps based on the pgsize (2MB
>>> for 4K granule) and each of 2MB will further result in 512 TLBIVAs 
>>> (2MB/4K)
>>> resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a huge
>>> overhead.
>>>
>>> So instead use tlb_flush_all() callback (TLBIALL/TLBIASID) to invalidate
>>> the entire context for partial walk flush on select few platforms where
>>> cost of over-invalidation is less than unmap latency
>>
>> It would probably be worth punching this description up a little bit.
>> Elsewhere you said in more detail why this over-invalidation is less
>> of a big deal for the Qualcomm SMMU. It's probably worth saying
>> something like that here, too. Like this bit paraphrased from your
>> other email:
>>
>> On qcom impl, we have several performance improvements for TLB cache
>> invalidations in HW like wait-for-safe (for realtime clients such as
>> camera and display) and few others to allow for cache lookups/updates
>> when TLBI is in progress for the same context bank.
>>
> 
> Sure will add this info as well in the next version.
> 
>>
>>> using the newly
>>> introduced quirk IO_PGTABLE_QUIRK_TLB_INV_ALL. We also do this for
>>> non-strict mode given its all about over-invalidation saving time on
>>> individual unmaps and non-deterministic generally.
>>
>> As per usual I'm mostly clueless, but I don't quite understand why you
>> want this new behavior for non-strict mode. To me it almost seems like
>> the opposite? Specifically, non-strict mode is already outside the
>> critical path today and so there's no need to optimize it. I'm
>> probably not explaining myself clearly, but I guess i'm thinking:
>>
>> a) today for strict, unmap is in the critical path and it's important
>> to get it out of there. Getting it out of the critical path is so
>> important that we're willing to over-invalidate to speed up the
>> critical path.
>>
>> b) today for non-strict, unmap is not in the critical path.
>>
>> So I would almost expect your patch to _disable_ your new feature for
>> non-strict mappings, not auto-enable your new feature for non-strict
>> mappings.
>>
>> If I'm babbling, feel free to ignore. ;-) Looking back, I guess Robin
>> was the one that suggested the behavior you're implementing, so it's
>> more likely he's right than I am. ;-)
>>
> 
> Thanks for taking a look. Non-strict mode is only for leaf entries and
> dma domains and this optimization is for non-leaf entries and is applicable
> for both, see __arm_lpae_unmap(). In other words, if you have 
> iommu.strict=0
> (non-strict mode) and try unmapping a large sg buffer as the problem 
> described
> in the commit text, you would still go via this path in unmap and see the
> delay without this patch. So what Robin suggested is that, let's do this
> unconditionally for all users with non-strict mode as opposed to only
> restricting it to implementation specific in case of strict mode.

Right, unmapping tables works out as a bit of a compromise for 
non-strict mode - we don't use a freelist to defer the freeing of 
pagetable pages, so we rely on making non-leaf invalidations 
synchronously to knock out walk caches which may be pointing to the page 
beforte we free it. We might actually be able to get away without that 
for non-strict unmaps, since partial walks pointing at freed memory 
probably aren't too much more hazardous than the equivalent leaf TLB 
entries while the IOVA region is held in the flush queue, but it 
certainly does matter for maps when we're knocking out a (presumably 
empty) table entry to put down a new block whose IOVA will be 
immediately live.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
