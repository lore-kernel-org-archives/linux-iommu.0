Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389043D97F
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7a80a96dbso54722557b3.0
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532047; x=1698136847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZlS/7U1efr6AK8aT2dfiOZNDdagRiOd/6FdP6Lb3EM=;
        b=lOhcQVI+bON9wdmigjQFg8BHPF6wfCrZ5susBQ2SXP8Fa0HNZfZVkKIr260/hkhjGC
         f3uujxZQdmIaHSa7NervbXjXh217ZUKKKH06gP41L/Rc+w0RzgwTgM8pvHZpLCC3mlAS
         YmNdQQNM7GQYtuunBw+gOIOkrtH2cXQZZTDFoIhj2W/dK7iq4b1709R1S114p65fyolr
         U6/dFXGtXnUepEzOoO54mFJlXHAmwuycXN5eJk2rIGOFLTDPvyqvIQSDDs16YYvrUDiO
         bppDflE9TW5xRUOy2QqlF9Rl9dS8ibZel3dq7KM7sjJ3mQ3ovagtmHPbGR1w5Qlm5PT8
         uu+A==
X-Gm-Message-State: AOJu0YzXoVgCH3pv0DKXm1DPx3FWboNENR32bpz5CX2KMAHOg0wW0b9e
	BG1GBuEW1P1R3EZqn8lN33tPSdxDCQgpDw==
X-Google-Smtp-Source: AGHT+IGjNpJ0V9bcgLD19Ih5rwhQ2zaq/0MvaNV82lQaQZFUPRLCHQwwWMlc6qRgoFg9BNhDiV0JAA==
X-Received: by 2002:a0d:ddd0:0:b0:59f:699b:c3b3 with SMTP id g199-20020a0dddd0000000b0059f699bc3b3mr1020746ywe.0.1697532047094;
        Tue, 17 Oct 2023 01:40:47 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id w131-20020a0dd489000000b00594fff48796sm433013ywd.75.2023.10.17.01.40.44
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 01:40:45 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59e88a28b98so46644667b3.1
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:40:44 -0700 (PDT)
X-Received: by 2002:a0d:ca50:0:b0:5a7:ba02:9c9a with SMTP id
 m77-20020a0dca50000000b005a7ba029c9amr1017206ywd.2.1697532044608; Tue, 17 Oct
 2023 01:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-10-hch@lst.de>
In-Reply-To: <20231016054755.915155-10-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 10:40:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVq0ihLthVQF-2v4_E=m7jdOZty8b69eizJyWoU+0CFCw@mail.gmail.com>
Message-ID: <CAMuHMdVq0ihLthVQF-2v4_E=m7jdOZty8b69eizJyWoU+0CFCw@mail.gmail.com>
Subject: Re: [PATCH 09/12] m68k: use the coherent DMA code for coldfire
 without data cache
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> Coldfire cores configured without a data cache are DMA coherent and
> should thus simply use the simple coherent version of dma-direct.
>
> Introduce a new COLDFIRE_COHERENT_DMA Kconfig symbol as a convenient
> short hand for such configurations, and a M68K_NONCOHERENT_DMA symbol
> for all cases where we need to build non-coherent DMA infrastructure
> to simplify the Kconfig and code conditionals.
>
> Not building the non-coherent DMA code slightly reduces the code
> size for such configurations.
>
> Numers for m5249evb_defconfig below:
>
>   text     data     bss     dec     hex filename
> 2896158  401052   65392 3362602  334f2a vmlinux.before
> 2895166  400988   65392 3361546  334b0a vmlinux.after
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The m68kclassic-with-MMU parts look fine to me, so
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

I'll defer to Greg for the nommu and Coldfire parts...

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
