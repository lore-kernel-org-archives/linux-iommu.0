Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112AC8CE
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751247146; cv=none; b=edwY9MHIS0S4qt+3RVglRkSUdO8DO5IcdqpJxZ0bLWZo3Iv0eBdRnKt/DHoP0fKxs8cUJkIoCFNBw2he89wIxMCH6R6s2g+S6Eywg92Z6nAUXr6/pAFwwbdsxBSmkgxCxlclOJxgNhVV8963Jhz/+tunRq1nvOy3l39/TTUL+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751247146; c=relaxed/simple;
	bh=PdbmSrnBaljKSjVuz2OmgriJvaxALYThsxW+O8GzZqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMw0p+B3fc5hf80w1W27BMsFrcUEOiE/T7bP49A+2u23qwJf8SzrcatzoEqhm4Sz4BtHbOierwC6HNq7vahIXCphqPQJhI0cAYg4SietWFtfiabmaYnSoOTfik7kIVsa9zoTV0QE7Dl4llQMbkblAkPBY6bNc4XbS2QE1Uyjiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATkSKLM6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATkSKLM6"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b1fd59851baso1291035a12.0
        for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751247145; x=1751851945; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwxo+Mz3IvrzaosTpE+nrtogxa++aPCEgx5JYVoi1DE=;
        b=ATkSKLM67KN3smYtjuQVy6glP/z11UqRnZqzNkYplPJD8rO/qDDgIBJonLFr6fyDKM
         4ACFwhRXWUDtvAZEiq/vUJGaQmA3FVCawTrgjpo7Lhe41OWeFK/iVP22lrOsZU3A/Dwn
         11S0qTfN4zetUXyky9wspDKJel7THVmJK3M6WGgVZKD4wQCeVa/CKf/A0UqPPuLbp2A1
         HuTfnSWz9ZAvvvwmst5yFBQfKg2MYNkORiD2C2pL/ewN2xMzgu+B4FJtyUFnt2ft7NJP
         qkEFL3reukV/4SZ6Gqw6Tq5J4MkIMwA03zK+7Qlg0iRkv/52rrjl34vYAumXM9ZwtGZm
         nhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751247145; x=1751851945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwxo+Mz3IvrzaosTpE+nrtogxa++aPCEgx5JYVoi1DE=;
        b=hcvQtjHEua1Eu9sKa36vAzbZSrgh4J2KEtuimH6zZYAWrh0zetOZ4DnCFgY/DRIqBr
         a9dS0cvW91thjGUKqeK/nUUeAE9MUqg4ad3S/EGkeHdc/4AwJdU2JQRW13fCZwG1W7Jz
         3ozcjMtbGFTm5pDX+kTF8vHrfMcFuda1/apkTJvvwNli9cOOxG0nxr3Pl+D7sQrsFBhP
         QpVKEI6EN4BG7wVw81fjTXCrb5a6d4g6Dhz8bI/wGj/Aj9fz2gR0K9WmbUchqfEM9kQl
         KT5jYgFxzA4gwZQA/Wbavpgc/Zhah7qJEwjIW7IHQ+iggnEts66f3nltYTHj/kUMozLr
         Ngaw==
X-Forwarded-Encrypted: i=1; AJvYcCXG/aSndoXlA4zpIXt7qYdbnprWCzGjsfnyWMqQeGvGW+qfZOX5cOSCR+BuXBVEWoSxwOzbxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7NXNYwoAZs5VBtc1I+TMGvDnUWnLWre1xOOuSjhOBgKiuL0si
	AVX51G/zg9QsKmjp13pyozkeeQHddb9LmHCc7O3elEGttgcICxhzouXv
X-Gm-Gg: ASbGnctDsjS2DG5czmxOydxKZXtA/rLigL5tdf8X0V8zD0rnh6tvRTUjvLnHMpMjcL4
	sR0BfE2A1nPjNav6cjQ75280JwmDNFRp/gX4eek6EdPT0BzdTHiOe4NYpfbwEKyiaFq7hs3UzOs
	wURkgKvKIu88zj6wCD7DUqWsx9CTHpqn5z6zbabB6t/ciWK7jkHWDZaafioaYZxNT81t8BCNUyz
	7wymNa7mKPRceP4UK7NFUafdOQAlPHSCfGXYQ1FSfv52VhMuZ/6Mx2h1Ke9FR6Ljj8ktkEWl2ew
	lEbkSKl8IW8ty4NNQdf06HZm5D8BJxcVJl38iHM/mwO1VB4nW5sO07maXkd/XfCmF8fuvmnC
