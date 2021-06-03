Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A9C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 13:10:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D46613DE
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 13:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D46613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C122C400F1;
	Thu,  3 Jun 2021 13:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yX-lvJXMaqQ6; Thu,  3 Jun 2021 13:10:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BBF0400CA;
	Thu,  3 Jun 2021 13:10:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18962C000E;
	Thu,  3 Jun 2021 13:10:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E615CC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 13:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C651D608F6
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 13:09:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1RLqbDvtbxh for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:09:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90C756001B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 13:09:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C91721063;
 Thu,  3 Jun 2021 06:09:54 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14F733F774;
 Thu,  3 Jun 2021 06:09:52 -0700 (PDT)
Subject: Re: Regression 5.12.0-rc4 net: ice: significant throughput drop
To: Jussi Maki <joamaki@gmail.com>
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
 <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
 <7f048c57-423b-68ba-eede-7e194c1fea4e@arm.com>
 <CAHn8xckNt3smeQPi3dgq5i_3vP7KwU45pnP5OCF8nOV_QEdyMA@mail.gmail.com>
 <7c04eeea-22d3-c265-8e1e-b3f173f2179f@iogearbox.net>
 <705f90c3-b933-8863-2124-3fea7fdbd81a@arm.com>
 <CAHn8xc=1g8bzV-uxaJAYpJ114rR7MLzth=4jyDG329ZwEG+kpg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c434b9b4-5a8c-a7a9-4e01-b6d8bd40b918@arm.com>
Date: Thu, 3 Jun 2021 14:09:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHn8xc=1g8bzV-uxaJAYpJ114rR7MLzth=4jyDG329ZwEG+kpg@mail.gmail.com>
Content-Language: en-GB
Cc: jroedel@suse.de, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, jesse.brandeburg@intel.com, davem@davemloft.net,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 gregkh@linuxfoundation.org, anthony.l.nguyen@intel.com,
 bpf <bpf@vger.kernel.org>, hch@lst.de
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

On 2021-06-03 13:32, Jussi Maki wrote:
> On Wed, Jun 2, 2021 at 2:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>> Thanks for the quick response & patch. I tried it out and indeed it
>>>> does solve the issue:
>>
>> Cool, thanks Jussi. May I infer a Tested-by tag from that?
> 
> Of course!
> 
>> Given that the race looks to have been pretty theoretical until now, I'm
>> not convinced it's worth the bother of digging through the long history
>> of default domain and DMA ops movement to figure where it started, much
>> less attempt invasive backports. The flush queue change which made it
>> apparent only landed in 5.13-rc1, so as long as we can get this in as a
>> fix in the current cycle we should be golden - in the meantime, note
>> that booting with "iommu.strict=0" should also restore the expected
>> behaviour.
>>
>> FWIW I do still plan to resend the patch "properly" soon (in all honesty
>> it wasn't even compile-tested!)
> 
> BTW, even with the patch there's quite a bit of spin lock contention
> coming from ice_xmit_xdp_ring->dma_map_page_attrs->...->alloc_iova.
> CPU load drops from 85% to 20% (~80Mpps, 64b UDP) when iommu is
> disabled. Is this type of overhead to be expected?

Yes, IOVA allocation can still be a bottleneck - the percpu caching 
system mostly alleviates it, but certain workloads can still defeat 
that, and if you're spending significant time in alloc_iova() rather 
than alloc_iova_fast() then it sounds like yours is one of them.

If you're using small IOVA sizes which *should* be cached, then you 
might be running into a pathological case of thrashing the global depot. 
I've ranted before about the fixed MAX_GLOBAL_MAGS probably being too 
small for systems with more than 16 CPUs, which on a modern AMD system I 
imagine you may well have.

If on the other hand your workload is making larger mappings above the 
IOVA caching threshold, then please take a look at John's series for 
making that tuneable:

https://lore.kernel.org/linux-iommu/1622557781-211697-1-git-send-email-john.garry@huawei.com/

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
