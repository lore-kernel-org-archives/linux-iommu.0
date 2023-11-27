Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6120F7
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+68Jg97"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c997467747so16904441fa.1
        for <iommu@lists.linux.dev>; Sun, 26 Nov 2023 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701055781; x=1701660581; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV1CXf/5vgCh5mOFnUCAA7ihYHRFt1CuTIjPFpsOHiU=;
        b=d+68Jg977i4hH9g8rFwrD/3hW5CGVAYI5J7qoSLAlpzza+ao2YVW/JqKheAHK8PEK7
         gtF3qm4IcV6j4AfGkAbZR6B3xgnsSycF7SroitplNWUfiTJUpZt4m7e5pA18MwTFdDiS
         k1nYB6VVYr4Rnmx4UoTMjMYRVt/fcuUcJqwBwGRL3Ol/A8qo8B2/bHLX6O9ERxPv3tQA
         T9r3Ib8oOwz/Vesfi1XGt/Xs0uPcZ6fL0ANHNlTUNUgwdJ+9fTylUG8eswxXNHVfhFL+
         yT8RvSW5q8UVMmixO8pinKhbM7cqvGnTJIF+nqg13w+W5xoQ78py/BIEdWN8awQm8mjU
         2LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701055781; x=1701660581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV1CXf/5vgCh5mOFnUCAA7ihYHRFt1CuTIjPFpsOHiU=;
        b=lLLenm5OIFSPLdwNoJs4P6euJY9AC5vlyBp+KcMaKf/IRUz0n09CAeINrb/enA4OZx
         IkUjMEwZClTna0cE1fc4j2ROxnyPDVjkNvIEJKvaGGmeS64rp6Jy/eTJdGJyrY35qRPf
         rXPC44DItB3M4aLBQ3g1BjkWvNSuw8s2u/TxKFX2cr8XPAPvZz16MWItQ102oheMLnKZ
         tu90fdcpuhX6etFZfnU82VAsmmAegAQd3RCnJo3o0YYKPF2H2RN0dHfCpdVihiWMZFRt
         avqFZtuMEwbFckp2wEgNZ6mSaEPtxmPCwHpVsqK2ull9hR/RtSYIY8elq1yNMfX+M5os
         qC9Q==
X-Gm-Message-State: AOJu0Yymi+JtUeF7w3NWVwzg46TjghW3AWrFXdglSfFM2vF/6lIvMKIS
	k2QY+txLrun3Rn04uEgj8zPvhe44Jta9tWnRYl1Crxs1R2E=
X-Google-Smtp-Source: AGHT+IGOf4mC0tblJt+CsMkIa+mju8Wanx4dOjJ4UGZAvNfOvuBltgSZ2ncd12yqTeq8/VhiG5zFlfwlz54C/8ofkhQ=
X-Received: by 2002:a2e:3c15:0:b0:2bc:b9c7:7ba8 with SMTP id
 j21-20020a2e3c15000000b002bcb9c77ba8mr3854903lja.43.1701055781092; Sun, 26
 Nov 2023 19:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 27 Nov 2023 11:29:29 +0800
Message-ID: <CAGWkznGz-Q_gC6EnuTgO3boZY9mSMpMWPRHt-ajo=VDUTHMMEw@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch arose from a real problem where the driver failed to use
dma_map_single(dev, ptr). The ptr is a vmalloc va which is mapped over
the reserve memory by dma_init_coherent_memory.

On Mon, Nov 27, 2023 at 11:09=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> memremap within dma_init_coherent_memory will map the given phys_addr
> into vmalloc area if the pa is not found during iterating iomem_resources=
,
> which conflict the rejection of vmalloc area in dma_map_single_attrs.
> IMO, it is find to let all valid virtual address be valid for DMA as the
> user will keep corresponding RAM safe for transfer.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/dma-mapping.h | 12 +++++++-----
>  kernel/dma/debug.c          |  4 ----
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f0ccca16a0ac..7a7b87289d55 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -328,12 +328,14 @@ static inline void dma_free_noncoherent(struct devi=
ce *dev, size_t size,
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *=
ptr,
>                 size_t size, enum dma_data_direction dir, unsigned long a=
ttrs)
>  {
> -       /* DMA must never operate on areas that might be remapped. */
> -       if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
> -                         "rejecting DMA map of vmalloc memory\n"))
> -               return DMA_MAPPING_ERROR;
> +       struct page *page;
> +
>         debug_dma_map_single(dev, ptr, size);
> -       return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(=
ptr),
> +       if (is_vmalloc_addr(ptr))
> +               page =3D vmalloc_to_page(ptr);
> +       else
> +               page =3D virt_to_page(ptr);
> +       return dma_map_page_attrs(dev, page, offset_in_page(ptr),
>                         size, dir, attrs);
>  }
>
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 06366acd27b0..51e1fe9a70aa 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1198,10 +1198,6 @@ void debug_dma_map_single(struct device *dev, cons=
t void *addr,
>         if (!virt_addr_valid(addr))
>                 err_printk(dev, NULL, "device driver maps memory from inv=
alid area [addr=3D%p] [len=3D%lu]\n",
>                            addr, len);
> -
> -       if (is_vmalloc_addr(addr))
> -               err_printk(dev, NULL, "device driver maps memory from vma=
lloc area [addr=3D%p] [len=3D%lu]\n",
> -                          addr, len);
>  }
>  EXPORT_SYMBOL(debug_dma_map_single);
>
> --
> 2.25.1
>
