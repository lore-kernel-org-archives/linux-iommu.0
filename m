Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA9C2CD
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57b8cebf57dso2834065eaf.0
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697530024; x=1698134824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9M3vO8TKvpu7sLT3D9MNM+ZNPQeT7q9+/iFi4wqDgU=;
        b=GQHd9zppZ2nvGIGIknABxrarNNmkRKmE41MgM62VOvo+SGTKQuAkRAkcAhcWlYnJfE
         RVbujtDmChCwYj7pN4llBPAZzQkJiLVTYZjkPuKK4P0khzJfDBzHQS1BnazHgXqReGCZ
         QjAWoDqtbmcxzQznVnYKA4ywBsCU6obn8iPoB8hcZh6aBrfaEnEspdf45J+UpTcE3btJ
         QLBCSJT+LE++7Z1p7zA3Lc2eZD/nk+v7vhCoHRd5NErlMqT7T+651fkbc7r+Fv72yiX5
         7E5wDuQKxt9PDqx6xAtrrggBQLiqlqNGPakHXAjzyAd4WYsLDsa2SuCSDtYCh2oy8589
         LjnQ==
X-Gm-Message-State: AOJu0YzcCFD+wxoMtnv1wu2oSj0keYSXStzrDhskL+d9zr/gdO8gu37i
	TTRacabc07CLBVB+edBmkQ8KpV3rO+A6Cw==
X-Google-Smtp-Source: AGHT+IFQut+ciguthJBdoa+knLEsNSOIJo3BVBEs1FAms/xOlbtqESKMBxhoj+pGw4lDoIh+Pp6nHQ==
X-Received: by 2002:a05:6359:3114:b0:135:5ede:f352 with SMTP id rh20-20020a056359311400b001355edef352mr1788320rwb.8.1697530024205;
        Tue, 17 Oct 2023 01:07:04 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id x4-20020a63db44000000b00584aff3060dsm841529pgi.59.2023.10.17.01.07.03
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 01:07:03 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d23f1e3b8so3962979a91.1
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:07:03 -0700 (PDT)
X-Received: by 2002:a0d:e9c2:0:b0:59b:c6a4:15c7 with SMTP id
 s185-20020a0de9c2000000b0059bc6a415c7mr1352703ywe.46.1697529555871; Tue, 17
 Oct 2023 00:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-4-hch@lst.de>
In-Reply-To: <20231016054755.915155-4-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 09:59:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXO94MVoNVh+=meozYXRwpV8jPTBivLJfDHVTvJn7nW4g@mail.gmail.com>
Message-ID: <CAMuHMdXO94MVoNVh+=meozYXRwpV8jPTBivLJfDHVTvJn7nW4g@mail.gmail.com>
Subject: Re: [PATCH 03/12] soc: renesas: ARCH_R9A07G043 depends on !RISCV_ISA_ZICBOM
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> ARCH_R9A07G043 has it's own non-standard global pool based DMA coherent

its

> allocator, which conflicts with the remap based RISCV_ISA_ZICBOM version.
> Add a proper dependency.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
