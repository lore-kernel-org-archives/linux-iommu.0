Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7C12B63
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 08:12:07 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-307664010fdso6209526f8f.0
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683706326; x=1686298326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6EsMAJBrwIXYtJEEeCQu1fc5qd/bCSpNSoDMMv2ltQ=;
        b=Ls2RNsQdi0se0zGx4zvVWlgD2WVc3rCLUuinUgHV/6vfIeJ1OM6ytIyBeJRabh/SYZ
         YzOK/VJ4uiRo/kBiMfSL9F4vyEuvLgJyOhgajHV44sNjBbEFee3D762xOcNKPQNzeIyb
         8Prsc+Z31foB6pA447gh5qnBQDIAmXbpxBxc1UZoSQKfSMsWt78BDae6r49A8qkxmKgV
         ILQbJEyGHTIPOhD5TcdQR3ikcyuxebE9z01Ob1RKoltxDk83yeKS0xBn4PS0NfI5/uZl
         4OnR8+dZfrkJj5trv6/KnwuMtJm6+lssOq9gXfPlKm9ElpRydSALejJ2k/pwRIWHiXyV
         dAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706326; x=1686298326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6EsMAJBrwIXYtJEEeCQu1fc5qd/bCSpNSoDMMv2ltQ=;
        b=TnRFbh6dzky1F9XqYRZ2+S9obMTdJeF4aBQbtRJF0hNrEo56GXI77FhFpPy00EN93Z
         ULkFrFfnvo/BOZ085FpVhvc8gjtWw5+e+oFAfQhuwdbc4oUwXv/6kXvwU0OP1ScZ2vux
         ukyhtY3VC7MOgZZpkAPk+8nli9kM12N7GZ8vvNZfN23imKSFZudVWMtLRi4/cO7eJ+Yj
         vLOyi5bUkeDbZqg6e6ggvj1IDGCXQP8CcdoPIHrmjaX74OKcJ8ngH5TF/6O5AaOouKIe
         bkjCQqJgeshq0BCMI+NnAbaM3KYGT2eBLYq+XOk1GQGgcU5nWXn5AQ6Km3fzI4gvnEbH
         lKUg==
X-Gm-Message-State: AC+VfDyOnfP50xcgeqWEnrxxsef/7foZzFpu9C2R6ApnNlU03R+GcAdq
	VMb3y4FX8P4JNuTSDCNcQMQOYQ==
X-Google-Smtp-Source: ACHHUZ7Oc/qKsllciWxkAsvKtMeLnUK4AO+mmgEQRyjg2ti6wAJ4Lx7DVWJCkn+PgfygTh/JU9SJRg==
X-Received: by 2002:adf:f749:0:b0:306:2de9:4c63 with SMTP id z9-20020adff749000000b003062de94c63mr11837824wrp.30.1683706325845;
        Wed, 10 May 2023 01:12:05 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id x10-20020adfffca000000b002e61e002943sm16494160wrs.116.2023.05.10.01.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:12:05 -0700 (PDT)
Date: Wed, 10 May 2023 09:11:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, eric.auger@redhat.com,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230510081157.GA3326511@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414150744.562456-1-jean-philippe@linaro.org>

Hi Joerg,

On Fri, Apr 14, 2023 at 04:07:45PM +0100, Jean-Philippe Brucker wrote:
> When an endpoint is released, for example a PCIe VF is disabled or a
> function hot-unplugged, it should be detached from its domain. Send a
> DETACH request.
> 
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This patch fixes device unregistration in the virtio-iommu driver, could
you please pick it up for the next batch of fixes?  It applies cleanly on
v6.4-rc1

Thanks,
Jean

> ---
>  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 5b8fe9bfa9a5..3d3d4462359e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> +{
> +	int i;
> +	struct virtio_iommu_req_detach req;
> +	struct viommu_domain *vdomain = vdev->vdomain;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> +
> +	if (!vdomain)
> +		return;
> +
> +	req = (struct virtio_iommu_req_detach) {
> +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> +		.domain		= cpu_to_le32(vdomain->id),
> +	};
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> +	}
> +	vdev->vdomain = NULL;
> +}
> +
>  static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
>  			    int prot, gfp_t gfp, size_t *mapped)
> @@ -990,6 +1012,7 @@ static void viommu_release_device(struct device *dev)
>  {
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
> +	viommu_detach_dev(vdev);
>  	iommu_put_resv_regions(dev, &vdev->resv_regions);
>  	kfree(vdev);
>  }
> -- 
> 2.40.0
> 
