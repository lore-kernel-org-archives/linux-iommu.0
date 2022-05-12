Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3CAC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 11:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E512040BCD;
	Thu, 12 May 2022 11:59:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K06o-zdmDKQi; Thu, 12 May 2022 11:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB7F0402BC;
	Thu, 12 May 2022 11:59:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6E9DC0039;
	Thu, 12 May 2022 11:59:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7B3CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B61AD61094
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lAWNJugf6iFl for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:59:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C44E606CB
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652356788; x=1683892788;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2xpqBipggE9efSrMnAk1RxaKgm4Z25yOtIHM0l1ipSE=;
 b=fJGr/NoagcChKpyILh4awcJC/cOr6fkjzP70HVmY6nyn63ly7O6Winwn
 vUTl4GQ8+AHUhJn5hIbi3CrQmfewUcxupvqSPI1Etq4WqUem9yJ97nTeS
 aV8s7G53k8eEqOS/h+qhcTBe+7zNmED+wFNg+9RBByX+1CYjYhHAkRbCB
 x7oApUsoUOix4vIrmMRJRLjpTbfO2EH0x7e7CYFaw9Vw8s9SWBSkgIEqr
 G2FzERiN1VMY/Dmd1et50TIMyHTc6dQBK8Yaq1lb0y+ZBgX9RQdxiXodm
 VAdqrkc5I5wR7izIB9Am4aW5nYYQRrGy8v4MUQQVvVdayhQRn1iTzw6Vh g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="333015292"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; d="scan'208";a="333015292"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 04:59:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; d="scan'208";a="594633931"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 04:59:43 -0700
Message-ID: <1a78418a-8637-e8dd-d1de-5529f20058fd@linux.intel.com>
Date: Thu, 12 May 2022 19:59:41 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512114844.GT49344@nvidia.com>
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

On 2022/5/12 19:48, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 01:17:08PM +0800, Baolu Lu wrote:
>> On 2022/5/12 13:01, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, May 12, 2022 11:03 AM
>>>>
>>>> On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>>>>>> Also, given the current arrangement it might make sense to have a
>>>>>>> struct iommu_domain_sva given that no driver is wrappering this in
>>>>>>> something else.
>>>>>> Fair enough. How about below wrapper?
>>>>>>
>>>>>> +struct iommu_sva_domain {
>>>>>> +       /*
>>>>>> +        * Common iommu domain header,*must*  be put at the top
>>>>>> +        * of the structure.
>>>>>> +        */
>>>>>> +       struct iommu_domain domain;
>>>>>> +       struct mm_struct *mm;
>>>>>> +       struct iommu_sva bond;
>>>>>> +}
>>>>>>
>>>>>> The refcount is wrapped in bond.
>>>>> I'm still not sure that bond is necessary
>>>>
>>>> "bond" is the sva handle that the device drivers get through calling
>>>> iommu_sva_bind().
>>>>
>>>
>>> 'bond' was required before because we didn't have a domain to wrap
>>> the page table at that time.
>>>
>>> Now we have a domain and it is 1:1 associated to bond. Probably
>>> make sense now by just returning the domain as the sva handle
>>> instead?
>>
>> It also includes the device information that the domain has been
>> attached. So the sva_unbind() looks like this:
>>
>> /**
>>   * iommu_sva_unbind_device() - Remove a bond created with
>> iommu_sva_bind_device
>>   * @handle: the handle returned by iommu_sva_bind_device()
>>   *
>>   * Put reference to a bond between device and address space. The device
>> should
>>   * not be issuing any more transaction for this PASID. All outstanding page
>>   * requests for this PASID must have been flushed to the IOMMU.
>>   */
>> void iommu_sva_unbind_device(struct iommu_sva *handle)
>>
>> It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
>> if we can include the device in the unbind() interface.
> 
> Why would we have a special unbind for SVA?

It's about SVA kAPI for device drivers. The existing kAPIs include:

struct iommu_sva *iommu_sva_bind_device(struct device *dev,
                                         struct mm_struct *mm,
                                         void *drvdata);
void iommu_sva_unbind_device(struct iommu_sva *handle);
u32 iommu_sva_get_pasid(struct iommu_sva *handle);

> SVA should not different from normal domains it should use the normal
> detach flow too.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
