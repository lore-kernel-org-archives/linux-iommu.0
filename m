Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12391C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 18:32:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F51233ED
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 18:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F51233ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CA3F84DBD;
	Wed, 13 Jan 2021 18:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1pFhDbLMmOv6; Wed, 13 Jan 2021 18:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E3F76843BD;
	Wed, 13 Jan 2021 18:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC9F7C088B;
	Wed, 13 Jan 2021 18:32:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFB65C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A334C203D9
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e8JqQa1lV26n for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 18:32:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 97257203D2
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:32:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A66E868B02; Wed, 13 Jan 2021 19:32:19 +0100 (CET)
Date: Wed, 13 Jan 2021 19:32:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v3 4/6] swiotlb: Add restricted DMA alloc/free support.
Message-ID: <20210113183218.GB19254@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-5-tientzu@chromium.org> <20210113124847.GC1383@lst.de>
 <82bb75bc-11e6-ac94-9d24-7c896e3aae98@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82bb75bc-11e6-ac94-9d24-7c896e3aae98@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 frowand.list@gmail.com, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, xypron.glpk@gmx.de, rafael.j.wysocki@intel.com,
 Christoph Hellwig <hch@lst.de>, bgolaszewski@baylibre.com,
 xen-devel@lists.xenproject.org, treding@nvidia.com, devicetree@vger.kernel.org,
 will@kernel.org, konrad.wilk@oracle.com, dan.j.williams@intel.com,
 robh+dt@kernel.org, Claire Chang <tientzu@chromium.org>,
 boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, jgross@suse.com,
 drinkcat@chromium.org, gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
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

On Wed, Jan 13, 2021 at 06:27:08PM +0000, Robin Murphy wrote:
>> Can we hook in somewhat lower level in the dma-direct code so that all
>> the remapping in dma-direct can be reused instead of duplicated?  That
>> also becomes important if we want to use non-remapping uncached support,
>> e.g. on mips or x86, or the direct changing of the attributes that Will
>> planned to look into for arm64.
>
> Indeed, AFAICS this ought to boil down to a direct equivalent of 
> __dma_direct_alloc_pages() - other than the address there should be no 
> conceptual difference between pages from the restricted pool and those from 
> the regular page allocator, so this probably deserves to be plumbed in as 
> an alternative to that.

Yes, that's what I mean.  You managed to word it much better, though.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
