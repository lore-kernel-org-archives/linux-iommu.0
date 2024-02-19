Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCAD2D043
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342209; cv=none; b=pEh5sM7iqWcYpC9+Niwa32Y134GXL+it0bfo/EPEhGtdTFNbLlV+QNGivWpLPMWKmvNj49oMYNKC5EgfepdSji92uvCuEDHCDfUB3wkQCUPGek9JjbAY/v6F+ONHMWaiorIsqqcxWKKmrka5B9b4FX0uweysjpKefzalsuW9pfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342209; c=relaxed/simple;
	bh=jA8i3ioQgOQIGjp2Ibf5r1JRi97p+s3VymmYnM5xl2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKIqCsNe+EpiEPKgSm+K8J2biJE+Xgu3+McKvB/hvLiL2UA2zG3M9wb8iMWffNXEaWN9idU3MFbCO9tO5geboxRrSHKjop83SQ9RS7WQXOceHEaJlSeAU1cBU4cHCFBmoD7pmUcLPMXY4WCv5uKX8OUI6g3UEgcwRZdZI86KObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk/B3HLr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk/B3HLr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60818d338bfso12747447b3.0
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 03:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708342206; x=1708947006; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzcrk3xPXXPW5E4xvwIqBIj0vf/WhGzB03Om/UaEaD4=;
        b=sk/B3HLrBJtz8v/EyQDjCHeHE9ZQMfWrVBjDmyVefWjcLp1WLW2sFj9nXdxDpPeB1a
         ezADozgvwM9MTarxkEjFhonWfX8yimwHxLqOdychvJZm5qqJxItFWfSAfKapPbp64ME3
         4q+B7EiFftNlDq/EbkaaUE2ClNLH2e5TwdEJUVvrH8eJA0Yd+CQ4lZ7SYU6H7oBM+D4n
         F4Hn+oBpdY0WHh8Czt0exa32EHicqqQBKbGuQYOsP7BghjQ9yUEUf8Td/giCsTss5PzO
         byucipWhzbtd4dEX71U5QNmQn76yH8/2ufnL1pRg+y8AcOujQ1D++NfrS5vpZfAh9PKs
         LfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342206; x=1708947006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzcrk3xPXXPW5E4xvwIqBIj0vf/WhGzB03Om/UaEaD4=;
        b=tIYDGWqrHpeivwrrf+p0Z6WrySWwA/lboO2i0KDJ1O6vGfpOUo0J/gKrGeFgIVU4Ec
         v625s5D0QFKViclM9/TdYsc0pQAIdQHvWBWd0k0JxoNwdA7iR/R+s98eImbzgkBwaOGs
         PdU2RoNp6+MUxtHPOGryoFN1fwWEhpTA9cybZd/8tyewlj3AipqYQHIewH9YdAT8i1t+
         wWGf6MpwHL2Ksx120o9WjhjcxXC1TJjliPSnZ0BDG/TPVWKuXSrAUqckurM4nhkcmsHC
         r1H4u6Cbf5kiQQqWplrCG+vo2QjXsKEv1RA7aCaN72IKzC8HEP1H1iGOA8iNHcTMusMV
         FuJA==
X-Forwarded-Encrypted: i=1; AJvYcCX2scNI0sBCd1YUoaYC+k/+QqSmJ7+8peR03I4bO73wbQ+1z2Z0z+tC3kNodIkZGWni2kynDqubMt8PqnBqlssLr07lMqw=
X-Gm-Message-State: AOJu0Yz70ihhPTRkSEQrMT3FA+r0ZKPAjaU48g502L1LOknkHvV7YKzy
	66TelagXFLTrO5Znz9ANeYRP9DSk10lfhpl0ZDLHhO/xWPjlT7Pck7T5Gq+nMQ84W1T75HphzKP
	xehGSnWCw14Uj56eKGr+S/Z5dAydu6oSkYm2r
X-Google-Smtp-Source: AGHT+IFQZJmL8c/5NtY6f5BdPvoYb88H262MzAFliOOAJlGQJH69WotyinmVpQjwiiapZFhWIhykVbSBw7LtebX4I1g=
X-Received: by 2002:a0d:cb0e:0:b0:604:7b9e:f62f with SMTP id
 n14-20020a0dcb0e000000b006047b9ef62fmr13410931ywd.37.1708342206438; Mon, 19
 Feb 2024 03:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com> <ZcUXP14Ng8g5vw1j@smile.fi.intel.com>
