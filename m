Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206042BC45
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075001; cv=pass; b=hEwLmd4UAi4a6gLbnCXefPjISj/7xtlXiTM4mJX39cybx1EjecMkXe9UulFrBwSHvmKiV0smv0/NKlQNhHxOjlr+QCZ24Ds138bH14BGBlCe41JNvB+Yeg6DOWfPb3ZYFGjrAVvHPQ7eMtJAbL5bAM2Y5URd/YmHVX3l5sA5rnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075001; c=relaxed/simple;
	bh=9x29Aiqdkk6+DDsHq1AqPImugU49YcngRtEsYHX3Of0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwAQnUKZDK87oo+QvIieK06BsFhjVAk+4ZP5eYeijUm+N6UgvbbtmvwpkQUQ37hA17and0JxjxOY70CTVvZGuW/vieS2+p1VN5vdhj4y/0HQmemPbFF4opEn/I9QEKHxdkdN/yTfappsOLszQnyttjg7BtyBpIiEyLsCiZfnGaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=e56zAtGU; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="e56zAtGU"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso1932404e87.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 17:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784074998; cv=none;
        d=google.com; s=arc-20260327;
        b=Umn2gT7RSldBB65hwtvmHNv7DtNWNzJO8DK3RdDfq04q6k8Iy3MZ3yo36XN0VWlDY+
         k7kYFw1Sjx61pb2I+21xkVUL4jESkVqkeOpiAyMq3+/PVomxVsRn+2WPtjAm/WcFnRaH
         zrdf5ZONjqhR/+A4E88z/e7Rz1cujnXDaZYPXzjhKKp1mEcY1aHmw9xhUhs/KxU1HBUv
         FQ30JGjXRhrXzQe9t0arBBW3LP2y0oLjmeYMKpNUo7JvlI8d0aDah6Wx+1p6lzCLuPJb
         CBiiJok2IBzuE/Vp3K93Nk2VUQkzIEgDKaWq1xBhmblFbnr//T04LkjX6oyQ1k+YEw1H
         hcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fGUPMLe6brAlBgqT/7IrDERf5iJZ6QiHCuhrASo2M1s=;
        fh=a1Rp2xqn5J6MK46M0loHr3hzIC/td+nvTKAATc9lqOo=;
        b=ma9kwTIHz9hDch73gywmkcQwhYXv+ksFNjRhCFIXlG7oWLUgaA3oQcxU8ZW8APOAlW
         mpVkBEdQQixZNVi777mLACNdAFk5LnWJXNI6mSNbUMZgr4eylU0LChfmfZWzi7BVHhNr
         b17nX1YPp/fQkPCUFS6jexuHYVJLA481qL1hdYOMRDjbLYcdjUrBhS/LQmqjaazVHsLm
         o+R8pm3biCI1Wid8FZ9HjnmXxWZW9wUuiAe2j/TqsCywP7AD1L1WaoIZV9ILvnClB0Ka
         lO976Cf4AP72/LX3gdefPoEB2Y985eecUffI0z2/lEWGd/cVFsRotyv3oNwsmwx18nwz
         GR0A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1784074998; x=1784679798; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGUPMLe6brAlBgqT/7IrDERf5iJZ6QiHCuhrASo2M1s=;
        b=e56zAtGUGvyuxvef/Ssr0rjUfF4SJre4IItqxWFG+M3Qs3EuLqnRM2wWkCJO5O45MH
         nTxt73MaTxDGVMlTiLbHBIBuRX0jw2GZiLuVOWKN5US8Z7lHwar7Zz2CXr7NzRxkZNnc
         /skF+e3vTcrqAJc8kgCBK3KwBc6aWTrLhG/EZ906x6mFtHJN+wCAWupMdjYFwJAiCuap
         K1um5hmjxGrAO7BSXo46d0GCbafdpDzpjn3cbbeuaEj6+M/loZZ6X7I+Cu/VIgne989E
         l0xeyonkKnBwRSntmq11JmCG25tF28iGaWPgnm5kacc7O/eZlw0UYrNmYJOIFa+rr37T
         Nz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074998; x=1784679798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGUPMLe6brAlBgqT/7IrDERf5iJZ6QiHCuhrASo2M1s=;
        b=eJc1upNl91m5FBBOhI+LEfKHepE4KyTlRFtdJOiZQFWymZv8EjKxMFt6r2xJgjlWo9
         mjxFfg1otXXRjP/yrWAwMl0B3CIbBvezucumPuDnxWL6/wXNUCjyVu74bp5+OE46NZ+o
         t9ZsBDvDxTzJc/uw7cTakYKcDKttFFqJumb5xkTb9/OIKHogn/0rqDm8BBTX7itNhvao
         QrpsE1iUFlrl+5zjcePk/AEGEaze3vz3086l7oIM8Phw69fz5XVUwQsRm4iDGtrHiXng
         dUwTiquDS78yweyhX9uH4yKvISE0YJBUn2Pup5BU8nnT20ICOFK6DUYwJFKaOnfFrnE8
         3AKA==
