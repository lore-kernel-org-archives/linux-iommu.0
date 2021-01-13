Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53824C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 12:42:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951CC2339F
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 12:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951CC2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0D8DD2D3FC;
	Wed, 13 Jan 2021 12:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B+pdCz3vHGla; Wed, 13 Jan 2021 12:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18B032A16D;
	Wed, 13 Jan 2021 12:42:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDDB0C088B;
	Wed, 13 Jan 2021 12:42:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7DDAC013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D59EE87190
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgYGSjYV6phP for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 12:42:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67FB48715E
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 12:42:14 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3EA2768B02; Wed, 13 Jan 2021 13:42:09 +0100 (CET)
Date: Wed, 13 Jan 2021 13:42:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Message-ID: <20210113124209.GA1383@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-3-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 frowand.list@gmail.com, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, mpe@ellerman.id.au, rafael.j.wysocki@intel.com,
 hch@lst.de, bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org,
 treding@nvidia.com, devicetree@vger.kernel.org, will@kernel.org,
 konrad.wilk@oracle.com, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org, boris.ostrovsky@oracle.com,
 andriy.shevchenko@linux.intel.com, jgross@suse.com, drinkcat@chromium.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 xypron.glpk@gmx.de, robin.murphy@arm.com
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

> +#ifdef CONFIG_SWIOTLB
> +	struct io_tlb_mem	*dma_io_tlb_mem;
>  #endif

Please add a new config option for this code instead of always building
it when swiotlb is enabled.

> +static int swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> +				   size_t size)

Can you split the refactoring in swiotlb.c into one or more prep
patches?

> +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> +				    struct device *dev)
> +{
> +	struct io_tlb_mem *mem = rmem->priv;
> +	int ret;
> +
> +	if (dev->dma_io_tlb_mem)
> +		return -EBUSY;
> +
> +	if (!mem) {
> +		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +		if (!mem)
> +			return -ENOMEM;

What is the calling convention here that allows for a NULL and non-NULL
private data?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
