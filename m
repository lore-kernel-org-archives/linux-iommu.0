Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88063F0AA7
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354493; cv=pass; b=R9IcDoD3t6w3Px6FKMW+y1UUeD/flvN3o8vmYLKde6a5ZwIJ2DrTQQNxVZo+SIrHKqiQaV99+IHRehp4nntGuZPevWwJXPfBs6dz0KNcMKYWGpPA+Eh3h4AI9N/nyefrIu4PnKcrqlkcPTBUyLiWbCJRlo4UYGkPYTerlESMnC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354493; c=relaxed/simple;
	bh=Bt0GjCbdHErDh2NSInWIxmaigd4B1HrIivlH1Nponi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD1wL0VGZvp36sE1eQtRiKGQaIwAkJWXEpBzkRcm4lX49MySw0jXmoC+tVsb6LFfSfivOkX5nEApvO1jBzR2RmrbNf47EBZMli2K1DTxl+USsJnbsN1rbFC7Lk6QRKNTqT9DYA0UoYKVVVlQMLSO524JIF5Q/Yg8yC1nfDbQp9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6hwdUg9; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6hwdUg9"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b6c45781aso664811cf.0
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774354489; cv=none;
        d=google.com; s=arc-20240605;
        b=Nw0LKidzkj4cuU1Oli48mR2FR3TV1pl96llN1nRb/z70Jl41pNjYN0jnulvEDSPpc+
         Ryw1H9F/2hTm4/tZJt1oEOBX73bthlmc3uZdggwcAhtwzY9i4HlpsaSW8pzK4XQgvn1m
         HYQL2oocYX5b24S24JeV744HAd4sUjpyoA3fS6AXC+lIQN+SjfbxAbBjlcm0BvEcC7vN
         fHW58GkOJ4MFhvl240OdQ1qT5KWrbZyNNKZVXC/77iX2XlWu6+i7P2A5BoLKEZ9hC1tb
         Wb93M+ax2Ata7w6xSmmRA+eqfZuLBsqRpVzfysjaHLfMfIXuk0H4NFSc6TjRbvdopS4G
         t94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=38JEbVN9/czZUHowiTyQJJi+NFgr4A1LQF8NnXOZQbo=;
        fh=hyDfAG/4YPnH5ArMh46rphz7ljcLiD40+kVsM7gXASs=;
        b=AoNj8c4AOF9zmju5FCTaLDG8LNfaA6faqVjVkrYoTUPi45Ve2dT8+9prnhfnqnW9Ys
         Gc1krjoABjKMWH1O+3HP5CTfpe4v88E8hKjR2kHUIJSMm9zIzLEIT4YAh0sXfI2yszPu
         e4NowooyZsnWSAS7pCl0OAtSarLJQ97LG7q4J9tIRwkRmCng70gJlnlx8RF0R8rNVMPP
         hq4TodZ10dTYje6MQi8cB/JpNeSR6HvfWbmVZ15T/uIw0w+6E1c0fWj15PETGr1F2vVk
         p35d+y3kknN4UxwViw6bXrF/QhjaeCZTk1fcS14pg6FA8cL87K0hq+JJAFZRyEGfBGQi
         sAhw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774354489; x=1774959289; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38JEbVN9/czZUHowiTyQJJi+NFgr4A1LQF8NnXOZQbo=;
        b=Z6hwdUg9zYVEpi5U/9Nyvd2ABHHFpKB3S+45N1SGRwlpsjU55br0Oionb6xC8QjL49
         jhLq+blPhfDxBHM992B3UaTb5ccLWARRIMeHxcDnB+OF8myt9UofMoLIjdD+lWcGCcIs
         m7Wf//UVWxMCEveDMKHwoBgZfpKuOvgS50eJR6/6iiMQxMlJzY4f/iNIpunXRidmDCdL
         G6DCKHOW9qLVASzaiZT2AAzmeoeYmSusHvVTVgFqXWB8yDM+44VcEGdJIi/tWNOlwjLx
         g4rsjDwVjzs4HJa/OZzFQV6478gQ5rFAT5VCuzyUA58ClyPhyrOF9ygEQhRmGVWpi3C/
         xzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354489; x=1774959289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38JEbVN9/czZUHowiTyQJJi+NFgr4A1LQF8NnXOZQbo=;
        b=Enl7Q4gR7UViwnvJ+AUyf+EjVAZ3ahGp8/BOOPQMEgHvMBGgrEs0pOjIB6+DqqNB1z
         cO+3yaHabe8FaWNa/vVDxExtLEAZquJCi+LX29IwhL7fUm3mrWt7Ny9IICDQjE602SnK
         MTgYd7TQHrjDIdKbgZdLwIw4zXsgZeUByYehUOvTu5Nhmb3D3IQB9X6Ckqy3v/gs+6WI
         9oa0PrE/kHINcU90ToiLmym6EwfxEgPQSuMc/QRyHaI9ceXHvryx+uakPYjmsEUV3FH5
         IqI5atrV2pZ/gpY9IzR7QEREslihIs1kpNNCehiblAVslW3yIwZmSWPD6c3fWTGfAfkz
         auuA==
