Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796558;
	b=HSw7AbYPqwTWGf5/SYdyimBRuXm4vLWVPKFirsSvKd7VzHGBpDW0evSq/zFoFM1Hp4rr
	 c2zMszBc2BBN7v8z1sQJLFq2VbG8TvzXlcOv6dgYvxZO9aDeczl2XY4L1mb/9qaeS9fs5
	 bEIc15IX8JRlBojRYXglvM8ekK0PTUCmIraq0xC8f3MqLhhLcIvv1G/+bfM9R2/rEdkk2
	 AIjLUCmN8pVTCnISrzFFw3I34phWOepv4hv9sUywZkTGzON1BR2YupQ5WGPmy3ZL8CimC
	 LO+9FmZmoNFwQKXqi3CSqUXBernA3+Fi+FFdtJYjJDdexrzJuGFq8jRMgH2WJSvD3mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796558;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2FluCkB23A2rX2sPHBDAcwkjRgUYCjrVI/IlnA5wVSI=;
	b=hqj1NgJq+eEw0Ih/w9tEwuyLGNz9lgy1nEyZlfVKASUlyGLqNsset0qY4viDxltalQxp
	 lRy9VN9XigPPntwFspOE4ymg3ODmTA6doD+hrlM6EFsqXYCj4kt9vMOcLPGJcJ/6HTCHl
	 M3E+IoqFnKJPgGeexuFRXGCHfjId4iOvb4lxPOckS1kFWHuZS0nYL55LMwmCF1fksIyVg
	 NxGTbQ281m4IMjVnsf6Oz3wJt7YMysWgSOfJqgvXUMGw+8mUZpoFk23JqYTKvtWo5XFSz
	 ZzVI2NsCLYLgjW+Sqwmu90Brb+p9oyS3H4GpaIVgqfBgBfAY8Mkx2+mbV9dapEGnpaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853A606A324
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 16:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E853A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67bee1f693bso6470222d50.1
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796557; x=1796401357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FluCkB23A2rX2sPHBDAcwkjRgUYCjrVI/IlnA5wVSI=;
        b=VDu2UZPVxciAUfZz5O6Rz/jvqbNSzAiT4n5TsjyGgWeKxn0K0Nh+Lan9tyu5kE5z35
         nMdnX8kpN18acx8E2JWEMSWjBSqpOcwD4ozRTf61TFKBhWiMd7x5rOYQgQ2ASQouWSJ8
         GwSeHSa2TO0X9A/ucQsLCSjB7QXpOZCEP+S3AcsIleLv8hrdgeDD++jXb38duqcbh1cT
         Yt9EhcLJSBpKRDjHpAk13d21NRuHpQKAj9eg/dB1mk5NHy6ID0O28hC4tVVWLdnTswV5
         eOpYVjVpcpXcm0Kypt1LHVdtic2+jIx1OPN3G742voAfbSuFNTrn5pCPaDNoUPu0fEN4
         18Tg==
X-Forwarded-Encrypted: i=1; AL+hErFI0dQ8XxrtSRtjALlnlzC6ZfiYSqec9YTcXq8MwqllSZzbYrrpMkWVzRwCMkfluaqY80yZNw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8okREd95PI8lmHaA+OhPxOBoonThHRj7jDGJfx5UNx7PqPP8Pp
	XuGzpt3ubX1sJjpucJOJHgZr5w9pbbt74Iib8806bHvo6J7ikBov9nI0zgzkUw==
