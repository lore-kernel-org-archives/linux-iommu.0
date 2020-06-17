Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64768C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 20:45:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A2C21556
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 20:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="NFZcC0Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A2C21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B51E48809D;
	Wed, 17 Jun 2020 20:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wnXaJb1F4Ndv; Wed, 17 Jun 2020 20:45:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E45D487C13;
	Wed, 17 Jun 2020 20:45:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBB63C0863;
	Wed, 17 Jun 2020 20:45:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D65A9C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B70F62202E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2SVqXxv48HaP for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 20:45:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 7B023204E5
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:45:34 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id m21so3119956eds.13
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KnLCZJwys+q4B3B05ok3TtEm9HWxcpRhuVgOFrlznhw=;
 b=NFZcC0HxLVeJtloucD6xkDEeP+TvW++GtU2PKmlM7Pm5PGuHk8vGkD4nuqJXeVe1kD
 QgPZd8MfuT69OaWTBim3SZi4PnPodruvNDFvFGkGgjPa3MHia3roD+LRImbpilOjbPGE
 ZzVtW9xZm5CbX8kX5zVUyYCKaCk9XCeyqW6hE//g8E6qJ09W4PLzfAY8BZNDX8d6qwIW
 1Qc4DTFOYCVWNqpinrn4k92Ax7orPareKeURiV+EcmQMCws9mV6qBAx/bdFaMw3AAaGn
 UqR2RZde2nOCN7LOw2hqRRTbNcQ4tJZcO8bFVaZ6LfEdkb1oam83UKvwzc2anAMDXPba
 ji+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KnLCZJwys+q4B3B05ok3TtEm9HWxcpRhuVgOFrlznhw=;
 b=NXfflnoxU4hewqZC72a4ZP2JXrNnFRu4354PmAhG+RJfM+Cw0x1iW3XBQd2mTGmPFC
 Sq4n2X4dVnWhQipuqR2LJo7e/Lir/IjEtPvMlMFY3fq+o96gYepSLSOlh9PThZo6prVM
 hxQ1OhXqhvLfB8b3XtLRReyjYmwqKIMRJ3eaOd+Pgcj2kr9F40thFoSwd6oSw83SRK00
 sKZQ5nBQx+MoJPVS+cbKe9p91xuEh3b8Nc5Yn9IKQ6Vx5hsCNP8RVW7iri0JYEcV0bgO
 fZrEtggwrSRxVbiOe6kdl4c828H6FtuS3HVcf407X5Njem9985v4E3ikZjw04HDFJTxJ
 Gj8w==
X-Gm-Message-State: AOAM531O77a8hjfb6GFy431xklgFwNXEDvmt0b+12209TWEjwkQjbB1E
 ZWukE2u8r+oDeJ8hXAqb2R4mGHkoBUqjlfEN2NFr/TcezoI=
X-Google-Smtp-Source: ABdhPJy5tFufG+SBVUtax2Z87ERt62C9EUZ15mPz3fddCgc6sVOg4TRQp2GozJYEPiXj2lWl6HnY46NpoQCRpZl4fPs=
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr402640lfa.60.1592426237348; 
 Wed, 17 Jun 2020 13:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200409233350.6343-1-jcrouse@codeaurora.org>
 <20200409233350.6343-5-jcrouse@codeaurora.org>
 <CADaigPWJDEwPZyUyEO9H3=+zzdEX=h+gSa-w1ppNpM9ryY0LZA@mail.gmail.com>
In-Reply-To: <CADaigPWJDEwPZyUyEO9H3=+zzdEX=h+gSa-w1ppNpM9ryY0LZA@mail.gmail.com>
From: Eric Anholt <eric@anholt.net>
Date: Wed, 17 Jun 2020 13:37:06 -0700
Message-ID: <CADaigPVvZrP_mOcB5f7w77t+4O1=Ya2VW8Ff96EzemO6swr_8Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] drm/msm: Refactor address space initialization
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, will@kernel.org,
 Sam Ravnborg <sam@ravnborg.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Brian Masney <masneyb@onstation.org>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, zhengbin <zhengbin13@huawei.com>,
 iommu@lists.linux-foundation.org, tongtiangen <tongtiangen@huawei.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Drew Davenport <ddavenport@chromium.org>,
 Wambui Karuga <wambui.karugax@gmail.com>, freedreno@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>
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

On Wed, Jun 17, 2020 at 1:16 PM Eric Anholt <eric@anholt.net> wrote:
>
> On Thu, Apr 9, 2020 at 4:34 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Refactor how address space initialization works. Instead of having the
> > address space function create the MMU object (and thus require separate but
> > equal functions for gpummu and iommu) use a single function and pass the
> > MMU struct in. Make the generic code cleaner by using target specific
> > functions to create the address space so a2xx can do its own thing in its
> > own space.  For all the other targets use a generic helper to initialize
> > IOMMU but leave the door open for newer targets to use customization
> > if they need it.
>
> I'm seeing regressions in dEQP-VK.memory.allocation.random.* on cheza
> after this commit.   The symptom is that large allocations fail with
> -ENOSPC from MSM_GEM_INFO(IOVA).
>
> Possibly relevant change from having stuffed some debug info in:
>
> before:
> [    3.791436] [drm:msm_gem_address_space_create] *ERROR* msmgem
> address space create: 0x1000000 + 0xfeffffff
> [    3.801672] platform 506a000.gmu: Adding to iommu group 6
> [    3.807359] [drm:msm_gem_address_space_create] *ERROR* msmgem
> address space create: 0x0 + 0x7fffffff
> [    3.817140] msm ae00000.mdss: bound 5000000.gpu (ops a3xx_ops)
> [    3.823212] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
> to get memory resource: vbif_nrt
> [    3.832429] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
> to get memory resource: regdma
> [    3.841478] [drm:dpu_kms_hw_init:878] dpu hardware revision:0x40000000
> [    3.848193] [drm:msm_gem_address_space_create] *ERROR* msmgem
> address space create: 0x1000 + 0xffffefff
>
> after:
>
> [    3.798707] [drm:msm_gem_address_space_create] *ERROR* msmgem
> address space create: 0x1000000 + 0xfffffff
> [    3.808731] platform 506a000.gmu: Adding to iommu group 6
> [    3.814440] [drm:msm_gem_address_space_create] *ERROR* msmgem
> address space create: 0x0 + 0x7fffffff
> [    3.820494] hub 2-1:1.0: USB hub found
> [    3.824108] msm ae00000.mdss: bound 5000000.gpu (ops a3xx_ops)
> [    3.828554] hub 2-1:1.0: 4 ports detected
> [    3.833756] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
> to get memory resource: vbif_nrt
> [    3.847038] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
> to get memory resource: regdma
> [    3.856095] [drm:dpu_kms_hw_init:878] dpu hardware revision:0x40000000
> [    3.862840] [drm:msm_gem_address_space_create] *ERROR* msmgem
> address space create: 0x1000 + 0xfffffff
>
> 256MB for GMU address space?

Found the bug, fixes at the last 2 commits of
https://github.com/anholt/linux/tree/drm-msm-address-space

I'm going to try having another go at convincing gmail to let git
send-email through, but all the howtos in the world didn't work last
time (gsuite has different behavior from normal gmail).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
