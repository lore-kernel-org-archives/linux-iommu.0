Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB01C2D7
	for <iommu@lists.linux.dev>; Sat,  8 Apr 2023 06:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FSAuJyqLlRwLojcGY0uJ8g8ZAyrKXEp/l8FpS90Rmtg=; b=hU0+Q7xC4qo6vMPcF8mrLKUPxZ
	ilXBjTbB/ObSoD+Qy8a7vC+EWpKNal6d9ELdL8heFFs5Ua8nxmMpelA4BFBjpRxE9smGptudDfFEm
	KlMCPY05zj9+gcFWRbARYwgJ5He2Wm113gok5v/wB3AhILSjVPkPOGRtzdiljB0MSbYVkoGiQDYqh
	odxfMxsSZvGFaEcOvZ/CDpmJWEUOXZkukHG9b/Y7y6wIaG+Hd7RtkaZo+j4k6lKKgfGjtRpahpYnx
	kYpmg2hokhu6pYYfgC32t9XtUqcgfW8PWKEuijXFf6mt46ijGvB8tZWPRept2Bpkty7jbNRoZwZ2G
	y22tOgPg==;
Received: from 213-225-8-166.nat.highway.a1.net ([213.225.8.166] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pl1i3-00Bo2E-2k;
	Sat, 08 Apr 2023 06:06:00 +0000
Date: Sat, 8 Apr 2023 08:05:56 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.3
Message-ID: <ZDEERJRl1jrw2kQn@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 0eee5ae1025699ea93d44fdb6ef2365505082103:

  swiotlb: fix slot alignment checks (2023-03-22 09:03:17 +0100)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-04-08

for you to fetch changes up to bbb73a103fbbed6f63cb738d3783261c4241b4b2:

  swiotlb: fix a braino in the alignment check fix (2023-04-06 16:45:12 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.3

 - fix a braino in the swiotlb alignment check fix (Petr Tesarik)

----------------------------------------------------------------
Petr Tesarik (1):
      swiotlb: fix a braino in the alignment check fix

 kernel/dma/swiotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
