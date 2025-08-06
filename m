Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F941FF1B5
	for <iommu@lists.linux.dev>; Wed,  6 Aug 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513914; cv=none; b=XQf5YDWs2VQDDzq41OzeGSNAHW0bdjsJtd0R5bToNkk7eLc1CmkvcOsf0mCmtkkLdot4PtsP8W1bgQeYlzxufBXZLWkFS5HAOrTKrweshJQQfkuCaiZkzxX9tUcv/n9CZrBdNoQDaFxzP8PV8CHkF4OvZwXWSjfyQC7D5PD7wrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513914; c=relaxed/simple;
	bh=i3B+58L5SlA4xTPdUp3E2qzr23/QAqw0rD8uvE9JwXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVsP7dbOC8Q/+b4yujxchrkVBA1uXDZMAWD7pd8p3Lq1Ql/gh9O0nqO4bv2s1cW2fZY8qKgQBVBBhw78PGoKXGL+GZjNUW8saADa9zPVV2jxRICzzSNWOGF9+q6SiXnSlJnY3v+xJv6pUX0KcuB4Ouu+d6GF+VS59ESE/CO1JYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqDyPvtk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqDyPvtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754513911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFNdR9gJvxUJ76WkzFWy6OZiky5m3qPp0Fyvysc9k2k=;
	b=RqDyPvtk7mRYQFeZYbX4XVaO1ZfuPpuIZncu7aPnyVXPTNibSw8sv5iB4qKSq00dEkj9EW
	YyobAOLwSO+OQFYZJwEt+Ky30a5+whsvrJd1J5ImUInQJ9TlEZYfEBFORXvGspCdwKOqkP
	Fr8iJpnvGVNdWc8IJfdUrU1I99Czl3Q=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-DAkhch5BOQuYeGLHEjV04g-1; Wed, 06 Aug 2025 16:58:30 -0400
X-MC-Unique: DAkhch5BOQuYeGLHEjV04g-1
X-Mimecast-MFC-AGG-ID: DAkhch5BOQuYeGLHEjV04g_1754513909
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3fdd9298eso727805ab.3
        for <iommu@lists.linux.dev>; Wed, 06 Aug 2025 13:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754513909; x=1755118709;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XL3JtSDnypcZCdbt3A90Mr99TpavO/k4/VrpLyiBez8=;
        b=iEltcPTCg4nRYKNDqizMRxgdT9ZwmwQo7JOVJeK1zh8iZHV+KR4qALyzh+6aJQAFn4
         ZAkm6lcNyKvZOhSzy1FKlePfYQXRteF+L/PW3EtQtzMxGfyrv3Tw+UR5lKRsSIQmOlRY
         08IkI7lTWTOTA+qWOkTScWoSL7wEiwXlTyJgLLzl9Ds33cleRdOhG4MCscFW4JA1FOAX
         x2yHEGL8/6u5rT39cegASA9MH3CawRPBVwpMVYFqpdpO4v1CaXmhIZeTnvUU7GKahQsu
         qhHHQ4dh3x1AjNlE4k6KgEybR7fTbfDkq7ZuK9YxW0eJhfrFCjfkGYOLixM1VRZ4E3QA
         W++w==
X-Forwarded-Encrypted: i=1; AJvYcCXreYcOACK9MgGXwAEKejB3k4NeV3b/c+nmw4bcVQeVSAY6PpWsz5s9Giou8v0f/b1EXVtKmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzlMpAVyJ3agxx6IWV1dg/HbcWAA0zGcu8pvx42STn9LVugWr6
	zxTU88wc1dTSBmHg5It708KIUVKmlF+HxGObU9f3LoqAI/DiP6hk0Rn9ogdxBp8la0KQeFuJ8+G
	oH04/MBh0PvhMSEyUq7HhtWf50duTvF8iYsIypolwuu3qeIQR3AiQJeru
X-Gm-Gg: ASbGncsKDcioRqgAUXlQf7iQBR9zQ69IKgoSI7zhp8b19N9b4RAoKEnTnI6kZQsItRL
	MY6D0Ub0tbMC3yx8h1fmStTfnUOjIXKR/KXP5PP2/Ll2pIj50mDQ41WgccQhWS0DDQrxuHEr8Vi
	LbrmaUOf33rscePg685fFEQrMGzLiKRA3DnkoP6cyXVWU5yTxl+AU2lv07BJfB2/Z5vmTVcXANo
	IMaR+2HX36XRuu07vxlcrts8PWAtXuYIWeKuUth7lX0ZtUCTDAvuoM+/B4NoOK5KsykXVrKyyYx
	eidkRaLEpk1jp/mCvTqRt74NVBysris9kSGaLNjatOw=
