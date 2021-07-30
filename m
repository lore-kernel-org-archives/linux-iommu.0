Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72590C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 00:07:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0261160F5C
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 00:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0261160F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BF4A406A3;
	Fri, 30 Jul 2021 00:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zTCPdpz9Ch0z; Fri, 30 Jul 2021 00:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E0B84069D;
	Fri, 30 Jul 2021 00:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74E51C001A;
	Fri, 30 Jul 2021 00:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75FAEC000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 00:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 650404069E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 00:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0vlhCCg7qwG for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 00:07:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4588E4069D
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 00:07:13 +0000 (UTC)
Received: by mail-vs1-xe2c.google.com with SMTP id p13so4502749vsg.2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k+xYEU7GGmWpZRCP0v/62bsuQOHLx/NQBjwr1YpFdkM=;
 b=drIAYW+zXFJ+cbbCXFBGz0LWySE6GoP8M/FmnV8wYBubfbEXrQBU7SR9pmjYeGISrf
 xPoprO6u0MS59ubngZDL0/Go9vBy7rLhQZrt6OmuYLMp7olW7fW2yXKZDJMXu1uIfFFm
 R6sQ0cnJhb7jXY2xOm6yGgd1FCPYRh04qE60c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k+xYEU7GGmWpZRCP0v/62bsuQOHLx/NQBjwr1YpFdkM=;
 b=r+srDWjVroDXcl60oNHdxwfPw3XAsILU1L9Thy97vklh7y6xbZKWlbj8bBdlk0uXsJ
 EmfpMnQ789/9wWEv+MOE1vfMNcjj9ib/yEme7UHL+XDPYVGN+BnXuM+IFoBWEhfT1dqq
 JbOeiFNGFoYoUV4B23adbPu8KLh3VZEUF3MHddooIB+QQLyySNoGzaLq7Zub0EuznUOh
 0lj3Z/OR9WT1ZbD8r3JHxi1UDVx3kP2jVkFoi/evGM1IpYAz8eJsMB20qoYBM3mOabkV
 D8FmF6vcu3glVtQyD+1jK9EMZG44BylJWPUPPbVOeiFX6gjgt8TpJNQfthUzWyV9BNEB
 ETQg==
X-Gm-Message-State: AOAM532odYVHhLayaLLvhAqRy3oO5TL4vIld5kFdWA6Pq9J4z+XE0CxA
 +xsAQ0KHQNJou103ytmovRkcZaqIlOUjEg==
X-Google-Smtp-Source: ABdhPJy+gaNWk4KpDzx9wknfX0DO/YnQsFdiCdLOu7NEoOHM6skw0UDZ5FSvXuZC2P16EXKBvErFkw==
X-Received: by 2002:a67:2e14:: with SMTP id u20mr7185048vsu.19.1627603631781; 
 Thu, 29 Jul 2021 17:07:11 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com.
 [209.85.222.41])
 by smtp.gmail.com with ESMTPSA id d9sm183117vsm.19.2021.07.29.17.07.10
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 17:07:11 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id b5so3257590uaj.8
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 17:07:10 -0700 (PDT)
X-Received: by 2002:a9f:238b:: with SMTP id 11mr7438420uao.91.1627603630500;
 Thu, 29 Jul 2021 17:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627468308.git.robin.murphy@arm.com>
 <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
In-Reply-To: <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Jul 2021 17:06:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xek6_Qp7U=PrvGgVTQ9BqDwN34QVKAhgrMVCh=PjvBqg@mail.gmail.com>
Message-ID: <CAD=FV=Xek6_Qp7U=PrvGgVTQ9BqDwN34QVKAhgrMVCh=PjvBqg@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To: Robin Murphy <robin.murphy@arm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 LKML <linux-kernel@vger.kernel.org>, Chunyan Zhang <chunyan.zhang@unisoc.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Thu, Jul 29, 2021 at 3:33 PM Doug Anderson <dianders@chromium.org> wrote:
>
> I was definitely getting some inconsistencies in my tests where the
> eMMC speeds were getting into a bad state, but I don't believe it's
> related to your patch series.

I think this was just me being an idiot. I forgot that I'd been
running with KASAN, so that explains why my speeds were so much slower
than usual and probably also explains how it could get in a bad state
(I guess it also explains why sugov was eating up 30% of my CPU time
since that went away too!). No mystery here aside from why it took me
this long to realize it.

I'm now getting ~213 MB/s without forcing it to lazy and ~261 MB/s
with forcing it to lazy through sysfs (and without any other cpufreq
hacks).

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