X-Forwarded-Encrypted: i=1; AJvYcCVcXlMKm6yoVrE4rF11DyZtdfOAPyHUZlEaOOIvT/VWru1cSDTSSoAFaClQDOWWuZVFQ8cB/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYrec5msE6ynErDicsXzIYVfhSw5QZebLKQ6EmGjnWacChAdPo
	oq0LSNKltRdWwcgytQH1MLaL6Wy+35GMdj54fkKoPO180QivOJ3BByBcU02itrjag7qXYqdZscW
	Ssaml9z21egtsbqDxscW50vincRX07FdXeaQlc0Vn
X-Gm-Gg: ATEYQzxGvoli3G+DKkAniLhJdPdw1N27Nf8wVLSbXwBGtohpZcdC1bk/LLXZHoWrN74
	Bm1PSIn4QEPioUavX0VD+Xo04X93GW2qAjEy5TPihoBhU5+55YVZqxZaNQ5ORtzyeXK0k81elVS
	SaCBjZ9pmmYPcYA+3/yCKQhCXLdyHeK1CH5Rd2PXtsx7F0SJIcWBbMzqKuERb1tiMMuZtSFDkmX
	mi4x6qZlWbDxz2nIPZHB2g8UD+SFhhAHUldzGXVdGo1c8A9Bbndz13BEViz2hVWG+X1lIqlXLJG
	vGWfyPu1v7NhQfygtjvFa4gqkrSyrZxDNmIlnZwS
X-Received: by 2002:a05:622a:514e:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-50b6fbd1411mr15608601cf.8.1774354488033; Tue, 24 Mar 2026
 05:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260305123641.164164-1-jiri@resnulli.us> <ablV_f_l7wD2m63E@google.com>
 <20260324120057.GC8437@ziepe.ca>
In-Reply-To: <20260324120057.GC8437@ziepe.ca>
From: Mostafa Saleh <smostafa@google.com>
Date: Tue, 24 Mar 2026 12:14:36 +0000
X-Gm-Features: AQROBzDTh0ODj4C3lU1UM-hZHPuBDyd64_bmAvFt0-7PB-OKq8PhbYOrLNqJZ2s
Message-ID: <CAFgf54qoFhvVR2yfROGaTJmLcjuLACswVFv=trqgJwGb_DB3zA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, 
	ptesarik@suse.com, catalin.marinas@arm.com, aneesh.kumar@kernel.org, 
	suzuki.poulose@arm.com, steven.price@arm.com, thomas.lendacky@amd.com, 
	john.allen@amd.com, ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:
>
> > On the other hand, for restricted-dma, the memory decryption is deep
> > in the DMA direct memory allocation and the DMA API callers (for ex
> > virtio drivers) are clueless about it and can=E2=80=99t pass any attrs.
> > My proposal was specific to restricted-dma and won=E2=80=99t work for y=
our case.
>
> How is this any different from CC?
>
> If the device cannot dma to "encrypted" memory, whatever that means
> for you, then the DMA API:
>  - Makes dma alloc coherent return "decrypted" memory, and the built
>    in mapping of coherent memory knows about this
>  - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory
>
> There is no need for something like virtio drivers to be aware of
> any of this.
>
> On the other hand if the driver deliberately allocates decrypted
> memory without using DMA API alloc coherent then it knows it did it
> and can pass the flag to map it.
>

The problem is that the DMA API currently gets confused by this; it
can end up double decrypting the memory or using the wrong functions
as mentioned in [1]
In addition to the complexity it adds to the already complicated DMA
code. I don't have a strong opinion on how to solve this, but I
believe we need clear boundaries (and wrappers) for cases where memory
encryption is expected as it is starting to spill into the kernel.

[1] https://lore.kernel.org/all/20260305170335.963568-1-smostafa@google.com=
/

Thanks,
Mostafa


> > I am wondering if the kernel should have a more solid, unified method
> > for identifying already-decrypted memory instead. Perhaps we need a
> > way for the DMA API to natively recognize the encryption state of a
> > physical page (working alongside force_dma_unencrypted(dev)), rather
> > than relying on caller-provided attributes?
>
> Definately not, we do not want the DMA API inspecting things like
> this.
>
> Jason
