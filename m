Return-Path: <SRS0=R9yw=VE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC6C48BE1
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:13:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA20E2082E
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA20E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 460261E71;
	Sun,  7 Jul 2019 15:13:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E12B71E1A
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 55AAC7D2
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:45 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D03B73086215;
	Sun,  7 Jul 2019 15:03:44 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B4DE18E2E;
	Sun,  7 Jul 2019 15:03:42 +0000 (UTC)
Subject: Re: [PATCH v7 5/6] vfio/type1: Add IOVA range capability support
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
	<20190626151248.11776-6-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <78727f63-e83f-f588-f0db-79ceb0dcbab9@redhat.com>
Date: Sun, 7 Jul 2019 17:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190626151248.11776-6-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Sun, 07 Jul 2019 15:03:44 +0000 (UTC)
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuwei5@hisilicon.com, linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

Hi Shameer,

On 6/26/19 5:12 PM, Shameer Kolothum wrote:
> This allows the user-space to retrieve the supported IOVA
> range(s), excluding any reserved regions. The implementation
non relaxable reserved regions
> is based on capability chains, added to VFIO_IOMMU_GET_INFO ioctl.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v6 --> v7
> 
> Addressed mdev case with empty iovas list(Suggested by Alex)
> ---
>  drivers/vfio/vfio_iommu_type1.c | 101 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  23 ++++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 89ad0da7152c..450081802dcd 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2141,6 +2141,73 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
> +		 struct vfio_iommu_type1_info_cap_iova_range *cap_iovas,
> +		 size_t size)
> +{
> +	struct vfio_info_cap_header *header;
> +	struct vfio_iommu_type1_info_cap_iova_range *iova_cap;
> +
> +	header = vfio_info_cap_add(caps, size,
> +				   VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE, 1);
> +	if (IS_ERR(header))
> +		return PTR_ERR(header);
> +
> +	iova_cap = container_of(header,
> +				struct vfio_iommu_type1_info_cap_iova_range,
> +				header);
> +	iova_cap->nr_iovas = cap_iovas->nr_iovas;
> +	memcpy(iova_cap->iova_ranges, cap_iovas->iova_ranges,
> +	       cap_iovas->nr_iovas * sizeof(*cap_iovas->iova_ranges));
> +	return 0;
> +}
> +
> +static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
> +				      struct vfio_info_cap *caps)
> +{
> +	struct vfio_iommu_type1_info_cap_iova_range *cap_iovas;
> +	struct vfio_iova *iova;
> +	size_t size;
> +	int iovas = 0, i = 0, ret;
> +
> +	mutex_lock(&iommu->lock);
> +
> +	list_for_each_entry(iova, &iommu->iova_list, list)
> +		iovas++;
> +
> +	if (!iovas) {
> +		/*
> +		 * Return 0 as a container with only an mdev device
> +		 * will have an empty list
> +		 */
> +		ret = 0;
> +		goto out_unlock;
> +	}
> +
> +	size = sizeof(*cap_iovas) + (iovas * sizeof(*cap_iovas->iova_ranges));
> +
> +	cap_iovas = kzalloc(size, GFP_KERNEL);
> +	if (!cap_iovas) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	cap_iovas->nr_iovas = iovas;
> +
> +	list_for_each_entry(iova, &iommu->iova_list, list) {
> +		cap_iovas->iova_ranges[i].start = iova->start;
> +		cap_iovas->iova_ranges[i].end = iova->end;
> +		i++;
> +	}
> +
> +	ret = vfio_iommu_iova_add_cap(caps, cap_iovas, size);
> +
> +	kfree(cap_iovas);
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2162,19 +2229,53 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		}
>  	} else if (cmd == VFIO_IOMMU_GET_INFO) {
>  		struct vfio_iommu_type1_info info;
> +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +		unsigned long capsz;
> +		int ret;
>  
>  		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
>  
> +		/* For backward compatibility, cannot require this */
> +		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
> +
>  		if (copy_from_user(&info, (void __user *)arg, minsz))
>  			return -EFAULT;
>  
>  		if (info.argsz < minsz)
>  			return -EINVAL;
>  
> +		if (info.argsz >= capsz) {
> +			minsz = capsz;
> +			info.cap_offset = 0; /* output, no-recopy necessary */
> +		}
> +
>  		info.flags = VFIO_IOMMU_INFO_PGSIZES;
>  
>  		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
>  
> +		ret = vfio_iommu_iova_build_caps(iommu, &caps);
> +		if (ret)
> +			return ret;
> +
> +		if (caps.size) {
> +			info.flags |= VFIO_IOMMU_INFO_CAPS;
> +
> +			if (info.argsz < sizeof(info) + caps.size) {
> +				info.argsz = sizeof(info) + caps.size;
> +			} else {
> +				vfio_info_cap_shift(&caps, sizeof(info));
> +				if (copy_to_user((void __user *)arg +
> +						sizeof(info), caps.buf,
> +						caps.size)) {
> +					kfree(caps.buf);
> +					return -EFAULT;
> +				}
> +				info.cap_offset = sizeof(info);
> +			}
> +
> +			kfree(caps.buf);
> +		}
> +
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 8f10748dac79..1951d87115e8 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -714,7 +714,30 @@ struct vfio_iommu_type1_info {
>  	__u32	argsz;
>  	__u32	flags;
>  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
> +#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
>  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> +	__u32   cap_offset;	/* Offset within info struct of first cap */
comment indent?
> +};
> +
> +/*
> + * The IOVA capability allows to report the valid IOVA range(s)
> + * excluding any reserved regions associated with dev group. Any dma
any non relaxable reserved regions exposed by devices attached to the
container?
s/dma/DMA?
> + * map attempt outside the valid iova range will return error.
> + *
> + * The structures below define version 1 of this capability.
> + */
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE  1
> +
> +struct vfio_iova_range {
> +	__u64	start;
> +	__u64	end;
> +};
> +
> +struct vfio_iommu_type1_info_cap_iova_range {
> +	struct vfio_info_cap_header header;
> +	__u32	nr_iovas;
> +	__u32	reserved;
> +	struct vfio_iova_range iova_ranges[];
>  };
>  
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
