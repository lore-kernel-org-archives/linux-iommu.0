Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4CBE4A;
	Fri, 27 Jun 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028736; cv=none; b=lhOBJS65eHdDPLT5/AMKTK7u5CLY6yB+ry9XGqYiCets9b3Ch0JHxokRM9U41zxE9xmIVPwl9kCQ0Bklmafy6+vdU5mnjNCNrT1k1CNzMWjFtHgQeEcDbmVdfP0o2FsfU+slmU2POBIG2jipR4NF2jPLDpEF8f66pQLgncZJZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028736; c=relaxed/simple;
	bh=v9xhDsJzTPpFAaoavqodrapuBNsZPtcNMS/8GB5SjiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9gGy0lMEN5Xj1min2asxXTMim4bTgazjvGy1mKzOfgQjxL6MT8oNdAFrpvJdmJuJUHT9Ez64zNoIq6e4uP8lWYfkgOW5he91Mu1JOiV3hWBuz8RSik26QOhUXqPUZ9GlwajTNFOmH1qEa7ztj7RF7nvkJ84TEZ+mNE5aI7CToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xOv+RcMC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xOv+RcMC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pP/26raY4vF6ka9sJwOSt6+UnCQ4YRdYQywoxoRyAXU=; b=xOv+RcMCuod52byNjnoE46y//f
	XVlg9Zp8Z1DJm/V8mLlhWk8vk27jzb5phcHVO8CpNULnTagZmV3H+SGj/Vv7s5lBkMWBIyNLhhACD
	sqYDdAdq1xOYvROyPtG9jv0TUY8fauLs3hig+T4r53zbE8hCzKTgV/uQgZeW3i23iinr0vFB6ZcJo
	hc/zvKOLbh3SiRd4cOSuWgR/0f8Inep8yUGVrxTCVLVYPDJL92gJdQVlf2ifOq+YKwfo5q9RWMD67
	wBFJ6qd/w24LrCag62kDDG02Z5DPkTG9PAS+n9yR9ZMJUpsAtesUvP0JKzdGlRhZu0wjW2tJZa471
	aWx224IQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV8Yq-0000000Eh9P-04VD;
	Fri, 27 Jun 2025 12:52:08 +0000
Date: Fri, 27 Jun 2025 05:52:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin@web.codeaurora.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	John Garry <john.g.garry@oracle.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <aF6T9-iUWMVx4DyK@infradead.org>
References: <20250624133923.1140421-1-ptesarik@suse.com>
 <20250624133923.1140421-8-ptesarik@suse.com>
 <aFynHWAYtKPFT55P@archie.me>
 <20250626070602.3d42b607@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626070602.3d42b607@mordecai.tesarici.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 26, 2025 at 07:06:02AM +0200, Petr Tesarik wrote:
> @Marek, @Robin Do you agree that device drivers should not be concerned
> about the physical address of a buffer passed to the streaming DMA API?
> 
> I mean, are there any real-world systems with:
>   * some RAM that is not DMA-addressable,
>   * no IOMMU,
>   * CONFIG_SWIOTLB is not set?
> 
> FWIW if _I_ received a bug report that a device driver fails to submit
> I/O on such a system, I would politely explain the reporter that their
> kernel is misconfigured, and they should enable CONFIG_SWIOTLB.

Modulo the case of < 32-bit (or 31-bit for some systems) case the
general idea was that the iommu API always works except for temporary
resource shortages.  Now if you configure without SWIOTLB on system
that would otherwise need it you gotta keep the pieces.  That's why
I've always argued against making that (and ZONE_DMA) user selectable,
but some arch maintainers insisted that they want that, breaking the
original guarantee.  Which is annoying as dma_map_* can't tell you
if the failure is permanent or transient.
