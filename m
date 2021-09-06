Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC5FC433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 11:06:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE0960EBA
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 11:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EE0960EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BCD840208;
	Mon,  6 Sep 2021 11:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzX5hA7A90l4; Mon,  6 Sep 2021 11:06:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A686F400CF;
	Mon,  6 Sep 2021 11:06:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB2FC001C;
	Mon,  6 Sep 2021 11:06:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EF36C001B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 11:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A33E81067
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 11:06:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KUUlgaVpPGjV for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 11:06:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 882A380F7B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 11:06:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6486D;
 Mon,  6 Sep 2021 04:06:08 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01D03F73D;
 Mon,  6 Sep 2021 04:06:07 -0700 (PDT)
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
To: Joerg Roedel <joro@8bytes.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <YTIrHxWNzIwuseXO@8bytes.org>
 <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
 <YTKXLjwkD3Kn8VUz@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <11f8773b-1440-a94a-220b-9f994241d0b4@arm.com>
Date: Mon, 6 Sep 2021 12:06:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTKXLjwkD3Kn8VUz@8bytes.org>
Content-Language: en-GB
Cc: iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On 2021-09-03 22:44, Joerg Roedel wrote:
> On Fri, Sep 03, 2021 at 11:43:31AM -0700, Linus Torvalds wrote:
>>    choice
>>          prompt "IOMMU default domain type"
>>          depends on IOMMU_API
>>          default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
>>          default IOMMU_DEFAULT_DMA_STRICT
> 
> Huh, yeah, that is bogus. Seems like I overlooked that part of the
> patch-set because I was so amazed by the simplifications and cleanups in
> the rest of it.

Mad as it looks, this does in fact capture the existing behaviour. What 
we've consolidated here was previously a weird mix of driver- and 
subsystem-level controls, and it is specifically those two drivers which 
have a long-standing expectation of using lazy behaviour by default.

>> See what I'm saying? Making the default be based on some random "this
>> driver is enabled" when it can then affect *other* drivers that are
>> also enabled and not part of the decision seems to be a fundamental
>> confusion about what is going on, when it's not at all clear which
>> driver will actually be IN USE.
> 
> The Kconfig option itself was actually my suggestion, but how the
> default value is chosen certainly needs improvement. I will sort this
> out with the people involved.
> 
>> IOW, the fix might be to just say "the default is always lazy".
>>
>> Or the fix might be something that is global to a configuration and
>> doesn't rely on which iommu is in use (eg "on x86, the default is
>> always LAZY")

We could certainly express it as "default IOMMU_DEFAULT_DMA_LAZY if X86" 
if people would prefer - virtio-iommu doesn't support lazy mode either 
way, so the end result will still be equivalent.

Robin.

>> Or the fix is to make that 'iommu_dma_strict' variable - and the
>> default value for it - be a per-IOMMU thing rather than be a global.
> 
> My preference would be to make 'lazy' or 'strict' the default for all,
> but the ARM folks might disagree. On the other side it also doesn't make
> sense to let IOMMU drivers override the users Kconfig choice at runtime.
> We will discuss this and come up with something better. >
> Thanks,
> 
> 	Joerg
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
