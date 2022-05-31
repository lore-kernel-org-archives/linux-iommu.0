Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCD1C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 15:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A65DA6127F;
	Tue, 31 May 2022 15:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TApsRB5zILST; Tue, 31 May 2022 15:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 842B161054;
	Tue, 31 May 2022 15:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BAF6C0039;
	Tue, 31 May 2022 15:01:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D03BBC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC770419F2
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7qrLB4JcKob for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 15:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7262419BC
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 15:01:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1597B23A;
 Tue, 31 May 2022 08:01:14 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8D43F73D;
 Tue, 31 May 2022 08:01:11 -0700 (PDT)
Message-ID: <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
Date: Tue, 31 May 2022 16:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531145301.GE1343366@nvidia.com>
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

On 2022-05-31 15:53, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
>> On 2022/5/31 21:10, Jason Gunthorpe wrote:
>>> On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
>>>
>>>> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
>>>> iommu_unmap() and dumping tables in debugfs exclusive. This does not
>>>> work because debugfs may depend on the DMA of the devices to work. It
>>>> seems that what we can do is to allow this race, but when we traverse
>>>> the page table in debugfs, we will check the validity of the physical
>>>> address retrieved from the page table entry. Then, the worst case is to
>>>> print some useless information.
>>>
>>> Sounds horrible, don't you have locking around the IOPTEs of some
>>> kind? How does updating them work reliably?
>>
>> There's no locking around updating the IOPTEs. The basic assumption is
>> that at any time, there's only a single thread manipulating the mappings
>> of the range specified in iommu_map/unmap() APIs. Therefore, the race
>> only exists when multiple ranges share some high-level IOPTEs. The IOMMU
>> driver updates those IOPTEs using the compare-and-exchange atomic
>> operation.
> 
> Oh? Did I miss where that was documented as part of the iommu API?
> 
> Daniel posted patches for VFIO to multi-thread iommu_domin mapping.
> 
> iommufd goes out of its way to avoid this kind of serialization so
> that userspace can parallel map IOVA.
> 
> I think if this is the requirement then the iommu API needs to
> provide a lock around the domain for the driver..

Eww, no, we can't kill performance by forcing serialisation on the 
entire API just for one silly driver-internal debugfs corner :(

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
