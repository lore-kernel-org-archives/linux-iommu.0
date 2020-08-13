Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE56C433DF
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 13:20:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31C620774
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 13:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+v6uTea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31C620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BDA74883F7;
	Thu, 13 Aug 2020 13:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PSGLW1ia2rdn; Thu, 13 Aug 2020 13:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0EF28838B;
	Thu, 13 Aug 2020 13:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADE33C013C;
	Thu, 13 Aug 2020 13:20:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA04EC004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 96FF786C15
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GFMlhd66qDJ0 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 13:20:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4CE4585485
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597324833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/Iv8A+lVq7aUDHm0xgMBb5TxaSWfwGijdZCx7onRds=;
 b=c+v6uTea759kkn/GYW3SKt7qnBjMdrpuiyOzAbEbRj3ewy6yLMjuKoyhJMaRLiXJ9Lj6qB
 HzMGbj9JwAYSR+ECXwWUzi3dqOCbgBTfAX6i7gEY8dZaoqbUhKSPneH+mjCXtMGiiU3V9J
 0PoUY1V0pdxNT4xECkpTwiMTZTekEmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-ik2_KaBQP_GBeCGCUI6BYA-1; Thu, 13 Aug 2020 09:20:29 -0400
X-MC-Unique: ik2_KaBQP_GBeCGCUI6BYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383CE890E6B;
 Thu, 13 Aug 2020 13:20:26 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9616C5DC17;
 Thu, 13 Aug 2020 13:19:57 +0000 (UTC)
Subject: Re: [PATCH v6 04/15] vfio/type1: Report iommu nesting info to
 userspace
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-5-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2243bef1-52b7-9142-54be-8763046aa9f8@redhat.com>
Date: Thu, 13 Aug 2020 15:19:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1595917664-33276-5-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

Hi Yi,
On 7/28/20 8:27 AM, Liu Yi L wrote:
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
>  drivers/vfio/vfio_iommu_type1.c | 106 +++++++++++++++++++++++++++++++++++-----
>  include/uapi/linux/vfio.h       |  19 +++++++
>  2 files changed, 113 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 3bd70ff..18ff0c3 100644
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
> @@ -1929,6 +1934,13 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
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
> @@ -1959,6 +1971,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
> @@ -2029,6 +2047,32 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_domain;
>  
> +	/* Nesting cap info is available only after attaching */
> +	if (iommu->nesting) {
> +		struct iommu_nesting_info tmp = { .argsz = 0, };
> +
> +		/* First get the size of vendor specific nesting info */
> +		ret = iommu_domain_get_attr(domain->domain,
> +					    DOMAIN_ATTR_NESTING,
> +					    &tmp);
> +		if (ret)
> +			goto out_detach;
> +
> +		iommu->nesting_info = kzalloc(tmp.argsz, GFP_KERNEL);
> +		if (!iommu->nesting_info) {
> +			ret = -ENOMEM;
> +			goto out_detach;
> +		}
> +
> +		/* Now get the nesting info */
> +		iommu->nesting_info->argsz = tmp.argsz;
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
> @@ -2138,6 +2182,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	return 0;
>  
>  out_detach:
> +	vfio_iommu_release_nesting_info(iommu);
>  	vfio_iommu_detach_group(domain, group);
>  out_domain:
>  	iommu_domain_free(domain->domain);
> @@ -2338,6 +2383,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  					vfio_iommu_unmap_unpin_all(iommu);
>  				else
>  					vfio_iommu_unmap_unpin_reaccount(iommu);
> +
> +				vfio_iommu_release_nesting_info(iommu);
>  			}
>  			iommu_domain_free(domain->domain);
>  			list_del(&domain->next);
> @@ -2546,6 +2593,39 @@ static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
>  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>  }
>  
> +static int vfio_iommu_add_nesting_cap(struct vfio_iommu *iommu,
> +				      struct vfio_info_cap *caps)
> +{
> +	struct vfio_info_cap_header *header;
> +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> +	size_t size;
> +
> +	/* when nesting_info is null, no need go further */
no need to go
> +	if (!iommu->nesting_info)
> +		return 0;
> +
> +	/* when @format of nesting_info is 0, fail the call */
> +	if (iommu->nesting_info->format == 0)
> +		return -ENOENT;
> +
> +	size = offsetof(struct vfio_iommu_type1_info_cap_nesting, info) +
> +	       iommu->nesting_info->argsz;
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
> +	       iommu->nesting_info->argsz);
can't you use vfio_info_add_capability() directly?
> +
> +	return 0;
> +}
> +
>  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>  				     unsigned long arg)
>  {
> @@ -2581,6 +2661,8 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>  	if (!ret)
>  		ret = vfio_iommu_iova_build_caps(iommu, &caps);
>  
> +	ret = vfio_iommu_add_nesting_cap(iommu, &caps);
> +
>  	mutex_unlock(&iommu->lock);
>  
>  	if (ret)
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 9204705..0cf3d6d 100644
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
> + * Userspace selected VFIO_TYPE1_NESTING_IOMMU type should check
> + * this capability to get supported features.
nested capabilities should be checked by the userspace after setting
VFIO_TYPE1_NESTING_IOMMU?
> + *
> + * @info: the nesting info provided by IOMMU driver.
> + */
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> +
> +struct vfio_iommu_type1_info_cap_nesting {
> +	struct	vfio_info_cap_header header;
> +	struct iommu_nesting_info info;
> +};
> +
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
