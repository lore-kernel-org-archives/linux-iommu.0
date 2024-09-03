Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36404171C9
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348506; cv=none; b=XfsPmI7LwupU6Bg1lJV49LdK0ivu6E6JQj+HUcRA0D6pbIOwL/4/P1jRxEOYmA4JSgfo4BU0ccwFBToTaBa0b1ngtkUoBMNMyhNOYb48s3HlwgJtq6+KHBMOroz3zWhpFBsh/9GkbR0nIKsFX8aGKa8SUb6vIc3Ur6e7qkhl3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348506; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbwKVZeFd9ESIQHKyGAkxXav1bo5aMs0U0kRiPXk+3nPq7pZdJih/VlMQV8317aBbGPZnPW+eG4EPtDKnH89u0cHWqzGT0b9Q3qmZbbUfpJIxvTRsfquP2Re6pKkz4BDDXG4NSjyP7c6Y6uL1v19Ija2za2QNzJCQ2MoT1F7+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1BE8227A87; Tue,  3 Sep 2024 09:28:21 +0200 (CEST)
Date: Tue, 3 Sep 2024 09:28:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] arm64: mm: keep low RAM dma zone
Message-ID: <20240903072821.GA2168@lst.de>
References: <3cc8abdb1d6a2d882d16dc2b9890df3ce2117d0d.1725171154.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc8abdb1d6a2d882d16dc2b9890df3ce2117d0d.1725171154.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.

