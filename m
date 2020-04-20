Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CBC3A5A0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:15:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F71721D79
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 18:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F71721D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4140886914;
	Mon, 20 Apr 2020 18:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BMtoA2IfNxDX; Mon, 20 Apr 2020 18:15:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D85D86911;
	Mon, 20 Apr 2020 18:15:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46577C1D74;
	Mon, 20 Apr 2020 18:15:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D04C1C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BE33287F3F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qWa6THK9YF0d for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 18:15:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CFF4D87F12
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 18:15:22 +0000 (UTC)
IronPort-SDR: l5PHZwrc7gRn3+bkJcLX7B8H8wrLJDVE6R5Sl6GvP1zYYvYWTwCg8FmzrHfEZ7VlTZt7Fih3Wk
 eRBkiCbV89+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 11:15:22 -0700
IronPort-SDR: 8fT09weErfTNfN3mfjnYSebk8Nn+HR58tGa0lnQIUlEHvLqz6923WibZ88j62ipIrGurCIktai
 4d4uQqkvArDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; d="scan'208";a="246960869"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2020 11:15:21 -0700
Date: Mon, 20 Apr 2020 11:14:37 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420181437.GA229170@romley-ivt3.sc.intel.com>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica> <20200420135727.GO26002@ziepe.ca>
 <20200420104850.60531cb6@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200420104850.60531cb6@jacob-builder>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, christian.koenig@amd.com,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Apr 20, 2020 at 10:48:50AM -0700, Jacob Pan wrote:
> On Mon, 20 Apr 2020 10:57:27 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> > > On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:  
> > > > On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker
> > > > wrote:  
> > > > > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig
> > > > > wrote:  
> > > > > > > +	rcu_read_lock();
> > > > > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices,
> > > > > > > mm_node)
> > > > > > > +		io_mm->ops->invalidate(bond->sva.dev,
> > > > > > > io_mm->pasid, io_mm->ctx,
> > > > > > > +				       start, end - start);
> > > > > > > +	rcu_read_unlock();
> > > > > > > +}  
> > > > > > 
> > > > > > What is the reason that the devices don't register their own
> > > > > > notifiers? This kinds of multiplexing is always rather messy,
> > > > > > and you do it for all the methods.  
> > > > > 
> > > > > This sends TLB and ATC invalidations through the IOMMU, it
> > > > > doesn't go through device drivers  
> > > > 
> > > > I don't think we mean the same thing, probably because of my
> > > > rather imprecise use of the word device.
> > > > 
> > > > What I mean is that the mmu_notifier should not be embedded into
> > > > the io_mm structure (whch btw, seems to have a way to generic
> > > > name, just like all other io_* prefixed names), but instead into
> > > > the iommu_bond structure.  That avoid the whole multiplexing
> > > > layer.  
> > > 
> > > Right, I can see the appeal. I still like having a single mmu
> > > notifier per mm because it ensures we allocate a single PASID per
> > > mm (as required by x86). I suppose one alternative is to maintain a
> > > hashtable of mm->pasid, to avoid iterating over all bonds during
> > > allocation.  
> > 
> > I've been getting rid of hash tables like this.. Adding it to the
> > mm_struct does seem reasonable, I think PASID is a pretty broad
> > concept now.
> > 
> Agreed, perhaps Fenghua can consider that in his patchset. It would
> help align life cycles as well.
> https://lkml.org/lkml/2020/3/30/910>

Seems we depend on each other: my patch defines pasid in mm_struct.
I can free PASID in your detach() function.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