X-Gm-Gg: AZFdTZfE7cLfsu+S/uWLg4Qnzll3rd6khAa21c1U60YYZNoASQ8NgQiP0mVJAhUShBJ
	njVs5jDLCQuPydrj2l3LCQWr7fz7PrfXbmt1fWfumzljaIFx6NN/Omeh4kgkg7mGRZvhLWa3MsT
	Fydo0Aqs7qKhLTSfIDEJPs9fnWFPMQphh2n7kll9MEDIuGErAZ59Y4gq0IY05NkXaWHMRJfzv4c
	QWd8SlB5skNwqAPQv2fSJcLun757SkUoY2/M2VGkBTZjkR/1VPR6i03V2QaiK1FnZHfjk1Y6cie
	CdyWGL1YDcZsQqwHIhoSR7qzbCBFpTtDr+PpJ5KACpfxdB5t34RKmbi3zPrisF5nTQCQJn7YniF
	Nd62HJ5X7WxsS7HOzRLAiBOuAOYCNPGpZOk1qJ8O+TrOMgAt6EDh9WnztpJd5XnmXxm/CejqXC9
	4gLjGh3Y+b47LtVAWQ8A2sDOThvbqMH14eF8g+7oFGdOtWBhBpn6MAOZSch52gjzOk8Gt3bfujZ
	xwLRz8cuwW8Wg095lAArwCj2trEB9F3D+yYl7sf0Q9Ai46p7Ip+mALwS/30ztWthyl7IDiUrZE1
	YMfePqiggZImUE7K34lvOHB+6Lgn1igPYPucZQK+0Df7u9UJ24HBosjekPfelt/qgMb4D+7Y1Lv
	lOX/AeAnN8GJ/c3VsLGMDH8IdVG3PORINnc0ia7Gt1i9BAPYRnukemk5TRhQ=
X-Received: by 2002:a05:690e:b8d:b0:679:cc49:55cb with SMTP id 956f58d0204a3-67df44b8ae6mr12417130d50.99.1795796556703;
        Fri, 27 Nov 2026 08:22:36 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df3354fe3sm11354458d50.10.2026.11.27.08.22.35
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 08:22:35 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b531cd9bbaso72845327b3.2
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:22:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEGt4FRKQpwTWvPJ1NFHmRG5JX8a4sDklNoFrcC+yDcNeB3p8kDAIj5jgH9KY8Kh6leTUzwsg==@lists.linux.dev
X-Received: by 2002:a05:690c:9a82:b0:8b0:c71d:2b2b with SMTP id
 00721157ae682-8b5205137b8mr119923687b3.45.1795796555253; Fri, 27 Nov 2026
 08:22:35 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261114133738.52817-1-tanure@linux.com>
