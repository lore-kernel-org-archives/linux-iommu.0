Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7B1422A7
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271258; cv=none; b=ZwMRE3I77E8fk6wa3CaEBWG61G7vbiPYVbra12NQ5yukxLu310uvMdCSmI0YDNfU+2XV/WAUOEP4SySR7bb7LMTe/0mBfiXzwbCihKkFfVzKSzxFOwC1H1QZilIQXJamd0fS+ZRR8S1f/6r86SO1ep+p634ByyEFqY778zcvxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271258; c=relaxed/simple;
	bh=l/UOzlJrGDkSHTuKTHjaT+Pq7UK62xzyFQW3JHnm5Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hao2pgOiFD+XjX33ysfhigwDY/uwo8IyigRFkWdRKjhwb4K4Zp6T9S2koC81qRk2S4Nf2obDgrV99w2ymFMabkdTvk77dKqM5Sm+hTcR2hQn7xRtUUUou0jTasggM07sZgyzAENUqGLA+iTeb4FbvhFA0SrM9GdF8otw+PDZoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=EAtPPuCG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="EAtPPuCG"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627efad69b4so7924167b3.3
        for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1718271255; x=1718876055; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCGcmMkVAYD3NfdijGLTxRKIxsWVC1ouY5NCrb4R7to=;
        b=EAtPPuCG8DDTfgOR1oDe1rSZsmQkILMJ/8T1Ps2CsXVqRqKUKo+jnS+T8ARB1s+Agt
         ycwFiHLbXbX/CLJ/Bs2ozUzSpMl/jp9e89995lNvY36Wfd4f9al2LKY9DMKMSSVF/FMS
         QlkN+JV5HA7N4bXt04TQKVjTFj6PFQK2GvIky6aSA2qti6cUB0h3TcarpwBqhnMBMdjW
         5bWXvIOLGgyW7muzSHDUU5NCHx6ngEr69lCNO3Nu4mnGiwQXv+fo0SSVc1kwhwPiYhbq
         glSdscJ1rtE9zbTnvMstDtOlB557/IIIUs0xfKrmIfzlDAgNlZd5j4oTm/7kdZHndkF6
         VaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271255; x=1718876055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCGcmMkVAYD3NfdijGLTxRKIxsWVC1ouY5NCrb4R7to=;
        b=GtZ+TqnQRdXD2N+4dqjsYmDivvfTnYOe1aLr43A0c5dRah4IQCLbd26iZFcuxjO0Ey
         4tK8PbKvP6uMx3OI3FiWzIGjsZajw57VcjBhCREYPwAs7jxKSYyyEXpYBsN6j3Fm0hzV
         ep6hG8Qg8jzxijsBk1AksYTbB35Dh0vq6vrzSfDrsi1aUIsxAWq9f18rJfTNxhjI3qIo
         a+wrtCzUWgWkCqAzX8gSo8f4kJuQwEAF16Y3TLy/DGmsCsbE+UptjY8a/Zw89Fa+HImo
         3eN1y2KWbPMY54qxd+Z1ctCcEpDQl5O0Sb2B/Ryhq8Nag1Hm8hg/ikVKMxpbx7cQP5nT
         koqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfp6TNxtjlq1ktuNBnBgrWuGDTmYEf5iDO9WTdo64UvNN4lB9zV95PN6M+jh8W+QLKzwKaFYboYz0zlkBE94MZjBm+8ps=
X-Gm-Message-State: AOJu0Yz8+opMCgm8ud7PTN6vX0Mtw0rW3M4Fd132T0B11uTgfGE6HM4K
	2cIni5UnwnTT5z1+OcmB17pXtQb3Hhi2inIfqKXhEvFbVNlf0KsuszEY7CKc5WhC9RuybV0/nMg
	r0co=
X-Google-Smtp-Source: AGHT+IF2MAxke0ExHvOil3ZBCnijn612cVjgpmrEx9vCf/i54LEffSnY8qA9tH1d3fWDPd3s7Srkmw==
X-Received: by 2002:a0d:d8cf:0:b0:61b:1c75:2077 with SMTP id 00721157ae682-62fb7f9a047mr41595087b3.7.1718271254599;
        Thu, 13 Jun 2024 02:34:14 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631183d7842sm1210927b3.24.2024.06.13.02.34.13
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:34:13 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfecd065b0aso752754276.1
        for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 02:34:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlDNaXsMNA1l7pqJZFZLPDi0akpnNniwKvSESsdJ/G+bnc5Bq2PYfY7Rc+PzrtCdC4C5tNCsBAssbYOgXDiNSGVBcCGe0=
