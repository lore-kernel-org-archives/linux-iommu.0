Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3FBC43334
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 05:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A28540A93;
	Fri, 10 Jun 2022 05:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2wAE6J5OQoW; Fri, 10 Jun 2022 05:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3052C4023B;
	Fri, 10 Jun 2022 05:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6B34C0039;
	Fri, 10 Jun 2022 05:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0A86C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF0F461192
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvFfH6g5cHX1 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 05:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6C8160FAE
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654839445; x=1686375445;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6a8QudFS6MG+aPxhpladdSOsdGbNDj5qg8atPxMfEDg=;
 b=KTQEOsFnQWBCrlt0hn38ofXps6N2upeidNgywiOqeha2eBhFEy945t+6
 Tp6xdtYKIA9plbkGmKV3DkOzQqm4zP1oDpZEikRFeZctLyD68yZZ8yImp
 IotSlCv0CkPBnqACC7WAnO/wJDYBT9vpJmvR2vrJmHaevRDSFfaUuXK2u
 5qMkq8L+8yXqmvO8gU7qBUTi3PbPCpnqzKxUgamAez098yaV3LTvl4Kra
 Kf95SAvBdmZ1JZvq6qk0dP7GW23DyJsZ9atkl0jcLjPEj6BgHo97JqtGN
 xlxcTCp4Z431POU/tMcRPJmDEkbF2SJIQ1LuhcvbABD3TFtcF7WAIj79I Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302896712"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="302896712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 22:37:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="637944554"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148])
 ([10.249.169.148])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 22:37:22 -0700
Message-ID: <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
Date: Fri, 10 Jun 2022 13:37:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609124934.GZ1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Joao Martins <joao.m.martins@oracle.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/6/9 20:49, Jason Gunthorpe wrote:
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
> It seems OK, but I wonder if there is benifit to using
> put_pages_list() from the rcu callback

The price is that we need to allocate a "struct list_head" and free it
in the rcu callback as well. Currently the list_head is sitting in the
stack.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
