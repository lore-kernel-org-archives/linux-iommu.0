Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635FBC2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 12:13:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AE820774
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 12:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uPEh7nQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AE820774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08AC2861F0;
	Thu, 16 Apr 2020 12:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-u1wrPmC0m9; Thu, 16 Apr 2020 12:13:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9742B85FC7;
	Thu, 16 Apr 2020 12:13:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E892C1AE8;
	Thu, 16 Apr 2020 12:13:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F09C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 12:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 90D8681B7D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 12:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ugxyWb3zulAa for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 12:13:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E12081AEB
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hp6+eCj2O2nxWa/wGv8G7WCsIo0VMT1PsA9CYyFBw9A=; b=uPEh7nQY1JKkhF8C0Y4y2Gmad+
 0Lh9YxbB3n3bpZKSCTfe6apdDsHEJQ8+1fnAfMJYOQ7Ql+RYgwCiCPEay95+4hAhiUPJevlzeX1fJ
 juawpIUiGFu5mfa45bPWKqLkW/n9s5rroA3MynnjLIq7Qat6n1jaBQx75J3NNZelUA4YrqkUuGVcz
 H4Y2Zaeu42mCsHRkgGXpP+lVm6OKcx1KkTmiiHaNW3oV6yz92qPAmnFt+DrohrYDUCVX35t3XPvgO
 I1F0/d5RJPxCiBLE4f1cc1WmYObAzPqAFWgla4SAq3SvBWHFY87AaCOmi+Lt3b0XoTejUhCJEzA40
 t2381FKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jP3Oe-0002ua-05; Thu, 16 Apr 2020 12:13:32 +0000
Date: Thu, 16 Apr 2020 05:13:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200416121331.GA18661@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416085402.GB1286150@myrica>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, linux-mm@kvack.org,
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

On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > > +	rcu_read_lock();
> > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > > +				       start, end - start);
> > > +	rcu_read_unlock();
> > > +}
> > 
> > What is the reason that the devices don't register their own notifiers?
> > This kinds of multiplexing is always rather messy, and you do it for
> > all the methods.
> 
> This sends TLB and ATC invalidations through the IOMMU, it doesn't go
> through device drivers

I don't think we mean the same thing, probably because of my rather
imprecise use of the word device.

What I mean is that the mmu_notifier should not be embedded into the
io_mm structure (whch btw, seems to have a way to generic name, just
like all other io_* prefixed names), but instead into the
iommu_bond structure.  That avoid the whole multiplexing layer.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
