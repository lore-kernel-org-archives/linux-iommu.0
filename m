Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF36C433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:45:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4571206F5
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS83TbHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4571206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82F8C88CCD;
	Mon,  6 Jul 2020 13:45:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id viQMIyKMVzlu; Mon,  6 Jul 2020 13:45:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7834188CB4;
	Mon,  6 Jul 2020 13:45:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B1BDC0893;
	Mon,  6 Jul 2020 13:45:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE12C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 398B488A10
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:45:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F3ZVUp7ii++z for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:45:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 93CC288A28
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594043146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjKEXQ6i5alDGKSUnpnCOM5ougmsFiB6czLmwa0OSSE=;
 b=VS83TbHoXWcnl97VPNFuLDfx7ii10rrWZQdciZsFrD6fyrb7SDEbTB9LFPjL2D0yI/D0zl
 T5x0jyY1ZtQCILxrZqHRqWWE/xpgN9lw/mh9aHMPYhs5hpICYMzfSYiH0jV/ZIXGHbXGve
 ieu3WPCjpa9jEWnr+hPzMqSQ9Q8hq2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-4heq6mkvOOGL3ZOSEYc41w-1; Mon, 06 Jul 2020 09:45:41 -0400
X-MC-Unique: 4heq6mkvOOGL3ZOSEYc41w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F55E107ACCA;
 Mon,  6 Jul 2020 13:45:39 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 986AF5D9CC;
 Mon,  6 Jul 2020 13:45:30 +0000 (UTC)
Subject: Re: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to
 userspace
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
 <d434cbcc-d3b1-d11d-0304-df2d2c93efa0@redhat.com>
 <DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <94b4e5d3-8d24-9a55-6bee-ed86f3846996@redhat.com>
