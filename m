Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB1D2E2
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a7d9d357faso5226657b3.0
        for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 00:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786324; x=1698391124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OizVgKEhlDyqgQ+n9W+hpcjW/zmDsIX6WVqXAdIMLco=;
        b=uYxCc02igmTbDuZP6kPx8ggIVBIRJMn4csrMHaoR38rZq0CUhO3989J2Edf5/Ve9mC
         /gV9dnqBuFcBXwTGsPktr48H8RKRETAcDnctVUxDL8AKLflwUowm0Q/exo/kHss1AgAu
         plDeBS3xLk0gOre/DrI8AbdyfHGU45KbUMtAJGMx6l/ygTFstYLjtBdPfDNQfRFpi1L+
         FvNzo/TcNVMcAEEbSNnyMsdadi2sYelZMWFTFpnRPFINvVn1rRqshqm54UnNhhtVBoni
         q0iifjhtOJPva83M6KAYrKB5gFW9Lsc4l1DSN26riMfXSR+WXP8AquGbJmuSZQYskKit
         rPDQ==
X-Gm-Message-State: AOJu0YzNsKIVNWTn9UUvUAIqCoAsFqYQ22UM7/FJhbdnP/VXLlR+aUvn
	+ZQOqSmHePAVsSs0oaXUxZtCZv1AOFn3sg==
X-Google-Smtp-Source: AGHT+IF1YqP5pbfZwaI6l2LoKdlQgJ8EEO+om3s0RrH93PL3fvdrxebINCQyTH3dxBw+QwQM3tZnRw==
X-Received: by 2002:a81:6055:0:b0:5a1:d63f:5371 with SMTP id u82-20020a816055000000b005a1d63f5371mr1102982ywb.20.1697786323674;
        Fri, 20 Oct 2023 00:18:43 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u7-20020a816007000000b0059b50f126fbsm477992ywb.114.2023.10.20.00.18.43
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:18:43 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7d532da4bso4988027b3.2
        for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 00:18:43 -0700 (PDT)
X-Received: by 2002:a0d:ddd7:0:b0:59f:4dcd:227e with SMTP id
 g206-20020a0dddd7000000b0059f4dcd227emr1147454ywe.37.1697786323167; Fri, 20
 Oct 2023 00:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231020054024.78295-1-hch@lst.de> <20231020054024.78295-2-hch@lst.de>
In-Reply-To: <20231020054024.78295-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Oct 2023 09:18:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNmbMsqBF3gozT7yqUVJZ+9Eg2wjTuQF+1W4jKXdAZVQ@mail.gmail.com>
Message-ID: <CAMuHMdVNmbMsqBF3gozT7yqUVJZ+9Eg2wjTuQF+1W4jKXdAZVQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

s/depdenencies/dependencies/

On Fri, Oct 20, 2023 at 7:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> CONFIG_DMA_GLOBAL_POOL can't be combined with other DMA coherent
> allocators.  Add dependencies to Kconfig to document this, and make
> kconfig complain about unment dependencies if someone tries.

unmet


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
