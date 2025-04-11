Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F2EC2
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744344025; cv=none; b=CcaW9ecqbv5+OkhaoZFgI/ZV7v+NBeq3YN3pddPhvTl3X36QJAsZ/hDDwpsVlkm3nRPj4Xgk+XHFdrVkBQzgAgQymEmEgoh4FTIwW32BVlakem9BNygkJiJJmEFkYrCkR0MM/QttsQvYVsB/PRkYh7t5vINtalmZ1reIAypXkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744344025; c=relaxed/simple;
	bh=YJr0nh+jBekMaPbo5SJVsRNDbkI42Qrxq/47wkqxgUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HudACUgu6PgvbrwvyDV/VhlGjg1ApbSEw7ZNJUKiDqxrul2I/hRvfAITwrxKDoBXWpGFPmV3/wKf9L/C8jKdyvGpAVNqGSfWDw2Vds+WCdwz5sDXFA7izOjcVykEMMxAwF1stVZijXKT/Sq2BdBaUxyU3NRb8rVgEexKRW/p7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aqjmqdCL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aqjmqdCL"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499c5d9691so1634736e87.2
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744344022; x=1744948822; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHWIMdKlgPNKb3PMSIlYPlaNoe+BJ8UQ31+Dau9Z84E=;
        b=aqjmqdCLjLFurobWHdd7ZES+VfCvOZPqsaK1SKuWWTxkgnDy39GcxFtYCZf6LjxukY
         nC05W7uo12iyIdtQ7y3wCfyCYCB8RSyLUAlAlvHLLtrshAWbsNRbUqYJCvryBhBK5ORA
         FpwNyNQ1zln/l1/TGEu0kVI6gtmhPUMmLCCYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744344022; x=1744948822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHWIMdKlgPNKb3PMSIlYPlaNoe+BJ8UQ31+Dau9Z84E=;
        b=aHgN32KoqvugT+vMoMdfvN0YT1ZMd3kPeIACnLZIJjMN/j6N+4wUdsnyAQ0lytvEFd
         rBdRrja+E6DtKD+0x5nVtu72KJJe5fENc/ZNLV+Y6zNGe/erYfyv6JjrZn00iY4wJym0
         OAapBcyP71ZmzYtE2rF57Ytvzv+91Wgccz9MtxietbBZOu9QFm0igv+mQm/DBLMT8HQU
         gQD1cwjEg4JYM66ctKIet3rEIPYTZozvFzuPkmPaXs0LJj2hw91O4XQqYiifUjnwTTQC
         hRX7VnJDbPTRKStPPIJWisaGZVLyjrjT9j7ifbzaDk3dwjpO0iCmhg5fDKCY5YE7mx8P
         7E1w==
X-Forwarded-Encrypted: i=1; AJvYcCUQlMiJluddQkBt4mjz/ngo5ptInvA/PGfGQYjPel8nQpU16HKHrCRPGY7iKqnbMCnUKwQEqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5hsGXqMV2C3erpVfgZhEXHMaouXdQBbnbbPHhUxxi2TZ12DFd
	upzilPDJm4wl3fnUs6JykQeOwVjtwLM8Hl37RZBTyab1Ei/64KN00APEF/eFQEIWbezK2MJ1sxe
	LfGsDyJB+2HO7YjAOX06D93raKdHP2VDsR8AR
X-Gm-Gg: ASbGncsXN8udtUreE0gTJd35N3jJgXoY1uYW4HrGy3OTxeTyyRMYC8hK6VMyHCwp3ZX
	OHW3ccy2QMWEZ05Jf9wwO8DCTUz/C0ky2f6sV9f/cHIzG0W4QVXUfRTCqQyJLq1mx6LqV3e7ma/
	cX97s8Gst3ofCmrKo3AXb/3NYJtVJH3yQ1hzazPsX7HTVTqKZmPR7GKJS6XmwM
X-Google-Smtp-Source: AGHT+IEvevm0MOcXBzxbs4ti+fwQen4zLU1xR7p8Or4sTrGp8qiGlLwUoFP65QHqvWqY5TMoGkZVjQQOrtVJ82I+O9s=
X-Received: by 2002:a05:6512:118f:b0:545:c7d:1784 with SMTP id
 2adb3069b0e04-54d452cf59cmr331463e87.43.1744344021842; Thu, 10 Apr 2025
 21:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250410101001.429694-1-wenst@chromium.org> <a0a9861e-699e-4bb9-9e30-09d70cb83644@linux.intel.com>
