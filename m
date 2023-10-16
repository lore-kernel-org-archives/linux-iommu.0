Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF222AB23
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2fPd6UO"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7b6b4c2f1a0so109269241.1
        for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697471024; x=1698075824; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5VhkbLijcsIjEPutw+pmedC1vRGyDo1Fb4EwWhkNwo=;
        b=d2fPd6UOV33oqCYja2b8dWnUYOrdD0YbrjgfFOvT7q09gj4b1gNCctwQYOjNug61fL
         btd7VAzD9BgUvIkPaIXMuLtVoCQ2MhSwR2CJ77w7ND/GazYTOrfqLqsTdSMHaT24theS
         TdfsmVeCmTzG2x58DCXUFZfVb3xyKQwXrgu4E+31PBKpkf5957sqIjUUO3lhXQAyZEqd
         PtAarx4pUOvhGuT7Sv+zqsQ6pwAogdjH6bB0xFY6zWZe2AMFvU/WMX37ViqiQ8/JSRlx
         gfiC1ysIZqibXlcbQDNlBGkM2F2FwZ5BiD6BfwyPf7w8g/YQAv69GTnB5Tuby4iacorm
         O1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471024; x=1698075824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5VhkbLijcsIjEPutw+pmedC1vRGyDo1Fb4EwWhkNwo=;
        b=AOUSyg85GFRm3bLkH6GdQ5ItTTBwEkJGCyNgaXgQzJIAAV2feO6wfDyVlmb5E1owF9
         xqn9K3mIrHu+gCEqbBt4kqqzpf3L8JbaQk8fFan6F5NXDVKifsrfRti3JiBPAdHoTcDA
         oc+2JYNOYnrJuEYk0RInl96Pmkmowp7jvg8AXoX+67svzrDpZWS1UGyOdutfDkMVkz0k
         I1e5K8mwFVBNZky5/0PIwO/MdRn75E9k9GJkS6mMitYrWWtNeJod5PtXI7wpcWIWwteN
         SuMKKYTa8DouVbEvhW9R4hD3nkFLjPQMyrkytCaYReGRbZOOJPnLO1Zr9pcfY8Df0PHa
         5GRA==
X-Gm-Message-State: AOJu0YzwKsEA38zUfvAknAtegmlanq3rR+CjywZjgJiz8xn1VEQkyq+c
	zDvAEHqzsq7dM3sZMoCc8GqotpCQNaiPAXdlQOg=
X-Google-Smtp-Source: AGHT+IG/WMjMrGYCGsuwhthBEKZ8VCVuxCi3PoeLoYHu5J1bxDK0qcF2TAbbJo60X/pGsL22e+tEj0vGdiYsm/MFMMM=
X-Received: by 2002:a1f:e404:0:b0:49a:1a56:945c with SMTP id
 b4-20020a1fe404000000b0049a1a56945cmr28517495vkh.13.1697471023853; Mon, 16
 Oct 2023 08:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de>
In-Reply-To: <20231016054755.915155-5-hch@lst.de>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 16 Oct 2023 16:42:27 +0100
Message-ID: <CA+V-a8skxbuRkU9PKUZRkQkp-y0PKeYx4WhVcJtktAT-VEgmCA@mail.gmail.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from ARCH_R9A07G043
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
> Selecting DMA_GLOBAL_POOL without the rest of the non-coherent DMA
> infrastructure does not make sense.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/soc/renesas/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index f1696d3b5018d0..ea473b4150dfa8 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -338,6 +338,7 @@ config ARCH_R9A07G043
>         select ARCH_RZG2L
>         select AX45MP_L2_CACHE
>         select DMA_GLOBAL_POOL
> +       select RISCV_DMA_NONCOHERENT
Can we keep this alphabetical sorted please, with that fixed:

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

>         select ERRATA_ANDES if RISCV_SBI
>         select ERRATA_ANDES_CMO if ERRATA_ANDES
>
> --
> 2.39.2
>
