Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AA34A79F
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795988; cv=none; b=qyujISC8NpNadoY5Ct+Dm3QWWdJ6LbLsBRJ8D94iNnDzWEI8F2slC7XPogqbvXKdIg3MNj/mFE8H7Jt9xWa6+TCjoquWCkl56uTLlHkTDRC6X/su+vcaDErHjpygbNVw3NCrNFIkbe5t501ag3BFoW35ElyD/T1bTSnFUltWioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795988; c=relaxed/simple;
	bh=PjkR2tMQRuYn/ygqr2HVflV0gK3dD8M60qKBdwuHS8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4iwgk36X277fOPl+vxhy/+dbZy/57Y5xlRlzEVdIkRgYcLMBcsnG167bCZ+xL7G41M97humCKvqvNtEHSzPKQoYLCr/pav/lsGy6Dq1ubykvwvugoaYyIJZacZHdK7x0PHNcdemqbWglxSDsbJdfUx7wEmx5SbR5/ip1EOcOKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJOP5xqg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJOP5xqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC19C4AF0B
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795988;
	bh=PjkR2tMQRuYn/ygqr2HVflV0gK3dD8M60qKBdwuHS8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TJOP5xqgxdXpV2aQaEkmAtPWRBKcIjm2Hq4nvMViPZZRdEbwQkuv1exYg/gXJNAzQ
	 +7pfdLIN+EEBC+TBkNUJ3VUgTF/shJTSAjIzvXPGbEmzBtClQSMrqvYO3JRuiQd29t
	 ucWoafNVeFEycsfzqs1vS6ZK4CRotpRoJeOdqhHNcMBDyeWkju5ZRYYK/vByznsrIQ
	 VnjOo+aRwZUMktOoetOCjnRqCOg15GYIrquXPj37JowIHtaTrEWP+M346kfdxAfWH6
	 o5c64Ol5I9Lt10UhuJrxCbZnapQpWFO8Y7Wa2zmk6LsxJv/BitgLp8WnuM5SaE6d+4
	 CzXgvXfQz+zxQ==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6467ac59e16so1710037d50.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 06:26:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUARLGeT45F8OofaTCqd415VStbwymTKXub1dy7Eb/C1un6iwAEXniYRapIDMyy5xY03ue4qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2M6sTnF7bpimxQyElHHTpEPfkoTZq7fQ5jAsAkisTorWgKpB6
	TuypcaluLSPnGXrKNAfktR69CQ0pGIAlFFsPVxxF8jJZ95xVi2SaxlPDBJeqgZsg49FUaTYK9cd
	Rc2CDyctz9eNmBUIsu2LcqowV9Cfuv/A=
X-Google-Smtp-Source: AGHT+IE1AHMbjbBLRmE3oJob/4kE4EVVYQZcaA9cnEmtwVucD/JfcgKztpsKkpS1pfgNeslV7gLnm8DPgheIPd3GLMU=
X-Received: by 2002:a05:690e:5cc:b0:640:d038:fafb with SMTP id
 956f58d0204a3-64716c79f7amr1819221d50.64.1767795987264; Wed, 07 Jan 2026
 06:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260102155037.2551524-1-aneesh.kumar@kernel.org> <20260105175323.GF125261@ziepe.ca>
In-Reply-To: <20260105175323.GF125261@ziepe.ca>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Jan 2026 15:26:16 +0100
X-Gmail-Original-Message-ID: <CAD++jLnfWuoYavrOKoxd6=UvPhuWJmKzHWe76-FM2S+raUnEuw@mail.gmail.com>
X-Gm-Features: AQt7F2rZFEypFbURIrjAt4rTyOBrSrpSe9zI9wXLa3pFPoPxNv2R2a7h-FMGnY0
Message-ID: <CAD++jLnfWuoYavrOKoxd6=UvPhuWJmKzHWe76-FM2S+raUnEuw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: set decrypted flag for remapped DMA allocations
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:53=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Jan 02, 2026 at 09:20:37PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > Devices that are DMA non-coherent and require a remap were skipping
> > dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> > requires unencrypted access. Move the call after the if (remap) branch
> > so that both the direct and remapped allocation paths correctly mark th=
e
> > allocation as decrypted (or fail cleanly) before use.
>
> This is probably fine, but IMHO, we should be excluding the
> combination of highmem and CC at the kconfig level :\

The only way you can get CMA in highmem is by passing in a highmem
location to the allocator from the command line.

I have a strong urge to just patch CMA to not allow that and see what
happens. Or at least have it print a big fat warning that this will go
away soon.

I think this is only used on legacy ARM32 products that are no longer
maintained, but I might be wrong.

Yours,
Linus Walleij
