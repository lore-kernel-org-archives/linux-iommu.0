Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB58C433E2
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 18:39:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D0D20772
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 18:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYrFp5um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D0D20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B264A24F13;
	Thu,  2 Jul 2020 18:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeSiZd5-+v5P; Thu,  2 Jul 2020 18:39:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8E02524EA2;
	Thu,  2 Jul 2020 18:39:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FC3CC0890;
	Thu,  2 Jul 2020 18:39:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33968C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 18:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1AEFA87C4E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 18:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmXqcBKsFeqV for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 18:39:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DC5FD87688
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593715145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QinCx818pF5X1BdSH0zzsKcBs7VYqRNInJzgnq1e7DU=;
 b=RYrFp5umrJtG3+zk8EdP9qw46HFkc70wdzM6uD1xV4akmvxyfUmNqDjkEUuESGKsHSgapG
 E/RcnPiTk+3tkLEjQHaylwjh1rTAExDmhpwyKdggmRpbRdQGFB9n5BniPraxkEJAmyE50k
 Mbh8kzkZr9OPrO63VgbPK72w9nVwUMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-HeEylAtSP3qHqeCAcVzSjA-1; Thu, 02 Jul 2020 14:38:58 -0400
X-MC-Unique: HeEylAtSP3qHqeCAcVzSjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE3F92E93;
 Thu,  2 Jul 2020 18:38:56 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BDD379254;
 Thu,  2 Jul 2020 18:38:48 +0000 (UTC)
Date: Thu, 2 Jul 2020 12:38:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/14] vfio/type1: Report iommu nesting info to
 userspace
Message-ID: <20200702123847.384e7460@x1.home>
In-Reply-To: <1592988927-48009-4-git-send-email-yi.l.liu@intel.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-4-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com,
 jun.j.tian@intel.com
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

On Wed, 24 Jun 2020 01:55:16 -0700
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch exports iommu nesting capability info to user space through
> VFIO. User space is expected to check this info for supported uAPIs (e.g.
> PASID alloc/free, bind page table, and cache invalidation) and the vendor
> specific format information for first level/stage page table that will be
> bound to.
> 
> The nesting info is available only after the nesting iommu type is set
> for a container. Current implementation imposes one limitation - one
> nesting container should include at most one group. The philosophy of
> vfio container is having all groups/devices within the container share
> the same IOMMU context. When vSVA is enabled, one IOMMU context could
> include one 2nd-level address space and multiple 1st-level address spaces.
> While the 2nd-leve address space is reasonably sharable by multiple groups
> , blindly sharing 1st-level address spaces across all groups within the
> container might instead break the guest expectation. In the future sub/
> super container concept might be introduced to allow partial address space
> sharing within an IOMMU context. But for now let's go with this restriction
> by requiring singleton container for using nesting iommu features. Below
> link has the related discussion about this decision.
> 
> https://lkml.org/lkml/2020/5/15/1028
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  9 +++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 7accb59..8c143d5 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -72,6 +72,7 @@ struct vfio_iommu {
>  	uint64_t		pgsize_bitmap;
>  	bool			v2;
>  	bool			nesting;
> +	struct iommu_nesting_info *nesting_info;
>  	bool			dirty_page_tracking;
>  	bool			pinned_page_dirty_scope;
>  };

Mind the structure packing and alignment, placing a pointer in the
middle of a section of bools is going to create wasteful holes in the
data structure.

