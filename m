Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6C4381C4
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271020; cv=none; b=WQ2edqr7n4BbOwZ494cuDXeG0rC+qVgjY9Kbs2npr+e3QlMOdKDbAIyUowCtfkxmiyRkpwSZwewSl3dZYMaT5btovDzC64KztI3V+vIK67cDYu2eRbLFtSfuuNTPlRVPTKNBf+gUQUhy/VHJ9GP3rj4iIn7tv5OAK0ViFlok2vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271020; c=relaxed/simple;
	bh=r70M0JfsYwTJ3NX7KJwbL08Y8oQ3NMtqgodl6EYlEYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSSZbVgmGhnts+f/9IZUmQmnl2poXvL4Nui3HsFpu/EaI2DoGYgu4ujPrDIsKvP9OhWWjbaW90dHvJIWqWjXvrIFowD6Wh8ERtn1mVYaPxzAGz0HVejT2d8YSi8N9mogS7MA0LsNqgFqAZ4pXcbR2vWmU0B9UYFmh3tVCZL7vDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=hYQVy+Io; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="hYQVy+Io"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d229826727so417317b6e.1
        for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1718271018; x=1718875818; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M3ELKqqsvIZfzOpsu+gAgFZkgR2tBXp2Hwr3Ne0u3I=;
        b=hYQVy+IoOP3CPoAWc9C7sB2nHFskb3q9euYAo5dfpx0c/eUh9Tk0WMfG04MNXSFfpu
         UVjtrXLkr8clrPHVD6gcXYGPJChLbsXtioeYQjnsfNqocp9h0PNRkZ0qbJteIwh+bOAF
         DXO10a5jSzaQbaDXdfNOvu58wVAz6SOh89lj+aQn3hWI/BKwNo6e2NK3ppeptj0AAqxK
         pi2oxaUrWqeIGNEncVkhV+PRKIt9gTP+4DLatepxAlA/B31iH9KwGSkIvasuDffTSEjd
         uULVq/uTolEhG1P9Fue1LnI0Ql4/hFnxCZFIbxKXwP47lgyo7OGuZ+UkmJaxKCm+kVuT
         lngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271018; x=1718875818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5M3ELKqqsvIZfzOpsu+gAgFZkgR2tBXp2Hwr3Ne0u3I=;
        b=hFNyHWsTXO97sDFBketNos5/0JJ/61H3EnLMZEKgKMhpuEynPugx47kGnDI3aOwv9N
         NeknkrnCAg8o2OSM9X/eNnATLDzYoMXRoWM3MOl5hUJ1CAEPd+bA1PqgMjcNn4prmeZD
         O0+MX7jGMuKu9+u+kiUiVLg80S89ZTAoHntgyxdmivB7Gs1eKJpfV+22NZwMKeoKso//
         IHqHqt1t3t+FKfgTYnoqyNwgzZXZF0e7C/mjNMtqJSHJ6vKExXv+FRlBeBUih22sy8MR
         dK/y2SvnU3pEI9wAN/5NEU4hzZJAad6QtnSsoCejGJ7UITxHrlcCMfApzM04/NgD/wJR
         +aSg==
X-Forwarded-Encrypted: i=1; AJvYcCXGy0BD8IltqPf0oA8VSI+Z5uYYf0bX2GpGek/74ei3D/89wCybS575zjoV7xTahGazIFNoNtOvLJRhWmMa0QLDVIgxNBo=
X-Gm-Message-State: AOJu0YzENPJKTQtbvdEdZrN9d7X1Ms+5eH+REhTtfRLH6TAiypFKJ3hT
	f5z7VgLG2wyarQahXIo4c5Lvz4Eju8e89s1xqN015ClvqnLYRrOYQXQ6yTsQJsr257lXqZ1/RDg
	+ICRUgQ==
X-Google-Smtp-Source: AGHT+IEq68q2VR7k1jsNuNyHs1HmN6KBwWnH/SyIUbcCgL0JyR9AStoVjQLM2zIWP8fs13WdGeOgkg==
X-Received: by 2002:a05:620a:1aa7:b0:797:8fce:6d7c with SMTP id af79cd13be357-797f602a906mr504846285a.36.1718270997707;
        Thu, 13 Jun 2024 02:29:57 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe69dffsm36223085a.126.2024.06.13.02.29.57
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:29:57 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44052a479c0so4117971cf.0
        for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 02:29:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdSSzfqWl0HOS1PKyk5k+SMB8f0jQtK8wYzSz5LkrO93B+/gMfqtgpqNh3KKwyrOQSWBA8fJ9Mr4WLju2nyjlO9naZtaU=
X-Received: by 2002:a05:6902:2207:b0:dfe:6002:683 with SMTP id
 3f1490d57ef6-dfe67063c46mr4743823276.32.1718270658168; Thu, 13 Jun 2024
 02:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
 <20240612-6-10-rocket-v1-2-060e48eea250@tomeuvizoso.net> <ffviz6ak6qsn2reg5y35aerzy7wxfx6fzix6xjyminbhfcguus@clszdjakdcjd>
In-Reply-To: <ffviz6ak6qsn2reg5y35aerzy7wxfx6fzix6xjyminbhfcguus@clszdjakdcjd>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 13 Jun 2024 11:24:06 +0200
X-Gmail-Original-Message-ID: <CAAObsKCx+r5UuESnrPem1Rb1-BF4i8FVwu6uozWhABOWoq+M4Q@mail.gmail.com>
Message-ID: <CAAObsKCx+r5UuESnrPem1Rb1-BF4i8FVwu6uozWhABOWoq+M4Q@mail.gmail.com>
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

