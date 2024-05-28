Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF4645;
	Tue, 28 May 2024 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871753; cv=none; b=SjNueZXEGZcwhP7WG/edLPv1UlqBHPR47wOavRgg2z3v+E2iQHazg9GKp6PkEP9S024HgIrCXBi44iY4qaB6JIuGrcbcH4/ffSIvWNjn0tEWbR3xF9+NMqJNRqfx1iQASXlribK+AtPW9M63zfxpXUMnBxUPMaA3A9ScQzWPFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871753; c=relaxed/simple;
	bh=0CXyIaSIcIvnhOrbj4/tTeYYvOeXhTqPwtR91rJKVIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmjD+762buPVXViXjquTFXI2C8HBfkPZlTHd1dHphGnlFIEiZIcwMzJwAb5Hty5FIuT422nbdF9cdsYvxwm+xCorlax8nxN2GlVpzZLdxbEhiPGJnBGG2VbtmMiha4t94qNpjSJVDH7McLOSFWJmDKpQ4kfl1ASNCeC0N/5pqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l0CfYHgZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0CfYHgZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0CXyIaSIcIvnhOrbj4/tTeYYvOeXhTqPwtR91rJKVIU=; b=l0CfYHgZ++0RNk4PInLN8d0CXI
	GNzaT0t8lzt32fgjXz6YWL3RANfr0ij1Ioyd3HHtKFI6G+Ex7s85Dl8e7NaO1A9CqLOtHPsUvqsrk
	e4TeSYYVQwrMm40AX34Yn6u1DDN+i3vpiB9ujt+btOIsDl1IB7o/MxSwDJte1TCeOqwRLq5UXQ6k5
	XciOO2G2jPlUupVWPtg1SYpfdJQ5hAkPOwV9lKTfLSbe50nRYJ0jUGUBj34Pdi+ZFyqSum3LS7gEE
	EcWvpwEheCY7G7gA7bU86rzdfCFH30U55LCdOghGpv8she29FPSIWmGDUIfbKAy7P9y4feBBoeYb0
	GSIo3plg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBoln-0000000H3Db-1Xow;
	Tue, 28 May 2024 04:49:07 +0000
Date: Mon, 27 May 2024 21:49:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v1 1/1] iommu/dma: Make SG mapping and syncing robust
 against empty tables
Message-ID: <ZlViQ8jLOp-9l9BN@infradead.org>
References: <20240527232625.462045-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527232625.462045-1-andriy.shevchenko@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 02:26:25AM +0300, Andy Shevchenko wrote:
> Statistically there are only a few cases in the kernel that do such a
> check. However, any attempt to make it alinged with the rest 99%+ cases
> will be a regression due to above mentioned relatively recent change.
> Instead of asking a caller to perform the checks, just return status quo
> to SG mapping and syncing callbacks, so they won't crash on
> uninitialised SG list.

This is not a valid use of the API, please fix the callers instead.

