Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D2C49ED7
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:11:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50AC2089F
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 17:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGVn97TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50AC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B07E5E2B;
	Tue, 10 Sep 2019 17:11:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7CAB1E2A
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:11:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0C68D8AC
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 17:11:02 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id i1so17864199edv.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iuWQbHX+PMmNOYmd/8pxmVPIKdIed7YlISeGMgRidgc=;
	b=nGVn97TTZhK0PPPfJL9dl6WBhPT2YLeqSt3p+U7yVwjN5WBJDYwgKSOc1NbPrCdimp
	+jFNz7Grhyg+FrsoHamdre2gg4lQ1KAh8/MamoeZAraCi06wUTgRTi8DknjKoLQ76fke
	6WP/46MkYH+188U0fEj/iwGNh+L+E8hcVZ3A7e0ROH7WowUWLEICs/dkWSVdQJ8MsTOZ
	g9tjXofI2V9D49kezB8GYV1VdthPv7Yd6dZO94FeMzDOsp1HyILdtrJIhI9/dl9Mp4QP
	vl1VA0XHL8OZtRUblScbQfNTHWOkd+9bzr6/O5+MlhfATeHSX9LxnWbvp71P6++vzL0Z
	vTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iuWQbHX+PMmNOYmd/8pxmVPIKdIed7YlISeGMgRidgc=;
	b=mvZrctnh8rKQjv3NcsnCZEOaJncvLZup8JLWvRgfbw+cPYBv2Gz0Tiz0ZaDFLDR13z
	gRzgaHlMUvBss31r9bDwgcJx6X7cAto8i1ZBjHTk9p88XGga6RTEf+U8j168B4+pvq17
	P8pigjkCNlG+Nqw5T638Uzr0oEQvU92RzWkt+SzTDWZsDJ3ZzUyDp+tjkL15/fB6sHKB
	G4rc5jxyaKT66lBgs0HduoHmWmxo+vH0au5J4MphriYBL4VZm1Yv7YSxHiJuPyXhyZ9P
	13okuQuu6mNXJr1ZHz+x/B6N5qKBq0BOKs3HEEJ7re0EO8mONkDaVKdtWSQjoghjNJSe
	RcEg==
X-Gm-Message-State: APjAAAUux0Yf1WwV64LigbikrRd4FYzAObCl9IOAIyGn46L5RDicECHR
	aEZMl6XviAaAL5p1Lcv/ZF2tUb5czvoGMQAr8tE=
X-Google-Smtp-Source: APXvYqxiIVIycVxvEEUmiCW5coXzW8/2YE/GZpopAwpb2E0GVaAmfqW3+sFpN7JvdeaqLP5yP2YwvFPlBP2u18+UK6I=
X-Received: by 2002:a17:906:3293:: with SMTP id
	19mr25728734ejw.265.1568135460497; 
	Tue, 10 Sep 2019 10:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190906214409.26677-1-robdclark@gmail.com>
	<c43de10f-7768-592c-0fd8-6fb64b3fd43e@arm.com>
In-Reply-To: <c43de10f-7768-592c-0fd8-6fb64b3fd43e@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 10 Sep 2019 10:10:49 -0700
Message-ID: <CAF6AEGv5WtwOuUE-+koL3SxuoXxcT5n=EooD7G_4YRh34HFTwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iommu: handle drivers that manage iommu directly
To: Robin Murphy <robin.murphy@arm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel <dri-devel@lists.freedesktop.org>, Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Clark <robdclark@chromium.org>,
	Jonathan Marek <jonathan@marek.ca>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mamta Shukla <mamtashukla555@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Abhinav Kumar <abhinavk@codeaurora.org>, Bruce Wang <bzwang@chromium.org>,
	Alexios Zavras <alexios.zavras@intel.com>,
	Sean Paul <seanpaul@chromium.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Allison Randal <allison@lohutok.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:DRM DRIVER FOR MSM ADRENO GPU"
	<freedreno@lists.freedesktop.org>,
	Georgi Djakov <georgi.djakov@linaro.org>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 10, 2019 at 9:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/09/2019 22:44, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > One of the challenges we have to enable the aarch64 laptops upstream
