Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5543E024F
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845993; cv=pass; b=HGPc82sbg5UrcsIJW9877yLBAguaM87Na8IUFEdk8dNxnB3LBmTpcLMHFsn6w9ijzYEK88rVvEILMB6vmWr6lt6WzfE44Ifz7OAFe7ugtB/FxKcOWteEeImjdoO4Mw0+vN2R0V4/UHXed21vjihpXcoRKc0s80YJSI8YuAJtGWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845993; c=relaxed/simple;
	bh=bjLxVnOZzU/qm7UB5DlwY9dDfszNtgL7RNt+HQuKZ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwskB0DKf2MBXGuA4F+r/6NDgfqvknzHFp8zarzhqAqkdVzDXOv/6xT2w8GIVSo9L6VOQ9zv3YMaeO4EufKlWsIfevvxF9UjIg83MVRGqs+rIyxPYlcvLeOGUtXMNWi7nbClc3iyT82RM6HU0fyPlUe0T/oKTNHhMOgj2GfmVlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=B0MSVteD; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="B0MSVteD"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a46260385so27617467b3.3
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 11:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775845991; cv=none;
        d=google.com; s=arc-20240605;
        b=EEBV1yurB8c4MKsQD/l0G45KC4jpHJkXfZmh3wgXOFoak33a7zGrx5iRc+PF3419s4
         FVj8L0S2RtwKu1btj03rNABPCGchzs1hbhcI6xD4wAqze8qVTWqL8DGYwprteRD0CLaO
         Oxhkg5w2iDERigzF1XLEPwvvSlRKa1TUTlmr9vXb4FN5Bkp+3jhrbHxuP4bi095Zzeq0
         0aWFwwG4x1iJpOw//Ai1cIONjcQF9YjejZqWdhk9tZ1Kdx08YUwapa0AjAHhfDyBfQBO
         z3CQA3UMpy4GWieEtNfr2nN4Lw17Y5Kwl8TGzQEiVmAO80NP1ikCPUoKjUx7tZv2NlVz
         SgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmZVgx4du5Y8gMF1xPyxrDio1rDedaQrWT161jIwWcU=;
        fh=IfZxgRTT1JWNeycjSwYBJ0Wj/Aw4XiaEaFzW/d9jb8k=;
        b=BfNrgaCjbMHEK9Sj4Pv6kzQZjfaauclF5Ysx7yXrk8zsd4uZrfuyBoRL+ux3/s1kFF
         uXfM14hVVSIFkxIYD7MF9PD+VQfBTifjm0xf5UyHQk4FyDjdlmefq2E6XMS5TZay5aug
         qoDll9n6Gb8GGKg9Vpx7iI6z/fdAiQQ5QcWkJDn6ovP8Fi8TDqOrmfKkssnZWkUUfWIM
         VqjKhH3f0/91nfLK9WgZeE9QnZTK4ZKUlpFNw2jJQqKLztK4GHizLmoOKt5VqThYK+Ps
         L1e7PJmcrHb0nNJUdoX0BIw8zipBH57cqqCID/OYXZcEE20JeiWJS5PB5HE4veQKHpdQ
         gEBg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775845991; x=1776450791; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmZVgx4du5Y8gMF1xPyxrDio1rDedaQrWT161jIwWcU=;
        b=B0MSVteDAz+dUWCCMdZItjpzPmoneubzTVhd6kWFBsjFwLsFyhffKuuI31Oi8uGk2H
         CnU+4DFKDvUUSL40m+/HDG7pAtIXvZ6/GART/2fjDvI49HjdiGjkzyxqaRNck6nbF9i0
         nxzR1sw2ujJ0U9Bq0VI5s+bxuVSJWhbEmEQMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845991; x=1776450791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmZVgx4du5Y8gMF1xPyxrDio1rDedaQrWT161jIwWcU=;
        b=h1ymYWwe82TlDrL/DOaxibiH6L8o8NzWAyh25PwR7XeJzrOziagZojKbSWVFuVrGdU
         3U03FVD3HOs+wmUVgIyFZ/p4VnAmL+rQ8CGmxPZBNW+zFfakETfiUWqgP+frWnYC206R
         YgiLRuLuMOJGFgAoZYCCh7vOc5DvN0gfAVGGqaxpZMoerRxRsZiIpfCVhIrxGME/+kKn
         NEoIceLm7XXs87LR6BuokvICoqOzod/mrYGwwiwnA+Jee+RffG09ewEkWdR5Hh+urUYD
         xg/VZzFlXI3M7+4OMFpGERWTcJZKXp8rYmTOyc1N6yIrTs2OeOfoCd+7F91ZC9ho+Ykm
         SL4w==
