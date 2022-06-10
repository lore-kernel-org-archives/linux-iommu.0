Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93979C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 05:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 380B9419B5;
	Fri, 10 Jun 2022 05:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EfDJ5s-Zi6P2; Fri, 10 Jun 2022 05:59:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C99CB419A1;
	Fri, 10 Jun 2022 05:59:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904E4C0039;
	Fri, 10 Jun 2022 05:59:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 571E6C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 376DF419B5
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9vTEe0I_Bxch for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 05:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52377419A1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654840792; x=1686376792;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bi5/vUaFBJ5/BUicsPXQdGCHavfxj1TbsC4ptkwormA=;
 b=XEJZo8XZaytF1YMgzJ0vPv2PNda9WNoY04EqxCYzkUaZ9O3TUYVxsUxV
 ejd+48/tJAV+jM/wHqyj+vCjI7xtvqiXwMsv+eBfu9WNf++PIGlDY2zey
 4vZ0N1VhQP5JyRQ2H/kK3LOvULR1pneYttAVmpQ4a37f+MVVcP3S+20d6
 TQ96qt6AdZmJ4Ji5V1rvHRuomqmVN28Gvse0M9LYiqoKr1bXk3mbt/DzR
 FIN7+BERurZ1jZwKZhXlexGqg+pn7XIFmsJ7LuMMkGT6LZ/nJ1uQATvov
 vjutEWBjB72AnT5nXvxtGPifiF7Oyr6MZbtgZ1cqM0t3nhibCSKmjoBFr w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266295551"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="266295551"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 22:59:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="637952801"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148])
 ([10.249.169.148])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 22:59:32 -0700
Message-ID: <df138613-c098-031f-e906-6599ed1076f9@linux.intel.com>
Date: Fri, 10 Jun 2022 13:59:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <9a339b42-2993-f7e2-3122-764a486e796f@arm.com>
 <20220609133234.GA1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609133234.GA1343366@nvidia.com>
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

On 2022/6/9 21:32, Jason Gunthorpe wrote:
> On Thu, Jun 09, 2022 at 02:19:06PM +0100, Robin Murphy wrote:
> 
>> Is there a significant benefit to keeping both paths, or could we get away
>> with just always using RCU? Realistically, pagetable pages aren't likely to
>> be freed all that frequently, except perhaps at domain teardown, but that
>> shouldn't really be performance-critical, and I guess we could stick an RCU
>> sync point in iommu_domain_free() if we're really worried about releasing
>> larger quantities of pages back to the allocator ASAP?
> 
> I think you are right, anything that uses the iommu_iotlb_gather may
> as well use RCU too.
> 
> IIRC the allocators already know that RCU is often sitting on
> freed-memory and have some contigency to flush it out before OOMing,
> so nothing special should be needed.

Fair enough. How about below code?

static void pgtble_page_free_rcu(struct rcu_head *rcu)
{
         struct page *page = container_of(rcu, struct page, rcu_head);

         __free_pages(page, 0);
}

/*
  * Free pages gathered in the freelist of iommu_iotlb_gather. Use RCU free
  * way so that it's safe for lock-free page table walk.
  */
void iommu_free_iotlb_gather_pages(struct iommu_iotlb_gather *iotlb_gather)
{
         struct page *page, *next;

         list_for_each_entry_safe(page, next, &iotlb_gather->freelist, 
lru) {
                 list_del(&page->lru);
                 call_rcu(&page->rcu_head, pgtble_page_free_rcu);
         }
}

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
