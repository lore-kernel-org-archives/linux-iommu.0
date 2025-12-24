Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC132737F4
	for <iommu@lists.linux.dev>; Wed, 24 Dec 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766539768; cv=none; b=GabQ4CwzUoxTYeTEEcOsPsNcFZcMnyCH4bTPZfJtTmQOUOEo421hR/Rd5eef0birMpBWBWKpY0Z2pmV8OXjcQBppn+ZXCPDJBGh3R9qO//FcwnTLzwvkx+oT4Ejxcli4RTWDIR/Lzlp8U0VWsUn9Pp75R39SYG8AGhilDG/M5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766539768; c=relaxed/simple;
	bh=o/XT/uZphnM2Dfsrdfnny5Wl3jKhdg6NAovPba8oo+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH9tWezMSNSqnYt3ehunC2KzRg9j+NxLMMUuIhwqF9A2z8/ThtmnXfCJJ13bQwkPvY/q3OwSNVkNKoGMHLosSL2JwYE2rduYYIh3NQiheJVS/5BaRFLCDmh6WR7jwTt2z85699wOPlbInbKUBYDi6QJQ+Y4lYX3mPvGbAU6ZS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjqBNjAo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjqBNjAo"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-888bd3bd639so68998446d6.1
        for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 17:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766539765; x=1767144565; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY7oetAkXk6EDYNEyscTKD195vWG9mtNfQ3sP9pZIoo=;
        b=AjqBNjAo56uCozjNMUijFggQkxpPq3OyBUjA5WdZ26kQHPjqflDrNApamCl8bdDc8F
         PByjCdy7lajkBH8tYg9POfxYupcl7Q3CNbuavQsFFMwSJmB0iSicHAnNUkrbDxDB5dJo
         wgx884WHVlqyZugo/nRvb1S4+G6NtjA0k9Q9xHJ2Fl2hmdpQZ3JJKnp5rcWwBSirXBH7
         9oAxt40iR/ObWkjgpd4FxoIE2crm+HU4tfeGWCxRj9IO11tg/9DWTo9KzNCNJZRv5FeJ
         IwsOGfhj5lgoKkxdeuIUzELT3Q7Ss5p+ByQTf1LFPRFFtegsmh3QtzgDKSDKm5fvJKFQ
         gE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766539765; x=1767144565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fY7oetAkXk6EDYNEyscTKD195vWG9mtNfQ3sP9pZIoo=;
        b=GFNK3rZHH+1NTQiaSSWlrOc6TZaRHONS3btThz8Q/FATSDVn2Wz32RHzZoLUrXXbmc
         LmYRfVEp4ZqqMKjkbZ0V9mPpchKDV/mBJpwB1DCQan2wSgUnbfi1QUuANwe7V/NIS54w
         9UlOWlZAgG45vsyWqZmqn96kx+8+OaEXNc/JBD28SOcunO2B5LwEWIebo38TDR3BWOjG
         bF4126ClT8MNXjPnUNetwtHfrOKJw6VQhvVJyUp7IS99e0FYLEsxcLJXYOV5TQGTFySa
         Q3V7pPb0OrRykUVtUIwXN5ejqEmTSWWzRnU5yfyy24NUrjIhiwGLuCWcgCRnS0KvLmCP
         K2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcAKnh1fRcHB2apa0TqFuLRo8U0ZKwKGf6DZu7C2DQWf7DBMdJekj71/untONVDCSJWurtdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUCMowI6rqse9I04qwIQeyP9hyjKq6TLArTKu/HZbMC56/+He8
	JWdJzGzrqzXe2mxiGXgYR6sFYcbC0zioI3MRATdStfiuLYeXkMuW3v/7YmX9dT93EX7Xw6tJ1Y6
	BwqahjAdd5rVMVI8rRxzQLAckQyhDjQ0=
X-Gm-Gg: AY/fxX6dvNl2S6HmRh1zt4Qxnc0pnyaNM9YdqZ8OZFd8+x+pj+/T3PLPCtMnhzZ1Gac
	X8dO8T4IRtMoywUGG2OuUIet47LqNFZ6UyFYRtbZPi/Uc8cwIRvuDoUq1Si3CjMt0YmexISm9dL
	+xR5G2rdVcfWCCkkqkWnKgLVOID2JdkcJIl35PsHsUBP/fivGq40t3UPJ0fXIRrZLzzUCGzIhL4
	4WjuxodxjTqKIGgt5N5vrdbYxEnHXl0EKKp8h7icGiaoi5UkTu6OeuWAJ9vc+Qer+/tlg==
X-Google-Smtp-Source: AGHT+IEqanr28YSBOTX+Nbqh3KipT7oWDaRrm4vfSqEc2gNLOzwNiYOzGsbYOVFZRYgy+qI8NODGQG32DiQMP3byR7U=
X-Received: by 2002:a0c:fe4a:0:b0:888:4930:7988 with SMTP id
 6a1803df08f44-88d8453a11cmr183257436d6.35.1766539765063; Tue, 23 Dec 2025
 17:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251221115523.GI13030@unreal> <20251221192458.1320-1-21cnbao@gmail.com>
 <20251222084921.GA13529@unreal> <CAGsJ_4yuvHNqHDi8eN-8UoY2McoXUeCMmbjFAr=jSdv8GpGKeg@mail.gmail.com>
 <20251223141424.GB11869@unreal>
