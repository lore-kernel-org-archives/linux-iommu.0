Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D73EA78
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821626; cv=none; b=j98C8PfUrnf2BhY4cyanRgpp2OO05mKeO3COOII9vF1BcHF3bW5RBrvxC5oB0v3g89JJf9rYN7reoortHxi83sXt5WrpakDcBhyRuYMgu8Lo1ONiimxHEDy/yvwgek3fgHRmjk1F4ZZ52yG1RNseNX/0hPPiI7xO2V0SdXB4TeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821626; c=relaxed/simple;
	bh=7ZoHgpdBSvGdJPrarfgjnz43g7iyXARldk+R14Nq+XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUg9yfFuog5c5DN5RWFrrr+B/dSrm0TuvsAtIZm3ZTQxREIJ3Innlq3GHCfsrmfIglV5aiDaE6cqtu6BIvyCIqbyBvhjOGP3cKI7mXsTg2uFKUHjaLS22k6a+VnumQ6p7YhzBKh7fF9FhvrFcTtavzQ7Ywi1B8SNu2/x8RcKVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=W3kRWR1N reason="key not found in DNS"; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="W3kRWR1N"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3beb504c985so755156b6e.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706821624; x=1707426424; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpf1puraZK0YLhm6VC32jQUIE3+0XR7H+iAbplKocpw=;
        b=W3kRWR1NVWk1spe8QC8QR/UxV7PrSN+7SVJE4fJZgvyddufzijby7gO4743ZGO4H+d
         zrt9H9n6mmsA39+yhcG40/DazdNJUUFBLYhHmnmYkwEfMXcjoxyDNie/ISpiivx0Sdu4
         AORo0bUDyqxi8KNfDYxSkJDIn2rBEla7OjJiR3GOc1AwgtJGqk3j0wRO1ZKFa4yKn3Ae
         WCzF+yzqJ+j9LslWS39IMgz0YcFkinClJBoTqlwwd7NP2jNh84RuA+NilIGagaZ1xeo3
         FtZJyhAbmQ0jU8Icuw5+9IQpeIzJJXOG4necf/j4+F8B3Uyz6sc93idWjV6Cft7I/TJ2
         nbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821624; x=1707426424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xpf1puraZK0YLhm6VC32jQUIE3+0XR7H+iAbplKocpw=;
        b=cvYB1Gf3Q/Qwa2/EYIw00t3tKN4hn4znyAj5Da4Ip3ssw6/ZmqtI/ZVFcZWa8qUSDV
         wEJLrHMI4lk4pjghoYuEnPH2aSe06C2Ampsh+PssH62dqthZ5lz3uTtojMVz6U5+QAFU
         rPCnVbNIDfMqmpCDj02Ks3+/uQ7fkCF3NPDxV3b4K1TfZUFmbknAh/PSwRc0cnZeh27v
         RBjMq/w5NsgMuOW/aSwEXVYZWtt3fqkAzXFhM7gID15J+htG30Ks3uKevbOqKBU9VL+h
         KdYLTfoa5KdTtS2iLVMW7Q5p+IY2ewTPlmqaRhvuE87rpf1DYHBeXzqVjDeiccRIdovH
         T5QA==
X-Gm-Message-State: AOJu0YxIlzeCosqbLEFd5CLdEGxsOgVCKCb8+bOtqn6XE7FxZBsz1JdE
	IqwlgPcbPqtqiZza+PbPCxVlN+Uqeavmhz7bSKE8gxcfylN8mrjcA5B8zVdpW8XoU45kPLec5j3
	h9NzuD8vNYnqT1vERcgManqF16NbjOu2okW2PXw==
X-Google-Smtp-Source: AGHT+IHGtpacZ+jaBeIGAsk6QQM31sihBMAtG5jzOo+mB5SscJQIhVF2DHVshWAHRjZKVuxKH7/NbyOPrZUa5kEDaHc=
X-Received: by 2002:a05:6808:2220:b0:3be:aafd:ce3 with SMTP id
 bd32-20020a056808222000b003beaafd0ce3mr7132823oib.3.1706821623809; Thu, 01
 Feb 2024 13:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