X-Forwarded-Encrypted: i=1; AJvYcCXLqkEFlvb+FP/0Oznbw7F7eywoPwEVjxJ+VJt0C8vykAtKGtIOSg0y36YLNN3GRrtz7aKLAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6BaytG8jXzPRH4yqy5jSRL+eLa0st+16IvIVaJdXDRGWv2v4U
	iyjW/m2/90gNzwhBz7Aade93BDrZkoTCVdDkBEBc04dt7sUsMRgZ97AmFpl4w8Wdc+4SFziS/YH
	kL/5cNpQsfz1mFctKodAPOp8AdptCl8sFBsWAlbBFMg==
X-Gm-Gg: AeBDieuP31PX4Evd7PpyVX5Y/ZPih4od5XWXEPHjtJZQdlXM9oj+ljFraVO19BsVGDs
	hul7yOy0188u9Q5VFWorSJLknvqytlzL05MeDgwgj92/JxR/5h+3SG3FCTGM+ENlnuxRTIr6S7S
	mRPabK1dwStwwIOmXad4Q063I/b2mG0+WHE8fdG9mp0Q4LX2WFGwUcinTGI7NiKC/1cgSPa1t7s
	MY4q0kxJbnqvsMyQgPFcKxj0qk3NT6xG18i7VCuwF/8TQ7BRWNIqMCovbJBEqLtUqKQHOU0fY/M
	geSrVLlmmAhvXGe3pBWd8VhrqblasVXqKkCGxDqvnt+lr8a1raDT/n3RFJl24j2zD6mR7Fmc07b
	RWm5DrrvbkfgLOdf9o1nMFR3yyK11Qhvb3nyxn7ekSFK/b0SNlEbvEQU4wrc5vjFERX8/MY4KUQ
	==
X-Received: by 2002:a05:690c:dd4:b0:79b:dd37:69b4 with SMTP id
 00721157ae682-7af6f8094ddmr45213367b3.13.1775845991067; Fri, 10 Apr 2026
 11:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJQ4VyeaZyVwh0Y-tanUCAqiY8v=rmiGr8cp_XmFph=SGQ@mail.gmail.com>
 <BL1PR11MB52718837B34DB23713CEC2978C592@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB52718837B34DB23713CEC2978C592@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Sina Hassani <sina@openai.com>
Date: Fri, 10 Apr 2026 11:33:00 -0700
X-Gm-Features: AQROBzCwnHPksNb0jtEzoTvVsAsoVyPLtOpmO6_Mi6ZtDuZiNJaDZ1zSwIh3Rkg
Message-ID: <CAAJpGJTeCs8x52ruotE1bLnmY1HGnaBeqcHeGKCfUt25NWN2UA@mail.gmail.com>
Subject: Re: [PATCH v3] Fixes a race in iopt_unmap_iova_range
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aaron Wisner <awiz@openai.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 8:28=E2=80=AFPM Tian, Kevin <kevin.tian@intel.com> w=
rote:
>
> > From: Sina Hassani <sina@openai.com>
> > Sent: Friday, April 10, 2026 6:10 AM
> >
> > Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the
> > loop
> > body when getting to the more expensive unmap operations. This is fine =
on
> > its own except the loop condition is based on the first area that match=
es
> > the unmap address range. If a concurrent call to map picks an area that=
 was
> > unmapped in the previous iterations, this loop will try to mistakenly u=
nmap
> > them.
> >
> > How to reproduce: I was able to reproduce this by having one userspace
> > thread mapping buffers and passing them to another thread that unmaps
> > them. The problem easily shows up as ebusy errors if you use single pag=
e
> > mappings.
> >
> > The fix: A simple fix that I implemented here is to advance the start
> > pointer after we unmap an area. That way we are only looking at the
> > IOVA range that is mapped and hence guaranteed to not have any overlaps
> > in each iteration.
> >
> > Test: I tested this against the repro mentioned above and it works fine=
.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sina Hassani <sina@openai.com>
> > ---
> >  drivers/iommu/iommufd/io_pagetable.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iommu/iommufd/io_pagetable.c
> > b/drivers/iommu/iommufd/io_pagetable.c
> > index ee003bb2f647..e306871de06d 100644
> > --- a/drivers/iommu/iommufd/io_pagetable.c
> > +++ b/drivers/iommu/iommufd/io_pagetable.c
> > @@ -814,6 +814,14 @@ static int iopt_unmap_iova_range(struct
> > io_pagetable *iopt, unsigned long start,
> >                 unmapped_bytes +=3D area_last - area_first + 1;
> >
> >                 down_write(&iopt->iova_rwsem);
> > +
> > +               /* Do not reconsider things already unmapped in case of
> > +                * concurrent allocation */
> > +               if (area_last >=3D last) {
> > +                       break;
> > +               } else {
> > +                       start =3D area_last + 1;
> > +               }
> >         }
>
> this could simply be:
>
>         if (area_last >=3D last)
>                 break;
>         start =3D area_last + 1;
done
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
