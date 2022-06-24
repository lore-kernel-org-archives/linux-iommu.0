Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A628EB
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vMOXdBy5q0jneD6eagGKUyxYDxjR9s5ISqYNMfmQSLs=; b=e9VIrFRSAoJIFu8bsXbrZyRRTc
	i0XRBruZXdofziujw65WQJCUaxKA2cynWytHcpHtsukfz1JLZwagaQIlgR56v/CWe7tnG+vbzzotD
	0aMsikP80AhoEI7hiEUBajzmFOTf6jRTzhz994vFGETTgH5J0VSUNccEo+LT5qKkFVTBkDF/d83XA
	wsvpi9S/qpTTwNJHnKJiEhFWx7eZME93DJB04Lw3dpSTOLZBg94XsXvfPj21CDJ3WMifj55kxHDMB
	edLRo7xTly67AzTxZqdwl7sFY2hMlu7c0BloaHDnS/2dH5QsuRAp8ZN8P40Byj5mO+b6lZNNwoQhT
	41RxiRww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4iuR-002GrT-UF; Fri, 24 Jun 2022 12:59:39 +0000
Date: Fri, 24 Jun 2022 05:59:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev, Joerg Roedel <jroedel@suse.de>,
	Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrW1Oy0ojM5pXREB@infradead.org>
References: <20220624125139.412-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624125139.412-1-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID: <20220624125939.4LLI0l7n_ubNbWJe6ufMY0G72eD1uvSAXsL1UTtcvg8@z>

On Fri, Jun 24, 2022 at 02:51:39PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IOMMU mailing list will move from lists.linux-foundation.org to
> lists.linux.dev. The hard switch of the archive will happen on July
> 5th, but add the new list now already so that people start using the
> list when sending patches. After July 5th the old list will disappear.

Shouldn't this also remove the old list given it has only a few days
to live?
