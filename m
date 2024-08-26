Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA11946BB
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691894; cv=none; b=uG4IwpDCg1HlxS8K07fN6w6F2WrqnwOieCfo+Jr1Oi8olpiuYXQDGwJPetznqAf7F6vAvAtrN56GsMLsMZ8hbw4MEcOWHekUjyBsUNrNi0pz4FxJmgqJPcDq53YxC2eqrOF4wJ0J/yLuoe8KvIpkqzd2bOamLE2Am/MQSlMkzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691894; c=relaxed/simple;
	bh=sSP3E1pz71KBeoaohCBRvwa3X+4yl+kGCoQ6GI6IpL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2son61Dj1P0rCfvWSMLdmvflr2OSlFKUcDj6YVZp6vQgG/m2sYno+r1VAdwhBIxlpEm+G4QXCGLK+UEZcmoUg/5w6LpjtUtPStCemllBj/ZhwKeIZQa8pPJmQxLbkZ/Oka3z7mTt/IU2kyNZaq20DwM36/3TwDxX8mDFG6HA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYHM1Y75; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYHM1Y75"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724691891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwlIXih1BO8ZQGiTKnzjUQyj1FpIRW1qmjvRfN0Byzo=;
	b=JYHM1Y751J4tdonemKPfpFfUed6e98lPmc41C20ak6482dXnT0Liepqt3yqfYmrqgb/L/Y
	ynarWF6T7IdT+frRvJ+eXt97g3IuL3v8y3MZWgNxUx+H1DP64ZJ34yPcHlAw+87oHpBVq5
	aaCy2g7jP/wh2CD3v3bcoXiiyFqYdFw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-UsCwm4RBPNqjmV2mFz-0Pg-1; Mon, 26 Aug 2024 13:04:50 -0400
X-MC-Unique: UsCwm4RBPNqjmV2mFz-0Pg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8285f737so49555239f.0
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 10:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691889; x=1725296689;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwlIXih1BO8ZQGiTKnzjUQyj1FpIRW1qmjvRfN0Byzo=;
        b=qZrvS9esbSVDG35VKGBjxxLytrqROaEeG9dUa8Od0gGESPn1R6t3+HxoY2MIcx9JgV
         I07NAOpiYc3khrkBIl6CttZOeWql6b9LPcX9X296vewLqYSl+i6BCASzC8YTHugT264Y
         6aIZIP2YDLlSaQIhvLzhl0bsjlJ3f+AmIspCpb6Li6ro1i2atgOkzcQaeyUllvZzhDI+
         iOIIHmUiQPB44trJImRjPT00zJv7XZX8Slv8IOv4O1ka2W0sYjUzM+IYftPBC444p6yh
         PIKds/oiKUj3zUl2LJPOgZ4m4u+sYA7Mi8rcXlH7HthtHZXL/iRTuVtLSbzW7mab/x0C
         YWHw==
X-Forwarded-Encrypted: i=1; AJvYcCVkgG3PVVU/4aVgnjhfb7rkD+hK2KTfqrmaH8MM6JTO3XWfFYrWRxBOrQEQ2PbVL3C6zFgPTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzK9eSFNhSOrGrtRr8EIAxQkr00G8aC2V7d9+oyTb9rwQHziz54
	O7GCesNp6FjbmJGm8SiR+IxsRHsWjJlRc7Uzc8U9lZjfDwNiuP8P2oGDuoOsbFW5tPBW0hJ6AKK
	qmKLYvqI7Wa/IOnB0VFZkVs7LyAayyGWhelYKZUKLJVz6hHFjsjnc
X-Received: by 2002:a05:6e02:1522:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39e3c97a5dfmr61324845ab.1.1724691889186;
        Mon, 26 Aug 2024 10:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/jEWrTo7q6VwBNGfSnxrn8MgB6Q7L404MZHrzYPI78/GNJ5dUbnlkNdD62TNSjIbJvZrssQ==
X-Received: by 2002:a05:6e02:1522:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39e3c97a5dfmr61324775ab.1.1724691888651;
        Mon, 26 Aug 2024 10:04:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce7113a21asm2269909173.166.2024.08.26.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:04:48 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:04:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Manoj Vishwanathan <manojvishy@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 David Dillow <dillow@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 0/4] vfio/iommu: Flag to allow userspace to set DMA
 buffers system cacheable
Message-ID: <20240826110447.6522e0a7.alex.williamson@redhat.com>
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
References: <20240826071641.2691374-1-manojvishy@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 07:16:37 +0000
Manoj Vishwanathan <manojvishy@google.com> wrote:

> Hi maintainers,
> 
> This RFC patch introduces the ability for userspace to control whether
> device (DMA) buffers are marked as cacheable, enabling them to utilize
> the system-level cache.
> 
> The specific changes made in this patch are:
> 
> * Introduce a new flag in `include/linux/iommu.h`: 
>     * `IOMMU_SYS_CACHE` -  Indicates if the associated page should be cached in the system's cache hierarchy.
> * Add `VFIO_DMA_MAP_FLAG_SYS_CACHE` to `include/uapi/linux/vfio.h`:
>     * Allows userspace to set the cacheable attribute to PTE when mapping DMA regions using the VFIO interface.
> * Update `vfio_iommu_type1.c`:
>     * Handle the `VFIO_DMA_MAP_FLAG_SYS_CACHE` flag during DMA mapping operations.
>     * Set the `IOMMU_SYS_CACHE` flag in the IOMMU page table entry if
> the `VFIO_DMA_MAP_FLAG_SYS_CACHE` is set.

We intend to eventually drop vfio type1 in favor of using IOMMUFD,
therefore all new type1 features need to first be available in IOMMUFD.
Once there we may consider use cases for providing the feature in the
legacy type1 interface and the IOMMUFD compatibility interface.  Thanks,

Alex

> * arm/smmu/io-pgtable-arm: Set the MAIR for SYS_CACHE
> 
> The reasoning behind these changes is to provide userspace with
> finer-grained control over memory access patterns for devices,
> potentially improving performance in scenarios where caching is
> beneficial. We saw in some of the use cases where the buffers were
> for transient data ( in and out without processing).
> 
> I have tested this patch on certain arm64 machines and observed the
> following:
> 
> * There is 14-21% improvement in jitter measurements, where the
> buffer on System Level Cache vs DDR buffers
> * There was not much of an improvement in latency in the diration of
> the tests that I have tried.
> 
> I am open to feedback and suggestions for further improvements.
> Please let me know if you have any questions or concerns. Also, I am
> working on adding a check in the VFIO layer to ensure that if there
> is no architecture supported implementation for sys cache, if should
> not apply them.
> 
> Thanks,
> Manoj Vishwanathan
> 
> Manoj Vishwanathan (4):
>   iommu: Add IOMMU_SYS_CACHE flag for system cache control
>   iommu/io-pgtable-arm: Force outer cache for page-level MAIR via user
>     flag
>   vfio: Add VFIO_DMA_MAP_FLAG_SYS_CACHE to control device access to
>     system cache
>   vfio/type1: Add support for VFIO_DMA_MAP_FLAG_SYS_CACHE
> 
>  drivers/iommu/io-pgtable-arm.c  | 3 +++
>  drivers/vfio/vfio_iommu_type1.c | 5 +++--
>  include/linux/iommu.h           | 6 ++++++
>  include/uapi/linux/vfio.h       | 1 +
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 

