Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5A1AA81
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 17:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690392833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=595aIFAqz7KLDifNzOOpVRZNEJ01+8bEI4rnP/3L4To=;
	b=EU90qie4Le5etddl8YKKIWKXHgzm41z8Z6eXELYjyMBArLmqSSfzLHflWXoGXMf35fZKZN
	mD82zkAp3D/HziR3954TJwsErPkplaoq2tbalvFEWdyMdCU0z1ds/nGbHIHX8jR6QpoNrn
	TO6ey8OVVycEb8LZvIjkoExlo3G3teo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-pjxiGp4rMyO6q0XsjNR3iQ-1; Wed, 26 Jul 2023 13:33:51 -0400
X-MC-Unique: pjxiGp4rMyO6q0XsjNR3iQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-78704050adbso59639f.2
        for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 10:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690392831; x=1690997631;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=595aIFAqz7KLDifNzOOpVRZNEJ01+8bEI4rnP/3L4To=;
        b=UlQuD2rjyyw7qW4TIntGZUoGpUq8rSgsEPHnMP3US4M2JOJHFmi3hQ7oPVjwkEtasr
         4R19Dpp2CJm/oaKrjKnaf8H+wko3s6CG4nCwTWlxpOyCr/L/dRIVkw5lgEeLy6Fp/nAj
         8fbTv6dEaFdwLjNlc8pnW4zjQs9QZbGGL51Gj+CbDe+adHnRZXLnLNaQ+Jrrpw4hqN+Q
         3iRMnFeuTEFDvDJ6pUSOzrL894BL171UKEuN9Ah+KG+y9jEwxey0q05Zy0t+i+cNt7tx
         NncHSCJZT2oWNCMVWJO+qHi6O1NRL0Oor0cGPU4B1e42MynmUs+7wXYXHpNuCC7Ql3B9
         aSyQ==
X-Gm-Message-State: ABy/qLYY2mog/t5nsgZsMReBZhp5isO0PNw/JNV1+yB8911WABkPgSMp
	pra6hjLY6xX+8gGqVCs3bY7bWwHATbplLIVAI9heK4BpediaP2gIl7kQVpA4r7TGjHPSz3mEcSM
	zOoc48AJe2pXPTTg=
X-Received: by 2002:a5e:8713:0:b0:786:98bd:66d4 with SMTP id y19-20020a5e8713000000b0078698bd66d4mr2821729ioj.15.1690392831044;
        Wed, 26 Jul 2023 10:33:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFSNSK8ezzU7UY6kqRAWp8eJAgdkkstqtMf1gdt1dZfcxLAkXL1XnER7kAc9CqUzcaWir7uvw==
X-Received: by 2002:a5e:8713:0:b0:786:98bd:66d4 with SMTP id y19-20020a5e8713000000b0078698bd66d4mr2821704ioj.15.1690392830818;
        Wed, 26 Jul 2023 10:33:50 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id f23-20020a6be817000000b0078b9d1653a8sm3815595ioh.42.2023.07.26.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 10:33:50 -0700 (PDT)
Date: Wed, 26 Jul 2023 11:33:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <jgg@nvidia.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
 <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
 <farman@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Message-ID: <20230726113349.3dc1382c.alex.williamson@redhat.com>
In-Reply-To: <064227abb779063c328fd79afc7c74dabdf2489e.1690226015.git.nicolinc@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
	<064227abb779063c328fd79afc7c74dabdf2489e.1690226015.git.nicolinc@nvidia.com>
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

On Mon, 24 Jul 2023 12:47:04 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> A driver that doesn't implement ops->dma_unmap shouldn't be allowed to do
> vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/vfio/vfio_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

I assume these go through iommufd.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 902f06e52c48..0da8ed81a97d 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1483,6 +1483,8 @@ int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,
>  	/* group->container cannot change while a vfio device is open */
>  	if (!pages || !npage || WARN_ON(!vfio_assert_device_open(device)))
>  		return -EINVAL;
> +	if (!device->ops->dma_unmap)
> +		return -EINVAL;
>  	if (vfio_device_has_container(device))
>  		return vfio_device_container_pin_pages(device, iova,
>  						       npage, prot, pages);
> @@ -1520,6 +1522,8 @@ void vfio_unpin_pages(struct vfio_device *device, dma_addr_t iova, int npage)
>  {
>  	if (WARN_ON(!vfio_assert_device_open(device)))
>  		return;
> +	if (WARN_ON(!device->ops->dma_unmap))
> +		return;
>  
>  	if (vfio_device_has_container(device)) {
>  		vfio_device_container_unpin_pages(device, iova, npage);

