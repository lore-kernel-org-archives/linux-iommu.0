Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDE27211
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:56:45 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-96f588bc322so18782366b.1
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684432603; x=1687024603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzWNbSRJVd3rro7yhzWQMEtJ5Iqu6HA19zSm7B5FPgA=;
        b=CR3LZCuBVanPMOVw+f751EMAMvtEZd2t/+627rc/6+CtRcPO50RJ5/NSlcfM2K3Z7O
         3N2gG432V4o1DSNY5M5jWq5lzr4PvGxJfwtL7xSCXyzSUjSFGkqNQR9NqwgOjHJC0dRj
         bYg+eZgnAoaHp7ksEc2rcz19caimOTmhXYN2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432603; x=1687024603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzWNbSRJVd3rro7yhzWQMEtJ5Iqu6HA19zSm7B5FPgA=;
        b=GgcVKeddMRvgS5qf+h2Os++fssWZaTfxjGwhv6xyKweavE1nJD3N/KdCPUQj0K/fYu
         auPKMq1YE0F5LJNvCVpnGxCyz7R4lRs/doHjokcXTE+D/XwE1XWGtu0jLZgmn4MmI0m2
         UUYGZAlCjgiW/NkH4zynLb1azRuAmuzN569VI/REJzuqdIAlFZrDgmGQj0+fRbOXv6WU
         iaIA+00hIr/YSOiBBtIJsfy4MMWrLpd9JbJQZyGBGkH/txDcF9xKc4DIUSCbuXdbLcfL
         I80W2CNsOHhp2agz0yeV2yB9E0Czn3h8MMUvIRlSgH5S2s9p2AHQgaWN9oSNyXS5ZxVT
         AlHQ==
X-Gm-Message-State: AC+VfDzkFDQZckT8vkU79urKeSAAyr7wpN17h2y0H0JDJwMpa8QhJLZf
	TZircpTV35KyeLXKQwabMDqK/k/ZsqWhQ389Y4K7xJ00
X-Google-Smtp-Source: ACHHUZ6ttwS39alx4hHVB91FLbKdQvETC+dSDvltRRRZr6qZFxM6fZ1cb4L6PGw9O5NagXldz1Iv5Q==
X-Received: by 2002:a17:907:7250:b0:966:b4b:eb0 with SMTP id ds16-20020a170907725000b009660b4b0eb0mr45592814ejc.30.1684432603180;
        Thu, 18 May 2023 10:56:43 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id bv17-20020a170906b1d100b00965c529f103sm1236592ejb.86.2023.05.18.10.56.41
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:56:42 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-510d0e40c6eso3247815a12.2
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 10:56:41 -0700 (PDT)
X-Received: by 2002:a17:907:928b:b0:966:2123:e0c3 with SMTP id
 bw11-20020a170907928b00b009662123e0c3mr39319767ejc.15.1684432601629; Thu, 18
 May 2023 10:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
In-Reply-To: <20230518173403.1150549-1-catalin.marinas@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 May 2023 10:56:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>
Message-ID: <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>, 
	Isaac Manjarres <isaacmanjarres@google.com>, Saravana Kannan <saravanak@google.com>, 
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, 
	Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:34=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> That's the fourth version of the series reducing the kmalloc() minimum
> alignment on arm64 to 8 (from 128).

Lovely. On my M2 Macbook air, I right now have about 24MB in the
kmalloc-128 bucket, and most of it is presumably just 16 byte
allocations (judging by my x86-64 slabinfo).

I guess it doesn't really matter when I have 16GB in the machine, but
this has annoyed me for a while.

It feels like this is ready for 6.5, no?

                 Linus
