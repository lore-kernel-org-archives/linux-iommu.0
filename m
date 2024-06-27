Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7F3BB2E
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468179; cv=none; b=eEC0wUdwCqFLWO+C87QSM4u7JcoDnbI8gPzxfZjhCyAlaBCFy0X/dyFAVOnvXM7Gna1A3sKmO78uOPQTbwpHWx52wQtLIovGgn+6Od9b9r5vAdJvFmIOXfvjPbLQXohFATcSzTeoWg9cbKA+SPN0CeRCPNxuuS56YSnQ2Qy/0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468179; c=relaxed/simple;
	bh=Zu/USSLLVzlQjjX5Yb1F5XViHJe9mbKAsxNppsIim3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6d6js0Vr9tnd0MrsAKdArBi/h7mAg73Qt/KxhKEEwZoc1d4JfQwi8+FWEDIo/N3hZ+1IBOIb8HdJtY2AhyHnylgUtCKsofT5IQjOFXCgfuYIHffPUyADDTvw5HAcR7dhHw99H+Cp9LiF976jKSxqxW2b/SIeTRF3G8wC5xDY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65F8768C4E; Thu, 27 Jun 2024 08:02:52 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:02:51 +0200
From: "hch@lst.de" <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Message-ID: <20240627060251.GA15590@lst.de>
References: <20240607031421.182589-1-mhklinux@outlook.com> <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 26, 2024 at 11:58:13PM +0000, Michael Kelley wrote:
> > This patch trades off making many of the core swiotlb APIs take
> > an additional argument in order to avoid duplicating calls to
> > swiotlb_find_pool(). The current code seems rather wasteful in
> > making 6 calls per round-trip, but I'm happy to accept others'
> > judgment as to whether getting rid of the waste is worth the
> > additional code complexity.
> 
> Quick ping on this RFC.  Is there any interest in moving forward?
> Quite a few lines of code are affected because of adding the
> additional "pool" argument to several functions, but the change
> is conceptually pretty simple.

Yes, this looks sensible to me.  I'm tempted to apply it.

