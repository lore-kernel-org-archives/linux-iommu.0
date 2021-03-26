Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C69AC433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 17:52:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945BC61A13
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 17:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945BC61A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3798784C9D;
	Fri, 26 Mar 2021 17:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLIcR0uCiewE; Fri, 26 Mar 2021 17:52:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 164D884C99;
	Fri, 26 Mar 2021 17:52:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEE13C000E;
	Fri, 26 Mar 2021 17:52:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 192A9C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 17:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00A31405F4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 17:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="kkWAJEnK";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="M1f3i3Tp"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMSDu3I_nywO for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 17:52:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97B814026E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 17:52:18 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7E5CE5803E0;
 Fri, 26 Mar 2021 13:52:17 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Fri, 26 Mar 2021 13:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=8kXwPtHhldbtwjNjOopwUJ4yeuP+
 UupShvi+BRfDlsU=; b=kkWAJEnK7AL7xBL0aeNOCJjZAgkNurezljLLaszKkIkx
 V4eNarYodtl3szZ/3/55p9PRCd4uqljo4oDOhD2G3kp8O86deVVDTNH+cNqZtgFy
 EnSrpTG6gnEcW3BBjF6Nt+sPS8XHhyvwrYSfklOB+vW2ztwn4EXGaQ0dAwBgsqBI
 FD6TnH5oNMrhiqHhegV/JP5NzH+DRx/4sf+pf+C0qADSlSc+8zl9gZ6xw+sNWIJy
 bKHjbSxfZLrPXSd5k/RP9xZvK25rXvK/YAuYBnjRh5ON807srOKOGICtMLDCIIg2
 oarIZEB9fx4ZOv9TNYZEE6njGrHcjblgGOL2cYkpnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8kXwPt
 HhldbtwjNjOopwUJ4yeuP+UupShvi+BRfDlsU=; b=M1f3i3TpnYArNC62R6uBrG
 blLIAjBY8OCsvChA96rOpEyqSBMP8UK9cN8jP4YDXTqDhpJ2DF89sds2txc3s0re
 lYFK02qispO0elErLVdusUc+qMvaD4LBZsjATmVKqU6WRUaPRb+akKdSdUDmfoTG
 rkbk/iQzy9X4QBgA0NvrUGGE2Qv2nsDKH+1HJJ2mY2CIAMjX2skcqQucQ+Wr8TLA
 eVZWAHoB7rB9ycAZEGr0uqs2KFxCxd+RdMHZw0OWRW3YWSxUDnZFebg1eXhbb/80
 7glSyB3atL1+a7aSUBUHtvh4ypM7IfIKBLRKkP0kV3witNlHJPWF1uLaVC5c5kfg
 ==
X-ME-Sender: <xms:Tx9eYDwDqo9TpOLlhJ2xDK8umKsnlIge2GdSa7L_DShU1HAWn-O_IQ>
 <xme:Tx9eYLRkkTVBZr7cD08xlgDo503UEe2c5S7dfbf7zeDW55oxJmx7FP6Mtd52X8oEp
 Dni-kPkm5mRVbRtg5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:UB9eYNXwsVT0b6-FKyVYiwn-V4ua6yk3lYtGApEn1vXlXVKaSNKk0Q>
 <xmx:UB9eYNhUYu2UFxmtGa7qaNPGQ85JjsP2WEezmZA1pfjG51F14kURMg>
 <xmx:UB9eYFD0ey7WFCshECRzcWnfC0GgeaCGN3G-OkRVCombv6Pgl2mKPA>
 <xmx:UR9eYKLxUOwaIUsFagYHjyqxl_p3AQFbYcWYr9d8Vyvojj8xXSFJWtsbRnU>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E184E51C005F; Fri, 26 Mar 2021 13:52:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <45faaadd-eda7-464f-96ff-7324f566669e@www.fastmail.com>
In-Reply-To: <e03833b1-1368-c5c3-424b-59e34bef19f3@arm.com>
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
Date: Fri, 26 Mar 2021 18:51:55 +0100
To: "Robin Murphy" <robin.murphy@arm.com>,
 "Mark Kettenis" <mark.kettenis@xs4all.nl>, "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mohamed.mediouni@caramail.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, stan@corellium.com
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



On Fri, Mar 26, 2021, at 18:34, Robin Murphy wrote:
> On 2021-03-26 17:26, Mark Kettenis wrote:
> > 
> > Anyway, from my viewpoint having the information about the IOVA
> > address space sit on the devices makes little sense.  This information
> > is needed by the DART driver, and there is no direct cnnection from
> > the DART to the individual devices in the devicetree.  The "iommus"
> > property makes a connection in the opposite direction.
> 
> What still seems unclear is whether these addressing limitations are a 
> property of the DART input interface, the device output interface, or 
> the interconnect between them. Although the observable end result 
> appears more or less the same either way, they are conceptually 
> different things which we have different abstractions to deal with.
> 
> Robin.
>

I'm not really sure if there is any way for us to figure out where these
limitation comes from though.

I've done some more experiments and looked at all DART nodes in Apple's Device
Tree though. It seems that most (if not all) masters only connect 32 address
lines even though the iommu can handle a much larger address space. I'll therefore
remove the code to handle the full space for v2 since it's essentially dead
code that can't be tested anyway.


There are some exceptions though:

There are the PCIe DARTs which have a different limitation which could be
encoded as 'dma-ranges' in the pci bus node:

           name         base      size
         dart-apcie1: 00100000  3fe00000
         dart-apcie2: 00100000  3fe00000
         dart-apcie0: 00100000  3fe00000
        dart-apciec0: 00004000  7fffc000
        dart-apciec1: 80000000  7fffc000

Then there are also these display controller DARTs. If we wanted to use dma-ranges
we could just put them in a single sub bus:

              name     base      size
          dart-disp0: 00000000 fc000000
            dart-dcp: 00000000 fc000000
       dart-dispext0: 00000000 fc000000
         dart-dcpext: 00000000 fc000000


And finally we have these strange ones which might eventually each require
another awkward sub-bus if we want to stick to the dma-ranges property.

    name     base      size
  dart-aop: 00030000 ffffffff ("always-on processor")
  dart-pmp: 00000000 bff00000 (no idea yet)
  dart-sio: 0021c000 fbde4000 (at least their Secure Enclave/TPM co-processor)
  dart-ane: 00000000 e0000000 ("Neural Engine", their ML accelerator)


For all we know these limitations could even arise for different reasons.
(the secure enclave one looks like it might be imposed by the code running
on there).


Not really sure to proceed from here. I'll give the dma-ranges options a try
for v2 and see how that one works out but that's not going to help us understand
*why* these limitations exist. 
At least I won't have to change much code if we agree on a different abstraction :)

The important ones for now are probably the USB and the PCIe ones. We'll need the
display ones after that and can probably ignore the strange ones for quite a while.




Best,

Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
