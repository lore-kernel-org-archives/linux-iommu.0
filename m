Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F3C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 22:33:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292D1604D7
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 22:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 292D1604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDEA583B3A;
	Thu, 29 Jul 2021 22:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itU-Q_E8CfNc; Thu, 29 Jul 2021 22:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7CBD083B2C;
	Thu, 29 Jul 2021 22:33:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4951FC001A;
	Thu, 29 Jul 2021 22:33:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30502C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 22:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08C78404C0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 22:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gAm9eExAHbIO for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 22:33:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A636401B3
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 22:33:37 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id 190so7549375qkk.12
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wSwaXGR0ffkfvWSYpOo1mSV78T7UHpROeIuBTm4Z1MA=;
 b=JNsWCZEiSnwSWX4wOvM5A/54GOSNToWAvaSyXaVfkfUMj2iAO83NDeysjcv6v2HSus
 a7FXhiwDzdQMcThODZIAMpFvWYE0wKp+72IRfKZUjq6dJMu3CSvGv9gRIe0mEYk7f4iR
 6lRau+ZIUy3OOBkEyqFaxTXUHZacdvac+hgno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wSwaXGR0ffkfvWSYpOo1mSV78T7UHpROeIuBTm4Z1MA=;
 b=YD43aviwhjIgr+T+Zg4m6ecP/Yh/NyfAuyL5sq3SjJ9MGtdUQdiiWljMMeMEAeL5xd
 1g2JwUgxeI/aPAXSVn42WPp83IH4zITBJLY5za7nWGHtfdaTES9FV0Bm4QRBWF0HDLJf
 gC7c0cFrWA7L2oix1qEbdim1cBNzGc5V/ube5lc3aPaAI7a+azpCA6mcBjnsNfNCRmdT
 8C38+qY9zzmofDuXGTMhXzLeZUkaUx0yU3qQ+OacC6NDe5AjgMa5+TLqKZc2op6cNa0a
 JB/1ZnSqn0NXbDc2nXcCKJ7lqx7ITvptBtJ31Et5gjXK7QHrhlk7uKPt/5Csfenwjs0W
 WQcA==
X-Gm-Message-State: AOAM533qtKLRFuyg+yXp6z2c25g+hSsoFx6QxxTwwSRacOWDOr9VyY9A
 akuBgUUGTqjO9/6gnniful+rnSzwOocAqg==
X-Google-Smtp-Source: ABdhPJwNOVNT49h4fZaYDeksQP6NvAdpQEk+h6Uf9uQKU4OnTnLiJwfStGBpGeHMDuVzgCkG/hht8w==
X-Received: by 2002:a05:620a:e0d:: with SMTP id
 y13mr7532600qkm.14.1627598016642; 
 Thu, 29 Jul 2021 15:33:36 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com.
 [209.85.219.172])
 by smtp.gmail.com with ESMTPSA id d192sm2496474qkc.51.2021.07.29.15.33.34
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 15:33:34 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p145so11653264ybg.6
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 15:33:34 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr9908544ybb.257.1627598013905; 
 Thu, 29 Jul 2021 15:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627468308.git.robin.murphy@arm.com>
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Jul 2021 15:33:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
Message-ID: <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
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

