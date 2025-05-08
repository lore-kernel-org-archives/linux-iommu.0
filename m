Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC461F561D;
	Thu,  8 May 2025 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677694; cv=none; b=f6aQEPbddmmWPig/rF6lmavwGDoueaXHrJ0IWeUiZPDDfGCebB+SAZgOVZgc8gGzGoaXcC1ZIxQAuiJLYyFGX4uNvpSJeuSS4xc0bEr2kRCTy3dUiKXbZs/Bph9/NL0UJxqD+jbL5919GQtxWiV5eraa3J8WLr3dFEGxwGD+Bdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677694; c=relaxed/simple;
	bh=w86OGc6RWIhtDYy5k5FLEKlIAUwpi/4GGh7PHA74FFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb3cr1T6EboOVC5dyxakZY3ymYreuDXWAy+fUgydsZC2DMddQJL/b9gIcNVXDL/5gRPkg/ENKpaFLUQFCqvAyWicQHAsd1Qd3TwANXd6QoLhTX/zG6A40SvUPKQhlZv00cFYDL72/DWz4UYPlsuvHmJa+igNKGkYdQTGmRu4FEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=il6E3u2h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="il6E3u2h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=41y5a2fmLpkUVnjUrs+3spKKdWGJe+CFaj83hBx9tto=; b=il6E3u2hODnTYTdHGLvese8c4k
	moZHoVqHVx9Mv3WchvyW0oJ9k2NMXgY+5X9tjKFn7cA9vt21hz7oDJW7uw+PrrxehnVWvrK004O68
	bJ4+p3xV5IPwiv3dGKLczXIM4GPVqkBYvjUScsbDBcGBHg2oLTcs4N2xDXtIq+ZSSmkv4h+jE8Gmb
	cqrLDED7/LnE4h9Yt8IilMzCzlDps8RAVHzWoTPO/AzxKfR4dp8rS2f6w6zOEZ2tYNjGBarV+gnyl
	oCaJvmyAKhjtT+SuVOPqH3ZLM1fJ5Mt2yysevzIoCkfDmMs3PpP69DckYB5Sw/pwLSyRNMQHPpcyW
	OWLzkU0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCsea-0000000HGrC-1ecu;
	Thu, 08 May 2025 04:14:36 +0000
Date: Wed, 7 May 2025 21:14:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: John Ernberg <john.ernberg@actia.se>, Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] xen: swiotlb: Implement map_resource callback
Message-ID: <aBwvrLKD_VJapYkB@infradead.org>
References: <20250502114043.1968976-1-john.ernberg@actia.se>
 <20250502114043.1968976-3-john.ernberg@actia.se>
 <alpine.DEB.2.22.394.2505021007460.3879245@ubuntu-linux-20-04-desktop>
 <75266eb7-66a4-4477-ae8a-cbd1ebbee8db@actia.se>
 <alpine.DEB.2.22.394.2505071602570.3879245@ubuntu-linux-20-04-desktop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2505071602570.3879245@ubuntu-linux-20-04-desktop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 07, 2025 at 04:09:15PM -0700, Stefano Stabellini wrote:
> > This mapping is not for a RAM backed address. In the eDMA case for the 
> > iMX8QXP the `phys` coming in here is the address of a register.
> 
> Ok, this information is important :-)
> 
> I am not certain whether the map_resource interface can only be called
> for MMIO addresses or if it can also be called for RAM-backed addresses
> with a size > PAGE_SIZE. In the latter case, we could run into the issue
> I was describing.

map_resource is intended for MMIO regions, although those could be >
PAGE_SIZE.  It must not be called on RAM.

