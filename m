Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C38C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 15:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94D8F83E61;
	Wed,  8 Dec 2021 15:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAVsmvm3NN3e; Wed,  8 Dec 2021 15:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 684EF83E23;
	Wed,  8 Dec 2021 15:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DCDAC002F;
	Wed,  8 Dec 2021 15:35:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CEFDC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E86841C6C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5R6SVwaiX7t2 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7F6541C66
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:35:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224720471"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; d="scan'208";a="224720471"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 07:35:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; d="scan'208";a="503088404"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.146.48])
 ([10.209.146.48])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 07:35:50 -0800
Message-ID: <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
Date: Wed, 8 Dec 2021 08:35:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20211208131358.GR6385@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Barry Song <21cnbao@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
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


On 12/8/2021 6:13 AM, Jason Gunthorpe wrote:
> On Tue, Dec 07, 2021 at 05:47:14AM -0800, Jacob Pan wrote:
>> In-kernel DMA should be managed by DMA mapping API. The existing kernel
>> PASID support is based on the SVA machinery in SVA lib that is intended
>> for user process SVA. The binding between a kernel PASID and kernel
>> mapping has many flaws. See discussions in the link below.
>>
>> This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
>> requests with PASID under the same mapping managed by DMA mapping API.
>> In addition, SVA-related bits for kernel DMA are removed. As a result,
>> DSA users shall use DMA mapping API to obtain DMA handles instead of
>> using kernel virtual addresses.
> Er, shouldn't this be adding dma_map/etc type calls?
>
> You can't really say a driver is using the DMA API without actually
> calling the DMA API..
>
>> +	/*
>> +	 * Try to enable both in-kernel and user DMA request with PASID.
>> +	 * PASID is supported unless both user and kernel PASID are
>> +	 * supported. Do not fail probe here in that idxd can still be
>> +	 * used w/o PASID or IOMMU.
>> +	 */
>> +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
>> +		idxd_enable_system_pasid(idxd)) {
>> +		dev_warn(dev, "Failed to enable PASID\n");
>> +	} else {
>> +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>>   	}
> Huh? How can the driver keep going if PASID isn't supported? I thought
> the whole point of this was because the device cannot do DMA without
> PASID at all?

There are 2 types of WQ supported with the DSA devices. A dedicated WQ 
type and a shared WQ type. The dedicated WQ type can support DMA with 
and without PASID. The shared wq type must have a PASID to operate. The 
driver can support dedicated WQ only without PASID usage when there is 
no PASID support.


>
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
