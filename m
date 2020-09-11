Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937F9C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 20:17:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8FE221E3
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 20:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiN1eiq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8FE221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FC7E87648;
	Fri, 11 Sep 2020 20:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GTtVY5boWEY4; Fri, 11 Sep 2020 20:17:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F6B387643;
	Fri, 11 Sep 2020 20:17:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47D4DC0052;
	Fri, 11 Sep 2020 20:17:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43B48C0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 20:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2BB8A87648
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 20:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Ud3Jt1p2wUH for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 20:17:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 19E1C87643
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599855418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0u0859Czq3iKRZqiK+W1seOIVjdXi6eElFH8tq3Uv8=;
 b=aiN1eiq61bx5ZXDSJA6pXnqwqbEPWulqGjGwlElGF8PnQHsujI9ZloG6Y52nvAniFBmeMg
 JR3wKuKW7DGn/nH+X9LaNtHhVr3ZJD7sNn+HNqOldMU0Q4fd86kCxTLkiOXgVRiasJIoc1
 tBn3RkbCo2C6nT0+LeN59HQdKTwtBZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-xs6ZdtksPyaqBMB5r3Oa4w-1; Fri, 11 Sep 2020 16:16:55 -0400
X-MC-Unique: xs6ZdtksPyaqBMB5r3Oa4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20F8810059A4;
 Fri, 11 Sep 2020 20:16:53 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B66660C07;
 Fri, 11 Sep 2020 20:16:42 +0000 (UTC)
Date: Fri, 11 Sep 2020 14:16:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/16] vfio/type1: Report iommu nesting info to
 userspace
Message-ID: <20200911141641.6f77f4d3@w520.home>
In-Reply-To: <1599734733-6431-4-git-send-email-yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-4-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jasowang@redhat.com, stefanha@gmail.com,
 iommu@lists.linux-foundation.org, yi.y.sun@intel.com, hao.wu@intel.com,
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

