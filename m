Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8E5236
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA5AF68AA6; Mon, 23 Oct 2023 07:56:58 +0200 (CEST)
Date: Mon, 23 Oct 2023 07:56:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH RFC 1/9] dma-debug: Fix a typo in a debugging
 eye-catcher
Message-ID: <20231023055658.GA11569@lst.de>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net> <169772913879.5232.8222328841727254479.stgit@klimt.1015granger.net> <20231020044941.GA12234@lst.de> <D983E311-0357-454C-8FA8-D365536C5ADB@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D983E311-0357-454C-8FA8-D365536C5ADB@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 20, 2023 at 01:38:01PM +0000, Chuck Lever III wrote:
> I think you were explicitly copied only the first two.
> I assumed you would see the others on the mailing lists.
> 
> I used information in MAINTAINERS for the files and
> subsystems those patches modified. Is that information
> up to date?

You must always send the entire series to all recipients.  Without
that proper review is impossible.
