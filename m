Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9673C433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 15:37:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EC961B31
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 15:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2EC961B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5978C80DFD;
	Mon, 15 Nov 2021 15:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kSMCtluKW6l; Mon, 15 Nov 2021 15:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4EE2680D93;
	Mon, 15 Nov 2021 15:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDB26C002E;
	Mon, 15 Nov 2021 15:37:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 882DFC0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 15:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7791080D93
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 15:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5OeOP-frFSAb for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 15:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C030A80D11
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 15:37:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F31FE1063;
 Mon, 15 Nov 2021 07:37:40 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BBB93F766;
 Mon, 15 Nov 2021 07:37:38 -0800 (PST)
Message-ID: <8499f0ab-9701-2ca2-ac7a-842c36c54f8a@arm.com>
Date: Mon, 15 Nov 2021 15:37:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/11] driver core: Set DMA ownership during driver
 bind/unbind
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-3-baolu.lu@linux.intel.com>
 <YZJeRomcJjDqDv9q@infradead.org> <20211115132442.GA2379906@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211115132442.GA2379906@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>, Diana Craciun <diana.craciun@oss.nxp.com>
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

On 2021-11-15 13:24, Jason Gunthorpe via iommu wrote:
> On Mon, Nov 15, 2021 at 05:19:02AM -0800, Christoph Hellwig wrote:
>> On Mon, Nov 15, 2021 at 10:05:43AM +0800, Lu Baolu wrote:
>>> @@ -566,6 +567,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>>   		goto done;
>>>   	}
>>>   
>>> +	if (!drv->suppress_auto_claim_dma_owner) {
>>> +		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL, NULL);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>
>> I'd expect this to go into iommu_setup_dma_ops (and its arm and s390
>> equivalents), as that is what claims an IOMMU for in-kernel usage
> 
> If iommu_device_set_dma_owner(dev_a) fails changes dynamically
> depending on what iommu_device_set_dma_owner(dev_b, DMA_OWNER_USER)
> have been done.
> 
> The whole point here is that doing a
>   iommu_device_set_dma_owner(dev_b, DMA_OWNER_USER)
> needs to revoke kernel usage from a whole bunch of other devices in
> the same group.
> 
> revoking kernel usage means it needs to ensure that no driver is bound
> and prevent future drivers from being bound.
> 
> iommu_setup_dma_ops() is something done once early on in boot, not at
> every driver probe, so I don't see how it can help??

Note that there's some annoying inconsistency across architectures, and 
with the {acpi,of}_dma_configure() code in general. I guess Christoph 
might be thinking of the case where iommu_setup_dma_ops() *does* end up 
being called off the back of the bus->dma_configure() hook a few lines 
below the context above.

iommu_setup_dma_ops() itself is indeed not the appropriate place for 
this (the fact that it can be called as late as driver probe is subtly 
broken and still on my list to fix...) but
bus->dma_configure() definitely is. Only a handful of buses care about 
IOMMUs, and possibly even fewer of them support VFIO, so I'm in full 
agreement with Greg and Christoph that this absolutely warrants being 
scoped per-bus. I mean, we literally already have infrastructure to 
prevent drivers binding if the IOMMU/DMA configuration is broken or not 
ready yet; why would we want a totally different mechanism to prevent 
driver binding when the only difference is that that configuration *is* 
ready and working to the point that someone's already claimed it for 
other purposes?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