> @@ -130,6 +131,9 @@ struct vfio_regions {
>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>  					(!list_empty(&iommu->domain_list))
>  
> +#define IS_DOMAIN_IN_CONTAINER(iommu)	((iommu->external_domain) || \
> +					 (!list_empty(&iommu->domain_list)))
> +
>  #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
>  
>  /*
> @@ -1959,6 +1963,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		}
>  	}
>  
> +	/* Nesting type container can include only one group */
> +	if (iommu->nesting && IS_DOMAIN_IN_CONTAINER(iommu)) {
> +		mutex_unlock(&iommu->lock);
> +		return -EINVAL;
> +	}
> +
>  	group = kzalloc(sizeof(*group), GFP_KERNEL);
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!group || !domain) {
> @@ -2029,6 +2039,36 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_domain;
>  
> +	/* Nesting cap info is available only after attaching */
> +	if (iommu->nesting) {
> +		struct iommu_nesting_info tmp;
> +		struct iommu_nesting_info *info;
> +
> +		/* First get the size of vendor specific nesting info */
> +		ret = iommu_domain_get_attr(domain->domain,
> +					    DOMAIN_ATTR_NESTING,
> +					    &tmp);
> +		if (ret)
> +			goto out_detach;
> +
> +		info = kzalloc(tmp.size, GFP_KERNEL);
> +		if (!info) {
> +			ret = -ENOMEM;
> +			goto out_detach;
> +		}
> +
> +		/* Now get the nesting info */
> +		info->size = tmp.size;
> +		ret = iommu_domain_get_attr(domain->domain,
> +					    DOMAIN_ATTR_NESTING,
> +					    info);
> +		if (ret) {
> +			kfree(info);
> +			goto out_detach;
> +		}
> +		iommu->nesting_info = info;
> +	}
> +
>  	/* Get aperture info */
>  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
>  
> @@ -2138,6 +2178,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	return 0;
>  
>  out_detach:
> +	kfree(iommu->nesting_info);

This looks prone to a use-after-free.

>  	vfio_iommu_detach_group(domain, group);
>  out_domain:
>  	iommu_domain_free(domain->domain);
> @@ -2338,6 +2379,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  					vfio_iommu_unmap_unpin_all(iommu);
>  				else
>  					vfio_iommu_unmap_unpin_reaccount(iommu);
> +
> +				kfree(iommu->nesting_info);

As does this.  Set to NULL since get_info tests the pointer before
trying to use it.

>  			}
>  			iommu_domain_free(domain->domain);
>  			list_del(&domain->next);
> @@ -2546,6 +2589,30 @@ static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>  }
>  
> +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> +					   struct vfio_info_cap *caps)
> +{
> +	struct vfio_info_cap_header *header;
> +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> +	size_t size;
> +
> +	size = sizeof(*nesting_cap) + iommu->nesting_info->size;
> +
> +	header = vfio_info_cap_add(caps, size,
> +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> +	if (IS_ERR(header))
> +		return PTR_ERR(header);
> +
> +	nesting_cap = container_of(header,
> +				   struct vfio_iommu_type1_info_cap_nesting,
> +				   header);
> +
> +	memcpy(&nesting_cap->info, iommu->nesting_info,
> +	       iommu->nesting_info->size);
> +
> +	return 0;
> +}
> +
>  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>  				     unsigned long arg)
>  {
> @@ -2586,6 +2653,12 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>  	if (ret)
>  		return ret;
>  
> +	if (iommu->nesting_info) {
> +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (caps.size) {
>  		info.flags |= VFIO_IOMMU_INFO_CAPS;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index eca66926..f1f39e1 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> +#include <linux/iommu.h>

Why?  We're not directly referencing any IOMMU UAPI structures here.

>  
>  #define VFIO_API_VERSION	0
>  
> @@ -1039,6 +1040,14 @@ struct vfio_iommu_type1_info_cap_migration {
>  	__u64	max_dirty_bitmap_size;		/* in bytes */
>  };
>  
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> +
> +struct vfio_iommu_type1_info_cap_nesting {
> +	struct	vfio_info_cap_header header;
> +	__u32	flags;

I think there's an alignment issue here for a uapi.  The header field is
8-bytes total and info[] should start at an 8-byte alignment to allow
data[] within info to have 8-byte alignment.  This could lead to the
structure having a compiler dependent size and offsets.  We should add
a 4-byte reserved field here to resolve.

> +	__u8	info[];
> +};

This should have a lot more description around it, a user could not
infer that info[] is including a struct iommu_nesting_info from the
information provided here.  Thanks,

Alex

> +
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
