Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E955236
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id F28EA68AA6; Mon, 23 Oct 2023 08:09:19 +0200 (CEST)
Date: Mon, 23 Oct 2023 08:09:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jia He <justin.he@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
Message-ID: <20231023060919.GB11907@lst.de>
References: <20231016125254.1875-1-justin.he@arm.com> <20231016125254.1875-2-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016125254.1875-2-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 16, 2023 at 12:52:53PM +0000, Jia He wrote:
> This is a preparatory patch to move dma_addressing_limited so that it is
> exported instead of a new low-level helper.

So while this exports dma_addressing_limited that's really a side effect.
The primary thing is that it moves the function out of line.
