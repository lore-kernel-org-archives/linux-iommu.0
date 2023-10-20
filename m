Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E129ECE
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id D45EE67373; Fri, 20 Oct 2023 06:49:41 +0200 (CEST)
Date: Fri, 20 Oct 2023 06:49:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC 1/9] dma-debug: Fix a typo in a debugging
 eye-catcher
Message-ID: <20231020044941.GA12234@lst.de>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net> <169772913879.5232.8222328841727254479.stgit@klimt.1015granger.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169772913879.5232.8222328841727254479.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

I'll add this to the dma-mapping tree.

FYI, I only got patches 1, 2 and the cover letter.  Something seems to
be broken in your mailer setup.
