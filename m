Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50532BF41
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118188; cv=pass; b=bRdxAgdkTsburW4+MqOqx5+PNCZNnAXU9LWFx36vVa2tHRCSbWi9t07a14FSp7EE44GS+dA8CGP6gJL8ewtOD5ieYbO8kAZksWmZV9sO8k+MIdNT/3B9s0lPa+IjzcZKppODpQA6IyT4WKfWs3Tp5Fa0Sh6/fWlOynCGA4XlTfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118188; c=relaxed/simple;
	bh=ieW780M6xxJCMBWPwe2Wo6G767M73YI/jsW5RA6v7tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azCIFyrenkuZ9lcOaHR7s+0SH8HGvoOZPSWKoOEFsKwAZodZkPKB/5QZZi4y7JFeYijUGr5Z5mMmCEs49a058EAJX1g0Pyv0BxfS8Vqd5+/sxWSbw3V8J1oMB3Cu9Ks+zw0Nkj+cTyAZINWUOV9wUc8Vk547j7jFFVm6Ewo60pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SDjI2Gby; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SDjI2Gby"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa68cf03bfso7739747e87.0
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 12:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781118185; cv=none;
        d=google.com; s=arc-20240605;
        b=PqDaF8R9eqK+j8vp7qGDq2Tk2SnaBIK2V9HsYeYIYZ/CpYmeXLZnnQ/R/Erf9mzASJ
         q6hmxb0Dyiu489qDDvodiYWuo8dxgd0N/HfL9J1Krgww021/iZhrJGcXQ8bDafi6hWZa
         Fwq7Pg9xLO9Yef65/9E0hBGG/NngrUS/kUAgDdsZvHxMVdhqepipOT1dyis70rd5I7rh
         +pnXJCEI1wn/pxcghoYamRBntby7j/qgBuNnXx1plKn4UZWYevMkQ7NshkdcX54dQet2
         LsWwxz42c8fD3tD5b6gyA0mpu0vab3w3uUKyLLD0u8OHSvp6pCLbUCCYK3D+KKVgthcU
         T1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aUXpPgzCrGF8iLPRq4NB5gtEtNYbqOaVXfoC6RA//PY=;
        fh=NeID/3nrR6jTW4ZjmBQb7Fbn/9cE3UQIVFGRQpfyw9g=;
        b=hA3FkgRs/cuCHKuV04hv8A/CktHoXQ69JZPnglyJKQVrbhN3k4//BC5nIImjJ/BPzf
         Bgsg8utyOeZnEXD+hiP6yC7ExfEZoj2BhH5qCwqH7Gf2znLH5mwg0CpPrdTOFUMud+Ex
         gmW9MtdG28WjVAnrU/hZZoHpNp68JaBqKPXkqZQWFvh2vuROyEeSfajTymQf9XwS520d
         JsQqC2y9qs5bJi7TWupJJwlEOfmWQPV7MbqqaLu/iB6RV3y1bAA8A6A3yMEOyvsozP3a
         eauxpO3VuPGI1FwtGyFfO+n1u1vY4J2WxqwGsUD0iCiJJevUBAtm63ws/4J26g1P5zlc
         O2UA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781118185; x=1781722985; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUXpPgzCrGF8iLPRq4NB5gtEtNYbqOaVXfoC6RA//PY=;
        b=SDjI2GbyNGnX4MzFUvjdSu6rie3vALLfu1wSHxbD/BgFXkZCAFl+BoTG29e3vkclXh
         oZVz6Iu85vAeOfdtlcwu2iOwHGA1Zd+dGgFbzPhYKCAbtARFDTBnl0B0kaAmcQfzVA07
         nAwvjAbcxiWAdqIINE+uFeO1jZHrESR5aCM2IhRtIGPAxtE7XB763IWztutj100u8TnD
         nZ59RY5s+tt0FoBVyDs5efd4TYKcVEOAOgVPQ81uKIHcV4E5W++jj9l/WwWa87xu1zA0
         DPsiS78p8rPDHL0hAJD5VGCcu9U6kdmbvC/ezvYuuLo0PDd9gLk31cZfz9ct8bdWwwBI
         eewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781118185; x=1781722985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUXpPgzCrGF8iLPRq4NB5gtEtNYbqOaVXfoC6RA//PY=;
        b=lpb/raDL71W2q1dVlqVASVri3k7O6V3gNRhxigg6j4iJ+UiZAwuRJ0YhOzj41x4UDA
         T5/zDklRclDw/o5xR7w/fSPyTZSiydq91Z5ng+I07GQzU+SkCeRCajlhS5mWhE9wyJDa
         +LOTZA/2r2DahRSFurpgW8mYPZy5EbslR4DwR0oQ1gdiiv0mn0pMnXCZwPDELNVprfog
         GIdG1jQ7Re5yNySI3rVUjo2owoHacic2M460mK6Sp2bOIALyy7S5K2yxXoux0KFDNi1B
         BIkl3BsPe1RW5cJ9Sk+gMKyfpdRLV9VpxqFyNRYL/rya/QslYnlCcsi02fT5mOwGc+yJ
         nKKw==
