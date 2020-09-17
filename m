Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A45C433E2
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 10:51:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EBF204FD
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 10:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EBF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA07186FF0;
	Thu, 17 Sep 2020 10:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rtUiMbL-J2M; Thu, 17 Sep 2020 10:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A20886DD5;
	Thu, 17 Sep 2020 10:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05693C0864;
	Thu, 17 Sep 2020 10:51:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C034C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 10:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 24270875AA
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 10:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5jZpQOUWEHc for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 10:51:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0854C8757C
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 10:51:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: tomeu) with ESMTPSA id 9287529BF49
Subject: Re: [PATCH 0/3] drm: panfrost: Coherency support
To: Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <cover.1600213517.git.robin.murphy@arm.com>
 <d109e9da-feb3-c09f-2b7f-98c92ce39593@baylibre.com>
 <20200916170409.GA2543@kevin>
 <CAL_JsqLGO4YYPjQsjnzZCW5iT6n+keZw9G9mFALJip0nDo42Hw@mail.gmail.com>
 <d135f546-41aa-a6e2-52fe-7707d379c793@arm.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <0518e067-3b9a-8fe3-619f-8fce4c6c9677@collabora.com>
Date: Thu, 17 Sep 2020 12:51:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d135f546-41aa-a6e2-52fe-7707d379c793@arm.com>
Content-Language: en-US
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Kevin Hilman <khilman@baylibre.com>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
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

On 9/17/20 12:38 PM, Steven Price wrote:
> On 16/09/2020 18:46, Rob Herring wrote:
>> On Wed, Sep 16, 2020 at 11:04 AM Alyssa Rosenzweig
>> <alyssa.rosenzweig@collabora.com> wrote:
>>>
>>>> So I get a performance regression with the dma-coherent approach, 
>>>> even if it's
>>>> clearly the cleaner.
>>>
>>> That's bizarre -- this should really be the faster of the two.
>>
>> Coherency may not be free. CortexA9 had something like 4x slower
>> memcpy if SMP was enabled as an example. I don't know if there's
>> anything going on like that specifically here. If there's never any
>> CPU accesses mixed in with kmscube, then there would be no benefit to
>> coherency.
> 
> The DDK blob has the ability to mark only certain areas of memory as 
> coherent for performance reasons. For simple things like kmscube I would 
> expect that it's basically write-only from the CPU and almost all memory 
> the GPU touches isn't touched by the CPU. I.e. coherency isn't helping 
> and the coherency traffic is probably expensive. Whether the complexity 
> is worth it for "real" content I don't know - it may just be silly 
> benchmarks that benefit.

Or maybe it's only a problem for applications that do silly things? I 
don't think kmscube was ever optimized for performance.

Regards,

Tomeu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
