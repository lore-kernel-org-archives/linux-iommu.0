Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627D3C3C
	for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290751; cv=none; b=JDsDETmCPU9NFa6hzwJeR0bIJ4Seo8dZkT1xXUWGvO76CyLRYJxpua8gOmqLfZUSP1R5x7JeXAM8Stw3Qx3pFEH8z9jEYzR4znNPDBJ+Wyi9/uoeag6JqdYsBub6FRQmM4tvl2w1drV0rcRK5ap6fRd8VuXQ1SWkr9jjy/WCPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290751; c=relaxed/simple;
	bh=bWyRCGTcPRNkiQbPV1UIZK/QkxgPyfNx5HGKdVQ0DSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwtR26KV9ekVuSjM3MH6/gCtUQc2WNRt9LOtJ8A6+AJqdAqGjgkTYUXk+bvMbNEG78oO6EXVkEUVIm0yhQTyVa4tzSAk5nciZpmy3TemKiUdGNN9muc0rjiJlJMOscj8tIpX85lFBN7+qjxCSWMgRQzFQ7qSSpT2Q5IYZakcUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR4wdn7R; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR4wdn7R"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso33894521fa.0
        for <iommu@lists.linux.dev>; Sun, 10 Nov 2024 18:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731290747; x=1731895547; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdEkfAJOsElSV+ujZ/1dK2DOAkU54yl3So/8rs20Jag=;
        b=cR4wdn7RPT3FL/MxyllAm2KPpsuAXHMmGTNsSyv0DmklnGfqmqKdMGXMPxE+GSeud5
         P0WCH0iU1T4LcZx4BGpU6H3aCJL73PMAIfClszNgYkGXDz6E4WbIo2Icx8JwQanNSEP+
         UuVXk/teu/u72U2/mO/cuNpmkMtnABFvP35p1UpR6CZnRgcgjhJQMKnAJl1elPe1IGXh
         ymFdC25aocFYydGEV62upJ1yKZxs8hGU3L0j24l7Jvr6JDi30jYyBmlZ4Uon6IR+ZQ39
         1atxbrS61Lkq2cW2ao7Vegs9XbhNpq1crlR+nwOFZxVwZGRkhCPRSVoUVcqxuafXALg5
         GU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731290747; x=1731895547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdEkfAJOsElSV+ujZ/1dK2DOAkU54yl3So/8rs20Jag=;
        b=PZrzkWY3V63HkstJIadFTT3fRhVoxta4W+99b5Q2KB1he0ApFuxEd3cYeqRAU4wCK/
         kJZspLv8CKvjQ7Xo/PWNAqgc3V2fEdkAkLxUbhTkkxK6nQRXIfe6FYa+dGKjtGZH2XDu
         pqukmFbHfV98CCw9maljtFryqk0AzP8Z6mBDHCuFaiT4JVoiwvCqkLIVVklp6lvkSS8a
         EjFIkCIUWWSIKJwOamCSISlo0diWqu6PimVB2t8vCAz8rEAM1MOjyGiDGWrAnGWRUxyb
         uy5GqMzph5icgC/GqgQ9K57NaxdXlV7ZIZTMajhUogcYEdhufvb5aiVc+v8h/Enf7Ij0
         sCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBdAovjPf4mU/Ge/WEVJLFqGaN9ndhvydLLp+I/ZLGBSLTR8nHu+gF43CjO4gcn+rlNDyqMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIBvuLC+wMYV93ggR3+uL31bWID7DlgdVe86gTNMU7eHBnxRLq
	3E0g1njmn8oLle0n256I5HppVfeuyIhVY9cAgE5SKgAnWY93ZGOwV5x1UeamnH+H5fuLpgTJl5V
	0gK0UXhdG/GWs64S+PNPuCUL0Q7Y=
X-Google-Smtp-Source: AGHT+IF0tJPIolZyNYPTT2b/MpCJe82Fg/iZslXB6gzAqlmjhMUqVGRF2M5H+UaSiVlIP433HQ0w2T+2CyxfkrVJL68=
X-Received: by 2002:a2e:bc1d:0:b0:2fb:5014:8eb9 with SMTP id
 38308e7fff4ca-2ff2014ec60mr46592301fa.10.1731290746959; Sun, 10 Nov 2024
 18:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1731244445.git.leon@kernel.org> <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
