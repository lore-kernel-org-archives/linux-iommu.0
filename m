Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3643D383
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 18:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC77C4339E
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684433602;
	bh=yDLL5tj1xkKKmoFc1E/7+xQ4B2wCPYZH5V6TDDGmdVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uziSSf850u+mnpk+Vt1aKBnNp//kYAxFjsh+mMI9rh9QjaZmPs5eKQ4XQE5GfLbgE
	 UEwgqvsb2EnCYBJ+WtEluPwWCV+hPVV46gjmJBQi6lrUSJeeos+kY1S+UJH1HBt7wX
	 OAyKIz96thG8jVLS1OwjN9vQGfRIzPOY2q6K15LZjm9l+fRIKvAMVDv4b4kL1Fjwqm
	 xNjSbF5RIfcylAzkksZo7aa8v9S13dtIiXmf8ROLes3xnitKdB7Z8hjjRAaKbCBQAg
	 9vAwY7yxi9HaxERDSSIfE/BBL47l9kdIGDEc8cuuQV/6R9UWc4CGjnXx+vpMRdyLkO
	 qgnTrCHQzDRKg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f13c577e36so2811876e87.1
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 11:13:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDygjIWm7DWr40WGpmkMO6NUMOuMzRi0YDjV7ivjiKauNPb3z4YA
	qpWvgke9DLChGzHfL5GFnrjEqKzka5D3NtL0/mk=
X-Google-Smtp-Source: ACHHUZ5ZRa9ejECdwGeIRHQ+9cR034EbTY8WRobK152Od8eJ3dm0azWveVvkgRAsW3mfiYSG4a1O44PnOa9uH4m38gU=
X-Received: by 2002:ac2:4836:0:b0:4e9:afb3:d56a with SMTP id
 22-20020ac24836000000b004e9afb3d56amr39584lft.7.1684433600349; Thu, 18 May
 2023 11:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230518173403.1150549-1-catalin.marinas@arm.com> <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>
In-Reply-To: <CAHk-=wgm77p42Ow87pZf042+s5aC4S0N4TEPHQnrEyeg-aKtpg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 18 May 2023 20:13:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE+LvjV2fnTg=DHP2ynaqaPtj-YKKC1y1YS4Jf_DOCL3A@mail.gmail.com>
Message-ID: <CAMj1kXE+LvjV2fnTg=DHP2ynaqaPtj-YKKC1y1YS4Jf_DOCL3A@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to 8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Isaac Manjarres <isaacmanjarres@google.com>, 
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 May 2023 at 19:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 18, 2023 at 10:34=E2=80=AFAM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > That's the fourth version of the series reducing the kmalloc() minimum
> > alignment on arm64 to 8 (from 128).

For the series:

Tested-by: Ard Biesheuvel <ardb@kernel.org> # tx2

and I am seeing lots of smaller allocations, all of which would have
otherwise taken up 128 or 256 bytes:

kmalloc-192         6426   6426    192   42    2 : tunables    0    0
  0 : slabdata    153    153      0
kmalloc-128         9472   9472    128   64    2 : tunables    0    0
  0 : slabdata    148    148      0
kmalloc-96         15666  15666     96   42    1 : tunables    0    0
  0 : slabdata    373    373      0
kmalloc-64         21952  21952     64   64    1 : tunables    0    0
  0 : slabdata    343    343      0
kmalloc-32         23424  23424     32  128    1 : tunables    0    0
  0 : slabdata    183    183      0
kmalloc-16         41216  41216     16  256    1 : tunables    0    0
  0 : slabdata    161    161      0
kmalloc-8          77846  80384      8  512    1 : tunables    0    0
  0 : slabdata    157    157      0

The box is fully DMA coherent, of course, so this doesn't really tell
us whether the swiotlb DMA bouncing stuff works or not.

>
> Lovely. On my M2 Macbook air, I right now have about 24MB in the
> kmalloc-128 bucket, and most of it is presumably just 16 byte
> allocations (judging by my x86-64 slabinfo).
>
> I guess it doesn't really matter when I have 16GB in the machine, but
> this has annoyed me for a while.
>

Yeah but surely the overhead in terms of D-cache footprint is a factor here=
 too?

> It feels like this is ready for 6.5, no?
>

Yes, please...