In-Reply-To: <a0a9861e-699e-4bb9-9e30-09d70cb83644@linux.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 11 Apr 2025 12:00:10 +0800
X-Gm-Features: ATxdqUFbJ4GtHKX8HOamg3WV8RNYANFUqCJ3P9hiSTY2H7Zv1LMcHkQ-xrYbL58
Message-ID: <CAGXv+5F1zj_sSkMSZuu8eV+nVT5wu-GChCNxr8cOE=rRQierhQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Clear IOMMU DMA ops when detaching a device from
 its IOMMU group
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 9:34=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 4/10/25 18:09, Chen-Yu Tsai wrote:
> > In recent changes to the IOMMU subsystem seen in v6.15-rc1, the process
> > and order of how IOMMU linked devices are brought up has changed. Now
> > when the IOMMU is probed, the IOMMU subsystem core will attempt to link
> > or attach devices described in the device tree as using the IOMMU to
> > the IOMMU's associated group or domain. If any part of this fails, the
> > whole process is (mostly) undone. The IOMMU failure is then treated as
> > a deferred probe; after sufficient time, the deferred probe times out
> > and the attached devices are brought out without the IOMMU.
> >
> > In the process of undoing changes, one part was missed. When a device
> > is initialized for use with the IOMMU, iommu_setup_dma_ops() is also
> > called, which signals that DMA operations should go through the IOMMU.
> > This part was not reverted when the IOMMU changes were undone. When
> > the device later probes without the IOMMU, DMA operations would attempt
> > to use IOMMU operations with no IOMMU domain present, causing a crash.
> >
> > The above was observed on an MT8188 Chromebook. The MT8188 device tree
> > had incorrectly described the IOMMU endpoint for part of its display
> > pipeline; the IOMMU driver would successfully attach a couple hardware
> > blocks, fail at the incorrectly described one, and roll back all
> > changes. Later when the deferred probe times out, the display pipleine
> > probes without the IOMMU, but when a framebuffer is allocated, it goes
> > through the IOMMU DMA ops, causing a NULL pointer dereference crash.
> >
> > Add a helper that is the opposite of iommu_setup_dma_ops(), and call it
> > when the IOMMU-enabled device is being detached from its IOMMU.
> >
> > Closes:https://lore.kernel.org/all/CAGXv+5HJpTYmQ2h-
> > GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com/
> > Signed-off-by: Chen-Yu Tsai<wenst@chromium.org>
> > ---
> > This patch should be applied for v6.15. It's not immediately clear to
> > me which commit is the actual cause, so I did not add a Fixes tag.
>
> I guess it might be:
>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe
> path")
>
> Or, something near that. Please verify before apply.

I can't really tell.

> > ---
> >   drivers/iommu/dma-iommu.c | 5 +++++
> >   drivers/iommu/dma-iommu.h | 5 +++++
> >   drivers/iommu/iommu.c     | 2 ++
> >   3 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index cb7e29dcac15..62a51d84ffe1 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1739,6 +1739,11 @@ void iommu_setup_dma_ops(struct device *dev)
> >       dev->dma_iommu =3D false;
> >   }
> >
> > +void iommu_clear_dma_ops(struct device *dev)
> > +{
> > +     dev->dma_iommu =3D false;
> > +}
> > +
> >   static bool has_msi_cookie(const struct iommu_domain *domain)
> >   {
> >       return domain && (domain->cookie_type =3D=3D IOMMU_COOKIE_DMA_IOV=
A ||
> > diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> > index eca201c1f963..dfd31cb9e685 100644
> > --- a/drivers/iommu/dma-iommu.h
> > +++ b/drivers/iommu/dma-iommu.h
> > @@ -10,6 +10,7 @@
> >   #ifdef CONFIG_IOMMU_DMA
> >
> >   void iommu_setup_dma_ops(struct device *dev);
> > +void iommu_clear_dma_ops(struct device *dev);
> >
> >   int iommu_get_dma_cookie(struct iommu_domain *domain);
> >   void iommu_put_dma_cookie(struct iommu_domain *domain);
> > @@ -30,6 +31,10 @@ static inline void iommu_setup_dma_ops(struct device=
 *dev)
> >   {
> >   }
> >
> > +static inline void iommu_clear_dma_ops(struct device *dev)
> > +{
> > +}
> > +
> >   static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> >   {
> >       return -EINVAL;
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index c8033ca66377..498f8f48394c 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -677,6 +677,8 @@ static void __iommu_group_remove_device(struct devi=
ce *dev)
> >       struct iommu_group *group =3D dev->iommu_group;
> >       struct group_device *device;
> >
> > +     iommu_clear_dma_ops(dev);
> > +
> >       mutex_lock(&group->mutex);
> >       for_each_group_device(group, device) {
> >               if (device->dev !=3D dev)
>
> I don't think there needs to be an inline helper for this one-time call.
> Perhaps you can simply do it like this:
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c8033ca66377..cd9d7a0fcaa0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -536,6 +536,7 @@ static void iommu_deinit_device(struct device *dev)
>
>          /* Caller must put iommu_group */
>          dev->iommu_group =3D NULL;
> +       dev->dma_iommu =3D false;

I wanted to keep the reverting part in the cleanup path corresponding
to where it was set up, with corresponding helpers, so that they are
symmetric. That said I'm not that familiar with the IOMMU code, but it
makes more sense to me than sticking a random line somewhere.


ChenYu

>          module_put(ops->owner);
>          dev_iommu_free(dev);
>   }
>
> ?
>
> Thanks,
> baolu
