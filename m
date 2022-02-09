Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F9C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 11:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD5C360B14;
	Wed,  9 Feb 2022 11:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4APGnw90-kB5; Wed,  9 Feb 2022 11:56:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F5AD60670;
	Wed,  9 Feb 2022 11:56:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E70CC001A;
	Wed,  9 Feb 2022 11:56:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B85C6C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 11:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D9A960A71
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 11:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s3XFgSISU0yn for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 11:56:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03C9B60670
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644407778; x=1675943778;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+Iyisy+Ou0kWFIqDJOqlqTBvzyz5qmeIE9EcOe5udqE=;
 b=HchcUZVa9fEyVSkFcMrjfkY+zeojjkdRRPJFT+8inYGcF2Xt2eY/WvcJ
 4QQsZeUjLqU8p1Ej7WXrgElVYbMjHxIXwgh0w6Qix5onswQO/6F1DnjiW
 L1dVqxTkuBEKdSzMDl6aQ6DqITZwt/W3lB9KrbT5ioHEGlVV86fYwTqjA
 xijYyVHI4L+0Jm1+4/6rqFbtGqbWngJPLGf2ZRRuNrSuqt4TYbmsZIE7e
 cTZaayVwMW5HmiGFVIc4JCrEF+3hEr0DRXisrM3MbgS7Tj3zjvsuQRbpp
 F8irsD2vFHMFaHfU4q8m9hb+fkmfeHynJVHN63HM2AtKM/EsGED9OfSjR w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="246771086"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; d="scan'208";a="246771086"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 03:56:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; d="scan'208";a="771321954"
Received: from smile.fi.intel.com ([10.237.72.61])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 03:56:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1nHlZ7-002bIz-6P; Wed, 09 Feb 2022 13:55:17 +0200
Date: Wed, 9 Feb 2022 13:55:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct
 assignment
Message-ID: <YgOrpC/Wg2MA7eRy@smile.fi.intel.com>
References: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
 <58e77093-51e2-59a2-e413-164d83ecd9b8@arm.com>
 <YgNoENf1EIFmaeDD@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgNoENf1EIFmaeDD@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
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

On Tue, Feb 08, 2022 at 11:06:56PM -0800, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 03:55:32PM +0000, Robin Murphy wrote:
> > On 2022-02-07 14:13, Andy Shevchenko wrote:
> > > Use DMA ops setter instead of direct assignment. Even we know that
> > > this module doesn't perform access to the dma_ops member of struct device,
> > > it's better to use setter to avoid potential problems in the future.
> > 
> > What potential problems are you imagining? This whole file is a DMA ops
> > implementation, not driver code (and definitely not a module); if anyone
> > removes the "select DMA_OPS" from CONFIG_IOMMU_DMA they deserve whatever
> > breakage they get.
> > 
> > I concur that there's no major harm in using the helper here, but I also see
> > no point in pretending that there's any value to abstracting the operation
> > in this particular context.
> 
> Yeah.  Killing off the the wrapper is actually on my todo list, mostly
> because it leads to people doing completely broken things like the VDPA
> private dma ops that should not exist.

Let's abandon this change. (I see that it's kinda 50/50 of the users
with API and without)

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
