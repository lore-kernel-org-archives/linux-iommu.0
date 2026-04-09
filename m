Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FD387361
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772653; cv=pass; b=H5hpRL1iHVRUNdUe6v/JpERbc7cm/sBlUQ4ianHTz8LIzwJWXWs3o11mxVdHGqZDEcfWeL1szKfNu9j6iBb04VxRIflYVq2w+6nX1y1MUimGfgKQBMMF1osYAJ1PRyL12Ii36XQywwoAE03excraJKSL0k6C3xUj7fEKX6t5+mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772653; c=relaxed/simple;
	bh=pvLC+N1HCWas7LKGP2ULVAeMtjStgVNUt66QEX2BPBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ybtakpxg7DDRFAii21XEG2b8Aw9lOe4qBBvjc4lIy4lvaWx2w0jNi+secj1ymyg2cACTZTGXB6zzPOvHX6qbOSAyWtPXgx9Jbchxrj95NOjZp6ATMFt+7PxnZ8RSR/xj1xC8hLdQl4/7elO5yo7zLiPAuH0cNe7Qfw2chknDkoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Ipy9MQZ+; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Ipy9MQZ+"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79a74765703so13549627b3.3
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 15:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772651; cv=none;
        d=google.com; s=arc-20240605;
        b=Nj8o7ERWgwWiqfIATPtA+U+od1xUBgUGYoby0Fgp2sDVThWODYNJHcrU1my/V3jVJm
         U/QoEWX+U3AIEu2rXRRMxOQR2zKnUq8NukELB8QbH57LR7I2dZmmcxU3rIqqyXZ+Ii9y
         6PIHv3Z0AD+EMTYX2J5R3BzOJDo2bSiuxsTOSBzdXx0aIUgkPAzpWdA/b7oySOqK1ykh
         LP3NsA6vacuQkdY7dlYpiYd70GNTKmFIJOVxb4guhKrBsr6nCOEretUv+n5spgHA6Bfx
         OF5yRpKuEo/TxcnhHwUO2fjoYWw436zs3wHmKAdfMt0t4GUtWBZX6AVICPgCPuCvWljw
         6Xug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7nLB0Zeb5lwRxxg4uutHdC1hXI0lpZf22Utas+BEjE=;
        fh=2xvZroOL8VtrGx2SNkrEVO//5Nh/2s3eQO7sYNV0Dpw=;
        b=aFRi7wMgedN6S6geXLAP2vaZ7IZfOcQUtCDk/HBq6T3ouFa0dZeyoYGVAmvq+364v6
         KhQ6AwQKD7XT3SJTvnOvsQO8cHSB7nAd3jDdt4b0AfXDy0cVRZY3sX/rZkdJQAUDhwTB
         N/CAS9Vz0h3qBEnfeUw80i0KEVlx9z3us7B8hIjY9OJdoLsaZvAg7VBSEw3JFyJpShY5
         YJQizrHnwolx15Lz5i9gz/0ZHjVDYaabcwT+Id37uFQYpZ8q0WMc9ewcAevkH6RDF0+H
         w97S5vfk0TKIDsgW3OWTbFlrm8UqmBNRgUiVozGxDDNeayeG1/r2XbIhOagR6ICPC4jy
         RKvQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775772651; x=1776377451; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7nLB0Zeb5lwRxxg4uutHdC1hXI0lpZf22Utas+BEjE=;
        b=Ipy9MQZ+Qm9Flg5X7PlIjbimUtlqO7r19ssDc8WTWymTH2asxnar76IhIV4DQ/Y9yj
         RNbdXpODKaYAMZ5umDlHCD5tbSuo8elTrkhPbYxBxOjFUX52nUtirzEIgydLZeKilOIB
         RAoKpSgQmfT5pLbPiAgs+nhmbW7ITccztuI6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772651; x=1776377451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7nLB0Zeb5lwRxxg4uutHdC1hXI0lpZf22Utas+BEjE=;
        b=AYVVqMKvUP57Q+DjZO2vFWmyuuaKaIzS7r3pXiHgwX2gcsrHxQZcTRtT3JrJj04CV7
         jyD8tbK57E/gJW6e0m7YxoCH6+OqUTafs58Pprr8xC/gTlOpJfnDB2nebl8fhKf+GnSr
         oC6mbVurFS+Sjv+NoeAedrpFagSIIXqTiSjlOwxPkcAWTBPkMrRdTtcckGz42NyDKQ6L
         6CEsvwqPlclM8VVDtS/ZxFewLGoTGVrooxQm4INhXsTD/pEtb6ba4ucWft2ju7W0k874
         QcL/UmaKHFUaIjiAwKM6Ii7XNPnXflfpbvqUOIdJcsfsbpsh0p2PGQS+u9BMeYdZ74TW
         MiLA==
