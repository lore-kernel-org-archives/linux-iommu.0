Return-Path: <SRS0=qkVD=5I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27520C4332B
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:59:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD92420769
	for <iommu@archiver.kernel.org>; Mon, 23 Mar 2020 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ac8xEEQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD92420769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA5B287D61;
	Mon, 23 Mar 2020 09:59:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfoe-wF3-DQ8; Mon, 23 Mar 2020 09:59:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D07D687D57;
	Mon, 23 Mar 2020 09:59:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB1E7C1AE2;
	Mon, 23 Mar 2020 09:59:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C13EBC0177
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ADF2D861F1
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sdE7vZ9sZI5p for <iommu@lists.linux-foundation.org>;
 Mon, 23 Mar 2020 09:59:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6D04A80662
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 09:59:53 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id 31so10154017wrs.3
 for <iommu@lists.linux-foundation.org>; Mon, 23 Mar 2020 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SKwP6PuSmpPxD5KIQt+eRPXDv7gAdJWy99DhxndHi8Q=;
 b=Ac8xEEQD2/vnLVFS79WqIoarVPeLu0ry3vDW5+1c1fKc0szvKZVzENJvatKh+bdREL
 5PanFo7ygKEHHlN4Q6DeE3BmD3TXbVt5RjdrOfEsoBRhlmn8C6nqqI4RwgSgqAOz8eVa
 4kZDTlc6TyJIyKI389XnOOjmGCaSEkg7ZW7c8ZYNnw06IRYmhwtiVSqNQvw/v6jCt5VH
 51fRN61BQTGBuZc5p+/RPmRhVHluoRSd7noUSUVajFk+iyhPN6wrEv76zDDXlHV46/Ny
 yVia9MNh1KMi4ArJJuB941R/AwZruzfCZQMIkQMSXSa39SW/ykH32rdcIBRKhYzHY6Qg
 Ok0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SKwP6PuSmpPxD5KIQt+eRPXDv7gAdJWy99DhxndHi8Q=;
 b=sIb3AjptH9nfcvCP/+/H7QWH4EeUR+Wdeip59e+R3qPuH293E7RzNSix4ggCXAVTsX
 fxu9gubTcU6rmNlpdgrygnu+3qIyMY8oPeADD+BPTlXFuOw+NGNt9bixYepFk2piIKoE
 Iqpdc2IFBBFN9KV7iu1nU2IVEZlEMbv1jGXtKfTNb6HoKY+e8TccVGoyA5CuqFbO3xHe
 b26/He6kSHj0uNMjSGc5cF5SmwCcnZdwO9ixp4nfmRi04ReZcOs8IWQgwa1oTxneTWU2
 yW3DXFlIZnokp7u8o6I/326GxOq4FhTS/3waUQFEvrIt2NBSdU3sXDxzk0DAS/DP7Qdk
 cBvw==
X-Gm-Message-State: ANhLgQ0Lu4SmDSOpe0R7ylswmaSmIiuftlu9OWFc+kPUb9jOl95Ph5iY
 UL/K3VPo+DK/7mtsOpRrl4nyvg==
X-Google-Smtp-Source: ADFU+vtxV3GmAHk3qYBesY4u/jqaZVOvYlPww74IdS6zCly9cNlITWeL8IQJ2yfwWY2gDBlY07rn6A==
X-Received: by 2002:adf:ea8e:: with SMTP id s14mr29093421wrm.206.1584957591642; 
 Mon, 23 Mar 2020 02:59:51 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n1sm22800602wrj.77.2020.03.23.02.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 02:59:50 -0700 (PDT)
Date: Mon, 23 Mar 2020 10:59:43 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH RFC] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200323095943.GA2038940@myrica>
References: <20200323084108.1721-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200323084108.1721-1-bbhushan2@marvell.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jasowang@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Bharat,

Please add the IOMMU list on your next posting

On Mon, Mar 23, 2020 at 02:11:08PM +0530, Bharat Bhushan wrote:
> Different endpoint can support different page size, probe
> endpoint if it supports specific page size otherwise use
> global page sizes.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  drivers/iommu/virtio-iommu.c      | 24 ++++++++++++++++++++----
>  include/uapi/linux/virtio_iommu.h |  6 ++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index cce329d71fba..e69347ca4ee6 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -78,6 +78,7 @@ struct viommu_endpoint {
>  	struct viommu_dev		*viommu;
>  	struct viommu_domain		*vdomain;
>  	struct list_head		resv_regions;
> +	u64				pgsize_bitmap;
>  };
>  
>  struct viommu_request {
> @@ -415,6 +416,14 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
>  	return ret;
>  }
>  
> +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> +				    struct virtio_iommu_probe_pgsize_mask *mask)
> +
> +{
> +	vdev->pgsize_bitmap = mask->pgsize_bitmap;

We need to read this through le64_to_cpu(). Also check that the length of
the field provided by the device is >= sizeof(mask) (like
viommu_add_resv_mem() does)

> +	return 0;
> +}
> +
>  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  			       struct virtio_iommu_probe_resv_mem *mem,
>  			       size_t len)
> @@ -494,11 +503,13 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
>  	       cur < viommu->probe_size) {
>  		len = le16_to_cpu(prop->length) + sizeof(*prop);
> -
>  		switch (type) {
>  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
>  			break;
> +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop);
> +			break;
>  		default:
>  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
>  		}
> @@ -607,16 +618,21 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>  	return &vdomain->domain;
>  }
>  
> -static int viommu_domain_finalise(struct viommu_dev *viommu,
> +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  				  struct iommu_domain *domain)
>  {
>  	int ret;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct viommu_dev *viommu = vdev->viommu;
>  
>  	vdomain->viommu		= viommu;
>  	vdomain->map_flags	= viommu->map_flags;
>  
> -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> +	if (vdev->pgsize_bitmap)
> +		domain->pgsize_bitmap = vdev->pgsize_bitmap;
> +	else
> +		domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> +

nit: it could be nicer to initialize vdev->pgsize_bitmap in add_device(),
override it in probe_endpoint(), and just copy it here.

>  	domain->geometry	= viommu->geometry;
>  
>  	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> @@ -657,7 +673,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		 * Properly initialize the domain now that we know which viommu
>  		 * owns it.
>  		 */
> -		ret = viommu_domain_finalise(vdev->viommu, domain);
> +		ret = viommu_domain_finalise(vdev, domain);

Attaching additional endpoints with different masks to the domain should
return an error

>  	} else if (vdomain->viommu != vdev->viommu) {
>  		dev_err(dev, "cannot attach to foreign vIOMMU\n");
>  		ret = -EXDEV;
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..aff3db0ef54b 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>  
>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>  
>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>  
> @@ -119,6 +120,11 @@ struct virtio_iommu_probe_property {
>  	__le16					length;
>  };
>  
> +struct virtio_iommu_probe_pgsize_mask {
> +	struct virtio_iommu_probe_property	head;

Compilers will introduce 4 bytes of padding here, to align the next field.
We need to make them explicit by adding a 4-bytes 'reserved' field.

> +	uint64_t				pgsize_bitmap;

__le64

Thanks,
Jean

> +};
> +
>  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>  
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