In-Reply-To: <20261114133738.52817-1-tanure@linux.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Fri, 27 Nov 2026 16:22:23 +0000
X-Gmail-Original-Message-ID: <CAJX_Q+15Vit+pU3XE+DiUH4u6APf-FYBuhnrVGx9=pZC8MGpWw@mail.gmail.com>
X-Gm-Features: Aa3M54quNMc8BBDlmy1z8lmGJhR7RotCtAP1c_2g21GpRyDjwzEWIScV0cEj9Ts
Message-ID: <CAJX_Q+15Vit+pU3XE+DiUH4u6APf-FYBuhnrVGx9=pZC8MGpWw@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: do not walk the page tables of a disabled MMU
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 1:37=E2=80=AFPM Lucas Tanure <tanure@linux.com> wro=
te:
>
> A page fault handler running while another CPU detaches the same IOMMU
> can read a cleared RK_MMU_DTE_ADDR, turn it into a linear-map pointer
> and dereference it, which panics the machine. A dummy or firmware-left
> address is as unsafe.
>
> Seen on PX30 at reboot: the display controller still fetched an
> unmapped framebuffer, its IOMMU sat in a page fault, ignored the stall
> and paging-disable commands, and had RK_MMU_DTE_ADDR cleared during
> the handler's second run.
>
> No wait works: the master shares the line, the RK3588 NPU driver
> detaches from its interrupt thread, where synchronize_irq() deadlocks,
> and synchronize_hardirq() skips a force-threaded handler. A spinlock
> orders the walk against the register clear.
>
> 6.1 vendor kernel log, rk_pagefault_done is the walk, per CPU:
>
>   CPU 1, init, reboot path:
>   [ 1069.789374][    T1] rk_iommu ff460f00.iommu: Enable stall request ti=
med out, retry_count =3D 0, status: 0x0002cb
>   [ 1069.791314][    T1] rk_iommu ff460f00.iommu: Disable paging request =
timed out, retry_count =3D 0, status: 0x0002cb
>   [ 1069.830197][    T1] Call trace:
>   [ 1069.830922][    T1]  iommu_detach_device+0xd0/0xdc
>   [ 1069.831483][    T1]  rockchip_drm_dma_detach_device+0x1c/0x34
>   [ 1069.832033][    T1]  vop_crtc_atomic_disable+0xb0c/0xc44
>   [ 1069.832751][    T1]  drm_atomic_helper_commit_modeset_disables+0x348=
/0x690
>   ...
>   [ 1069.836601][    T1]  drm_atomic_helper_shutdown+0xa0/0x158
>   [ 1069.837152][    T1]  rockchip_drm_platform_shutdown+0x18/0x2c
>   [ 1069.837870][    T1]  platform_shutdown+0x3c/0x54
>   [ 1069.838599][    T1]  device_shutdown+0x194/0x260
>   [ 1069.839160][    T1]  kernel_restart+0x40/0x128
>
>   CPU 0, page fault handler:
>   [ 1069.790364][    C0] rk_iommu ff460f00.iommu: Page fault at 0x0000000=
0ffee0000 of type read
>   [ 1069.792129][    C0] rk_iommu ff460f00.iommu: Page fault while iommu =
not attached to domain?
>   [ 1069.792184][    C0] rk_iommu ff460f00.iommu: Page fault at 0x0000000=
0ffee0280 of type read
>   [ 1069.794604][    C0] Unable to handle kernel paging request at virtua=
l address ffffff8000000ffc
>   [ 1069.805998][    C0] Internal error: Oops: 0000000096000006 [#1] PREE=
MPT SMP
>   [ 1069.809484][    C0] pc : rk_pagefault_done+0x1b4/0x3c8
>   [ 1069.810548][    C0] lr : rk_pagefault_done+0x19c/0x3c8
>   [ 1069.832390][    C0] Call trace:
>   [ 1069.833116][    C0]  rk_pagefault_done+0x1b4/0x3c8
>   [ 1069.833844][    C0]  rk_iommu_irq+0x64/0xc8
>   [ 1069.834395][    C0]  __handle_irq_event_percpu+0xe8/0x2ac
>   [ 1069.834945][    C0]  handle_irq_event+0x40/0xbc
>   [ 1069.835675][    C0]  handle_fasteoi_irq+0x118/0x28c
>   [ 1069.836404][    C0]  generic_handle_domain_irq+0x44/0x6c
>   [ 1069.836954][    C0]  gic_handle_irq+0x60/0xf0
>   [ 1069.837505][    C0]  call_on_irq_stack+0x3c/0x5c
>   [ 1069.838235][    C0]  do_interrupt_handler+0x4c/0x94
>   [ 1069.838963][    C0]  el1_interrupt+0x44/0xa8
>   [ 1069.839446][    C0]  el1h_64_irq_handler+0x18/0x2c
>   [ 1069.839997][    C0]  el1h_64_irq+0x78/0x7c
>   [ 1071.215224][    C0] Kernel panic - not syncing: Oops: Fatal exceptio=
n in interrupt
>
> Fixes: c68a292152d3 ("iommu/rockchip: rk3288 iommu driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 1fa3110b142a..0f40d9678344 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -115,6 +115,7 @@ struct rk_iommu {
>         struct iommu_device iommu;
>         struct list_head node; /* entry in rk_iommu_domain.iommus */
>         struct iommu_domain *domain; /* domain to which iommu is attached=
 */
> +       spinlock_t lock;
>         const struct rk_iommu_ops *rk_ops;
>  };
>
> @@ -543,7 +544,8 @@ static int rk_iommu_force_reset(struct rk_iommu *iomm=
u)
>         return 0;
>  }
>
> -static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
> +static void log_iova(struct rk_iommu *iommu, struct iommu_domain *domain=
,
> +                    int index, dma_addr_t iova)
>  {
>         void __iomem *base =3D iommu->bases[index];
>         u32 dte_index, pte_index, page_offset;
> @@ -563,6 +565,12 @@ static void log_iova(struct rk_iommu *iommu, int ind=
ex, dma_addr_t iova)
>
>         mmu_dte_addr =3D rk_iommu_read(base, RK_MMU_DTE_ADDR);
>         mmu_dte_addr_phys =3D iommu->rk_ops->pt_address(mmu_dte_addr);
> +       if (domain =3D=3D &rk_identity_domain ||
> +           mmu_dte_addr_phys !=3D to_rk_domain(domain)->dt_dma) {
> +               dev_err(iommu->dev, "iova =3D %pad: page directory %#x is=
 not the attached domain's, not walked\n",
> +                       &iova, mmu_dte_addr);
> +               return;
> +       }
>
>         dte_addr_phys =3D mmu_dte_addr_phys + (4 * dte_index);
>         dte_addr =3D phys_to_virt(dte_addr_phys);
> @@ -593,6 +601,7 @@ static void log_iova(struct rk_iommu *iommu, int inde=
x, dma_addr_t iova)
>  static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>  {
>         struct rk_iommu *iommu =3D dev_id;
> +       struct iommu_domain *domain;
>         u32 status;
>         u32 int_status;
>         dma_addr_t iova;
> @@ -606,6 +615,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id=
)
>         if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
>                 goto out;
>
> +       spin_lock(&iommu->lock);
> +       domain =3D READ_ONCE(iommu->domain);
>         for (i =3D 0; i < iommu->num_mmu; i++) {
>                 int_status =3D rk_iommu_read(iommu->bases[i], RK_MMU_INT_=
STATUS);
>                 if (int_status =3D=3D 0)
> @@ -625,15 +636,15 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_=
id)
>                                 &iova,
>                                 str_write_read(flags =3D=3D IOMMU_FAULT_W=
RITE));
>
> -                       log_iova(iommu, i, iova);
> +                       log_iova(iommu, domain, i, iova);
>
>                         /*
>                          * Report page fault to any installed handlers.
>                          * Ignore the return code, though, since we alway=
s zap cache
>                          * and clear the page fault anyway.
>                          */
> -                       if (iommu->domain !=3D &rk_identity_domain)
> -                               report_iommu_fault(iommu->domain, iommu->=
dev, iova,
> +                       if (domain !=3D &rk_identity_domain)
> +                               report_iommu_fault(domain, iommu->dev, io=
va,
>                                                    flags);
>                         else
>                                 dev_err(iommu->dev, "Page fault while iom=
mu not attached to domain?\n");
> @@ -651,6 +662,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id=
)
>
>                 rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_sta=
tus);
>         }
> +       spin_unlock(&iommu->lock);
>
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>
> @@ -921,16 +933,19 @@ static struct rk_iommu *rk_iommu_from_dev(struct de=
vice *dev)
>  /* Must be called with iommu powered on and attached */
>  static void rk_iommu_disable(struct rk_iommu *iommu)
>  {
> +       unsigned long flags;
>         int i;
>
>         /* Ignore error while disabling, just keep going */
>         WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>         rk_iommu_enable_stall(iommu);
>         rk_iommu_disable_paging(iommu);
> +       spin_lock_irqsave(&iommu->lock, flags);
>         for (i =3D 0; i < iommu->num_mmu; i++) {
>                 rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
>                 rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
>         }
> +       spin_unlock_irqrestore(&iommu->lock, flags);
>         rk_iommu_disable_stall(iommu);
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>  }
> @@ -997,7 +1012,7 @@ static int rk_iommu_identity_attach(struct iommu_dom=
ain *identity_domain,
>         if (iommu->domain =3D=3D identity_domain)
>                 return 0;
>
> -       iommu->domain =3D identity_domain;
> +       WRITE_ONCE(iommu->domain, identity_domain);
>
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_del_init(&iommu->node);
> @@ -1051,7 +1066,7 @@ static int rk_iommu_attach_device(struct iommu_doma=
in *domain,
>         if (ret)
>                 return ret;
>
> -       iommu->domain =3D domain;
> +       WRITE_ONCE(iommu->domain, domain);
>
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_add_tail(&iommu->node, &rk_domain->iommus);
> @@ -1227,6 +1242,7 @@ static int rk_iommu_probe(struct platform_device *p=
dev)
>                 return -ENOMEM;
>
>         iommu->domain =3D &rk_identity_domain;
> +       spin_lock_init(&iommu->lock);
>
>         platform_set_drvdata(pdev, iommu);
>         iommu->dev =3D dev;
> --
> 2.56.1
>
ping?
