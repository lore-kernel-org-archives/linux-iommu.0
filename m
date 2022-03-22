Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A192C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 00:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27003416F1;
	Tue, 22 Mar 2022 00:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aH_sFkni19nD; Tue, 22 Mar 2022 00:49:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 007A441550;
	Tue, 22 Mar 2022 00:49:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA480C0012;
	Tue, 22 Mar 2022 00:49:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24A9EC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03BD840A91
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7dXxxYv4bhG8 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 00:49:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 472F9401B7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647910143; x=1679446143;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0x7qIpjv0NuBVYWXT9Tw0mEj9Ru1y7+aMXqGBkCgSwc=;
 b=AZZLqLNpJeLc836IzJCIqCg7zMOMseBP9gTkeMhC7pgypG+IRs9bpjlU
 A2z67VnxGWHA8/C9pVbzoTRAQ4hqBbHZRYzMDYtZjXjKUZDxjwrGHuDBB
 sohzsnzywfJVFOgJC8pyVlRqSEch4J0FLkKf0lB41Fqolo+rsDmkDXRvJ
 Q7GTl3GQMCVGJcl5JwpFJU/9vuFFBiLZUewdZiSQ0n6X9a7qZYldbAkXM
 WI1AU40Sa81ivDa1cCbG4oaMGeDLaeWH4nL0wmMGT57A08S1uZGIysayY
 GF3LbwZMYIdeJA4evygJNQiq2Loyji/bqGAFX+Dw8uHLItMHA6BfjzGmo g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257634382"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="257634382"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:49:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="560120071"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.85])
 ([10.254.208.85])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:48:59 -0700
Message-ID: <85d61ad6-0cf0-ac65-3312-32d0cdeb1b27@linux.intel.com>
Date: Tue, 22 Mar 2022 08:48:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
 <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <7de05f5e-864f-175e-5604-29561d330884@linux.intel.com>
 <BN9PR11MB5276981B9328F10E5FC89B728C179@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276981B9328F10E5FC89B728C179@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/3/22 8:26, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, March 21, 2022 6:22 PM
>>>> -				if (features >= 0)
>>>> +				if (features >= 0) {
>>>>    					info->pasid_supported = features | 1;
>>>> +					dev->iommu->pasid_bits =
>>>> +						fls(pci_max_pasids(pdev)) - 1;
>>> Original intel_svm_alloc_pasid() covers both PCI and non-PCI devices:
>>>
>>> 	ioasid_t max_pasid = dev_is_pci(dev) ?
>>> 		pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
>>>
>>> though I'm not sure whether non-PCI SVA has been supported indeed, this
>>> patch implies a functional change here.
>>>
>>
>> The info->pasid_supported is only set for PCI devices. So the status is
>> that non-PCI SVA hasn't been supported. No functional change here from
>> this point of view.
>>
> 
> Then this information should be included in the commit msg.

Sure.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
