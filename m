Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26C1D516A
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015342; cv=none; b=Y+z7bImu5wArtbq0zFoUhm2h6LuUrfKQyk4rIV/3jLZpiK7/B/XXeubdR99M5NpY+o4Lqf62mbF0iL1FJCt8GGbyDwnVeYww/TY0OgUFf2MdaGCQ+RXcDGG2fCvb+1l5eq11p6Fljh8RqCHczhpu7VMudSozASBW3RQ+L9RVvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015342; c=relaxed/simple;
	bh=KeAOhF/tSRbbUNCZ1cXZMEVaaaHzf0ZSwQV/BU3ATG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QejvoDQP3fRRUqmPCMfuv61hXu4WG+7T45TNPbEvGmCqRjYjrUldRks/suPyUH99YylJYBMawbGpE1W+le9Mv4YnAfUV+xwoIjVJJMjQ/ERQM9DWoNqOgS0LAhRKcUirTDB6CNzwsopTQVX+/AJb547xE9phcgqn4DHYHeEkyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAeTMZDO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAeTMZDO"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso694535f8f.3
        for <iommu@lists.linux.dev>; Mon, 03 Mar 2025 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741015337; x=1741620137; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcZCKiDmcDV+Zl6nxjCvDXnjag3dxzpo0yD3ZrEqp+8=;
        b=kAeTMZDOKQt0VRrL4DwG3ZV3G/7B0v3T2OIoDGpdEbZBOOF3LrrI7qn5k6mv9tn+N0
         14NijCrQ058cGJuqDvnBJA+b8UPNTR/cIMrMckqIf8vesBZ69u9VBCW/kF6h3GRL+h2o
         FRbO0FAdOm5R8iGl57tmxzOLFmIceevu3DIVJevj66rMntsyKCo0ljSoQBSxAFvSdbLc
         mpn3WWy1oh24Yu5+DqOcRjLOrVSFexrRlVaFceSwVXTBvbeoB51n9DzrwKpnRXnDQ+zN
         xH0uNp7kIXQAQgFqEDcgUJTQ9jLzgsSXkOvB7spZomWELNl08j4kHyBOLk8z6jTyoV3V
         TxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015337; x=1741620137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcZCKiDmcDV+Zl6nxjCvDXnjag3dxzpo0yD3ZrEqp+8=;
        b=Nh96DXwoev3S8XY2XR23PmnZDvvj7/ufAhmOu2aoyrbeiBZRMEQgSrBI2E3KAiZYDz
         bvsZHm0jlKiiv2aDgXT4R7T5cPBUNBWwi7TFjNiIQhXU+4yj24TACJK+xr7qXjn7/chw
         rHUqkgjUzL1EInorBPpYvMwpibvJYMRjg/64skaO3RdodGk9H8hynYIHX9L7ipe9S5Ug
         v5XYSRx6cbVcbi4QsJnBHOQN9yUR3PDowcl8SPWUvw5FpbZfMfIuA+yuw+RHgfezhewp
         50uFFtNfGpTE2eLrjL1/z0rYiUDt4MoqvqD4tK2WYdZ2gXafYpUlg8HuCsHq6bHYCYjG
         cO/A==
X-Gm-Message-State: AOJu0YzpQoNxTkllPBAvZ+vKeengwK5eqi7Notn2/hXRLViS3zmk+jsK
	DDFLQUkgzf6KrgExTSEpN3CnnjUSa+NOhT5hxp0HEHfeuCKazjwD7bAAgPQRbns=
X-Gm-Gg: ASbGncuYOAytk6sDTCx7jpZLDPcb2F9ZB3OtQgp8rl2Vj16YhvQPsmctvtOLAFHwKCh
	jRz5AHPHKgtoWdsWNZcj3JRIB4XDo+1MSCIyIEonBaQHuzSqJDnRN40vH8fad7kqlLk6We1sKTc
	E4g1cPBvp++0k8Ze5i/rrUe+dvzxjJp9A9lQe5qu1kvjc8Umc+TwxPhSTA0Y4S4BHnIhtq/SYS0
	JMlbN6BtOliIX7GA3E+HI4uWAoLwtA6bfyh2jpo+iLRuBudKWigz2DrncXU8lCKrVn3FdZxK+XJ
	wfiJ2iM0i8f9P2nAMFxCBaN8HE22C1GTZeqavZ2Umd8=
X-Google-Smtp-Source: AGHT+IF2RZ18jiutaNwmQgyXw9Sya7CxFe3BwwYu1EQNCljMSVJq5RUCGSWLg0nAeTOJ0v5+o9CEEA==
X-Received: by 2002:a05:6000:280f:b0:390:e84f:c594 with SMTP id ffacd0b85a97d-390eca41cffmr7152457f8f.37.1741015337171;
        Mon, 03 Mar 2025 07:22:17 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dcc1sm14481904f8f.87.2025.03.03.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:22:16 -0800 (PST)
Date: Mon, 3 Mar 2025 15:22:43 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 1/5] iommu/virtio: Break out bypass identity support
 into a global static
