Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED91AC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:00:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9AE2070C
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mfox9LeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9AE2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78B8188B15;
	Mon,  6 Jul 2020 13:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqHOkYntOTIK; Mon,  6 Jul 2020 13:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BEC8588AD3;
	Mon,  6 Jul 2020 13:00:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5238C0891;
	Mon,  6 Jul 2020 13:00:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F28AC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6B78B8763F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:00:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRkr4OM5CqBg for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:00:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 27450874D1
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594040453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRvkjhIH9FwsRMYIWgTLOYV+dlULlwA+LmeNUpAMVFc=;
 b=Mfox9LePeWeE/xNzk58xYJWJ64r+XfMWH/9wzh2KPq+CWtu5V34tpZz57Jh2pvz72Z5g68
 QwC4N+iyABvueFOhbtybcvjZGoynOBusStTIluXuKQ9sMLQaA+Fl40Bx5aWreUYDfd8P1S
 gNXSWEa6jKNfDA4E0o5UemSKKfKtiHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-hsuwTLzgNc-rrRJSIiJfqQ-1; Mon, 06 Jul 2020 09:00:52 -0400
X-MC-Unique: hsuwTLzgNc-rrRJSIiJfqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF16C8015F9;
 Mon,  6 Jul 2020 13:00:49 +0000 (UTC)
Received: from [10.36.113.241] (ovpn-113-241.ams2.redhat.com [10.36.113.241])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B8005C1B2;
 Mon,  6 Jul 2020 13:00:46 +0000 (UTC)
Subject: Re: [PATCH v4 02/15] iommu: Report domain nesting info
To: "Liu, Yi L" <yi.l.liu@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-3-git-send-email-yi.l.liu@intel.com>
 <b9479f61-7f9e-e0ae-5125-ab15f59b1ece@redhat.com>
 <DM5PR11MB14352CBCB1966C0B9E418C7CC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b1d361f3-b0ca-7fef-ba31-1bdcdadea96f@redhat.com>
Date: Mon, 6 Jul 2020 15:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB14352CBCB1966C0B9E418C7CC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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



On 7/6/20 2:20 PM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Monday, July 6, 2020 5:34 PM
>>
>> On 7/4/20 1:26 PM, Liu Yi L wrote:
>>> IOMMUs that support nesting translation needs report the capability info
>> need to report
>>> to userspace, e.g. the format of first level/stage paging structures.
>>>
>>> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
>>> nesting info after setting DOMAIN_ATTR_NESTING.
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
>>>  include/uapi/linux/iommu.h | 78
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 78 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>>> index 1afc661..1bfc032 100644
>>> --- a/include/uapi/linux/iommu.h
>>> +++ b/include/uapi/linux/iommu.h
>>> @@ -332,4 +332,82 @@ struct iommu_gpasid_bind_data {
>>>  	} vendor;
>>>  };
>>>
>>> +/*
>>> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
>>> + *				user space should check it before using
>>> + *				nesting capability.
>> alignment?
> 
> oh, yes, will do it.
> 
>>> + *
>>> + * @size:	size of the whole structure
>>> + * @format:	PASID table entry format, the same definition with
>>> + *		@format of struct iommu_gpasid_bind_data.
>> the same definition as struct iommu_gpasid_bind_data @format?
> 
> right. yours is much better.
> 
>>> + * @features:	supported nesting features.
>>> + * @flags:	currently reserved for future extension.
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
>>> + * | SYSWIDE_PASID |  PASIDs are managed in system-wide, instead of per   |
>>> + * |               |  device. When a device is assigned to userspace or   |
>>> + * |               |  VM, proper uAPI (userspace driver framework uAPI,   |
>>> + * |               |  e.g. VFIO) must be used to allocate/free PASIDs for |
>>> + * |               |  the assigned device.                                |
>>> + * +---------------+------------------------------------------------------+
>>> + * | BIND_PGTBL    |  The owner of the first level/stage page table must  |
>>> + * |               |  explicitly bind the page table to associated PASID  |
>>> + * |               |  (either the one specified in bind request or the    |
>>> + * |               |  default PASID of iommu domain), through userspace   |
>>> + * |               |  driver framework uAPI (e.g. VFIO_IOMMU_NESTING_OP). |
>>> + * +---------------+------------------------------------------------------+
>>> + * | CACHE_INVLD   |  The owner of the first level/stage page table must  |
>>> + * |               |  explicitly invalidate the IOMMU cache through uAPI  |
>>> + * |               |  provided by userspace driver framework (e.g. VFIO)  |
>>> + * |               |  according to vendor-specific requirement when       |
>>> + * |               |  changing the page table.                            |
>>> + * +---------------+------------------------------------------------------+
>> Do you foresee cases where BIND_PGTBL and CACHE_INVLD shouldn't be
>> exposed as features?
> 
> sorry, I didn't quite get it. could you explain a little bit more. :-)
For SYSWIDE_PASID I understand SMMU won't advertise it. But do you
foresee any nested implementation not requesting the owner of the tables
to bind and invalidate caches. So I understand those 2 features would
always be supported?
> 
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
>>> +	__u32	size;
>>> +	__u32	format;
>>> +	__u32	features;
>>> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
>>> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
>>> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
>> In other structs the values seem to be defined before the field
> 
> not sure. :-) I mimics the below struct from uapi/vfio.h
Yep I noticed that afterwards. In IOMMU uapi it looks the opposite
though. So I would alignto the style in the same file but that's not a
big deal.
> 
> struct vfio_iommu_type1_dma_map {
>         __u32   argsz;
>         __u32   flags;
> #define VFIO_DMA_MAP_FLAG_READ (1 << 0)         /* readable from device */
> #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)        /* writable from device */
>         __u64   vaddr;                          /* Process virtual address */
>         __u64   iova;                           /* IO virtual address */
>         __u64   size;                           /* Size of mapping (bytes) */
> };
> 
>>> +	__u32	flags;
>>> +	__u16	addr_width;
>>> +	__u16	pasid_bits;
>>> +	__u32	padding;
>>> +	__u8	data[];
>>> +};
>>> +
>>> +/*
>>> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
>>> + *
>> spurious line
> 
> yes, will remove this line.
> 
> Regards,
> Yi Liu
> 
>>> + *
>>> + * @flags:	VT-d specific flags. Currently reserved for future
>>> + *		extension.
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
>> Thanks
>>
>> Eric
> 

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