X-Google-Smtp-Source: AGHT+IFZCO9JUwt3uc3yB0stvOczNjE1Z46dM+SWxPKuf+S1ol8ZiAtkuzHavPc/X4mafB35eylK+Q==
X-Received: by 2002:a17:90b:1dd2:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-318c92f26abmr15843348a91.29.1751247144552;
        Sun, 29 Jun 2025 18:32:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315edcfd75dsm3332769a91.1.2025.06.29.18.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 18:32:23 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 951B5420A813; Mon, 30 Jun 2025 08:32:18 +0700 (WIB)
Date: Mon, 30 Jun 2025 08:32:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 7/8] docs: dma-api: update streaming DMA physical
 address constraints
Message-ID: <aGHpIiKWDr0T-FLN@archie.me>
References: <20250627101015.1600042-1-ptesarik@suse.com>
 <20250627101015.1600042-8-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HrIK/LW9hGVtLpKi"
Content-Disposition: inline
In-Reply-To: <20250627101015.1600042-8-ptesarik@suse.com>


--HrIK/LW9hGVtLpKi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:10:14PM +0200, Petr Tesarik wrote:
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/=
dma-api.rst
> index 9fcdb160638e0..a075550ebbb54 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -184,6 +184,26 @@ segments, the function returns 0.
>  Part Id - Streaming DMA mappings
>  --------------------------------
> =20
> +Streaming DMA allows to map an existing buffer for DMA transfers and then
> +unmap it when finished.  Map functions are not guaranteed to succeed, so=
 the
> +return value must be checked.
> +
> +.. note::
> +
> +	In particular, mapping may fail for memory not addressable by the
> +	device, e.g. if it is not within the DMA mask of the device and/or a
> +	connecting bus bridge.  Streaming DMA functions try to overcome such
> +	addressing constraints, either by using an IOMMU (a device which maps
> +	I/O DMA addresses to physical memory addresses), or by copying the
> +	data to/from a bounce buffer if the kernel is configured with a
> +	:doc:`SWIOTLB <swiotlb>`.  However, these methods are not always
> +	available, and even if they are, they may still fail for a number of
> +	reasons.
> +
> +	In short, a device driver may need to be wary of where buffers are
> +	located in physical memory, especially if the DMA mask is less than 32
> +	bits.
> +
>  ::
> =20
>  	dma_addr_t
> @@ -204,27 +224,13 @@ DMA_BIDIRECTIONAL	direction isn't known
> =20
>  .. note::
> =20
> -	Not all memory regions in a machine can be mapped by this API.
> -	Further, contiguous kernel virtual space may not be contiguous as
> +	Contiguous kernel virtual space may not be contiguous as
>  	physical memory.  Since this API does not provide any scatter/gather
>  	capability, it will fail if the user tries to map a non-physically
>  	contiguous piece of memory.  For this reason, memory to be mapped by
>  	this API should be obtained from sources which guarantee it to be
>  	physically contiguous (like kmalloc).
> =20
> -	Further, the DMA address of the memory must be within the dma_mask of
> -	the device.  To ensure that the memory allocated by kmalloc is within
> -	the dma_mask, the driver may specify various platform-dependent flags
> -	to restrict the DMA address range of the allocation (e.g., on x86,
> -	GFP_DMA guarantees to be within the first 16MB of available DMA
> -	addresses, as required by ISA devices).
> -
> -	Note also that the above constraints on physical contiguity and
> -	dma_mask may not apply if the platform has an IOMMU (a device which
> -	maps an I/O DMA address to a physical memory address).  However, to be
> -	portable, device driver writers may *not* assume that such an IOMMU
> -	exists.
> -
>  .. warning::
> =20
>  	Memory coherency operates at a granularity called the cache

The wording looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--HrIK/LW9hGVtLpKi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaGHpHQAKCRD2uYlJVVFO
o7BTAQD2guhFoVk0F3IFsbTS/6Ol/17jQ8zJ8Y1DrFSsn2CrUgD8ChTz5+jY2xNj
g3nM93NHjiM4P2S06XM2BOx7i7nPXgc=
=aOWE
-----END PGP SIGNATURE-----

--HrIK/LW9hGVtLpKi--
