Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA41531EA
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183531; cv=none; b=jRXoC3lXkc+FjUSeQTZk89VH6VXm5JrJZ8yqjJDQivNYSXOsVseMGHS9cQSXDoLNI7ylerKba+zn4bUIZ9hqOZgl8nnAAWGbWU3cG9o6XQHITiv2FMzzKFMze9jstCwuQSCutbhMOul0DT+LX/2EBHsKRdbG4b61wne3tQZhTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183531; c=relaxed/simple;
	bh=5dtmDLd3dalHwVEgcR+tiAH42FjFSBJ+JMILFC1R808=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB27NQqP79hv5BITsueuIXhlGuBD55Ur4wTjBlJofh1owSwurxBBzV+3wYgxTJgs+3FuibCUZLTPpoQ3TZF3sEJ7ukYFjtec7QapHc/LHPo1alBmhPbuDzS2FwPSybmDudqI0Yu0Y0GmqyKM7n4lZ+NzJBVmARzzH+idmmcNOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cfHFgwhw; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cfHFgwhw"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b450320aso4433155ab.3
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729183525; x=1729788325; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/+hKz9Utv8LPO0aGsn01ZA038qHbKiaHK+Sj+rHiIo=;
        b=cfHFgwhwLsey1E31pER3ikH0QF2vkkZsqkD1LvTdx+yuW/YcdvzymHAZhGrGuglMzd
         1RolC2J2JqFQ/C3KyR2VxnQ+kWgfAjclWwuplsrNDpmNUw/ht7HhDqWpoxGqZW/pyc4J
         1aXnxnW2g/6zGxwuoLUuNrnePVmCUzyqHqhY+MkvGzMUs6dIAmO4za3trQsxzLb5ToII
         PUMSlQgO0Q/KS2tHTyHkDmO1f4aX81egp7/chopLX5cnJ1nhTUVcubPojSF3eVmWV+X5
         S1kvz2n0DngEaTWOIAdU05t1s3nDf8AjE0j1n9vR4//p4vG5yI3c53dAloeXgOYs4d2D
         3O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183525; x=1729788325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/+hKz9Utv8LPO0aGsn01ZA038qHbKiaHK+Sj+rHiIo=;
        b=vzYdOCOUSv/CouYnBrGRbDGU4tcKC4TiGvpONT58FZC6BrUQ2w4l+xyyiTJXJbK1hT
         h48xVCnw4YRhVDApZahLqV8D4Xj+hB+223osy7H+1hbW1eBbyJ1eJoDUd4y7e7CEix77
         rI62A2p0wG3vMTNSYjJbCiGPyHdHeOuWqyHiXhQZ8S8oTqRqKfQuTotCoZbv6c60cVYQ
         Kg7zZYIxKzYrXYWCWzrQvu50uirWWTDogcrDnuh7Hlz+/ReTsUIuJRn+HzaODA/ClE2W
         8GQnoIz68gl3ppgseXu1ePIUnYkaFwgRpF5Udm+gdPnUMSiGrHsx6aQfPx2w34/8xmmH
         padQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL/SOm0N3lXDnCuhSQ+tapXiMBwi6lgzD9QFq5vvLAnyGOeKUa2Tf1jn6kFTZcpVBr4lF4/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvVcCt2DIQpCAKD5EIpVlolR9cbMLUl24mw6BJlh9JWJCVCLR+
	lWBMjREREo/VBdXYyG9Kl0nYYbVVSpQkdFvOrW4s0enIvbVQtBT8fOmJGDTbIXtVWJL+Ztao30R
	I839johgytfE/DiJmnJch5alMLKyBA55Q/74ugw==
X-Google-Smtp-Source: AGHT+IEyjFo+SIWSJWyVZBGV5zs/J+99C1GHNHOGAoKVR2hwF/wgFiuTrcZJ9nhmSqqLjMiUKewGgdAueOpzvhLZuL0=
X-Received: by 2002:a05:6e02:1786:b0:3a0:7687:8c2d with SMTP id
 e9e14a558f8ab-3a3dc5030b3mr70463775ab.26.1729183525560; Thu, 17 Oct 2024
 09:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728579958.git.tjeznach@rivosinc.com> <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
 <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
In-Reply-To: <lagj6ljulmfjogrzhfd3jrf5fnngev63q2g3bmvftwfzc3s6mb@gw6oz4yriyjf>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 17 Oct 2024 09:45:14 -0700
Message-ID: <CAH2o1u4BYyHhi3dVcBrB8T2JpXdxStsfYodmOT-6a8KMHAot8w@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On Wed, Oct 16, 2024 at 2:35=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Thu, Oct 10, 2024 at 12:48:05PM -0700, Tomasz Jeznach wrote:
> > +static const struct of_device_id riscv_iommu_of_match[] =3D {
> > +     {.compatible =3D "riscv,iommu",},
>
> nitpick: Unusual indention:
>
> uwe@taurus:~/gsrc/linux$ git grep -l '{.compatible =3D' | wc -l
> 192
> uwe@taurus:~/gsrc/linux$ git grep -l '{ .compatible =3D' | wc -l
> 4197
>
> (Hu, I expected the difference to be bigger than a factor of ~20.)
>
> I'd go for a space before ".compatible" and one after the trailing
> comma.
>
> > +     {},
> > +};
> > +
> > +static struct platform_driver riscv_iommu_platform_driver =3D {
> > +     .probe =3D riscv_iommu_platform_probe,
> > +     .remove_new =3D riscv_iommu_platform_remove,
> > +     .driver =3D {
> > +             .name =3D "riscv,iommu",
> > +             .of_match_table =3D riscv_iommu_of_match,
> > +             .suppress_bind_attrs =3D true,
> > +     },
> > +};
>
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers. Please just drop "_new".
>

Thank you for those comments, they look reasonable.
Can we postpone those changes after v10 is merged into the iommu subsystem =
tree?

> Best regards
> Uwe

Best regards,
- Tomasz
