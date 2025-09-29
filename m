Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066B22A4D8
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180670; cv=none; b=I9qPJZjaCeQU2lP5NcqWXzSSLz8d8kz509VXIqNcL6VaT9xb2jP66f8ZbibwENGt0V61lhs8SO7gkp+iHzYMkYukXYkJPi007xuyPrbXDxgZ2dFpAorMEiOG200LdC9oNp39+/kLyNDWAf2VrAuByFA9ncJDBmRa+VVKOOuSTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180670; c=relaxed/simple;
	bh=fo8uROp6Yd4p51oNun07BdvS3ckFl/pgBYhRp5v8n58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGydYVeSH9luNDSqtEA/l0BWB2lOMYHBHLd2efiw1ilTgcq92LI9DnP3tmjnII5C7Fmz2YbO7xGL8RkiMiZk1sIjOmqZjlLlxvZt2/gw1HB9qrGzOqmpdQqEMd1VozGmbi2zn/CT1cx8T/8PFlN9n1HRHLB7THnqTWhK8Hw1ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPsZ2uOK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPsZ2uOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759180668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvJsfDbbmraa6iCCkjoqVoBB3Mb9XdjPoCcVP3qHFzU=;
	b=WPsZ2uOKVqLQETBTtPI36pbF0fAxED6UkoBsRTJc8vHtRaFEZDfFfPLQP4ljacqDJheZ5W
	Y2DEBoMwKaz+PbrPOZllAvla0F8AGl+z0U2IkumRHuyBNeNJKaAk7AkouWXYCg5LnrrMk+
	dGbbTCtYvPQFnwpVJmRFJ0nwxKf4mZs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-neQCB8rpPK2U8CMhT2j8XA-1; Mon, 29 Sep 2025 17:17:45 -0400
X-MC-Unique: neQCB8rpPK2U8CMhT2j8XA-1
X-Mimecast-MFC-AGG-ID: neQCB8rpPK2U8CMhT2j8XA_1759180664
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4264c256677so13488715ab.3
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 14:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180664; x=1759785464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvJsfDbbmraa6iCCkjoqVoBB3Mb9XdjPoCcVP3qHFzU=;
        b=pPpKxpdrZN0KMhvhz98G/ycKeym8YuziUMpDjNA0q0l3Vy5MnBtIRNEgbAbh8GYP07
         5byR854XvbfUMQ5Z9AXGA87Cu6Yqz451bfyr63iHsbuLniwAmNVcA2koENXEkTIJfx80
         gWR6ZMqyDC7cUNS+Le8GM5CroaNktI57YekBAljS+xV1j7+E+F1PoxWl7MvW+XMGeJmC
         rLv3/XKn/ztk5CYkADjJSpsVKrx2BXsZZfNIiyLXFZ8iTsBwKPZvdwNQgI85auVRDS3d
         rq1qSh7wsb9ZZdbhJ+ILl8VAiyNDBi70qLxQkC/aSjx8M3xp0lzIQcQLbfrK3t2+YCrT
         pFjg==
X-Forwarded-Encrypted: i=1; AJvYcCUaBJgjW7nAExv73epzoy7Ob1LMZ+G5GzliQ7E82rgiYghl0837nbwWvcTEC5jeQFNrqfBn5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw43l80dWi0cKYd6ggHOhadW1IKIQfJm7gREiUqrvkYh+55mjeO
	KwTkB6gkOXyR5jtA/7TVvdq1uCSNURJ8GwLvZEy7SpME5rlAiv8rXQOU8WZmRuVSXMRPlRUwn+D
	6IvPLM7JEpNTdOLV9nfFpym0lyV98/so2wmKhZiLBdqTYpZQJ7LvU3Zzy
X-Gm-Gg: ASbGncuAYHd5EhAm16FLuWkv9mXKpbSjSIMrQznkIoPNw9P0tVAMcUMONHav9UFK0UT
	FvAZqCKHHz+8a/pJaVbQRADnytbK3v58vSiUre+2A0Ue9ugza/M8xDX9826+FN+hzBN7bewEKX/
	n/YKmrclAgwWAnW3CIic8tEoOK5mOmj4Xg1bEe4Q5UtlDRF9vZG/2ndw+ppYFf2vx/2XbQYBVqt
	21rW2U5aB5Rd/akVgAplSqPI1W8Z2v7DFFdxkSm9lNpz+HjeAvERj9Zptis2tOMVOR7a8FyWxmL
	x7SPuHmpnIwU9+0yJ88WfeJBVQogsu7MAz6zi/ob15E=
X-Received: by 2002:a05:6e02:1525:b0:408:1624:b2ee with SMTP id e9e14a558f8ab-425955e4f60mr87965035ab.1.1759180664165;
        Mon, 29 Sep 2025 14:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3VrvxaH7k00bkTZJWrxcv/Xeuv7Ik/zOnPnH3ASkfKmA5ptZ34qoyLfGaDXRfunQjFfs8kg==
X-Received: by 2002:a05:6e02:1525:b0:408:1624:b2ee with SMTP id e9e14a558f8ab-425955e4f60mr87964675ab.1.1759180663680;
        Mon, 29 Sep 2025 14:17:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57269f5d0c5sm1963571173.13.2025.09.29.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:17:42 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:17:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 07/10] vfio/pci: Add dma-buf export config for MMIO
 regions
Message-ID: <20250929151740.21f001e3.alex.williamson@redhat.com>
In-Reply-To: <b1b44823f93fd9e7fa73dc165141d716cb74fa90.1759070796.git.leon@kernel.org>
References: <cover.1759070796.git.leon@kernel.org>
	<b1b44823f93fd9e7fa73dc165141d716cb74fa90.1759070796.git.leon@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mIg_0hdlu7NzGWp5srVnDOGg77rV_RZBR2KCYqDgb-s_1759180664
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 17:50:17 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add new kernel config which indicates support for dma-buf export
> of MMIO regions, which implementation is provided in next patches.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/Kconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 2b0172f54665..55ae888bf26a 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -55,6 +55,26 @@ config VFIO_PCI_ZDEV_KVM
>  
>  	  To enable s390x KVM vfio-pci extensions, say Y.
>  
> +config VFIO_PCI_DMABUF
> +	bool "VFIO PCI extensions for DMA-BUF"
> +	depends on VFIO_PCI_CORE
> +	depends on PCI_P2PDMA && DMA_SHARED_BUFFER
> +	default y
> +	help
> +	  Enable support for VFIO PCI extensions that allow exporting
> +	  device MMIO regions as DMA-BUFs for peer devices to access via
> +	  peer-to-peer (P2P) DMA.
> +
> +	  This feature enables a VFIO-managed PCI device to export a portion
> +	  of its MMIO BAR as a DMA-BUF file descriptor, which can be passed
> +	  to other userspace drivers or kernel subsystems capable of
> +	  initiating DMA to that region.
> +
> +	  Say Y here if you want to enable VFIO DMABUF-based MMIO export
> +	  support for peer-to-peer DMA use cases.
> +
> +	  If unsure, say N.
> +
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
>  source "drivers/vfio/pci/hisilicon/Kconfig"

This is only necessary if we think there's a need to build a kernel with
P2PDMA and VFIO_PCI, but not VFIO_PCI_DMABUF.  Does that need really
exist?

I also find it unusual to create the Kconfig before adding the
supporting code.  Maybe this could be popped to the end or rolled into
the last patch if we decided to keep it.  Thanks,

Alex

