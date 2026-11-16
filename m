Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794828779;
	b=RKwBtikzNoHJC46Yd2fNp5hlsj5V8SWE6pDIhhhU15+aRnZ4EDwrhLV32l0PK/e/M9Qj
	 CTKXjWUwpdm8YU2z/WL5hJoAN2fKZbzn7txvS5m+F/hZZAb6DHio7Axj9pXnVlmaWnMWr
	 B0GUWR38rcYQHUuBVM1+2UknM3tYiVhRwgOWP4qxVq4a4/CqKWzJmXRqGhykejh5bOJjg
	 +ICqRMEzF5tp4zcxu7B/YRYde27hDa3lBm7i50YOrb5n1sqFGixt8onMeGm2ix8StRZO0
	 GehAB5oDeElkcZjrDLDLm6bvIaQ185iZHFlhd+N/Xqz3a4xGbAdDuK5theQqsSwIvOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WkFbdpqrAcDUqj+SkzGRxAQW493jh+pNn7c7c7yEn/k=;
	b=2Yttak7Y0JQQ6vOP4hmhw6NdVA/5Q2Uwgw80qz18eGP6NOJ9waEjU4FC2dYpNOxjfm7q
	 xHlqH9MCIJyiKBCuT5t5z2V1OARz427Q7okZ8oz1R9Qs4racPj1sMJYQoGNgZhYp0zS7J
	 qz1P88MSwfO4blLjIli4WF4dYstY/b4jYjokKxaoIQwc4mCDQWjfPtESt3qqpWEBPIlgb
	 1rT/bziwjvwMhBF88YK1SL2ul4+tLqjxCIH31JvTXX3dE/H6dSFljo5qnbSz5Jznqy4KP
	 w3I5U49eJGNwllLwhWfeXehqOoKfZlxgr+UpHPcSYeIzgcHhjjoiUh/cSZ9C/BYgHSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhMdnTOf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA6606A31C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CEA6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhMdnTOf
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c0bd676eeso2449427d50.3
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 03:32:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794828778; cv=none;
        d=google.com; s=arc-20260327;
        b=JZ95w+pCP8sc2wLTeFgTQeQWkKZcb4kcVQ+sPkazPLyDUATybBQz5WhsNF1CbeGazu
         mRzkaSka8uwGqpQD0DIvfkM5yDdZV/iLuQGom7w23j8Lh2AsAYeXJq+tocoELMe1Fcm7
         tMPbt/bHoP4ELdKhixQ2DYnx1+Z30nnnUALf0be3bD02QFpSsdevOMhYH8eKTrAaxXuO
         z30cwE7QpY547ekkKqHVwsf9bxdclp5XvIVhII/Gon6I/oSJvHjp6gF52OH5zsj3nFcl
         i0g5/S1cYpn3pZnHCLE7ntLq8IEmLi1OfAgP7Xr21OLPUWRZQjkrp8F0eTXJU+K+JQdr
         rmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WkFbdpqrAcDUqj+SkzGRxAQW493jh+pNn7c7c7yEn/k=;
        fh=IvMr26hFzL03kCoAdY1qCT4dNfmhm1ZrhqfaIdVNr7o=;
        b=Tq0CzQSEa+IJp6ulZ2GetGcCGqMKKdVZchQ5iYu2k9B41djA3xbAvQBnyIzWrTfop8
         2vGMvXlvMysFoXFg8yCMWuwoVcDdq0OpV0jAXEsTwzPD3xhXHc8MR1xsfoiFCbvueNCj
         PqFuPczvo3O8ZlKAGhGtuYjOcu/aI3RyMluUQvWWGmAq3+PSjPNI7ajCuBGrofW3hegn
         5rXg2luVeRlfV1I1wf90r/ZYk5+vWX0uPpulaN7vQUVrT2kdhKu9ZRh1RktDsvJ6ljwR
         qoYkY1ygN3FA7G6+G+y6TAgKNsOxWCFiclIjFadREoBD8aH0FaG5ykxrl6s1pYUvyAc1
         ji8Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794828778; x=1795433578; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WkFbdpqrAcDUqj+SkzGRxAQW493jh+pNn7c7c7yEn/k=;
        b=DhMdnTOfzovEtsSWOCe1AJf+Yo9ruNq6frHa2OW8d/FzFi3ZgHmUAiv6xsQrRpdiZ3
         mNGhFogdzLPmnNZg5VhHcKNZTigRFVo6SYFaunFWV7PkcvoNt3pcC4mGnpHTZpumKzZV
         2mUaEBB8hPl0/n2nwgMJrVEoirbG/P8C0oyXO6joXT32UaShShIU2av/q5vpgEXrIYDL
         oev/qQm8YEDvMxNURUlkvJqQlFsHpcmXCYVMi9Pj/DMqzlL9+sWYn39qZsHevg1jR4lu
         qZeH4d2qYwrcaiO/Ut2OgEcKhGEOwOq2dSbuXiGr2qno4I06d0itanGCVh2Z5PWZ/xP5
         iHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794828778; x=1795433578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkFbdpqrAcDUqj+SkzGRxAQW493jh+pNn7c7c7yEn/k=;
        b=eUgcuqHzk/7oeXZCwU3M5RnFR2wEJfPjGIJMJnTMaWTgPP9XZDECfIjnATmVY8RxSv
         J3oQhQNbrG8ileOghUIOMj0TSVMk9RmVkloVlNmokUzIvvAcEiETjQC54Qjj6Iw2EX/V
         MpU0BJxomvBe5CtAG7OC3epey4SCIGlZh1sSpw2r91TA85WtTFDzTIrDZPwNTh44kamT
         oOLts4hVsTz8YK48mCS/ISh78XPcmQvQ5HOb2JFOsiIAca5pY9x0iRI3nq6o9TvmHab0
         IrZpm3NbdWbeDCk+C7mPGbskOGjZDWoqjKyMcQC94tWkgN1A24wiXxy7aFubpzFJ2oVe
         zMRw==
