Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DF26FA42
	for <iommu@lists.linux.dev>; Thu,  8 May 2025 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715351; cv=none; b=ci1pze8OL/TqBDkcBBtL2nJPBajiwLI3bSkAXdrIuFmgZD20vjyL11UVRRwupA3On+QfP+GdvI2tdUnb0906re+uAQfFZ31jlIC1MYRoIWYhBUq0SXd65nsK3F7unlNtVOBGitryunaJfgOHOctcRzkal4OPqoykzZUEms3h/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715351; c=relaxed/simple;
	bh=HgapASh5XA8oVv/Lz/V7hhXc6nFQHYF1VgUr9bgNK50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXYHa4UkpaqyNurm+gxROlt4WlRRwLmojk8QOgYVRTv/FVXSYFqSAQ+YlTAf4Mh5wQ3pYNndhoKbvZMgsUndsxapx4A1ZUddP62Xh2qYR/F8NFolGu6yQbDhu39nJK4dkqc70oskGNigJgpwB2dYAWmHO1aPzXrT6s5bjhlSEEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nIySzIDd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nIySzIDd"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbcd9088a7so2075252a12.0
        for <iommu@lists.linux.dev>; Thu, 08 May 2025 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746715347; x=1747320147; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrrj7tzRV0HSot50MsrZe31qPKZT2X3/IHla60zHnEo=;
        b=nIySzIDdvTPhkbZOcf7f4+KKhW8Mintr4qwfwfN0Iq9rHP4IUuruRz0N5TDQNtqcLZ
         cGFfDpI24Q0SaFJUnQI2hcaLTmaSNG6g7X+asy+QMbawCO8rdOCLqAs9PkaW8GgYlpON
         uvWlRL4O5W8Lf+sKCeJqAlljXheQmKiT4uHBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746715347; x=1747320147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrrj7tzRV0HSot50MsrZe31qPKZT2X3/IHla60zHnEo=;
        b=u6RE71OYX2gxH9cMT7iUNKuzxEcZTIgag3TPGIPCWfqY559+JZaMQLsvXFRcvGz6qd
         pJ2qbyz1EefDBJx44S2DoybLFhIPWZTmoQzZ7UL5TnuRfF6cH1FiU1DEu7J8+J4jAqwh
         hf1sWceKYal0voSRxs1fyxdlgQ0Yivsr5Gh/n59kXZ+azJepL2UT413E2p8t59rOr7HG
         fH1ILPIipT3PSP5jOGlF5Us1GKwo08zJgKd1fvf2ys3h4pHg2zQPEThv1vpGmBtXVynS
         jzHKyspuhU1b5YUhfWhG38MMj4CLCVdECKegUbaH6IUsSvI6tCCrlFQ1qAzBVPDUy2Yk
         AKQg==
X-Forwarded-Encrypted: i=1; AJvYcCXAeYxqI9v2+IncCe9MTvDpCNpuQN4BSNDqReRSoRG6VyVR94HIjMgP5WsI/3ldIEG3seHH7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuXlzo/q28YjMio4W2NBEmR4PNrRMSekPkwhgSAg8hh38vFDk2
	cnbZOxvsW/ikLE7/Ve/07B47w+acnI6Vv2tfsH7AUdgAwoow1Soio9oT8c9jnbNqjh3VIK0nveU
	=
X-Gm-Gg: ASbGnctXJ4jfNCMRWv0Hz+xpp8Ec2McKCR/d/UiSK5zaqKYFV3u7IUUfTK/RRqcZu6v
	uoiSan1nO0fywO6G3IXXquNT+8TNj3UEP8kRKOmfwWuAup2KfZRce1jaCv9W6dEGWz1Nhy+VbaB
	TIlZan4qezLFK12//OngYyAWBjlrgE/TDVi8TiZqGYZgTYqdTX6AT2U8l8jws9wuc9Zx30dIta+
	OBXqRyUqfiw9S4GBxaPdaMrOzcugiUziSIPo8NGWfqLkLjOLHfCxh2LHju1Wbj3lkQ7cdGbVKMq
	Gcdm0GAQH+AyWPmmJf2LGjnOde5qbGvntwPOqSRKwD4AHtyvMuef4LIpJXbVBD3+aLEf2qzGPay
	u
X-Google-Smtp-Source: AGHT+IG+s3H6tNCxacThb5EpAjM8Js/yHnp8nXMji6nOMxjnmRYfYiRPdqYn40Kd7zrnwRBIP0ikCA==
X-Received: by 2002:a05:6402:5243:b0:5f6:22ca:8aae with SMTP id 4fb4d7f45d1cf-5fc34b0feaamr3327739a12.2.1746715347567;
        Thu, 08 May 2025 07:42:27 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777c5c3asm11280704a12.21.2025.05.08.07.42.26
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:42:26 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso10005a12.1
        for <iommu@lists.linux.dev>; Thu, 08 May 2025 07:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeY0zaH+VWlvFyKz04P8BSR5m6Uw4uHRYE3r87VJnZWWGmBoo7wmp8THN2nJuc21b8/hxugQ==@lists.linux.dev
X-Received: by 2002:a50:8e57:0:b0:5fb:f573:78fe with SMTP id
 4fb4d7f45d1cf-5fc6d3df3d1mr75346a12.1.1746715346027; Thu, 08 May 2025
 07:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250507160921eucas1p2aa77e0930944aadaaa7c090c8d3d0e73@eucas1p2.samsung.com>
 <20250507160913.2084079-1-m.szyprowski@samsung.com> <20250507160913.2084079-2-m.szyprowski@samsung.com>
In-Reply-To: <20250507160913.2084079-2-m.szyprowski@samsung.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 8 May 2025 23:42:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CUOJJ_fpzXrihtqxRiAZfWBNtCxkaDi6GeZk0rc+XKvA@mail.gmail.com>
X-Gm-Features: ATxdqUGjYbxgU6zpFJMZMGQW-VMwakmlnKiG_rNSxR-mybkfMglw3-_t5QXxPAE
Message-ID: <CAAFQd5CUOJJ_fpzXrihtqxRiAZfWBNtCxkaDi6GeZk0rc+XKvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: videobuf2: use sgtable-based scatterlist wrappers
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:09=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
> functions have to be called with the number of elements originally passed
> to dma_map_sg_*() function, not the one returned in sgt->nents.
>
> Fixes: d4db5eb57cab ("media: videobuf2: add begin/end cpu_access callback=
s to dma-sg")
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/=
media/common/videobuf2/videobuf2-dma-sg.c
> index c6ddf2357c58..b3bf2173c14e 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -469,7 +469,7 @@ vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf=
 *dbuf,
>         struct vb2_dma_sg_buf *buf =3D dbuf->priv;
>         struct sg_table *sgt =3D buf->dma_sgt;
>
> -       dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->nents, buf->dma_dir)=
;
> +       dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
>         return 0;
>  }
>
> @@ -480,7 +480,7 @@ vb2_dma_sg_dmabuf_ops_end_cpu_access(struct dma_buf *=
dbuf,
>         struct vb2_dma_sg_buf *buf =3D dbuf->priv;
>         struct sg_table *sgt =3D buf->dma_sgt;
>
> -       dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->nents, buf->dma_d=
ir);
> +       dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
>         return 0;
>  }
>
> --
> 2.34.1
>

Thanks for the fix!

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
