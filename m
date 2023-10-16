Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B232B779
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaRaJivv"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7b08ac3ce7fso1909617241.2
        for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697471156; x=1698075956; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be+JqDvKcVfoZO+fdW/6Y7p5xoTP2t1qbUjOd8UWjBU=;
        b=EaRaJivvh6jotwUxBGk0lKsY5MJVBO/9JhXLm3Exo9sZnPocHp0zlbF8pw+v9eos4R
         jj7wz4oAaat7lXFzwJXMlEwHk52InbzmiP2JdmNt0lsXqLk1zcvH+dEnHgqZhRMSNdFe
         AxXqCJBLj6jlOBLYROcSuJB8YRWBjVslfG6witEiMSdd9VjHL0OvM5XBufsq7M8kLr35
         BdNTfsL5n3hpQrYOSslTKvXM4NHQt4MT6ccj8E/ANorJKE8nUzQIQukMP9OArNK8oxR/
         p2S4Lc48zToxqMtgq+Tv8tzkqZPyx0hwkUn0ZAMKYZZoDtXm+RFj19H86Ly7UM9iHa+m
         R5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471156; x=1698075956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be+JqDvKcVfoZO+fdW/6Y7p5xoTP2t1qbUjOd8UWjBU=;
        b=rFDt83+GW1pl5UFwlfnNemlKS7mhk8wiurN8NDC/vWYVEVEDcRl2pRWYpMnwuVoxww
         Chcg8rW4SkcnIrDZusaxsyyz55vawMD7HWSO8wep6c5GX2OD+Gyy+QGmmoKPKNSOnZEu
         ztchC5KRCRoYiqDIc0yFMYW3YPlNw8YP2sfkYFJJSKrC3+pv3airPI+DPNQPYpZ8DeFZ
         oND3DH+kbBsbXU1QiOWuA0W6tBLIPiQ8klmXVjPhXzJvsnht3K80nM1cr0t2KqV2nJl5
         9TRSexo6hIEQA5zKxcDEpqqaFJN3aOv/rR/meoM9FyHVm5TJ3+sb+vAiJP2kcT8Ik9K/
         8HLg==
X-Gm-Message-State: AOJu0YyM/F6LfiRPu8SXUE0GJtUyGevO9B1Od1ob9UeLX8qyxQFTuWiy
	zXbvkzmDzhn2VN2X9MW3vgN//aXZSBJgdeTMBjM=
X-Google-Smtp-Source: AGHT+IGv1onTQjqVJotgyiMblBPHjo7A5lICsP21th4oYCrXg7fMKsA2HIivTnjBub3qHrxO15iu+5gAK0C1u+4Pm/Y=
X-Received: by 2002:a1f:e641:0:b0:48f:8891:29d9 with SMTP id
 d62-20020a1fe641000000b0048f889129d9mr27437782vkh.13.1697471156012; Mon, 16
 Oct 2023 08:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-6-hch@lst.de>
In-Reply-To: <20231016054755.915155-6-hch@lst.de>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 16 Oct 2023 16:44:39 +0100
Message-ID: <CA+V-a8vfYb-OBZMMXx7vwtZ4b9V7iep3CzPw5FVmvespF8OPqw@mail.gmail.com>
Subject: Re: [PATCH 05/12] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 6:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> CONFIG_DMA_GLOBAL_POOL can't be combined with other DMA coherent
> allocators.  Add dependencies to Kconfig to document this, and make
> kconfig complain about unment dependencies if someone tries.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index f488997b071712..4524db877eba36 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -135,6 +135,8 @@ config DMA_COHERENT_POOL
>
>  config DMA_GLOBAL_POOL
>         select DMA_DECLARE_COHERENT
> +       depends on !ARCH_HAS_DMA_SET_UNCACHED
> +       depends on !DMA_DIRECT_REMAP
>         bool
>
>  config DMA_DIRECT_REMAP
> --
> 2.39.2
>
