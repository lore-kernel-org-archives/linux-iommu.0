Return-Path: <SRS0=cNfX=L6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A7C07E96
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 21:36:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F55761C73
	for <iommu@archiver.kernel.org>; Tue,  6 Jul 2021 21:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F55761C73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A0CC605F7;
	Tue,  6 Jul 2021 21:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRuePYeAXvq9; Tue,  6 Jul 2021 21:36:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2DCA605B3;
	Tue,  6 Jul 2021 21:36:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B64E3C0010;
	Tue,  6 Jul 2021 21:36:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B91CCC000E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 21:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97CAA4059D
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 21:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ljrZXP-ERJS7 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 21:36:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1274440472
 for <iommu@lists.linux-foundation.org>; Tue,  6 Jul 2021 21:36:30 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id w127so902967oig.12
 for <iommu@lists.linux-foundation.org>; Tue, 06 Jul 2021 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g1JVJiy081ll+MGQFYrIQnx64nTijHCUrQkv8Wk47Uc=;
 b=SyDsjtI7l4Qry4skD2wvLmbuIkvNN1DlMY1bPGWVilUzHBLHLszzbhcD+3jRO1BOeL
 lPlxDNr9OBbxW7Z4hlnB9l48IidslH2YiYqrethULXiC1PNWksDnRHAeao6WJawnXMNd
 1CCd7Akwq1gi9MNdYTkbDsmSHc0mGNT0DCDNTAOSAUbdYORIfQAqrlv+kEyM+BltHMrD
 lwqGEKx+C7f4LfErjREh2fdktEV49PtQKKMkYjan0SLl4E4KU/d2PUfDCskbx3eEj3Vc
 Rx7q4Tj40TD2dFd/+OuyoTCY1cDXjN/i4QianJReUl7zhzm2mzMaWDbTrh9HtraTluUN
 ntjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g1JVJiy081ll+MGQFYrIQnx64nTijHCUrQkv8Wk47Uc=;
 b=Ub+8319uANVGyZWdU2ahv+Y9WH7ucHmk9Tci2iRSV1UMstYfAvqg2Cjg1t6AMa8byD
 6Na4q1uV6PbZpGNfj866SPT24Gqz/KYX4im70bPoJQYczpbQjkBAQm3VO1CzZQKQdx+i
 W+kwzETbS5ZTXQUspAVybQzgY+6szFtbUhOy502d+YVWOjsLzZm2U5AtZO8ors/JZg/z
 tHZz9RodehWh86GJQknT4/l3TToXSe8hQzM5loIpDqHLsqbQ1E+2XeLjyq1jkx4E/UWz
 cDlLxKniYtlY1boLQcgKbmjcRr17I4pat4x0QJgb16+tK5eZ7tb8MvdsTn0yWJC9p+CJ
 OgUA==
X-Gm-Message-State: AOAM532jb0l7ZCO6Vx+uWHg05xZam+8CrF2sbTTh3B2WuvRVnwlsmMyT
 3FXMjTVdLdMNy1Q/o8pIBZU+aQ==
X-Google-Smtp-Source: ABdhPJxF6cWhxvYgLYDEaV3IFuw7TC+iaZZc2k3kqPOFIabTy82sv63HUgNyNOI+CBJ6updHj0tIvA==
X-Received: by 2002:a05:6808:f0a:: with SMTP id
 m10mr302995oiw.145.1625607390057; 
 Tue, 06 Jul 2021 14:36:30 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id v134sm289352oie.28.2021.07.06.14.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 14:36:29 -0700 (PDT)
Date: Tue, 6 Jul 2021 16:36:26 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 0/5] iommu/arm-smmu: adreno-smmu page fault handling
Message-ID: <YOTM2g9t0/gvNxuh@yoga>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <2016473f-2b38-f049-1e8d-04bdf5af6cea@linaro.org>
 <CAF6AEGu6Wt+FDh_Kp8GrZB9TV7ufTuidmqBfkzA9rcCJc7zSQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGu6Wt+FDh_Kp8GrZB9TV7ufTuidmqBfkzA9rcCJc7zSQQ@mail.gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Lee Jones <lee.jones@linaro.org>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, John Stultz <john.stultz@linaro.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Douglas Anderson <dianders@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>
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

