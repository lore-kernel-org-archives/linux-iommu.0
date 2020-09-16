Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C03C433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 17:47:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455C0206B6
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5ESeMEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455C0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DF4CE2E0EA;
	Wed, 16 Sep 2020 17:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkwfLnEoQgxY; Wed, 16 Sep 2020 17:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CA5FA2E112;
	Wed, 16 Sep 2020 17:46:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE938C0864;
	Wed, 16 Sep 2020 17:46:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35C76C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 328518742E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCfBowUVp2yq for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 17:46:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A85BC8741A
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:46:43 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19052206DC
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600278403;
 bh=T7fAAdGMEwmTUz3pfaivZhFKXEL+DDksEtd73K/d1go=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=B5ESeMEUtj1Na7fmLooTO8GkHarnHss8zBYCfN/dmFbqoxSgiuinIyUxGXgDBiHRD
 wVyiSJIvR2essfm0M43MtG9+p1eZkTr/kBrVnLRsjPY6AVwDHkkeciV16Nwyt618Qi
 AQzbMGHh21c31NP/94SPiEy7qaTP3ohI6MHi7vzI=
Received: by mail-oi1-f169.google.com with SMTP id x14so9047995oic.9
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 10:46:43 -0700 (PDT)
X-Gm-Message-State: AOAM531aO+vo1bF9qv7Ocujz/DW/X5ep6oTXrrz/rVbTMOb/6bE3Q0BW
 Fp1qoM9sSnTKSdfELB7J/2cZU5RaunIhAUNDnw==
X-Google-Smtp-Source: ABdhPJzrTvS63xEc/YGj1M1VvkjQrHbt5CCRuhwhSuLfTUE5WrBgivzbCA7OeSqMGDgazvs3cRxd8meuptTx472enRI=
X-Received: by 2002:aca:1711:: with SMTP id j17mr4051983oii.152.1600278402414; 
 Wed, 16 Sep 2020 10:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600213517.git.robin.murphy@arm.com>
 <d109e9da-feb3-c09f-2b7f-98c92ce39593@baylibre.com>
 <20200916170409.GA2543@kevin>
In-Reply-To: <20200916170409.GA2543@kevin>
From: Rob Herring <robh@kernel.org>
Date: Wed, 16 Sep 2020 11:46:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGO4YYPjQsjnzZCW5iT6n+keZw9G9mFALJip0nDo42Hw@mail.gmail.com>
Message-ID: <CAL_JsqLGO4YYPjQsjnzZCW5iT6n+keZw9G9mFALJip0nDo42Hw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm: panfrost: Coherency support
To: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Steven Price <steven.price@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 16, 2020 at 11:04 AM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> > So I get a performance regression with the dma-coherent approach, even if it's
> > clearly the cleaner.
>
> That's bizarre -- this should really be the faster of the two.

Coherency may not be free. CortexA9 had something like 4x slower
memcpy if SMP was enabled as an example. I don't know if there's
anything going on like that specifically here. If there's never any
CPU accesses mixed in with kmscube, then there would be no benefit to
coherency.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
