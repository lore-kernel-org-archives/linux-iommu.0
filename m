Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA015CB
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590926; cv=none; b=pYjaQ6GlVrRM+18mfUAWVCP2cAsp9QXSj1+xptU1zwYsn28QmXTG8R5SUfNHVv0Ag/9dL10x7uIA3iCp/IZgFd3SOhkU0IbQN2KqtW3bx+TkCIAVjiQ7/lwdeLl1vhXbwo6FgBk3tRij0/X4YSCHdk8neR87JU8QLCUPvVc3xNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590926; c=relaxed/simple;
	bh=jzDyJroF8/afP3GzKI2rmY8da0VGXH1bOwktasOHt5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfLO55XsAGsQoianPS5I8ZrL7AAse5mgv+ZVrb3yN6+4lq8c4EUy796zZqYNvCH2KN0ZMTbueAqr2xVMT93652GKD6iS3vQZYlM6cK9HXatKSmoerwENK5XPV/8vt7zXy8mlNAeEvtVIYQcqFS+FYtb5Q1eAycO8YMUuCjXMgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E662A227A87; Wed, 10 Jul 2024 07:55:20 +0200 (CEST)
Date: Wed, 10 Jul 2024 07:55:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, mhkelley58@gmail.com,
	mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, jgross@suse.com, sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com, m.szyprowski@samsung.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240710055520.GA25305@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com> <20240709111013.6103d3f0@mordecai.tesarici.cz> <20240709111812.GB4421@lst.de> <20240709210818.28116c53@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709210818.28116c53@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 09:08:18PM +0200, Petr Tesařík wrote:
> I'm confused. If you're not a big fan, why are we effectively adding
> them to more places now than before the patch?

Because I didn't want to second guess the patch author too much.
