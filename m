Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA6C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 20:00:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62B361A24
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 20:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62B361A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7865F606B8;
	Fri, 26 Mar 2021 20:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tiJW6aBNvKXc; Fri, 26 Mar 2021 20:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52D2260D56;
	Fri, 26 Mar 2021 20:00:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C738C000C;
	Fri, 26 Mar 2021 20:00:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9382CC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7AFC384CC8
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXOglkhxnjHF for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 20:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD21F84C51
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:00:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5064361A24
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616788815;
 bh=CP+yMWcELcV+SXQBy4H5t4xbunPhafsH9XMSu0Zo7Vw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JHKnA+SlRnJ15rfHbUhsZmhvjZc6yPFkrSutdal+PjP8fMhmZnYJ4C89Ti1fEE0Fm
 b2IfU3ehqnI6ds9I1h/sAQZUkJntRDSLjZY8D1pMQ/VjERbfPbMjkjONKa5Ol8rt2E
 Kyz43649mZ+1pi2k9P6gPA1Su0H8Ee3tWExOTGAs2f4QnCnXxwrpbzfSSIb4ExGd6U
 LAIxSkmmibn2hdpyC8kzeIChNTW3Vz1AvZYLYeZt8/1NqnkWMgRHs15QDXqxtOuAJU
 LSNIbV4Im/bwpCM+cqxyIdragOqedEFeE3sZ/jAzUODdsvZ8FQBXYmAFTx+oJyo8Hb
 8sbENjkKyxzcA==
Received: by mail-ot1-f54.google.com with SMTP id
 68-20020a9d0f4a0000b02901b663e6258dso6283381ott.13
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 13:00:15 -0700 (PDT)
X-Gm-Message-State: AOAM533SPJhFkZhVasiBccWqc43KqNM1FKcG3Lg+bhxuI5fOmfxoD1R3
 cBeAzoODvnIWgLb2q/VDIBBA1LDeCKsaQQcywJM=
X-Google-Smtp-Source: ABdhPJyGIunRwuUh73+7gPt9LaZIVRJx1BLFCrKVQYBhGgW7xQM0rNvtR42DW78q1NJrXlmTHiNOoFeFDagAQoJu6tE=
X-Received: by 2002:a9d:316:: with SMTP id 22mr13066299otv.210.1616788814290; 
 Fri, 26 Mar 2021 13:00:14 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <45faaadd-eda7-464f-96ff-7324f566669e@www.fastmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 26 Mar 2021 20:59:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1+BOmT39k=OqFU+LtgfW=SDCp5W69YW58sVGf66mSppw@mail.gmail.com>
Message-ID: <CAK8P3a1+BOmT39k=OqFU+LtgfW=SDCp5W69YW58sVGf66mSppw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To: Sven Peter <sven@svenpeter.dev>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Mar 26, 2021 at 6:51 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Fri, Mar 26, 2021, at 18:34, Robin Murphy wrote:
> > On 2021-03-26 17:26, Mark Kettenis wrote:
> > >
> > > Anyway, from my viewpoint having the information about the IOVA
> > > address space sit on the devices makes little sense.  This information
> > > is needed by the DART driver, and there is no direct cnnection from
> > > the DART to the individual devices in the devicetree.  The "iommus"
> > > property makes a connection in the opposite direction.
> >
> > What still seems unclear is whether these addressing limitations are a
> > property of the DART input interface, the device output interface, or
> > the interconnect between them. Although the observable end result
> > appears more or less the same either way, they are conceptually
> > different things which we have different abstractions to deal with.
>
> I'm not really sure if there is any way for us to figure out where these
> limitation comes from though.

My first guess was that this is done to partition the available address
address space in a way that allows one physical IOTLB to handle
multiple devices that each have their own page table for a subset
of the address space, as was done on old PowerPC IOMMUs.
However, the ranges you list don't really support that model.

> I've done some more experiments and looked at all DART nodes in Apple's Device
> Tree though. It seems that most (if not all) masters only connect 32 address
> lines even though the iommu can handle a much larger address space. I'll therefore
> remove the code to handle the full space for v2 since it's essentially dead
> code that can't be tested anyway.
>
>
> There are some exceptions though:
>
> There are the PCIe DARTs which have a different limitation which could be
> encoded as 'dma-ranges' in the pci bus node:
>
>            name         base      size
>          dart-apcie1: 00100000  3fe00000
>          dart-apcie2: 00100000  3fe00000
>          dart-apcie0: 00100000  3fe00000
>         dart-apciec0: 00004000  7fffc000
>         dart-apciec1: 80000000  7fffc000

This looks like they are reserving some address space in the beginning
and/or the end, and for apciec0, the address space is partitioned into
two equal-sized regions.

> Then there are also these display controller DARTs. If we wanted to use dma-ranges
> we could just put them in a single sub bus:
>
>               name     base      size
>           dart-disp0: 00000000 fc000000
>             dart-dcp: 00000000 fc000000
>        dart-dispext0: 00000000 fc000000
>          dart-dcpext: 00000000 fc000000
>
>
> And finally we have these strange ones which might eventually each require
> another awkward sub-bus if we want to stick to the dma-ranges property.
>
>     name     base      size
>   dart-aop: 00030000 ffffffff ("always-on processor")
>   dart-pmp: 00000000 bff00000 (no idea yet)

Here I also see a "pio-vm-size" property:

    dart-pmp {
      pio-vm-base = <0xc0000000>;
      pio-vm-size = <0x40000000>;
      vm-size = <0xbff00000>;
      ...
   };

Which seems to give 3GB of address space to the normal iotlb,
plus the last 1GB to something else. The vm-base property is also
missing rather than zero, but that could just be part of their syntax
instead of a real difference.

Could it be that there are

>   dart-sio: 0021c000 fbde4000 (at least their Secure Enclave/TPM co-processor)

Same here:
    dart-sio {
       vm-base = <0x0>;
       vm-size = <0xfc000000>;
       pio-vm-base = <0xfd000000>;
      pio-vm-size = <0x2000000>;
      pio-granularity = <0x1000000>;
   }

There are clearly two distinct ranges that split up the 4GB space again,
with a small hole of 16MB (==pio-granularity) at the end of each range.

The "pio" name might indicate that this is a range of addresses that
can be programmed to point at I/O registers in another device, rather
than pointing to RAM.

           Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
