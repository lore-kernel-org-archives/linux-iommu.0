Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793208282;
	b=Uk3oJM++uHsVGHv3jSdiUgX4WJad4VIiZmWIhRkGUG9a8eIJSZ5yAYO1q5+SrvxwssiO
	 M4nsxzSXtMhJ8ikpszr3wA7n6BgUFqW7dmcpU4fxMDrBRsGBUuw9Lpink/N6r9ziU2R8z
	 dJs7NmWq6xVwdFrPppDwmDzd+tW+wt7x8XxvMoYEKUEEHRCf47nLbrcQS0bw+irJR0Acb
	 7XXqzNrr5pov6l3l2EbUq9ReYFKYeoUJL/vU1JWaRJc9yL6h1h2bUyApPh/E5YT8wSKd9
	 sEGmPa8pW4CN21QY74f/O5nmCMh/BOG/czqOycrrqSz1NnCuc30D88pGFK0kP6CqAfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
	b=O3S5s8hxMcr2o08acqg1QkiPYnqe/LPzTQXTAegA/idk5basKBZJ5vyZi4zPsc4ek/j5
	 n5Z+813xOrBHxM8Z5VKzG9KhUBqlovb+B4dY9wHX+YqMdOfHoNb+66BR33Zpw8lZaiql2
	 ukrX0yr42ZEseEb4rya7zk/JuSV1CJvKe7CWI+jLV5K2idj+ylJhszEb+hPdUlXAvFTcS
	 91EHsZJUo4NBDzPJ/HcBKRE+IF4wAZrBXVH9wraipTxGHnHS/6LJISyGu3HD/D7Nf6sSL
	 /tLx12cBtyQdOdNIn5ah5e6u2zVFVQs+rBJZYp+VkBKTsVyGNi1kaZXtYFf3V+NC+vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MZCNsX93;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF65606A321
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 17:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF65606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MZCNsX93
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1846bc43c28so1455403c88.0
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208281; cv=none;
        d=google.com; s=arc-20260327;
        b=dSV29cPO0sJg7iF99ft1cOS8+MkXUrR3YVsK5n0Q1khDIEq4272yGV1XfrEX6HZKZ0
         gskFT+tvKHYyQIo25aDt0j9viI7CxLbIztRmx9TyXTnwnmXINBOSpa48EvIFmdQAlwas
         KnorxNUx8C6AwwCsKdeYhoOMTUBoNKqeON/X/awvt6HN4bYgPPu3ycObUzXxtmfleGgj
         ucOrOi0POfVItc+wdxZvXKc182Uajq3swStuhxBfzhyo1U1N6MhFTPGxeczMC5Z160Y0
         gdrFETY17EpgxSojAQW0/Czci3upVFM5vkt1hW4GC77w7X0QI+yqN+5Tay1fC21LKMG8
         cNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        fh=hRabATGRs9JaVRqZeD1mwZ7mx85neUJQvM12sMRCHXI=;
        b=VAjMHfxzWsIAooS5z50E7J+9OYfAitpCg4p6ozL3TQVMPmPMc/yz/asXxQyxuHmdez
         FVgn//5pKhFYSAs0yfuxOVZMguz8wcXX7kM8x2C7BxT9HElnCTlBs8M4G8N7SSXGt5A9
         v3Yn26I+IFl5B0iOy2xRXzwU1Mq80VLafG7iMa1hTg6d1LPrzWFRa+toojXPjrr6fvhx
         WZeJVECmbFArh5SHi23WPuOHkxusO4+OU5n509zvM9HOCJGBIJiawIqHamSvxrDerGFp
         ueaZ20sd08QL67GN3eNdOM6WlA65+azmkWNmdroROMblpjkKVvF2rIMJh52KmIx8pHR0
         Q62A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208281; x=1793813081; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=MZCNsX93Fk7cMVntu4J/5rsNvIKWfDQH7AcIKZtPL0/xEOnusNMqY2FYRex/poEBYR
         h6WW+gdjKLe/idJydKB9TGoXS/jElqm6eN5loHXm9vYv5PokvQu28zagmXVZvIizipea
         EQbPU+Z8iJ206WBc71Zhyl7TCt84/EwDeTExRPGFZILO/9kQ1lMwARuYMFvKytWc/jIx
         hqT7tIzADyHzzv27POIE4EgiIjAG7vyhucwBjJQ1Qc2x7X1FrJuSl6AH8naNb+9WKoOG
         5v/42ssDVASBFujH708av4X+SQ0klKVDn4S0Mlt1z6l8+OsU6Mtwhnx2WmlhJTgU5z7T
         8OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208281; x=1793813081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=PWIbKDPL5aEebUr9p44ERISk+u8laJyZUZblKfD0qCNeGpixDijHwL+Qw5eeNUDsDH
         CkWXovJW7e+QFLDm4ywL1RjPr+UxSxlbmBKCpkTDIa6+CitukAGcWnAB/OpyYilvwjuT
         6SSZGooUFhOCgyqJbAWjhDRb+9GLAj427sgicYexgsn3RoM66AnZhAJ3cr4ld8fN6e3M
         a7WOLpfdOpEpUxmtzkmt4iYSmIA7x4OKRKyMvcFqK9YhQDxhCu4zfJCXBOW5jsoQ4Zu+
         sBwEu8PQt+t+OMv2zMX4jfxFyFIbi3Tq7yZCuNBr2GH4wUAxsLuZ5F3S2K+U/fjUaQ4V
         2Hqg==