X-Forwarded-Encrypted: i=1; AFNElJ/b2CDQbmph5Anwq8hKFpG8fLaz73+wFP/z7/93jzSv2o+Ud5ZFQqZvaNLLcTsCon15IZWLhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkVF8GCdhTX2B5nPIUNlTXuBqYlHWRSFSw3nJFnJWBJRgGFsiH
	XNNJ+1AuOuBYoOct4LM1rgjn+1/8gfgp+Clj5hCmkoEncVPYvHmc5adUlMuMOEugU2prQ3jifUx
	5UCtEmLSrd/lftBF7QojNU8RHMMqGNFvJWvaKPvTH9w==
X-Gm-Gg: Acq92OGTy3OfU+7PBwct4oIjwLpaF3rUq1l4j9QxrVovtYWsP4DOg48dKOi/YRCjJi2
	szt+Cq2XFV92Xk/8uJEc0UofLOxFeJxg9U61ehwNm8GOkhmzjs6p1rTp41oTRDy25XIMXTMcaLG
	K3gpRyIkXLZvxgcw2xRt0sWJqj0xuhHxDUNSSCxMWXbfiJIg5uN4kkZE9TcFu3E+pzkCcnk6+TM
	GMUAKXMAfIjv8JRTMriAksUt+nevUlngmTG4tV4F4q6/YTe5mKNLGEC7QBR6mlALZg2tGi78J4R
	Cslf74xy0QtNve/I
X-Received: by 2002:a05:6512:3193:b0:5aa:6c05:f0e with SMTP id
 2adb3069b0e04-5acf680fbf2mr2990127e87.7.1781118184883; Wed, 10 Jun 2026
 12:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610002351.1672863.5f5d62d5e4be.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
 <20260610163750.GP2764304@ziepe.ca>
In-Reply-To: <20260610163750.GP2764304@ziepe.ca>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Wed, 10 Jun 2026 15:02:53 -0400
X-Gm-Features: AVVi8CcJET_qZy5oebdGiLOxwg3BQsvkHSiyHzpoCh4YeZ1vsbmb0B2N1bdIWVQ
Message-ID: <CAE+C+DazFYXJYsgzv5yGyy3kky0y-bQdP6_u3v4SVZ2BAm54rA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/iommufd: avoid selftest dirty bitmap size wrap
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "open list:IOMMUFD" <iommu@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 12:37=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jun 10, 2026 at 12:23:52AM +0000, Samuel Moelius wrote:
>
> > @@ -1705,6 +1707,13 @@ static int iommufd_test_dirty(struct iommufd_ucm=
d *ucmd, unsigned int mockpt_id,
> >               goto out_put;
> >       }
> >
> > +     if (check_mul_overflow((unsigned long)SZ_16M, page_size, &max_len=
gth))
> > +             max_length =3D ULONG_MAX;
>
> You should never have a cast in a check_.._overflow like this.
>
> Also just fail, something is really wrong if page size is so large
> this doesn't succeed.

I am getting ready to travel and I will address this when I return in
about two weeks. Thank you for understanding.
