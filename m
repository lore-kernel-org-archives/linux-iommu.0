Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C1BC433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 02:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1125081293;
	Wed, 25 May 2022 02:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5AzoasQ2E87i; Wed, 25 May 2022 02:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC03081296;
	Wed, 25 May 2022 02:38:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8DB4C0032;
	Wed, 25 May 2022 02:38:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86E6BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63E174090B
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9yroiQVZKlQ for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 02:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2690E40905
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 02:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653446311; x=1684982311;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SdlZnAu2OMh5vWqWaY7d/SJjgLMefXlumhmFyk3EdaY=;
 b=DCuV0cLHDPBXNIahy2SHIJoGKEvYhir58Nqklh1pvzRONt6CpUVdI46I
 NowPvKMwr55h2HPbu7FHOlUdv+c5pIkJqOndIjbSjl2jpVitp1KblLrF8
 kxgiBmGuiXFPJMLQXcUB96RPIhca7TsouvYxHfcWoCLypHdxDWkoukwQl
 aOYyg6VbKbZ5xuK4Fr4i16Y39jb8bThuFo+8qtXU6LKgfdrN01No/BB6l
 q/zPpOSs7T6okpW7FMyw3xfNDB/NxGrbHCmXueH3HHkavzUqTce0cSo6J
 99Y9u3Pk/5Oe3rsdTk8/p2wl0XqkfTESvuhcuGVkQy+BP4AwJoUFMMl6C g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273426049"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="273426049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601611754"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 19:38:26 -0700
Message-ID: <5d1e2178-ac4c-a864-59b4-d297a3366f6a@linux.intel.com>
Date: Wed, 25 May 2022 10:38:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220524133839.GS1343366@nvidia.com>
 <BN9PR11MB52767C320271EC422B1D55228CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767C320271EC422B1D55228CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

On 2022/5/25 08:44, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Tuesday, May 24, 2022 9:39 PM
>>
>> On Tue, May 24, 2022 at 09:39:52AM +0000, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Thursday, May 19, 2022 3:21 PM
>>>>
>>>> The iommu_sva_domain represents a hardware pagetable that the
>> IOMMU
>>>> hardware could use for SVA translation. This adds some infrastructure
>>>> to support SVA domain in the iommu common layer. It includes:
>>>>
>>>> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
>>>> domain
>>>>    type.
>>>> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>>>>    support SVA should provide the callbacks.
>>>> - Add helpers to allocate and free an SVA domain.
>>>> - Add helpers to set an SVA domain to a device and the reverse
>>>>    operation.
>>>>
>>>> Some buses, like PCI, route packets without considering the PASID value.
>>>> Thus a DMA target address with PASID might be treated as P2P if the
>>>> address falls into the MMIO BAR of other devices in the group. To make
>>>> things simple, the attach/detach interfaces only apply to devices
>>>> belonging to the singleton groups, and the singleton is immutable in
>>>> fabric i.e. not affected by hotplug.
>>>>
>>>> The iommu_set/block_device_pasid() can be used for other purposes,
>>>> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
>>>> in the iommu.c.
>>>
>>> usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
>>> with 'block' doesn't read very clearly.
>>
>> I thought we agreed we'd use the blocking domain for this? Why did it
>> go back to an op?
>>
> 
> Probably it's based on following discussion:
> 
> https://lore.kernel.org/all/c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com/
> 
> --
>> FWIW from my point of view I'm happy with having a .detach_dev_pasid op
>> meaning implicitly-blocked access for now.
> 
> If this is the path then lets not call it attach/detach
> please. 'set_dev_pasid' and 'set_dev_blocking_pasid' are clearer
> names.

Yes. Learning from above discussion, we are about to implement the
set_dev_pasid and blocking domain in parallel. We will convert all
the callback names to set_dev and set_dev_pasid after blocking domain
support is merged.

> --
> 
> Looks Baolu chooses this path and plans to use the blocking domain
> later.

Yes. I have already started to implement the blocking domain in Intel
driver. With it as an example, we can extend it to other possible IOMMU
drivers.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
