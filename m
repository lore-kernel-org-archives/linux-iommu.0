Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83823CD8AB
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132599; cv=none; b=QxyPHs54bOHT5deZsZMBB+J56UTafc4EOWHLhGiTLUJHZU8tNj0eaHS8AfBaz6se+LwqTfFHxGc3oXANTF4Ns54HIfHraO71WM8Nszq5Lyjbdb2qG3Zs+xmSmrvVuyUtYmrGAXtTk8AARVAZ9Sz9YGKQeE5omP1DdkXgDx9mWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132599; c=relaxed/simple;
	bh=ZmBGSEKxrm2sD1+zHMG9w0btvdw9ZsL148HNd6FLqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5UfOuNZOMc7NKNEd/vtntFIWKno+NgGsYN6F7F9J/RscizkiXBNtJOSiTRh1DKA8+euPvgxTIjM1m89TTy7OAfD6edME0tfaQnqUdkHwhcMjZdVlGnbtAItRx8o8q2C1y8OYzTr+oUKmdiBK6AhMuydOlWuJuHpEXduB8CBAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjGKf2zr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mTVyePCt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjGKf2zr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mTVyePCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775132596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xRxSNukj518ppA3ZO+j946SBDUenrVVHerZheyJEcDQ=;
	b=LjGKf2zr/aRN2tOMCkH/oG/HIdRBC5uKqP6cQPGO8HHAZEo2aWMkwGJPnwtQMjQ1WfvEss
	X7lW/Qvv5sFC5A2wc2MmRq7OE13+Oly3HQBVJIRIx7h90ZT6ZRWNfdQ8D6Qkxm+ypkkJpy
	vQaBHQ1oaIwxQ0p6GN0PTaVV4PLNuRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-XKtiisg3OL2LCZUpC9qgbQ-1; Thu, 02 Apr 2026 08:23:15 -0400
X-MC-Unique: XKtiisg3OL2LCZUpC9qgbQ-1
X-Mimecast-MFC-AGG-ID: XKtiisg3OL2LCZUpC9qgbQ_1775132594
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d03bad787so808171f8f.1
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775132594; x=1775737394; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRxSNukj518ppA3ZO+j946SBDUenrVVHerZheyJEcDQ=;
        b=mTVyePCtO5uGPB26N1E+pa80zhA9Pz/913K17i8cT6t1XzAuG4roVhuSY2D+aZe6zf
         nhehGhWP/gQ1SJHPxHNyjdDtLiH8ueKlo67HQfx2mPprsid/2Vu8b8Gya4+eZhLXO4cN
         S/qQRn+xah+iBhILTtIXMu8wnq9QxQkXG/pnupvNAWNQCBQYFduhZH4b+KzKG2H1mf2/
         Jkp85YRyXrTUCs0G/v3YvReCeDtkm11eoTrX3ibg4q4zEKHg6fNXtySN/wTVPaI5WUHq
         bATDzKHL07mkQbLqB19iW2/ruqFuXr0GxM/vOwbo64aA6qckDnqtZ8w/zUfPZLuxfVJ7
         BSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775132594; x=1775737394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRxSNukj518ppA3ZO+j946SBDUenrVVHerZheyJEcDQ=;
        b=Kjt4J8clzMzt5bIcOIhhKI1S4i+zxtLwGCjY7IflzfurBcEtO9JaMiLw4+CDxzAv8A
         EprQiGdWOo9v2+9YF1po5lm4Xi41CxQlrMeayVOjZIdjB7QaFnqgEyNq0ecUZAPaNWF1
         EU4YttYoaTLScIQcRnoyFppfx/IVyuWQK+xm04fNgavYkJxPK9hsA0fbOHDuRbvlFqTz
         BtT5jf6dVKobYAXUkiQLAVtcKpFn7veMmuu2E9rrfCwahLjlytHdTq66d86NcJtuYJoe
         M9m9XIeFWrbHvMi5/HzQg0Tu/yBlCS484Ny+LYEyERSXWYYYjQO0Vj1qbD6mrNwwZtvY
         AdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvjc8GyG51SFinbS+r/4jgFyzya1GyIGMOJ3VXjZY1PHWc+vUs3hxsoHyYBtx/FBlWnLOacQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBR6hvwjtEgW43d67RtH8IH4oKa6C/5lJZ/vKwi9i621nyTg/K
	Lq+EoHXydh7ohdKvsFMsNjaR1KvJAW9ZD3S5nJ6kQS1jUUVKcwX27GA3XFzVLbBpi6pe7u2R8lU
	AIkRgClQQ+yxN922iY9LbbYoH+lXXzAHB86vjYYPhlC6qzv0Bm5jzTbzB
