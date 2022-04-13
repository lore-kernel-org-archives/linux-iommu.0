Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ADAC433F5
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 11:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 049FC60BD0;
	Wed, 13 Apr 2022 11:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sP1Z1HunLeaE; Wed, 13 Apr 2022 11:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA5D3605A5;
	Wed, 13 Apr 2022 11:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AADEFC0033;
	Wed, 13 Apr 2022 11:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68ED5C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 11:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DF434026E
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 11:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dGTKihIzpC08 for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 11:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56C974024F
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649851067; x=1681387067;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=KoV5gY7Wi2PGzlg0y3OcX3k0Vg2NKJrLgb3wz9X3dmU=;
 b=Ydz/IhAiHc72j/NXAWIVyBFLcspQ3vfQEIzXU9UR1yDrbSzU6RKJTUka
 qfAY9WaOweZlufFffQHVOM+EA4NsqmErhmzlF3X8ovMFQ+6DZQqfO5scu
 udSp//EYLmjC1hIwsHBsAHKUuDdoOzyoAjoIrNaMz7vc2jBU1go6ByACr
 j2D0NAJTYXwyN9g2LKvvn3xYmbl8frvYB0UlZnMEI1RMtd2M6I6NgVje6
 u9uyoJOIvbVPkz4m5vjwrH5a2UNj7munYLg7HzrvKHRjGLqXeNuDfGOdd
 0xy9o2Tqyh1YDM/xG7KTgNmUy6ihaqDXxrNjjK7++iDhMnMkkPFo6aRbL Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244531021"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; d="scan'208";a="244531021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 04:57:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; d="scan'208";a="573236615"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.67])
 ([10.254.215.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 04:57:38 -0700
Message-ID: <c92d014a-9332-27d2-688b-48fc07efdebb@linux.intel.com>
Date: Wed, 13 Apr 2022 19:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
 <BN9PR11MB5276BE861CF22DDC11D9D8038CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
In-Reply-To: <BN9PR11MB5276BE861CF22DDC11D9D8038CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/13 7:36, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 12, 2022 8:53 PM
>>
>>>
>>>> +	if (!handle) {
>>>> +		ret = -ENOMEM;
>>>> +		goto out_put_ioas;
>>>> +	}
>>>> +
>>>> +	/* The reference to ioas will be kept until domain free. */
>>>> +	domain = iommu_sva_alloc_domain(dev, ioas);
>>>
>>> Shouldn't we first try whether existing domains are compatible to this
>>> device?
>>
>> If we think that here domain represents a hardware pagetable actually
>> used by IOMMU for a {device, pasid}, we are able to use per-{device,
>> pasid} domain without checking compatibility. Sharing a domain among
>> devices under the same IOMMU may be an optimization. That could be done
>> in the IOMMU driver just like what vt-d driver is doing for pass-through
>> DMA domains.
>>
> 
> there is only one hardware page table per mm in this case. Multiple domains
> are required only due to compatibility reason as Jason/Robin pointed out
> in SMMU case. Given all other places create multiple domains per ioas only
> upon incompatibility, probably it's more consistent to doing so in this path
> too...

Sharing domain for compatible devices is valuable when the domain
supports map/unmap operations. That can reduce the number of map/unmap
calls and the resulting synchronization of IOTLB. But for SVA case, it's
a dumb domain which only provides attach/detach operations.

A similar case could be found on pass-through DMA domains. The iommu
core allocates a default domain for each group although all the domains
represent a same page table for the compatible devices. The VT-d driver
optimizes this by exporting a static identity domain.

Anyway, I am open for this. I can add a compatible domain list if most
of you like that way. :-)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
