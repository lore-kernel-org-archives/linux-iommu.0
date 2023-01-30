Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B2323C
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 14:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1870C4339E
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675088552;
	bh=Rv7vpedtXmMsC2ZldBorrpLV/hQ3cPb3cZwp/JPOZMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PU5fThWqx7vIQyvz3mb74830sa8egZGsH2qeMRCRy43qW6nOElB5Nb+7LguvkSUvv
	 eIf/W6YzfJygJaSbS2P9Lz0XBYCRnIGQUIfcCD9aME9acc2v5mOAlrbBNIsC03gpFC
	 nEDTuaPOwviKV6EF4rSqLFqLY881xSSX6A5UjmcfmZxo/73Gltjtq+szt9dSpiqeFq
	 2Nb/PwncE1oGBgYKKaV3Iwb37qub0kNJ3ap4KDMUlMcx9wIXUycBGhRpccWySMxFmq
	 RbHsmckF7gub26TuexrKXaaxwZiAjEOHlmzDQeUf60+HFVTv2MRP6QMrGw/AUrg0f9
	 1PJcaH8dzXZcg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4b718cab0e4so161191417b3.9
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 06:22:32 -0800 (PST)
X-Gm-Message-State: AO0yUKUfijxW/2f4oI7jpCUrnyb8J5p5TlT/anu7/PXGFt6fhuzaqFI4
	Gt1uy4ozm1sd5zSPIEDJGyuvrj3h5IFPdHeOmF8=
X-Google-Smtp-Source: AK7set/iKN4GPoJ3AAU9c4a2d2Iu3bNsL3i+70I4GSg0waYe1ZW2WThCeen4GZUVB6daPLK/wVYIgd144SKxmDFciPE=
X-Received: by 2002:a81:6007:0:b0:50f:9101:2eb4 with SMTP id
 u7-20020a816007000000b0050f91012eb4mr701547ywb.182.1675088551824; Mon, 30 Jan
 2023 06:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1673978700.git.robin.murphy@arm.com> <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com> <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
 <Y9KRBRKdwSIRrvQw@nvidia.com> <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
 <6e0728ae-74a3-b76f-c5c3-6504e13c721f@arm.com> <Y9PxKLyQg/+ZrK6a@nvidia.com>
 <df59477f-3751-7314-40ab-9519dbfe0fe2@linux.intel.com> <14a5130c-3180-87db-5a14-2aaeaf97b7ce@arm.com>
 <Y9fL6gc4gZlQSzht@nvidia.com>
In-Reply-To: <Y9fL6gc4gZlQSzht@nvidia.com>
From: Oded Gabbay <ogabbay@kernel.org>
Date: Mon, 30 Jan 2023 16:22:05 +0200
X-Gmail-Original-Message-ID: <CAFCwf135w+iVn2qiucNrgig+cj=+kQiSUwxMcBPVYVPp-doE5Q@mail.gmail.com>
Message-ID: <CAFCwf135w+iVn2qiucNrgig+cj=+kQiSUwxMcBPVYVPp-doE5Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org, 
	will@kernel.org, hch@lst.de, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 30, 2023 at 3:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Jan 30, 2023 at 01:49:20PM +0000, Robin Murphy wrote:
>
> > All in all, it's only actually the habanalabs ones that I'm slightly wary
> > of, since they're effectively (mis)using device_iommu_mapped() to infer the
> > DMA ops implementation, which could potentially go wrong (or at least *more*
> > wrong) on POWER with this change. I guess the saving grace is that
> > although
>
> IMHO habana is not using the DMA API abstraction properly. If it
> doesn't work on some archs is their bugs to deal with - we don't need
> to complexify the core code to tiptoe around around such an abuse in
> an obscure driver.
>
> Jason
Agreed, feel free to change the kapi as you see fit. Do the right
thing for the kernel.
In any case, we limit ourselves to x86-64 arch in the 6.3 merge cycle.

Oded
