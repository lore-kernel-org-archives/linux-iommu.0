Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A5C47247
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 00:22:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A695206B8
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 00:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gybJtBt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A695206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 283F786DF4;
	Wed,  6 May 2020 00:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUTyE_Z4UBjT; Wed,  6 May 2020 00:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2815F86DD3;
	Wed,  6 May 2020 00:22:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4F4C088B;
	Wed,  6 May 2020 00:22:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37EA2C0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 00:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 279248869A
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 00:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zSLtphrNxmOv for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 00:22:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3F19688699
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 00:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588724563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QoqKXjvHS1POFny3QwrSW9RfCPL+8QBVwaJ8hMnU7Dg=;
 b=gybJtBt8PlE87Jaoh5mOokREGY+u5Mb+3wYcPVFQGqxYldGheScX9g5JRs49EpQgAnBsRo
 urZHQ9krIkB9h59yCfxLmxQ5OOnasVP1+c/zinGxbMHcnvateUSXyY9OkSsPZqqvFh1h2i
 eQOYddd1URxS02WxsPz4KH1qucCY5RQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-OtPrl8l3MpanXuxpgmzmpg-1; Tue, 05 May 2020 20:22:42 -0400
X-MC-Unique: OtPrl8l3MpanXuxpgmzmpg-1
Received: by mail-wr1-f72.google.com with SMTP id x8so303925wrl.16
 for <iommu@lists.linux-foundation.org>; Tue, 05 May 2020 17:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QoqKXjvHS1POFny3QwrSW9RfCPL+8QBVwaJ8hMnU7Dg=;
 b=Lp3xKPxVjU0T/WitgdJRLZJcxPwVzUj5/gzxYObq/T04tsgAJYiXffPKgLpdQNCxeO
 9TdvE9SLWiP5zD9aQp/sMq4aMToQEo8aXrGic/rjf1UvmpQQpWjBSruR39DepjMqnTqk
 g/BJ1q1HuG+NOFHVFK//qfA1T2FuJivZxy2Tc+dJCyaO8CyO372N5JoY0qA8VUosFuBk
 FB0/hVRhpSv+HcLJaW2ATiJCzXSQbx74IFi1yrxdone9KQbRtl7FWA//UvsKJCcIAbXI
 GuKMCGYz5XWc7g10gSYPvo6AZmgu98iCftmGEb2tJJv9/CZTPrVc/4AkEvy80KDHMrP7
 Zy7w==
X-Gm-Message-State: AGi0PubxLNET8ZPk28hjfbkwMbQalQa2z6mfulEUd1XDULd6fajbQizy
 ikmOrHtIQfy1lJ6Y8q1Rm8YzqKVuJMp31ISe3ALLiXHS4n3m/lzBG2njerqO0gxteq9Ajwgn7j9
 2RzhDN+yFi9VH1eXzWk/FqWrzSfEB1w==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr6674143wrp.142.1588724561168; 
 Tue, 05 May 2020 17:22:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJmoSpO73yXNDTz8jDLDw6M0OmFQm9c8vXZNzPGPO9rFjmHx4lA5SH/ADZzc+i0KYiNA0+Q4A==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr6674112wrp.142.1588724560893; 
 Tue, 05 May 2020 17:22:40 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n12sm299685wrj.95.2020.05.05.17.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 17:22:40 -0700 (PDT)
Date: Tue, 5 May 2020 20:22:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200505200659-mutt-send-email-mst@kernel.org>
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

This is too late to validate length, you have dereferenced it already.
do it before the read pls.

> +		return -EINVAL;

OK but note that guest will then just proceed to ignore the
property. Is that really OK? Wouldn't host want to know?


> +
> +	vdev->pgsize_bitmap = pgsize_bitmap;

what if bitmap is 0? Is that a valid size? I see a bunch of
BUG_ON with that value ...

I also see a bunch of code like e.g. this:

        pg_size = 1UL << __ffs(pgsize_bitmap);

which probably won't DTRT on a 32 bit guest if the bitmap has bits
set in the high word.



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

I'm confused by this. So let's assume host supports pages sizes
of 4k, 2M, 1G. It signals this in the properties. Nice.
Now domain supports 4k, 2M and that's all. Why is that a problem?
Just don't use 1G ...


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

As any virtio UAPI change, you need to copy virtio TC at some point
before this is merged ...

> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>  
>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>  
>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>

Does host need to know that guest will ignore the page size mask?
Maybe we need a feature bit.
  
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

This is UAPI. Document the format of pgsize_bitmap please.


>  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>  
> -- 
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
