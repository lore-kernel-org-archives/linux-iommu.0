Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18387C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 12:28:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9475D233F9
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 12:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9475D233F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED5F686481;
	Wed, 13 Jan 2021 12:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VxbDHNjWBhwX; Wed, 13 Jan 2021 12:28:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6E2AF86475;
	Wed, 13 Jan 2021 12:28:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61E2EC088B;
	Wed, 13 Jan 2021 12:28:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF0CC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E87342A0D9
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDc7I7nBIzvv for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 12:27:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 8809C27A4E
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:27:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45BAB2313E;
 Wed, 13 Jan 2021 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1610540878;
 bh=DMT/14eqvz5zf53FuIMip/3tOpUYx9AeGju+aNpk6Tg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RIeWKwdCzel81a5/+igwlQa7a96S4uuDSVMhO/TwoBeDkIRVbX+C6VT/zl3DHzGuy
 TN7OjM0+Zieesb8xP+RgbKU5rKX0cUd7nzCdBCw4R29wCGdqUIBnkZaVV1OJ6+Cnca
 DxODljnCCEJbvE8Rkq5e8BMdF1IFL/e9Km/FCSDg=
Date: Wed, 13 Jan 2021 13:29:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Message-ID: <X/7nkb/YDpKlakRO@kroah.com>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
 <X/VrqxcaAMi65CF0@kroah.com> <20210113115126.GB29376@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210113115126.GB29376@lst.de>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 frowand.list@gmail.com, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, xypron.glpk@gmx.de, rafael.j.wysocki@intel.com,
 bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org, treding@nvidia.com,
 devicetree@vger.kernel.org, will@kernel.org, konrad.wilk@oracle.com,
 dan.j.williams@intel.com, robh+dt@kernel.org,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 andriy.shevchenko@linux.intel.com, jgross@suse.com, drinkcat@chromium.org,
 linuxppc-dev@lists.ozlabs.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mpe@ellerman.id.au, robin.murphy@arm.com
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

On Wed, Jan 13, 2021 at 12:51:26PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 06, 2021 at 08:50:03AM +0100, Greg KH wrote:
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -413,6 +413,7 @@ struct dev_links_info {
> > >   * @dma_pools:	Dma pools (if dma'ble device).
> > >   * @dma_mem:	Internal for coherent mem override.
> > >   * @cma_area:	Contiguous memory area for dma allocations
> > > + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
> > 
> > Why does this have to be added here?  Shouldn't the platform-specific
> > code handle it instead?
> 
> The whole code added here is pretty generic.  What we need to eventually
> do, though is to add a separate dma_device instead of adding more and more
> bloat to struct device.

I have no objections for that happening!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
