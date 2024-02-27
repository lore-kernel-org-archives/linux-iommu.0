Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D8145B09
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048669; cv=none; b=dhw9AxuuPMXkPcHC8/OhVmqFMWA2zXqUiDr3Uj3U7IQVGCnuuRve09ltrsz5W8IKmjd9DaF4VrubocU2sDF/unbqNLZ8YeV+kvY+ynfWbwQ1c+ay3gimnfevQwbFs05RQBOvXCbvumVGI9GcHXNegJQEIEIh7KssHLHni20Z7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048669; c=relaxed/simple;
	bh=xp1QTpfotzzuZ0ozNPNcLoEX9NOoIuP3P6xkVJWbeLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgugG4KZQ+Ei9WlMcY7SEFA/iloTtOK+lVmYqxyiA66GKs9Pzs2FfkiLd+qulhnQW/afw/kVp3RHzfWNDzV3oMdebtds1Oald4RwgOm9LkWLjDymOCqOEVFOOxZu72BWSk4XIFGzagW0730+28tJz+2tR/K40xSOKleE7QU56hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C48568C4E; Tue, 27 Feb 2024 16:44:24 +0100 (CET)
Date: Tue, 27 Feb 2024 16:44:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-contiguous: remove debug code to removed
 CONFIG_CMA_DEBUG
Message-ID: <20240227154424.GB15319@lst.de>
References: <20240207143825.986-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207143825.986-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

added to the dma-mapping for-next branch.

