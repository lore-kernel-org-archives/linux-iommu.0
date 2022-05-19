Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEAEC433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 21:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DF348416E;
	Thu, 19 May 2022 21:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J_n6XAfmm8yU; Thu, 19 May 2022 21:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 57B83841B0;
	Thu, 19 May 2022 21:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27DEBC0039;
	Thu, 19 May 2022 21:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E802C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 21:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2143C4252C
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 21:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVhsUruBin2F for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 21:01:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F5F042524
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652994114; x=1684530114;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DYCIsdHXjqyWWTpU5Mo1OkWS4PvlHDtGprxIbJ0rp/g=;
 b=XEWxFJRRxqk9LiEy6MIn6ynPQouQJBdqiUXA3igkKVoK7U5YAVcQqDOh
 UflIe+Aq06ZTmGXJbOYonHs+ycZPuvlGkImHaqcDRyCnN5a/L8Dk4AylB
 HhyLRRqNnY3pDbvlchPQx/yibpso+iphHtjj/3Pc+UWbWkfawDvWyDzZ+
 uBDILPvrvcqW0uV1wfJ8pQYJME9k9xUV8z3+8XVojOwTrGAxlhM3i64Lp
 KMcP33OXzSwOISgr/+t71rfuwzvu6znrvNVtDDRi6f2jqoGfZOTi3upVp
 xmO6vjtwRdD9iJlfICPxZRL7EWqzlcWBI+pgABtF4i8RAO99gQ7kgc9yH Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297686197"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; d="scan'208";a="297686197"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 14:01:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; d="scan'208";a="743129020"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 14:01:53 -0700
Date: Thu, 19 May 2022 14:05:43 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 1/4] iommu/vt-d: Implement domain ops for
 attach_dev_pasid
Message-ID: <20220519140543.1b43ef85@jacob-builder>
In-Reply-To: <20220518185205.GT1343366@nvidia.com>
References: <20220510232121.GP49344@nvidia.com>
 <20220510172309.3c4e7512@jacob-builder>
 <20220511115427.GU49344@nvidia.com>
 <20220511082958.79d5d8ee@jacob-builder>
 <20220511161237.GB49344@nvidia.com>
 <20220511100216.7615e288@jacob-builder>
 <20220511170025.GF49344@nvidia.com>
 <20220511102521.6b7c578c@jacob-builder>
 <20220511182908.GK49344@nvidia.com>
 <20220518114204.4d251b41@jacob-builder>
 <20220518185205.GT1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, robin.murphy@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jason,

On Wed, 18 May 2022 15:52:05 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 18, 2022 at 11:42:04AM -0700, Jacob Pan wrote:
> 
> > > Yes.. It seems inefficient to iterate over that xarray multiple times
> > > on the flush hot path, but maybe there is little choice. Try to use
> > > use the xas iterators under the xa_lock spinlock..
> > >   
> > xas_for_each takes a max range, here we don't really have one. So I
> > posted v4 w/o using the xas advanced API. Please let me know if you have
> > suggestions.  
> 
> You are supposed to use ULONG_MAX in cases like that.
> 
got it.
> > xa_for_each takes RCU read lock, it should be fast for tlb flush,
> > right? The worst case maybe over flush when we have stale data but
> > should be very rare.  
> 
> Not really, xa_for_each walks the tree for every iteration, it is
> slower than a linked list walk in any cases where the xarray is
> multi-node. xas_for_each is able to retain a pointer where it is in
> the tree so each iteration is usually just a pointer increment.
> 
Thanks for explaining, yeah if we have to iterate multiple times
xas_for_each() is better.

> The downside is you cannot sleep while doing xas_for_each
> 
will do under RCU read lock

> > > The challenge will be accessing the group xa in the first place, but
> > > maybe the core code can gain a function call to return a pointer to
> > > that XA or something..  
>  
> > I added a helper function to find the matching DMA API PASID in v4.  
> 
> Again, why are we focused on DMA API? Nothing you build here should be
> DMA API beyond the fact that the iommu_domain being attached is the
> default domain.
The helper is not DMA API specific. Just a domain-PASID look up. Sorry for
the confusion.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