Date: Mon, 6 Jul 2020 15:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB1435290B6CD561EC61027892C3690@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On 7/6/20 3:10 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Monday, July 6, 2020 6:37 PM
>>
>> Yi,
>>
>> On 7/4/20 1:26 PM, Liu Yi L wrote:
>>> This patch exports iommu nesting capability info to user space through
>>> VFIO. User space is expected to check this info for supported uAPIs (e.g.
>>> PASID alloc/free, bind page table, and cache invalidation) and the vendor
>>> specific format information for first level/stage page table that will be
>>> bound to.
>>>
>>> The nesting info is available only after the nesting iommu type is set
>>> for a container. Current implementation imposes one limitation - one
>>> nesting container should include at most one group. The philosophy of
>>> vfio container is having all groups/devices within the container share
>>> the same IOMMU context. When vSVA is enabled, one IOMMU context could
>>> include one 2nd-level address space and multiple 1st-level address spaces.
>>> While the 2nd-leve address space is reasonably sharable by multiple groups
>> level
> 
> oh, yes.
> 
>>> , blindly sharing 1st-level address spaces across all groups within the
>>> container might instead break the guest expectation. In the future sub/
>>> super container concept might be introduced to allow partial address space
>>> sharing within an IOMMU context. But for now let's go with this restriction
>>> by requiring singleton container for using nesting iommu features. Below
>>> link has the related discussion about this decision.
>>>
>>> https://lkml.org/lkml/2020/5/15/1028
>>>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>> ---
>>> v3 -> v4:
>>> *) address comments against v3.
>>>
>>> v1 -> v2:
>>> *) added in v2
>>> ---
>>>
>>>  drivers/vfio/vfio_iommu_type1.c | 105
>> +++++++++++++++++++++++++++++++++++-----
>>>  include/uapi/linux/vfio.h       |  16 ++++++
>>>  2 files changed, 109 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>> index 7accb59..80623b8 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -62,18 +62,20 @@ MODULE_PARM_DESC(dma_entry_limit,
>>>  		 "Maximum number of user DMA mappings per container (65535).");
>>>
>>>  struct vfio_iommu {
>>> -	struct list_head	domain_list;
>>> -	struct list_head	iova_list;
>>> -	struct vfio_domain	*external_domain; /* domain for external user */
>>> -	struct mutex		lock;
>>> -	struct rb_root		dma_list;
>>> -	struct blocking_notifier_head notifier;
>>> -	unsigned int		dma_avail;
>>> -	uint64_t		pgsize_bitmap;
>>> -	bool			v2;
>>> -	bool			nesting;
>>> -	bool			dirty_page_tracking;
>>> -	bool			pinned_page_dirty_scope;
>>> +	struct list_head		domain_list;
>>> +	struct list_head		iova_list;
>>> +	struct vfio_domain		*external_domain; /* domain for
>>> +							     external user */
>> nit: put the comment before the field?
> 
> do you mean below?
> 
> +	/* domain for external user */
> +	struct vfio_domain		*external_domain;
yes that's what I meant
> 
>>> +	struct mutex			lock;
>>> +	struct rb_root			dma_list;
>>> +	struct blocking_notifier_head	notifier;
>>> +	unsigned int			dma_avail;
>>> +	uint64_t			pgsize_bitmap;
>>> +	bool				v2;
>>> +	bool				nesting;
>>> +	bool				dirty_page_tracking;
>>> +	bool				pinned_page_dirty_scope;
>>> +	struct iommu_nesting_info	*nesting_info;
>>>  };
>>>
>>>  struct vfio_domain {
>>> @@ -130,6 +132,9 @@ struct vfio_regions {
>>>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>>>  					(!list_empty(&iommu->domain_list))
>>>
>>> +#define IS_DOMAIN_IN_CONTAINER(iommu)	((iommu->external_domain) || \
>>> +					 (!list_empty(&iommu->domain_list)))
>> rename into something like CONTAINER_HAS_DOMAIN()?
> 
> got it.
> 
>>> +
>>>  #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) /
>> BITS_PER_BYTE)
>>>
>>>  /*
>>> @@ -1929,6 +1934,13 @@ static void vfio_iommu_iova_insert_copy(struct
>> vfio_iommu *iommu,
>>>
>>>  	list_splice_tail(iova_copy, iova);
>>>  }
>>> +
>>> +static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
>>> +{
>>> +	kfree(iommu->nesting_info);
>>> +	iommu->nesting_info = NULL;
>>> +}
>>> +
>>>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>>>  					 struct iommu_group *iommu_group)
>>>  {
>>> @@ -1959,6 +1971,12 @@ static int vfio_iommu_type1_attach_group(void
>> *iommu_data,
>>>  		}
>>>  	}
>>>
>>> +	/* Nesting type container can include only one group */
>>> +	if (iommu->nesting && IS_DOMAIN_IN_CONTAINER(iommu)) {
>>> +		mutex_unlock(&iommu->lock);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>  	group = kzalloc(sizeof(*group), GFP_KERNEL);
>>>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>>>  	if (!group || !domain) {
>>> @@ -2029,6 +2047,36 @@ static int vfio_iommu_type1_attach_group(void
>> *iommu_data,
>>>  	if (ret)
>>>  		goto out_domain;
>>>
>>> +	/* Nesting cap info is available only after attaching */
>>> +	if (iommu->nesting) {
>>> +		struct iommu_nesting_info tmp;
>>> +		struct iommu_nesting_info *info;
>>> +
>>> +		/* First get the size of vendor specific nesting info */
>>> +		ret = iommu_domain_get_attr(domain->domain,
>>> +					    DOMAIN_ATTR_NESTING,
>>> +					    &tmp);
>>> +		if (ret)
>>> +			goto out_detach;
>>> +
>>> +		info = kzalloc(tmp.size, GFP_KERNEL);
>> nit: you may directly use iommu->nesting_info
> 
> got you.
> 
>>> +		if (!info) {
>>> +			ret = -ENOMEM;
>>> +			goto out_detach;
>>> +		}
>>> +
>>> +		/* Now get the nesting info */
>>> +		info->size = tmp.size;
>>> +		ret = iommu_domain_get_attr(domain->domain,
>>> +					    DOMAIN_ATTR_NESTING,
>>> +					    info);
>>> +		if (ret) {
>>> +			kfree(info);
>> ... and set it back to NULL here if it fails
> 
> and maybe no need to free it here as vfio_iommu_release_nesting_info()
> will free the nesting_info.
> 
>>> +			goto out_detach;
>>> +		}
>>> +		iommu->nesting_info = info;
>>> +	}
>>> +
>>>  	/* Get aperture info */
>>>  	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
>> &geo);
>>>
>>> @@ -2138,6 +2186,7 @@ static int vfio_iommu_type1_attach_group(void
>> *iommu_data,
>>>  	return 0;
>>>
>>>  out_detach:
>>> +	vfio_iommu_release_nesting_info(iommu);
>>>  	vfio_iommu_detach_group(domain, group);
>>>  out_domain:
>>>  	iommu_domain_free(domain->domain);
>>> @@ -2338,6 +2387,8 @@ static void vfio_iommu_type1_detach_group(void
>> *iommu_data,
>>>  					vfio_iommu_unmap_unpin_all(iommu);
>>>  				else
>>>
>> 	vfio_iommu_unmap_unpin_reaccount(iommu);
>>> +
>>> +				vfio_iommu_release_nesting_info(iommu);
>>>  			}
>>>  			iommu_domain_free(domain->domain);
>>>  			list_del(&domain->next);
>>> @@ -2546,6 +2597,30 @@ static int vfio_iommu_migration_build_caps(struct
>> vfio_iommu *iommu,
>>>  	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
>>>  }
>>>
>>> +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
>>> +					   struct vfio_info_cap *caps)
>>> +{
>>> +	struct vfio_info_cap_header *header;
>>> +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
>>> +	size_t size;
>>> +
>>> +	size = sizeof(*nesting_cap) + iommu->nesting_info->size;
>>> +
>>> +	header = vfio_info_cap_add(caps, size,
>>> +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
>>> +	if (IS_ERR(header))
>>> +		return PTR_ERR(header);
>>> +
>>> +	nesting_cap = container_of(header,
>>> +				   struct vfio_iommu_type1_info_cap_nesting,
>>> +				   header);
>>> +
>>> +	memcpy(&nesting_cap->info, iommu->nesting_info,
>>> +	       iommu->nesting_info->size);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>>>  				     unsigned long arg)
>>>  {
>>> @@ -2586,6 +2661,12 @@ static int vfio_iommu_type1_get_info(struct
>> vfio_iommu *iommu,
>>>  	if (ret)
>>>  		return ret;
>>>
>>> +	if (iommu->nesting_info) {
>>> +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>>  	if (caps.size) {
>>>  		info.flags |= VFIO_IOMMU_INFO_CAPS;
>>>
>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>> index 9204705..3e3de9c 100644
>>> --- a/include/uapi/linux/vfio.h
>>> +++ b/include/uapi/linux/vfio.h
>>> @@ -1039,6 +1039,22 @@ struct vfio_iommu_type1_info_cap_migration {
>>>  	__u64	max_dirty_bitmap_size;		/* in bytes */
>>>  };
>>>
>>> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
>>
>> You may improve the documentation by taking examples from the above caps.
> 
> yes, it is. I somehow broke the style. how about below?
> 
> 
> 
> /*
>  * The nesting capability allows to report the related capability
>  * and info for nesting iommu type.
>  *
>  * The structures below define version 1 of this capability.
>  *
>  * User space should check this cap for setup nesting iommu type.
before setting up stage 1 information? The wording above sounds a bit
confusing to me as it can be interpreted as before choosing
VFIO_TYPE1_NESTING_IOMMU.

You also need to document it returns the capability only after a group
is attached - which looks strange by the way -.

Thanks

Eric
>  *
>  * @info:	the nesting info provided by IOMMU driver. Today
>  *		it is expected to be a struct iommu_nesting_info
>  *		data.
> #define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
> 
> struct vfio_iommu_type1_info_cap_nesting {
> 	...
> };
> 
>>> +
>>> +/*
>>> + * Reporting nesting info to user space.
>>> + *
>>> + * @info:	the nesting info provided by IOMMU driver. Today
>>> + *		it is expected to be a struct iommu_nesting_info
>>> + *		data.
>> Is it expected to change?
> 
> honestly, I'm not quite sure on it. I did considered to embed
> struct iommu_nesting_info here instead of using info[]. but I
> hesitated as using info[] may leave more flexibility on this
> struct. how about your opinion? perhaps it's fine to embed the
> struct iommu_nesting_info here as long as VFIO is setup nesting
> based on IOMMU UAPI.
> 
>>> + */
>>> +struct vfio_iommu_type1_info_cap_nesting {
>>> +	struct	vfio_info_cap_header header;
>>> +	__u32	flags;
>> You may document flags.
> 
> sure. it's reserved for future.
> 
> Regards,
> Yi Liu
> 
>>> +	__u32	padding;
>>> +	__u8	info[];
>>> +};
>>> +
>>>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>>>
>>>  /**
>>>
>> Thanks
>>
>> Eric
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
