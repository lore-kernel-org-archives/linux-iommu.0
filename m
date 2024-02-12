Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742FA4DA1C
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779918; cv=none; b=jShQn4ZigKIuysY/3MBQFbTobl9FrS3eINOLMtE62wRIQBttiqrEqwN2qWH6Zzt29dIHwfIax6QSGb3wbAHge/5Rp8YyePDnBPfl99ZYFfE72RbiExIscGQ+mng6UKtzUuPrJGzXPaOWFzDelFHgfLT/ZzEINyp2Nl7yS4/0uVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779918; c=relaxed/simple;
	bh=B7pihwsjDfEm8UE0m/hFK9r9fK9HYujiQ7NXpc9fsmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsf/jjXnqn7loTJ1NrKHU9rYj/oCJ8W+EfcBLz09AigDu0PlTMaNdFPYRh4qY/XHanxlQBn9UCUawy3POLu0PL9swAg7GVDV46JZwJYWaYGBJJwVK+/u7DWCmXPQ3wudUnUgEmpiWH3Ami6NytQ1OlDJ8JVjH1TKG2ZvToNvWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwzh9Kpr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwzh9Kpr"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3044781276.1
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 15:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707779915; x=1708384715; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q2oUKZ9+k2fWUDVHdxmDEvSogLo9+LaOxnS10TKDJLQ=;
        b=hwzh9KprXnKIvB6cl2c3KJdVi/B9UXwPe0gUmEcoyEJrO5TOhvwNH20uFvukoj9Xqt
         +uzVjKTksa5rrhLGU4bJlUns4xM3egFO/nO0MoYnPA+kyfWgYBhc+Q7Okghz5jEZf1PR
         +NRGofFp+U0xTSwuxcApcYeWKf/JJwdgAY1EG17atJLjDI8G5e+iErIr7+7B3F5xLlNq
         Eucdn72wVtP0TQIT76aU46DmS9sH+duBZne4CCd7GhL9oQOgtZ6vMWJLatE1TofRG0+4
         9XcSnsx0WXPtA9jz0jEwOVxrJMff3ByBZmJSTc+WbYkEtYia2yXpALSqod3DEllqsIP+
         3lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707779915; x=1708384715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2oUKZ9+k2fWUDVHdxmDEvSogLo9+LaOxnS10TKDJLQ=;
        b=fBDImWoV8LLXV1D4kxjDdrpYxObsb2tKN43nagcddoYp1PvWkdyGKzNsFrJbjy5nYD
         N3HNkIxCdYmqyOnSZYmP5oL9m3G6jKWL0n63NUBLF6S8VNrMRy71IaUEvlbCJ3cYUQz8
         g3swEYpcjWYdycct1TYzM5kPnphzCSzjLas6OwSadNUbacO2q4SE8n4vxwnk9lpKfAKe
         6LbN5+Rpf3z8cs+qeIPi3JHF35UkVDa2UdXqesM4vXnfmuSjga+xlEk9DkoP3mPuiwHj
         8g8OBcjQ9nuoJrPS274F+UWqmduY+BVOoWhCJ19fBc25GBxh/8PK8nm4+cFXSebI6Iqf
         vp2g==
X-Gm-Message-State: AOJu0Yw9tYbjf93xm9NPY5pus/tSStfqlyBqig+56T0b8mbhwZPs1Y3A
	mts8iAWv37Sh72I+rfgffhjEKX8O2kQtPhNYhDVGoh+bwGbqeJz/+MnIhdAz6o2gOjCr1UOkRQ5
	9YnYYBD476obqIbitYWfCohgD/Lt9BfCKIHxmXw==
X-Google-Smtp-Source: AGHT+IE4eLVt2y/x1WM/Sg5v7ZT9w1e+rZDJpX22D6pGoEK1ybOMcLQRNaQPyX7zAEGSwC/QEyXmdBqfKqeNULg9klc=
X-Received: by 2002:a25:ac4e:0:b0:dc6:9d15:be3f with SMTP id
 r14-20020a25ac4e000000b00dc69d15be3fmr712809ybd.2.1707779915351; Mon, 12 Feb
 2024 15:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20240209200538.917366-1-dmitry.baryshkov@linaro.org> <20240209222349.GA923780@nvidia.com>
In-Reply-To: <20240209222349.GA923780@nvidia.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 01:18:24 +0200
Message-ID: <CAA8EJpqdc3nQmTaWYY4VDE7ChV0NjMgBK7Q0rDRTyKZoWtbreA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com, 
	robin.murphy@arm.com, will@kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 00:23, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Feb 09, 2024 at 10:05:38PM +0200, Dmitry Baryshkov wrote:
