Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8389C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 12:34:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331F464F4E
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 12:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331F464F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03DA186E1A;
	Tue,  2 Feb 2021 12:34:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxKuZGXomJov; Tue,  2 Feb 2021 12:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B56386C1D;
	Tue,  2 Feb 2021 12:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C41FC0FA7;
	Tue,  2 Feb 2021 12:34:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2FD6C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 12:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D0372001E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 12:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HoEiriCNaJ7s for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 12:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 423BA2001C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 12:34:42 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DVPPC5SkTzjFR0;
 Tue,  2 Feb 2021 20:33:35 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 20:34:36 +0800
Subject: Re: [PATCH v11 01/13] vfio: VFIO_IOMMU_SET_PASID_TABLE
To: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>, <will@kernel.org>,
 <joro@8bytes.org>, <maz@kernel.org>, <robin.murphy@arm.com>,
 <alex.williamson@redhat.com>
References: <20201116110030.32335-1-eric.auger@redhat.com>
 <20201116110030.32335-2-eric.auger@redhat.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <84a111da-1969-1701-9a6d-cae8d7c285c6@huawei.com>
Date: Tue, 2 Feb 2021 20:34:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201116110030.32335-2-eric.auger@redhat.com>
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, vivek.gautam@arm.com, zhangfei.gao@linaro.org
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

Hi Eric,

On 2020/11/16 19:00, Eric Auger wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> This patch adds an VFIO_IOMMU_SET_PASID_TABLE ioctl
> which aims to pass the virtual iommu guest configuration
> to the host. This latter takes the form of the so-called
> PASID table.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v11 -> v12:
> - use iommu_uapi_set_pasid_table
> - check SET and UNSET are not set simultaneously (Zenghui)
> 
> v8 -> v9:
> - Merge VFIO_IOMMU_ATTACH/DETACH_PASID_TABLE into a single
>   VFIO_IOMMU_SET_PASID_TABLE ioctl.
> 
> v6 -> v7:
> - add a comment related to VFIO_IOMMU_DETACH_PASID_TABLE
> 
> v3 -> v4:
> - restore ATTACH/DETACH
> - add unwind on failure
> 
> v2 -> v3:
> - s/BIND_PASID_TABLE/SET_PASID_TABLE
> 
> v1 -> v2:
> - s/BIND_GUEST_STAGE/BIND_PASID_TABLE
> - remove the struct device arg
> ---
>  drivers/vfio/vfio_iommu_type1.c | 65 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 19 ++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 67e827638995..87ddd9e882dc 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2587,6 +2587,41 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static void
> +vfio_detach_pasid_table(struct vfio_iommu *iommu)
> +{
> +	struct vfio_domain *d;
> +
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(d, &iommu->domain_list, next)
> +		iommu_detach_pasid_table(d->domain);
> +
> +	mutex_unlock(&iommu->lock);
> +}
> +
> +static int
> +vfio_attach_pasid_table(struct vfio_iommu *iommu, unsigned long arg)
> +{
> +	struct vfio_domain *d;
> +	int ret = 0;
> +
> +	mutex_lock(&iommu->lock);
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		ret = iommu_uapi_attach_pasid_table(d->domain, (void __user *)arg);
This design is not very clear to me. This assumes all iommu_domains share the same pasid table.

As I understand, it's reasonable when there is only one group in the domain, and only one domain in the vfio_iommu.
If more than one group in the vfio_iommu, the guest may put them into different guest iommu_domain, then they have different pasid table.

Is this the use scenario?

Thanks,
Keqian

> +		if (ret)
> +			goto unwind;
> +	}
> +	goto unlock;
> +unwind:
> +	list_for_each_entry_continue_reverse(d, &iommu->domain_list, next) {
> +		iommu_detach_pasid_table(d->domain);
> +	}
> +unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>  					   struct vfio_info_cap *caps)
>  {
> @@ -2747,6 +2782,34 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
>  			-EFAULT : 0;
>  }
>  
> +static int vfio_iommu_type1_set_pasid_table(struct vfio_iommu *iommu,
> +					    unsigned long arg)
> +{
> +	struct vfio_iommu_type1_set_pasid_table spt;
> +	unsigned long minsz;
> +	int ret = -EINVAL;
> +
> +	minsz = offsetofend(struct vfio_iommu_type1_set_pasid_table, flags);
> +
> +	if (copy_from_user(&spt, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (spt.argsz < minsz)
> +		return -EINVAL;
> +
> +	if (spt.flags & VFIO_PASID_TABLE_FLAG_SET &&
> +	    spt.flags & VFIO_PASID_TABLE_FLAG_UNSET)
> +		return -EINVAL;
> +
> +	if (spt.flags & VFIO_PASID_TABLE_FLAG_SET)
> +		ret = vfio_attach_pasid_table(iommu, arg + minsz);
> +	else if (spt.flags & VFIO_PASID_TABLE_FLAG_UNSET) {
> +		vfio_detach_pasid_table(iommu);
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
>  static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>  					unsigned long arg)
>  {
> @@ -2867,6 +2930,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		return vfio_iommu_type1_unmap_dma(iommu, arg);
>  	case VFIO_IOMMU_DIRTY_PAGES:
>  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> +	case VFIO_IOMMU_SET_PASID_TABLE:
> +		return vfio_iommu_type1_set_pasid_table(iommu, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 2f313a238a8f..78ce3ce6c331 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> +#include <linux/iommu.h>
>  
>  #define VFIO_API_VERSION	0
>  
> @@ -1180,6 +1181,24 @@ struct vfio_iommu_type1_dirty_bitmap_get {
>  
>  #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
>  
> +/*
> + * VFIO_IOMMU_SET_PASID_TABLE - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> + *			struct vfio_iommu_type1_set_pasid_table)
> + *
> + * The SET operation passes a PASID table to the host while the
> + * UNSET operation detaches the one currently programmed. Setting
> + * a table while another is already programmed replaces the old table.
> + */
> +struct vfio_iommu_type1_set_pasid_table {
> +	__u32	argsz;
> +	__u32	flags;
> +#define VFIO_PASID_TABLE_FLAG_SET	(1 << 0)
> +#define VFIO_PASID_TABLE_FLAG_UNSET	(1 << 1)
> +	struct iommu_pasid_table_config config; /* used on SET */
> +};
> +
> +#define VFIO_IOMMU_SET_PASID_TABLE	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
