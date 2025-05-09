Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72C1D88A4
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761484; cv=none; b=CSZvxL+GByFzFWzDHeuPBWWh1tmoPk0vV+PyJQ1d8WpSuzk6YC8FG0ZBR86NR57Qhz4G1wW9ZbDhhWiiZ+Z9qcDoXCybpcOUvvj/XAefOBasmpfKF7TvP5QcOUaczDcykJjfAU0c3nE1CBr5KSAqLSD5RWCb9Vu6R975ESr0RoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761484; c=relaxed/simple;
	bh=+Yt6T0u3fYfQL7cdc7BFMhOrNEKA8KJXzQY/Qxnx5gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqu0xUAbKthfiDEcq1rDwn73yh5HITW19rO1DYhipmRS+gH9CBe2bIfrgdaxgjCMr82PG5mdUkFYNM0kwJr3yx9I/wMR9Ar2h2moDlCe5fiXtq3Z5vY5ybxD+wHMvI9JGQiZ6HOTZX/4IpZsYJRlq0glSFzZTcuSdpo/3Aipdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcV1C3sw; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcV1C3sw"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4def06b6f87so42913137.0
        for <iommu@lists.linux.dev>; Thu, 08 May 2025 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746761480; x=1747366280; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A2ix+KLqr1uAddQxC8meUMDCd4s6wELmtjquDmWLdA=;
        b=CcV1C3swiouX60HT6U1gVo5T6NXFsEIsGbdUEYcvf5m8qvMuoAyQXszDJcbb2UtSI4
         j0oS1Sg46u+xlT7r5GGSz7tLK+lavDD6WJLKMD+OccVMxPJWermo/FkjdaAz96bLOCtU
         AUc94LapVJa1R5GVfZfQTKvPTzfAdK/kyKxaV04PYqIaRT9BJGg4eOyEZ5CteaKo7NLM
         pRflsaEuCyi/PPf6is+FsHsr4zBOxsBC0To+PU9zWxykGdybc3S07ptR3oUelShnlbM5
         /+JkV9YX5ZekacE8reYsBRGE6u3FzX+uxxC1PgVGYTVPJB6c6GzGeCUbGXjPNeY5WNnG
         tvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746761480; x=1747366280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A2ix+KLqr1uAddQxC8meUMDCd4s6wELmtjquDmWLdA=;
        b=nEOFiQ1cWRojefV8/moJHeJBEi85v15H4/Ij2lBg5N7+UP3SYcx95moR6oEfhNUGQM
         Vb+Z8VdvaHWuSglhbYiUQa6P6BQ22AjRpSfw2URFMpNJ8PcUWfV0qVl/Wj+oAwDh8cC4
         XpATCq6au1vBpa7R/xVUSTxOfL4ygkfocXhLVuTE1zavCx575YNDBet98p2BzPaYvVsf
         qE+4R7DXwd30EMiUMhGAXJ0gtONN7f4VzF5lO3jl8auo80yXkesuZO1y7kyZI2Jif0/U
         tZFWFk6/h6cMGssOLeB+WCtQxWavLx4PafLXV5Peeys1z8FCbwq8InOvdKTn+ombyUzR
         QriA==
X-Forwarded-Encrypted: i=1; AJvYcCURcHHHnktUJQV7pPX6gp2bF3cunvfGvS1iRvJyqKp58ZN7hwr9sy2NTC/7N35OTaxVzjzZVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjI6vOflqFVVUjXCLJ9T6R+Cvz7QlWE1aC+u0XxX9FfP551k/y
	8OVT913SJACmPx2EL9ZSDQ40UD8c7ic7S1gxUWXM+f1ngpzPE2s+Q+8TpJoluyAidtQ/zF39NuQ
	h86VNbIzyxNRjYRNoIDYVilitwfQ=
X-Gm-Gg: ASbGnctKLEmGGA7LyOXn+HVK0X6ybWB79qresJgpkA5BX2+FS/Rvc1zPrYYsppPmdHI
	AuiONcEBJmT3/JmAT+fsz3cyBRyDESMX6tbVHrJQAlwrrT58Ssu4FDYIlmKjwolETByU1dsbAYB
	VFeU+UuiM2QASaJNPCajDqmA==
X-Google-Smtp-Source: AGHT+IGc5+Cslf0S1acbclvSNhn/uwwmcTG8ZUvvlGJo/X0wH/M3Gq+zbif2xm4TrTenOWf1MumTFqC9O986MUqRF8I=
X-Received: by 2002:a05:6102:8097:b0:4c1:774b:3f7a with SMTP id
 ada2fe7eead31-4deed3d4b5bmr1410263137.16.1746761480413; Thu, 08 May 2025
 20:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250509020238.3378396-1-xiaqinxin@huawei.com> <20250509020238.3378396-2-xiaqinxin@huawei.com>
In-Reply-To: <20250509020238.3378396-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 May 2025 15:31:09 +1200
X-Gm-Features: AX0GCFuxI4KztwbrtFwtCfTebZzuXx55Bo7QyZab2Vhdl2Eshu9OBelft6iLsz8
Message-ID: <CAGsJ_4zrCiugrAPw-aExgSMZXYBBUqLyyWbcpKH8RdhKnHxj9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:02=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
>
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
>
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header fil=
e for map_benchmark definition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

+Marek, +Robin

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/map_benchmark.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 62674c83bde4..2ac2fe52f248 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -27,5 +27,6 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> +       __u8 expansion[76];     /* For future use */
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> --
> 2.33.0
>

Thanks
Barry
