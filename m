Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE0C433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:56:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBCC20771
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRxQnI5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBCC20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C71587652;
	Mon,  6 Jul 2020 12:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUPUft0ZHkQv; Mon,  6 Jul 2020 12:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 55CE68762C;
	Mon,  6 Jul 2020 12:56:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB06C0891;
	Mon,  6 Jul 2020 12:56:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACA39C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A2CFF87E30
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 49-sy0sPpuun for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 12:56:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B67F987FB0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594040158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHW5WFSdiQhetYhMA+xT1zHko+EzRWkh10xNqqBbHAE=;
 b=DRxQnI5McbigtoJgSz1tf4l0JV44KW5/4AVumxjNJqwvllMe8f+7zjiregBL5PKl+fZ2Bd
 IM6/3jjXeM0EFUytrTLor0//SvPOsrqfzrt9ar5IyV5wjcqNWVEWn0BTja9NS1P1pxwqfA
 nlhrTsR9mxi2tpDeI4wGG2uK5J+x5CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-HnA-SJcDPy29nTeB_0QW0w-1; Mon, 06 Jul 2020 08:55:53 -0400
X-MC-Unique: HnA-SJcDPy29nTeB_0QW0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B44804001;
 Mon,  6 Jul 2020 12:55:51 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EDAA1C4;
 Mon,  6 Jul 2020 12:55:42 +0000 (UTC)
Subject: Re: [PATCH v4 01/15] vfio/type1: Refactor vfio_iommu_type1_ioctl()
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-2-git-send-email-yi.l.liu@intel.com>
 <0622db04-8254-8068-e00a-4681ec8686a8@redhat.com>
 <DM5PR11MB14353D1D9476BE68C78B09FCC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9bdab902-4ef5-2d38-cc4c-8cdf72eaed19@redhat.com>
