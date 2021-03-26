Return-Path: <SRS0=A+5j=IY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5EC433C1
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 20:03:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CAF6197C
	for <iommu@archiver.kernel.org>; Fri, 26 Mar 2021 20:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CAF6197C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2E836060C;
	Fri, 26 Mar 2021 20:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8V00FlPCF0Uj; Fri, 26 Mar 2021 20:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCDBF605B7;
	Fri, 26 Mar 2021 20:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5B9BC000C;
	Fri, 26 Mar 2021 20:03:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5896CC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46BC784CC9
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0_q0mU5vGw9p for <iommu@lists.linux-foundation.org>;
 Fri, 26 Mar 2021 20:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B29684CAC
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:03:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC1F61A18
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616789028;
 bh=4LKLYKqudMoB6aEd0Ps7uLTpOx51F1Icssxa7AiFOw0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=prkDcNQpdnFzJnZv4Ul12AA/8zLGY27K6F+rBjzHhJq5NBK64WHUpsTem8eBtcfq8
 HEU/kcqmBG6bk7WnfZ/IM91KhzhQE2pUDGa/zVEP4ococfpu86/s24LCtrU8wT2GyK
 m6gUaMsN8IGte6bF3v8K/u3vkltqzOTXU/j30NXMfmjBWUvpR3aJWYqOM0+15uxvEs
 LyEnaWEoeurwpOM/zxMXBSi9YSAaeaglJTAllj1WTCQJMYJTZ7QrGQhjLmJ3ajNCyS
 LXCywYD3hnmQcNFxE9Lud5JbQkq41i3G35jD0V1uR7vTEi10VW2BiRXNMLm/7ThHYG
 Kx2Z0hgshZvtw==
Received: by mail-ot1-f53.google.com with SMTP id
 m21-20020a9d7ad50000b02901b83efc84a0so6301290otn.10
 for <iommu@lists.linux-foundation.org>; Fri, 26 Mar 2021 13:03:48 -0700 (PDT)
X-Gm-Message-State: AOAM530mAZRhFqFUwLDlcUJmvMsKEI2WFGrqrjnIVlZ0Jlgb94QSUwBA
 tzuKUHd/x6F6NyGKTl8L3PRxLSUkTOo3SPjbQZE=
X-Google-Smtp-Source: ABdhPJyPEunl4Ngli4e/a9ttTgDySVGUAx1snwV7toHx9J8Evv0fmZt1qQLI1SgPLsSAWwUdD3HAzaFQDSDeIqyJHRs=
X-Received: by 2002:a05:6830:148c:: with SMTP id
 s12mr13387334otq.251.1616789027968; 
 Fri, 26 Mar 2021 13:03:47 -0700 (PDT)
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
In-Reply-To: <c1bcd9821a8f8c05@bloch.sibelius.xs4all.nl>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 26 Mar 2021 21:03:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1CFHgjuzmefKcbC3MPeBD0USeTe7oZsTcQ=6tagG3Cvw@mail.gmail.com>
Message-ID: <CAK8P3a1CFHgjuzmefKcbC3MPeBD0USeTe7oZsTcQ=6tagG3Cvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Rob Herring <robh@kernel.org>, sven@svenpeter.dev,
 DTML <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Stan Skowronek <stan@corellium.com>
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

On Fri, Mar 26, 2021 at 6:28 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

> I haven't figured out how the bypass stuff really works.  Corellium
> added support for it in their codebase when they added support for
> Thunderbolt, and some of the DARTs that seem to be related to
> Thunderbolt do indeed have a "bypass" property.  But it is unclear to
> me how the different puzzle pieces fit together for Thunderbolt.

As a general observation, bypass mode for Thunderbolt is what enabled
the http://thunderclap.io/ attack. This is extremely useful for debugging
a running kernel from another machine, but it's also something that
should never be done in a production kernel.

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