On Wed, Jul 28, 2021 at 8:59 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi all,
>
> Here's v2 where things start to look more realistic, hence the expanded
> CC list. The patches are now based on the current iommu/core branch to
> take John's iommu_set_dma_strict() cleanup into account.
>
> The series remiains in two (or possibly 3) logical parts - for people
> CC'd on cookie cleanup patches, the later parts should not affect you
> since your drivers don't implement non-strict mode anyway; the cleanup
> is all pretty straightforward, but please do yell at me if I've managed
> to let a silly mistake slip through and broken your driver.
>
> This time I have also build-tested x86 as well as arm64 :)
>
> Changes in v2:
>
> - Add iommu_is_dma_domain() helper to abstract flag check (and help
>   avoid silly typos like the one in v1).
> - Tweak a few commit messages for spelling and (hopefully) clarity.
> - Move the iommu_create_device_direct_mappings() update to patch #14
>   where it should have been.
> - Rewrite patch #20 as a conversion of the now-existing option.
> - Clean up the ops->flush_iotlb_all check which is also made redundant
>   by the new domain type
> - Add patch #24, which is arguably tangential, but it was something I
>   spotted during the rebase, so...
>
> Once again, the whole lot is available on a branch here:
>
> https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq
>
> Thanks,
> Robin.
>
>
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Robin Murphy (24):
>   iommu: Pull IOVA cookie management into the core
>   iommu/amd: Drop IOVA cookie management
>   iommu/arm-smmu: Drop IOVA cookie management
>   iommu/vt-d: Drop IOVA cookie management
>   iommu/exynos: Drop IOVA cookie management
>   iommu/ipmmu-vmsa: Drop IOVA cookie management
>   iommu/mtk: Drop IOVA cookie management
>   iommu/rockchip: Drop IOVA cookie management
>   iommu/sprd: Drop IOVA cookie management
>   iommu/sun50i: Drop IOVA cookie management
>   iommu/virtio: Drop IOVA cookie management
>   iommu/dma: Unexport IOVA cookie management
>   iommu/dma: Remove redundant "!dev" checks
>   iommu: Introduce explicit type for non-strict DMA domains
>   iommu/amd: Prepare for multiple DMA domain types
>   iommu/arm-smmu: Prepare for multiple DMA domain types
>   iommu/vt-d: Prepare for multiple DMA domain types
>   iommu: Express DMA strictness via the domain type
>   iommu: Expose DMA domain strictness via sysfs
>   iommu: Merge strictness and domain type configs
>   iommu/dma: Factor out flush queue init
>   iommu: Allow enabling non-strict mode dynamically
>   iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
>   iommu: Only log strictness for DMA domains
>
>  .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
>  drivers/iommu/Kconfig                         | 80 +++++++++----------
>  drivers/iommu/amd/iommu.c                     | 21 +----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 29 ++++---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 --
>  drivers/iommu/dma-iommu.c                     | 44 +++++-----
>  drivers/iommu/exynos-iommu.c                  | 18 +----
>  drivers/iommu/intel/iommu.c                   | 23 ++----
>  drivers/iommu/iommu.c                         | 53 +++++++-----
>  drivers/iommu/ipmmu-vmsa.c                    | 27 +------
>  drivers/iommu/mtk_iommu.c                     |  6 --
>  drivers/iommu/rockchip-iommu.c                | 11 +--
>  drivers/iommu/sprd-iommu.c                    |  6 --
>  drivers/iommu/sun50i-iommu.c                  | 12 +--
>  drivers/iommu/virtio-iommu.c                  |  8 --
>  include/linux/dma-iommu.h                     |  9 ++-
>  include/linux/iommu.h                         | 15 +++-
>  18 files changed, 171 insertions(+), 226 deletions(-)

I ran with:

a) mainline Linux (at commit 4010a528219e)
b) pulled iommu/next (at commit 9be9f5580ab6)
c) picked from patchwork your series

...and I ran on sc7180-trogdor-lazor.

Things worked OK and I could transition my eMMC to non-strict mode with:

echo DMA-FQ > /sys/devices/platform/soc@0/7c4000.sdhci/iommu_group/type

I was definitely getting some inconsistencies in my tests where the
eMMC speeds were getting into a bad state, but I don't believe it's
related to your patch series. I could transition myself back to strict
DMA with this (only got one unrelated warn splat about
dev_pm_opp_put_clkname when unbinding) because I was booted up from
USB for testing:

cd /sys/bus/mmc/drivers/mmcblk
echo mmc1:0001 > unbind
cd /sys/bus/platform/drivers/sdhci_msm/
echo 7c4000.sdhci > unbind
echo DMA > /sys/devices/platform/soc@0/7c4000.sdhci/iommu_group/type
echo 7c4000.sdhci > bind

...and it was consistently faster with non-strict than with strict so
whatever bad state I sometimes managed to get in it affected both
modes. ;-)

So I guess that's a long-winded way to say this:

Tested-by: Douglas Anderson <dianders@chromium.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
