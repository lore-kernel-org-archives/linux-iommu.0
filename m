Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FF282E1
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024340; cv=none; b=n3PNwUzLRFHY9LUEoqKwcufNW8ZCPsFf5WPQcd1CVK8hQUPEuS4nejGf3bDy3bsUR9tXRPyZlIAmxXEHhyITIAa6gAa/2GNy0HkI1Vaop4iJ9wAngHsunuEs33zAQ3QbN44nq7Zgor9abg5VBsT3+5uBbnTkVDbbNmTaaky68/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024340; c=relaxed/simple;
	bh=ZPRti1CI8p1V40wO4CGTtrqPhRk4GtpbeKPBK/2WljE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UF1iPUCEBQuERUXvWoKeSDhlF3s/toQFCKhpaw6GEMoS+rKf44biho2nULP1EPLHwdWGbdl5P0a5Z+Dw7f99a9jhTvbPireUhOWOXmqjdBMlnB3obIhOTmLrkYDRtiPrbKrFc3POAgzWUDzwpz+6zJlat3x1EktAghwa1svHUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpffOb8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpffOb8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720024338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T29v3MqMDNzKMLmvfKJHErvtZBlG75imLBcIldPfbq8=;
	b=PpffOb8viEhI6gZd+WTEXRT4ulosUJ0foJGj70+JkbiuiVFY1Jo++kluw/Z4r/vC1TS54/
	ZlSWUyLRF2L8/3gOmJF4yYQoqpcOf4xGq8DXBupTWZ2R1S9r83NGGfzA/MD9XC1vrTJAQr
	BTkEEfZE8KSTHwGJKAPZDqhnZ92eP/g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-fjRz9tsuPXW2MTBndu1LmA-1; Wed, 03 Jul 2024 12:32:16 -0400
X-MC-Unique: fjRz9tsuPXW2MTBndu1LmA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee87d500caso6308211fa.3
        for <iommu@lists.linux.dev>; Wed, 03 Jul 2024 09:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024335; x=1720629135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T29v3MqMDNzKMLmvfKJHErvtZBlG75imLBcIldPfbq8=;
        b=uLa72NB26BsY5p/BRTWAeFOt/Rigzo+DWhXwFPd/sZLXIeYQnkUzPBh55dKe8SxoxW
         NizW++bsn/Jh+rfYuqr1Aa10GQkHODIyWx/nxTCMYMrXnldLfGXJYW2DXAAnibXdP/KK
         M0ArLE05UioFnviDM66GzKc6aWjRDI+OowZe7Vzn2B8VM3iZWg2c5hAPLIlUA4OlGZYc
         NWkNFWB1e40Pg5XERyn+vF1F4F9IuLk+g8OIxGinH9nOtlix2tHNMPh+n5JzCCRDPDAX
         kqprMaP4VvhtjO6V6UHIS4iKTch5YaWYFTgBP+LoUv0M5y8Rtcibz7i42k+XMxTfVt+z
         8oDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDeSq25CnIDxKNMPwVjdGoZ2M9P5GY0wa3eRBvxTmKHLKf78wirDAuS4VXecuz06bISC7fVenTK8D4oUU7LakWP17JHYI=
X-Gm-Message-State: AOJu0YzgAanYWxvjNjt0PKGlBDD2X9Vul8gijfMpJhEJXbwdoJUsXKvh
	tKkDFFm+vDeAZTo30Q5aQUMXDyuBAbcJkATd0R3w/SXhWUvm/0Veb/rfoIwpm8brK1uHyrV0a/R
	PKqV+SHh+5rsCZPQOLJRujVWQgmVBEsyn6UwV6+l4e/CFoqRNb25k
X-Received: by 2002:a2e:bc19:0:b0:2eb:d924:43fb with SMTP id 38308e7fff4ca-2ee5e6bc6f7mr90933001fa.41.1720024335094;
        Wed, 03 Jul 2024 09:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3V7vYkVhH8OJphhsnsxAVWOG21asngpKcdckbhi0zQYrX/jZvvDTcTN6is+OmAjmZQvtD0g==
X-Received: by 2002:a2e:bc19:0:b0:2eb:d924:43fb with SMTP id 38308e7fff4ca-2ee5e6bc6f7mr90932111fa.41.1720024332354;
        Wed, 03 Jul 2024 09:32:12 -0700 (PDT)
Received: from redhat.com ([31.187.78.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cff9sm242324535e9.3.2024.07.03.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:32:11 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:32:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
Message-ID: <20240703123146-mutt-send-email-mst@kernel.org>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240610085555.88197-5-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2024 at 04:55:38PM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_paging_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


I assume it's merged with the rest of the stuff, right?

> ---
>  drivers/vhost/vdpa.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 63a53680a85c..e31ec9ebc4ce 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1312,26 +1312,24 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
> -	const struct bus_type *bus;
>  	int ret;
>  
>  	/* Device want to do DMA by itself */
>  	if (ops->set_map || ops->dma_map)
>  		return 0;
>  
> -	bus = dma_dev->bus;
> -	if (!bus)
> -		return -EFAULT;
> -
>  	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
>  		dev_warn_once(&v->dev,
>  			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
>  		return -ENOTSUPP;
>  	}
>  
> -	v->domain = iommu_domain_alloc(bus);
> -	if (!v->domain)
> -		return -EIO;
> +	v->domain = iommu_paging_domain_alloc(dma_dev);
> +	if (IS_ERR(v->domain)) {
> +		ret = PTR_ERR(v->domain);
> +		v->domain = NULL;
> +		return ret;
> +	}
>  
>  	ret = iommu_attach_device(v->domain, dma_dev);
>  	if (ret)
> -- 
> 2.34.1

