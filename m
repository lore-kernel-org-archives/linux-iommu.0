Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14015C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 02:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D938402DC;
	Thu,  9 Dec 2021 02:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1iMMqyUDz22p; Thu,  9 Dec 2021 02:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69C49400F2;
	Thu,  9 Dec 2021 02:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CF11C001E;
	Thu,  9 Dec 2021 02:21:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7841C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 02:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5E01405AE
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 02:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wWAxgW-2tt5 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:21:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D4AB4059D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 02:21:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="324260663"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; d="scan'208";a="324260663"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 18:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; d="scan'208";a="516080276"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 08 Dec 2021 18:21:47 -0800
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
 <20211208104939.732fa5b9@jacob-builder>
 <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
Date: Thu, 9 Dec 2021 10:21:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
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

On 12/9/21 9:56 AM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, December 9, 2021 2:50 AM
>>
>>> Can a device issue DMA requests with PASID even there's no system
>> IOMMU
>>> or the system IOMMU is disabled?
>>>
>> Good point.
>> If IOMMU is not enabled, device cannot issue DMA requests with PASID. This
>> API will not be available. Forgot to add dummy functions to the header.
>>
> 
> PASID is a PCI thing, not defined by IOMMU.
> 
> I think the key is physically if IOMMU is disabled, how will root complex
> handle a PCI memory request including a PASID TLP prefix? Does it block
> such request due to no IOMMU to consume PASID or simply ignore PASID
> and continue routing the request to the memory controller?
> 
> If block, then having an iommu interface makes sense.
> 
> If ignore, possibly a DMA API call makes more sense instead, implying that
> this extension can be used even when iommu is disabled.
> 
> I think that is what Baolu wants to point out.

Yes, exactly. Imagining in the VM guest environment, do we require a
vIOMMU for this functionality? vIOMMU is not performance friendly if we
put aside the security considerations.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
