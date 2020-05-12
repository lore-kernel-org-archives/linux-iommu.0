Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E3EC54E4A
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 14:54:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1EA206B8
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDOhFiBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1EA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C6B3D84CF4;
	Tue, 12 May 2020 14:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsRvqRADFizf; Tue, 12 May 2020 14:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E1BB84E24;
	Tue, 12 May 2020 14:54:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 299E2C0178;
	Tue, 12 May 2020 14:54:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C990C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 14:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5881426316
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 14:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 636yYAs7e3L7 for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 14:54:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 137DC262BC
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589295242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZOs/bxxTbikpapKhWDX3v8GWxjINqQOFJaU3KA5ktI=;
 b=FDOhFiBkaGnfCd5a6YQuC+eKq29L6ejIDulwOKPjXqJH5BHFBE276iJvBktGbfNoLZJkKB
 5HHkARwp+1XGK7hOQjvkDXWbLxhR135YnxIscJTQhj9VrBVdvSduUg+DUXYvHnAwd4Vw4m
 efjgtxK+6CmLvkDw0+5hA0fzzg8LHQo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-iFDxTXAuPCCn60s5mj6AMQ-1; Tue, 12 May 2020 10:53:44 -0400
X-MC-Unique: iFDxTXAuPCCn60s5mj6AMQ-1
Received: by mail-wr1-f69.google.com with SMTP id o6so7087067wrn.0
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 07:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YZOs/bxxTbikpapKhWDX3v8GWxjINqQOFJaU3KA5ktI=;
 b=qp1AXRXPRTGJyvYPw5QAhUDy3kEjz2OQThFrr0cVgv+NrbjrwvoVxSLSZj+HXCvaF1
 bWY3I5YfMcbENG7V/V41lt9UbaM7sO3QmXrTrEGSdEhQm9GW7acnxlYvEIQYcT7g3DoI
 A8DKMxOV71d00QtmworkpLY14ePXMBBgLKwmVrUnwDukGeYZg9nYFAM83ri5CBKq0huD
 x0pvdIge/wrw/qfUB0aUCd6Il9Vo5CbA5stBvFcSO6gjMQS2hLLoeQMGZubVleThbzj2
 bjsFa8dpDgRkqwyPtXLMN9HI0cEa6r9GPtvK8mkQm4KJZMbwZKmwGGVsTkWzKh01h1hR
 sOyA==
X-Gm-Message-State: AGi0PuZm8jLsTpinW+QOE2LUHFPoLLteV0V8G7wc5+nYjc2rPvF/+8n5
 AYVJQZxgxOqILE0ndyP7vbrbhRFghCtsUTorMDjt7QzacW1Il9Ctj3OxOsQ6MH4YlLeRY663HgN
 F3gW42aKRdC9GXui0TABKtnbvrGt9nw==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr24982847wrm.43.1589295223052; 
 Tue, 12 May 2020 07:53:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIw5On7DBpVmIndpyIiLyjKFPEMnKTaMXAz7znewwU/ycqbbRTJxLZoZDsaR40tXDplD0nbCA==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr24982818wrm.43.1589295222757; 
 Tue, 12 May 2020 07:53:42 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
 by smtp.gmail.com with ESMTPSA id v131sm4782950wmb.27.2020.05.12.07.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 07:53:42 -0700 (PDT)
Date: Tue, 12 May 2020 10:53:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200512105149-mutt-send-email-mst@kernel.org>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
MIME-Version: 1.0
In-Reply-To: <20200505093004.1935-1-bbhushan2@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jasowang@redhat.com, eric.auger.pro@gmail.com
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

On Tue, May 05, 2020 at 03:00:04PM +0530, Bharat Bhushan wrote:
> Different endpoint can support different page size, probe
> endpoint if it supports specific page size otherwise use
> global page sizes.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v4->v5:
>  - Rebase to Linux v5.7-rc4
> 
> v3->v4:
>  - Fix whitespace error
> 
> v2->v3:
>  - Fixed error return for incompatible endpoint
>  - __u64 changed to __le64 in header file
> 
>  drivers/iommu/virtio-iommu.c      | 48 ++++++++++++++++++++++++++++---
>  include/uapi/linux/virtio_iommu.h |  7 +++++
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index d5cac4f46ca5..9513d2ab819e 100644
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
> @@ -415,6 +416,19 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
>  	return ret;
>  }
>  
> +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> +				    struct virtio_iommu_probe_pgsize_mask *mask,
> +				    size_t len)
> +{
> +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> +
> +	if (len < sizeof(*mask))
> +		return -EINVAL;
> +
> +	vdev->pgsize_bitmap = pgsize_bitmap;
> +	return 0;
> +}
> +
>  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  			       struct virtio_iommu_probe_resv_mem *mem,
>  			       size_t len)
> @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
>  			break;
> +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> +			break;
>  		default:
>  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
>  		}

So given this is necessary early in boot, how about we
add this in the config space? And maybe ACPI too ...


> @@ -630,7 +647,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  
>  	vdomain->id		= (unsigned int)ret;
>  
> -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> +	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
>  	domain->geometry	= viommu->geometry;
>  
>  	vdomain->map_flags	= viommu->map_flags;
> @@ -654,6 +671,29 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  	kfree(vdomain);
>  }
>  
> +/*
> + * Check whether the endpoint's capabilities are compatible with other
> + * endpoints in the domain. Report any inconsistency.
> + */
> +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
> +					  struct viommu_domain *vdomain)
> +{
> +	struct device *dev = vdev->dev;
> +
> +	if (vdomain->viommu != vdev->viommu) {
> +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> +		return false;
> +	}
> +
> +	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
> +		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
> +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int i;
> @@ -670,9 +710,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		 * owns it.
>  		 */
>  		ret = viommu_domain_finalise(vdev, domain);
> -	} else if (vdomain->viommu != vdev->viommu) {
> -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> -		ret = -EXDEV;
> +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
> +		ret = -EINVAL;
>  	}
>  	mutex_unlock(&vdomain->mutex);
>  
> @@ -886,6 +925,7 @@ static int viommu_add_device(struct device *dev)
>  
>  	vdev->dev = dev;
>  	vdev->viommu = viommu;
> +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
>  	INIT_LIST_HEAD(&vdev->resv_regions);
>  	dev_iommu_priv_set(dev, vdev);
>  
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 48e3c29223b5..2cced7accc99 100644
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
> @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
>  	__le16					length;
>  };
>  
> +struct virtio_iommu_probe_pgsize_mask {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	__le64					pgsize_bitmap;
> +};
> +
>  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>  
> -- 
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
