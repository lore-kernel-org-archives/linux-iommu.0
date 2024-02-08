Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A77994A
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404269; cv=none; b=DdTkL7F5/2WvGGtVNN3+3e/KD6eirYKYOYGwu6HpmYOzHijhHnI2xII/nFSOTRTo0iF40GHuqYRZHEFvv3JEfI2gObiq0JUBkRcaipT8Cc18FdeCYDxJLvG2uE9wknhrDerGxX2gOnDkgH0UPCCS8A0o+ckHr8IPgy6VmKkRfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404269; c=relaxed/simple;
	bh=hH7V+z/hkc0o3nHSLBAVIPKUSNR0BqQ6uPNJD/UTNDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVXSuXjz4BJmGbmcAB+e+XHP2ifTFHvOvbVQyacDkE1os4FkiU79Uxv1VDNIif80j+GWB7+dX0yO0iWIj0I+xLINQUPFLMzXUopZ/XziyXZv+FOLA4zcPSnCsnlx0Uj4THKUD67PUPMU5wPLLsDEegVIEMlEeiL3WfvUak8eEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CftC6t0T; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CftC6t0T"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604b23d91afso2920417b3.3
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707404267; x=1708009067; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zopLlrXDFqXb0fsa403Kdv4YZb4TULp/KAiF9gHcjgo=;
        b=CftC6t0TJV13ac0Rv9f7Z6o4+v68Agd1Z6ssLgoDMSKeeVz5tSEfMPuR8ZiY1dM4wc
         v4Y69jv7dP2SDhPylFNeym0O86QJEU9XnaaY4hU/0RZUOHkBU6ED5Ctj37r7d+/mdBQW
         3ZsNxR2L92J9+S4uXB7qWsQErPz9rUD3hGRD2u1oqnUEhxOGCzjkxfyN4yFKZkxUviqg
         o2b9qUk3oPDj2wyExtm1mjJdP/Z99rpwMOoXPaNo8UW+Khkb4RfohJKNkczkQL8tsC1r
         t9LVYJLX0sPnivFC70BsrHsSUki95dFriA7WtBE0SECYTTuZ3f59JU3XUk0CfTbRaVxr
         Ej4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404267; x=1708009067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zopLlrXDFqXb0fsa403Kdv4YZb4TULp/KAiF9gHcjgo=;
        b=NBhhccr5Sciz4OOrri4Qc5paIgDA0aW6+wvl0qqs4Bapakkml+rEYRAathS7GTIgdX
         PzCf+BPhhYGJ4MpMZ1qOPMRjCQkFO9pvfT4AcjhXfiwWhX+LRVoODWUdBZVUdvlYAdHA
         1/4BODDXyGnhqE/LuDezsklsWHOlr5s2SoXnWufoiOpxAIk00avE0XzaHpRYgPuruejh
         Xm5XWIjt+wWQsJ6c3lhxtUOTZNAGlMG4q67xMq+8WXcuMsxfYTRgh8ZehT679niPC/r3
         SOwMoFJwWuDP3WbOlHfexS5G6leA081NrOB8mrxraTp6rU5/BJY1AXXrqyPoHUcuVs0e
         Nwfg==
X-Forwarded-Encrypted: i=1; AJvYcCWzb8Z1rQgC+NK6Y1VnU11OSC8OD+r22xPghcbm2JfyGKcvUuztg17WWJzco9IJ7yE0/d+VTm6FGQKx2p83zIa6s0ODb/I=
X-Gm-Message-State: AOJu0YyPnfSZTXQJkIw/gidP96inmt5YiYFe/OFPLhMnpQlDiDO6FhJi
	t1zMH3cNCrGsvYSi73ivAGJpxb1bjs0zqhP/8EfsPJYFPKIIwKUi+nnjLCKn9hsth/k7gyKA7Xw
	DBUUDXtd/LnXe4Ubolbpj7Haw3Pf4XWxLgBK6
X-Google-Smtp-Source: AGHT+IGrPduEnxofD7OsjMeh2aFvSXFirpwFFu4mUL42iR68ByNnAUEsUvjhMEaNQwNYyPv1xuLzyiMtMEhEE7h6zPM=
X-Received: by 2002:a05:690c:6:b0:5ff:9662:11c8 with SMTP id
 bc6-20020a05690c000600b005ff966211c8mr11396195ywb.43.1707404266501; Thu, 08
 Feb 2024 06:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240205072312.2342188-1-howardyen@google.com>
 <ZcDPn5eLvMwpb7N1@smile.fi.intel.com> <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
 <CAJDAHvYYUcn2HL1QTSG-KA0QcuAOotk5hY4cpuasOu_H=X-V0A@mail.gmail.com> <ZcSzW1kFZIZ_f759@smile.fi.intel.com>
