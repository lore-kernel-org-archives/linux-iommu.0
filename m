Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A573CCFAF
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203106; cv=none; b=tFjeVOJRzQRrNANzLjqB8AnvyiVPI7VqwtTfm1UesFRHuPDz6VcEX/GY22KwagvUXWTDxL/KT9Pdrei4WslDWbgrg0vs4wUoMvWxliehqNvi9HOJ4+9+KqdpNYi1N53pnzuRbNv3vrGrGyuBMDrgHmVve81DxgbvRi2yUG3DRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203106; c=relaxed/simple;
	bh=ALu77l9JWVXGe1A3hUFppTa6Pdqm7Gq1p7JR3rm89DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogaz4MT4k50mOOF2jzMX8oR8yISvUGFJam5YL+ccwWHKokDu+/iXuj+E3ZgWzhFAEUQxJ9rn0CO48RyNYZ3lp6JQD+t3Jz92xfGG55v7jWvfzueVwtpleT6cHjSX1SWp0TFY+SizHxwL9HTlaPpF92SCg3Rx/yG084NvTKklv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJdh5WUl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJdh5WUl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso35975825e9.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782203103; x=1782807903; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqWt0bI44jas3c/HR//JGgX6WMjaPFSRIYH+iY3eOF4=;
        b=rJdh5WUldjkGifGjcpB63MBIdDX01sjfaErwopkUszQONcTJV2OyMuojRJIsKrP9HY
         vtTIOZwpoUWaKRIAyQh16D4TDLWLcnUBqzBsfaJfL9kTXypcQ63RNKEUy78ZLSloGq4B
         xmkWUJUiyo1q/cb0yrm4arasWzrSM5AE0HigZdSw7htGyNHln+2cuqoXB37fmIAxEzKb
         mHFS1dQccRyOiSoJr+I0u9oJWqyoJDnY1k8dP9RhYDwpMenaCvunjbJFpnqMAwUAfSFn
         Ylm7mbaStr5/pFNwsUH4cJg6MEU+6mny+pDYyItgfq8TVL893NIVRrPfgm3Yt53gork5
         gPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782203103; x=1782807903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqWt0bI44jas3c/HR//JGgX6WMjaPFSRIYH+iY3eOF4=;
        b=Pb6ZV09CU7nt2AelT72GDFYSC5+ILWCMjtGu0WTpoFnnFwiC1b9r0h4anyrwABvKID
         1ORM/C8P+OHT42TnmWwqpsfucVwiFWJ//Ap/F5v8ys/ufI+Rlx9K+NlIzQUhXML+GuNK
         EZ4AGPCQd4JDRyo7N+79hqTokMWE4K+yvYKfODZ6sMatG4kOGZ19OnKqQjRoNCvlXhFy
         e1gPhEbNcX4OO9ZGxGnE+qrhkaIPNRyfKLdT7p0PSffroBggRKZbDqTfFLhV5A/XBbnu
         5lHLeNV+EC0kJfKM7HTZNqH7qnsgM239sQ6BfrRH+hhKFNB0VxU468R7Z9HDGlLt1vFN
         453g==
X-Forwarded-Encrypted: i=1; AFNElJ/MlbXQ1mGU6VUu0IpnsQ5j/FWIRS2Mx6m4pVuG6REvazmblW7bqKwq40d55PpYFoXqpQm3BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaozoRo3Zj3oITz9Kl24Rqwv+7v4DQWGgFBJBh81hnM5D80ddK
	ajsF+vyRjA2gW68ZUT6rXrPnRmx+GRWB0ZlQQU8Ir1NCgOTMWYMBtUpG
X-Gm-Gg: AfdE7cm+8nEM6xPJIWCr0W6amyhMEnYTjn0FmoDeLxho72IVvcP5PTCO3uRqeed913m
	cDvpLyfQmO1MEwlwVUbEu2z2E+lot1hv8nwgOUoFjmaugwRvC0YdisDBaS5Je4HGffLMNx0ugpS
	8tYieQR/NGLbh6X6yIWV/tPlVmA0ld7IzLqOlIOA5Bpoebad0/SIkN4qG/VginKtLQ8Qd3PvrzH
	8exPi3dcuO27fRUmX/V7iFtU4D3O1Vjb8nOYXDQfRmPpqRZLgyC1zgSM4WCmIQDvPmclrv2xUkE
	B17mwwktPx0LR0McUyVWRt/cJEHqQlexrJ8u1/iXLh5ZmHrBBcvPd26jiLfOEzCG9dwafecozuS
	VfP/vucRGBCLCKGywgrqjKksKnNKJkRdcLcmI1fQt0oPtJpttONGX14SQeFeCWdFIuqEO1JdEd5
	JG/EwurflFvTy/Nr51CTdom+mz/e6/CEt62afyjbQVdcQRHUS54Q==
X-Received: by 2002:a05:600c:348f:b0:492:4636:87ae with SMTP id 5b1f17b1804b1-492463687d1mr271367215e9.17.1782203103276;
        Tue, 23 Jun 2026 01:25:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923c862sm262149435e9.7.2026.06.23.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:25:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:25:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260623092501.17bef195@pumpkin>
In-Reply-To: <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
	<20260622091344.794e0d74@pumpkin>
	<CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 17:26:10 -0400
David Hu <xuehaohu@google.com> wrote:

> On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> > =20
>=20
> Hi David,
>=20
> Thank you for your review. You raised many good points regarding
> optimizations here. I'll switch to using 2G as the max entry size
> (`SZ_2G` from `linux/sizes.h`), and remove divisions and
> multiplications. I'll also replace the `for()` loop with `while
> (length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
> to `size_t`.

You shouldn't need a cast at all.

	David L.

> I'll send out a v2 with these changes shortly.
>=20
> Thanks,
> David
