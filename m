Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DA45BFC
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG9L+PiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE392C433CB
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701356217;
	bh=GpBXBuO6iixv10ETLZMpn7khg0ZMspsWXBNle1mq37U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JG9L+PiNhBEsYN3YXwoulUb8YGDSgyoa+ymRhVQUvMW4Yf1ixX7qex95f1+P5Ebxc
	 k7in+bmpb4AxWMzyMsBD/2r6Uq30Rezh/qPnb6B18rc9vDUQouHpE+ums7sq8Z1lnv
	 YwszRT5p4gnDR5pALd7nwbNPHS1G3FhdY748c06N5VnqjHcFqwKbdekONwAPcK02Fi
	 aIIIJmOAKa3Eq5bS84D7qMhLoOlFLoE4ItQ/z+RhV/1fPOleD4mXRLpD0xARsUocNa
	 eZrdYwDTwN2EUegTBAKOLBiAi0WJN+hvNI9bqu0EhZoA8QkX43ThbsL3WPoAMpVYDO
	 Rf0QDJRGU9GAg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c9c581596eso10512601fa.0
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 06:56:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyvtB52Q1oyweCe7inRZGaGnv5qugMyhpInPkaZJoVx/3p1rvmS
	aM0ThIKVSBIA8/xypYq/rujrFjjU8d7AH0Oz3w==
X-Google-Smtp-Source: AGHT+IGo9+hwZbxNr54yXWh69cfY32jjew+hEBiuusC6kMJDQptRw29wukfMiu6+gPSwl3ItrcFP74MRuMgWAcqeURY=
X-Received: by 2002:a19:ac0d:0:b0:50b:c42e:7c4f with SMTP id
 g13-20020a19ac0d000000b0050bc42e7c4fmr1756657lfc.15.1701356195582; Thu, 30
 Nov 2023 06:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1701268753.git.robin.murphy@arm.com> <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
In-Reply-To: <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 30 Nov 2023 08:56:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+V_=um5+Kz1AofDxx8_gqdWGeYqPdaxMDV1HiPsvq=A@mail.gmail.com>
Message-ID: <CAL_JsqJ+V_=um5+Kz1AofDxx8_gqdWGeYqPdaxMDV1HiPsvq=A@mail.gmail.com>
Subject: Re: [PATCH 2/7] OF: Simplify DMA range calculations
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:43=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> Juggling start, end, and size values for a range is somewhat redundant
> and a little hard to follow. Consolidate down to just using inclusive
> start and end, which saves us worrying about size overflows for full
> 64-bit ranges (note that passing a potentially-overflowed value through
> to arch_setup_dma_ops() is benign for all current implementations, and
> this is working towards removing that anyway).
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/device.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
