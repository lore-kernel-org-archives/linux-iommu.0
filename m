Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91245170826
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785695; cv=none; b=qXaKZ/mtSmsJhGz68W9ZNMuVIwwjEbnMta5bVF+NpWeCuM2tQRZb3+vbeXGVgJeqTCzgaw5Nog+Omh+jMhme0eqkgzg1BxM1IApUV3xyGum1DvvPWvHDeXT1KOcNbhGDL3LkUe6yptXk7B74p0EsVrgteViZ9KWv4QkB/3jvaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785695; c=relaxed/simple;
	bh=vKol5aA9zVXJsQDnzmskykPLu50Z0i/zHvnhTkkSTaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDzzhn0lmS5i465S4JgR/uizQdQLTVWWulEMSsD5GZpXT5EW/Me8/jV58n2YW03mZkDPWx79D5+FD8blFpDd1+HtZdOjqFQXTZltDB44+YVsWSc1yVHnrjyFEryRo7MTpi3b2HzHAiZT1OLKcnNDNvtLu2DRcCSsDoSzth2He2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Jo2UymLs; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Jo2UymLs"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ec3b5f05e8so22252385ab.0
        for <iommu@lists.linux.dev>; Mon, 01 Sep 2025 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1756785692; x=1757390492; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0vF3AA+Rkq7nWTBrL0TBSZgMNIOZptEtxBEHlmZxNk=;
        b=Jo2UymLszviz61lza/Lfn85J/ZSZvuTDQzCpHsgSUc/LfkQM5qHihLAh1MlzoCKCXh
         NySkuV5meNUYSqx1n5nFStzGeYJSUmMRfcdgJgyHKRC1G0NGcT41RNUlzQU0f7JhMTOn
         PE6/ag5pnhA3Hd7+btDD3cTAilW0MKla7Y7XqdYsyb0Yy1C2LLga1ywq0/U9ZUCSCYIC
         CxgM9L6SO+p/Xi7NxxSK7t7dmm9pJfmo/Ev1ZQ1Nvyr0OF/Adj1dBcK/OsOdp/vFC09N
         HWRP4b/Ge0WcVlZydkY77xc+L4qqZBwfs2kVDiqYeDrx8OBUF3/EjibJPicoMcbVY+Qy
         dqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785692; x=1757390492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0vF3AA+Rkq7nWTBrL0TBSZgMNIOZptEtxBEHlmZxNk=;
        b=knM4/dOfV8IQpHHRf6AmE5lkz9zwxdLBrT6BOpUMkGH+NMQ7jAC36EJHjmS+PWUX+H
         am3alHAZsnZf7AwZzSj17K0fq4kNrzJopHkqlv//pLWiiRodKFA0YwGLJOelNC5IODWi
         sml9hYkK+ureGHdOFCrkfsbtm3ZqIBkH0tT8gc/LGCs4ea7TYD/8BBv22OzA4YLLttIf
         SVyWrfKPfhIOB94y1TvE2zN5w3lpbiSaSuN1U6KhVJf5DAxwT6sYhxRXL/PMu1BsiVYJ
         9dSHxTfdkpSHsfT38eSybKrrtfZURDlK/f+1ystF9+dk8LKGb0wg9fr8U/CBrP5cVBBE
         qqTw==
X-Forwarded-Encrypted: i=1; AJvYcCXFU4Ov5dmwkO5Yk8VEADUKOSCqYvNjWIFy491kFbotEiDVe1dR7eknLP2BzqliRT5i5yf6QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJv6IS1Y+a2ItHwkszL8hvpY+0OP+YTA5dFWLCVAJ32QBjXFBm
	BNFPNm7NGbfX4izCZ9lvNJKRXXTiFiv5c0Sp7qt99nIuanw6fKtHP5/Eig8VwITYd7/7Lb88Uwp
	OyuLJimVGDnHJzKoJMwbZKscm+OFOyP9Wagp6SpTUhA==
X-Gm-Gg: ASbGnctr9X2ahw7ugHIl2YwLzM+FgQb4MQQU8QPj/gUZ4V4aat0Ukjqj0r2xmA9RNba
	dwTcaIZPdPtj6UmFBGO/gfXSO7l3Kthzyg8ASD2J85MLmKE/7qlXlIC/ch8l1cimYgLOTt3zFw4
	yF2NkICB3TJCFq0gTCSpx46W0+U8l13vH6+PBFUw8n2fvVZhWwH1o1uo9i2zZ6PeNb0SZMVtZsK
	xBGLCpz+g==
