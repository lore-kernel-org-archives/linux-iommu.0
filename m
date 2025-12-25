Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39456165F1A
	for <iommu@lists.linux.dev>; Thu, 25 Dec 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669516; cv=none; b=T3dKl+HFYdKHKEWH3D6P8eYl6iTD9+jEOLEdW+6XDY+rhyYT/APSVvUejnWNcf8LFYq6v7QXCCT2KezpJ2HczGDczP1hBdkTA6wj5pl0UkaSTKEDfCvEALdeRqfsq0WXjONrFFJDENQDyLu8gm2h/upi4rrne1IN/HLprIykD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669516; c=relaxed/simple;
	bh=TH/BSCFcOu+yF5K4qu8fuoAlh91HdHtOJeMnVsxxDVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU4pKA07k8puVssuVFbGP28H+qFtYHn3sZUvHr2Xpyu8FfKUlRzTEDFvTtUZ/mE7VmlJT4vbdOzwH1WPKrmSO3HYQydur/2SppAzXmmnQ/X8FBrBxK4G5mw/8K7w1BS3tfE/0bYCno7KpEesdMT5qiKDW61m75F3FlD09ZmItBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwM5q5Sr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwM5q5Sr"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8887ac841e2so58657026d6.2
        for <iommu@lists.linux.dev>; Thu, 25 Dec 2025 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766669514; x=1767274314; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ma4TUbuDVbjYOdFrkGJYla9jNc+5PWT/yJiIA5v8X/s=;
        b=KwM5q5SrCgfCGCtsFaS4g7dVYYNNByoUq5EPQMiinYz5/x+g50Y8Uw9i47lNHRNZtB
         ULOejtwBQgDzD3JyJZbaWMG+9Gxj6nKWrf973AolDgw5CeCu0La/uPVwBS+27JBCN0WM
         5Nm+dRkhRdqqJ0K5I+ikSwhXiR2yl8O31w4gLdqfeRbtRyX4XOVfzYBq5nu1/Twtp3P3
         vfhHxhsLb8IJ69YlDez1jZHa3k55kSjsrwfcOYPlut1nlsr+VI9WWkq8DaEx2PR/RGXX
         GJCDbkZS4K4TflvVC7fcr6nW4fv9XzC866G3c2vrIhKaXi7cuOvvg0ssS6Gb4LXhaZ3C
         QArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766669514; x=1767274314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ma4TUbuDVbjYOdFrkGJYla9jNc+5PWT/yJiIA5v8X/s=;
        b=coPoVWzBjJHJpATqepHSsC33Ytlv/CvI8pukFZ66nP+n9nEWXXZnnJOF+RIv6yhM7P
         UzZDLrEaOJ5szPuY4lQlGSFlFTICr7VgVchkp2uhmLVKFKgkQlOnNYLOsaTYChrBejSG
         kjbn0dD7yeStBCf3aAYWOi1CMtCzuf4T7xO7yJYKh0DeRRAoXBgNxWQPzdnl4QG6M2vU
         nehISBLby8tzadzW+TMxX86oRnizik1dE8u+8vd0rXJUsxij4XU4XrD85NAMvRbK59hW
         j4KDbTGh92xu+vMHjen6jSExT1V5b7ByXgd/sZPzgljjuVVEte/itiw/REXIjtvcohsP
         3yXA==
X-Forwarded-Encrypted: i=1; AJvYcCXiA0GNuVsomDLniNWAEBXxc16xlqF/lwRzPI49QEteKNjEIxNo7rxZo1YbjQFKH6MNTXMY4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHn+2LJT65RfaBwecgSV2ubCFdWDXP4IonAv1GfbW5UqpMd7t2
	/GaD9h9vE1qu1oAYzogxjpKnawlkprMJcv7vSzsAZ1skh3H+MmxsIsV+NqQmAtRY+PpMx0xnX1e
	p52AeOLyK/1CkisRmFINpGEP29th7aUU=
X-Gm-Gg: AY/fxX4dBUer+KqESIXXhX/lQJ1I6NOARltJVUMZUq5Xmf91vakgGUu8bDQ3WCunRtT
	tNMfK4CnZhInXOoY5O+Yrvh5ZzQZDvDSZxWNI7hlfvpOUVXwi12vpm5iCZ85EydbLWzFcSUoUN9
	G14G8jFsy3Jz0g/Z18tGFpeSQJyeViNEwbsYsyJKvnoSvt+X09SophsnH/It8rQNbjchIRncCTB
	dDK/jRF9SWGbdI05FYqCbL5hv54Lx1l5lHyhCczrT5hb2vpsZhtURxyPxxjckggQ0PX2Q==
