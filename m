Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C5207A18
	for <iommu@lists.linux.dev>; Wed,  6 Aug 2025 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517733; cv=none; b=rCIa88gYK5hopvTWZj/6i345YZNkEyL35E4P7VQbd7IgsIbOS+JEeqigI3Bmn+vseMBKsGVbpiPZ1uKpTQBJSCjChwG7B6xvDC9I6bFaa89qm+NTTe19LBnP6EV2v66gmYcDXahjZZ1Xkkks2JroYqzh6m/tLUcLMGnp3VAzhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517733; c=relaxed/simple;
	bh=sBGR4NtuEpYLnU8xLpZkN2kUNrTNO6/D2QzCl2EwKDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5iGv3vG1WJFzHKKbXmO4+QJw84ZTJdPSt9jY8B27RA6nCmti28hU61vpM/+xLUVx9eTGZRIUWUoBwkJJTYOo5/6TcwtT4552I7wfbmjKIMXrPeX3IKEmTgK/MwfNfT8os7k8aHi3ZBFcgUnEYg7DPJxuHkfF/T8R5dOjy0wdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFCWIFW/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFCWIFW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754517729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPKtzeEHbCO/oC/mPOhJydcV6bGZHZZqGISB9ILuO/c=;
	b=jFCWIFW/VS4tChIbUOU5nlFllrxXyLBBZcDWdvG/GYhGjB9adkgkaPZcGMZsvTFoONaZoo
	KXbbbQmHRTWoZ5gt1kf2JU66zhGjJDr8xNzLLoDPWm81wj+bftOHen+bCEixFW0uNEQpVw
	FQ+8Onq/KSnwey3bT8ld0yAKCWtUIT8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-VK9YgKDeOH6xXK6UVwQ7LA-1; Wed, 06 Aug 2025 18:02:09 -0400
X-MC-Unique: VK9YgKDeOH6xXK6UVwQ7LA-1
X-Mimecast-MFC-AGG-ID: VK9YgKDeOH6xXK6UVwQ7LA_1754517728
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3fdd9298eso841605ab.3
        for <iommu@lists.linux.dev>; Wed, 06 Aug 2025 15:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517728; x=1755122528;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPKtzeEHbCO/oC/mPOhJydcV6bGZHZZqGISB9ILuO/c=;
        b=rCdqle0ANklPDz+aG48maVaD6l4Y7434nj7r3jOCrzqPLclMRl5Efly0EXpRekuriT
         C8t6srmf8Ed2zTHeQ41til84oP+9UGPRFPLJOJElPqWv5yKznGkd4osk8xQWtS+3qY7m
         65SEzdozRHmoT70M/jr2eZcIP17tpEKD2Ok4QeZivdSYawy+T+5qCHi8x3TqkqIO5v2p
         rF6wtKuX53kOo0fxlTE0kTqJNBtVTGRsezePMV1OsYJpIVBgDtaL4Ts+jAUM+2PIN5Nc
         6CL0tABgb8xmxKHucfHhHtEe89wINhyXvKZ89KC79VZxTSos2aTreICKBaxedxUpgaa2
         /Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCXIKVWjDRGkO/QZmclY4O4UyZzjcXW3dZ2Oj/mKunT7oadrSI/UatQebBX+CBX8Eby1LDVSWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz96R6F5kxR8v5rmwUiKAq+es4GRcym6StrbrDZrim0PczWZwyI
	+Rxm2tZYg8cdsV8M4QA9qrwZO3DVtKqAGqaHyB4EQCa4nm4Cjl7E1+0aKP3TANwBKKIyRXzcg6Y
	Tlv0uyJdfYieIqLGpzpDSA1wzqkTS6h8S0WJcp0psLCSd0TWCcqoyjvlu
X-Gm-Gg: ASbGncsBGrI99PSD77AYx80Y1FxAC8x9QPJQvhUfw9NFMFSu8J/iV4B0jvcha23bnCX
	g38kBziM43AJujqllQ/uMy6cK0rwvcg26zNRrLRnk+7YjRBGg5EMyKA0Rar/vIfRV+EL3QkCGx5
	YKWL7qbE/mKgT6SiVOE//U0vRUgxxjXBjMjqGuu6hM2dc82s7aVYVtsEMbvAJcrtFo5AMfkTvNS
	xPzH0KzAAUictNsN6o94LoQJvIZ2Isk8VAsfzK5pQZPtPMLZyVlfs2wM56II3q/v3+pURoBTOY+
	hqj6GVpJHt6i7c1COTeaJGliNSgB9apchyjLgtuRwoI=
X-Received: by 2002:a05:6e02:3193:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3e51b8854c1mr22433185ab.2.1754517728020;
        Wed, 06 Aug 2025 15:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIzdy8eeJry7tYq6oPCO7e2LCNwpZ/0SyAUMoLDbyTlBwk+OaaK/N75sVSFjgffH+CpRQ7JQ==
X-Received: by 2002:a05:6e02:3193:b0:3dd:c927:3b4f with SMTP id e9e14a558f8ab-3e51b8854c1mr22432755ab.2.1754517727346;
        Wed, 06 Aug 2025 15:02:07 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e40297c389sm63783105ab.2.2025.08.06.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:02:05 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:02:01 -0600
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
Subject: Re: [PATCH v1 08/10] vfio/pci: Enable peer-to-peer DMA transactions
 by default
Message-ID: <20250806160201.2b72e7a0.alex.williamson@redhat.com>
In-Reply-To: <edb2ec654fc27ba8f73695382ab0a029f18422b5.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<edb2ec654fc27ba8f73695382ab0a029f18422b5.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -rGQfNP9UoeHznqWJbpHrCxgUSlbVRa90ubVetKYf3k_1754517728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Aug 2025 16:00:43 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that all VFIO PCI devices have peer-to-peer capabilities
> enables, so we would be able to export their MMIO memory through DMABUF,
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 4 ++++
>  include/linux/vfio_pci_core.h    | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 31bdb9110cc0f..df9a32d3deac9 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -28,6 +28,7 @@
>  #include <linux/nospec.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommufd.h>
> +#include <linux/pci-p2pdma.h>
>  #if IS_ENABLED(CONFIG_EEH)
>  #include <asm/eeh.h>
>  #endif
> @@ -2088,6 +2089,9 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	INIT_LIST_HEAD(&vdev->dummy_resources_list);
>  	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
> +	vdev->provider = pci_p2pdma_enable(vdev->pdev);
> +	if (IS_ERR(vdev->provider))
> +		return PTR_ERR(vdev->provider);

I think this just made all vfio-pci drivers functionally dependent on
CONFIG_PCI_P2PDMA.  Seems at best exporting a dma-buf should be
restricted if this fails.  Thanks,

Alex

>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index fbb472dd99b36..b017fae251811 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -94,6 +94,7 @@ struct vfio_pci_core_device {
>  	struct vfio_pci_core_device	*sriov_pf_core_dev;
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
> +	struct p2pdma_provider  *provider;
>  };
>  
>  /* Will be exported for vfio pci drivers usage */