X-Google-Smtp-Source: AGHT+IHyzW+/5sZk3REX6p5gITjtt3mTNs/VjN2Tek/XlWrX+PGuWni51wU7hsEbW1hVZXbmTe8C4BoqMzr7Lu08/nA=
X-Received: by 2002:a05:6e02:4901:b0:3f4:3c3b:5af8 with SMTP id
 e9e14a558f8ab-3f43c3b5b5fmr171695585ab.27.1756785692539; Mon, 01 Sep 2025
 21:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-3-zong.li@sifive.com> <20250901133629.87310-1-ni_liqiang@126.com>
In-Reply-To: <20250901133629.87310-1-ni_liqiang@126.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 2 Sep 2025 12:01:19 +0800
X-Gm-Features: Ac12FXwpi8gyi1mSx73Jw2TbBz0hbsvAceRzz4mouXq2z_brh7Py0L56YowF_GU
Message-ID: <CANXhq0ra+yv-Wt_vKTN3+c4StsPQB1vR+=Kp3RVSh0g10Oogqw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
To: niliqiang <ni_liqiang@126.com>
Cc: aou@eecs.berkeley.edu, iommu@lists.linux.dev, jgg@ziepe.ca, 
	joro@8bytes.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	chenruisust@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:37=E2=80=AFPM niliqiang <ni_liqiang@126.com> wrote=
:
>
> Hi Zong
>
> Fri, 14 Jun 2024 22:21:48 +0800, Zong Li <zong.li@sifive.com> wrote:
>
> > This patch initialize the pmu stuff and uninitialize it when driver
> > removing. The interrupt handling is also provided, this handler need to
> > be primary handler instead of thread function, because pt_regs is empty
> > when threading the IRQ, but pt_regs is necessary by perf_event_overflow=
.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8b6a64c1ad8d..1716b2251f38 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int ir=
q, void *data)
> >   return IRQ_HANDLED;
> >  }
> >
> > +/*
> > + * IOMMU Hardware performance monitor
> > + */
> > +
> > +/* HPM interrupt primary handler */
> > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> > +{
> > + struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *)dev=
_id;
> > +
> > + /* Process pmu irq */
> > + riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > +
> > + /* Clear performance monitoring interrupt pending */
> > + riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP=
);
> > +
> > + return IRQ_HANDLED;
> > +}
> > +
> > +/* HPM initialization */
> > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > +{
> > + int rc;
> > +
> > + if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +     return 0;
> > +
> > + /*
> > +  * pt_regs is empty when threading the IRQ, but pt_regs is necessary
> > +  * by perf_event_overflow. Use primary handler instead of thread
> > +  * function for PM IRQ.
> > +  *
> > +  * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> > +  * other threaded IRQs by other queues.
> > +  */
> > + rc =3D devm_request_irq(iommu->dev,
> > +               iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IP=
SR_PMIP)],
> > +               riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED=
, NULL, iommu);
> > + if (rc)
> > +     return rc;
> > +
> > + return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->=
dev));
> > +}
> > +
>
> What are the benefits of initializing the iommu-pmu driver in the iommu d=
river?
>
> It might be better for the RISC-V IOMMU PMU driver to be loaded as a sepa=
rate module, as this would allow greater flexibility since different vendor=
s may need to add custom events.
>
> Also, I'm not quite clear on how custom events should be added if the RIS=
C-V iommu-pmu is placed within the iommu driver.

Hi Liqiang,
My original idea is that, since the IOMMU HPM is not always present,
it depends on the capability.HPM bit, if we separate HPM into an
individual module, I assume that the PMU driver may not have access to
the IOMMU's complete MMIO region. I=E2=80=99m not sure how we would check t=
he
capability register in the PMU driver and avoid the following
situation: capability.HPM is zero, but the IOMMU-PMU driver is still
loaded because the PMU node is present in the DTS. It will be helpful
if you have any suggestions on this.

Regarding custom events, since we don=E2=80=99t have the driver data, my
current rough idea is to add a vendor event map table to list the
vendor events and use Kconfig to define them respectively. This is
just an initial thought and may not be the good solution, so feel free
to share any recommendations. Of course, if we eventually decide to
move it to drivers/perf as an individual module, then we could use the
driver data for custom events, similar to what ARM does.

Thanks

>
>
> Best regards,
> Liqiang
>
