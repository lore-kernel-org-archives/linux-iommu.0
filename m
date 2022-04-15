Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA59C433F5
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 17:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE97384040;
	Fri, 15 Apr 2022 17:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvIwRRC2VcnR; Fri, 15 Apr 2022 17:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DB4083FB7;
	Fri, 15 Apr 2022 17:58:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B502C0033;
	Fri, 15 Apr 2022 17:58:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCBC0C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 17:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A362D40526
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 17:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqhrUGWR0N9F for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 17:58:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CAAD4014D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 17:58:53 +0000 (UTC)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nfQDZ-0004Kh-JT; Fri, 15 Apr 2022 19:58:49 +0200
Message-ID: <afd1eeb8-0291-d891-c6f4-022f243a9a72@leemhuis.info>
Date: Fri, 15 Apr 2022 19:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
 #forregzbot
Content-Language: en-US
From: Thorsten Leemhuis <linux@leemhuis.info>
To: regressions@lists.linux.dev
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
 <9e3c47e0-6807-081d-feb7-ed7c5fe1d1f1@leemhuis.info>
In-Reply-To: <9e3c47e0-6807-081d-feb7-ed7c5fe1d1f1@leemhuis.info>
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1650045533;61358a03;
X-HE-SMSGID: 1nfQDZ-0004Kh-JT
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

#regzbot fixed-by: 4fe87e818ea492ade079cc0

On 31.03.22 08:51, Thorsten Leemhuis wrote:
> [TLDR: I'm adding the regression report below to regzbot, the Linux
> kernel regression tracking bot; all text you find below is compiled from
> a few templates paragraphs you might have encountered already already
> from similar mails.]
> 
> Hi, this is your Linux kernel regression tracker. Sending this just to
> the lists, as it's already handled.
> 
> On 30.03.22 19:51, Alex Xu (Hello71) wrote:
>>
>> After a recent kernel update, booting one of my machines causes it to 
>> hang on a black screen. Pressing Lock keys on the USB keyboard does not 
>> turn on the indicators, and the machine does not appear on the Ethernet 
>> network. I don't have a serial port on this machine. I didn't try 
>> netconsole, but I suspect it won't work.
>>
>> Setting mem_encrypt=0 seems to resolve the issue. Reverting f5ff79fddf0e 
>> ("dma-mapping: remove CONFIG_DMA_REMAP") also appears to resolve the 
>> issue.
>>
>> The machine in question has an AMD Ryzen 5 1600 and ASRock B450 Pro4.
> 
> To be sure below issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
> 
> #regzbot ^introduced f5ff79fddf0e
> #regzbot title dma: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD
> SME boot fail
> #regzbot ignore-activity
> 
> If it turns out this isn't a regression, free free to remove it from the
> tracking by sending a reply to this thread containing a paragraph like
> "#regzbot invalid: reason why this is invalid" (without the quotes).
> 
> Ciao, Thorsten
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