X-Forwarded-Encrypted: i=1; AJvYcCUJbf4W4hMNyyRsjOcEdaq8E6iKemz+RKtb+2Y/ISqN86BvBxpS0PmpLVMODgDnNg27DUsozg==@lists.linux.dev
X-Gm-Message-State: AOJu0YziR0eFQ5QQ3ZNqioR92h4MANgf+ejOPduYXrHGRdfk96YzfExz
	rkrROVCtsRItZnh5M4KaKAjuGtSWE+Awkb7Q9kGANbpjTuGJ3LM9uBP/LK+bo3LwNdUuagOStff
	1U74ij/Ba75DJuTe/7jGoNfnowpjZfqXMQ/nL9SS/Hw==
X-Gm-Gg: AeBDieuJI7rK720y65CCNuzV6Nx14zHLgqig1A+ATzmyghg+5MJNeqxTtIIF2GbfVSr
	o3PQ6D4Ps6qWah3pgXYMkgPAAAKWEZQGWXkeQLkb5WJW4907jWlCqYzA6OtKeOWAifWyv3eVmaj
	PGbisBl8PoAf4YYZw2gWaO38X/aRmX5Tu3UnzgI2ZQW2icDDk2v3O2UCsvMsPC01wkDUnETI/w5
	h6NZhtLX5RdUp4np0CoItKOdz1h81sZsfSUC7fPfNBOdhD15w7JUTOkPWO5uo0BXcxnJ6+mrTHL
	9ptfbjk7koxwPPjbMlrwmv9WRmR11unNhpvl0gFbQvzJz+AnuIPsVuKB4fSaTPyWFo691Wvvx8E
	nSSTFAPMzBfCGkhbTO6a3Llw9WJ4kI69ts6yWmk/o0daVsDvhv3HDKJ6UtPhz+/o=
X-Received: by 2002:a05:690c:48c8:b0:7a2:a8dd:1660 with SMTP id
 00721157ae682-7af72924107mr8482167b3.54.1775772651068; Thu, 09 Apr 2026
 15:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca> <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca> <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
 <20260409151559.GR2551565@ziepe.ca>
In-Reply-To: <20260409151559.GR2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Thu, 9 Apr 2026 15:10:40 -0700
X-Gm-Features: AQROBzCfblFwr01-zmTarnevR0J0ekwUJWkBIPKJHL8xbcIaYrBhFucdllmVowE
Message-ID: <CAAJpGJTTBxSmivhC0=LNYcO37YGnKWFGREbSEq0dVbzt9s_-pA@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 8:16=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 06:40:05PM -0700, Sina Hassani wrote:
> > On Mon, Apr 6, 2026 at 6:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > > > On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > > >
> > > > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > > > >
> > > > > > io_pagetable *iopt, unsigned long start,
> > > > > >                 unmapped_bytes +=3D area_last - area_first + 1;
> > > > > >
> > > > > >                 down_write(&iopt->iova_rwsem);
> > > > > > +
> > > > > > +               /* Do not reconsider things already unmapped in=
 case of
> > > > > > +                * concurrent allocation */
> > > > > > +               start =3D area_last + 1;
> > > > >
> > > > > area_last can be ULONG_MAX so this literally overflows to 0. It i=
s why
> > > > > I formed the suggestion I gave as I did
> > > > >
> > > > Yes, in which case the  if (start < area_last) that follows will ca=
tch
> > > > it. Are you suggesting I compare against ULONG_MAX instead?
> > >
> > > iommufd does not have any overflows to 0 and rely on it tricks like
> > > this. You should just compare to the existing iteration last
> > >
> > Just to confirm that I understand correctly, like this?
> >
> > +               if (area_last >=3D last) {
> > +                       break;
> > +.              } else {
> > +.                      start =3D area_last + 1;
> > +               }
>
> Yeah that looks Ok
Sounds good, sent you the v3
>
> Jason