> > is dealing with the fact that the bootloader enables the display and
> > takes the corresponding SMMU context-bank out of BYPASS.  Unfortunately,
> > currently, the IOMMU framework attaches a DMA (or potentially an
> > IDENTITY) domain before the driver is probed and has a chance to
> > intervene and shutdown scanout.  Which makes things go horribly wrong.
>
> Nope, things already went horribly wrong in arm_smmu_device_reset() -
> sure, sometimes for some configurations it might *seem* like they didn't
> and that you can fudge the context bank state at arm's length from core
> code later, but the truth is that impl->cfg_probe is your last chance to
> guarantee that any necessary SMMU state is preserved.

cfg_probe is where Bjorn's patch is preserving the SMMU state.  So I
think that should ensure device_reset() preserves the configuration..
or at least if something is missing, that seems fixable.

> The remainder of the problem involves reworking default domain
> allocation such that we can converge on what iommu_request_dm_for_dev()
> currently does but without the momentary attachment to a translation
> domain to cause hiccups. That's starting here:
>
> https://lore.kernel.org/linux-iommu/cover.1566353521.git.sai.praneeth.prakhya@intel.com/

I suppose if the stream-match state and bootloader chosen context bank
is preserved, then keeping it direct-mapped would avoid things
starting to fault before display driver is probed.  That plus some
solution for GPU default domain would narrow the scope of what I need
to just avoiding getting iommu dma_ops installed.

> > But in this case, drm/msm is already directly managing it's IOMMUs
> > directly, the DMA API attached iommu_domain simply gets in the way.
> > This series adds a way that a driver can indicate to drivers/iommu
> > that it does not wish to have an DMA managed iommu_domain attached.
> > This way, drm/msm can shut down scanout cleanly before attaching it's
> > own iommu_domain.
> >
> > NOTE that to get things working with arm-smmu on the aarch64 laptops,
> > you also need a patchset[1] from Bjorn Andersson to inherit SMMU config
> > at boot, when it is already enabled.
> >
> > [1] https://www.spinics.net/lists/arm-kernel/msg732246.html
> >
> > NOTE that in discussion of previous revisions, RMRR came up.  This is
> > not really a replacement for RMRR (nor does RMRR really provide any
> > more information than we already get from EFI GOP, or DT in the
> > simplefb case).  I also don't see how RMRR could help w/ SMMU handover
> > of CB/SMR config (Bjorn's patchset[1]) without defining new tables.
>
> The point of RMRR-like-things is that they identify not just the memory
> region but also the specific device accessing them, which means the
> IOMMU driver knows up-front which IDs etc. it must be careful not to
> disrupt. Obviously for SMMU that *would* be some new table (designed to
> encompass everything relevant) since literal RMRRs are specifically an
> Intel VT-d thing.

Perhaps I'm not looking in the right place, but the extent of what I
could find about RMRR tables was:

https://github.com/tianocore/edk2/blob/master/MdePkg/Include/IndustryStandard/DmaRemappingReportingTable.h#L122

I couldn't really see how that specifies the device.  But entirely
possible that I'm not seeing the whole picture.

I am a bit curious about how windows handles this, since they must
have the same problem on these laptops.

> > This perhaps doesn't solve the more general case of bootloader enabled
> > display for drivers that actually want to use DMA API managed IOMMU.
> > But it does also happen to avoid a related problem with GPU, caused by
> > the DMA domain claiming the context bank that the GPU firmware expects
> > to use.
>
> Careful bringing that up again, or I really will rework the context bank
> allocator to avoid this default domain problem entirely... ;)

That doesn't seem like a bad outcome ;-)

BR,
-R

> Robin.
>
> >  And it avoids spurious TLB invalidation coming from the unused
> > DMA domain.  So IMHO this is a useful and necessary change.
> >
> > Rob Clark (2):
> >    iommu: add support for drivers that manage iommu explicitly
> >    drm/msm: mark devices where iommu is managed by driver
> >
> >   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    | 1 +
> >   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   | 1 +
> >   drivers/gpu/drm/msm/msm_drv.c              | 1 +
> >   drivers/iommu/iommu.c                      | 2 +-
> >   drivers/iommu/of_iommu.c                   | 3 +++
> >   include/linux/device.h                     | 3 ++-
> >   7 files changed, 10 insertions(+), 2 deletions(-)
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