X-Google-Smtp-Source: AGHT+IFXqVfQGdKCFtie54AHWuyFuSYXtx9jQJRfVs1svScjN64NEzVwJFTqHKBOW4bSKBKLL8LD99WEEiFY991yy+w=
X-Received: by 2002:a05:6214:3f92:b0:88f:e333:4a9c with SMTP id
 6a1803df08f44-88fe3334c18mr92100216d6.51.1766669513817; Thu, 25 Dec 2025
 05:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251224085145.GF11869@unreal> <20251225054509.39917-1-21cnbao@gmail.com>
 <20251225123650.GJ11869@unreal>
In-Reply-To: <20251225123650.GJ11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Dec 2025 02:31:42 +1300
X-Gm-Features: AQt7F2poVyCilMC4Mh0wp6dzeQVZK_rbefSQzETylBy7BEICZTKnZkktLmE29Wc
Message-ID: <CAGsJ_4zpWWLaynh1U4MKCS-N8tZ0tvE6tAmb0m+Pbf-kPsYQJg@mail.gmail.com>
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if
 supported by the arch
To: Leon Romanovsky <leon@kernel.org>
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org, 
	catalin.marinas@arm.com, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, maz@kernel.org, robin.murphy@arm.com, 
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com, 
	will@kernel.org, zhengtangquan@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 1:36=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Dec 25, 2025 at 06:45:09PM +1300, Barry Song wrote:
> > > > >
> > > >
> > > > OK. Could you take a look at [1] and see if any further
> > > > improvements are needed before I send v2?
> > >
> > > Everything looks ok, except these renames:
> > > -                       arch_sync_dma_for_cpu(paddr, sg->length, dir)=
;
> > > +                       arch_sync_dma_for_cpu_batch_add(paddr, sg->le=
ngth, dir);
> >
> > Thanks!
> > I'm happy to drop the rename as outlined below-feedback welcome :-)
> >
> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/ca=
che.h
> > index dd2c8586a725..487fb7c355ed 100644
> > --- a/arch/arm64/include/asm/cache.h
> > +++ b/arch/arm64/include/asm/cache.h
> > @@ -87,6 +87,12 @@ int cache_line_size(void);
> >
> >  #define dma_get_cache_alignment      cache_line_size
> >
> > +static inline void arch_sync_dma_flush(void)
> > +{
> > +     dsb(sy);
> > +}
> > +#define arch_sync_dma_flush arch_sync_dma_flush
> > +
> >  /* Compress a u64 MPIDR value into 32 bits. */
> >  static inline u64 arch_compact_of_hwid(u64 id)
> >  {
> > diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> > index b2b5792b2caa..ae1ae0280eef 100644
> > --- a/arch/arm64/mm/dma-mapping.c
> > +++ b/arch/arm64/mm/dma-mapping.c
> > @@ -17,7 +17,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size=
_t size,
> >  {
> >       unsigned long start =3D (unsigned long)phys_to_virt(paddr);
> >
> > -     dcache_clean_poc(start, start + size);
> > +     dcache_clean_poc_nosync(start, start + size);
> >  }
> >
> >  void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
> > @@ -28,7 +28,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t =
size,
> >       if (dir =3D=3D DMA_TO_DEVICE)
> >               return;
> >
> > -     dcache_inval_poc(start, start + size);
> > +     dcache_inval_poc_nosync(start, start + size);
> >  }
> >
> >  void arch_dma_prep_coherent(struct page *page, size_t size)
> > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> > index 4809204c674c..e7dd8a63b40e 100644
> > --- a/include/linux/dma-map-ops.h
> > +++ b/include/linux/dma-map-ops.h
> > @@ -361,6 +361,12 @@ static inline void arch_sync_dma_for_cpu(phys_addr=
_t paddr, size_t size,
> >  }
> >  #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
> >
> > +#ifndef arch_sync_dma_flush
>
> You likely need to wrap this in "#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FLUSH"
> as done in the surrounding code.

I've dropped the new Kconfig option and now rely on whether
arch_sync_dma_flush() is provided by the architecture. If an arch
does not define arch_sync_dma_flush() in its asm/cache.h, a no-op
implementation is used instead.

Do you still prefer keeping a config option to match the surrounding
code style? Note that on arm64, arch_sync_dma_flush() is already a
static inline rather than an extern, so it is not strictly aligned
with the others.
Having both CONFIG_ARCH_HAS_SYNC_DMA_FLUSH and
"#ifndef arch_sync_dma_flush" seems duplicated.

Another potential optimization would be to drop these options
entirely and handle this via ifndefs, letting each architecture
define the macros in asm/cache.h instead.

Whether arch implements arch_sync_dma_for_xx() as static inline or
as external functions makes no difference.

- #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
- void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,-
                enum dma_data_direction dir);
- #else
+ #ifndef arch_sync_dma_for_cpu
static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
                enum dma_data_direction dir)
{
}
#endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */

>
> Thanks
>
> > +static inline void arch_sync_dma_flush(void)
> > +{
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
> >  void arch_sync_dma_for_cpu_all(void);
> >  #else
> >

Thanks
Barry
