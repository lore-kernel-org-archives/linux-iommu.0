Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13395C433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:04:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1742084C
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXTOyAOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1742084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 911D1232FA;
	Fri,  3 Jul 2020 16:04:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCC28vI6CL7E; Fri,  3 Jul 2020 16:04:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E7407204E1;
	Fri,  3 Jul 2020 16:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB49EC088E;
	Fri,  3 Jul 2020 16:04:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC35FC0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CB0C587D52
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 61twUTCmpUtj for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 16:04:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0652287D47
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 16:04:21 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id g20so28002631edm.4
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X/kUxjEepXtiPp+5nrjETtriBB7vp52saJU42L3Q0Ek=;
 b=NXTOyAOQ4GoupnlWcTajW/yNVeDnYrfHcp4BtrD8hDhof+ZevAzYJm3TxuAGYtrvIX
 rXs7IFYPAFaAYkPSaGYVPBBgx6wUXpVU7Tf2ZSfU3HSQNZuIfqmfnlHdR+0A3wooDual
 nww+ROO2dUWuJ2ti+hBkqVqEvZ4/hV0oUVxIg0fkD2qdrTqnRvFxJTPvp4CItzB1qJ33
 WDZPCtPVHuafx+0x1a3uAUjL2W/abTWpcNOi1zYqkyWNo9TnJ1r8zsPjqs3p1NNLj7+e
 BcY9+L3RcT/CUwC72p1r8dLp4ozaSzFkg9YeIqLuX1w6Y0NorfG4CmhwiljG3gO09s6G
 0jOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X/kUxjEepXtiPp+5nrjETtriBB7vp52saJU42L3Q0Ek=;
 b=L9IbGfIRi+2xmZq0mZE9vOs11OZZqLr2RD2yI7RnxKbCr8rtD3fuQREk5CzABjnQKL
 66dIh6mdF8o45ynwwjUdPhNLxoTqlWNV9litLac5GVYnrKKxOykJ9MNpRy2qTIpjKRjd
 lXU29kl43E0xsIqXGo0bzfXEEwwkSOQ5d6CVWqgmnESYuQzTmL4uTzVIdT+u0bDVF/V2
 TqlxzjsHVmYRogJf7i+qQtlxXZXfZTsiIpHaLHAD7xvRSOnO3MnPvNWIKchGqBFjhhXL
 VDdrp15bEa8R420nVMnIEHVBX9Dsk4JeVLbx9nqfYtHoGXul5OGl45x/PTeL1hAKINg9
 XNEw==
X-Gm-Message-State: AOAM530yAaEIn8+5Biq60U4T+dCCZYGaM+5+1jnYer2YTmTXZXNloAwn
 6T70oRej4aVSecRLyXMD8tXEtciF/ui8Wlepne4=
X-Google-Smtp-Source: ABdhPJwY+TDU+zLAlj3AXwzh91hebM+nK4d4Q98sJyCJl1eumLSurp18Wh0DJ0XCpOtgEb4A9pmtUBcHSW9aUnmJcXw=
X-Received: by 2002:aa7:c656:: with SMTP id z22mr28236616edr.101.1593792259297; 
 Fri, 03 Jul 2020 09:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593344119.git.saiprakash.ranjan@codeaurora.org>
 <449a6544b10f0035d191ac52283198343187c153.1593344120.git.saiprakash.ranjan@codeaurora.org>
 <20200703133732.GD18953@willie-the-truck>
 <ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org>
In-Reply-To: <ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 3 Jul 2020 09:04:49 -0700
Message-ID: <CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com>
Subject: Re: [PATCHv3 7/7] drm/msm/a6xx: Add support for using system
 cache(LLC)
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Sean Paul <sean@poorly.run>, freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthias Kaehlcke <mka@chromium.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Sharat Masetty <smasetty@codeaurora.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Emil Velikov <emil.velikov@collabora.com>
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

On Fri, Jul 3, 2020 at 7:53 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Will,
>
> On 2020-07-03 19:07, Will Deacon wrote:
> > On Mon, Jun 29, 2020 at 09:22:50PM +0530, Sai Prakash Ranjan wrote:
> >> diff --git a/drivers/gpu/drm/msm/msm_iommu.c
> >> b/drivers/gpu/drm/msm/msm_iommu.c
> >> index f455c597f76d..bd1d58229cc2 100644
> >> --- a/drivers/gpu/drm/msm/msm_iommu.c
> >> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> >> @@ -218,6 +218,9 @@ static int msm_iommu_map(struct msm_mmu *mmu,
> >> uint64_t iova,
> >>              iova |= GENMASK_ULL(63, 49);
> >>
> >>
> >> +    if (mmu->features & MMU_FEATURE_USE_SYSTEM_CACHE)
> >> +            prot |= IOMMU_SYS_CACHE_ONLY;
> >
> > Given that I think this is the only user of IOMMU_SYS_CACHE_ONLY, then
> > it
> > looks like it should actually be a property on the domain because we
> > never
> > need to configure it on a per-mapping basis within a domain, and
> > therefore
> > it shouldn't be exposed by the IOMMU API as a prot flag.
> >
> > Do you agree?
> >
>
> GPU being the only user is for now, but there are other clients which
> can use this.
> Plus how do we set the memory attributes if we do not expose this as
> prot flag?

It does appear that the downstream kgsl driver sets this for basically
all mappings.. well there is some conditional stuff around
DOMAIN_ATTR_USE_LLC_NWA but it seems based on the property of the
domain.  (Jordan may know more about what that is about.)  But looks
like there are a lot of different paths into iommu_map in kgsl so I
might have missed something.

Assuming there isn't some case where we specifically don't want to use
the system cache for some mapping, I think it could be a domain
attribute that sets an io_pgtable_cfg::quirks flag

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