X-Received: by 2002:a5b:5d2:0:b0:dfa:cd4a:b3aa with SMTP id
 3f1490d57ef6-dfe691067efmr4261141276.56.1718271253175; Thu, 13 Jun 2024
 02:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
 <20240612-6-10-rocket-v1-2-060e48eea250@tomeuvizoso.net> <ffviz6ak6qsn2reg5y35aerzy7wxfx6fzix6xjyminbhfcguus@clszdjakdcjd>
 <CAAObsKCx+r5UuESnrPem1Rb1-BF4i8FVwu6uozWhABOWoq+M4Q@mail.gmail.com>
In-Reply-To: <CAAObsKCx+r5UuESnrPem1Rb1-BF4i8FVwu6uozWhABOWoq+M4Q@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 13 Jun 2024 11:34:02 +0200
X-Gmail-Original-Message-ID: <CAAObsKChaBZ2C5ezWsiZ_LoN6R2HFhFA9=UNSRYB6cyeo-jreg@mail.gmail.com>
Message-ID: <CAAObsKChaBZ2C5ezWsiZ_LoN6R2HFhFA9=UNSRYB6cyeo-jreg@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/rockchip: Attach multiple power domains
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:24=E2=80=AFAM Tomeu Vizoso <tomeu@tomeuvizoso.ne=
t> wrote:
>
> On Thu, Jun 13, 2024 at 2:05=E2=80=AFAM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > On Wed, Jun 12, 2024 at 03:52:55PM GMT, Tomeu Vizoso wrote:
> > > IOMMUs with multiple base addresses can also have multiple power
> > > domains.
> > >
> > > The base framework only takes care of a single power domain, as some
> > > devices will need for these power domains to be powered on in a speci=
fic
> > > order.
> > >
> > > Use a helper function to stablish links in the order in which they ar=
e
> > > in the DT.
> > >
> > > This is needed by the IOMMU used by the NPU in the RK3588.
> > >
> > > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > ---
> >
> > To me it looks like this is multiple IOMMUs, which should each get
> > their own node. I don't see a good reason for merging these
> > together.
>
> I have made quite a few attempts at splitting the IOMMUs and also the
> cores, but I wasn't able to get things working stably. The TRM is
> really scant about how the 4 IOMMU instances relate to each other, and
> what the fourth one is for.
>
> Given that the vendor driver treats them as a single IOMMU with four
> instances and we don't have any information on them, I resigned myself
> to just have them as a single device.
>
> I would love to be proved wrong though and find a way fo getting
> things stably as different devices so they can be powered on and off
> as needed. We could save quite some code as well.

FWIW, here a few ways how I tried to structure the DT nodes, none of
these worked reliably:

https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple-devi=
ces-power/arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1163
https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-schema-subnod=
es//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1162
https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple-devi=
ces//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L1163
https://gitlab.freedesktop.org/tomeu/linux/-/blob/6.10-rocket-multiple-iomm=
us//arch/arm64/boot/dts/rockchip/rk3588s.dtsi?ref_type=3Dheads#L2669

I can very well imagine I missed some way of getting this to work, but
for every attempt, the domains, iommus and cores were resumed in
different orders that presumably caused problems during concurrent
execution fo workloads.

So I fell back to what the vendor driver does, which works reliably
(but all cores have to be powered on at the same time).

Thanks,

Tomeu

