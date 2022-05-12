Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91C5C433F5
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 05:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58391400B8;
	Thu, 12 May 2022 05:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k0QxGiOmEcfz; Thu, 12 May 2022 05:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 421B440B9F;
	Thu, 12 May 2022 05:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15DC6C0032;
	Thu, 12 May 2022 05:17:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6C11C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2F8660BDD
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PqmMn4oTHiH6 for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B3A360ADC
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 05:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652332634; x=1683868634;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JZD9ZoRZafokL8iPENWer3ntJWFW7GvCYTn95IARhRg=;
 b=V8HR9PbwnClzeLU3EtR6ZAOIjkkRby6LftE4VWvH+h3tQLAeLgszN80s
 CNWHyMa9GAUzgEVywJjVP+YDg6QQWUOw4En1QZO0e29Ati0WA5MPyzoaG
 wwX8IfnEGtQBFv7auR/tsUGViyOER077eNNrOWBPzF8hlP4EkW40N9tDk
 j1Zn8MlLuxig6skGAabgH+Ot2EQnTdRL8xQNYokm28x2BEMe7hrPz/q4h
 9v4zsCACch0/+f7EEHyvI7LAQTKVI0KcL+RPp25cODgmaT3MytPkcT9PD
 E1yJgydzVgmyAMp9gCltELlZXL4OYDMiR7Q67BxlQr6zp0GwPr7wuFsWv A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269567504"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="269567504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 22:17:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="594492936"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168])
 ([10.255.29.168])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 22:17:10 -0700
Message-ID: <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
Date: Thu, 12 May 2022 13:17:08 +0800
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/5/12 13:01, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 12, 2022 11:03 AM
>>
>> On 2022/5/11 22:53, Jason Gunthorpe wrote:
>>>>> Also, given the current arrangement it might make sense to have a
>>>>> struct iommu_domain_sva given that no driver is wrappering this in
>>>>> something else.
>>>> Fair enough. How about below wrapper?
>>>>
>>>> +struct iommu_sva_domain {
>>>> +       /*
>>>> +        * Common iommu domain header,*must*  be put at the top
>>>> +        * of the structure.
>>>> +        */
>>>> +       struct iommu_domain domain;
>>>> +       struct mm_struct *mm;
>>>> +       struct iommu_sva bond;
>>>> +}
>>>>
>>>> The refcount is wrapped in bond.
>>> I'm still not sure that bond is necessary
>>
>> "bond" is the sva handle that the device drivers get through calling
>> iommu_sva_bind().
>>
> 
> 'bond' was required before because we didn't have a domain to wrap
> the page table at that time.
> 
> Now we have a domain and it is 1:1 associated to bond. Probably
> make sense now by just returning the domain as the sva handle
> instead?

It also includes the device information that the domain has been
attached. So the sva_unbind() looks like this:

/**
  * iommu_sva_unbind_device() - Remove a bond created with 
iommu_sva_bind_device
  * @handle: the handle returned by iommu_sva_bind_device()
  *
  * Put reference to a bond between device and address space. The device 
should
  * not be issuing any more transaction for this PASID. All outstanding page
  * requests for this PASID must have been flushed to the IOMMU.
  */
void iommu_sva_unbind_device(struct iommu_sva *handle)

It's fine to replace the iommu_sva with iommu_sva_domain for sva handle,
if we can include the device in the unbind() interface.

Anyway, I'd expect to achieve all these in two steps:

- sva and iopf refactoring, only iommu internal changes;
- sva interface refactoring, only interface changes.

Does above work?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