In-Reply-To: <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 1 Feb 2024 16:06:27 -0500
Message-ID: <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:56=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2024-02-01 7:30 pm, Pasha Tatashin wrote:
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > The magazine buffers can take gigabytes of kmem memory, dominating all
> > other allocations. For observability prurpose create named slab cache s=
o
> > the iova magazine memory overhead can be clearly observed.
> >
> > With this change:
> >
> >> slabtop -o | head
> >   Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
> >   Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
> >   Active / Total Caches (% used)     : 135 / 211 (64.0%)
> >   Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
> >   Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> >
> > OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> > 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazin=
e
> >   91636  88343 96%    0.03K    739     124      2956K kmalloc-32
> >   75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> >
> > On this machine it is now clear that magazine use 242M of kmem memory.
>
> Hmm, something smells there...
>
> In the "worst" case there should be a maximum of 6 * 2 *
> num_online_cpus() empty magazines in the iova_cpu_rcache structures,
> i.e., 12KB per CPU. Under normal use those will contain at least some
> PFNs, but mainly every additional magazine stored in a depot is full
> with 127 PFNs, and each one of those PFNs is backed by a 40-byte struct
> iova, i.e. ~5KB per 1KB magazine. Unless that machine has many thousands
> of CPUs, if iova_magazine allocations are the top consumer of memory
> then something's gone wrong.

This is an upstream kernel  + few drivers that is booted on AMD EPYC,
with 128 CPUs.

It has allocations stacks like these:
init_iova_domain+0x1ed/0x230 iommu_setup_dma_ops+0xf8/0x4b0
amd_iommu_probe_finalize.
And also init_iova_domain() calls for Google's TPU drivers 242M is
actually not that much, compared to the size of the system.

Pasha

>
> Thanks,
> Robin.
>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index d30e453d0fb4..617bbc2b79f5 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >
> >   #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> >
> > +static struct kmem_cache *iova_magazine_cache;
> > +static unsigned int iova_magazine_cache_users;
> > +static DEFINE_MUTEX(iova_magazine_cache_mutex);
> > +
> >   struct iova_magazine {
> >       union {
> >               unsigned long size;
> > @@ -654,11 +658,51 @@ struct iova_rcache {
> >       struct delayed_work work;
> >   };
> >
> > +static int iova_magazine_cache_init(void)
> > +{
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&iova_magazine_cache_mutex);
> > +
> > +     iova_magazine_cache_users++;
> > +     if (iova_magazine_cache_users > 1)
> > +             goto out_unlock;
> > +
> > +     iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine",
> > +                                             sizeof(struct iova_magazi=
ne),
> > +                                             0, SLAB_HWCACHE_ALIGN, NU=
LL);
> > +
> > +     if (!iova_magazine_cache) {
> > +             pr_err("Couldn't create iova magazine cache\n");
> > +             ret =3D -ENOMEM;
> > +     }
> > +
> > +out_unlock:
> > +     mutex_unlock(&iova_magazine_cache_mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static void iova_magazine_cache_fini(void)
> > +{
> > +     mutex_lock(&iova_magazine_cache_mutex);
> > +
> > +     if (WARN_ON(!iova_magazine_cache_users))
> > +             goto out_unlock;
> > +
> > +     iova_magazine_cache_users--;
> > +     if (!iova_magazine_cache_users)
> > +             kmem_cache_destroy(iova_magazine_cache);
> > +
> > +out_unlock:
> > +     mutex_unlock(&iova_magazine_cache_mutex);
> > +}
> > +
> >   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> >   {
> >       struct iova_magazine *mag;
> >
> > -     mag =3D kmalloc(sizeof(*mag), flags);
> > +     mag =3D kmem_cache_alloc(iova_magazine_cache, flags);
> >       if (mag)
> >               mag->size =3D 0;
> >
> > @@ -667,7 +711,7 @@ static struct iova_magazine *iova_magazine_alloc(gf=
p_t flags)
> >
> >   static void iova_magazine_free(struct iova_magazine *mag)
> >   {
> > -     kfree(mag);
> > +     kmem_cache_free(iova_magazine_cache, mag);
> >   }
> >
> >   static void
> > @@ -766,11 +810,17 @@ int iova_domain_init_rcaches(struct iova_domain *=
iovad)
> >       unsigned int cpu;
> >       int i, ret;
> >
> > +     ret =3D iova_magazine_cache_init();
> > +     if (ret)
> > +             return -ENOMEM;
> > +
> >       iovad->rcaches =3D kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> >                                sizeof(struct iova_rcache),
> >                                GFP_KERNEL);
> > -     if (!iovad->rcaches)
> > +     if (!iovad->rcaches) {
> > +             iova_magazine_cache_fini();
> >               return -ENOMEM;
> > +     }
> >
> >       for (i =3D 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> >               struct iova_cpu_rcache *cpu_rcache;
> > @@ -948,6 +998,7 @@ static void free_iova_rcaches(struct iova_domain *i=
ovad)
> >
> >       kfree(iovad->rcaches);
> >       iovad->rcaches =3D NULL;
> > +     iova_magazine_cache_fini();
> >   }
> >
> >   /*
