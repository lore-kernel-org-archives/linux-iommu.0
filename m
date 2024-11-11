Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B74D8CB
	for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309603; cv=none; b=pmdPo8tXKzcMr4YgdTKn9cNh15pMzS24K+RSovYNDdlVOwX3aF1Y14JIHvrDDtkoPkPnxMor+3H1icdBL6YhDKF8r9D1CDmrbDrKf4oHqeYpHqg1k5x3kk0V+5fRJHJPjmroMtGvRxR89UvebEhYExqMCvok0ZEKWnAq3hu6uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309603; c=relaxed/simple;
	bh=2rkhCrabTh+dME1AyXeh+UGUqDM4G2Qwh/eeTBLxHOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6EhhXROBPwKBZVp6OEEVNVhfBqGX8htN8GO4ndW6ZmmLTb57qc+iM2Iu7QS49Ects0qhrICZaX4ACG2tPU2tzEGdpKA0XsNjv11cRqettA3wVI6gIA+oxg9AXqJyGZjMAHzVjxKcUZ/knhMghyadsmig4bJwMvavss+XIo1Dms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkuPlIh6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkuPlIh6"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso467769a12.1
        for <iommu@lists.linux.dev>; Sun, 10 Nov 2024 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731309601; x=1731914401; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOmU+DqOTssuNxVDSw47mJh+RLlQKxt2hGA3wP7JifE=;
        b=GkuPlIh6iV8jzXhh3tI37GRVVu77LiSqDEZhsZDTbZ8Sc9gvX9kzM76W0yI04I2cJd
         Vlniqlqu3ZP3T89BO9kYUU7MuUHwwGi2MVUIuf++H4gM0QzAI4IMhjY2msuKJ005Qm5I
         pydcq/5uQ/6N1HifUOOnkToEKtc1tg+sBdR6EBB/ZK0AH+hibZRIbT5bZ7+q7900gu9d
         kF+vCCoZki3jsuMIjc/FSQWcm0PgxyH+rGDVsL6XcevwWNV82hMVFVfdxjACiswDTe1h
         zBJqa/wTucjQlOgsenQ8Ofr+YPC5c/9dj/Lv83slNPPq4NcrnvAkKF+QVE1jto9ukK3p
         rqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731309601; x=1731914401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOmU+DqOTssuNxVDSw47mJh+RLlQKxt2hGA3wP7JifE=;
        b=jkdgS3AbUgbEZHQJIzRSL0n58vzEL9lA6lG2KGLf6bZdCXwmTJe8QC1DgJUMChDSCo
         Wg8KiEMNEWk3e22dIO+jVVpwuLVCricTZiT4SPeC2ctxWSbLPEaBN5MBY3gMgPksQ3gt
         34FF0iLmbIL8huf+TUZsT7BfrmDa/UwI1/6ldN7EWHSE8kGKEEKqtzbKCnBpPitNYrqm
         rkyqg+u03RTIUi9rpq8XbVRkaYKi9LPANXbnAgqeWlVAhbGetaVdtrEn8jF2uMvs+qRO
         dhEwQGa6kZ98UFA2I4yIo/Egm0uTImpKo8jKA18VOmRw7GwtWWhrM3PYoGT05bfVSkiT
         U8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVSXzUCqK3JAWTsYD3O0Oq8PZWbbl/MqPwbRIzJF2e8CvN3+hnCUNJqNeSYwBpyLLIduZOdrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIpyoKTi38bkmhUmGMuiAhyO/0LJ2E9GsE4B5nG2+0HPxYL6SV
	gNM5njU0OL9qRX6utkZBEZ3pMDPE7NFdHqZ+lmVu15RnH4shanMFHSw0E7iFRwv8CCAWuxN6YPC
	K2fU/pl7v2Nxn4eYPRhMiqqOkpJY=
X-Google-Smtp-Source: AGHT+IE2GbhyhHM7VLZoUXFICAIpmggZuUxeUy9Xke7HCQ1ScZ37Bf1N00DNPtc+BrABfZWGfVXnr9FTBKVDLWlkvX0=
X-Received: by 2002:a05:6a20:6a1c:b0:1d8:d880:2069 with SMTP id
 adf61e73a8af0-1dc228395camr18138782637.3.1731309601118; Sun, 10 Nov 2024
 23:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1730298502.git.leon@kernel.org> <9515f330b9615de92a1864ab46acbd95e32634b6.1730298502.git.leon@kernel.org>
 <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev> <20241111063932.GC23992@lst.de>
In-Reply-To: <20241111063932.GC23992@lst.de>
From: Greg Sword <gregsword0@gmail.com>
Date: Mon, 11 Nov 2024 15:19:48 +0800
Message-ID: <CAEz=LcshavSrtGDjhKBPZU9o+5Mr8rPiBPmVL4dxcOmEiqHQSQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/17] dma-mapping: Add check if IOVA can be used
To: Christoph Hellwig <hch@lst.de>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leonro@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Nov 10, 2024 at 04:09:11PM +0100, Zhu Yanjun wrote:
> >> +
> >> +/*
> >> + * Use the high bit to mark if we used swiotlb for one or more ranges=
.
> >> + */
> >> +#define DMA_IOVA_USE_SWIOTLB                (1ULL << 63)
> >
> > A trivial problem.
> > In the above macro, using BIT_ULL(63) is better?
>
> No, and can people please stop suggesting it?  That macro is so fucking
> pointless that it's revolting,

Why do you hate this macro so much, have you considered the feelings
of the macro author?

>
>
