Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5BAC433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 00:12:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C4F2606F9;
	Thu,  9 Dec 2021 00:12:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7OeUyR6uTAWL; Thu,  9 Dec 2021 00:12:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7ADD56068F;
	Thu,  9 Dec 2021 00:12:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52E87C002F;
	Thu,  9 Dec 2021 00:12:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABD29C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0096606C0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:12:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kAvQNlaMo16y for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 00:12:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFA236068F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 00:12:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238209149"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="238209149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 16:12:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="503279210"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.146.48])
 ([10.209.146.48])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 16:12:24 -0800
Message-ID: <5fec4e7e-be37-193b-b4ab-dd1bbdb589d1@intel.com>
Date: Wed, 8 Dec 2021 17:12:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com> <20211208115516.1d36fed9@jacob-builder>
 <20211208203022.GF6385@nvidia.com> <20211208135945.6d0a3b69@jacob-builder>
 <20211208233936.GI6385@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20211208233936.GI6385@nvidia.com>
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


On 12/8/2021 4:39 PM, Jason Gunthorpe wrote:
> On Wed, Dec 08, 2021 at 01:59:45PM -0800, Jacob Pan wrote:
>> Hi Jason,
>>
>> On Wed, 8 Dec 2021 16:30:22 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>> On Wed, Dec 08, 2021 at 11:55:16AM -0800, Jacob Pan wrote:
>>>> Hi Jason,
>>>>
>>>> On Wed, 8 Dec 2021 09:13:58 -0400, Jason Gunthorpe <jgg@nvidia.com>
>>>> wrote:
>>>>>> This patch utilizes iommu_enable_pasid_dma() to enable DSA to
>>>>>> perform DMA requests with PASID under the same mapping managed by
>>>>>> DMA mapping API. In addition, SVA-related bits for kernel DMA are
>>>>>> removed. As a result, DSA users shall use DMA mapping API to obtain
>>>>>> DMA handles instead of using kernel virtual addresses.
>>>>> Er, shouldn't this be adding dma_map/etc type calls?
>>>>>
>>>>> You can't really say a driver is using the DMA API without actually
>>>>> calling the DMA API..
>>>> The IDXD driver is not aware of addressing mode, it is up to the user of
>>>> dmaengine API to prepare the buffer mappings. Here we only set up the
>>>> PASID such that it can be picked up during DMA work submission. I
>>>> tested with /drivers/dma/dmatest.c which does dma_map_page(),
>>>> map_single etc. also tested with other pieces under development.
>>> Ignoring the work, doesn't IDXD prepare the DMA queues itself, don't
>>> those need the DMA API?
>>>
>> Do you mean wq completion record address? It is already using DMA API.
>> 	wq->compls = dma_alloc_coherent(dev, wq->compls_size,
>> &wq->compls_addr, GFP_KERNEL);
>> 	desc->compl_dma = wq->compls_addr + idxd->data->compl_size * i;
> I would have expected something on the queue submission side too?

DSA is different than typical DMA devices in the past. Instead of a 
software descriptor ring where the device DMA to fetch the descriptors 
after the software ringing a doorbell or writing a head index, the 
descriptors are submitted directly to the device via a CPU instruction 
(i.e. MOVDIR64B or ENQCMD(S)). The CPU takes the KVA of the 64B 
descriptor and writes to the device atomically. No DMA mapping is 
necessary in this case.


>
>>> the same thing, they do not use the same IOVA's. Did you test this
>>> with bypass mode off?
>> Yes with dmatest. IOVA is the default, I separated out the SATC patch which
>> will put internal accelerators in bypass mode. It can also be verified by
>> iommu debugfs dump of DMA PASID (2) and PASID 0 (RIDPASID) are pointing to
>> he same default domain. e.g
> Well, OK then..
>
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
