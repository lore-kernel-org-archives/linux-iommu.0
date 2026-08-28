Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F113E2746
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907418; cv=pass; b=D3+l40jKRLKgcE9Aw7o8gR2hWQXKKXQjwJWipGp+zBXXO+LMKtuFSEMePT732WPOUYawEkh+FoKKpug+HbFUOsqwCUun8GXzGmPjOTAC6G3Km5/45xy5ETWNLMQadHJ6Af8bpUnX9JmSVc1nY9L1eDT42wa5PnM6U+gofNTMXRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907418; c=relaxed/simple;
	bh=SmO6o6ks0c9uUsIBN0Sbld6q6+dDo0ePNZGGhFN2EAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVrPDTd/he/FjgIxsI8JQKkYBYcPMtMhgrm/LN13C6Eo01UavAzd8YjZIBLddbB9u/DjOuilK/fl0+cpXMwNpXV4d6pOqtChzREPyKh5jvwLBSUXh2ozY2ANpOzCMexPAvhbflQIlLeNNR5QzL4ulLYKRpf3xR9IRspaRzbVfek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VVu2yGve; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VVu2yGve"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c253425b253so129621066b.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787907415; cv=none;
        d=google.com; s=arc-20260327;
        b=EWoYs9NbSW8EcGu7Gx4Uzq4Ss6MTYfnplj8sqQknJjLnlwFeQiPNVqKeP4XoFnvAqR
         xm4fOMi3+nNIlLNTQiYVm8p5aCyoQ3gUfHAZfrxQOGOuLf5XEDtrjI397dHoImhR+dqZ
         USUDy2pWVGx8jn16zuTRbPdFn0rVqXCl1d7wMUWTFOokLFkG57/FJBlQdNPNNbCGDHf/
         PDt7CylGiFEgELmduz40C8Lez7tyAKi4B9nJdqv5ZNzwFeaX/fl03c1b+ulCJ+F799AL
         BWs72sC+Co2BS1NlIjio9izT90xiU7AfMv9rbT72duZqMSBKjie2OFoDnYpCROYNKUNK
         YG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KH0APOVPoRE7sreVg72LcwRkOSoARs0sBWd4BqC6Eg4=;
        fh=viusIlnzjlGfk2troKTZ2OE9y+kgxQ7591ikHfetZJs=;
        b=FUYhcuWiwiKCQ4XxJs3Sr5ofyAqivN5Coc6GALZG7K4xRfXVOjaZLGEc16uFGMbMJO
         5fMJEgZ+zbqlhhSpo845dmdPwCrW7v4JWDlo1aMib4SMKhfEXWrN3zfVjfNBh/TUndg7
         5dc4JDMjE2MFAj8e1k6KzT4Z7HD/A9mYO/Vi+8RXlsUH/yKM/TtRQjEMfcYaU3GDtJlC
         q80Jif9pl4MWkQWpTW6c57T9kXVqEGJ8oAgP+r428e4XuaDyXp26rvz3U/OyNYiBxNjL
         78sUNazY1ngoXhtd7V4hpaNGv5LeqL8Tw7NdgDWnU9MRnUJ/4tUfLs1lw2l+Xz9J239H
         CSxQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787907415; x=1788512215; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KH0APOVPoRE7sreVg72LcwRkOSoARs0sBWd4BqC6Eg4=;
        b=VVu2yGveiw/GjzASivef65ZSSuR25tq5m/S+rYWfrGUOh1VzOheFDBQ8efIeGhREsv
         OSUrMABEupWC/dGWy+PL+hardzgMszDZ8XBW4mtkYZIP7dwWkaf1RcO303MTTlEn+hU+
         Hl89tIod1Dqa4VGtcsyKJI7R2mIOkqlQFbU3W2QOd4gnIdsF92/8qRsHVzPf7mrLkQLk
         BHeh30mipWeIWsgJ1d/sNsaC5V8nokcqisqVYL/3RZ60HUbXm11aj52HNd7BwWKMStgE
         52AZaNJFH14IOfZ5WhOg56mFxfL0D6jHk3j+rsvRa0sANVIZTxM+Kdgc/Tw4MDXe2hz1
         QT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907415; x=1788512215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KH0APOVPoRE7sreVg72LcwRkOSoARs0sBWd4BqC6Eg4=;
        b=GhHOhNDx23kFu9R7In19Hd50FpbN8bNRs0H1Ox1pl0N/R3uGZ7np+YBWB4neAeYEwO
         4gA5iXaqBf50PKLnXWcAIYtePx7gl8LtO+KzSDNaebvjxBjNxHLPDo7M/K9d+gyGCsQC
         jnr06Rd72HMc9kP6yFQBwN8/fxWyZsJhc2wBGlNuDcuNQBNZJ5DpZUHbK/1gQ7V2Hdgv
         buNiSDHwfeHqu5eEMrU1xS6Oa7b8p3OeHQ1vyLuamirM5UWGCTKg7wltKXy48oCJjwnU
         J4MXzj6g1zvN1TrDJDdURRTfFPlpPfujLY5sdJbQuCaJeLsVqJlzgYuPFk5LtVZzHx4m
         Pe4w==
