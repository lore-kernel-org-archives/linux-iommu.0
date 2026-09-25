Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311F4D7D34
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351491; cv=pass; b=PStbYd2YkdtVQPWRjgYHMErSlTHUB1bMuSIcYO0v2hCv3FmlOCPs3eTTC34WLty45k9F5PU8IhKOZUXeRW5sJ0fxdL99HDMrM705tk34Ysi1NF5wYwpv7Vsf6I5q33FM94MCEn3ImY+dONg4tQu6sbpRxd9onSck6XNz/+rOPuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351491; c=relaxed/simple;
	bh=ksv9+eayqWXdAvP9hbPnMbA2UNu74L0hqhKX+YUYQA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNLB+h6udrXY1kLbqBGzTqgqeTJdhWnL+UpuhZYWFMbizit7v8Yo3YsK722pa9OxXm7iOsZLF9wwEn+xTFiW/IBHVsx34OhIqUFqfvZO08phHotYj/GE0QNcX5dSo/bPNK9hDPsXHrCh7B98kcMCVyIubVc5CAceZGinClnSWME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=iXrdb/xQ; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="iXrdb/xQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so10747905e9.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790351482; cv=none;
        d=google.com; s=arc-20260327;
        b=NsyyT32GdThzap1tI2xX3RhQQZoLk72aCWi9uVNDNZQ3G/Zfxk/K0H0arl7VS7Vw/p
         oxCDWPMLUyICYlouNPssek5M/r12V/vLyByz+UpEjB5hbNRRUq1jafxi8EA+ZGkWURqF
         DxJH5xHUlkktex+0NOGfZ2HgnIQ+sYbC63kx7dwNX43zXl9jFyJSX/UdgimQAt5kFW0Y
         leV5veDoxL9pPIyO7yn4T3A5bKdD4NGQrB5W77gtxdbtsaktrVsFYUQ8nJW4PK3ov4pl
         Xz1JMA+NjzjqE2jr+YaUKJnOCtj7ioXxuZfKlZwnmNW938ny/QGqImxcB4V16XIOqwCA
         9mzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v7p/CXRNed6Ee5EzOeUUhXw4TYzwEpF8rokaKaV5e+Q=;
        fh=ayBbcL5LN18RaYkmyQ35xY0R3Xp2Z0tyMSbpRYiIuQQ=;
        b=kzPnYbo4BltBNyDkLIn34yRZldTO5TVrwNFJ0I4fT33da+rrxaRX7jq48lwSK1U68c
         b25mJ1v2+XTy9A8w4CkR3un8DY+z43AHmnS/pk933vNMamLqBnzwr3SGERLT+gi7e0i6
         9eRpYP51SP699ROEWeMQXzYTt8kw8I8T9P2zud2VtTX7svohiPchSFr02hR4OTX3aFOP
         J9RkbDKQugta91ce+JbVYIWPScbaiYyISRRAtBL+YRzHgMSxCF2sMLWs1Vben4uX1Enm
         lAIYPJuvUmiV2ot3ywToiYfLukem9kcp3kMVHVO7Mwk9DFt5/Cm91AoHNGzYPbJGJC9n
         5XVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790351482; x=1790956282; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v7p/CXRNed6Ee5EzOeUUhXw4TYzwEpF8rokaKaV5e+Q=;
        b=iXrdb/xQSdBfYWbyCrKX5TvC13TAG9YOd736GZm/NF4zZKv43VHWM8ObD0wSFRZkEu
         Asen/2GzI6mLtuzICVuatYC/+sSJrGxOCGV8AVq0yQBV9FNU6Xy0PPvg6n2I7vTnSCBf
         5YblA3EbVvbnB5uRhUMpE/7GeyEoufhAWlzaalOFAmE5QX8OjAvUSJWnAsWRt+nDKC5X
         4lQ1nURcsFo4triRS6kWbv+1XvcZHsazooiMqT2YgCRmlhXpESEK7n89Pq73/uxTRqoA
         5FeHJfN4s0gBot8NNg+qm3tpiZjDFH76wd1O1/bBamsCA4DUTQSESCrQwgb7C4n+P27c
         s+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351482; x=1790956282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7p/CXRNed6Ee5EzOeUUhXw4TYzwEpF8rokaKaV5e+Q=;
        b=2s6kIcI9W+GY5fbHqETspfdpmc2+W5EAGRgi1QNm2FgPf4jo473buvY8SfMZf7Rmng
         tIBQ5vCmU/NU6+ne8R6eM47W0tZFOjqsBaTWc8vi/p8djI3eUYLh9nPvdpqt5ip6HmXX
         S4bbhFYquhPRxdW5ndOuGFqt6XZC3sZ9xtjEXuOjZmajsjEWkS8KwyQa8HtAmMFDHBmG
         ohR2eJsRPvB84ME5iqPG7J5Xf32V4gbt4+IJ4thfwRSrWfggcuGbLpMx8CD7YzNpcL+G
         dLcM/FBRueeo999etbi/tc/2BSeQY/l5pFOLrBPxBw7zuECNY6tYb3OQo4F4d9pi6OuI
         7bvw==