X-Forwarded-Encrypted: i=1; AL+hErEbop2VtuJi/6wUCqHDEHirHz61VDOZE+dI2dI3RcglVnaVsfIV3+was0DcNTLP07qh7FZPwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8KltcWczrXu9LVLf6GMGKNU9M2AuKEFQa59A51G6JL5Xl8mS2/
	Vb/NJcHdl7tM5dkeUl4+hPyY31ouPH4PfeE1dJ9cgFgc9/12D++hGoILoRuJyOR/5dGqe89+8Va
	Q1NJ6KaWGp8MbpKTYBmNKpQUPsPqbhmg=
X-Gm-Gg: AZFdTZfmtj8uxR1ODM5f7JjR0ZMWIN01X5AWy856BRVhpKTRgTgCXxpLRUzt3kU3QxT
	BhgpdDi2xcoscNJcrTJZlZCoPEseG9C7wKbCpsIJRfBrrP8a1gr24SZp1Ohg2wwRUOaAxpwPwgu
	QQAfkev+4H0P30FXD55e20InaGACt2wJDIYH11I1C2KaXMcrpd4HsRVC+g/szyuqZvi5b2OreUj
	KkY2VWMFeMuk4NlfcocGbi1mR3XkbN88BfI8Za9mn6OyfV4Qs7POEgmYic3rqael1jbQK/QkAck
	ufoEjfvLX9DRHvflpL8DWwB7FarQAPktjwBKmrw7s803VB9uo//1rNpDwwpbS9KnAqJtCnjHRur
	IGCIDK5nDg1iCuFok5DXX6wbuEKQjElzzcvhc9LsOB8OJpbXYhooohPfZ/FbcSmcAi2uC8BjBha
	PefOXwxikqIrRHBcCXBOrbtCqjjQ==
X-Received: by 2002:a05:690e:400b:b0:675:5e46:36cc with SMTP id
 956f58d0204a3-67d897d9483mr6388130d50.82.1794828777994; Mon, 16 Nov 2026
 03:32:57 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261115120534.2331911-2-thnkslprpt@gmail.com> <avrL1hGke3Hux2IM@U-2FWC9VHC-2323.local>
In-Reply-To: <avrL1hGke3Hux2IM@U-2FWC9VHC-2323.local>
From: Avi <thnkslprpt@gmail.com>
Date: Mon, 16 Nov 2026 06:32:21 -0500
X-Gm-Features: AclHuK_VZyh65L9sMYzi5VAiUspj5fkWhpWYhKx4YL3ocShAjw9Rms0HZoeOtmM
Message-ID: <CA+jvY9HtQZtCW7c10gS03DBLshujocvZRZKseAYyZSjFrBy7mQ@mail.gmail.com>
Subject: Re: [PATCH] dma-contiguous: reserve NUMA CMA areas after default
 reservation failure
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think both quite clear, but I don't mind either way ;-)

On Mon, Nov 16, 2026 at 4:24=E2=80=AFAM Feng Tang <feng.tang@linux.alibaba.=
com> wrote:
>
> On Sun, Nov 15, 2026 at 02:05:35PM +0200, Avi Weiss wrote:
> > dma_contiguous_reserve() returns when reserving the default CMA area
> > fails, skipping independently configured NUMA CMA areas that might
> > still be reservable.
> >
> > Register the default area only when its reservation succeeds, then
> > continue with NUMA CMA reservation even if the default area fails.
> >
> > Fixes: 7e6ace2535d0 ("dma-contiguous: add kconfig option to setup numa =
cma area if not configured explicitly")
> > Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> > ---
> >  kernel/dma/contiguous.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 90937dc7c627..0b6500bb6cd9 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -287,8 +287,6 @@ void __init dma_contiguous_reserve(phys_addr_t limi=
t)
> >                                                 selected_limit,
> >                                                 &dma_contiguous_default=
_area,
> >                                                 fixed);
> > -             if (ret)
> > -                     return;
> >
> >               /*
> >                * We need to insert the new area in our list to avoid
> > @@ -305,9 +303,11 @@ void __init dma_contiguous_reserve(phys_addr_t lim=
it)
> >                * but we also need to insert it in our list to avoid
> >                * having a default area but an empty list.
> >                */
> > -             ret =3D dma_contiguous_insert_area(dma_contiguous_default=
_area);
> > -             if (ret)
> > -                     pr_warn("Couldn't queue default CMA region for he=
ap creation.");
> > +             if (!ret) {
> > +                     ret =3D dma_contiguous_insert_area(dma_contiguous=
_default_area);
> > +                     if (ret)
> > +                             pr_warn("Couldn't queue default CMA regio=
n for heap creation.");
> > +             }
>
> Thanks for the fix!
>
> Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
>
> one nitpick is, is the below code more readable? (I'm OK with
> your patch as is):
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 90937dc7c627..3daa9ae3ab7d 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -288,7 +288,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>                                                   &dma_contiguous_default=
_area,
>                                                   fixed);
>                 if (ret)
> -                       return;
> +                       goto numa_resv;
>
>                 /*
>                  * We need to insert the new area in our list to avoid
> @@ -310,6 +310,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>                         pr_warn("Couldn't queue default CMA region for he=
ap creation.");
>         }
>
> +numa_resv:
>         dma_numa_cma_reserve();
>  }
>
