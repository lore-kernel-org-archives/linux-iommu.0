Return-Path: <SRS0=Y/a2=IZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D574C433DB
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 15:31:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA6D61991
	for <iommu@archiver.kernel.org>; Sat, 27 Mar 2021 15:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA6D61991
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EEB64063C;
	Sat, 27 Mar 2021 15:31:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FmOV7dg-9Xvu; Sat, 27 Mar 2021 15:31:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B1EB40628;
	Sat, 27 Mar 2021 15:31:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 003F1C000B;
	Sat, 27 Mar 2021 15:31:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC78C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 15:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0722784D91
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 15:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="UDIqOyXp";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Qm1zA1/f"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 175zorJ0XEf2 for <iommu@lists.linux-foundation.org>;
 Sat, 27 Mar 2021 15:31:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBE9784D8C
 for <iommu@lists.linux-foundation.org>; Sat, 27 Mar 2021 15:31:07 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id DC64858043D;
 Sat, 27 Mar 2021 11:31:04 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Sat, 27 Mar 2021 11:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=x2m3pCDfFJux8o5j+dJWq42C3lpC
 8BI/9Q73L1x239U=; b=UDIqOyXp4GWRmI2pzioG2zuL3bKG4h5t1oaqrMF+A9/U
 WD6G5vyt+h7rjWV/2rwtSLbM79Vc6xOB+j5gjjCrs5su1k2oL+8cfR/ZTns61zkY
 /ZgRT37gx/5oJkS578CTTr4NyZoB20uA0Pixc3tqyAEaRNWy+oFtztYFIzWZe+WV
 gZMIYrwa3xPb63OrvhNqjMn8AO4NetnpDRAIE/gx1ae8Y0VJbJUdRI0Wuf9v0MM0
 7qby21vBt8sfsJ1HUeBUUYqYnp+ZpczL2CZrfHaifor5yodI6/JUM7iAW3YPo2tP
 mf5gEGpTAbMa9WFRQ/FgmLTJV7MNsF6Z5hrTanQmHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=x2m3pC
 DfFJux8o5j+dJWq42C3lpC8BI/9Q73L1x239U=; b=Qm1zA1/fn0kTeXiwtso6EV
 aQkQ4AY2qawCC2OVtoUViubYu+WsOw1jQwFekQ8xdoF5uuCZdryL939THsvpPPzU
 4rOR3Km4Mng0Iq+Ah9/Q10bk8RibabwJ0Sys1zcKzV6bdMnIEJ4TNDNqF+sOHcoI
 p6qNu/yWphfM6qoNqG/cKhLRIrlKOCvar1RjqtpS/tgLAfBgyaKS3DreVCoWKyjY
 eseRKUzeRP4tHuKd1o5v1/9OpTJU5Wq/9axhSQ9Lk9ZkMekn2FggipTDkym9eBmW
 9RnEFvi5h71ATTWWJy6ftG2jq7msXnnLBGd+dIFfAuRtnxw65itdDxKZLyy7DTPw
 ==
X-ME-Sender: <xms:tk9fYM-wL0B-ssgg9z0qy-E1Tdnazb_7gG3k5DVNgKb4RZx-zkRPjw>
 <xme:tk9fYEte8vVqBPVcM0n4C4-j8dFfoQM8k9IbizgghsKsB3WkA2VRNkkebaBU3To5V
 dRRyQRAHQ4pT1cLGdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgedgjeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
 feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:tk9fYCDgbWfypTawmrTRQahtLUj_AZ4k2hlWzSjC8rnqIFJSybsz8A>
 <xmx:tk9fYMeZiGML7OoQyWmZn1p6pkXgSugaqg2rPMEPCIgShey6U_UDKA>
 <xmx:tk9fYBMICq18U5WBFnWHIfdjcICF8E5K0jFGYsglQu3be_vi8ChWXg>
 <xmx:uE9fYGmdn6EfIzaVGHaTEbtMBtQE7VGMkEnxt84jozNUQRflI1jnYKkSFWo>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 732A051C005E; Sat, 27 Mar 2021 11:31:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <c62dd4c1-2680-4eab-a2d7-fff390f3f11a@www.fastmail.com>
In-Reply-To: <CAK8P3a1+BOmT39k=OqFU+LtgfW=SDCp5W69YW58sVGf66mSppw@mail.gmail.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
 <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
 <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
 <c1bcd9821a8f8c05@bloch.sibelius.xs4all.nl>
 <e03833b1-1368-c5c3-424b-59e34bef19f3@arm.com>
 <45faaadd-eda7-464f-96ff-7324f566669e@www.fastmail.com>
 <CAK8P3a1+BOmT39k=OqFU+LtgfW=SDCp5W69YW58sVGf66mSppw@mail.gmail.com>
Date: Sat, 27 Mar 2021 16:30:41 +0100
To: "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Cc: Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On Fri, Mar 26, 2021, at 20:59, Arnd Bergmann wrote:
> On Fri, Mar 26, 2021 at 6:51 PM Sven Peter <sven@svenpeter.dev> wrote:
> >   dart-sio: 0021c000 fbde4000 (at least their Secure Enclave/TPM co-processor)
> 
> Same here:
>     dart-sio {
>        vm-base = <0x0>;
>        vm-size = <0xfc000000>;
>        pio-vm-base = <0xfd000000>;
>       pio-vm-size = <0x2000000>;
>       pio-granularity = <0x1000000>;
>    }
> 
> There are clearly two distinct ranges that split up the 4GB space again,
> with a small hole of 16MB (==pio-granularity) at the end of each range.
> 
> The "pio" name might indicate that this is a range of addresses that
> can be programmed to point at I/O registers in another device, rather
> than pointing to RAM.
> 
>            Arnd
>

Very interesting observation!

Mark and I have discussed this a little bit further on IRC. Mark also successfully
used the PCIe DARTs with a DMA window outside of the one specified by vm-base/vm-size
in the ADT.

I believe that the (pio-)vm-base/size properties merely specify the ranges their
allocator uses and do not describe actual hardware limitations. Mark also suggested
that they might reserve memory at the beginning to find bugs similar to how one
might not allow to map memory at 0x0.

I have also done a few more experiments and figured out that if I put the IOMMU
into bypass mode (which doesn't seem to work for all IOMMUs/master combinations
which is why I'll leave it out of this series for now until I figure out more
details) I *can* use the full address space. I think the limitation
is therefore imposed by the translation hardware inside the IOMMU and not by
the bus/the interconnect.

If that's correct I think the right place to enforce this is to just limit
the aperture inside the DART driver to a 32bit address space whenever address
translation is enabled.


Thanks,

Sven

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
