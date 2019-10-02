Return-Path: <SRS0=9AUr=X3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98778ECE58C
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 10:35:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54709218DE
	for <iommu@archiver.kernel.org>; Wed,  2 Oct 2019 10:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54709218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1ADE1B79;
	Wed,  2 Oct 2019 10:35:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8DEDEB6D
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 10:35:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6B9EC3D0
	for <iommu@lists.linux-foundation.org>;
	Wed,  2 Oct 2019 10:35:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88AA11000;
	Wed,  2 Oct 2019 03:35:19 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1FC3F739;
	Wed,  2 Oct 2019 03:35:17 -0700 (PDT)
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
To: Tomasz Figa <tfiga@chromium.org>, Yong Wu <yong.wu@mediatek.com>
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
	<CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <366b0bda-d874-9109-5c83-ff27301f3486@arm.com>
Date: Wed, 2 Oct 2019 11:35:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream <srv_heupstream@mediatek.com>,
	Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	"moderated list:ARM/Mediatek SoC support"
	<linux-mediatek@lists.infradead.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 02/10/2019 06:18, Tomasz Figa wrote:
> Hi Yong,
> 
> On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>
>> The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
>> TLB sync") help move the tlb_sync of unmap from v7s into the iommu
>> framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
>> lacked the dom->pgtlock, then it will cause the variable
>> "tlb_flush_active" may be changed unexpectedly, we could see this warning
>> log randomly:
>>
> 
> Thanks for the patch! Please see my comments inline.
> 
>> mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
>> full flush
>>
>> To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
>> And when checking this issue, we find that __arm_v7s_unmap call
>> io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
>> this also is potential unsafe for us. There is no tlb flush queue in the
>> MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
>> If v7s don't always gurarantee the sequence, Thus, In this patch I move
>> the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
>> and we don't care if it is leaf, rearrange the callback functions. Also,
>> the tlb flush/sync was already finished in v7s, then iotlb_sync and
>> iotlb_sync_all is unnecessary.
> 
> Performance-wise, we could do much better. Instead of synchronously
> syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
> beginning, if there was any previous flush still pending. We would
> also have to keep the .iotlb_sync() callback, to take care of waiting
> for the last flush. That would allow better pipelining with CPU in
> cases like this:
> 
> for (all pages in range) {
>     change page table();
>     flush();
> }
> 
> "change page table()" could execute while the IOMMU is flushing the
> previous change.

FWIW, given that the underlying invalidation mechanism is range-based, 
this driver would be an ideal candidate for making use of the new 
iommu_gather mechanism. As a fix for stable, though, simply ensuring 
that add_flush syncs any pending invalidation before issuing a new one 
sounds like a good idea (and probably a simpler patch too).

[...]
>> @@ -574,8 +539,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>          .detach_dev     = mtk_iommu_detach_device,
>>          .map            = mtk_iommu_map,
>>          .unmap          = mtk_iommu_unmap,
>> -       .flush_iotlb_all = mtk_iommu_flush_iotlb_all,
> 
> Don't we still want .flush_iotlb_all()? I think it should be more
> efficient in some cases than doing a big number of single flushes.
> (That said, the previous implementation didn't do any flush at all. It
> just waited for previously queued flushes to happen. Was that
> expected?)

Commit 07fdef34d2be ("iommu/arm-smmu-v3: Implement flush_iotlb_all 
hook") has an explanation of what the deal was there - similarly, it's 
probably worth this driver implementing it properly as well now (but 
that's really a separate patch).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