Message-ID: <20250303152243.GB2083810@myrica>
References: <0-v2-a3b72fd4b99a+1b6-iommu_virtio_domains_jgg@nvidia.com>
 <1-v2-a3b72fd4b99a+1b6-iommu_virtio_domains_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v2-a3b72fd4b99a+1b6-iommu_virtio_domains_jgg@nvidia.com>

On Thu, Feb 27, 2025 at 08:19:59PM -0400, Jason Gunthorpe wrote:
> To make way for a domain_alloc_paging conversion add the typical global
> static IDENTITY domain. This supports VMMs that have a
> VIRTIO_IOMMU_F_BYPASS_CONFIG config.
> 
> If the VMM does not have support then the domain_alloc path is still used,
> which creates an IDENTITY domain out of a paging domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 86 ++++++++++++++++++++++++++++--------
>  1 file changed, 67 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index b85ce6310ddbda..55a2188197c621 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -48,6 +48,7 @@ struct viommu_dev {
>  	u64				pgsize_bitmap;
>  	u32				first_domain;
>  	u32				last_domain;
> +	u32				identity_domain_id;
>  	/* Supported MAP flags */
>  	u32				map_flags;
>  	u32				probe_size;
> @@ -70,7 +71,6 @@ struct viommu_domain {
>  	struct rb_root_cached		mappings;
>  
>  	unsigned long			nr_endpoints;
> -	bool				bypass;
>  };
>  
>  struct viommu_endpoint {
> @@ -305,6 +305,22 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
>  	return ret;
>  }
>  
> +static int viommu_send_attach_req(struct viommu_dev *viommu, struct device *dev,
> +				  struct virtio_iommu_req_attach *req)
> +{
> +	int ret;
> +	unsigned int i;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		req->endpoint = cpu_to_le32(fwspec->ids[i]);
> +		ret = viommu_send_req_sync(viommu, req, sizeof(*req));
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * viommu_add_mapping - add a mapping to the internal tree
>   *
> @@ -687,12 +703,6 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  	vdomain->viommu		= viommu;
>  
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> -		if (virtio_has_feature(viommu->vdev,
> -				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> -			vdomain->bypass = true;
> -			return 0;
> -		}
> -
>  		ret = viommu_domain_map_identity(vdev, vdomain);
>  		if (ret) {
>  			ida_free(&viommu->domain_ids, vdomain->id);
> @@ -719,10 +729,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  
>  static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
> -	int i;
>  	int ret = 0;
>  	struct virtio_iommu_req_attach req;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> @@ -761,16 +769,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		.domain		= cpu_to_le32(vdomain->id),
>  	};
>  
> -	if (vdomain->bypass)
> -		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
> -
> -	for (i = 0; i < fwspec->num_ids; i++) {
> -		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> -
> -		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
> -		if (ret)
> -			return ret;
> -	}
> +	ret = viommu_send_attach_req(vdomain->viommu, dev, &req);
> +	if (ret)
> +		return ret;
>  
>  	if (!vdomain->nr_endpoints) {
>  		/*
> @@ -788,6 +789,40 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	return 0;
>  }
>  
> +static int viommu_attach_identity_domain(struct iommu_domain *domain,
> +					 struct device *dev)
> +{
> +	int ret = 0;
> +	struct virtio_iommu_req_attach req;
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	req = (struct virtio_iommu_req_attach) {
> +		.head.type	= VIRTIO_IOMMU_T_ATTACH,
> +		.domain		= cpu_to_le32(vdev->viommu->identity_domain_id),
> +		.flags          = cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS),
> +	};
> +
> +	ret = viommu_send_attach_req(vdev->viommu, dev, &req);
> +	if (ret)
> +		return ret;
> +
> +	if (vdev->vdomain)
> +		vdev->vdomain->nr_endpoints--;
> +	vdomain->nr_endpoints++;
> +	vdev->vdomain = vdomain;
> +	return 0;
> +}
> +
> +static struct viommu_domain viommu_identity_domain = {
> +	.domain = {
> +		.type = IOMMU_DOMAIN_IDENTITY,
> +		.ops = &(const struct iommu_domain_ops) {
> +			.attach_dev = viommu_attach_identity_domain,
> +		},
> +	},
> +};
> +
>  static void viommu_detach_dev(struct viommu_endpoint *vdev)
>  {
>  	int i;
> @@ -1061,6 +1096,7 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  }
>  
>  static struct iommu_ops viommu_ops = {
> +	.identity_domain	= &viommu_identity_domain.domain,
>  	.capable		= viommu_capable,
>  	.domain_alloc		= viommu_domain_alloc,
>  	.probe_device		= viommu_probe_device,
> @@ -1184,6 +1220,18 @@ static int viommu_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
>  		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
>  
> +	/* Reserve an ID to use as the bypass domain */
> +	if (virtio_has_feature(viommu->vdev, VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +		viommu->identity_domain_id = viommu->first_domain;
> +		viommu->first_domain++;
> +	} else {
> +		/*
> +		 * Assume the VMM is sensible and it either supports bypass on
> +		 * all instances or no instances.
> +		 */
> +		viommu_ops.identity_domain = NULL;
> +	}
> +
>  	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
>  
>  	virtio_device_ready(vdev);
> -- 
> 2.43.0
> 
> 