> > On Tue, 17 Oct 2023 Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > Now that the BLOCKED and IDENTITY behaviors are managed with their own
> > > domains change to the domain_alloc_paging() op.
> > >
> > > The check for using_legacy_binding is now redundant,
> > > arm_smmu_def_domain_type() always returns IOMMU_DOMAIN_IDENTITY for this
> > > mode, so the core code will never attempt to create a DMA domain in the
> > > first place.
> > >
> > > Since commit a4fdd9762272 ("iommu: Use flush queue capability") the core
> > > code only passes in IDENTITY/BLOCKED/UNMANAGED/DMA domain types. It will
> > > not pass in IDENTITY or BLOCKED if the global statics exist, so the test
> > > for DMA is also redundant now too.
> > >
> > > Call arm_smmu_init_domain_context() early if a dev is available.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > For some reason this patch breaks booting of the APQ8096 Dragonboard820c
> > (qcom/apq8096-db820c.dts). Dispbling display subsystem (mdss) and venus
> > devices makes the board boot in most of the cases. Most frequently the
> > last parts of the log loog in a following way:
>
> It is surprising we tested this patch on some tegra systems with this
> iommu and didn't hit anything..
>
> The only real functional thing this changes is to move the domain
> initialization up in time, potentially a lot in time in some
> cases. That function does alot of things including touching HW so
> possibly there is some surprising interaction with something else.
>
> So, I would expect this to not WARN_ON and to make it work the same as
> before the patch:
>
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -875,7 +875,9 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>         mutex_init(&smmu_domain->init_mutex);
>         spin_lock_init(&smmu_domain->cb_lock);
>
> -       if (dev) {
> +       WARN_ON(using_legacy_binding);
> +
> +/*     if (dev) {
>                 struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
>
>                 if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
> @@ -883,7 +885,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>                         return NULL;
>                 }
>         }
> -
> +*/
>         return &smmu_domain->domain;
>  }

With the full device tree, this crashed during the IOMMU probe, no warnings:

[   15.343477] bam-dma-engine 644000.dma-controller: num-channels
unspecified in dt
[   15.343675] bam-dma-engine 644000.dma-controller: num-ees unspecified in dt
[   15.394653] msm_serial 7570000.serial: msm_serial: detected port #2
[   15.395170] msm_serial 7570000.serial: uartclk = 19200000
[   15.401983] 7570000.serial: ttyMSM2 at MMIO 0x7570000 (irq = 37,
base_baud = 1200000) is a MSM
[   15.407549] serial serial0: tty port ttyMSM2 registered
[   15.421567] Bluetooth: hci0: setting up ROME/QCA6390
[   15.421728] arm-smmu b40000.iommu: probing hardware configuration...
[   15.425866] arm-smmu b40000.iommu: SMMUv2 with:
[   15.432153] arm-smmu b40000.iommu: stage 1 translation
[   15.436407] arm-smmu b40000.iommu: address translation ops
[   15.441580] arm-smmu b40000.iommu: non-coherent table walk
[   15.447136] arm-smmu b40000.iommu: (IDR0.CTTW overridden by FW configuration)
[   15.452750] arm-smmu b40000.iommu: stream matching with 2 register groups
[   15.460038] arm-smmu b40000.iommu: 2 context banks (0 stage-2 only)
[   15.466908] arm-smmu b40000.iommu: Supported page sizes: 0x63315000
[   15.473367] arm-smmu b40000.iommu: Stage-1: 48-bit VA -> 36-bit IPA
[   15.481638] arm-smmu b40000.iommu: preserved 0 boot mappings
[   15.491783] arm-smmu d00000.iommu: probing hardware configuration...
[   15.491955] arm-smmu d00000.iommu: SMMUv2 with:
[
Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.XF.1.0-00301


>
> Then I'd ask you to remove the comment and do:
>
> @@ -878,7 +878,9 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>         if (dev) {
>                 struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
>
> +               WARN_ON(true);
>                 if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
> +                       printk("Allocation failure in arm_smmu_domain_alloc_paging()\n");
>                         kfree(smmu_domain);
>                         return NULL;
>                 }
>
>
> And then we may get a clue from the backtraces it generates. I only
> saw one iommu group reported in your log so I'd expect one trace?

With the full device tree, same result:

[   12.319303] bam-dma-engine 644000.dma-controller: num-channels
unspecified in dt
[   12.319502] bam-dma-engine 644000.dma-controller: num-ees unspecified in dt
[   12.370379] msm_serial 7570000.serial: msm_serial: detected port #2
[   12.370895] msm_serial 7570000.serial: uartclk = 19200000
[   12.377773] 7570000.serial: ttyMSM2 at MMIO 0x7570000 (irq = 37,
base_baud = 1200000) is a MSM
[   12.383228] serial serial0: tty port ttyMSM2 registered
[   12.397263] arm-smmu b40000.iommu: probing hardware configuration...
[   12.397441] arm-smmu b40000.iommu: SMMUv2 with:
[   12.398072] Bluetooth: hci0: setting up ROME/QCA6390
[   12.402779] arm-smmu b40000.iommu: stage 1 translation
[   12.402817] arm-smmu b40000.iommu: address translation ops
[   12.402832] arm-smmu b40000.iommu: non-coherent table walk
[   12.402848] arm-smmu b40000.iommu: (IDR0.CTTW overridden by FW configuration)
[   12.402881] arm-smmu b40000.iommu: stream matching with 2 register groups
[   12.402943] arm-smmu b40000.iommu: 2 context banks (0 stage-2 only)
[   12.402987] arm-smmu b40000.iommu: Supported page sizes: 0x63315000
[   12.403004] arm-smmu b40000.iommu: Stage-1: 48-bit VA -> 36-bit IPA
[   12.404941] arm-smmu b40000.iommu: preserved 0 boot mappings
[   12.467015] arm-smmu d00000.iommu: probing hardware configuration...
[   12.467318] arm-smmu d0
Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.XF.1.0-00301

Even with disabling display-subsystem and venus, it crashes at the
same place, I don't seem to be able to get past it anymore.

-- 
With best wishes
Dmitry
