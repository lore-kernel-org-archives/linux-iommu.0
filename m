Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF38C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 06:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7E7C41131;
	Fri, 10 Dec 2021 06:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMqSDwCuqnGA; Fri, 10 Dec 2021 06:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C5D8403B2;
	Fri, 10 Dec 2021 06:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AACB7C002F;
	Fri, 10 Dec 2021 06:46:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6A3DC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 06:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BFD6D42554
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 06:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AgB7n5octZP5 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 06:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE4F242553
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 06:46:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218311203"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; d="scan'208";a="218311203"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 22:46:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; d="scan'208";a="516643571"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.25])
 ([10.254.211.25])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 22:46:36 -0800
Message-ID: <921a766f-d826-2ca4-f739-4d196b32a681@linux.intel.com>
Date: Fri, 10 Dec 2021 14:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208132255.GS6385@nvidia.com> <20211208111659.6de22e52@jacob-builder>
 <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
 <20211209152113.64b817b9@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
In-Reply-To: <20211209152113.64b817b9@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On 2021/12/10 7:21, Jacob Pan wrote:
> On Thu, 9 Dec 2021 10:32:43 +0800, Lu Baolu<baolu.lu@linux.intel.com>
> wrote:
> 
>> On 12/9/21 3:16 AM, Jacob Pan wrote:
>>> Hi Jason,
>>>
>>> On Wed, 8 Dec 2021 09:22:55 -0400, Jason Gunthorpe<jgg@nvidia.com>
>>> wrote:
>>>> On Tue, Dec 07, 2021 at 05:47:13AM -0800, Jacob Pan wrote:
>>>>> Between DMA requests with and without PASID (legacy), DMA mapping APIs
>>>>> are used indiscriminately on a device. Therefore, we should always
>>>>> match the addressing mode of the legacy DMA when enabling kernel
>>>>> PASID.
>>>>>
>>>>> This patch adds support for VT-d driver where the kernel PASID is
>>>>> programmed to match RIDPASID. i.e. if the device is in pass-through,
>>>>> the kernel PASID is also in pass-through; if the device is in IOVA
>>>>> mode, the kernel PASID will also be using the same IOVA space.
>>>>>
>>>>> There is additional handling for IOTLB and device TLB flush w.r.t. the
>>>>> kernel PASID. On VT-d, PASID-selective IOTLB flush is also on a
>>>>> per-domain basis; whereas device TLB flush is per device. Note that
>>>>> IOTLBs are used even when devices are in pass-through mode. ATS is
>>>>> enabled device-wide, but the device drivers can choose to manage ATS
>>>>> at per PASID level whenever control is available.
>>>>>
>>>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>>>>    drivers/iommu/intel/iommu.c | 105
>>>>> +++++++++++++++++++++++++++++++++++- drivers/iommu/intel/pasid.c |
>>>>> 7 +++ include/linux/intel-iommu.h |   3 +-
>>>>>    3 files changed, 113 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>>> index 60253bc436bb..a2ef6b9e4bfc 100644
>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>> @@ -1743,7 +1743,14 @@ static void domain_flush_piotlb(struct
>>>>> intel_iommu *iommu, if (domain->default_pasid)
>>>>>    		qi_flush_piotlb(iommu, did, domain->default_pasid,
>>>>>    				addr, npages, ih);
>>>>> -
>>>>> +	if (domain->kernel_pasid && !domain_type_is_si(domain)) {
>>>>> +		/*
>>>>> +		 * REVISIT: we only do PASID IOTLB inval for FL, we
>>>>> could have SL
>>>>> +		 * for PASID in the future such as vIOMMU PT. this
>>>>> doesn't get hit.
>>>>> +		 */
>>>>> +		qi_flush_piotlb(iommu, did, domain->kernel_pasid,
>>>>> +				addr, npages, ih);
>>>>> +	}
>>>>>    	if (!list_empty(&domain->devices))
>>>>>    		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr,
>>>>> npages, ih); }
>>>>> @@ -5695,6 +5702,100 @@ static void intel_iommu_iotlb_sync_map(struct
>>>>> iommu_domain *domain, }
>>>>>    }
>>>>>    
>>>>> +static int intel_enable_pasid_dma(struct device *dev, u32 pasid)
>>>>> +{
>>>> This seems like completely the wrong kind of op.
>>>>
>>>> At the level of the iommu driver things should be iommu_domain centric
>>>>
>>>> The op should be
>>>>
>>>> int attach_dev_pasid(struct iommu_domain *domain, struct device *dev,
>>>> ioasid_t pasid)
>>>>
>>>> Where 'dev' purpose is to provide the RID
>>>>
>>>> The iommu_domain passed in should be the 'default domain' ie the table
>>>> used for on-demand mapping, or the passthrough page table.
>>>>   
>>> Makes sense. DMA API is device centric, iommu API is domain centric. It
>>> should be the common IOMMU code to get the default domain then pass to
>>> vendor drivers. Then we can enforce default domain behavior across all
>>> vendor drivers.
>>> i.e. 	
>>> 	dom = iommu_get_dma_domain(dev);
>>> 	attach_dev_pasid(dom, dev, pasid);
>>>    
>>>>> +	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>>>>> +	struct device_domain_info *info;
>>>> I don't even want to know why an iommu driver is tracking its own
>>>> per-device state. That seems like completely wrong layering.
>>>>   
>>> This is for IOTLB and deTLB flush. IOTLB is flushed at per domain level,
>>> devTLB is per device.
>>>
>>> For multi-device groups, this is a need to track how many devices are
>>> using the kernel DMA PASID.
>>>
>>> Are you suggesting we add the tracking info in the generic layer? i.e.
>>> iommu_group.
>>>
>>> We could also have a generic device domain info to replace what is in
>>> VT-d and FSL IOMMU driver, etc.
>> The store place of per-device iommu driver private data has already been
>> standardized. The iommu core provides below interfaces for this purpose:
>>
>> void dev_iommu_priv_set(struct device *dev, void *priv);
>> void *dev_iommu_priv_get(struct device *dev);
>>
>> If we have anything generic among different vendor iommu drivers,
>> perhaps we could move them into dev->iommu.
>>
> Yes, good suggestion. DMA PASID should be a generic feature, not suitable
> for the opaque private date. Can we agree on adding the following flag for
> devTLB invalidation?
> 
> @@ -379,6 +379,7 @@ struct dev_iommu {
>          struct iommu_fwspec             *fwspec;
>          struct iommu_device             *iommu_dev;
>          void                            *priv;
> +       u32 pasid_dma_enabled           : 1;
>   };
> 
> For DMA PASID storage, can we store it in the iommu_domain instead of
> iommu_group? In the end, this PASID is only used for the default domain. It
> will be easier to refcount how many attached devices are using the PASID.
> Destroy the PASID when no devices in the group are using PASID DMA. IOTLB
> flush is per domain also.

Tying pasid to an iommu_domain is not a good idea. An iommu_domain
represents an I/O address translation table. It could be attached to a
device or a PASID on the device.

Perhaps the dev_iommu is a reasonable place for this.

@@ -390,6 +390,8 @@ struct dev_iommu {
         struct iommu_fwspec             *fwspec;
         struct iommu_device             *iommu_dev;
         void                            *priv;
+       unsigned int                    pasid_bits;
+       u32                             kernel_dma_pasid;
  };

@pasid_bits is a static attribute of a device which supports PASID
feature. It reads the PASID bitwidth that the device could support.
The vendor iommu driver could set this when the PASID feature is about
to be enabled. Normally, it's the MIN of device and iommu capabilities.

@kernel_dma_pasid is the PASID value used for kernel DMA if it's
enabled. It reads INVALID_IOASID if kernel DMA with PASID is not
enabled.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