X-Gm-Gg: AeBDieueo4zlaIj+aoQj+EMrYPu3n3h8Kc6Wn8xrrN6+pZbmlmEJR+CPlu07G3LkeRG
	Daq68o7JRMHBeP4NdkteTWn/j8bTIa+PbZFC3CXKnSdD4fTtDeb1W9VCWAq9ZqLAa+ucSTc3brA
	so7juUHB6EVfbpGlK67Zj5OGuDQ6CvD9lGMCSF3qIb9Z9rE0ZgsGB8Lus7HisLyHh252Dg1fnr2
	598Mk1Ieo024uwUeOM7021ZcoDyJahdaj+7oAZBwwkShSHyndCyKPFgfG94UzUEXtjdwVJV9s81
	fHWhuWrLNBx8ypCE970cLQS8JS4RmzF6M0O0VN5/g8zZUMXz5R4CfNyKKYWesm/clN30ZPHAtw=
	=
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43d1505b105mr13705399f8f.11.1775132594216;
        Thu, 02 Apr 2026 05:23:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2409:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43d1505b105mr13705319f8f.11.1775132593703;
        Thu, 02 Apr 2026 05:23:13 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d214f2b63sm4510096f8f.28.2026.04.02.05.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:23:13 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:23:12 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
Message-ID: <20260402-discreet-glossy-perch-bda4f9@houat>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="e65sn5i4kwgewwdb"
Content-Disposition: inline
In-Reply-To: <20260325192352.437608-3-jiri@resnulli.us>


--e65sn5i4kwgewwdb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
MIME-Version: 1.0

Hi Jiri,

On Wed, Mar 25, 2026 at 08:23:52PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Add a new "system_cc_shared" dma-buf heap to allow userspace to
> allocate shared (decrypted) memory for confidential computing (CoCo)
> VMs.
>=20
> On CoCo VMs, guest memory is private by default. The hardware uses an
> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> Intel TDX) to control whether a given memory access is private or
> shared. The kernel's direct map is set up as private,
> so pages returned by alloc_pages() are private in the direct map
> by default. To make this memory usable for devices that do not support
> DMA to private memory (no TDISP support), it has to be explicitly
> shared. A couple of things are needed to properly handle
> shared memory for the dma-buf use case:
>=20
> - set_memory_decrypted() on the direct map after allocation:
>   Besides clearing the encryption bit in the direct map PTEs, this
>   also notifies the hypervisor about the page state change. On free,
>   the inverse set_memory_encrypted() must be called before returning
>   pages to the allocator. If re-encryption fails, pages
>   are intentionally leaked to prevent shared memory from being
>   reused as private.
>=20
> - pgprot_decrypted() for userspace and kernel virtual mappings:
>   Any new mapping of the shared pages, be it to userspace via
>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>   of the direct map. These must also have the encryption bit cleared,
>   otherwise accesses through them would see encrypted (garbage) data.
>=20
> - DMA_ATTR_CC_SHARED for DMA mapping:
>   Since the pages are already shared, the DMA API needs to be
>   informed via DMA_ATTR_CC_SHARED so it can map them correctly
>   as unencrypted for device access.
>=20
> On non-CoCo VMs, the system_cc_shared heap is not registered
> to prevent misuse by userspace that does not understand
> the security implications of explicitly shared memory.
>=20
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

I'm a bit late to the party, sorry.

This new heap must be documented in
Documentation/userspace-api/dma-buf-heaps.rst, but (and especially since
it seems like it was merged already) it can be done as a follow-up
patch.

Maxime

--e65sn5i4kwgewwdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCac5frAAKCRAnX84Zoj2+
dnVEAX9CFXx//98RE08S4/htofGJDNunF07/14IluU1iYb8+94vCMi2iUvSzXSKI
zbgrVRgBfRy+pMU2nc+zOonhVfFvK813bX4cN9vLtMfH0/h/fKnFJKCc5msL12k4
8g97/3uO3A==
=FGaV
-----END PGP SIGNATURE-----

--e65sn5i4kwgewwdb--

