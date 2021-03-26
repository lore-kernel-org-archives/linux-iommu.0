Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A091C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 16:38:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA61619D5
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 16:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA61619D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70FDC405DF;
	Fri, 26 Mar 2021 16:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24xoqpjHEJFP; Fri, 26 Mar 2021 16:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6243E40239;
	Fri, 26 Mar 2021 16:38:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33C54C000D;
	Fri, 26 Mar 2021 16:38:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F91AC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7937860D4F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WddnCKc_5b2A for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 16:38:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9C5060C24
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:38:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 544F861A33
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616776720;
 bh=QEA0T21Fu4VzIaJtHMWn2IoyfAGGCrYbK9GWeEI8BYI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Wg5KoBZs/6f2D0h2Dh/5ZHL5+SEix0B49zJBcunx/+8Tkcj7ftRuOsnzONNwrVHuD
 t1OcDSiLgQxylemBtNA+h3rw3myeYmECCmks6buFyMtRjCGDQTwwGx/Xo08LSLt0li
 01AGwaWYu7t21Vc6RQvIqlHC/U3Zb72DqROlhSQS3Lp9dHXJGVfN5AO3QB9hhL1p4c
 yXyFPHE2TeFvyn+6nqczhaCghEypVMw+k2p6M8TTDAkes3ASZTaF8LHdnavJIwvaBx
 Py1seawcU5wMi/8npS14DFzm00sjpN1m67g27pIymtu0Se4S4AQoDkn5HNDeJ3aG0R
 gO03dMfXoQ3vA==
Received: by mail-ot1-f52.google.com with SMTP id
 91-20020a9d08640000b0290237d9c40382so5732965oty.12
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 09:38:40 -0700 (PDT)
X-Gm-Message-State: AOAM531XkuFDGhhbq+3mu7iD1Dw65A/Jo8Bp6AswRwNwISNdoQd5ydTQ
 EvD6+mBBvg3Y25pB3o2mNxyl5myoDnmN8a2sJss=
X-Google-Smtp-Source: ABdhPJzB0TrCzzwZmjbPbQIHOQOCMqU527iREXAspw4fnjjWwkJXz9Bi65g7VAAKjEts74t5pCxDXA+PaoPyZwzwQds=
X-Received: by 2002:a9d:316:: with SMTP id 22mr12446233otv.210.1616776719555; 
 Fri, 26 Mar 2021 09:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
 <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
In-Reply-To: <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 26 Mar 2021 17:38:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
Message-ID: <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
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

On Fri, Mar 26, 2021 at 5:10 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Fri, Mar 26, 2021, at 16:59, Mark Kettenis wrote:
> > Some of the DARTs provide a bypass facility.  That code make using the
> > standard "dma-ranges" property tricky.  That property would need to
> > contain the bypass address range.  But that would mean that if the
> > DART driver needs to look at that property to figure out the address
> > range that supports translation it will need to be able to distinguish
> > between the translatable address range and the bypass address range.
>
> Do we understand if and why we even need to bypass certain streams?

My guess is that this is a performance optimization.

There are generally three reasons to want an iommu in the first place:
 - Pass a device down to a guest or user process without giving
   access to all of memory
 - Avoid problems with limitations in the device, typically when it
only supports
   32-bit bus addressing, but the installed memory is larger than 4GB
 - Protect kernel memory from broken drivers

If you care about none of the above, but you do care about data transfer
speed, you are better off just leaving the IOMMU in bypass mode.
I don't think we have to support it if the IOMMU works reliably, but it's
something that users might want.

        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
