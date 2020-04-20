Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B2C38A30
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 17:43:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B77920BED
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B77920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 68CD320762;
	Mon, 20 Apr 2020 17:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVg8i4Gmes0z; Mon, 20 Apr 2020 17:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 94939204F6;
	Mon, 20 Apr 2020 17:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 875A1C07FF;
	Mon, 20 Apr 2020 17:43:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C019C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 17:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 66AD286BDB
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 17:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xdjiKSxnn3iK for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 17:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A8F3786B53
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 17:42:55 +0000 (UTC)
IronPort-SDR: 2b0DhP64zg2WSUr1A3eLCCHpTnwpnuPUXcZQ3Ra2BgXHOIdnkzXkl/QmZhuj7lggY4AgjiODvc
 w3iXK7vMY8Lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 10:42:54 -0700
IronPort-SDR: eM/j/RrA0dBjUaYVKE+3++Tb85wNGqjGC5Sdurj8El2Xw1ycvBFzcuEk1vr5nmoJeb1Oix9ZJQ
 KqoHCv3cjXTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; d="scan'208";a="246953658"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2020 10:42:53 -0700
Date: Mon, 20 Apr 2020 10:48:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420104850.60531cb6@jacob-builder>
In-Reply-To: <20200420135727.GO26002@ziepe.ca>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica> <20200420135727.GO26002@ziepe.ca>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, "Yu,
 Fenghua" <fenghua.yu@intel.com>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 20 Apr 2020 10:57:27 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> > On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:  
> > > On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker
> > > wrote:  
> > > > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig
> > > > wrote:  
> > > > > > +	rcu_read_lock();
> > > > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices,
> > > > > > mm_node)
> > > > > > +		io_mm->ops->invalidate(bond->sva.dev,
> > > > > > io_mm->pasid, io_mm->ctx,
> > > > > > +				       start, end - start);
> > > > > > +	rcu_read_unlock();
> > > > > > +}  
> > > > > 
> > > > > What is the reason that the devices don't register their own
> > > > > notifiers? This kinds of multiplexing is always rather messy,
> > > > > and you do it for all the methods.  
> > > > 
> > > > This sends TLB and ATC invalidations through the IOMMU, it
> > > > doesn't go through device drivers  
> > > 
> > > I don't think we mean the same thing, probably because of my
> > > rather imprecise use of the word device.
> > > 
> > > What I mean is that the mmu_notifier should not be embedded into
> > > the io_mm structure (whch btw, seems to have a way to generic
> > > name, just like all other io_* prefixed names), but instead into
> > > the iommu_bond structure.  That avoid the whole multiplexing
> > > layer.  
> > 
> > Right, I can see the appeal. I still like having a single mmu
> > notifier per mm because it ensures we allocate a single PASID per
> > mm (as required by x86). I suppose one alternative is to maintain a
> > hashtable of mm->pasid, to avoid iterating over all bonds during
> > allocation.  
> 
> I've been getting rid of hash tables like this.. Adding it to the
> mm_struct does seem reasonable, I think PASID is a pretty broad
> concept now.
> 
Agreed, perhaps Fenghua can consider that in his patchset. It would
help align life cycles as well.
https://lkml.org/lkml/2020/3/30/910

> Jason

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
