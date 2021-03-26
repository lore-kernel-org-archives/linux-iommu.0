Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCD7C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 17:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5872061A2B
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 17:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5872061A2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D24E084C9B;
	Fri, 26 Mar 2021 17:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbhQxcOwkVCb; Fri, 26 Mar 2021 17:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB7AB84C54;
	Fri, 26 Mar 2021 17:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 991FAC0012;
	Fri, 26 Mar 2021 17:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40E39C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 17:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D2A384C9A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 17:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMVGwR5akI3Z for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 17:26:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sibelius.xs4all.nl (sibelius.xs4all.nl [83.163.83.176])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F31F84C54
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 17:26:18 +0000 (UTC)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
 by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id b5900111;
 Fri, 26 Mar 2021 18:26:14 +0100 (CET)
Date: Fri, 26 Mar 2021 18:26:14 +0100 (CET)
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
 (message from Arnd Bergmann on Fri, 26 Mar 2021 17:38:24 +0100)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
 <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
 <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
Message-ID: <c1bcd9821a8f8c05@bloch.sibelius.xs4all.nl>
Cc: robh@kernel.org, sven@svenpeter.dev, devicetree@vger.kernel.org,
 will@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, maz@kernel.org,
 mohamed.mediouni@caramail.com, robin.murphy@arm.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Arnd Bergmann <arnd@kernel.org>
> Date: Fri, 26 Mar 2021 17:38:24 +0100
> 
> On Fri, Mar 26, 2021 at 5:10 PM Sven Peter <sven@svenpeter.dev> wrote:
> > On Fri, Mar 26, 2021, at 16:59, Mark Kettenis wrote:
> > > Some of the DARTs provide a bypass facility.  That code make using the
> > > standard "dma-ranges" property tricky.  That property would need to
> > > contain the bypass address range.  But that would mean that if the
> > > DART driver needs to look at that property to figure out the address
> > > range that supports translation it will need to be able to distinguish
> > > between the translatable address range and the bypass address range.
> >
> > Do we understand if and why we even need to bypass certain streams?
> 
> My guess is that this is a performance optimization.
> 
> There are generally three reasons to want an iommu in the first place:
>  - Pass a device down to a guest or user process without giving
>    access to all of memory
>  - Avoid problems with limitations in the device, typically when it
> only supports
>    32-bit bus addressing, but the installed memory is larger than 4GB
>  - Protect kernel memory from broken drivers
> 
> If you care about none of the above, but you do care about data transfer
> speed, you are better off just leaving the IOMMU in bypass mode.
> I don't think we have to support it if the IOMMU works reliably, but it's
> something that users might want.

Another reason might be that a device needs access to large amounts of
physical memory at the same time and the 32-bit address space that the
DART provides is too tight.

In U-Boot I might want to use bypass where it works since there is no
proper IOMMU support in U-Boot.  Generally speaking, the goal is to
keep the code size down in U-Boot.  In OpenBSD I'll probably avoid
bypass mode if I can.

I haven't figured out how the bypass stuff really works.  Corellium
added support for it in their codebase when they added support for
Thunderbolt, and some of the DARTs that seem to be related to
Thunderbolt do indeed have a "bypass" property.  But it is unclear to
me how the different puzzle pieces fit together for Thunderbolt.

Anyway, from my viewpoint having the information about the IOVA
address space sit on the devices makes little sense.  This information
is needed by the DART driver, and there is no direct cnnection from
the DART to the individual devices in the devicetree.  The "iommus"
property makes a connection in the opposite direction.

Cheers,

Mark
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
