Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD7C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 01:41:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 299AD2070A
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 01:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/eFoFsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299AD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E531F22F05;
	Fri, 26 Jun 2020 01:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5DLPr8Z+teI; Fri, 26 Jun 2020 01:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F681227E1;
	Fri, 26 Jun 2020 01:41:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77FB3C0863;
	Fri, 26 Jun 2020 01:41:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 919F6C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 01:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8D34486F8E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 01:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szctfuCPLuRl for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 01:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C44386F85
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 01:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593135691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uo+JSVhYTDvCZf7XIZ/u95KoeLyqGn7ATOJ0JQcKOAM=;
 b=X/eFoFsFmrSbMLbNmJKeyyAEAHG7l3ofIliReS4d7ekfU1heo0/igwtG+a387YlX7omkws
 p38azIUcV41Rp852YgHbuY8eI/G9xs2cv9MXEzh57/mHZhnJDM2S4ZnfDTV0CuMz8CJM5Q
 YYc4h10GBBAPXx+wkfFXgsnzXEo8JYs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-rEoMwialNGeBGf4vGkrCNg-1; Thu, 25 Jun 2020 21:41:29 -0400
X-MC-Unique: rEoMwialNGeBGf4vGkrCNg-1
Received: by mail-qv1-f71.google.com with SMTP id n10so5352905qvp.17
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 18:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=uo+JSVhYTDvCZf7XIZ/u95KoeLyqGn7ATOJ0JQcKOAM=;
 b=jQiZppA934vtrQbjbKpRkIcSvqxUyiS+Bv/Ts9D0fmiEFU/BWSPbpz9KHN8YZ30Nct
 ZJEZokDKbC8TGeqiyjR+k4fySMAy3ZoOoFQgW0lHMkgE5ObUgF64+MkB1L0j4t0ta9Ml
 OFQMIgeu6JZTmWO5239guee2WySq4OjqClLbvHf8cNRubruGikSdUWTkZMlpq0WqBjWg
 H3uV+XjAo43GjEYfGhCQZR8O0lmLKaVlBG/j0EgbK4MIcArsRg3fRYfskbdKn+ASeCpu
 WEb3yv7Yipv71rKR4EKiE1acrQcVwczcX9AnoiLvjx0lvWyQr6KmJcdCb0szzZ4/mfov
 NVOw==
X-Gm-Message-State: AOAM530V25z1QvBizube6jQxk7sZVk2gRpeRH880HM0UJZGsSrZkFebh
 96uuEceKWx4JNl9xyoSFSd4+W6KV9MJrzaeSopb2lTZgGJZuXHtCcuo75ubwu6CeM0XrS0+12sH
 rFIDKF9ElBkgro4+fDdnV41CdSl8Wgw==
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr485603qtv.57.1593135689031;
 Thu, 25 Jun 2020 18:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE0WP3An23id/QtUmTXvQBy3iL8fWfM574b18RON6eZLnCxQ/UjBX9iOp11Y71pEOcFwhWWA==
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr485566qtv.57.1593135688592;
 Thu, 25 Jun 2020 18:41:28 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id 19sm7136347qke.44.2020.06.25.18.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 18:41:27 -0700 (PDT)
Date: Thu, 25 Jun 2020 18:41:26 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 00/13] iommu: Remove usage of dev->archdata.iommu
Message-ID: <20200626014126.vbjw5jh7wqrpm4oc@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, x86@kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
References: <20200625130836.1916-1-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-ia64@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 David Woodhouse <dwmw2@infradead.org>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu Jun 25 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Hi,
>
>here is a patch-set to remove the usage of dev->archdata.iommu from
>the IOMMU code in the kernel and replace its uses by the iommu per-device
>private data field. The changes also remove the field entirely from
>the architectures which no longer need it.
>
>On PowerPC the field is called dev->archdata.iommu_domain and was only
>used by the PAMU IOMMU driver. It gets removed as well.
>
>The patches have been runtime tested on Intel VT-d and compile tested
>with allyesconfig for:
>
>	* x86 (32 and 64 bit)
>	* arm and arm64
>	* ia64 (only drivers/ because build failed for me in
>	        arch/ia64)
>	* PPC64
>
>Besides that the changes also survived my IOMMU tree compile tests.
>
>Please review.
>
>Regards,
>
>	Joerg
>
>Joerg Roedel (13):
>  iommu/exynos: Use dev_iommu_priv_get/set()
>  iommu/vt-d: Use dev_iommu_priv_get/set()
>  iommu/msm: Use dev_iommu_priv_get/set()
>  iommu/omap: Use dev_iommu_priv_get/set()
>  iommu/rockchip: Use dev_iommu_priv_get/set()
>  iommu/tegra: Use dev_iommu_priv_get/set()
>  iommu/pamu: Use dev_iommu_priv_get/set()
>  iommu/mediatek: Do no use dev->archdata.iommu
>  x86: Remove dev->archdata.iommu pointer
>  ia64: Remove dev->archdata.iommu pointer
>  arm: Remove dev->archdata.iommu pointer
>  arm64: Remove dev->archdata.iommu pointer
>  powerpc/dma: Remove dev->archdata.iommu_domain
>
> arch/arm/include/asm/device.h                 |  3 ---
> arch/arm64/include/asm/device.h               |  3 ---
> arch/ia64/include/asm/device.h                |  3 ---
> arch/powerpc/include/asm/device.h             |  3 ---
> arch/x86/include/asm/device.h                 |  3 ---
> .../gpu/drm/i915/selftests/mock_gem_device.c  | 10 ++++++++--
> drivers/iommu/exynos-iommu.c                  | 20 +++++++++----------
> drivers/iommu/fsl_pamu_domain.c               |  8 ++++----
> drivers/iommu/intel/iommu.c                   | 18 ++++++++---------
> drivers/iommu/msm_iommu.c                     |  4 ++--
> drivers/iommu/mtk_iommu.h                     |  2 ++
> drivers/iommu/mtk_iommu_v1.c                  | 10 ++++------
> drivers/iommu/omap-iommu.c                    | 20 +++++++++----------
> drivers/iommu/rockchip-iommu.c                |  8 ++++----
> drivers/iommu/tegra-gart.c                    |  8 ++++----
> drivers/iommu/tegra-smmu.c                    |  8 ++++----
> .../media/platform/s5p-mfc/s5p_mfc_iommu.h    |  4 +++-
> 17 files changed, 64 insertions(+), 71 deletions(-)
>
>-- 
>2.27.0
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