X-Forwarded-Encrypted: i=1; AHgh+RpRh4P7gK/ZeNfk7meEbmMtjJGi3iQT7WZ20QK6OLtEUKVhutJ7tz/uJchRoFNElSg1itVHTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZLQ4M+z2TkYh98REUFvwNNbKNMG+mNlttm92kjTK4/yFQUFpL
	9AuMa1O9dhMVvQ4mQAqbN6rgmkWRqhCeQQQ1ersjHyYMaWtJw29ITOmcN3CZ7BbwQEyB8DtHPWI
	uv8M5c/A2h+1se+UNjMrGZ6chYwbkvcfvfftlb8EgBQ==
X-Gm-Gg: AfdE7cll7SfogFVmvRpJrhs0gJS/q3xmhOZbTcrkrJmw5OrHPrV7kR4ADFy+LoPk1aL
	RCMcFqdULmt5vDzkIfjXGC+QWGPFImKknh4a74Rf9RsYoFJXWroLgNW8UM0kb/vg+HoJhWaJlBT
	9wqO85ckIPCefxSLH2gISq1CNK/6xSiaMMqXnrIFuTUWL+gLXaxQDfYR1+05dafCeMXjZ8Old8r
	k9fcINlNZBnQg+klbdxUp/NmQzQYx77QtITQEsx1lQStZpg63n6EPXadKEUJIKhVXB42RQ=
X-Received: by 2002:a05:6512:2c86:b0:5b1:5a31:8603 with SMTP id
 2adb3069b0e04-5b15a3187a7mr947081e87.55.1784074998453; Tue, 14 Jul 2026
 17:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260628152331.82122.408afd7b466c.iommufd-test-dirty-bitmap-size-wrap@trailofbits.com>
 <20260713135058.GA3133966@ziepe.ca>
In-Reply-To: <20260713135058.GA3133966@ziepe.ca>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Tue, 14 Jul 2026 20:23:07 -0400
X-Gm-Features: AUfX_mxX7NcX55htyJ9EbIJrdgNiKkH5ivAVHNNljZ24ym1lJEpNC77RdDsUqIU
Message-ID: <CAE+C+DZXff-6ozkTX2HggrubR3Cqhd=EoPXoKA22KeutDjuhbw@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/iommufd: avoid selftest dirty bitmap size wrap
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "open list:IOMMUFD" <iommu@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 9:51=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Sun, Jun 28, 2026 at 03:23:32PM +0000, Samuel Moelius wrote:
> > IOMMU_TEST_OP_DIRTY sizes its temporary dirty bitmap from
> > length / page_size.  Very large selftest ranges can make the
> > DIV_ROUND_UP() additions wrap before allocation, producing a
> > zero-length allocation while the later test_bit() loop still walks the
> > original number of bits.
> >
> > The selftest helper does not need to support unbounded dirty bitmap
> > sizes.  Reject requests whose range cap calculation overflows, or whose
> > range exceeds SZ_16M pages, before converting the value to bitmap
> > allocation and copy sizes.
>
> I suggested to limit either the length or the kvzalloc to around 16M
> as a practical limit
>
> > @@ -1686,6 +1687,8 @@ static int iommufd_test_dirty(struct iommufd_ucmd=
 *ucmd, unsigned int mockpt_id,
> >                             u32 flags)
> >  {
> >       unsigned long i, max;
> > +     unsigned long max_pages =3D SZ_16M;
> > +     unsigned long max_length;
> >       struct iommu_test_cmd *cmd =3D ucmd->cmd;
> >       struct iommufd_hw_pagetable *hwpt;
> >       struct mock_iommu_domain *mock;
> > @@ -1705,6 +1708,15 @@ static int iommufd_test_dirty(struct iommufd_ucm=
d *ucmd, unsigned int mockpt_id,
> >               goto out_put;
> >       }
> >
> > +     if (check_mul_overflow(max_pages, page_size, &max_length)) {
> > +             rc =3D -EOVERFLOW;
> > +             goto out_put;
> > +     }
> > +     if (length > max_length) {
> > +             rc =3D -EOVERFLOW;
> > +             goto out_put;
> > +     }
>
> This is some huge number, so big that this breaks the logic on 32 bits.
>
> It just needs this:
>
> +       max =3D length / page_size;
> +       if (max > SZ_16M * BITS_PER_BYTE)
> +               return -EOVERFLOW;
>
> At the top where it validates the arguments.
>
> I revised this patch and merged it.

Thank you, Jason.
