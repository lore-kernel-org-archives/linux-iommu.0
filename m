Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CDC17442
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:50:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83272222C6
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWsqhCSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83272222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5854CF29;
	Wed, 13 Nov 2019 07:50:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C385FF23
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [205.139.110.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0DA4D102
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1573631440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=Rnpa5U4sj3xZkQya2G1T7YqUyI/VJOSBWTsouefmHoI=;
	b=cWsqhCSmLBrG9shAulHOIza1N77STYNvX/Gb36ESW2spKvgzar2JQGqFQ+Wx3+6ueg77x9
	v1I+lLv8mKKIeBjIRqnSGK/9jTlJazX+g0uvjUGsGY7c+GAVQAMehvwh81Uq0obHWhrAz8
	jlW5CB5BhPQI4hsz/Qb22xDMOQefMaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
	[209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-140-Jyvm9L0NP2iCu0hdi7tQUA-1; Wed, 13 Nov 2019 02:50:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 701A718C6305;
	Wed, 13 Nov 2019 07:50:35 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C12C6019C;
	Wed, 13 Nov 2019 07:50:05 +0000 (UTC)
Subject: Re: [RFC v2 1/3] vfio: VFIO_IOMMU_CACHE_INVALIDATE
To: "Liu, Yi L" <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-2-git-send-email-yi.l.liu@intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5D04AD@SHSMSX104.ccr.corp.intel.com>
	<A2975661238FB949B60364EF0F2C25743A0D7C23@SHSMSX104.ccr.corp.intel.com>
	<20191105154224.3b894a9c@x1.home>
	<A2975661238FB949B60364EF0F2C25743A0EED2E@SHSMSX104.ccr.corp.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e3bc03ba-8537-dd1f-135a-520a695dc2b9@redhat.com>
Date: Wed, 13 Nov 2019 08:50:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EED2E@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Jyvm9L0NP2iCu0hdi7tQUA-1
X-Mimecast-Spam-Score: 0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"Tian, Jun J" <jun.j.tian@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Sun, Yi Y" <yi.y.sun@intel.com>
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

Hi Yi,

On 11/6/19 2:31 AM, Liu, Yi L wrote:
>> From: Alex Williamson [mailto:alex.williamson@redhat.com]
>> Sent: Wednesday, November 6, 2019 6:42 AM
>> To: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [RFC v2 1/3] vfio: VFIO_IOMMU_CACHE_INVALIDATE
>>
>> On Fri, 25 Oct 2019 11:20:40 +0000
>> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
>>
>>> Hi Kevin,
>>>
>>>> From: Tian, Kevin
>>>> Sent: Friday, October 25, 2019 5:14 PM
>>>> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
>>>> Subject: RE: [RFC v2 1/3] vfio: VFIO_IOMMU_CACHE_INVALIDATE
>>>>
>>>>> From: Liu, Yi L
>>>>> Sent: Thursday, October 24, 2019 8:26 PM
>>>>>
>>>>> From: Liu Yi L <yi.l.liu@linux.intel.com>
>>>>>
>>>>> When the guest "owns" the stage 1 translation structures,  the
>>>>> host IOMMU driver has no knowledge of caching structure updates
>>>>> unless the guest invalidation requests are trapped and passed down to the host.
>>>>>
>>>>> This patch adds the VFIO_IOMMU_CACHE_INVALIDATE ioctl with aims at
>>>>> propagating guest stage1 IOMMU cache invalidations to the host.
>>>>>
>>>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>>>> Signed-off-by: Liu Yi L <yi.l.liu@linux.intel.com>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>>> ---
>>>>>  drivers/vfio/vfio_iommu_type1.c | 55
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>  include/uapi/linux/vfio.h       | 13 ++++++++++
>>>>>  2 files changed, 68 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c
>>>>> b/drivers/vfio/vfio_iommu_type1.c index 96fddc1d..cd8d3a5 100644
>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>>> @@ -124,6 +124,34 @@ struct vfio_regions {
>>>>>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>>>>>  					(!list_empty(&iommu->domain_list))
>>>>>
>>>>> +struct domain_capsule {
>>>>> +	struct iommu_domain *domain;
>>>>> +	void *data;
>>>>> +};
>>>>> +
>>>>> +/* iommu->lock must be held */
>>>>> +static int
>>>>> +vfio_iommu_lookup_dev(struct vfio_iommu *iommu,
>>>>> +		      int (*fn)(struct device *dev, void *data),
>>>>> +		      void *data)
>>>>
>>>> 'lookup' usually means find a device and then return. But the real
>>>> purpose here is to loop all the devices within this container and
>>>> then do something. Does it make more sense to be vfio_iommu_for_each_dev?
>>
>> +1
>>
>>> yep, I can replace it.
>>>
>>>>
>>>>> +{
>>>>> +	struct domain_capsule dc = {.data = data};
>>>>> +	struct vfio_domain *d;
>>> [...]
>>>> 2315,6 +2352,24 @@
>>>>> static long vfio_iommu_type1_ioctl(void *iommu_data,
>>>>>
>>>>>  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>>>>  			-EFAULT : 0;
>>>>> +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
>>>>> +		struct vfio_iommu_type1_cache_invalidate ustruct;
>>>>
>>>> it's weird to call a variable as struct.
>>>
>>> Will fix it.
>>>
>>>>> +		int ret;
>>>>> +
>>>>> +		minsz = offsetofend(struct
>>>>> vfio_iommu_type1_cache_invalidate,
>>>>> +				    info);
>>>>> +
>>>>> +		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
>>>>> +			return -EFAULT;
>>>>> +
>>>>> +		if (ustruct.argsz < minsz || ustruct.flags)
>>>>> +			return -EINVAL;
>>>>> +
>>>>> +		mutex_lock(&iommu->lock);
>>>>> +		ret = vfio_iommu_lookup_dev(iommu, vfio_cache_inv_fn,
>>>>> +					    &ustruct);
>>>>> +		mutex_unlock(&iommu->lock);
>>>>> +		return ret;
>>>>>  	}
>>>>>
>>>>>  	return -ENOTTY;
>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>> index 9e843a1..ccf60a2 100644
>>>>> --- a/include/uapi/linux/vfio.h
>>>>> +++ b/include/uapi/linux/vfio.h
>>>>> @@ -794,6 +794,19 @@ struct vfio_iommu_type1_dma_unmap {
>>>>>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>>>>>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>>>>>
>>>>> +/**
>>>>> + * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE +
>>>>> 24,
>>
>> What's going on with these ioctl numbers?  AFAICT[1] we've used up through
>> VFIO_BASE + 21, this jumps to 24, the next patch skips to 27, then the last patch fills
>> in 28 & 29.  Thanks,
> 
> Hi Alex,
> 
> I rebase my patch to Eric's nested stage translation patches. His base also introduced
> IOCTLs. I should have made it better. I'll try to sync with Eric to serialize the IOCTLs.
> 
> [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
> https://lkml.org/lkml/2019/3/17/124

Feel free to choose your IOCTL numbers without taking care of my series.
I will adapt to yours if my work gets unblocked at some point.

Thanks

Eric
> 
> Thanks,
> Yi Liu
> 
>> Alex
>>
>> [1] git grep -h VFIO_BASE | grep "VFIO_BASE +" | grep -e ^#define | \
>>     awk '{print $NF}' | tr -d ')' | sort -u -n
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