Date: Mon, 6 Jul 2020 14:55:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB14353D1D9476BE68C78B09FCC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On 7/6/20 2:27 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Monday, July 6, 2020 5:34 PM
>>
>> Hi Yi,
>>
>> On 7/4/20 1:26 PM, Liu Yi L wrote:
>>> This patch refactors the vfio_iommu_type1_ioctl() to use switch
>>> instead of if-else, and each cmd got a helper function.
>> command
> 
> I see. :-)
> 
>>>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>> ---
>>>  drivers/vfio/vfio_iommu_type1.c | 392
>>> ++++++++++++++++++++++------------------
>>>  1 file changed, 213 insertions(+), 179 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c
>>> b/drivers/vfio/vfio_iommu_type1.c index 5e556ac..7accb59 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -2453,6 +2453,23 @@ static int vfio_domains_have_iommu_cache(struct
>> vfio_iommu *iommu)
>>>  	return ret;
>>>  }
>>>
>>> +static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
>>> +					    unsigned long arg)
>>> +{
>>> +	switch (arg) {
>>> +	case VFIO_TYPE1_IOMMU:
>>> +	case VFIO_TYPE1v2_IOMMU:
>>> +	case VFIO_TYPE1_NESTING_IOMMU:
>>> +		return 1;
>>> +	case VFIO_DMA_CC_IOMMU:
>>> +		if (!iommu)
>>> +			return 0;
>>> +		return vfio_domains_have_iommu_cache(iommu);
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>>  static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
>>>  		 struct vfio_iommu_type1_info_cap_iova_range *cap_iovas,
>>>  		 size_t size)
>>> @@ -2529,238 +2546,255 @@ static int vfio_iommu_migration_build_caps(struct
>> vfio_iommu *iommu,
>>>  	return vfio_info_add_capability(caps, &cap_mig.header,
>>> sizeof(cap_mig));  }
>>>
>>> -static long vfio_iommu_type1_ioctl(void *iommu_data,
>>> -				   unsigned int cmd, unsigned long arg)
>>> +static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
>>> +				     unsigned long arg)
>>>  {
>>> -	struct vfio_iommu *iommu = iommu_data;
>>> +	struct vfio_iommu_type1_info info;
>>>  	unsigned long minsz;
>>> +	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
>>> +	unsigned long capsz;
>>> +	int ret;
>>>
>>> -	if (cmd == VFIO_CHECK_EXTENSION) {
>>> -		switch (arg) {
>>> -		case VFIO_TYPE1_IOMMU:
>>> -		case VFIO_TYPE1v2_IOMMU:
>>> -		case VFIO_TYPE1_NESTING_IOMMU:
>>> -			return 1;
>>> -		case VFIO_DMA_CC_IOMMU:
>>> -			if (!iommu)
>>> -				return 0;
>>> -			return vfio_domains_have_iommu_cache(iommu);
>>> -		default:
>>> -			return 0;
>>> -		}
>>> -	} else if (cmd == VFIO_IOMMU_GET_INFO) {
>>> -		struct vfio_iommu_type1_info info;
>>> -		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
>>> -		unsigned long capsz;
>>> -		int ret;
>>> -
>>> -		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
>>> +	minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
>>>
>>> -		/* For backward compatibility, cannot require this */
>>> -		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
>>> +	/* For backward compatibility, cannot require this */
>>> +	capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
>>>
>>> -		if (copy_from_user(&info, (void __user *)arg, minsz))
>>> -			return -EFAULT;
>>> +	if (copy_from_user(&info, (void __user *)arg, minsz))
>>> +		return -EFAULT;
>>>
>>> -		if (info.argsz < minsz)
>>> -			return -EINVAL;
>>> +	if (info.argsz < minsz)
>>> +		return -EINVAL;
>>>
>>> -		if (info.argsz >= capsz) {
>>> -			minsz = capsz;
>>> -			info.cap_offset = 0; /* output, no-recopy necessary */
>>> -		}
>>> +	if (info.argsz >= capsz) {
>>> +		minsz = capsz;
>>> +		info.cap_offset = 0; /* output, no-recopy necessary */
>>> +	}
>>>
>>> -		mutex_lock(&iommu->lock);
>>> -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
>>> +	mutex_lock(&iommu->lock);
>>> +	info.flags = VFIO_IOMMU_INFO_PGSIZES;
>>>
>>> -		info.iova_pgsizes = iommu->pgsize_bitmap;
>>> +	info.iova_pgsizes = iommu->pgsize_bitmap;
>>>
>>> -		ret = vfio_iommu_migration_build_caps(iommu, &caps);
>>> +	ret = vfio_iommu_migration_build_caps(iommu, &caps);
>>>
>>> -		if (!ret)
>>> -			ret = vfio_iommu_iova_build_caps(iommu, &caps);
>>> +	if (!ret)
>>> +		ret = vfio_iommu_iova_build_caps(iommu, &caps);
>>>
>>> -		mutex_unlock(&iommu->lock);
>>> +	mutex_unlock(&iommu->lock);
>>>
>>> -		if (ret)
>>> -			return ret;
>>> +	if (ret)
>>> +		return ret;
>>>
>>> -		if (caps.size) {
>>> -			info.flags |= VFIO_IOMMU_INFO_CAPS;
>>> +	if (caps.size) {
>>> +		info.flags |= VFIO_IOMMU_INFO_CAPS;
>>>
>>> -			if (info.argsz < sizeof(info) + caps.size) {
>>> -				info.argsz = sizeof(info) + caps.size;
>>> -			} else {
>>> -				vfio_info_cap_shift(&caps, sizeof(info));
>>> -				if (copy_to_user((void __user *)arg +
>>> -						sizeof(info), caps.buf,
>>> -						caps.size)) {
>>> -					kfree(caps.buf);
>>> -					return -EFAULT;
>>> -				}
>>> -				info.cap_offset = sizeof(info);
>>> +		if (info.argsz < sizeof(info) + caps.size) {
>>> +			info.argsz = sizeof(info) + caps.size;
>>> +		} else {
>>> +			vfio_info_cap_shift(&caps, sizeof(info));
>>> +			if (copy_to_user((void __user *)arg +
>>> +					sizeof(info), caps.buf,
>>> +					caps.size)) {
>>> +				kfree(caps.buf);
>>> +				return -EFAULT;
>>>  			}
>>> -
>>> -			kfree(caps.buf);
>>> +			info.cap_offset = sizeof(info);
>>>  		}
>>>
>>> -		return copy_to_user((void __user *)arg, &info, minsz) ?
>>> -			-EFAULT : 0;
>>> +		kfree(caps.buf);
>>> +	}
>>>
>>> -	} else if (cmd == VFIO_IOMMU_MAP_DMA) {
>>> -		struct vfio_iommu_type1_dma_map map;
>>> -		uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
>>> -				VFIO_DMA_MAP_FLAG_WRITE;
>>> +	return copy_to_user((void __user *)arg, &info, minsz) ?
>>> +			-EFAULT : 0;
>>> +}
>>>
>>> -		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
>>> +static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
>>> +				    unsigned long arg)
>>> +{
>>> +	struct vfio_iommu_type1_dma_map map;
>>> +	unsigned long minsz;
>>> +	uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
>>> +			VFIO_DMA_MAP_FLAG_WRITE;
>> nit: may fit into a single line? other examples below.
> 
> yes, I can do it.
> 
>>>
>>> -		if (copy_from_user(&map, (void __user *)arg, minsz))
>>> -			return -EFAULT;
>>> +	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
>>>
>>> -		if (map.argsz < minsz || map.flags & ~mask)
>>> -			return -EINVAL;
>>> +	if (copy_from_user(&map, (void __user *)arg, minsz))
>>> +		return -EFAULT;
>>>
>>> -		return vfio_dma_do_map(iommu, &map);
>>> +	if (map.argsz < minsz || map.flags & ~mask)
>>> +		return -EINVAL;
>>>
>>> -	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
>>> -		struct vfio_iommu_type1_dma_unmap unmap;
>>> -		struct vfio_bitmap bitmap = { 0 };
>>> -		int ret;
>>> +	return vfio_dma_do_map(iommu, &map); }
>>>
>>> -		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>>> +static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
>>> +				      unsigned long arg)
>>> +{
>>> +	struct vfio_iommu_type1_dma_unmap unmap;
>>> +	struct vfio_bitmap bitmap = { 0 };
>>> +	unsigned long minsz;
>>> +	long ret;
>> int?
> 
> it is "long" in original code. do you want me to change it? I can do it
> if it's preferred.

I am checking your branch and I think
"331e33d2960c  vfio iommu: Update UNMAP_DMA ioctl to get dirty bitmap
before unmap"

turned it into an int

Thanks

Eric

> 
>>>
>>> -		if (copy_from_user(&unmap, (void __user *)arg, minsz))
>>> -			return -EFAULT;
>>> +	minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
>>>
>>> -		if (unmap.argsz < minsz ||
>>> -		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
>>> -			return -EINVAL;
>>> +	if (copy_from_user(&unmap, (void __user *)arg, minsz))
>>> +		return -EFAULT;
>>>
>>> -		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
>>> -			unsigned long pgshift;
>>> +	if (unmap.argsz < minsz ||
>>> +	    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
>>> +		return -EINVAL;
>>>
>>> -			if (unmap.argsz < (minsz + sizeof(bitmap)))
>>> -				return -EINVAL;
>>> +	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
>>> +		unsigned long pgshift;
>>>
>>> -			if (copy_from_user(&bitmap,
>>> -					   (void __user *)(arg + minsz),
>>> -					   sizeof(bitmap)))
>>> -				return -EFAULT;
>>> +		if (unmap.argsz < (minsz + sizeof(bitmap)))
>>> +			return -EINVAL;
>>>
>>> -			if (!access_ok((void __user *)bitmap.data, bitmap.size))
>>> -				return -EINVAL;
>>> +		if (copy_from_user(&bitmap,
>>> +				   (void __user *)(arg + minsz),
>>> +				   sizeof(bitmap)))
>>> +			return -EFAULT;
>>>
>>> -			pgshift = __ffs(bitmap.pgsize);
>>> -			ret = verify_bitmap_size(unmap.size >> pgshift,
>>> -						 bitmap.size);
>>> -			if (ret)
>>> -				return ret;
>>> -		}
>>> +		if (!access_ok((void __user *)bitmap.data, bitmap.size))
>>> +			return -EINVAL;
>>>
>>> -		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
>>> +		pgshift = __ffs(bitmap.pgsize);
>>> +		ret = verify_bitmap_size(unmap.size >> pgshift,
>>> +					 bitmap.size);
>>>  		if (ret)
>>>  			return ret;
>>> +	}
>>> +
>>> +	ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
>>> +	if (ret)
>>> +		return ret;
>>>
>>> -		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>> +	return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>>  			-EFAULT : 0;
>>> -	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
>>> -		struct vfio_iommu_type1_dirty_bitmap dirty;
>>> -		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
>>> -				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
>>> -				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
>>> -		int ret = 0;
>>> +}
>>>
>>> -		if (!iommu->v2)
>>> -			return -EACCES;
>>> +static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
>>> +					unsigned long arg)
>>> +{
>>> +	struct vfio_iommu_type1_dirty_bitmap dirty;
>>> +	uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
>>> +			VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
>>> +			VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
>>> +	unsigned long minsz;
>>> +	int ret = 0;
>>>
>>> -		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
>>> -				    flags);
>>> +	if (!iommu->v2)
>>> +		return -EACCES;
>>>
>>> -		if (copy_from_user(&dirty, (void __user *)arg, minsz))
>>> -			return -EFAULT;
>>> +	minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
>>> +			    flags);
>> single line?
> 
> got it.
> 
>>>
>>> -		if (dirty.argsz < minsz || dirty.flags & ~mask)
>>> -			return -EINVAL;
>>> +	if (copy_from_user(&dirty, (void __user *)arg, minsz))
>>> +		return -EFAULT;
>>> +
>>> +	if (dirty.argsz < minsz || dirty.flags & ~mask)
>>> +		return -EINVAL;
>>> +
>>> +	/* only one flag should be set at a time */
>>> +	if (__ffs(dirty.flags) != __fls(dirty.flags))
>>> +		return -EINVAL;
>>> +
>>> +	if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
>>> +		size_t pgsize;
>>>
>>> -		/* only one flag should be set at a time */
>>> -		if (__ffs(dirty.flags) != __fls(dirty.flags))
>>> +		mutex_lock(&iommu->lock);
>>> +		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
>>> +		if (!iommu->dirty_page_tracking) {
>>> +			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
>>> +			if (!ret)
>>> +				iommu->dirty_page_tracking = true;
>>> +		}
>>> +		mutex_unlock(&iommu->lock);
>>> +		return ret;
>>> +	} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
>>> +		mutex_lock(&iommu->lock);
>>> +		if (iommu->dirty_page_tracking) {
>>> +			iommu->dirty_page_tracking = false;
>>> +			vfio_dma_bitmap_free_all(iommu);
>>> +		}
>>> +		mutex_unlock(&iommu->lock);
>>> +		return 0;
>>> +	} else if (dirty.flags &
>>> +			 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
>> single line?
> 
> yep.
> 
>>> +		struct vfio_iommu_type1_dirty_bitmap_get range;
>>> +		unsigned long pgshift;
>>> +		size_t data_size = dirty.argsz - minsz;
>>> +		size_t iommu_pgsize;
>>> +
>>> +		if (!data_size || data_size < sizeof(range))
>>>  			return -EINVAL;
>>>
>>> -		if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
>>> -			size_t pgsize;
>>> +		if (copy_from_user(&range, (void __user *)(arg + minsz),
>>> +				   sizeof(range)))
>>> +			return -EFAULT;
>>>
>>> -			mutex_lock(&iommu->lock);
>>> -			pgsize = 1 << __ffs(iommu->pgsize_bitmap);
>>> -			if (!iommu->dirty_page_tracking) {
>>> -				ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
>>> -				if (!ret)
>>> -					iommu->dirty_page_tracking = true;
>>> -			}
>>> -			mutex_unlock(&iommu->lock);
>>> +		if (range.iova + range.size < range.iova)
>>> +			return -EINVAL;
>>> +		if (!access_ok((void __user *)range.bitmap.data,
>>> +			       range.bitmap.size))
>>> +			return -EINVAL;
>>> +
>>> +		pgshift = __ffs(range.bitmap.pgsize);
>>> +		ret = verify_bitmap_size(range.size >> pgshift,
>>> +					 range.bitmap.size);
>>> +		if (ret)
>>>  			return ret;
>>> -		} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
>>> -			mutex_lock(&iommu->lock);
>>> -			if (iommu->dirty_page_tracking) {
>>> -				iommu->dirty_page_tracking = false;
>>> -				vfio_dma_bitmap_free_all(iommu);
>>> -			}
>>> -			mutex_unlock(&iommu->lock);
>>> -			return 0;
>>> -		} else if (dirty.flags &
>>> -				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP)
>> {
>> idem
> 
> well received. :-)
> 
>>> -			struct vfio_iommu_type1_dirty_bitmap_get range;
>>> -			unsigned long pgshift;
>>> -			size_t data_size = dirty.argsz - minsz;
>>> -			size_t iommu_pgsize;
>>> -
>>> -			if (!data_size || data_size < sizeof(range))
>>> -				return -EINVAL;
>>> -
>>> -			if (copy_from_user(&range, (void __user *)(arg + minsz),
>>> -					   sizeof(range)))
>>> -				return -EFAULT;
>>>
>>> -			if (range.iova + range.size < range.iova)
>>> -				return -EINVAL;
>>> -			if (!access_ok((void __user *)range.bitmap.data,
>>> -				       range.bitmap.size))
>>> -				return -EINVAL;
>>> +		mutex_lock(&iommu->lock);
>>>
>>> -			pgshift = __ffs(range.bitmap.pgsize);
>>> -			ret = verify_bitmap_size(range.size >> pgshift,
>>> -						 range.bitmap.size);
>>> -			if (ret)
>>> -				return ret;
>>> +		iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
>>>
>>> -			mutex_lock(&iommu->lock);
>>> +		/* allow only smallest supported pgsize */
>>> +		if (range.bitmap.pgsize != iommu_pgsize) {
>>> +			ret = -EINVAL;
>>> +			goto out_unlock;
>>> +		}
>>> +		if (range.iova & (iommu_pgsize - 1)) {
>>> +			ret = -EINVAL;
>>> +			goto out_unlock;
>>> +		}
>>> +		if (!range.size || range.size & (iommu_pgsize - 1)) {
>>> +			ret = -EINVAL;
>>> +			goto out_unlock;
>>> +		}
>>>
>>> -			iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
>>> +		if (iommu->dirty_page_tracking)
>>> +			ret = vfio_iova_dirty_bitmap(range.bitmap.data,
>>> +					iommu, range.iova, range.size,
>>> +					range.bitmap.pgsize);
>>> +		else
>>> +			ret = -EINVAL;
>>> +out_unlock:
>>> +		mutex_unlock(&iommu->lock);
>>>
>>> -			/* allow only smallest supported pgsize */
>>> -			if (range.bitmap.pgsize != iommu_pgsize) {
>>> -				ret = -EINVAL;
>>> -				goto out_unlock;
>>> -			}
>>> -			if (range.iova & (iommu_pgsize - 1)) {
>>> -				ret = -EINVAL;
>>> -				goto out_unlock;
>>> -			}
>>> -			if (!range.size || range.size & (iommu_pgsize - 1)) {
>>> -				ret = -EINVAL;
>>> -				goto out_unlock;
>>> -			}
>>> +		return ret;
>>> +	}
>>>
>>> -			if (iommu->dirty_page_tracking)
>>> -				ret = vfio_iova_dirty_bitmap(range.bitmap.data,
>>> -						iommu, range.iova, range.size,
>>> -						range.bitmap.pgsize);
>>> -			else
>>> -				ret = -EINVAL;
>>> -out_unlock:
>>> -			mutex_unlock(&iommu->lock);
>>> +	return -EINVAL;
>>> +}
>>>
>>> -			return ret;
>>> -		}
>>> +static long vfio_iommu_type1_ioctl(void *iommu_data,
>>> +				   unsigned int cmd, unsigned long arg) {
>>> +	struct vfio_iommu *iommu = iommu_data;
>>> +
>>> +	switch (cmd) {
>>> +	case VFIO_CHECK_EXTENSION:
>>> +		return vfio_iommu_type1_check_extension(iommu, arg);
>>> +	case VFIO_IOMMU_GET_INFO:
>>> +		return vfio_iommu_type1_get_info(iommu, arg);
>>> +	case VFIO_IOMMU_MAP_DMA:
>>> +		return vfio_iommu_type1_map_dma(iommu, arg);
>>> +	case VFIO_IOMMU_UNMAP_DMA:
>>> +		return vfio_iommu_type1_unmap_dma(iommu, arg);
>>> +	case VFIO_IOMMU_DIRTY_PAGES:
>>> +		return vfio_iommu_type1_dirty_pages(iommu, arg);
>> default:
>> 	return -ENOTTY; ?
> 
> got it.
> 
>>>  	}
>>>
>>>  	return -ENOTTY;
>>>
>>
>> Besides
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> thanks.
> 
> Regards,
> Yi Liu
> 
>> Thanks
>>
>> Eric
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