> > I will still review this assuming there is one. That would require
> > to first of all update the DT binding:
> >
> > Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> >
> > 1. It does not allow using "power-domain-names" property
> > 2. It limits the number of allowed power-domains to 1
> > 3. It limits the number of allowed base addresses to 2
> >
> > Looking at the DT patch you also add more interrupts and clocks,
> > which are also limited by the binding. You should see a bunch of
> > warnings when you check the DTBS via 'make dtbs_check'
>
> Oops, yeah, I was limiting dtbs_check with DT_SCHEMA_FILES, now I see
> the errors.
>
> > >  drivers/iommu/rockchip-iommu.c | 36 ++++++++++++++++++++++++++++++++=
++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-=
iommu.c
> > > index f5629515bd78..673b0ebb6262 100644
> > > --- a/drivers/iommu/rockchip-iommu.c
> > > +++ b/drivers/iommu/rockchip-iommu.c
> > > @@ -6,6 +6,8 @@
> > >   *                   Daniel Kurtz <djkurtz@chromium.org>
> > >   */
> > >
> > > +#include "linux/err.h"
> > > +#include "linux/pm_domain.h"
> > >  #include <linux/clk.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/delay.h>
> > > @@ -115,6 +117,7 @@ struct rk_iommu {
> > >       struct iommu_device iommu;
> > >       struct list_head node; /* entry in rk_iommu_domain.iommus */
> > >       struct iommu_domain *domain; /* domain to which iommu is attach=
ed */
> > > +     struct dev_pm_domain_list *pmdomains;
> > >  };
> > >
> > >  struct rk_iommudata {
> > > @@ -1186,6 +1189,7 @@ static int rk_iommu_probe(struct platform_devic=
e *pdev)
> > >       struct resource *res;
> > >       const struct rk_iommu_ops *ops;
> > >       int num_res =3D pdev->num_resources;
> > > +     int pm_domain_count;
> > >       int err, i;
> > >
> > >       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> > > @@ -1271,6 +1275,35 @@ static int rk_iommu_probe(struct platform_devi=
ce *pdev)
> > >       if (!dma_dev)
> > >               dma_dev =3D &pdev->dev;
> > >
> > > +     pm_domain_count =3D of_property_count_strings(iommu->dev->of_no=
de, "power-domain-names");
> >
> > pm_domain_count =3D device_property_string_array_count(iommu->dev, "pow=
er-domain-names");
> >
> > When possible using device_property_ is prefered, since it allows
> > reusing code for systems not using DT.
> >
> > > +     if (pm_domain_count > 0) {
> > > +             const char **pm_domains =3D kvmalloc_array(pm_domain_co=
unt, sizeof(*pm_domains), GFP_KERNEL);
> > > +             struct dev_pm_domain_attach_data pm_domain_data =3D {
> > > +                     .pd_names =3D pm_domains,
> > > +                     .num_pd_names =3D pm_domain_count,
> > > +                     .pd_flags =3D PD_FLAG_DEV_LINK_ON,
> > > +             };
> > > +             int i;
> > > +
> > > +             if (!pm_domain_data.pd_names) {
> > > +                     err =3D -ENOMEM;
> > > +                     goto err_remove_sysfs;
> > > +             }
> > > +
> > > +             for (i =3D 0; i < pm_domain_count; i++) {
> > > +                     err =3D of_property_read_string_index(iommu->de=
v->of_node, "power-domain-names", i, &pm_domains[i]);
> > > +                     if (err) {
> > > +                             kfree(pm_domains);
> > > +                             goto err_remove_sysfs;
> > > +                     }
> > > +             }
> >
> > There is a helper to read a string array:
> >
> > err =3D device_property_read_string_array(iommu->dev, "power-domain-nam=
es", pm_domains, pm_domain_count);
>
>
> Thanks for the review,
>
> Tomeu
>
> > -- Sebastian
> >
> > > +
> > > +             err =3D dev_pm_domain_attach_list(iommu->dev, &pm_domai=
n_data, &iommu->pmdomains);
> > > +             kfree(pm_domains);
> > > +             if (err < 0)
> > > +                     goto err_remove_sysfs;
> > > +     }
> > > +
> > >       pm_runtime_enable(dev);
> > >
> > >       for (i =3D 0; i < iommu->num_irq; i++) {
> > > @@ -1292,6 +1325,7 @@ static int rk_iommu_probe(struct platform_devic=
e *pdev)
> > >       return 0;
> > >  err_pm_disable:
> > >       pm_runtime_disable(dev);
> > > +     dev_pm_domain_detach_list(iommu->pmdomains);
> > >  err_remove_sysfs:
> > >       iommu_device_sysfs_remove(&iommu->iommu);
> > >  err_unprepare_clocks:
> > > @@ -1310,6 +1344,8 @@ static void rk_iommu_shutdown(struct platform_d=
evice *pdev)
> > >               devm_free_irq(iommu->dev, irq, iommu);
> > >       }
> > >
> > > +     dev_pm_domain_detach_list(iommu->pmdomains);
> > > +
> > >       pm_runtime_force_suspend(&pdev->dev);
> > >  }
> > >
> > >
> > > --
> > > 2.45.2
> > >
> > >