X-Forwarded-Encrypted: i=1; AHgh+RrimDyiarLivLPqM5DWt3zNDG2QMnFaK+JHoHPUUHWQkiOKWNUnKi9IJonIjsWUgNJfmy6wmA==@lists.linux.dev
X-Gm-Message-State: AFuF++l2jAlJ3f/QD7EoT8YmCrjaIAhixbr4YykW4clE2289JqOIsem5
	KREV98ESdNviJwKSJo9/GHqEeX3M9JAOKUyBH5GD9Fias65+GHADw1EvuJueu/tGMGCn6GAjRR1
	HloplJhHHiApmB7RrNFQq01oQIHy+EY75aE6wm3co5g==
X-Gm-Gg: AR+sD1313WfbFhrwNyEO4hYXvXKEH4/8mBs3zCrOdkPVFHLetjt6Y+eCpOJLbpVLdpp
	o7jCcz70SPtxbtBw//J5yAo4xYqwfgyLecH0L83wPTEOZfeU7g3xRZ01ubDP+JgcCuDOxtc/Yj5
	Gu/Z75oPbioKdxgk4eiGzR2KG6nNtgszIW8Z9ccr8tHXrXH/S2xjY9SEPfKOerCZ6FZ2BMHF1MR
	yALSULXwjYXmDMf6T6Gn+8/v9UpbLSYCbfpwHS1Uecxl9/w83gYA8CnnnybBWo89H4fkO5DjlXd
	zwDIX0kCcc1WR4IffmeCqua1jeTSxvvyY9LrHUwamouf73Q=
X-Received: by 2002:a17:906:fe04:b0:c24:c24f:e176 with SMTP id
 a640c23a62f3a-c25571576e4mr284901266b.15.1787907414399; Fri, 28 Aug 2026
 01:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260828070747.4009519-1-zong.li@sifive.com> <CAJF2gTQ-1pKoBvnRSLkDGqwKDzon_yfyT74haifeGD=VRBanYg@mail.gmail.com>
In-Reply-To: <CAJF2gTQ-1pKoBvnRSLkDGqwKDzon_yfyT74haifeGD=VRBanYg@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Aug 2026 16:56:41 +0800
X-Gm-Features: AcwNN1V-ZapGFDA2xiCNdfR0yQ83uvkMjP-C1OSA7d6syIhtKwC-Wxz-1qct13s
Message-ID: <CANXhq0q6nkZapRCKew50azkrmR2Gyh_X7OA39uu1p-kR67QSMQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] RISC-V IOMMU HPM support
To: Guo Ren <guoren@kernel.org>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, david.laight.linux@gmail.com, 
	zhangzhanpeng.jasper@bytedance.com, yang.yicong@picoheart.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 4:49=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Li Zong,
>
> Just two patches? Where did the riscv-iommu PMU driver patch go?
>

I apologize for missing the first commit. I will resend it as PATCH
RESEND v7. Thank you very much for pointing this out!

