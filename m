Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E8C4320A
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1B6610FC
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA1B6610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6361A403DF;
	Mon,  2 Aug 2021 15:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wE0oncHr_upS; Mon,  2 Aug 2021 15:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC02C401C5;
	Mon,  2 Aug 2021 15:03:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE540C001B;
	Mon,  2 Aug 2021 15:03:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1F98C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FDB283A8F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id llPmwp76e3Bp for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 15:03:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F415583A87
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:03:56 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id n12so21860569wrr.2
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7XHOcI1iqZxijVLGLW7nItKOPrRmjBgh32wAYk4SY0A=;
 b=XHfgl+M3acCK7c0V7HKcPwXjFcClgkgpF8EEGCvsL19dxnBBG8PXPRDF0zkNLhAD8C
 eoElgSmdGbPUlGq0V/ocmmR/FLq0tG2IvgAFaeO0dAPN+lrF5Z5l68N7kuJnebiW22km
 AjHuMo7XLOekNR127PjRnsWmXdYNG5QBW93oZYKySrszC/IQ1M+p2SCvLhVmy4jGlZgi
 NV2kQ2FPtPB5CHuO16ms8wcPhglWnWHekMJQChMndk42kaSo3w+aN2L6H1UKXpq2JD57
 J/e9MuBhv8XBN+aL4sxNFY29iIIpagoCscQ9lmuvskMtv/HlEwPCDZ10W664wygmid0Z
 l6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7XHOcI1iqZxijVLGLW7nItKOPrRmjBgh32wAYk4SY0A=;
 b=E1ol7sXqzIvt31aHtrw3P2ylE6WmB665gM8d9DNvYiY2MV0Ozn9lsGXsuX+L5qEDGA
 LuzVxTNyLdtprKufRX2aXAdGM/gMFdsOj32Bg3a/6AHrA2M9OmI96vUT/B6hZiZfwHH4
 eN4z6UpwnUaqGudYeOsK1p0yuElyDjEz62Fkr8cuy/wdlJlJe9IEeX+jJXhaPpBMzNXY
 xEYnCVzMYwD0GwM5z//SSfknktrvcUskS9hdg5ogBMGCe0GN8X8l9fQA2e13GVsMfcxg
 jgKFw0Vx/0PKDt2A+j8PFlNTNDDh0O5Z66LW1eHOPiUysa0H7/UwWcUQikkzUhyi6Q1G
 Bf3w==
X-Gm-Message-State: AOAM532D+cH8q3C5r7I9O5jzX3sUmeei1l17cixvQroJbUrxsdMDKCQY
 puMitdExEBPo7pCe8jKACYDHQSVMq/RM8BeImcg=
X-Google-Smtp-Source: ABdhPJwGH/Eqr7CF+Kt6gNll6QNMzEySN4X0hbpZ4Q5OsyHEbBPyczRncKgDY8mkF35HvK0Ng4dxN6be2gs74L1YFnE=
X-Received: by 2002:a5d:4348:: with SMTP id u8mr19002665wrr.28.1627916635155; 
 Mon, 02 Aug 2021 08:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
 <20210802105544.GA27657@willie-the-truck>
In-Reply-To: <20210802105544.GA27657@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 2 Aug 2021 08:08:07 -0700
Message-ID: <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters
 to use system cache
To: Will Deacon <will@kernel.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sean Paul <sean@poorly.run>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 2, 2021 at 3:55 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
> > On 2021-07-28 19:30, Georgi Djakov wrote:
> > > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
> > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> > > > the memory type setting required for the non-coherent masters to use
> > > > system cache. Now that system cache support for GPU is added, we will
> > > > need to set the right PTE attribute for GPU buffers to be sys cached.
> > > > Without this, the system cache lines are not allocated for GPU.
> > > >
> > > > So the patches in this series introduces a new prot flag IOMMU_LLC,
> > > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
> > > > and makes GPU the user of this protection flag.
> > >
> > > Thank you for the patchset! Are you planning to refresh it, as it does
> > > not apply anymore?
> > >
> >
> > I was waiting on Will's reply [1]. If there are no changes needed, then
> > I can repost the patch.
>
> I still think you need to handle the mismatched alias, no? You're adding
> a new memory type to the SMMU which doesn't exist on the CPU side. That
> can't be right.
>

Just curious, and maybe this is a dumb question, but what is your
concern about mismatched aliases?  I mean the cache hierarchy on the
GPU device side (anything beyond the LLC) is pretty different and
doesn't really care about the smmu pgtable attributes..

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
