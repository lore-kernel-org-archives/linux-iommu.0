Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56FFC433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 12:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EBA540524;
	Thu, 12 May 2022 12:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZmJVdHx30Tc; Thu, 12 May 2022 12:47:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 391084016A;
	Thu, 12 May 2022 12:47:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E841AC0032;
	Thu, 12 May 2022 12:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 040C7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE76941958
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wVpDRF7LXn_X for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 12:47:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0161B401BD
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652359653; x=1683895653;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TZMqMvMmQoQX5FpgkY8+5sOYtRKyNEg9CK8KlsRcL5o=;
 b=cnXB6ffOFFBlVOLlpGLAHzwzHZWvYeF1ounsBEx1Ik3nUGwROy5auwi/
 xCkcpzTs3ObWmdQbWBmIsAzHtapEB3wdCRc0GIlPzAFdce3ar2Y3rOKrV
 QSOzduH8aTMgkUlSIw0q67CSx040xmBtwQUCTrSrLDgxw3NyIhc91SYds
 mBmty0fus2Crbus8J8TCD/LgKa5pIDXMuWv7L2/SLfDPFmsT5QE5urAPK
 +HlV0cVI9c+aWFj8DrvVC3yhGMABYRd8vcxY0WT75bZVt60/2sv7TNFAp
 +q1B3sRe3KRJ8BHpVnKYE7m6pLg5xZUhVnexkSECGcGo8YFN6rKeY+ymE w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330592074"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; d="scan'208";a="330592074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 05:47:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; d="scan'208";a="594650645"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 05:47:28 -0700
Message-ID: <f463fb9d-8edc-7b7d-b109-d3f5d0dcabd9@linux.intel.com>
Date: Thu, 12 May 2022 20:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
 <20220512114844.GT49344@nvidia.com>
 <1a78418a-8637-e8dd-d1de-5529f20058fd@linux.intel.com>
 <20220512120303.GY49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512120303.GY49344@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/12 20:03, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 07:59:41PM +0800, Baolu Lu wrote:
>> On 2022/5/12 19:48, Jason Gunthorpe wrote:
>>> On Thu, May 12, 2022 at 01:17:08PM +0800, Baolu Lu wrote:
>>>> On 2022/5/12 13:01, Tian, Kevin wrote:
>>>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>>>> Sent: Thursday, May 12, 2022 11:03 AM
>>>>>>
>>>>>> On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>>>>>>>> Also, given the current arrangement it might make sense to have a
>>>>>>>>> struct iommu_domain_sva given that no driver is wrappering this in
>>>>>>>>> something else.
>>>>>>>> Fair enough. How about below wrapper?
>>>>>>>>
>>>>>>>> +struct iommu_sva_domain {
>>>>>>>> +       /*
>>>>>>>> +        * Common iommu domain header,*must*  be put at the top
>>>>>>>> +        * of the structure.
>>>>>>>> +        */
>>>>>>>> +       struct iommu_domain domain;
>>>>>>>> +       struct mm_struct *mm;
>>>>>>>> +       struct iommu_sva bond;
>>>>>>>> +}
>>>>>>>>
>>>>>>>> The refcount is wrapped in bond.
>>>>>>> I'm still not sure that bond is necessary
>>>>>>
>>>>>> "bond" is the sva handle that the device drivers get through calling
>>>>>> iommu_sva_bind().
>>>>>>
>>>>>
>>>>> 'bond' was required before because we didn't have a domain to wrap
>>>>> the page table at that time.
>>>>>
>>>>> Now we have a domain and it is 1:1 associated to bond. Probably
>>>>> make sense now by just returning the domain as the sva handle
>>>>> instead?
>>>>
>>>> It also includes the device information that the domain has been
>>>> attached. So the sva_unbind() looks like this:
>>>>
>>>> /**
>>>>    * iommu_sva_unbind_device() - Remove a bond created with
>>>> iommu_sva_bind_device
>>>>    * @handle: the handle returned by iommu_sva_bind_device()
>>>>    *
>>>>    * Put reference to a bond between device and address space. The device
>>>> should
>>>>    * not be issuing any more transaction for this PASID. All outstanding page
>>>>    * requests for this PASID must have been flushed to the IOMMU.
>>>>    */
>>>> void iommu_sva_unbind_device(struct iommu_sva *handle)
>>>>
>>>> It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
>>>> if we can include the device in the unbind() interface.
>>>
>>> Why would we have a special unbind for SVA?
>>
>> It's about SVA kAPI for device drivers. The existing kAPIs include:
>>
>> struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>>                                          struct mm_struct *mm,
>>                                          void *drvdata);
>> void iommu_sva_unbind_device(struct iommu_sva *handle);
>> u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> 
> This is not what we agreed the API should be. We agreed:
> 
>   iommu_sva_domain_alloc()
>   iommu_attach_device_pasid()
>   iommu_detach_device_pasid()
> 
> Again, SVA should not be different from normal domain stuff.

Yes, agreed.

I am trying to achieve this in two steps. This first step focuses on
internal iommu implementation and keep the driver kAPI untouched. Then,
the second step focus on the driver APIs.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
