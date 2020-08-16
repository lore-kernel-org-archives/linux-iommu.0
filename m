Return-Path: <SRS0=Ai5c=B2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C902C433DF
	for <iommu@archiver.kernel.org>; Sun, 16 Aug 2020 12:41:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D616207DA
	for <iommu@archiver.kernel.org>; Sun, 16 Aug 2020 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHPLSqFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D616207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CE59920441;
	Sun, 16 Aug 2020 12:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahTKwIG2R4q4; Sun, 16 Aug 2020 12:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C5032043C;
	Sun, 16 Aug 2020 12:41:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD3BC088B;
	Sun, 16 Aug 2020 12:41:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80003C0051
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 12:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4298A20441
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 12:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6JoJ3H4Qn3x for <iommu@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 12:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 425F12043C
 for <iommu@lists.linux-foundation.org>; Sun, 16 Aug 2020 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597581675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6QbWSvnf2bmBixOnHI1VVMEbALEkdQsCPQ5VY3+rOs=;
 b=NHPLSqFkdw5a3ipgDEyuxEA27F3y4ZjT3ZgSodNzBDqbPhPuYu+otaq0S62F5CsX1CnUnt
 IBh9gl03SsSeDnd6pFV3CwLaZS66mjBf3WP5SdAKicCBrTIFJaLtaPjz40eYPdpFOrAMbZ
 FO38jH7yTzszzSPJ/OgfEXiXK1l2wRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Nnagph-PNv-RJbVc_e8CZw-1; Sun, 16 Aug 2020 08:41:11 -0400
X-MC-Unique: Nnagph-PNv-RJbVc_e8CZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C82F68712F5;
 Sun, 16 Aug 2020 12:41:09 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3505639A75;
 Sun, 16 Aug 2020 12:40:59 +0000 (UTC)
Subject: Re: [PATCH v6 02/15] iommu: Report domain nesting info
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-3-git-send-email-yi.l.liu@intel.com>
 <5c911565-c76a-c361-845e-56a91744d504@redhat.com>
 <DM5PR11MB1435CC4503506228790CCB39C3400@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <342e8d77-1c1d-e637-0227-720ba67df8ba@redhat.com>
