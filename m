Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DBF23CB
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 06:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=l6ch1yePjEdG0LmVNEefnc3mognlEW6uEpIRnYmSquI=; b=uP6k6PHyLH765XsfuFSU+OfUkl
	ipkxVfR39RVgw0I0sRf148OKdgLDkwNAfXqTGRCLfFZAmhXfbzY9fGolS7x5PaO7UYpcU8DOdpVoD
	xXslWmVuAd7NzVdzHro2KOL/puDe9A9HmpcRd8bUCqfdWN0Fdg8PKooj4mkR4I6paqnYEW0YNz6eV
	XGxPj86GD63zimN0uJJpP/+pjGYLx0NbV5/MFkDTHSlBP7ado7oQA3XmU+Wye/HRjQDxrlub08S9Z
	MxVOlmV9ekpTz13qOmnBp/sU7dA0ffWLQk82PInfufve+GR4SCQrJ60BpE9MUyFBLoF1QCZqQbgoR
	cNVNX04w==;
Received: from [2a02:1210:321a:af00:5fac:fede:a3b:c715] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOCCT-00BeDu-CB; Wed, 17 Aug 2022 06:06:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	linux-kernel@vger.kernel.org
Subject: fix dma coherent pool sizing
Date: Wed, 17 Aug 2022 08:06:44 +0200
Message-Id: <20220817060647.1032426-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all

Michal pointed out that the sizing of the dma coherent pools is bonkers
as it uses the total memory to size the pool for each zone, which leads
to comically larger zones for the 16-MB ZONE_DMA on x86, which tends
leads to allocation failure warnings.  This series switches to sizing
the ZONE_DMA and ZONE_DMA32 pools based on the number of pages that
actually reside in those zones instead.

Diffstat:
 pool.c |   65 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 24 deletions(-)
