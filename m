Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1228360
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5af5b532d8fso46763757b3.2
        for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 01:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698739652; x=1699344452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dW9T/oJs2BJS5b3p+JbS+2l957dizjV3YoatArAOMI=;
        b=rcY/CuyKgqqliL8zQN+WfYRHociNkUmR90tap9e2pQkbgMbeXjx1noxy6Lw+CN7nOM
         DASDB0BLf8GrOv9an2uuQzHPrSWMaO+sYc93FkiZUPni1Uk1klJVQxwtVrS7dhbnCKw8
         bzRHp7rzehLEPBeWRMnuSQu8OkX4OWn3Jc7hkdVDj1HLLSPfHwyXQg7dyLe/LIg2dfa9
         eNwXTTSDMoc/fbehEB6tufdE6uZtAtq2ADlyKn11VVbinJG476LgtL17gJ1FRnwTngqI
         lzlWONe+mVWtWCZ6fNeUzIVfNwgZTkOi1k8P53CXXJgCYMb/iUK7YBLh+GR4ZcsjN2L4
         bABg==
X-Gm-Message-State: AOJu0YwODRgInObYMpKdreSM02CFn/5AxyClrX7sggr8m2ugD06IdBPU
	x8B8WHfAlZCHTrs2aIjJ/ROAuVpuWwN59Q==
X-Google-Smtp-Source: AGHT+IFS6HX/WoXSD7SiS35UD/xgsjzXUmVAPd0CE/qS+/hd5Br5peEQIQ4SRODYEhyNF/epWExZjg==
X-Received: by 2002:a81:d007:0:b0:59b:5696:c33 with SMTP id v7-20020a81d007000000b0059b56960c33mr11388739ywi.46.1698739652210;
        Tue, 31 Oct 2023 01:07:32 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s18-20020a819b12000000b005af9da2225bsm495837ywg.20.2023.10.31.01.07.32
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:07:32 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a8ada42c2aso52226427b3.3
        for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 01:07:32 -0700 (PDT)
X-Received: by 2002:a81:e608:0:b0:5a7:bc66:949f with SMTP id
 u8-20020a81e608000000b005a7bc66949fmr11098090ywl.26.1698739651833; Tue, 31
 Oct 2023 01:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZT-46QZiN8b37Swy@infradead.org>
In-Reply-To: <ZT-46QZiN8b37Swy@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Oct 2023 09:07:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQrJcFh1rfd0HAOEb-KYKQVBBJ8RWpvU_W6kxc3EQi2g@mail.gmail.com>
Message-ID: <CAMuHMdXQrJcFh1rfd0HAOEb-KYKQVBBJ8RWpvU_W6kxc3EQi2g@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.7
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon, Oct 30, 2023 at 3:08=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> the Kconfig dependencies added in this branch caught configuration issues
> in a riscv platform.  The fixes for that went into th soc tree, so it
> if you want to avoid them it might make sense to pull this branch after
> the soc tree.

FTR, these fixes were merged in v6.6.

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