Date: Sun, 16 Aug 2020 14:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB1435CC4503506228790CCB39C3400@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On 8/14/20 9:15 AM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Thursday, August 13, 2020 8:53 PM
>>
>> Yi,
>> On 7/28/20 8:27 AM, Liu Yi L wrote:
>>> IOMMUs that support nesting translation needs report the capability info
>> s/needs/need to
>>> to userspace. It gives information about requirements the userspace needs
>>> to implement plus other features characterizing the physical implementation.
>>>
>>> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
>>> nesting info after setting DOMAIN_ATTR_NESTING. For VFIO, it is after
>>> selecting VFIO_TYPE1_NESTING_IOMMU.
>> This is not what this patch does ;-) It introduces a new IOMMU UAPI
>> struct that gives information about the nesting capabilities and
>> features. This struct is supposed to be returned by
>> iommu_domain_get_attr() with DOMAIN_ATTR_NESTING attribute parameter,
>> one a domain whose type has been set to DOMAIN_ATTR_NESTING.
> 
> got it. let me apply your suggestion. thanks. :-)
> 
>>>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>> v5 -> v6:
>>> *) rephrase the feature notes per comments from Eric Auger.
>>> *) rename @size of struct iommu_nesting_info to @argsz.
>>>
>>> v4 -> v5:
>>> *) address comments from Eric Auger.
>>>
>>> v3 -> v4:
>>> *) split the SMMU driver changes to be a separate patch
>>> *) move the @addr_width and @pasid_bits from vendor specific
>>>    part to generic part.
>>> *) tweak the description for the @features field of struct
>>>    iommu_nesting_info.
>>> *) add description on the @data[] field of struct iommu_nesting_info
>>>
>>> v2 -> v3:
>>> *) remvoe cap/ecap_mask in iommu_nesting_info.
>>> *) reuse DOMAIN_ATTR_NESTING to get nesting info.
>>> *) return an empty iommu_nesting_info for SMMU drivers per Jean'
>>>    suggestion.
>>> ---
>>>  include/uapi/linux/iommu.h | 74
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 74 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>>> index 7c8e075..5e4745a 100644
>>> --- a/include/uapi/linux/iommu.h
>>> +++ b/include/uapi/linux/iommu.h
>>> @@ -332,4 +332,78 @@ struct iommu_gpasid_bind_data {
>>>  	} vendor;
>>>  };
>>>
>>> +/*
>>> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
>>> + *			       userspace should check it before using
>>> + *			       nesting capability.
>>> + *
>>> + * @argsz:	size of the whole structure.
>>> + * @flags:	currently reserved for future extension. must set to 0.
>>> + * @format:	PASID table entry format, the same definition as struct
>>> + *		iommu_gpasid_bind_data @format.
>>> + * @features:	supported nesting features.
>>> + * @addr_width:	The output addr width of first level/stage translation
>>> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
>>> + *		support.
>>> + * @data:	vendor specific cap info. data[] structure type can be deduced
>>> + *		from @format field.
>>> + *
>>> + *
>> +===============+===================================================
>> ===+
>>> + * | feature       |  Notes                                               |
>>> + *
>> +===============+===================================================
>> ===+
>>> + * | SYSWIDE_PASID |  IOMMU vendor driver sets it to mandate userspace    |
>>> + * |               |  to allocate PASID from kernel. All PASID allocation |
>>> + * |               |  free must be mediated through the TBD API.          |
>> s/TBD/IOMMU
> 
> got it.
> 
>>> + * +---------------+------------------------------------------------------+
>>> + * | BIND_PGTBL    |  IOMMU vendor driver sets it to mandate userspace    |
>>> + * |               |  bind the first level/stage page table to associated |
>> s/bind/to bind
> 
> got it.
> 
>>> + * |               |  PASID (either the one specified in bind request or  |
>>> + * |               |  the default PASID of iommu domain), through IOMMU   |
>>> + * |               |  UAPI.                                               |
>>> + * +---------------+------------------------------------------------------+
>>> + * | CACHE_INVLD   |  IOMMU vendor driver sets it to mandate userspace    |
>>
>>> + * |               |  explicitly invalidate the IOMMU cache through IOMMU |
>> to explicitly
> 
> I see.
> 
>>> + * |               |  U
>>> API according to vendor-specific requirement when  |
>>> + * |               |  changing the 1st level/stage page table.            |
>>> + * +---------------+------------------------------------------------------+
>>> + *
>>> + * @data[] types defined for @format:
>>> + *
>> +================================+==================================
>> ===+
>>> + * | @format                        | @data[]                             |
>>> + *
>> +================================+==================================
>> ===+
>>> + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
>>> + * +--------------------------------+-------------------------------------+
>>> + *
>>> + */
>>> +struct iommu_nesting_info {
>>> +	__u32	argsz;
>>> +	__u32	flags;
>>> +	__u32	format;
>>> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
>>> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
>>> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
>>> +	__u32	features;
>>> +	__u16	addr_width;
>>> +	__u16	pasid_bits;
>>> +	__u32	padding;
>>> +	__u8	data[];
>>> +};
>> As opposed to other IOMMU UAPI structs there is no union member at the
>> end.
> 
> nice catch. do you think it would be better to adding a union and
> put the struct iommu_nesting_info_vtd in it?
Yes I think so. At least it would be consistent with the rest of the API
and with the guidelines.
> 
>> Also this struct is not documented in [PATCH v7 1/7] docs: IOMMU
>> user API. Shouldn't we align.
>> You may also consider to move this patch in Jacob's series for
>> consistency, thoughts?
> 
> this was talked one time between Jacob and me. It was put in this
> series as the major user of nesting_info is in this series. e.g.
> vfio checks the SYSWIDE_PASID. but I'm open to merge it with Jacob's
> series if it would make the merge easier.
Yep I think it would make sense to move in Jacob's series to have a
general understanding of the uapi

Thanks

Eric
> 
> Thanks,
> Yi Liu
> 
>>> +
>>> +/*
>>> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info.
>>> + *
>>> + * @flags:	VT-d specific flags. Currently reserved for future
>>> + *		extension. must be set to 0.
>>> + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
>>> + *		register.
>>> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
>>> + *		extended capability register.
>>> + */
>>> +struct iommu_nesting_info_vtd {
>>> +	__u32	flags;
>>> +	__u32	padding;
>>> +	__u64	cap_reg;
>>> +	__u64	ecap_reg;
>>> +};
>>> +
>>>  #endif /* _UAPI_IOMMU_H */
>>>
>>
>> Thanks
>>
>> Eric
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