In-Reply-To: <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 18:05:35 -0800
Message-ID: <CABCoZhAN-eeu=E5r+ZbZGTNwQta5yUw86sy8e_Je+Yri-+iuoQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] docs: core-api: document the IOVA-based API
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 5:50=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Christoph Hellwig <hch@lst.de>
>
> Add an explanation of the newly added IOVA-based mapping API.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/=
dma-api.rst
> index 8e3cce3d0a23..61d6f4fe3d88 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -530,6 +530,76 @@ routines, e.g.:::
>                 ....
>         }
>
> +Part Ie - IOVA-based DMA mappings
> +---------------------------------
> +
> +These APIs allow a very efficient mapping when using an IOMMU.  They are=
 an

"They" doesn't sound nice.
> +optional path that requires extra code and are only recommended for driv=
ers
> +where DMA mapping performance, or the space usage for storing the DMA ad=
dresses
> +matter.  All the considerations from the previous section apply here as =
well.

These APIs provide an efficient mapping when using an IOMMU. However, they
are optional and require additional code. They are recommended primarily fo=
r
drivers where performance in DMA mapping or the storage space for DMA
addresses are critical. All the considerations discussed in the previous se=
ction
also apply in this case.

You can disregard this comment, as anyone reading this paragraph will
understand the intended message.

> +
> +::
> +
> +    bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *s=
tate,
> +               phys_addr_t phys, size_t size);
> +
> +Is used to try to allocate IOVA space for mapping operation.  If it retu=
rns
> +false this API can't be used for the given device and the normal streami=
ng
> +DMA mapping API should be used.  The ``struct dma_iova_state`` is alloca=
ted
> +by the driver and must be kept around until unmap time.
> +
> +::
> +
> +    static inline bool dma_use_iova(struct dma_iova_state *state)
> +
> +Can be used by the driver to check if the IOVA-based API is used after a
> +call to dma_iova_try_alloc.  This can be useful in the unmap path.
> +
> +::
> +
> +    int dma_iova_link(struct device *dev, struct dma_iova_state *state,
> +               phys_addr_t phys, size_t offset, size_t size,
> +               enum dma_data_direction dir, unsigned long attrs);
> +
> +Is used to link ranges to the IOVA previously allocated.  The start of a=
ll
> +but the first call to dma_iova_link for a given state must be aligned
> +to the DMA merge boundary returned by ``dma_get_merge_boundary())``, and
> +the size of all but the last range must be aligned to the DMA merge boun=
dary
> +as well.
> +
> +::
> +
> +    int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
> +               size_t offset, size_t size);
> +
> +Must be called to sync the IOMMU page tables for IOVA-range mapped by on=
e or
> +more calls to ``dma_iova_link()``.
> +
> +For drivers that use a one-shot mapping, all ranges can be unmapped and =
the
> +IOVA freed by calling:
> +
> +::
> +
> +   void dma_iova_destroy(struct device *dev, struct dma_iova_state *stat=
e,
> +               enum dma_data_direction dir, unsigned long attrs);
> +
> +Alternatively drivers can dynamically manage the IOVA space by unmapping
> +and mapping individual regions.  In that case
> +
> +::
> +
> +    void dma_iova_unlink(struct device *dev, struct dma_iova_state *stat=
e,
> +               size_t offset, size_t size, enum dma_data_direction dir,
> +               unsigned long attrs);
> +
> +is used to unmap a range previously mapped, and
> +
> +::
> +
> +   void dma_iova_free(struct device *dev, struct dma_iova_state *state);
> +
> +is used to free the IOVA space.  All regions must have been unmapped usi=
ng
> +``dma_iova_unlink()`` before calling ``dma_iova_free()``.
>
>  Part II - Non-coherent DMA allocations
>  --------------------------------------
> --
> 2.47.0
>
>
