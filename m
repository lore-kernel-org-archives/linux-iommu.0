Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345332ABCC
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606818; cv=none; b=rtZGqlsWbH6VSkmbXnUmNPxXvMO7t60WHPt6Ng1mantLe2l5KivQyQGWMfkjH9LMlKUXF/abYlfAm333w4y9AQS/J6lHMOlZO5jwMhmrfxCiTwQhdMKnwRagS2wRt+2hLXEsrTGPv84R4NUiDC6kobVsZDFojNEl2D4/48AMc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606818; c=relaxed/simple;
	bh=Mox7WVrx2nsqFbNnAMpCHXjsIB1mhexPun4YkmTSVd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmX0pXrtUa2+LrfALz/PkZHTXYKsTR7MBmJBJ93Z10NkTht2/tLe/fVXftOA/3ZdEtU8F9kV85kCPojzGFtaq9Afs3G2LwRZEs76CYzgt6cn/2BWpCDSssBLY3GwoECOxn6JctDE6uVPdgQJnwtfzdqfGGrPCl3ujq17HwR0WrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoJX+Uof; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoJX+Uof"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592fd97c03eso4559090e87.1
        for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761606814; x=1762211614; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVb3sBQg3S7kfhJuRLHfxPiQ08+Bc1FaH34bvysQgyo=;
        b=LoJX+UofTzYReOfp7TpgeCbQOZ4rL7Y1j3xYfEflPcBlbA0HrfYjYaGhr5/dbBFjEw
         z+SgGDYnm17mRUU7BYsyN4lgU4WbzroMgDq31GDl/fXyngns5PWm8+dNmbDs0YvNdVrq
         yJ+JkwQbd42prVJ3tK7X/Piru9oNjGwrR8DbRJquyNKL2dXnMfko5DDM/nffBMEmcXbI
         HUX2SrYH4oAAlIASCwwzkledhb5dSthBHRkFSNh+GvV10Ny8BVNbBMPcjalUo5gwJ8Pb
         rorFroR44Ri+LK8w0xRXRU09J3ZKFn06xocRNnXa8Dfl88CpIy0hbOvTdHVChIxkTsMj
         5Jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606814; x=1762211614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVb3sBQg3S7kfhJuRLHfxPiQ08+Bc1FaH34bvysQgyo=;
        b=TSizOY68WVrUgNjxON6Kc8b/8OtChm1SIbt9rOgCcUg0bpCz3WBT+mQOY5bzkscbnK
         t4jy/yXgZvdrWuMicroNJvX+OzwXHjEjVruo5Z3V21c/Vgv0HvucFwFPREmeMX6RsKfq
         rtmYR9rY457bUsl9l7+Jv9ms1XWtoFrheA9c7qvOj+xJeCOPCinDQA4lwhsJh8R2J1tO
         GkS+paEWPJW5l4A9vkNO7HEIE3j0FNjiv4pTCDXQeGSI4YemFm1TeQ+RxzKfp4xd5RKY
         +CLWTaPjAqOt5GaR24X9Msz35JcCdIOw5Et+Fnu8SM2yty8PNVUcFZnDaC5klHSjT7ND
         Jxyg==
X-Forwarded-Encrypted: i=1; AJvYcCWbIayJrAORMzdmm0URYKKR1DKFQKyajjFDJxlAOjWaJNq8gdC54bwphwOAPBPxmNRA0+tfVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLOW/Doxa/nt+zPTcHArF5X36EdsuJtH9MYztzMVmTVOdH0Zgc
	7UF0QAxR/+e35qrhW/XkosFOHlghYCTsB6Yip3T7cOfZdT0L7n6zr5QlQ2Xc9ayQhb2pD1HdxEN
	bqHhGkLrv+/9O0hYxAUqFpmAJ9tt6cmNEmml+Bmmb
X-Gm-Gg: ASbGncslWNbNzlgRL4bZz+Uesey40WCXFrDuwnAoU3wl05KZsxwnGeamfPL6NAgw0hF
	F4HcBtna1v0anwg6ketptM4je2/W3rxXkP5f3CbLNy9SHF9CpaHIJaG5k721XQpUU6f3TgW3I4P
	H2WslyjfQ5yteUFeSU4nmeCqcGtbdJE5RMH/ELbm7opzlZv5v6XK1PdOXpavmnQAIl/IZvWbuYW
	SSMIOFBh2Yu0L4Jt0Ovzh3sqWCNOI8YFnsVqeoxwKMmniet5HDcG9JFVclgx0xwm3oDivg=
X-Google-Smtp-Source: AGHT+IGl3ca765JSYQeeeNWnOc4ez61Rh9cYHuTu2Z8wbfu4++aeMX3ejm6+mpCGbnxLweY96XJw4Qd/Jsw/gJioL2Q=
X-Received: by 2002:a05:6512:39ce:b0:585:c51e:e99d with SMTP id
 2adb3069b0e04-5930e98f2bbmr555951e87.3.1761606813913; Mon, 27 Oct 2025
 16:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1760368250.git.leon@kernel.org> <72ecaa13864ca346797e342d23a7929562788148.1760368250.git.leon@kernel.org>
In-Reply-To: <72ecaa13864ca346797e342d23a7929562788148.1760368250.git.leon@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 16:13:05 -0700
X-Gm-Features: AWmQ_blG76O58dB2_ktM5H7ZDlww5WUOcPernLo2oZm94nuYAfy2S9NihsUA1rg
Message-ID: <CALzav=cj_g8ndvbWdm=dukW+37cDh04k1n7ssFrDG+dN3D+cbw@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] vfio/pci: Add dma-buf export support for MMIO regions
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:44=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Add support for exporting PCI device MMIO regions through dma-buf,
> enabling safe sharing of non-struct page memory with controlled
> lifetime management. This allows RDMA and other subsystems to import
> dma-buf FDs and build them into memory regions for PCI P2P operations.

> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET create a dma_buf fd for the
> + * regions selected.
> + *
> + * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOE=
XEC,
> + * etc. offset/length specify a slice of the region to create the dmabuf=
 from.
> + * nr_ranges is the total number of (P2P DMA) ranges that comprise the d=
mabuf.
> + *
> + * Return: The fd number on success, -1 and errno is set on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF 11
> +
> +struct vfio_region_dma_range {
> +       __u64 offset;
> +       __u64 length;
> +};
> +
> +struct vfio_device_feature_dma_buf {
> +       __u32   region_index;
> +       __u32   open_flags;
> +       __u32   flags;
> +       __u32   nr_ranges;
> +       struct vfio_region_dma_range dma_ranges[];
> +};

This uAPI would be a good candidate for a VFIO selftest. You can test
that it returns an error when it's supposed to, and a valid fd when
it's supposed to. And once the iommufd importer side is ready, we can
extend the test and verify that the fd can be mapped into iommufd.

It will probably be challenging to meaningfully exercise device P2P
through a selftest, I haven't thought about how to extend the driver
framework for that yet... But you can at least test that all the
ioctls behave like they should.
