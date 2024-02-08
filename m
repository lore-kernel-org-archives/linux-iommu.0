Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73E69D13
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378832; cv=none; b=av/44meZ/ZNQhsb/1qYSy53nQXGvPSlyfEjHcppcnBJKENd/q1gNmPVX7V00Zc4TzeLKBijssNxmmnTXYzv1wakNY1E3keOD4Lps4P4FSrBnpe52Hxdhv4a+BrehAD6t2boxFh0PhPmUgKdoP4hoKlZGbHWoZDVp2dy52FHHkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378832; c=relaxed/simple;
	bh=zr0nXHCLCgbCxf536hCWc47ovVoYrsykHUk2cT9bZpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byQLsb2sX+IeQ3wxVIJrEVLCioVJcLETRTihHRGWOXB5CeIg7xNAf5YyP19iX924gxaYhkPssWqhdf05kmXsQsRyV8tvWmMse+zu91d1YKoXeQiCRzl+0Tt3E9TTAnNen2yZsOTPKDNqduPBjAAocy0CfWEIo9vkPfqi8Gdkido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZf9z5Wu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZf9z5Wu"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-604ac794c01so944587b3.2
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707378830; x=1707983630; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lTivgtbYP71+Odlu/TAApxufweZalnigwFKImBTxuw=;
        b=tZf9z5WuMyWWhAv+KGlmp/KaJaZ4x5qI43hHuM39+N0hPaU4wwW3bib52vn/w6mkYu
         P+pbk1mDvkJ0uSNJdq7CsG9jRSQ45XQiwcYfiEygiRwyE78ZbxO3WMNdRjEvNGYsYst2
         CdZ6A5W0FOJaWNtFe6QKAt44ayXVEwv8sGyNoSJpXiPaoGsJ6po/U634q5bJQ/Z+hOTt
         wQTrU78FAKiED3cKDOKspnRhxGnZRGDbETWVpIv71pgfagLlvsqzEg6Qd8bZaDJymRTE
         jMlqYLHMtAgAXkMjUwdwL1uiZ/uAbQLkjPiqmWTzVZBADYCGSEBHRGT8BNzWEbjk88ny
         H+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707378830; x=1707983630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lTivgtbYP71+Odlu/TAApxufweZalnigwFKImBTxuw=;
        b=QhoBD6y/tdNT0PQWcZFoqLnh4nDyWbP4yk9Hf2AW7FIV/DoPJ9f1fDZ2HmVly1x0DE
         6s3/fJ8UJO5H/3xvHCr1ot5zZN+z1lgrtgQyR0GUmYlIY/q6P9N47Rds57w8ZzNEOZi1
         /zL6qwhQYHh9pOrkTNwUmrkM33+jxgypfrTNBrZlx8kZZhmY0igeDpfSDX/ozNfUCzjR
         Tu5ZWDewtMQ9f22d4Krwy+MXcORdrpXh7bo8JfrYZzjSE97kq7MxlBziQl+UYcb9C3Fi
         s4aPVWblek7TuE5yTF9VJAwpqRK5cr4TH+F9h6dxQ+g+KRwsXneoyEgk1HZBGBtL5Lbe
         j1vw==
X-Gm-Message-State: AOJu0Yy0dFKUQ3ZxMSxgcAdySPpDeShGl+DzyDM8QbfTN7ailK7JHrp8
	nBiQCIbi7wnTr6gncBWjYXFwG/xIE998hI5rV7ChA7xNvNeLOyjt0y1rC7N/NiC5OWv9gRATo+1
	pURXu/cZ9BN+zZrDrHxbuY62X/XHx1HKAL7fS
X-Google-Smtp-Source: AGHT+IHq5op1lz43rDnEfucwyPkNa34V8pC6FdvL0c34p4k8oyrSf4BDHaIoFEgydIEr6WsetJ75rmQO565ZkVbVhlc=
X-Received: by 2002:a81:b545:0:b0:604:602d:8eb2 with SMTP id
 c5-20020a81b545000000b00604602d8eb2mr7083241ywk.12.1707378829561; Wed, 07 Feb
 2024 23:53:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240205072312.2342188-1-howardyen@google.com>
 <ZcDPn5eLvMwpb7N1@smile.fi.intel.com> <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
In-Reply-To: <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Thu, 8 Feb 2024 15:53:37 +0800
Message-ID: <CAJDAHvYYUcn2HL1QTSG-KA0QcuAOotk5hY4cpuasOu_H=X-V0A@mail.gmail.com>
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems per dev
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 02:08:00PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:
>
> ...
>
> > > @@ -18,15 +18,9 @@ struct dma_coherent_mem {
> > >     unsigned long   *bitmap;
> > >     spinlock_t      spinlock;
> > >     bool            use_dev_dma_pfn_offset;
> > > +   struct list_head        node;
> >
> > Have you run `pahole`? Here I see wasted bytes for nothing.
>
> On top of that one may make container_of() to be no-op, by placing this m=
ember
> to be the first one. But, double check this with bloat-o-meter (that it i=
ndeed
> does better code generation) and on the other hand check if the current f=
irst
> member is not performance critical and having additional pointer arithmet=
ics is
> okay.
>
> > >  };
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I'm trying to re-org the members as below

from =3D=3D=3D>

struct dma_coherent_mem {
void *                     virt_base;            /*     0     8 */
dma_addr_t                 device_base;          /*     8     8 */
unsigned long              pfn_base;             /*    16     8 */
int                        size;                 /*    24     4 */

/* XXX 4 bytes hole, try to pack */

unsigned long *            bitmap;               /*    32     8 */
spinlock_t                 spinlock;             /*    40     4 */
bool                       use_dev_dma_pfn_offset; /*    44     1 */

/* XXX 3 bytes hole, try to pack */

struct list_head           node;                 /*    48    16 */

/* size: 64, cachelines: 1, members: 8 */
/* sum members: 57, holes: 2, sum holes: 7 */
};


to =3D=3D=3D>

struct dma_coherent_mem {
struct list_head           node;                 /*     0    16 */
void *                     virt_base;            /*    16     8 */
dma_addr_t                 device_base;          /*    24     8 */
unsigned long              pfn_base;             /*    32     8 */
int                        size;                 /*    40     4 */
spinlock_t                 spinlock;             /*    44     4 */
unsigned long *            bitmap;               /*    48     8 */
bool                       use_dev_dma_pfn_offset; /*    56     1 */

/* size: 64, cachelines: 1, members: 8 */
/* padding: 7 */
};

Looks like there is about 7 bytes padding at the end of the structure.
Should I add __attribute__((__packed__)) to not add the padding?

--=20
Regards,

Howard
