Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA08BE0
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724904997; cv=none; b=RSPhwNqsXVYCzbXGp2o0vc6SPED3FKe8/L8x4VskZ4zaCqij2gmStkeMVYgP8UNVGRkIYbetxcj2njQunauf2ZtY2EZw5ENCefRCrSIG4nu6bz5Cxi0UtPALdveVECawqJm/diPqvvXhp4EC9HYMJkmKiIIRekxEhYPx6ajTeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724904997; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTDikaszeD7cPV0pQhPbmAZLd0Pj7IhKNxX7jl5SKuN/KpWH31kCYqv3uSCg3p34Gi5PWxD0U4JcteZ5zirgB1b5u4gi0SggmQjIMi2EM1qydNkwBjnmvk1d7X5qlwgxQq3g95eNTZP3chWXMMJARw8sFXHq7yaByLlVjIM4jEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C54A068AA6; Thu, 29 Aug 2024 06:16:31 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:16:31 +0200
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
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v2] arm64: mm: fix DMA zone when dma-ranges is missing
Message-ID: <20240829041631.GA4408@lst.de>
References: <d8e92b14181fc815773ac4f4bba70b5d48bc390e.1724838684.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e92b14181fc815773ac4f4bba70b5d48bc390e.1724838684.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.

