Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A831C433E0
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 07:55:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70A222E02
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 07:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70A222E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 61A088685F;
	Tue, 12 Jan 2021 07:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIZztW2GYpMx; Tue, 12 Jan 2021 07:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B89F58685C;
	Tue, 12 Jan 2021 07:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B14BBC088B;
	Tue, 12 Jan 2021 07:55:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADD42C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 81F4D237C8
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J24A38Jd2Zl2 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 07:55:30 +0000 (UTC)
X-Greylist: delayed 00:07:39 by SQLgrey-1.7.6
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
 [209.85.166.54])
 by silver.osuosl.org (Postfix) with ESMTPS id 646D8204A1
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:55:30 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id p187so2166114iod.4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 23:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j7gLFMlxBCQENVWtNxS2npLHFlF1Oh0HPmJ2b4uXz4E=;
 b=Muj3J6AUcKeWXk2QVKpBxfCJmD1ZNU3ECoTrLMhnZ3l10BcmT1KWV3KJZVJiyjnmgp
 tXnYNLGybukalejR/JL4Ccq0hthA+yksiWl3Xj9n38DlJXhcHL4x7k7Hi60j74u9oC5X
 xVXg0JvakYs/Mgnk3DB5tWgDJ2Wm5qz5NT8oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j7gLFMlxBCQENVWtNxS2npLHFlF1Oh0HPmJ2b4uXz4E=;
 b=GhDQgBB3FE2q997Y1eYlvlqwjaoHAa0o310WVPTVCBdiR9jx7JRLxJbZOziD0v0v5h
 Ms1inMMc3OpN9sNS17Zf7mNpwvhW/uLZj68tnViHIxlTBVT9QDJVnXitzGpUf2NSnk4S
 85RqUJz/y6VrDeRMzyF7fXipZESY6LLMmfLOlsdpEjfnT2DHIYxh17EAYQWTNPSGt9nX
 ZaDRsbAAC93oN0Li9EKPFKQTCYBg3rTBxsHhO3s4cE3eUoL/F6MJFeIPA1aSS5b6Wrmz
 qllZ7dQ16s1D2L9bxok6bXcv5PkOA6jkl9VqKVriwSIKujtYMNE1vPpCqbJrgVAL/Bmx
 dURg==
X-Gm-Message-State: AOAM531qLetBs7O6mFzV/Fhb+B1Vn3/PTzof0TtzvgkqyFJpteyR21d+
 XvnGn46l3pgJrl5pc7zdOnV+tCDKzI5lT2GK
X-Google-Smtp-Source: ABdhPJzbkurAyfx6CgXwGEi5tU8/O9gu4lmaUE0EACi4out/CB+lvCeCN6oO/IFQGeWnExSvCFtwCA==
X-Received: by 2002:a05:6e02:104b:: with SMTP id
 p11mr2817718ilj.241.1610437671258; 
 Mon, 11 Jan 2021 23:47:51 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com.
 [209.85.166.49])
 by smtp.gmail.com with ESMTPSA id s12sm1937043ilp.66.2021.01.11.23.47.50
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 23:47:51 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id 81so2076976ioc.13
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 23:47:50 -0800 (PST)
X-Received: by 2002:a05:6638:c52:: with SMTP id
 g18mr3073726jal.84.1610437670186; 
 Mon, 11 Jan 2021 23:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-6-tientzu@chromium.org>
 <20210106185757.GB109735@localhost.localdomain>
 <CALiNf2_dV13jbHqLt-r1eK+dtOcAKBGcWQCVMQn+eL6MuOrETQ@mail.gmail.com>
 <20210107180032.GB16519@char.us.oracle.com>
 <4cce7692-7184-9b25-70f2-b821065f3b25@gmail.com>
In-Reply-To: <4cce7692-7184-9b25-70f2-b821065f3b25@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 12 Jan 2021 15:47:39 +0800
X-Gmail-Original-Message-ID: <CALiNf29Kqr1WP3BEjX-y5Xtife7AinqiXAcRD2g4eB9isTaXfQ@mail.gmail.com>
Message-ID: <CALiNf29Kqr1WP3BEjX-y5Xtife7AinqiXAcRD2g4eB9isTaXfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/6] dt-bindings: of: Add restricted DMA pool
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Jan 8, 2021 at 2:15 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/7/21 10:00 AM, Konrad Rzeszutek Wilk wrote:
> >>>
> >>>
> >>>  - Nothing stops the physical device from bypassing the SWIOTLB buffer.
> >>>    That is if an errant device screwed up the length or DMA address, the
> >>>    SWIOTLB would gladly do what the device told it do?
> >>
> >> So the system needs to provide a way to lock down the memory access, e.g. MPU.
> >
> > OK! Would it be prudent to have this in the description above perhaps?
>
> Yes this is something that must be documented as a requirement for the
> restricted DMA pool users, otherwise attempting to do restricted DMA
> pool is no different than say, using a device private CMA region.
> Without the enforcement, this is just a best effort.

Will add in the next version.

> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
