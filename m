Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DFD13AD20
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817299; cv=none; b=joTwyyG5YTCrvwh4dVCwuyiac/gsjdV1fXGk2099Q7V+xMDBzA3SEtJR+YQMyCfhSoM0iNyAZ378L0qb2QVHVBc+5XggWsgzv8v2H0lxmZuY9OMHa50IqyBJwxxpSDOgTSfWUfpgHub1BHCeXy6uxFWFKMCYnxI+HsFbt1SycNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817299; c=relaxed/simple;
	bh=26cu36Y/aumavTKVnlTu8SUqS9rPkploIx7N5kO87RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmVg2gYJIHzNgo+Xzo9pCKmwVXhyQ7qX+PcKcrDmeMB7G9KkhLjeljxEMAQXCME9pCXizHiGUyy/b05TcEY8HSX9+JqGXtC0FkRJdYXoI75waWl1TvOZoxaLmFRcq6KVkNX8EhwGOm1AOgOQRnfoKxJ33ljelJCIFXZYwKTItM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SwXvmqoz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SwXvmqoz"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e998c70f9so3004711fac.2
        for <iommu@lists.linux.dev>; Mon, 09 Dec 2024 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733817296; x=1734422096; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPQvSbygqgIrExnr2bcxHFawcj0mKCE45rlYtPqLVSE=;
        b=SwXvmqozn5WW8z0N1EYl0TTI03liviQjqg37ib/TPjnEiZC/DJKgZoalAm63veHlok
         ez4Zr0yj+7Yp4uP1P5PBKmvQvPbQJPwj+fqygDMNbJ46sU7b1nH2WsLecW+52lrV2vXA
         Ky8kNJ31F7v2BzUrzxEF5YBIanFEStTI/hqNOIiPtZxVKRKenXMSg24C1qXKi/bdfpLI
         e+d5Ju7piEFKU4Jcc7H6VFJAvydjlw+E7zxUKmac9XJ+YdFmUHBgizIOVuPrJdGB/W8i
         YqjxITgJGJKwmdJOs6Nww6fISs4mrCODm+lRxSbs/BWpJfjx6orU5a2+Ijl2KS+zoria
         ltug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817296; x=1734422096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPQvSbygqgIrExnr2bcxHFawcj0mKCE45rlYtPqLVSE=;
        b=n9X4C2O9cAUtvm9QtS/ERvt44pnTy8V5Ko7m52haJeW8I8LFK73189ltL4WurETUAD
         vap9wWOBkSBFrTWPLlt+73Cqm/h+jikvPzCIejnVgBieWEpe8HkNPop+xfHUSB2FjY+E
         hiLi2GhPk49bv+XSHOG74ExXTgME7p/sEgvC6ts0nMWX82QuusYZe2qnr7wN/V/y/AZ5
         /GWASb2aiEvNI7WCjnJgwLxtHA/RvCgPvmKE2q/aZQb1lS5LjUzZi1AYjnO5v5Qoezp6
         qJ9QQRG2wlGMLXbEo5UfeHv+t3H7JL8WlDjNPzCJhwLQGU4JVHmbt6sHeKUds+rdyzK0
         dIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuWA/EFWa1rQbIAL2mt22mrs17d1269cJ8SM9m75pyTGJB1s+ytarNVMHcg1VYySVID3ndaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0mrMTmWp/aZOZYXwfQX7Qarjy1w/9LdUV1aiAfI9mvFQLFeiz
	xi50ve0jF9YbHltVZ+OQ9o14r3wBi/HzpUwmrha1uGcpNjMSFuRVE7S+KAWr0QMZlImws5kKIRu
	hsyROJskcQOUVZeKWpwXG6ShuVnTI9CgkBSzjRg==
X-Gm-Gg: ASbGncugi4PvTfA1KANL7iu2Tr9bGcjOODvTB+SHZ7FVcVh6VyR+ORRErGQFRAKtZHG
	W4kItBoXa+8txzphQEm94ddQTgx32bBLP1UChDw==