X-Forwarded-Encrypted: i=1; AKwUvBy9gVdl6v+N9p80CmBbsuT5aRpHtRVHelypftveKPhb1xjSIbIxadjknjEJY5bgUK2z+IudvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIuIUCZLbHM8wbOWpkptppYbdKcd0TOyYgdIbcF0SOTc6fW+AZE
	2UL6jtw15xsn2fKnTyxzCwl0LunlrJVp8glYRHcmxVgT6Irqg7cu44ADLPOXp7V6o+gzgMCjvCt
	LweYcKpRKEfy6uqAeRc97/S/mldIXFJX/+JtdhCX7
X-Gm-Gg: AYBFou3dk6rdQltBiOmzyhhBVoB9ebCRnnS803a4ngLAevCLC6FyiRXePVAIxI/FoMo
	4K6mDOXfr278OaIxQsX9sXiZCVajvlw4btkVT48QTumUdc/2l71Y0L+iOHNbNewSrFn3cLzvudj
	QArBkRGaZ8wQ61+WNZIEAwRFw2raPiio2WKzyUtoOL+3lAwV0jNQkV76qFvkr2/OV54bm/ZGQUq
	aOUSLOeX+QStdYpvrQowBY1l79b8D+tT7qHKxyVTFj6rDW0CpoGUiF8OL5SNYyN747o0lXwVFYt
	KDsX7c7NGHOsWqL8ToCVGBF+Atqxm2LEemma8eccR9JhEJw/+eswtAlsmOaJmY/+2qvl0/ghtPr
	HnNR7qq71flSK/VvIxPl95CuAGzWLZIVa4/aSvA==
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr3454907c88.13.1793208280541; Wed, 28 Oct 2026
 10:24:40 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 28 Oct 2026 10:24:10 -0700
X-Gm-Features: AclHuK8mtDBrFSk6j3m-QjfmBC0Hg3WdAbJ_jeR4OTytlWOkEsZuDbAniPHpdm0
Message-ID: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, jgg@nvidia.com, 
	robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, 
	pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Mon, Oct 26 2026, David Matlack wrote:
>
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google=
.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
>
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

+1000

KHO block should track the entry size automatically and not rely on
the caller. Otherwise every caller is going to have to store the entry
size in the struct that owns the KHO block, like I had to do in the
PCI v10 series :(

> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
