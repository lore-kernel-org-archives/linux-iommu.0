Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D81CCA479
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 02:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 756E283FA4;
	Thu, 16 Jun 2022 02:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8puzfluWEQTV; Thu, 16 Jun 2022 02:27:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6702483FA6;
	Thu, 16 Jun 2022 02:27:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41F32C0032;
	Thu, 16 Jun 2022 02:27:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37FC7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 02:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 187CD418F5
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 02:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXIbZeqPrlOR for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 02:27:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4712F4109F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 02:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655346428; x=1686882428;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+zsE1yD1mIDCXQBJJ5Ri010dHnoDRkJfwr7YyFuCg+U=;
 b=BEiyW4bSbJQDByUJBeuz5eDh86ZUEvSG6Tpsged+vbAInULtJetcIkkE
 yVMQEOtsncXlXc22EFKAZugl7WXYqNGDrSJpYUdVHqZi2+3UZGWuL3PN8
 BsYljOaA+S3T2c4bMVUY6B7BYJGDWtCmaRRIfOJlAJPtD1Mdgz2bmjhhs
 W2w+wOqvT2FDf05Ubqu+cR3gAGev+Qh7U+OeEfdY5sqEAf4HIHfEXFoIS
 odc5cDzSZQW8TPzmjbfyQY1JIZJwh/MtmnEvCwsOVGNyV9hJiQY/Ub6c+
 eloNnZ93P+nHG6aK5dmzcaHuEj68z9tJ2y6zI25yFR+FqdTRXqw/gDMOi g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304586933"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="304586933"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 19:27:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="831361599"
Received: from yuefengs-mobl.ccr.corp.intel.com (HELO [10.255.30.105])
 ([10.255.30.105])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 19:27:04 -0700
Message-ID: <6b8a4728-62c0-edb2-7b13-c4f01f5dc41a@linux.intel.com>
Date: Thu, 16 Jun 2022 10:27:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
 <20220615154040.GA4927@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220615154040.GA4927@nvidia.com>
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

On 2022/6/15 23:40, Jason Gunthorpe wrote:
> On Fri, Jun 10, 2022 at 01:37:20PM +0800, Baolu Lu wrote:
>> On 2022/6/9 20:49, Jason Gunthorpe wrote:
>>>> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
>>>> +			    struct list_head *pages)
>>>> +{
>>>> +	struct page *page, *next;
>>>> +
>>>> +	if (!domain->concurrent_traversal) {
>>>> +		put_pages_list(pages);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	list_for_each_entry_safe(page, next, pages, lru) {
>>>> +		list_del(&page->lru);
>>>> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
>>>> +	}
>>> It seems OK, but I wonder if there is benifit to using
>>> put_pages_list() from the rcu callback
>>
>> The price is that we need to allocate a "struct list_head" and free it
>> in the rcu callback as well. Currently the list_head is sitting in the
>> stack.
> 
> You'd have to use a different struct page layout so that the list_head
> was in the struct page and didn't overlap with the rcu_head

Okay, let me head this direction in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