X-Google-Smtp-Source: AGHT+IEtSPr48pGU/X+eSQ59PgbAI2DXvJGXJO+Mwo2oW/aawM83bRTg9TYcK3/pr5ZgifHEYZHiB2LUsmyVyglKvrY=
X-Received: by 2002:a05:6870:f78a:b0:296:e88f:8f56 with SMTP id
 586e51a60fabf-29f7389c4e1mr14517090fac.26.1733817296059; Mon, 09 Dec 2024
 23:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-3-zong.li@sifive.com>
In-Reply-To: <20240614142156.29420-3-zong.li@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 10 Dec 2024 15:54:45 +0800
Message-ID: <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com>
Subject: Re: [External] [RFC PATCH v2 02/10] iommu/riscv: support HPM and
 interrupt handling
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add Luxu in the loop.

On Fri, Jun 14, 2024 at 10:22=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote=
:
>
> This patch initialize the pmu stuff and uninitialize it when driver
> removing. The interrupt handling is also provided, this handler need to
> be primary handler instead of thread function, because pt_regs is empty
> when threading the IRQ, but pt_regs is necessary by perf_event_overflow.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8b6a64c1ad8d..1716b2251f38 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq,=
 void *data)
>         return IRQ_HANDLED;
>  }
>
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +
> +/* HPM interrupt primary handler */
> +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> +{
> +       struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *=
)dev_id;
> +
> +       /* Process pmu irq */
> +       riscv_iommu_pmu_handle_irq(&iommu->pmu);
> +
> +       /* Clear performance monitoring interrupt pending */
> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_=
PMIP);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* HPM initialization */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +       int rc;
> +
> +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +               return 0;
> +
> +       /*
> +        * pt_regs is empty when threading the IRQ, but pt_regs is necess=
ary
> +        * by perf_event_overflow. Use primary handler instead of thread
> +        * function for PM IRQ.
> +        *
> +        * Set the IRQF_ONESHOT flag because this IRQ might be shared wit=
h
> +        * other threaded IRQs by other queues.
> +        */
> +       rc =3D devm_request_irq(iommu->dev,
> +                             iommu->irqs[riscv_iommu_queue_vec(iommu, RI=
SCV_IOMMU_IPSR_PMIP)],
> +                             riscv_iommu_hpm_irq_handler, IRQF_ONESHOT |=
 IRQF_SHARED, NULL, iommu);
> +       if (rc)
> +               return rc;
> +
> +       return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iom=
mu->dev));
> +}
> +
> +/* HPM uninitialization */
> +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> +{
> +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +               return;
> +
> +       devm_free_irq(iommu->dev,
> +                     iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMM=
U_IPSR_PMIP)],
> +                     iommu);
> +
> +       riscv_iommu_pmu_uninit(&iommu->pmu);
> +}
> +
>  /* Lookup and initialize device context info structure. */
>  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_devi=
ce *iommu,
>                                                  unsigned int devid)
> @@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *=
iommu)
>         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
>         riscv_iommu_queue_disable(&iommu->cmdq);
>         riscv_iommu_queue_disable(&iommu->fltq);
> +
> +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +               riscv_iommu_pmu_uninit(&iommu->pmu);
>  }
>
>  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device *io=
mmu)
>         if (rc)
>                 goto err_queue_disable;
>
> +       rc =3D riscv_iommu_hpm_enable(iommu);
> +       if (rc)
> +               goto err_hpm_disable;
> +
>         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
>                                     dev_name(iommu->dev));
>         if (rc) {
> @@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
>  err_remove_sysfs:
>         iommu_device_sysfs_remove(&iommu->iommu);
>  err_iodir_off:
> +       riscv_iommu_hpm_disable(iommu);
> +err_hpm_disable:
>         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
>  err_queue_disable:
>         riscv_iommu_queue_disable(&iommu->fltq);
> --
> 2.17.1
>
>

Thanks,
Yunhui