X-Received: by 2002:a05:6e02:152e:b0:3e3:d2eb:52db with SMTP id e9e14a558f8ab-3e51b79eae2mr20687225ab.0.1754513909046;
        Wed, 06 Aug 2025 13:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMHObcGautLtJ7984K/wyyriLvMdPXmyUUT5V0nwJ7vFbNm7fOcxZIXtiLyBYuGHd6raZZQ==
X-Received: by 2002:a05:6e02:152e:b0:3e3:d2eb:52db with SMTP id e9e14a558f8ab-3e51b79eae2mr20686945ab.0.1754513908609;
        Wed, 06 Aug 2025 13:58:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ab01e84desm2049992173.51.2025.08.06.13.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:58:27 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:58:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 01/10] PCI/P2PDMA: Remove redundant bus_offset from
 map state
Message-ID: <20250806145825.2654ee59.alex.williamson@redhat.com>
In-Reply-To: <c9b6237964b9606418af400bb6bec5178fcffff2.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<c9b6237964b9606418af400bb6bec5178fcffff2.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P2_LXsPUcq4oAh-AQuyM-FK3bDWD-GEWvNlInnDcIWg_1754513909
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Aug 2025 16:00:36 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Remove the bus_off field from pci_p2pdma_map_state since it duplicates
> information already available in the pgmap structure. The bus_offset
> is only used in one location (pci_p2pdma_bus_addr_map) and is always
> identical to pgmap->bus_offset.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c       | 1 -
>  include/linux/pci-p2pdma.h | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index da5657a020074..274bb7bcc0bc5 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -1009,7 +1009,6 @@ void __pci_p2pdma_update_state(struct pci_p2pdma_ma=
p_state *state,
>  {
>  =09state->pgmap =3D page_pgmap(page);
>  =09state->map =3D pci_p2pdma_map_type(state->pgmap, dev);
> -=09state->bus_off =3D to_p2p_pgmap(state->pgmap)->bus_offset;
>  }
> =20
>  /**
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 075c20b161d98..b502fc8b49bf9 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -146,7 +146,6 @@ enum pci_p2pdma_map_type {
>  struct pci_p2pdma_map_state {
>  =09struct dev_pagemap *pgmap;
>  =09enum pci_p2pdma_map_type map;
> -=09u64 bus_off;
>  };
> =20
>  /* helper for pci_p2pdma_state(), do not use directly */
> @@ -186,7 +185,7 @@ static inline dma_addr_t
>  pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t =
paddr)
>  {
>  =09WARN_ON_ONCE(state->map !=3D PCI_P2PDMA_MAP_BUS_ADDR);
> -=09return paddr + state->bus_off;
> +=09return paddr + to_p2p_pgmap(state->pgmap)->bus_offsetf;
>  }
> =20
>  #endif /* _LINUX_PCI_P2P_H */

Looks like you're relying on this bogus code getting resolved in the
next patch...

In file included from kernel/dma/direct.c:16:
./include/linux/pci-p2pdma.h: In function =E2=80=98pci_p2pdma_bus_addr_map=
=E2=80=99:
./include/linux/pci-p2pdma.h:188:24: error: implicit declaration of functio=
n =E2=80=98to_p2p_pgmap=E2=80=99 [-Wimplicit-function-declaration]
  188 |         return paddr + to_p2p_pgmap(state->pgmap)->bus_offsetf;
      |                        ^~~~~~~~~~~~
./include/linux/pci-p2pdma.h:188:50: error: invalid type argument of =E2=80=
=98->=E2=80=99 (have =E2=80=98int=E2=80=99)
  188 |         return paddr + to_p2p_pgmap(state->pgmap)->bus_offsetf;
      |                                                  ^~
./include/linux/pci-p2pdma.h:189:1: error: control reaches end of non-void =
function [-Werror=3Dreturn-type]
  189 | }
      | ^

to_p2p_pgmap() is a static function and struct pci_p2pdma_pagemap
doesn't have a bus_offsetf member.  Thanks,

Alex