> --
> Best Regards
>  GUO Ren
>
> On Fri, Aug 28, 2026 at 3:07=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > This series implements support for the RISC-V IOMMU hardware performanc=
e
> > monitor.
> >
> > The RISC-V IOMMU PMU driver is implemented as an auxiliary device drive=
r
> > created by the parent RISC-V IOMMU driver. Therefore, the child driver
> > can obtain resources and information from the parent device, such as
> > the MMIO base address and IRQ number.
> >
> > The thrid commit adds raw spinlock for race condition when PCI MSI/MSI-=
X
> > on IMSIC. As the commit message mentioned:
> > Events are bound to one CPU and the interrupt is affine to it, so the
> > perf callbacks running with interrupts disabled would be enough to
> > exclude the handler. But PCI MSI/MSI-X on IMSIC breaks that:
> > The irqchip sets IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports
> > success while only recording the request, and the move is applied in
> > interrupt context upon the next device interrupt. Until then the
> > interrupt is still routed to the CPU IMSIC picked initially, so the
> > first overflow interrupt can run concurrently with the perf callbacks
> > on the CPU the events are bound to.
> >
> > I noticed that xgene_pmu and arm-cci have similar implementation, so ad=
d
> > it in riscv_iommu_pmu should be accepted.
> >
> > Changed in v6:
> > - Rebased onto the latest v7.3-rc
> > - Use sysfs_emit instead of cpumap_print_to_pagebuf
> > - Set up on_cpu and irq affinity by cpuhp callbacks
> > - Change type of on_cpu from unsigned int to int
> > - Reject filter operands of cycle event in event_init
> > - Check return value of counter number and  masks in probe
> > - Add raw spinlock for race condition (third commit)
> >
> > Changed in v5:
> > - Pick up suggestions from sashiko-bot as follows
> > - Fix event group validation for sw event
> > - Bind IRQ to aux PMU dev instead of parent IOMMU dev
> > - Clear OF bit when event is NULL
> > - Improve hi-lo-hi patten
> > - Add back IRQF_SHARED flag due to mismatch
> > - Manage cpuhp and pmu register by devre
> >
> > Changed in v4:
> > - Rebased onto v7.3-rc
> > - Use is_sampling_event() instead of accessing vairable directly
> > - Rename the matching name from "iommu.pmu" to "riscv-iommu.pmu"
> > - Change the naming of PMU device for avoid ":" in PCIe case
> > - Add suppress_bind_attrs attribute
> > - Remove IRQF_SHARED flag
> > - Set irq affinity to local CPU of IOMMU
> > - Allocate ID by IDA for auxiliary device
> > - Pick up suggestions from sashiko-bot
> >
> > Changed in v3:
> > - Rebased onto v7.2-rc3
> > - Use hi_lo_writeq/readq to access register
> > - Pick comments from sashiko-bot as follows
> > - Set IRQ CPU affinity
> > - Remove IRQF_ONESHOT flag when request irq
> > - Adjust cycle event check by checking event_id field only
> > - Fix bug for group events verificaiton
> > - Fix KASAN issue about casting 32-bit variable to unsigned long pointe=
r
> > - Clear IPSR pending bit before starting counter
> > - Clear OF bit in event selector register in irq handler
> > - Release irq by devm instead of explicit free_irq
> >
> > Changed in v2:
> > - Rebased onto v7.2-rc1
> > - Use hi-lo-hi mechanism to read counter.
> >   Suggested by Guo Ren and David Laight
> >
> > Changed in v1:
> > - Rebased onto v6.19-rc8
> > - Pick all suggestions and feedbacks from v1 series
> > - Add cpu hotplug implementation to avoid race enablement
> > - Move PMU-related definition from header to c file
> > - Change PMU driver to auxiliary device driver
> >
> > Changed in RFC:
> > - Rebase onto v6.13-rc7
> > - Clear interrupt pending before handling interrupt
> > - Fix the counter value issue caused by OF bit in the cycle counter.
> > - Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
> >   in riscv_iommu_remove()
> >
> > Zong Li (2):
> >   iommu/riscv: create a auxiliary device for HPM
> >   drivers/perf: riscv-iommu: protect shared state with a raw spinlock
> >
> >  drivers/iommu/riscv/Kconfig    |  1 +
> >  drivers/iommu/riscv/iommu.c    | 37 +++++++++++++++++++
> >  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
> >  3 files changed, 98 insertions(+), 6 deletions(-)
> >
> > --
> > 2.43.7
> >
