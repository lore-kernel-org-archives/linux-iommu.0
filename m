Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902A2989AE;
	Mon, 14 Apr 2025 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630940; cv=none; b=hh/4OwEAzEmDHLeMl2B+12gaO2/HG0GtV0ap7gaS+DCpgjzT4WiqfiVZReppP5EaOrIci/RnfcpyZ5DHJ4bWoNs2JWtNgVGlmZAvdqcfB4f5fKvHDby/wxNR9P6oVkb5T6zqY88PB5gDE7GXHVODvb6g8vK6NUSWPhclIea05TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630940; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMsn1cL57SJEkrzMNjtqwqeySMQuYmuraB0Av7g8RFaKf7zs4z8lI1n3yaCpHdSHk+w0AX7X0tW3hx2imENhS4aA9c4nKxaKvprKgwXlXJW7SU7JQxaV33AhW+rk4vVQPCWPJdshlrRMDU4UbVf4lQDH3ROfJmqlNce99bWk6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1KgqpPnR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1KgqpPnR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1KgqpPnRMPrHSGPtQ8Uw7ZKCC2
	xB0QIxptowN8kxnlUPm+zgeuVodagi9U6zI+hHuKVgY8hR7c2lWg7ReNqMG12QCa/j3YKaEfWg8k+
	hzU2RwvPZkeM+jOx0lKjO31pkqfh1euyfXO+APBUCA3/J22RTNxPPMgC1/rBjdVrKYgtIkPh8ymdz
	9N6oQ0vxFsP+eA1COJnxLqpYZjmFe+RS6gQ/261Ryzl723Wk+lMkNdtc4qr/VgTd/plT++VtubiGt
	i3TYDWve6Njn7f9CvY4NWzdYqmrrQyfgleZPHuyNaAa1fQCAWR6n0QxyFrEOeKqo+gfOSp5P308Sz
	4QLACt0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ICf-00000001oF9-1JLR;
	Mon, 14 Apr 2025 11:42:17 +0000
Date: Mon, 14 Apr 2025 04:42:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [v2] dma/mapping.c: dev_dbg support for dma_addressing_limited
Message-ID: <Z_z0mUDYNYhk7KqZ@infradead.org>
References: <20250414113752.3298276-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414113752.3298276-1-balbirs@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

