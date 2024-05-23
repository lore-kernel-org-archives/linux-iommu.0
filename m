Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3451E497
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471278; cv=none; b=uF1Yxv6Noo4+b0UlBdM0yk1e3674uiblap4k4jExDl48V78lZIVrWyd+yNPbqe+LQCugiZZv/SzJD9jFIwOKNmNZUw/DFOFA3h7Pd2FqMtChK2m4UDXpXbNAktnaaXC1Zu2QR1yz1/cQrmxoI+nnxDVl93FVbixrz3kPZxkvUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471278; c=relaxed/simple;
	bh=RSPz/BgK+60ML+64zy8oGk8LjuwU4cNCx7CrZFAbWKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMSyvYb/2wySTIGkAfPnUmPzT5liuesIwGd7bHwnrNZLHgXS3TqvKUiqUNQr9EN4E6hEoymgiHfm3L4xxTkRF4tn1Tv3vy4L3psUVaOXfCJbKFSk73mXdiZU/mkuwu+HfpKZTQSoF6N8GXXlfqBebbePg+5W6p2ldGOfq2EXn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msQnqhPr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msQnqhPr"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e45c0a8360so67790221fa.3
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716471275; x=1717076075; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtbQQajEFybjK9HptnFVriGEZVc+zK1/sxZYJMckKQ0=;
        b=msQnqhPrcFGVACjmDxCTPMMRWhAwd/7ouomy7f2YmfqHcRXFderqX/WbYMazuUsP3/
         GN/jbSmKAoP9VPY0mZx4nXuepBvuyMTurWdLCZbT10FTsDf1g+dARKu+431nVpF5q4Js
         RihBU4iZAqNnWDgedU+zi4TuLrulZ/nP5v8XDcc5Y+Ne4jTNs04TMe1Gq4wE2c2mDv8u
         UAELNhBQuJYmmZsC7nqJuu95dkCRhwDvsseT5tgrYMWmKsvnNbeHEeJbjcOpaT5BvkoS
         /VhwhlL+laNOaOrsDfcAdEPHdCnNoYn3Xl6uPA0uuMyOfUMRmRIwCZE5mUHDHYOa9dG9
         r1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716471275; x=1717076075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtbQQajEFybjK9HptnFVriGEZVc+zK1/sxZYJMckKQ0=;
        b=nT2BciT2i/urVaRAEOalUzMT2mLJ3UOSw5YMPQTCwXpjOblOJQtlhMHinjZjUmOnfb
         tqEG4tmsWW2ADZAk1bGm/vQqcAP82jc4V6lUCDnntTlYY0/UL9gFIIJF5URhbFRRro/M
         f8fH7nefEaN5zzwbtujtdW2qDTjpBXy1ay6oPmvA3zDGheEh8+6FmhBm+6RjmW7/PYpR
         AQd4TAFvK6LUWW7jBTYyF8QlIEKm0ZIxjn8uUfBIuh+4O7a0EnubmyN6jYT91uGt5whn
         KZmte7vXB39ohuQ8KToDZTm4ZBfJHxU+J1IS5GoiU1rhxxPGDsPRCk63AQWWhUsZfTAb
         mgPw==
X-Gm-Message-State: AOJu0YxVgBP8QtSkOSxyM5ZrSznfWMO1EpEAM84axfwKhA/YSp/CfoAj
	+5xGlhg5LL6jSHIxmaTvpnLVk8XrbqV6ZkIGsDt6DeY6Qr6bBVBrqXZ9HtQFawyTRuWwXXppMO6
	YY2nNu1aTOw3sUKHhREYEdOm+ydo=
X-Google-Smtp-Source: AGHT+IGrjPkj92rK8az8Rkwh6Nfn/LwvOSJYNgQY53BW8Pi/H1c5xfUnkRbo7lpLDaw+HBzmKK+OQ4b+H4MVPxAdlf8=
X-Received: by 2002:a2e:7302:0:b0:2e7:102f:7aeb with SMTP id
 38308e7fff4ca-2e949540b29mr32685201fa.40.1716471274703; Thu, 23 May 2024
 06:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240522082729.971123-1-ubizjak@gmail.com> <20240522082729.971123-2-ubizjak@gmail.com>
 <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
In-Reply-To: <c1892ba9-4eae-40fc-b3ab-73d0f82a74ea@linux.intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 23 May 2024 15:34:23 +0200
Message-ID: <CAFULd4Z=YkV1Hbs4DikPBwO-6rg8tfDLGeacSCnfbC02E5y+Cg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 3:24=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2024/5/22 16:26, Uros Bizjak wrote:
> > Use try_cmpxchg64() instead of cmpxchg64 (*ptr, old, new) !=3D old in
> > intel_pasid_get_entry().  cmpxchg returns success in ZF flag, so
> > this change saves a compare after cmpxchg (and related move
> > instruction in front of cmpxchg).
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index abce19e2ad6f..9bf45bc4b967 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -146,6 +146,8 @@ static struct pasid_entry *intel_pasid_get_entry(st=
ruct device *dev, u32 pasid)
> >   retry:
> >       entries =3D get_pasid_table_from_pde(&dir[dir_index]);
> >       if (!entries) {
> > +             u64 tmp;
> > +
> >               entries =3D iommu_alloc_page_node(info->iommu->node, GFP_=
ATOMIC);
> >               if (!entries)
> >                       return NULL;
> > @@ -156,8 +158,9 @@ static struct pasid_entry *intel_pasid_get_entry(st=
ruct device *dev, u32 pasid)
> >                * clear. However, this entry might be populated by other=
s
> >                * while we are preparing it. Use theirs with a retry.
> >                */
> > -             if (cmpxchg64(&dir[dir_index].val, 0ULL,
> > -                           (u64)virt_to_phys(entries) | PASID_PTE_PRES=
ENT)) {
> > +             tmp =3D 0ULL;
>
> nit: can this simply be
>                 tmp =3D 0;
> ?

I just took the same suffix as it was in the original code, but for
zero literal, it does not make any change. I can change it, it
preferred.

> > +             if (!try_cmpxchg64(&dir[dir_index].val, &tmp,
> > +                                (u64)virt_to_phys(entries) | PASID_PTE=
_PRESENT)) {
>
> Above change will cause a dead loop during boot. It should be

No, it is correct as written:

if (cmpxchg64(*ptr, 0, new))

can be written as:

if (cmpxchg64(*ptr, 0, new) !=3D 0)

this is equivalent to:

tmp =3D 0ULL;
if (!try_cmpxchg64(*ptr, &tmp, new))

Thanks,
Uros.