On Thu, Jun 13, 2024 at 2:05=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Wed, Jun 12, 2024 at 03:52:55PM GMT, Tomeu Vizoso wrote:
> > IOMMUs with multiple base addresses can also have multiple power
> > domains.
> >
> > The base framework only takes care of a single power domain, as some
> > devices will need for these power domains to be powered on in a specifi=
c
> > order.
> >
> > Use a helper function to stablish links in the order in which they are
> > in the DT.
> >
> > This is needed by the IOMMU used by the NPU in the RK3588.
> >
> > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > ---
>
> To me it looks like this is multiple IOMMUs, which should each get
> their own node. I don't see a good reason for merging these
> together.

I have made quite a few attempts at splitting the IOMMUs and also the
cores, but I wasn't able to get things working stably. The TRM is
really scant about how the 4 IOMMU instances relate to each other, and
what the fourth one is for.

Given that the vendor driver treats them as a single IOMMU with four
instances and we don't have any information on them, I resigned myself
to just have them as a single device.

I would love to be proved wrong though and find a way fo getting
things stably as different devices so they can be powered on and off
as needed. We could save quite some code as well.

> I will still review this assuming there is one. That would require
> to first of all update the DT binding:
>
> Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
>
> 1. It does not allow using "power-domain-names" property
> 2. It limits the number of allowed power-domains to 1
> 3. It limits the number of allowed base addresses to 2
>
> Looking at the DT patch you also add more interrupts and clocks,
> which are also limited by the binding. You should see a bunch of
> warnings when you check the DTBS via 'make dtbs_check'

Oops, yeah, I was limiting dtbs_check with DT_SCHEMA_FILES, now I see
the errors.

> >  drivers/iommu/rockchip-iommu.c | 36 ++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index f5629515bd78..673b0ebb6262 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -6,6 +6,8 @@
> >   *                   Daniel Kurtz <djkurtz@chromium.org>
> >   */
> >
> > +#include "linux/err.h"
> > +#include "linux/pm_domain.h"
> >  #include <linux/clk.h>
> >  #include <linux/compiler.h>
> >  #include <linux/delay.h>
> > @@ -115,6 +117,7 @@ struct rk_iommu {
> >       struct iommu_device iommu;
> >       struct list_head node; /* entry in rk_iommu_domain.iommus */
> >       struct iommu_domain *domain; /* domain to which iommu is attached=
 */
> > +     struct dev_pm_domain_list *pmdomains;
> >  };
> >
> >  struct rk_iommudata {
> > @@ -1186,6 +1189,7 @@ static int rk_iommu_probe(struct platform_device =
*pdev)
> >       struct resource *res;
> >       const struct rk_iommu_ops *ops;
> >       int num_res =3D pdev->num_resources;
> > +     int pm_domain_count;
> >       int err, i;
> >
> >       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> > @@ -1271,6 +1275,35 @@ static int rk_iommu_probe(struct platform_device=
 *pdev)
> >       if (!dma_dev)
> >               dma_dev =3D &pdev->dev;
> >
> > +     pm_domain_count =3D of_property_count_strings(iommu->dev->of_node=
, "power-domain-names");
>
> pm_domain_count =3D device_property_string_array_count(iommu->dev, "power=
-domain-names");
>
> When possible using device_property_ is prefered, since it allows
> reusing code for systems not using DT.
>
> > +     if (pm_domain_count > 0) {
> > +             const char **pm_domains =3D kvmalloc_array(pm_domain_coun=
t, sizeof(*pm_domains), GFP_KERNEL);
> > +             struct dev_pm_domain_attach_data pm_domain_data =3D {
> > +                     .pd_names =3D pm_domains,
> > +                     .num_pd_names =3D pm_domain_count,
> > +                     .pd_flags =3D PD_FLAG_DEV_LINK_ON,
> > +             };
> > +             int i;
> > +
> > +             if (!pm_domain_data.pd_names) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_remove_sysfs;
> > +             }
> > +
> > +             for (i =3D 0; i < pm_domain_count; i++) {
> > +                     err =3D of_property_read_string_index(iommu->dev-=
>of_node, "power-domain-names", i, &pm_domains[i]);
> > +                     if (err) {
> > +                             kfree(pm_domains);
> > +                             goto err_remove_sysfs;
> > +                     }
> > +             }
>
> There is a helper to read a string array:
>
> err =3D device_property_read_string_array(iommu->dev, "power-domain-names=
", pm_domains, pm_domain_count);


Thanks for the review,

Tomeu

> -- Sebastian
>
> > +
> > +             err =3D dev_pm_domain_attach_list(iommu->dev, &pm_domain_=
data, &iommu->pmdomains);
> > +             kfree(pm_domains);
> > +             if (err < 0)
> > +                     goto err_remove_sysfs;
> > +     }
> > +
> >       pm_runtime_enable(dev);
> >
> >       for (i =3D 0; i < iommu->num_irq; i++) {
> > @@ -1292,6 +1325,7 @@ static int rk_iommu_probe(struct platform_device =
*pdev)
> >       return 0;
> >  err_pm_disable:
> >       pm_runtime_disable(dev);
> > +     dev_pm_domain_detach_list(iommu->pmdomains);
> >  err_remove_sysfs:
> >       iommu_device_sysfs_remove(&iommu->iommu);
> >  err_unprepare_clocks:
> > @@ -1310,6 +1344,8 @@ static void rk_iommu_shutdown(struct platform_dev=
ice *pdev)
> >               devm_free_irq(iommu->dev, irq, iommu);
> >       }
> >
> > +     dev_pm_domain_detach_list(iommu->pmdomains);
> > +
> >       pm_runtime_force_suspend(&pdev->dev);
> >  }
> >
> >
> > --
> > 2.45.2
> >
> >
