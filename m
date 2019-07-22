Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA8C76188
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 15:01:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354BE2190F
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 15:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354BE2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ED25CCDE;
	Mon, 22 Jul 2019 15:01:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A3CE6C79;
	Mon, 22 Jul 2019 15:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE910775;
	Mon, 22 Jul 2019 15:01:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82CDC30A7C6B;
	Mon, 22 Jul 2019 15:01:27 +0000 (UTC)
Received: from [10.36.116.45] (ovpn-116-45.ams2.redhat.com [10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9070A60A9F;
	Mon, 22 Jul 2019 15:01:23 +0000 (UTC)
Subject: Re: [PATCH] iommu/virtio: Update to most recent specification
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
	joro@8bytes.org
References: <20190722144007.6437-1-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2b649f7d-67fc-4535-9c80-669d916f9f29@redhat.com>
Date: Mon, 22 Jul 2019 17:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190722144007.6437-1-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 22 Jul 2019 15:01:27 +0000 (UTC)
Cc: jasowang@redhat.com, iommu@lists.linux-foundation.org,
	virtualization@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Jean,

On 7/22/19 4:40 PM, Jean-Philippe Brucker wrote:
> Following specification review a few things were changed in v8 of the
> virtio-iommu series [1], but have been omitted when merging the base
> driver. Add them now:
> 
> * Remove the EXEC flag.
> * Add feature bit for the MMIO flag.
> * Change domain_bits to domain_range.
> * Add NOMEM status flag.
> 
> [1] https://lore.kernel.org/linux-iommu/20190530170929.19366-1-jean-philippe.brucker@arm.com/

> 
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/virtio-iommu.c      | 40 ++++++++++++++++++++++---------
>  include/uapi/linux/virtio_iommu.h | 32 ++++++++++++++-----------
>  2 files changed, 47 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 433f4d2ee956..80a740df0737 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -2,7 +2,7 @@
>  /*
>   * Virtio driver for the paravirtualized IOMMU
>   *
> - * Copyright (C) 2018 Arm Limited
> + * Copyright (C) 2019 Arm Limited
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -47,7 +47,10 @@ struct viommu_dev {
>  	/* Device configuration */
>  	struct iommu_domain_geometry	geometry;
>  	u64				pgsize_bitmap;
> -	u8				domain_bits;
> +	u32				first_domain;
> +	u32				last_domain;
> +	/* Supported MAP flags */
> +	u32				map_flags;
>  	u32				probe_size;
>  };
>  
> @@ -62,6 +65,7 @@ struct viommu_domain {
>  	struct viommu_dev		*viommu;
>  	struct mutex			mutex; /* protects viommu pointer */
>  	unsigned int			id;
> +	u32				map_flags;
>  
>  	spinlock_t			mappings_lock;
>  	struct rb_root_cached		mappings;
> @@ -113,6 +117,8 @@ static int viommu_get_req_errno(void *buf, size_t len)
>  		return -ENOENT;
>  	case VIRTIO_IOMMU_S_FAULT:
>  		return -EFAULT;
> +	case VIRTIO_IOMMU_S_NOMEM:
> +		return -ENOMEM;
>  	case VIRTIO_IOMMU_S_IOERR:
>  	case VIRTIO_IOMMU_S_DEVERR:
>  	default:
> @@ -607,15 +613,15 @@ static int viommu_domain_finalise(struct viommu_dev *viommu,
>  {
>  	int ret;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> -	unsigned int max_domain = viommu->domain_bits > 31 ? ~0 :
> -				  (1U << viommu->domain_bits) - 1;
>  
>  	vdomain->viommu		= viommu;
> +	vdomain->map_flags	= viommu->map_flags;
>  
>  	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
>  	domain->geometry	= viommu->geometry;
>  
> -	ret = ida_alloc_max(&viommu->domain_ids, max_domain, GFP_KERNEL);
> +	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> +			      viommu->last_domain, GFP_KERNEL);
>  	if (ret >= 0)
>  		vdomain->id = (unsigned int)ret;
>  
> @@ -710,7 +716,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  		      phys_addr_t paddr, size_t size, int prot)
>  {
>  	int ret;
> -	int flags;
> +	u32 flags;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> @@ -718,6 +724,9 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
>  		(prot & IOMMU_MMIO ? VIRTIO_IOMMU_MAP_F_MMIO : 0);
>  
> +	if (flags & ~vdomain->map_flags)
> +		return -EINVAL;
> +
>  	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
>  	if (ret)
>  		return ret;
> @@ -1027,7 +1036,8 @@ static int viommu_probe(struct virtio_device *vdev)
>  		goto err_free_vqs;
>  	}
>  
> -	viommu->domain_bits = 32;
> +	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
> +	viommu->last_domain = ~0U;
>  
>  	/* Optional features */
>  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
> @@ -1038,9 +1048,13 @@ static int viommu_probe(struct virtio_device *vdev)
>  			     struct virtio_iommu_config, input_range.end,
>  			     &input_end);
>  
> -	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_BITS,
> -			     struct virtio_iommu_config, domain_bits,
> -			     &viommu->domain_bits);
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
> +			     struct virtio_iommu_config, domain_range.start,
> +			     &viommu->first_domain);
> +
> +	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
> +			     struct virtio_iommu_config, domain_range.end,
> +			     &viommu->last_domain);
>  
>  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
>  			     struct virtio_iommu_config, probe_size,
> @@ -1052,6 +1066,9 @@ static int viommu_probe(struct virtio_device *vdev)
>  		.force_aperture	= true,
>  	};
>  
> +	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
> +		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
> +
>  	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
>  
>  	virtio_device_ready(vdev);
> @@ -1130,9 +1147,10 @@ static void viommu_config_changed(struct virtio_device *vdev)
>  
>  static unsigned int features[] = {
>  	VIRTIO_IOMMU_F_MAP_UNMAP,
> -	VIRTIO_IOMMU_F_DOMAIN_BITS,
>  	VIRTIO_IOMMU_F_INPUT_RANGE,
> +	VIRTIO_IOMMU_F_DOMAIN_RANGE,
>  	VIRTIO_IOMMU_F_PROBE,
> +	VIRTIO_IOMMU_F_MMIO,
>  };
>  
>  static struct virtio_device_id id_table[] = {
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index ba1b460c9944..237e36a280cb 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -1,8 +1,8 @@
>  /* SPDX-License-Identifier: BSD-3-Clause */
>  /*
> - * Virtio-iommu definition v0.9
> + * Virtio-iommu definition v0.12
>   *
> - * Copyright (C) 2018 Arm Ltd.
> + * Copyright (C) 2019 Arm Ltd.
>   */
>  #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
>  #define _UAPI_LINUX_VIRTIO_IOMMU_H
> @@ -11,26 +11,31 @@
>  
>  /* Feature bits */
>  #define VIRTIO_IOMMU_F_INPUT_RANGE		0
> -#define VIRTIO_IOMMU_F_DOMAIN_BITS		1
> +#define VIRTIO_IOMMU_F_DOMAIN_RANGE		1
>  #define VIRTIO_IOMMU_F_MAP_UNMAP		2
>  #define VIRTIO_IOMMU_F_BYPASS			3
>  #define VIRTIO_IOMMU_F_PROBE			4
> +#define VIRTIO_IOMMU_F_MMIO			5
>  
> -struct virtio_iommu_range {
> -	__u64					start;
> -	__u64					end;
> +struct virtio_iommu_range_64 {
> +	__le64					start;
> +	__le64					end;
> +};
> +
> +struct virtio_iommu_range_32 {
> +	__le32					start;
> +	__le32					end;
>  };
>  
>  struct virtio_iommu_config {
>  	/* Supported page sizes */
> -	__u64					page_size_mask;
> +	__le64					page_size_mask;
>  	/* Supported IOVA range */
> -	struct virtio_iommu_range		input_range;
> +	struct virtio_iommu_range_64		input_range;
>  	/* Max domain ID size */
> -	__u8					domain_bits;
> -	__u8					padding[3];
> +	struct virtio_iommu_range_32		domain_range;
>  	/* Probe buffer size */
> -	__u32					probe_size;
> +	__le32					probe_size;
>  };
>  
>  /* Request types */
> @@ -49,6 +54,7 @@ struct virtio_iommu_config {
>  #define VIRTIO_IOMMU_S_RANGE			0x05
>  #define VIRTIO_IOMMU_S_NOENT			0x06
>  #define VIRTIO_IOMMU_S_FAULT			0x07
> +#define VIRTIO_IOMMU_S_NOMEM			0x08
>  
>  struct virtio_iommu_req_head {
>  	__u8					type;
> @@ -78,12 +84,10 @@ struct virtio_iommu_req_detach {
>  
>  #define VIRTIO_IOMMU_MAP_F_READ			(1 << 0)
>  #define VIRTIO_IOMMU_MAP_F_WRITE		(1 << 1)
> -#define VIRTIO_IOMMU_MAP_F_EXEC			(1 << 2)
> -#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 3)
> +#define VIRTIO_IOMMU_MAP_F_MMIO			(1 << 2)
>  
>  #define VIRTIO_IOMMU_MAP_F_MASK			(VIRTIO_IOMMU_MAP_F_READ |	\
>  						 VIRTIO_IOMMU_MAP_F_WRITE |	\
> -						 VIRTIO_IOMMU_MAP_F_EXEC |	\
>  						 VIRTIO_IOMMU_MAP_F_MMIO)
>  
>  struct virtio_iommu_req_map {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
