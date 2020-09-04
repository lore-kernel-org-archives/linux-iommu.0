Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4160C2BC84
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:47:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B032064E
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgsDNr8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B032064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 162652E1BD;
	Fri,  4 Sep 2020 16:47:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAoOJm0cULIw; Fri,  4 Sep 2020 16:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AC7F82E0F8;
	Fri,  4 Sep 2020 16:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E481C07FF;
	Fri,  4 Sep 2020 16:47:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90765C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8CA0E86EBA
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dr52i9aQh0AD for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com
 [209.85.219.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D883A86E1C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:46:59 +0000 (UTC)
Received: by mail-qv1-f67.google.com with SMTP id b13so3328367qvl.2
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TBpouKohZ4xnNFvQAORhEKmSrdyDNk10oVx1FtC9Bws=;
 b=EgsDNr8jq4DF077DE8FFLRkR59IU61+j8V/Ka9V7oYrWIFPZmMCFtBwfask+T/m7M7
 ABkQRjkqmQNhqKh2VT7i4UJ/Wt90Z38MeTrYGvULyHJ82SQ6PsuQNCiKdiLa9nveFUpl
 R04cMMdDGxXDTRPRVqK11KOxC3g2sVS1/0YvzjlCoZCwTT0+M1Yo/uJWYoNvcaH8IrzS
 D4wFxN5u+Z5lTv8jIxdDc9Kz7W6pwsymzzpENZP0uaCYmJuezDkqwdXmmIDXl+AlvX5a
 XlvvIg2z5oM4vk2ffrT0qm6Rw0F7DcmoUiFJgFt2a2LOiExIWcNVg47MKAjj5MqzSRpP
 R2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TBpouKohZ4xnNFvQAORhEKmSrdyDNk10oVx1FtC9Bws=;
 b=mnrGr2AnTW2HNRwWXQJaMp4XRFKm9c65d8QiN+ihuhFJwWnOjfobxvUEuj/CXJrBX2
 Z9DbImJXF/UtfbuWoOO5O41cgVY0BVg56V6fJpf10n0DrxFxMAm915OyROOpAw2xY+ie
 QZjZBwgs8uOauhjYKt+ZVG546ucDG+FPZxTHEA2idLqYaoxZe7J0f/1hz1i7qy2OiWEm
 fAlh4hb+3kgTZxkqT0JyckrCBggQjjEIqur3a2QUQZ0qLemcj9AHFqRqLiOrJC/YPz16
 YN4koNebXib8eN1n0GoMsdrMShsphCd6D4+paf1nRXI2nMxM2oh8aBtlQDsNmxUsZ5CY
 4JLw==
X-Gm-Message-State: AOAM531A/9STpcN+1c/gnc6huQ6ipMzumDyIBiKOIOq/Mmx0zyZ1Da8D
 fxjUdnSsaj8eaI2DXsJ5GQIMlP4yh+cyRe9iBQE=
X-Google-Smtp-Source: ABdhPJwyy/xhHl+JQi8gUbkrBFV9qdIEd42p3ahcLsVYoc0LxBY3nBUW4K/0j87szLhObsiHhZk2WUEKzePSgoAinVs=
X-Received: by 2002:ad4:4ae9:: with SMTP id cp9mr8657659qvb.96.1599238018778; 
 Fri, 04 Sep 2020 09:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220238.603465-1-robdclark@gmail.com>
 <20200904091117.GH6714@8bytes.org>
In-Reply-To: <20200904091117.GH6714@8bytes.org>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 4 Sep 2020 09:47:45 -0700
Message-ID: <CAF6AEGtFoUQZv3HOpjXckExvXGVsqgPVe-rjq+wLXWM9+pjWkA@mail.gmail.com>
Subject: Re: [PATCH 00/20] iommu/arm-smmu + drm/msm: per-process GPU pgtables
To: Joerg Roedel <joro@8bytes.org>
Cc: Wambui Karuga <wambui.karugax@gmail.com>, Takashi Iwai <tiwai@suse.de>,
 Hanna Hawa <hannah@marvell.com>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Eric Anholt <eric@anholt.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Sam Ravnborg <sam@ravnborg.org>,
 Jon Hunter <jonathanh@nvidia.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Sibi Sankar <sibis@codeaurora.org>, Thierry Reding <treding@nvidia.com>,
 Brian Masney <masneyb@onstation.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Stephen Boyd <swboyd@chromium.org>,
 John Stultz <john.stultz@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Shawn Guo <shawn.guo@linaro.org>, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Sep 4, 2020 at 2:11 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Mon, Aug 17, 2020 at 03:01:25PM -0700, Rob Clark wrote:
> > Jordan Crouse (12):
> >   iommu/arm-smmu: Pass io-pgtable config to implementation specific
> >     function
> >   iommu/arm-smmu: Add support for split pagetables
> >   iommu/arm-smmu: Prepare for the adreno-smmu implementation
> >   iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
> >   dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
> >   drm/msm: Add a context pointer to the submitqueue
> >   drm/msm: Drop context arg to gpu->submit()
> >   drm/msm: Set the global virtual address range from the IOMMU domain
> >   drm/msm: Add support to create a local pagetable
> >   drm/msm: Add support for private address space instances
> >   drm/msm/a6xx: Add support for per-instance pagetables
> >   arm: dts: qcom: sm845: Set the compatible string for the GPU SMMU
> >
> > Rob Clark (8):
> >   drm/msm: remove dangling submitqueue references
> >   iommu: add private interface for adreno-smmu
> >   drm/msm/gpu: add dev_to_gpu() helper
> >   drm/msm: set adreno_smmu as gpu's drvdata
> >   iommu/arm-smmu: constify some helpers
> >   arm: dts: qcom: sc7180: Set the compatible string for the GPU SMMU
> >   iommu/arm-smmu: add a way for implementations to influence SCTLR
> >   drm/msm: show process names in gem_describe
>
> Can the DRM parts be merged independently from the IOMMU parts or does
> this need to be queued together? If it needs to be together I defer the
> decission to Will through which tree this should go.
>

Hi,

v16 of this series re-ordered the patches and has some notes at the
top of the cover letter[1] about a potential way to land it.. tl;dr:
the drm parts can and adreno-smmu-priv.h can go independently of
iommu.  And the first four iommu patches can go in independently of
drm.  But the last two iommu patches have a dependency on the drm
patches.

Note that I'll send one more revision of the series shortly (I have a
small fixup for one of the drm patches for an issue found in testing,
and Bjorn had some suggestions about "iommu/arm-smmu: Prepare for the
adreno-smmu implementation" that I need to look at.

BR,
-R

[1] https://lkml.org/lkml/2020/9/1/1469
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
