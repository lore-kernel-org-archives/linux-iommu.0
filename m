Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF0628
	for <iommu@lists.linux.dev>; Thu,  8 Jun 2023 04:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=p2gzrKI8pycdTfw3rHRPH/Xfrj
	aJxbAAyPxjYtZqIZYe+Car5Pp7pLQR3OcF58pdnKHfvDqGJaWzkIrhpQI89ygEWGZbXplszt6cMaj
	HEkAmAgy4sTuZgfjyBlzBA9qW93w3FDfeIaRri2QD/w6w8hTLLhvUdkJBsyBgPLWx1v1HeZJCmnyb
	wFu22TBb2MDoNPaqGTco4crqMNr9Hn615wDEa8tLGgD7t/+KwNt/iVRgOJyDjiurdZjr+C2FCXn4R
	LBteE5zFWl4EKZky0SHBsYw721qNsxPVO18prPA4aPxEcwrzvqZ5ITmHxH4U5PdHEABfoUkI3eetf
	rJ7vHA6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q77cB-0084zq-06;
	Thu, 08 Jun 2023 04:51:15 +0000
Date: Wed, 7 Jun 2023 21:51:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	hch@infradead.org, stable@vger.kernel.org,
	Jason Adriaanse <jason_a69@yahoo.co.uk>
Subject: Re: [PATCH RESEND] PCI: Add function 1 DMA alias quirk for Marvell
 88SE9235
Message-ID: <ZIFeQyiYuQUhbKFS@infradead.org>
References: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
