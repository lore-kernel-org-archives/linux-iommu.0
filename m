Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A998C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 06:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D57E441739;
	Thu, 12 May 2022 06:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hx2YmFsCwQfJ; Thu, 12 May 2022 06:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 937164174B;
	Thu, 12 May 2022 06:16:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56345C0039;
	Thu, 12 May 2022 06:16:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A00BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 06:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0852F6066D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 06:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EnfXJRkbcvZn for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 06:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BB5A60655
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 06:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652336207; x=1683872207;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=g6IIn5TcCQm3tWIL9ibzyttiUg0lLF5CJ9+P8r5+AbE=;
 b=jgX+jwEdLO6Iz0NFURoU616U0lJGOvJSC8oFfIWCFejbTO27IBB9ULwx
 UhFlxn4M8KrKXDZaU37gy9PtPr+aFil+v/Yvs+EGXIRfjzml+wDwow4HH
 PaNNPZ0JAXX0/BqjnU9i66lBrVgG8wB6c1tQNRfgvViLNcRa0+DCPg3KS
 RPaxxriYP3+lCecnQubSTNUpRtvnklDnrETSw9XYbPPKWQX9mIkKUiJEI
 VmBl6H4f28b4aOB/Pa+hE498yLkgQ5Ot18xZ7GLzoli7piRQprglj7fJy
 ijAdo7NF+gAaalL6zCLOdONHef5Z9OM8H92F5bOOYzQPtOFushHKS75o0 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="250431391"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="250431391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 23:16:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="594513911"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 23:16:37 -0700
Message-ID: <0170bf39-5c1b-c4d5-631d-2afe98a5de61@linux.intel.com>
Date: Thu, 12 May 2022 14:16:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
 <BN9PR11MB5276AFC5784F4D1FBA90E6058CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276AFC5784F4D1FBA90E6058CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2022/5/12 13:44, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 12, 2022 1:17 PM
>>
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
>>    * iommu_sva_unbind_device() - Remove a bond created with
>> iommu_sva_bind_device
>>    * @handle: the handle returned by iommu_sva_bind_device()
>>    *
>>    * Put reference to a bond between device and address space. The device
>> should
>>    * not be issuing any more transaction for this PASID. All outstanding page
>>    * requests for this PASID must have been flushed to the IOMMU.
>>    */
>> void iommu_sva_unbind_device(struct iommu_sva *handle)
>>
>> It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
>> if we can include the device in the unbind() interface.
> 
> can we just have unbind(domain, device)?

Yes. With this, we can remove bond.

This could be done in below phase 2.

> 
>>
>> Anyway, I'd expect to achieve all these in two steps:
>>
>> - sva and iopf refactoring, only iommu internal changes;
>> - sva interface refactoring, only interface changes.
>>
>> Does above work?
>>
>> Best regards,
>> baolu

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
