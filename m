Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC537628
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 08:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5076FC4339E
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686211571;
	bh=ZC8CIGi2c2rqiBeNOPuuQxHxEjC8rt/9nEmRCp7Glyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CxCfei4Fz/lhXi1IzAYPDCM3B0I6Z9iDHk+/H9Ogp9FobITuJIVZX3/JbLa98iAMn
	 jiNG5njl9JF82iCTfu9BKVD3x4brmtYr/Uy3/tqz4CefswWlzj+svZhH/rIh0b3mJ/
	 ntnnuifaDjkIVzrKn0400NQEI/D2+FJTKVBggTmnq8VEFWuJic0P4TKlJuknjF00Hc
	 TNSf9Chp0HXSOeVU6/S3xujTLRE91dQvFS005KLS/ZIA8cQ0NihFbNw/7ZIQNcBWnI
	 EYjId/QdxmSX0itX3jz9Ezu6G3Yd3kaX5C7Y3XshlZgwgM4QNalM0pGVE3RhBUoQNM
	 1y9dv/2vf3Blg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so437025e87.3
        for <iommu@lists.linux.dev>; Thu, 08 Jun 2023 01:06:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDyIV0FzYCCxWYGZPB8PLFpx2kBkkRzxU9Eslh9z2f7FcofLxKeT
	Pdfm8Or+ytf39prH/8NWEU5R70E5KATjnWIRTxg=
X-Google-Smtp-Source: ACHHUZ6vbL1o/z1XJ8tvQywKjaxRbYvyy8Kt8D9pEO3OpUT6Q79XhKqfiZtKaOob/ufKkbISov6Bp0qE5XzBlfFruGQ=
X-Received: by 2002:a2e:8ec7:0:b0:2af:b260:fd4d with SMTP id
 e7-20020a2e8ec7000000b002afb260fd4dmr3446530ljl.44.1686211569512; Thu, 08 Jun
 2023 01:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230531154836.1366225-1-catalin.marinas@arm.com> <CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
In-Reply-To: <CABfwK12_wC1t5J9c8qRmUi9H4GtYc6KR9oeJPi8ucK36prhUzQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 8 Jun 2023 10:05:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>
Message-ID: <CAMj1kXHP_57EOOYQtuL2NO9=7sHPxrX=c0ayYwHaYx9x9hxhJw@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Saravana Kannan <saravanak@google.com>, 
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, 
	Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2023 at 07:45, Isaac Manjarres <isaacmanjarres@google.com> wr=
ote:
>
> On Wed, May 31, 2023 at 8:48=E2=80=AFAM Catalin Marinas <catalin.marinas@=
arm.com> wrote:
> > Here's version 6 of the series reducing the kmalloc() minimum alignment
> > on arm64 to 8 (from 128). There are patches already to do the same for
> > riscv (pretty straight-forward after this series).
> Thanks, Catalin for getting these patches out. Please add my "Tested-by:"=
 tag
> for the series:
>
> Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
>
> With the first 11 patches, I observed a reduction of 18.4 MB
> in the slab memory footprint on my Pixel 6 device. After applying the
> rest of the patches in the series, I observed a total reduction of
> 26.5 MB in the
> slab memory footprint on my device. These are great results!
>

It would also be good to get an insight into how much bouncing is
going on in this case, given that (AFAIK) Pixel 6 uses non-cache
coherent DMA.