In-Reply-To: <ZcSzW1kFZIZ_f759@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Thu, 8 Feb 2024 22:57:34 +0800
Message-ID: <CAJDAHvaYqq+PFTQRejcbUbyX6zHw5wygF+dRh9HNbJ83fmZacA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems per dev
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 03:53:37PM +0800, Howard Yen wrote:
> > On Tue, Feb 6, 2024 at 11:43=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 05, 2024 at 02:08:00PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:
>
> ...
>
> > > > > @@ -18,15 +18,9 @@ struct dma_coherent_mem {
> > > > >     unsigned long   *bitmap;
> > > > >     spinlock_t      spinlock;
> > > > >     bool            use_dev_dma_pfn_offset;
> > > > > +   struct list_head        node;
> > > >
> > > > Have you run `pahole`? Here I see wasted bytes for nothing.
> > >
> > > On top of that one may make container_of() to be no-op, by placing th=
is member
> > > to be the first one. But, double check this with bloat-o-meter (that =
it indeed
> > > does better code generation) and on the other hand check if the curre=
nt first
> > > member is not performance critical and having additional pointer arit=
hmetics is
> > > okay.
> > >
> > > > >  };
> >
> > I'm trying to re-org the members as below
> >
> > from =3D=3D=3D>
> >
> > struct dma_coherent_mem {
> > void *                     virt_base;            /*     0     8 */
> > dma_addr_t                 device_base;          /*     8     8 */
> > unsigned long              pfn_base;             /*    16     8 */
> > int                        size;                 /*    24     4 */
> >
> > /* XXX 4 bytes hole, try to pack */
> >
> > unsigned long *            bitmap;               /*    32     8 */
> > spinlock_t                 spinlock;             /*    40     4 */
> > bool                       use_dev_dma_pfn_offset; /*    44     1 */
> >
> > /* XXX 3 bytes hole, try to pack */
> >
> > struct list_head           node;                 /*    48    16 */
> >
> > /* size: 64, cachelines: 1, members: 8 */
> > /* sum members: 57, holes: 2, sum holes: 7 */
> > };
> >
> >
> > to =3D=3D=3D>
> >
> > struct dma_coherent_mem {
> > struct list_head           node;                 /*     0    16 */
> > void *                     virt_base;            /*    16     8 */
> > dma_addr_t                 device_base;          /*    24     8 */
> > unsigned long              pfn_base;             /*    32     8 */
> > int                        size;                 /*    40     4 */
> > spinlock_t                 spinlock;             /*    44     4 */
> > unsigned long *            bitmap;               /*    48     8 */
> > bool                       use_dev_dma_pfn_offset; /*    56     1 */
> >
> > /* size: 64, cachelines: 1, members: 8 */
> > /* padding: 7 */
>
> Which seems better that above, right?
>
> > };
> >
> > Looks like there is about 7 bytes padding at the end of the structure.
> > Should I add __attribute__((__packed__)) to not add the padding?
>
> No, __packed is about alignment, may give you much worse code generation.
> With list_head member first you might get better code from the original,
> check it with bloat-o-meter.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

From the check result with bloat-o-meter, there is about 3.38%
reduction totally from the
original version. Thanks for the suggestion!

add/remove: 0/0 grow/shrink: 0/7 up/down: 0/-60 (-60)
Function                                     old     new   delta
rmem_dma_device_release                      104     100      -4
dma_release_from_dev_coherent                184     180      -4
dma_release_coherent_memory                  144     140      -4
dma_mmap_from_dev_coherent                   228     224      -4
dma_init_coherent_memory                     292     284      -8
rmem_dma_device_init                         168     152     -16
dma_declare_coherent_memory                  184     164     -20
Total: Before=3D1776, After=3D1716, chg -3.38%
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Data                                         old     new   delta
Total: Before=3D0, After=3D0, chg +0.00%
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
RO Data                                      old     new   delta
Total: Before=3D216, After=3D216, chg +0.00%

For the dev check, in the previous comment, they're in the static
function and are assigned
to ops function pointers, I think the check is required because they
might be invoked from
others.

I'll submit v3 with the members reorg, the return variable naming
changes and if (!dev) return; .


--=20
Regards,

Howard
