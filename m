Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD43332912
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807708; cv=none; b=bAWrUlAv557Jai0kPJxUkMLVoxPZVa/FUuGDtFgctJr3OkVJUGoqv5YTLKL9mRpUF+ZYkPGEnjsyvIUa3lerqbLLH7nwnQTsC8GqErsZGlfFqR3QHoL9SQqdWQDnxzPJ5y8H9NY35uZyohUJublVArpLlzsFIaZ3cvR+hcClg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807708; c=relaxed/simple;
	bh=4t4YiH3RDgSbwr+7duIJ7gbD2KOccVun3+glJXpoCkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLyU2UkYSlR0SNHq42vvH5wcokLoP/RYuUBC8lo7KgU9/y9ZJ1QYebsgMGLbqABwErHMSXfaHXlby36ilGW7eWcnVLVlqR7851v3u6ydq8GRuwSGAkTlBh7N+mD2Gw/GC0W93/rhUCrYDeqXqYd0ONfUi5AjRwao9HEP+aoiAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZov6JL4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZov6JL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7397C19423
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767807706;
	bh=4t4YiH3RDgSbwr+7duIJ7gbD2KOccVun3+glJXpoCkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EZov6JL4NTeTlVhW3y82zio8DhedIkh2LiI7/x/EHSghdr/Z5+eVaa4mXj6ywzint
	 kxC/zwA0kMRvSaq4U4N9rfEgWNp+WUplCNKuTeoMHyODUMad7MIfoyzGegVCyYjHA+
	 Jk/hSGS09LnC2bpbOPbG/+b/QnZo+2uN/fUvnGq5LPAWR2GRuiQZaN8JlESPHapIYU
	 N24hqZEZqckprjzuJz83pkwLv3cxMAICZedsWqXQMldzY02nMffR/MFp3/ISg/821D
	 /FyqXyZgKvnFbwaBpEqwxhcMk7rhLvLZHz1FdoAsag6Uv9Nrx7tizW9e4WNqp7pcz4
	 I3vC7C4iDftAg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fba1a1b1eso18280337b3.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 09:41:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhNJrbv0AsgOY/HoKPE1gxVS0QuC6/T2Q5WRWxfGIxpUPrT/45ckScS2N0FQ/RyUUUfvTHSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhHttXSsJEvdnE/VUuqN6qYOyquYb3+0P7P5I3LdR4HHzppZPy
	j6VsPCqtI5dFvTGCs9kN80d+UWQq59MIKNOLu14+ThZ5GgwZSu+DaRxrhBL/axYBPIe3oPNY5qr
	txhA1kYHrFxMIahys9vfcCRgaIzSO7/w=
X-Google-Smtp-Source: AGHT+IGsguoc2OD9jR+lhkP0cyXneD2j3WkajzaCsAhgvkXyPKqPIc3IYLc9ZaQy1xExKVhzQGpslehZO4Mz1R7bMlA=
X-Received: by 2002:a05:690e:b85:b0:641:f5bc:692e with SMTP id
 956f58d0204a3-6470d2f4d8emr4895060d50.39.1767807706046; Wed, 07 Jan 2026
 09:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260102155037.2551524-1-aneesh.kumar@kernel.org>
 <20260105175323.GF125261@ziepe.ca> <CAD++jLnfWuoYavrOKoxd6=UvPhuWJmKzHWe76-FM2S+raUnEuw@mail.gmail.com>
 <0dccea36-0d79-42cc-a12f-5a890061ff59@app.fastmail.com>
In-Reply-To: <0dccea36-0d79-42cc-a12f-5a890061ff59@app.fastmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Jan 2026 18:41:35 +0100
X-Gmail-Original-Message-ID: <CAD++jL=fwYJ6onVsrM_=ffuqwR2zLJLJNSWWmDM+Ov02Gf-DyQ@mail.gmail.com>
X-Gm-Features: AQt7F2o5oAKo7zazCkLaGtEePlEzathH2ISkFU2s86lOjyg9na27Zjr6FYJYKhA
Message-ID: <CAD++jL=fwYJ6onVsrM_=ffuqwR2zLJLJNSWWmDM+Ov02Gf-DyQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma-direct: set decrypted flag for remapped DMA allocations
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:04=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> On Wed, Jan 7, 2026, at 15:26, Linus Walleij wrote:
> > On Mon, Jan 5, 2026 at 6:53=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> >>
> >> On Fri, Jan 02, 2026 at 09:20:37PM +0530, Aneesh Kumar K.V (Arm) wrote=
:
> >> > Devices that are DMA non-coherent and require a remap were skipping
> >> > dma_set_decrypted(), leaving DMA buffers encrypted even when the dev=
ice
> >> > requires unencrypted access. Move the call after the if (remap) bran=
ch
> >> > so that both the direct and remapped allocation paths correctly mark=
 the
> >> > allocation as decrypted (or fail cleanly) before use.
> >>
> >> This is probably fine, but IMHO, we should be excluding the
> >> combination of highmem and CC at the kconfig level :\
> >
> > The only way you can get CMA in highmem is by passing in a highmem
> > location to the allocator from the command line.
>
> What about those that declare a "shared-dma-pool" node in DT?

Yeah that thing is really obscuring the view :(

That's usually just defining a size and alignment and pick out of the
existing core memory, sometimes an 'alloc-range'.

The actual memory extents resolution happens in
__reserved_mem_alloc_size in drivers/of/of_reserved_mem.c.
If you didn't define an alloc-range it will pick from base 0
so as low in lowmem as it can get, essentially. (AFAICT)
And I guess it will usually get some really low lowmem
then?

If an alloc-range is specified __reserved_mem_alloc_in_range()
is called and that is considerably less predictable and seems
to mostly concern itself with other fixed allocations and not
whether they are in highmem or lowmem, and might even
theoretically cross over the lowmem/highmem border
AFAICT, which would be a major headache so I don't think
that happens in practice.

I did a grep 'alloc-ranges' but now I'm a bit slow in the head
so cannot really figure out if these will end up outside the
linear map or not.

Yours,
Linus Walleij