On Sun 04 Jul 13:20 CDT 2021, Rob Clark wrote:

> I suspect you are getting a dpu fault, and need:
> 
> https://lore.kernel.org/linux-arm-msm/CAF6AEGvTjTUQXqom-xhdh456tdLscbVFPQ+iud1H1gHc8A2=hA@mail.gmail.com/
> 
> I suppose Bjorn was expecting me to send that patch
> 

No, I left that discussion with the same understanding as you... But I
ended up side tracked by some other craziness.

Did you post this somewhere or would you still like me to test it and
spin a patch?

Regards,
Bjorn

> BR,
> -R
> 
> On Sun, Jul 4, 2021 at 5:53 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Hi,
> >
> > I've had splash screen disabled on my RB3. However once I've enabled it,
> > I've got the attached crash during the boot on the msm/msm-next. It
> > looks like it is related to this particular set of changes.
> >
> > On 11/06/2021 00:44, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > This picks up an earlier series[1] from Jordan, and adds additional
> > > support needed to generate GPU devcore dumps on iova faults.  Original
> > > description:
> > >
> > > This is a stack to add an Adreno GPU specific handler for pagefaults. The first
> > > patch starts by wiring up report_iommu_fault for arm-smmu. The next patch adds
> > > a adreno-smmu-priv function hook to capture a handful of important debugging
> > > registers such as TTBR0, CONTEXTIDR, FSYNR0 and others. This is used by the
> > > third patch to print more detailed information on page fault such as the TTBR0
> > > for the pagetable that caused the fault and the source of the fault as
> > > determined by a combination of the FSYNR1 register and an internal GPU
> > > register.
> > >
> > > This code provides a solid base that we can expand on later for even more
> > > extensive GPU side page fault debugging capabilities.
> > >
> > > v5: [Rob] Use RBBM_STATUS3.SMMU_STALLED_ON_FAULT to detect case where
> > >      GPU snapshotting needs to avoid crashdumper, and check the
> > >      RBBM_STATUS3.SMMU_STALLED_ON_FAULT in GPU hang irq paths
> > > v4: [Rob] Add support to stall SMMU on fault, and let the GPU driver
> > >      resume translation after it has had a chance to snapshot the GPUs
> > >      state
> > > v3: Always clear FSR even if the target driver is going to handle resume
> > > v2: Fix comment wording and function pointer check per Rob Clark
> > >
> > > [1] https://lore.kernel.org/dri-devel/20210225175135.91922-1-jcrouse@codeaurora.org/
> > >
> > > Jordan Crouse (3):
> > >    iommu/arm-smmu: Add support for driver IOMMU fault handlers
> > >    iommu/arm-smmu-qcom: Add an adreno-smmu-priv callback to get pagefault
> > >      info
> > >    drm/msm: Improve the a6xx page fault handler
> > >
> > > Rob Clark (2):
> > >    iommu/arm-smmu-qcom: Add stall support
> > >    drm/msm: devcoredump iommu fault support
> > >
> > >   drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  23 +++-
> > >   drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 110 +++++++++++++++++++-
> > >   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  42 ++++++--
> > >   drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  15 +++
> > >   drivers/gpu/drm/msm/msm_gem.h               |   1 +
> > >   drivers/gpu/drm/msm/msm_gem_submit.c        |   1 +
> > >   drivers/gpu/drm/msm/msm_gpu.c               |  48 +++++++++
> > >   drivers/gpu/drm/msm/msm_gpu.h               |  17 +++
> > >   drivers/gpu/drm/msm/msm_gpummu.c            |   5 +
> > >   drivers/gpu/drm/msm/msm_iommu.c             |  22 +++-
> > >   drivers/gpu/drm/msm/msm_mmu.h               |   5 +-
> > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c  |  50 +++++++++
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c       |   9 +-
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.h       |   2 +
> > >   include/linux/adreno-smmu-priv.h            |  38 ++++++-
> > >   15 files changed, 367 insertions(+), 21 deletions(-)
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
