Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367FFC3A5A9
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 15:16:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B9F206D7
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 15:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B9F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD48C88607;
	Mon,  4 May 2020 15:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFAYf-J-PWtn; Mon,  4 May 2020 15:16:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1BB0888191;
	Mon,  4 May 2020 15:16:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 020FDC088A;
	Mon,  4 May 2020 15:16:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5585FC0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5198C88356
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iH1zpruveKL for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 15:16:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6B9348829A
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 15:16:51 +0000 (UTC)
IronPort-SDR: AVaGWpO3X5S7m7T5qzRlSnvNv5vasxVk8FYu2nioo64BAT0qnnBMswIK9Prwab39vmJ+Mzmwhd
 QQG/v6XfFfzw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2020 08:16:50 -0700
IronPort-SDR: lbqFDd9ohl9UbGCAK3Z4qWu4DHUOOqZWdbnTKo7EqSLIl5b7BXj9EsadFkTvIWkTXLcabMfBey
 htWBEGm4tgiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; d="scan'208";a="295526651"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 04 May 2020 08:16:49 -0700
Date: Mon, 4 May 2020 08:22:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200504082254.58fc6365@jacob-builder>
In-Reply-To: <20200504143932.GC170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
 <20200430113931.0fbf7a37@jacob-builder>
 <20200430134842.74e596b8@jacob-builder>
 <20200504143932.GC170104@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
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

On Mon, 4 May 2020 16:39:32 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Apr 30, 2020 at 01:48:42PM -0700, Jacob Pan wrote:
> > On Thu, 30 Apr 2020 11:39:31 -0700
> > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> >   
> > > > -void ioasid_free(ioasid_t ioasid)
> > > > +bool ioasid_free(ioasid_t ioasid)
> > > >  {  
> > Sorry I missed this in the last reply.
> > 
> > I think free needs to be unconditional since there is not a good
> > way to fail it.
> > 
> > Also can we have more symmetric APIs, seems we don't have
> > ioasid_put() in this patchset.  
> 
> Yes I was thinking of renaming ioasid_free() to ioasid_put() but got
> lazy. 
> 
> > How about?
> > ioasid_alloc()
> > ioasid_free(); //drop reference, mark inactive, but not reclaimed if
> > 		refcount is not zero.
> > ioasid_get() // returns err if the ioasid is marked inactive by
> > 		ioasid_free()  
> 
> How does the caller know that the ioasid is in active/inactive state,
> and not freed/reallocated?
> 
In inactive state, callers of ioasid_find(), ioasid_get() would all
fail. Only ioasid_put can still operate on it.

In freed state (i.e. not allocated), it will be the same as above with
the exception that ioasid_put has no effect.

> > ioasid_put();// drop reference, reclaim if refcount is 0.  
> 
> I'll add ioasid_put() for now. I'd like to avoid introducing the
> inactive state in this patch,
Sounds good. I just wanted to consult with you about the above APIs. I
will introduce the state when we have a real use.

> so shall I change the calls in the
> Intel driver to ioasid_put(), and not introduce a new ioasid_free()
> for the moment?
> 
Sounds good. 

> Thanks,
> Jean
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
