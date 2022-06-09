Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92364C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 13:19:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2724683FF2;
	Thu,  9 Jun 2022 13:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIt-UrO6DUFM; Thu,  9 Jun 2022 13:19:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD76581AC1;
	Thu,  9 Jun 2022 13:19:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DEEDC0032;
	Thu,  9 Jun 2022 13:19:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 293BFC002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 13:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AFB181AC1
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 13:19:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pEMVMWvlrb9u for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 13:19:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42CA781A3B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 13:19:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8928B12FC;
 Thu,  9 Jun 2022 06:19:14 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55F5D3F73B;
 Thu,  9 Jun 2022 06:19:12 -0700 (PDT)
Message-ID: <9a339b42-2993-f7e2-3122-764a486e796f@arm.com>
Date: Thu, 9 Jun 2022 14:19:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220609124934.GZ1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
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

On 2022-06-09 13:49, Jason Gunthorpe wrote:
> On Thu, Jun 09, 2022 at 03:08:10PM +0800, Lu Baolu wrote:
>> The IOMMU page tables are updated using iommu_map/unmap() interfaces.
>> Currently, there is no mandatory requirement for drivers to use locks
>> to ensure concurrent updates to page tables, because it's assumed that
>> overlapping IOVA ranges do not have concurrent updates. Therefore the
>> IOMMU drivers only need to take care of concurrent updates to level
>> page table entries.
>>
>> But enabling new features challenges this assumption. For example, the
>> hardware assisted dirty page tracking feature requires scanning page
>> tables in interfaces other than mapping and unmapping. This might result
>> in a use-after-free scenario in which a level page table has been freed
>> by the unmap() interface, while another thread is scanning the next level
>> page table.
>>
>> This adds RCU-protected page free support so that the pages are really
>> freed and reused after a RCU grace period. Hence, the page tables are
>> safe for scanning within a rcu_read_lock critical region. Considering
>> that scanning the page table is a rare case, this also adds a domain
>> flag and the RCU-protected page free is only used when this flat is set.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h |  9 +++++++++
>>   drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 5e1afe169549..6f68eabb8567 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -95,6 +95,7 @@ struct iommu_domain {
>>   	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	unsigned long concurrent_traversal:1;
>>   };
>>   
>>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> @@ -657,6 +658,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>>   	dev->iommu->priv = priv;
>>   }
>>   
>> +static inline void domain_set_concurrent_traversal(struct iommu_domain *domain,
>> +						   bool value)
>> +{
>> +	domain->concurrent_traversal = value;
>> +}
> 
> ?? If you want it to be a driver opt in I would just add a flags to
> the domain ops. "DOMAIN_FLAG_RCU_FREE_PAGES"

Is there a significant benefit to keeping both paths, or could we get 
away with just always using RCU? Realistically, pagetable pages aren't 
likely to be freed all that frequently, except perhaps at domain 
teardown, but that shouldn't really be performance-critical, and I guess 
we could stick an RCU sync point in iommu_domain_free() if we're really 
worried about releasing larger quantities of pages back to the allocator 
ASAP?

It's already a driver opt-in to use the iommu_iotlb_gather freelist in 
the first place, and right now the ones that do are also the ones that 
do lock-free table walks so will ultimately all want this as well.

Robin.

>> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
>> +			    struct list_head *pages)
>> +{
>> +	struct page *page, *next;
>> +
>> +	if (!domain->concurrent_traversal) {
>> +		put_pages_list(pages);
>> +		return;
>> +	}
>> +
>> +	list_for_each_entry_safe(page, next, pages, lru) {
>> +		list_del(&page->lru);
>> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
>> +	}
> 
> It seems OK, but I wonder if there is benifit to using
> put_pages_list() from the rcu callback
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
