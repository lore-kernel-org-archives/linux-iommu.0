Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6A1C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 21:41:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E761461A25
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 21:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E761461A25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1DD240EB0;
	Thu, 25 Mar 2021 21:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyRHFteX8ZOC; Thu, 25 Mar 2021 21:41:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B16B40EBD;
	Thu, 25 Mar 2021 21:41:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 325B4C000D;
	Thu, 25 Mar 2021 21:41:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA15C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 21:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9E8060B65
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 21:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DGMqPRxOlQpV for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 21:41:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B60E60B2C
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 21:41:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5AA61A25
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616708485;
 bh=RPr0+GAQJYl2SXFGMPkIt54GGFqTX+CVANOyfY1QFiY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=k5NiMFpnmGFDfTsTgKkHIfzy4Q87nBn6/uezhrr7m3mdolnhlED3LoG2wzf7SLR0T
 6pJzRE49SLYcBdd4RAg+iDP6Hp19foyZiJFV1U4ve6HWe9qMn5bVFVEFjZ1V15mpeV
 in8BH2QDhzOkk4kZeC/xFj0gzIgg2AIUXregXyHPu4glOXPYvR7pCBjb9tYWgChXnG
 D+eZZZCxkB6I66pyymVQi+/j4qs6M9S0Lb1FncI41V8nC1n7SFypn5EVyWrbNgdIGv
 eD8ZxcfeA9cYjZODc8ytNDL+5RbW8uEXJnrsSvNWz/E1/QPT7wOpKO2oz5jn4NSMzz
 JkxGn/cloYGJQ==
Received: by mail-ot1-f41.google.com with SMTP id
 91-20020a9d08640000b0290237d9c40382so3366006oty.12
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:41:25 -0700 (PDT)
X-Gm-Message-State: AOAM532Qw11nGjQgKOQt4eRJTkWyLHnItlIKdKgpO46qJk1iZa6eX/pU
 /fEHOfRbetDfqfMlVvg2YJvwXY52rEenfLKMZz8=
X-Google-Smtp-Source: ABdhPJxlCcqleUvoMM0qnZXW4lBarEjgZ1ug3Hjq78DPfvPnEuxx7Lua3VGxdB55kpr9ovRvIeqvFoRKnXWmtETo1pU=
X-Received: by 2002:a05:6830:148c:: with SMTP id
 s12mr9471035otq.251.1616708485174; 
 Thu, 25 Mar 2021 14:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
In-Reply-To: <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 25 Mar 2021 22:41:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
Message-ID: <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
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

On Thu, Mar 25, 2021 at 8:53 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Mar 23, 2021, at 21:53, Rob Herring wrote:
>
> I'm probably just confused or maybe the documentation is outdated but I don't
> see how I could specify "this device can only use DMA addresses from
> 0x00100000...0x3ff00000 but can map these via the iommu to any physical
> address" using 'dma-ranges'.

It sounds like this is a holdover from the original powerpc iommu, which also
had a limited set of virtual addresses in the iommu.

I would think it's sufficient to describe it in the iommu itself,
since the limitation
is more "addresses coming into the iommu must be this range" than "this device
must use that address range for talking to the iommu".

If the addresses are allocated by the iommu driver, and each iommu only has
one DMA master attached to it, having a simple range property in the iommu
node should do the trick here. If there might be multiple devices on the same
iommu but with different address ranges (which I don't think is the case), then
it could be part of the reference to the iommu.

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