X-Forwarded-Encrypted: i=1; AKwUvBypV9OqEw9XU/XKYVvkuITgC6heCo6fegpdZbNooMbUSn1GoWC7uYjtswz+kE5gmFVsgjJkDQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nBrUrkWZwD2/di4mwKz6JsqNtKIpj3iCAMld+rdQZu6oGV9f25
	NvyyHBkbjlFVf37PDvuXuEz9A247NlBdm6Be55kCV8DurN5nuQxNvL1xtQ9zfDDZcBmlOoIIxM3
	mmgQQ8Z2q91YtF/QndP9I+Vgu70vQ1bxbIsX2pd9O3g==
X-Gm-Gg: AYBFou3Nd0QNsgQK8txaxD6TyB7ThNqwQvfEuPWjIquqnfUEIkQ5YpiaSvaz4Rp8BX0
	yQtdJ5VqMELAPOUVt8w7mqbyO0rhl0CpfKR510GBMvd0W9Lmbq1goJLFL+yJ799vpQ1Sdva+Xd2
	LrDYAgeaJ3MRdpQCcrRtuyQjCo/3/lCeiWoYFSoN96/gCoK7ex/qGAqzlkUsboKCWjzYfPHYg4D
	wNIvC6tBWyNwETfMXvbzqplB4pq5i7qCGmSWUsQz38AYC29bhi2jhBAUpUERF1jxc7A5B6orp7y
	KZ3SyzK/0vPro/Q2beds6BJ3ZWYKRjBzjnayXUvbuKZ/tRPjPBPlmunDZcfhK6+ulvcZSXZpwds
	acaPgg6aHf9rQob1LuDYBBGAmxSMDmQGt0pOqTnqMh3xhFsjcuHtqnibscUV0STV5fbzEbP+LFo
	U=
X-Received: by 2002:a5d:5888:0:b0:488:57ad:d5c8 with SMTP id
 ffacd0b85a97d-4887171423cmr11459377f8f.3.1790351482096; Fri, 25 Sep 2026
 08:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com> <20260925151659.419512-15-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260925151659.419512-15-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Sep 2026 21:21:09 +0530
X-Gm-Features: AclHuK-IHMdTsA8jz2IcBn7rlhmgx5DYTuZzwV1GUkqdkciiE-3lPooZDFeq3zM
Message-ID: <CAAhSdy2WLpd7rA0+cUi-oLgDePsZV_4zr4v8rnxp=y=RkObuCA@mail.gmail.com>
Subject: Re: [PATCH v6 14/16] RISC-V: KVM: Enable KVM_VFIO interfaces on
 RISC-V arch
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, tjeznach@rivosinc.com, 
	jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, tglx@kernel.org, 
	kevin.tian@intel.com, fangyu.yu@linux.alibaba.com, 
	Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:47=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Enable KVM/VFIO support on RISC-V architecture, now that VFIO device
> assignment is available on RISC-V through VFIO_IOMMU_TYPE1, so a
> RISC-V KVM guest can be notified about VFIO-assigned devices.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

LGMT.

Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index ec2cee0a39e0..49179aae9504 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -29,6 +29,7 @@ config KVM
>         select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>         select KVM_GENERIC_HARDWARE_ENABLING
>         select KVM_MMIO
> +       select KVM_VFIO
>         select VIRT_XFER_TO_GUEST_WORK
>         select SCHED_INFO
>         select GUEST_PERF_EVENTS if PERF_EVENTS
> --
> 2.43.0
>