In-Reply-To: <20251223141424.GB11869@unreal>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 24 Dec 2025 14:29:13 +1300
X-Gm-Features: AQt7F2riwb-u3bAOGTAJVBUOYvKKCghOt8XbZSdY6cf48c0vtLf1xqZXCdBK7SI
Message-ID: <CAGsJ_4x9YOT2kG0iWz_5NzRVt2iDN9YeUTknZ2MKg7SwmOGOqg@mail.gmail.com>
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

On Wed, Dec 24, 2025 at 3:14=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Dec 23, 2025 at 01:02:55PM +1300, Barry Song wrote:
> > On Mon, Dec 22, 2025 at 9:49=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Mon, Dec 22, 2025 at 03:24:58AM +0800, Barry Song wrote:
> > > > On Sun, Dec 21, 2025 at 7:55=E2=80=AFPM Leon Romanovsky <leon@kerne=
l.org> wrote:
> > > > [...]
> > > > > > +
> > > > >
> > > > > I'm wondering why you don't implement this batch=E2=80=91sync sup=
port inside the
> > > > > arch_sync_dma_*() functions. Doing so would minimize changes to t=
he generic
> > > > > kernel/dma/* code and reduce the amount of #ifdef=E2=80=91based s=
paghetti.
> > > > >
> > > >
> > > > There are two cases: mapping an sg list and mapping a single
> > > > buffer. The former can be batched with
> > > > arch_sync_dma_*_batch_add() and flushed via
> > > > arch_sync_dma_batch_flush(), while the latter requires all work to
> > > > be done inside arch_sync_dma_*(). Therefore,
> > > > arch_sync_dma_*() cannot always batch and flush.
> > >
> > > Probably in all cases you can call the _batch_ variant, followed by _=
flush_,
> > > even when handling a single page. This keeps the code consistent acro=
ss all
> > > paths. On platforms that do not support _batch_, the _flush_ operatio=
n will be
> > > a NOP anyway.
> >
> > We have a lot of code outside kernel/dma that also calls
> > arch_sync_dma_for_* such as arch/arm, arch/mips, drivers/xen,
> > I guess we don=E2=80=99t want to modify so many things?
>
> Aren't they using internal, arch specific, arch_sync_dma_for_* implementa=
tions?

for arch/arm, arch/mips, they are arch-specific implementations.
xen is an exception:

static void xen_swiotlb_unmap_phys(struct device *hwdev, dma_addr_t dev_add=
r,
                size_t size, enum dma_data_direction dir, unsigned long att=
rs)
{
        phys_addr_t paddr =3D xen_dma_to_phys(hwdev, dev_addr);
        struct io_tlb_pool *pool;

        BUG_ON(dir =3D=3D DMA_NONE);

        if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC=
)) {
                if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))))
                        arch_sync_dma_for_cpu(paddr, size, dir);
                else
                        xen_dma_sync_for_cpu(hwdev, dev_addr, size, dir);
        }

        /* NOTE: We use dev_addr here, not paddr! */
        pool =3D xen_swiotlb_find_pool(hwdev, dev_addr);
        if (pool)
                __swiotlb_tbl_unmap_single(hwdev, paddr, size, dir,
                                           attrs, pool);
}

>
> >
> > for kernel/dma, we have two "single" callers only:
> > kernel/dma/direct.h, kernel/dma/swiotlb.c.  and they looks quite
> > straightforward:
> >
> > static inline void dma_direct_sync_single_for_device(struct device *dev=
,
> >                 dma_addr_t addr, size_t size, enum dma_data_direction d=
ir)
> > {
> >         phys_addr_t paddr =3D dma_to_phys(dev, addr);
> >
> >         swiotlb_sync_single_for_device(dev, paddr, size, dir);
> >
> >         if (!dev_is_dma_coherent(dev))
> >                 arch_sync_dma_for_device(paddr, size, dir);
> > }
> >
> > I guess moving to arch_sync_dma_for_device_batch + flush
> > doesn=E2=80=99t really look much better, does it?
> >
> > >
> > > I would also rename arch_sync_dma_batch_flush() to arch_sync_dma_flus=
h().
> >
> > Sure.
> >
> > >
> > > You can also minimize changes in dma_direct_map_phys() too, by extend=
ing
> > > it's signature to provide if flush is needed or not.
> >
> > Yes. I have
> >
> > static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
> >                 phys_addr_t phys, size_t size, enum dma_data_direction =
dir,
> >                 unsigned long attrs, bool flush)
>
> My suggestion is to use it directly, without wrappers.
>
> >
> > and two wrappers:
> > static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> >                 phys_addr_t phys, size_t size, enum dma_data_direction =
dir,
> >                 unsigned long attrs)
> > {
> >         return __dma_direct_map_phys(dev, phys, size, dir, attrs, true)=
;
> > }
> >
> > static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *d=
ev,
> >                 phys_addr_t phys, size_t size, enum dma_data_direction =
dir,
> >                 unsigned long attrs)
> > {
> >         return __dma_direct_map_phys(dev, phys, size, dir, attrs, false=
);
> > }
> >
> > If you prefer exposing "flush" directly in dma_direct_map_phys()
> > and updating its callers with flush=3Dtrue, I think that=E2=80=99s fine=
.
>
> Yes
>

OK. Could you take a look at [1] and see if any further
improvements are needed before I send v2?

[1] https://lore.kernel.org/lkml/20251223023648.31614-1-21cnbao@gmail.com/

Thanks
Barry
