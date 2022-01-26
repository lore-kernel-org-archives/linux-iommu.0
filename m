Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0722C3526D
	for <iommu@archiver.kernel.org>; Wed, 26 Jan 2022 14:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6577E606B0;
	Wed, 26 Jan 2022 14:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZPzwvpeH_Co; Wed, 26 Jan 2022 14:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 243ED60597;
	Wed, 26 Jan 2022 14:00:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00F71C0031;
	Wed, 26 Jan 2022 14:00:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E10FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 14:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 054C782446
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 14:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNttPY1B2mbN for <iommu@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:00:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D25EE8175E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 14:00:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E57741FB;
 Wed, 26 Jan 2022 06:00:10 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8953F793;
 Wed, 26 Jan 2022 06:00:07 -0800 (PST)
Message-ID: <ca66f612-879c-4620-0505-26af362b4240@arm.com>
Date: Wed, 26 Jan 2022 14:00:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
 <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
 <20220125151602.GL84788@nvidia.com>
 <a43279ba-8a18-a4a7-f317-a5e2091a0c74@linux.intel.com>
 <20220126132731.GR84788@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220126132731.GR84788@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>, "Pan,
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

On 2022-01-26 13:27, Jason Gunthorpe via iommu wrote:
> On Wed, Jan 26, 2022 at 09:51:36AM +0800, Lu Baolu wrote:
> 
>>>> they are fundamentally different things in their own right, and the ideal
>>>> API should give us the orthogonality to also bind a device to an SVA domain
>>>> without PASID (e.g. for KVM stage 2, or userspace assignment of simpler
>>>> fault/stall-tolerant devices), or attach PASIDs to regular iommu_domains.
>>>
>>> Yes, these are orthogonal things. A iommu driver that supports PASID
>>> ideally should support PASID enabled attach/detatch for every
>>> iommu_domain type it supports.
>>>
>>> SVA should not be entangled with PASID beyond that SVA is often used
>>> with PASID - a SVA iommu_domain should be fully usable with a RID too.
>>
>> The prototype of PASID enabled attach/detach ops could look like:
>>
>>         int (*attach_dev_pasid)(struct iommu_domain *domain,
>>                                 struct device *dev, ioasid_t id);
>>         void (*detach_dev_pasid)(struct iommu_domain *domain,
>>                                  struct device *dev, ioasid_t id);
> 
> It seems reasonable and straightforward to me..
> 
> These would be domain ops?
>   
>> But the iommu driver should implement different callbacks for
>>
>> 1) attaching an IOMMU DMA domain to a PASID on device;
>>     - kernel DMA with PASID
>>     - mdev-like device passthrough
>>     - etc.
>> 2) attaching a CPU-shared domain to a PASID on device;
>>     - SVA
>>     - guest PASID
>>     - etc.
> 
> But this you mean domain->ops would be different? Seems fine, up to
> the driver.

Indeed, it makes little practical difference whether the driver provides 
distinct sets of ops or just common callbacks which switch on the domain 
type internally. I expect that's largely going to come down to personal 
preference and how much internal driver code is common between the paths.

> I'd hope to see some flow like:
> 
>   domain = device->bus->iommu_ops->alloc_sva_domain(dev)
>   domain->ops->attach_dev_pasid(domain, dev, current->pasid)
> 
> To duplicate the current SVA APIs

+1 - I'd concur that attach/detach belong as domain ops in general. 
There's quite a nice logical split forming here where domain ops are the 
ones that make sense for external subsystems and endpoint drivers to use 
too, while device ops, with the sole exception of domain_alloc, are 
IOMMU API internals. By that reasoning, attach/bind/etc. are firmly in 
the former category.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
