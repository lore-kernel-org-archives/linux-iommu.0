Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC0C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:22:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAE52070C
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TulIa/yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAE52070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A9A586BB5;
	Mon,  6 Jul 2020 13:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p59tQb2Qad1q; Mon,  6 Jul 2020 13:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B07A86BAE;
	Mon,  6 Jul 2020 13:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47426C0893;
	Mon,  6 Jul 2020 13:22:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD3DCC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BC23586BA7
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I5-Evlzx7qK5 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:22:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D981986BA1
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594041735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eD+BPuGLixLMbCyAZUyX9b044yZCPOLzS0+xnOtqf8A=;
 b=TulIa/yM7tmYP/oDwRTDFjCfHDl6smqIOU5kRsmV6aBQ6lYjnvPv98w3Zw01rDyoG+fe7m
 yz7suW0qLuZ2PoYP4WG/r3RrLHITCkv1WgVXs6WfH0nOxsk9MA+5OMGvMp2QkqAXBk1H1i
 FJzrZfH9pvKpQgERP9hJSmz/0IryYUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-22Va9dKvOc29PdnKlvj5jw-1; Mon, 06 Jul 2020 09:22:12 -0400
X-MC-Unique: 22Va9dKvOc29PdnKlvj5jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB336BFC2;
 Mon,  6 Jul 2020 13:22:09 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11D5F7B40C;
 Mon,  6 Jul 2020 13:21:59 +0000 (UTC)
Subject: Re: [PATCH v4 03/15] iommu/smmu: Report empty domain nesting info
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-4-git-send-email-yi.l.liu@intel.com>
 <d791bad4-57b9-8e97-acbb-76b13e4154f8@redhat.com>
 <DM5PR11MB143543A04F5AF15EC7CBEC8BC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4d1a11b4-dcf3-b3a1-8802-3dd3ae97b3a4@redhat.com>
Date: Mon, 6 Jul 2020 15:21:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB143543A04F5AF15EC7CBEC8BC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "Wu, Hao" <hao.wu@intel.com>
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

On 7/6/20 2:46 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>>
>> Hi Yi,
>>
>> Please add a commit message: instead of returning a boolean for
>> DOMAIN_ATTR_NESTING, arm_smmu_domain_get_attr() returns a
>> iommu_nesting_info handle.
> 
> will do. thanks for the suggestion.
> 
>>
>> On 7/4/20 1:26 PM, Liu Yi L wrote:
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
>>>  drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++--
>>>  2 files changed, 54 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index f578677..0c45d4d 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -3019,6 +3019,32 @@ static struct iommu_group
>> *arm_smmu_device_group(struct device *dev)
>>>  	return group;
>>>  }
>>>
>>> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
>> *smmu_domain,
>>> +					void *data)
>>> +{
>>> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
>>> +	u32 size;
>>> +
>>> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>>> +		return -ENODEV;
>>> +
>>> +	size = sizeof(struct iommu_nesting_info);
>>> +
>>> +	/*
>>> +	 * if provided buffer size is not equal to the size, should
>>> +	 * return 0 and also the expected buffer size to caller.
>>> +	 */
>>> +	if (info->size != size) {
>> < size?
> 
> < size may work as well. but I'd like the caller provide exact buffer size. not sure
> if it is demand in kernel. do you have any suggestion?

I just suggested that by analogy with the VFIO argsz


> 
>>> +		info->size = size;
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* report an empty iommu_nesting_info for now */
>>> +	memset(info, 0x0, size);
>>> +	info->size = size;
>> For info, the current SMMU NESTED mode is not enabling any nesting. It just forces
>> the usage of the 2st stage instead of stage1 for single stage translation.
> 
> yep. The intention is as below:
> 
> " However it requires changing the get_attr(NESTING) implementations in both
> SMMU drivers as a precursor of this series, to avoid breaking
> VFIO_TYPE1_NESTING_IOMMU on Arm. Since we haven't yet defined the
> nesting_info structs for SMMUv2 and v3, I suppose we could return an empty
> struct iommu_nesting_info for now?"
> https://lore.kernel.org/linux-iommu/20200617143909.GA886590@myrica/
> 
> do you think any other needs to be done for now?

I understand this is a prerequisite. It was more as an information.
Returning a void struct is a bit weird but at the moment I don't have
anything better.

Thanks

Eric
> 
> Regards,
> Yi Liu
> 
>> Thanks
>>
>> Eric
>>> +	return 0;
>>> +}
>>> +
>>>  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>>  				    enum iommu_attr attr, void *data)  { @@ -
>> 3028,8 +3054,7 @@
>>> static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>>  	case IOMMU_DOMAIN_UNMANAGED:
>>>  		switch (attr) {
>>>  		case DOMAIN_ATTR_NESTING:
>>> -			*(int *)data = (smmu_domain->stage ==
>> ARM_SMMU_DOMAIN_NESTED);
>>> -			return 0;
>>> +			return arm_smmu_domain_nesting_info(smmu_domain,
>> data);
>>>  		default:
>>>  			return -ENODEV;
>>>  		}
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
>>> 243bc4c..908607d 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1506,6 +1506,32 @@ static struct iommu_group
>> *arm_smmu_device_group(struct device *dev)
>>>  	return group;
>>>  }
>>>
>>> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
>> *smmu_domain,
>>> +					void *data)
>>> +{
>>> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
>>> +	u32 size;
>>> +
>>> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
>>> +		return -ENODEV;
>>> +
>>> +	size = sizeof(struct iommu_nesting_info);
>>> +
>>> +	/*
>>> +	 * if provided buffer size is not equal to the size, should
>>> +	 * return 0 and also the expected buffer size to caller.
>>> +	 */
>>> +	if (info->size != size) {
>>> +		info->size = size;
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* report an empty iommu_nesting_info for now */
>>> +	memset(info, 0x0, size);
>>> +	info->size = size;
>>> +	return 0;
>>> +}
>>> +
>>>  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>>  				    enum iommu_attr attr, void *data)  { @@ -
>> 1515,8 +1541,7 @@
>>> static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>>  	case IOMMU_DOMAIN_UNMANAGED:
>>>  		switch (attr) {
>>>  		case DOMAIN_ATTR_NESTING:
>>> -			*(int *)data = (smmu_domain->stage ==
>> ARM_SMMU_DOMAIN_NESTED);
>>> -			return 0;
>>> +			return arm_smmu_domain_nesting_info(smmu_domain,
>> data);
>>>  		default:
>>>  			return -ENODEV;
>>>  		}
>>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