In-Reply-To: <ZcUXP14Ng8g5vw1j@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Mon, 19 Feb 2024 19:29:55 +0800
Message-ID: <CAJDAHvbYBVS=LiYHWd_KAtGtcQsjRsLCm2w3j9o4SvLBG_qiZw@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 2:02=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> > Add support for multiple coherent rmems per device. This patch replaces
> > original dma_mem with dma_mems list in device structure to store multip=
le
> > rmems.
> >
> > These multiple rmems can be assigned to the device one by one by
> > of_reserved_mem_device_init_by_idx() with the memory-region
> > declaration in device tree as below and store the rmem to the dma_mems
> > list.
> >
> >       device1@0 {
> >               ...
> >               memory-region =3D <&reserved_mem0>, <&reserved_mem1>;
> >               ...
> >       };
> >
> > When driver tries to allocate memory from the rmems, looks for the firs=
t
> > available rmem and allocates the memory from this rmem.
> >
> > Then if driver removed, of_reserved_mem_device_release() needs to be
> > invoked to release all the rmems assigned to the device.
>
> ...
>
> >       struct dma_coherent_mem *mem;
> > -     int ret;
> > +     int retval;
> >
> >       mem =3D dma_init_coherent_memory(phys_addr, device_addr, size, fa=
lse);
> >       if (IS_ERR(mem))
> >               return PTR_ERR(mem);
> >
> > -     ret =3D dma_assign_coherent_memory(dev, mem);
> > -     if (ret)
> > +     retval =3D dma_assign_coherent_memory(dev, mem);
> > +     if (retval)
> >               _dma_release_coherent_memory(mem);
> > -     return ret;
> > +     return retval;
>
> This is unrelated change.
>
> But why? Do you have retval in the _existing_ code elsewhere?

Rename the 'ret' variable to 'retval' because, in the
dma_mmap_from_dev_coherent(),
there is an argument named 'ret', and also I add 'retval' for the return va=
lue.
So I try to rename it here to be consistent.

>
>
> ...
>
> >  int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
> >               dma_addr_t *dma_handle, void **ret)
> >  {
> > -     struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> > +     struct dma_coherent_mem *mem_tmp;
> >
> > -     if (!mem)
> > +     if (list_empty(&dev->dma_mems))
> >               return 0;
> >
> > -     *ret =3D __dma_alloc_from_coherent(dev, mem, size, dma_handle);
> > +     list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> > +             *ret =3D __dma_alloc_from_coherent(dev, mem_tmp, size, dm=
a_handle);
> > +             if (*ret)
> > +                     break;
>
> This bails out on the first success. Moreover, if one calls this function
> again, it will rewrite the existing allocation. Is this all expected?
>
> OTOH, if you add multiple entries and bailing out on error condition it s=
hould
> be clear if the previous allocations have to be released.

If it's not able to allocate required memory from the first entry,
then tries to allocate
from the following entry, and so on.

>
> > +     }
>
> >       return 1;
>
> >  }
>
> ...
>
> >  int dma_release_from_dev_coherent(struct device *dev, int order, void =
*vaddr)
> >  {
> > -     struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> > +     struct dma_coherent_mem *mem_tmp;
> > +     int retval =3D 0;
> > +
> > +     list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> > +             retval =3D __dma_release_from_coherent(mem_tmp, order, va=
ddr);
> > +             if (retval =3D=3D 1)
> > +                     break;
>
> Same Q here.
>
> > +     }
> >
> > -     return __dma_release_from_coherent(mem, order, vaddr);
> > +     return retval;
> >  }
>
> ...
>
> >  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_stru=
ct *vma,
> >                          void *vaddr, size_t size, int *ret)
> >  {
> > -     struct dma_coherent_mem *mem =3D dev_get_coherent_memory(dev);
> > +     struct dma_coherent_mem *mem_tmp;
> > +     int retval =3D 0;
> >
> > -     return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
> > +     list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> > +             retval =3D __dma_mmap_from_coherent(mem_tmp, vma, vaddr, =
size, ret);
> > +             if (retval =3D=3D 1)
> > +                     break;
>
> And here.
>
> > +     }
> > +
> > +     return retval;
> >  }
>
> ...
>
> With the above Q in mind, here is another one: Why can't we allocate all =
at once?

Not sure if I misunderstand your meaning, It tries to allocate the
memory from the first
entry that satisfies the allocation requirement, but not separately.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Regards,

Howard
