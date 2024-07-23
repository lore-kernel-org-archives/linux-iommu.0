Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693617F;
	Tue, 23 Jul 2024 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693167; cv=none; b=nWPteBzQ+Uiy8vtPgkVlHjrbq4WQYN5VAOSSY7AFBclSQlE0z+J/7IcXikI+ehUwexJmORv7KBu2BRcvjDAcUmd7Hr3iSJpHAKsCg8iNBupDjJ0apqEjsHClpfPcxZYaYydTL1brsFeUm15EIYdRnm86Gbd5hifxWLxPJV50Pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693167; c=relaxed/simple;
	bh=WjSUx3GvKl5CUSPY08WsFk5F3w7X1b1z+ZsrzLhYna0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCOsPKbr1WwKiz/8LOyuZ8hiktlRF9+5EOWIIT47Er8oxWmblnsw40wvpgc7sL/xcnH57UHwe3MaF1mcVkCR4gElW/UuNet8WDA87jqzB1C/IagEvDdOPce5eY6nmLGoGSzZlk/tUpIE+i/2eM3hr/vo8cZW4x3n8G130zFGnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1rCoElHV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1rCoElHV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qTtqCPrHTO1wHZhUdAhy0D5VNvnq1HqrB1rWUw1+V/k=; b=1rCoElHVJJMrvrPyWpTy+V0CAQ
	c+pX5BAeZAd6FT0mdvd43MlA85tGrG+trR/YYfqqvjAsksB+xQlmEUN0HWXv0dCd9T6u5XJ8/m9cv
	mAH6wxBm21McIOROMwHCpCamXx6MGJawd4b123QzTglltxBCzLwvMOhhUjrnU/VcVSHQw6CENaBko
	Caa8liEjiW1oleIc0xaezjHKHLDVe1Jfi7+1yMvcinALs2orY4TyiFEnufBbgRfcgA8uEnMOlWtg7
	EHa0trcFOlpBDRSsMBgEpWVGrp57ejXcP8XmMBTSdD9fxft86qspr5PMMII3Vqyh+p6q4ykcA7B8z
	Z6Uj2C0g==;
Received: from [64.141.80.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW32b-0000000AvOp-0KDU;
	Tue, 23 Jul 2024 00:06:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: remove the dma_set_{max_seg_size,seg_boundary,min_align_mask} return value
Date: Mon, 22 Jul 2024 17:05:54 -0700
Message-ID: <20240723000604.241443-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

the above three functions can only return errors if the bus code failed
to allocate the dma_parms structure, which is a grave error that won't
get us far.  Thus remove the pointless return values, that so far have
fortunately been mostly ignored, but which the cleanup brigade now wants
to check for for no good reason.

I'd love to get this in after -rc1 so that we can catch any of those
cleanups that might be queued up for this merge window.