On Thu, 10 Sep 2020 03:45:20 -0700
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch exports iommu nesting capability info to user space through
> VFIO. Userspace is expected to check this info for supported uAPIs (e.g.
> PASID alloc/free, bind page table, and cache invalidation) and the vendor
> specific format information for first level/stage page table that will be
> bound to.
> 
> The nesting info is available only after container set to be NESTED type.
> Current implementation imposes one limitation - one nesting container
> should include at most one iommu group. The philosophy of vfio container
> is having all groups/devices within the container share the same IOMMU
> context. When vSVA is enabled, one IOMMU context could include one 2nd-
> level address space and multiple 1st-level address spaces. While the
> 2nd-level address space is reasonably sharable by multiple groups, blindly
> sharing 1st-level address spaces across all groups within the container
> might instead break the guest expectation. In the future sub/super container
> concept might be introduced to allow partial address space sharing within
> an IOMMU context. But for now let's go with this restriction by requiring
> singleton container for using nesting iommu features. Below link has the
> related discussion about this decision.
> 
> https://lore.kernel.org/kvm/20200515115924.37e6996d@w520.home/
> 
> This patch also changes the NESTING type container behaviour. Something
> that would have succeeded before will now fail: Before this series, if
> user asked for a VFIO_IOMMU_TYPE1_NESTING, it would have succeeded even
> if the SMMU didn't support stage-2, as the driver would have silently
> fallen back on stage-1 mappings (which work exactly the same as stage-2
> only since there was no nesting supported). After the series, we do check
> for DOMAIN_ATTR_NESTING so if user asks for VFIO_IOMMU_TYPE1_NESTING and
> the SMMU doesn't support stage-2, the ioctl fails. But it should be a good
> fix and completely harmless. Detail can be found in below link as well.
> 
> https://lore.kernel.org/kvm/20200717090900.GC4850@myrica/
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
> v6 -> v7:
> *) using vfio_info_add_capability() for adding nesting cap per suggestion
>    from Eric.
> 
> v5 -> v6:
> *) address comments against v5 from Eric Auger.
> *) don't report nesting cap to userspace if the nesting_info->format is
>    invalid.
> 
> v4 -> v5:
> *) address comments from Eric Auger.
> *) return struct iommu_nesting_info for VFIO_IOMMU_TYPE1_INFO_CAP_NESTING as
>    cap is much "cheap", if needs extension in future, just define another cap.
>    https://lore.kernel.org/kvm/20200708132947.5b7ee954@x1.home/
> 
> v3 -> v4:
> *) address comments against v3.
> 
> v1 -> v2:
> *) added in v2
> ---
>  drivers/vfio/vfio_iommu_type1.c | 92 +++++++++++++++++++++++++++++++++++------
>  include/uapi/linux/vfio.h       | 19 +++++++++
>  2 files changed, 99 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c992973..3c0048b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -62,18 +62,20 @@ MODULE_PARM_DESC(dma_entry_limit,
>  		 "Maximum number of user DMA mappings per container (65535).");
>  
>  struct vfio_iommu {
> -	struct list_head	domain_list;
> -	struct list_head	iova_list;
> -	struct vfio_domain	*external_domain; /* domain for external user */
> -	struct mutex		lock;
> -	struct rb_root		dma_list;
> -	struct blocking_notifier_head notifier;
> -	unsigned int		dma_avail;
> -	uint64_t		pgsize_bitmap;
> -	bool			v2;
> -	bool			nesting;
> -	bool			dirty_page_tracking;
> -	bool			pinned_page_dirty_scope;
> +	struct list_head		domain_list;
> +	struct list_head		iova_list;
> +	/* domain for external user */
> +	struct vfio_domain		*external_domain;
> +	struct mutex			lock;
> +	struct rb_root			dma_list;
> +	struct blocking_notifier_head	notifier;
> +	unsigned int			dma_avail;
> +	uint64_t			pgsize_bitmap;
> +	bool				v2;
> +	bool				nesting;
> +	bool				dirty_page_tracking;
> +	bool				pinned_page_dirty_scope;
> +	struct iommu_nesting_info	*nesting_info;

Nit, not as important as the previous alignment, but might as well move
this up with the uint64_t pgsize_bitmap with the bools at the end of
the structure to avoid adding new gaps.

>  };
>  
>  struct vfio_domain {
> @@ -130,6 +132,9 @@ struct vfio_regions {
>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>  					(!list_empty(&iommu->domain_list))
>  
> +#define CONTAINER_HAS_DOMAIN(iommu)	(((iommu)->external_domain) || \
> +					 (!list_empty(&(iommu)->domain_list)))
> +
>  #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
>  
>  /*
> @@ -1992,6 +1997,13 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>  
>  	list_splice_tail(iova_copy, iova);
>  }
> +
> +static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> +{
> +	kfree(iommu->nesting_info);
> +	iommu->nesting_info = NULL;
> +}
> +
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  					 struct iommu_group *iommu_group)
>  {
> @@ -2022,6 +2034,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		}
>  	}
>  
> +	/* Nesting type container can include only one group */
> +	if (iommu->nesting && CONTAINER_HAS_DOMAIN(iommu)) {
> +		mutex_unlock(&iommu->lock);
> +		return -EINVAL;
> +	}
> +
>  	group = kzalloc(sizeof(*group), GFP_KERNEL);
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!group || !domain) {
> @@ -2092,6 +2110,25 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_domain;
>  
> +	/* Nesting cap info is available only after attaching */
> +	if (iommu->nesting) {
> +		int size = sizeof(struct iommu_nesting_info);
> +
> +		iommu->nesting_info = kzalloc(size, GFP_KERNEL);
> +		if (!iommu->nesting_info) {
> +			ret = -ENOMEM;
> +			goto out_detach;
> +		}
> +
> +		/* Now get the nesting info */
> +		iommu->nesting_info->argsz = size;
> +		ret = iommu_domain_get_attr(domain->domain,
> +					    DOMAIN_ATTR_NESTING,
> +					    iommu->nesting_info);
> +		if (ret)
> +			goto out_detach;
> +	}
> +
>  	/* Get aperture info */
>  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
>  
> @@ -2201,6 +2238,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	return 0;
>  
>  out_detach:
> +	vfio_iommu_release_nesting_info(iommu);
>  	vfio_iommu_detach_group(domain, group);
>  out_domain:
>  	iommu_domain_free(domain->domain);
> @@ -2401,6 +2439,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  					vfio_iommu_unmap_unpin_all(iommu);
>  				else
>  					vfio_iommu_unmap_unpin_reaccount(iommu);
> +
> +				vfio_iommu_release_nesting_info(iommu);
>  			}
>  			iommu_domain_free(domain->domain);
>  			list_del(&domain->next);
> @@ -2609,6 +2649,32 @@ static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>  }
>  
> +static int vfio_iommu_add_nesting_cap(struct vfio_iommu *iommu,
> +				      struct vfio_info_cap *caps)
> +{
> +	struct vfio_iommu_type1_info_cap_nesting nesting_cap;
> +	size_t size;
> +
> +	/* when nesting_info is null, no need to go further */
> +	if (!iommu->nesting_info)
> +		return 0;
> +
> +	/* when @format of nesting_info is 0, fail the call */
> +	if (iommu->nesting_info->format == 0)
> +		return -ENOENT;


Should we fail this in the attach_group?  Seems the user would be in a
bad situation here if they successfully created a nesting container but
can't get info.  Is there backwards compatibility we're trying to
maintain with this?

> +
> +	size = offsetof(struct vfio_iommu_type1_info_cap_nesting, info) +
> +	       iommu->nesting_info->argsz;
> +
> +	nesting_cap.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_NESTING;
> +	nesting_cap.header.version = 1;
> +
> +	memcpy(&nesting_cap.info, iommu->nesting_info,
> +	       iommu->nesting_info->argsz);
> +
> +	return vfio_info_add_capability(caps, &nesting_cap.header, size);
> +}
> +
>  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>  				     unsigned long arg)
>  {
> @@ -2644,6 +2710,8 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>  	if (!ret)
>  		ret = vfio_iommu_iova_build_caps(iommu, &caps);
>  
> +	ret = vfio_iommu_add_nesting_cap(iommu, &caps);

Why don't we follow either the naming scheme or the error handling
scheme of the previous caps?  Seems like this should be:

if (!ret)
	ret = vfio_iommu_nesting_build_caps(...);

Thanks,

Alex


> +
>  	mutex_unlock(&iommu->lock);
>  
>  	if (ret)
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 9204705..ff40f9e 100644
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
> @@ -1039,6 +1040,24 @@ struct vfio_iommu_type1_info_cap_migration {
>  	__u64	max_dirty_bitmap_size;		/* in bytes */
>  };
>  
> +/*
> + * The nesting capability allows to report the related capability
> + * and info for nesting iommu type.
> + *
> + * The structures below define version 1 of this capability.
> + *
> + * Nested capabilities should be checked by the userspace after
> + * setting VFIO_TYPE1_NESTING_IOMMU.
> + *
> + * @info: the nesting info provided by IOMMU driver.
> + */
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> +
> +struct vfio_iommu_type1_info_cap_nesting {
> +	struct	vfio_info_cap_header header;
> +	struct	iommu_nesting_info info;
> +};
> +
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
