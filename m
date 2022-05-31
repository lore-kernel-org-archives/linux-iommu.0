Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11610C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 16:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B75F940604;
	Tue, 31 May 2022 16:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxMcLrDHO6uf; Tue, 31 May 2022 16:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B23340104;
	Tue, 31 May 2022 16:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F4AFC0032;
	Tue, 31 May 2022 16:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41EA0C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33AA4418F7
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pqREXgHcrX4a for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9DAB418FB
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:01:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D43E523A;
 Tue, 31 May 2022 09:01:52 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313793F73D;
 Tue, 31 May 2022 09:01:51 -0700 (PDT)
Message-ID: <b66a2e3b-9adc-5150-fe00-d68b141b1c28@arm.com>
Date: Tue, 31 May 2022 17:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
 <20220531151332.GF1343366@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531151332.GF1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On 2022-05-31 16:13, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 04:01:04PM +0100, Robin Murphy wrote:
>> On 2022-05-31 15:53, Jason Gunthorpe wrote:
>>> On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
>>>> On 2022/5/31 21:10, Jason Gunthorpe wrote:
>>>>> On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
>>>>>
>>>>>> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
>>>>>> iommu_unmap() and dumping tables in debugfs exclusive. This does not
>>>>>> work because debugfs may depend on the DMA of the devices to work. It
>>>>>> seems that what we can do is to allow this race, but when we traverse
>>>>>> the page table in debugfs, we will check the validity of the physical
>>>>>> address retrieved from the page table entry. Then, the worst case is to
>>>>>> print some useless information.
>>>>>
>>>>> Sounds horrible, don't you have locking around the IOPTEs of some
>>>>> kind? How does updating them work reliably?
>>>>
>>>> There's no locking around updating the IOPTEs. The basic assumption is
>>>> that at any time, there's only a single thread manipulating the mappings
>>>> of the range specified in iommu_map/unmap() APIs. Therefore, the race
>>>> only exists when multiple ranges share some high-level IOPTEs. The IOMMU
>>>> driver updates those IOPTEs using the compare-and-exchange atomic
>>>> operation.
>>>
>>> Oh? Did I miss where that was documented as part of the iommu API?
>>>
>>> Daniel posted patches for VFIO to multi-thread iommu_domin mapping.
>>>
>>> iommufd goes out of its way to avoid this kind of serialization so
>>> that userspace can parallel map IOVA.
>>>
>>> I think if this is the requirement then the iommu API needs to
>>> provide a lock around the domain for the driver..
>>
>> Eww, no, we can't kill performance by forcing serialisation on the entire
>> API just for one silly driver-internal debugfs corner :(
> 
> I'm not worried about debugfs, I'm worried about these efforts to
> speed up VFIO VM booting by parallel domain loading:
> 
> https://lore.kernel.org/kvm/20220106004656.126790-1-daniel.m.jordan@oracle.com/
> 
> The DMA API should maintain its own external lock, but the general
> domain interface to the rest of the kernel should be safe, IMHO.

The DMA API doesn't need locking, partly since it can trust itself not 
to do stupid things, and mostly because it's DMA API performance that's 
fundamentally incompatible with serialisation anyway. Why do you think 
we have a complicated per-CPU IOVA caching mechanism, if not to support 
big multi-queue devices with multiple CPU threads mapping/unmapping in 
different parts of the same DMA domain concurrently?

> Or at least it should be documented..

As far as I'm aware there's never been any restriction at the IOMMU API 
level. It should be self-evident that racing concurrent 
iommu_{map,unmap} requests against iommu_domain_free(), or against each 
other for overlapping IOVAs, is a bad idea and don't do that if you want 
a well-defined outcome. The simpler drivers already serialise on a 
per-domain lock internally, while the more performance-focused ones 
implement lock-free atomic pagetable management in a similar style to 
CPU arch code; either way it should work fine as-is. The difference with 
debugfs is that it's a completely orthogonal side-channel - an 
iommu_domain user like VFIO or iommu-dma can make sure its *own* API 
usage is sane, but can't be aware of the user triggering some 
driver-internal introspection of that domain in a manner that could race 
more harmfully. It has to be down to individual drivers to make that 
safe if they choose to expose such an interface.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
