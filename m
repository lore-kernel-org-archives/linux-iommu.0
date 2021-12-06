Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C6C4332F
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03DEE400C9;
	Mon,  6 Dec 2021 14:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dFunLZuQ4rRq; Mon,  6 Dec 2021 14:30:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1696403BE;
	Mon,  6 Dec 2021 14:30:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA8EC001E;
	Mon,  6 Dec 2021 14:30:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 376EAC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18DFE40918
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUtB22j2wHbA for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:30:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A47E408F8
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wUoLiSn51OKyZKPLXHrwnmgPjRpnvpvyNU8vXyEVvE8=; b=il/9NTD05MPaaylKKrpQt7dzHY
 zRXxWas+vo63olsRGM5IHckhvmwDXk98hanMLtbb6G6BTqx/SBYZhyb0iJu1VHK8gMMFJg3/ii79E
 vkaK/17F0Gxg4Kz9YGlf7eUiQeE5b6L0CohSjfbMgZ5+I3GgHR2lUenGJ4VKKOp8PLPERyCTilzUQ
 NcTsKC59hEftqUDEmNZPvaofOh5AgkPoccTcIo/Prhs6+evpXQK7jTZrpVCDMXhynTDiTclNXaST7
 ZyQ2bRRXXrCecJJgNMesx9hpA5gBbnw8EcfoFlBzTs1srWc2Uk6+9Eqev46AHJz0LZ2kExspIggfr
 hZdb/3Sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1muF01-004Cm0-LS; Mon, 06 Dec 2021 14:29:49 +0000
Date: Mon, 6 Dec 2021 06:29:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 01/18] iommu: Add device dma ownership set/release
 interfaces
Message-ID: <Ya4eXZtdMGhEP7GO@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-2-baolu.lu@linux.intel.com>
 <Ya4Ru/GtILJYzI6j@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ya4Ru/GtILJYzI6j@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 06, 2021 at 02:35:55PM +0100, Joerg Roedel wrote:
> >                 enum iommu_dma_owner type, void *owner_cookie);
> >         void iommu_device_release_dma_owner(struct device *dev,
> >                 enum iommu_dma_owner type);
> 
> It the owner is a group-wide setting, it should be called with the group
> instead of the device. I have seen the group-specific funcitons are
> added later, but that leaves the question why the device-specific ones
> are needed at all.

They aren't really.  A lot of bus drivers need helpers to set/release
the dma API domain if there is an iommu group, but tegra which actually
sets a non-default value would be much better off with just open coding
them.

> > @@ -621,6 +624,7 @@ struct iommu_group *iommu_group_alloc(void)
> >  	INIT_LIST_HEAD(&group->devices);
> >  	INIT_LIST_HEAD(&group->entry);
> >  	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
> > +	group->dma_owner = DMA_OWNER_NONE;
> 
> 
> DMA_OWNER_NONE is also questionable. All devices are always in one
> domain, and the default domain is always the one used for DMA-API, so
> why isn't the initial value DMA_OWNER_DMA_API?

The interesting part is the suppress_auto_claim_dma_owner flag, but it
might make more sense to release the dma API ownership for that rather
than requesting it if it is not set.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
