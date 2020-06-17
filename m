Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EE4C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 20:16:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F502186A
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="RcjQboxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F502186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC03387D7B;
	Wed, 17 Jun 2020 20:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQzoMllKiImT; Wed, 17 Jun 2020 20:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0CC7387C10;
	Wed, 17 Jun 2020 20:16:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0066CC0863;
	Wed, 17 Jun 2020 20:16:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A951C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2900B87D69
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EdDA8x3+4L5V for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 20:16:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CFC0387C50
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 20:16:19 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id s1so4532915ljo.0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anholt-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=llMR4XP929ZlX0ktOlskzBn+oIEoOfRqB8eqQjrjFOM=;
 b=RcjQboxpASiHG7fxPLYiYz5Qsa067b/Y7vl562EyU/eKD/7YLcsaUuCfIdUTFBIHmw
 wHu1OwrDlNQHnWt4Ew9oNmuKIrDMqXCfolYHnFGrjkmeyGXdLquSjo3gFjVUR1nfQq/i
 ZK6t1/zTyaUNnP5hURPNXEeotoLQhdR6NJOnbSNL2A0LapL/0QmmidRZK86i5GdxS0L9
 jP1ZHgwGyeRQrZuUnxjyUCHcPXBBM3N5+LS4Ao9rF9K25pqmqaMxUzIWODCR9fG0TcDO
 bi+9IEPa45OkrbM3kjub8tE3MWQeGbESE0rN8pj6AZO0BV4H+yNG5Einj+yC97ghVEgl
 z+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=llMR4XP929ZlX0ktOlskzBn+oIEoOfRqB8eqQjrjFOM=;
 b=KNIl95Tg8vbzViJfRCLWs4Vp+fYkjhPu9M67MSWrxCqy8UPZarADCv6XqlQ8w5Tqor
 TqMuThqjFWXkO6fOmhM1Zkf5UVHiuxxqYX131Q8BYlcZW7qxrOYFVpPQIBMK8zV8pjfM
 lhJ2ETWleHgSbcIn7n8jy+d5hoys7/jxev4dxkPJR8u9BVtnE7w1Pg0EMBQ+lRfiUTrI
 2kvOBEQEh+kC0Be97EKmiB84SZfMo3WEX+XGSyBpLudfd1O8b2W8E1so7GU9z33YExRY
 ul4vqbFhcBwg9+ETRSqYsJwAZa3UHleDOG2P5xXlVKs+lofztNtxbwaknoOp6EfHwNRh
 pmxg==
X-Gm-Message-State: AOAM531oLFna2swPgG4yRt9UFp9PLFBnKWKyjuBszdhrB/5EKVRDn2Ox
 OvZo6k9MZD44Hlpy/ZpRQMuuSzGkVsRw9vMNGnB1iw==
X-Google-Smtp-Source: ABdhPJwSuKXzvk5zn5fk4tSXh655bmsbFyqQJkONPwl29Qe0rVGDqzm/i/OqfAbWrrePE2TK2xM+/wTuvOvXd6Q6bW8=
X-Received: by 2002:a2e:9147:: with SMTP id q7mr513712ljg.430.1592424977772;
 Wed, 17 Jun 2020 13:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200409233350.6343-1-jcrouse@codeaurora.org>
 <20200409233350.6343-5-jcrouse@codeaurora.org>
In-Reply-To: <20200409233350.6343-5-jcrouse@codeaurora.org>
From: Eric Anholt <eric@anholt.net>
Date: Wed, 17 Jun 2020 13:16:06 -0700
Message-ID: <CADaigPWJDEwPZyUyEO9H3=+zzdEX=h+gSa-w1ppNpM9ryY0LZA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] drm/msm: Refactor address space initialization
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, will@kernel.org,
 Wen Yang <wen.yang99@zte.com.cn>, Sam Ravnborg <sam@ravnborg.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
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

On Thu, Apr 9, 2020 at 4:34 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Refactor how address space initialization works. Instead of having the
> address space function create the MMU object (and thus require separate but
> equal functions for gpummu and iommu) use a single function and pass the
> MMU struct in. Make the generic code cleaner by using target specific
> functions to create the address space so a2xx can do its own thing in its
> own space.  For all the other targets use a generic helper to initialize
> IOMMU but leave the door open for newer targets to use customization
> if they need it.

I'm seeing regressions in dEQP-VK.memory.allocation.random.* on cheza
after this commit.   The symptom is that large allocations fail with
-ENOSPC from MSM_GEM_INFO(IOVA).

Possibly relevant change from having stuffed some debug info in:

before:
[    3.791436] [drm:msm_gem_address_space_create] *ERROR* msmgem
address space create: 0x1000000 + 0xfeffffff
[    3.801672] platform 506a000.gmu: Adding to iommu group 6
[    3.807359] [drm:msm_gem_address_space_create] *ERROR* msmgem
address space create: 0x0 + 0x7fffffff
[    3.817140] msm ae00000.mdss: bound 5000000.gpu (ops a3xx_ops)
[    3.823212] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
to get memory resource: vbif_nrt
[    3.832429] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
to get memory resource: regdma
[    3.841478] [drm:dpu_kms_hw_init:878] dpu hardware revision:0x40000000
[    3.848193] [drm:msm_gem_address_space_create] *ERROR* msmgem
address space create: 0x1000 + 0xffffefff

after:

[    3.798707] [drm:msm_gem_address_space_create] *ERROR* msmgem
address space create: 0x1000000 + 0xfffffff
[    3.808731] platform 506a000.gmu: Adding to iommu group 6
[    3.814440] [drm:msm_gem_address_space_create] *ERROR* msmgem
address space create: 0x0 + 0x7fffffff
[    3.820494] hub 2-1:1.0: USB hub found
[    3.824108] msm ae00000.mdss: bound 5000000.gpu (ops a3xx_ops)
[    3.828554] hub 2-1:1.0: 4 ports detected
[    3.833756] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
to get memory resource: vbif_nrt
[    3.847038] msm_dpu ae01000.mdp: [drm:msm_ioremap] *ERROR* failed
to get memory resource: regdma
[    3.856095] [drm:dpu_kms_hw_init:878] dpu hardware revision:0x40000000
[    3.862840] [drm:msm_gem_address_space_create] *ERROR* msmgem
address space create: 0x1000 + 0xfffffff

256MB for GMU address space?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
