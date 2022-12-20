Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E10186A
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ppdW24xT12RkaZU9C8ifVA44nnqAOsohCG3d1m74QY0=; b=OBrOQpeSeMeOJy2wqwZ3Ih9SjG
	0QJg7xBCYwlzNc4U8uVSgf6rsv/0yynaI5fpNKuhr9ymUgD/oLq7w4oCIOsfWtHbdd5sF7j/67tVF
	9MSe2M3rwQ2phhU81xcsSLzF7X6lrHKZeOJ7PoQSEOJ3rqcBiFIgVZgen54WW9cdYlvHznNXSzFv5
	JhJ4FCze8Ig8+SrE5GkbVUCWQU8nO7HpL5WNdxzQ6lY/FfbEPr9b3gzDycD9C1mKZ1qucTePVZenH
	VEp/qbGoPP5NmSnhX6enoy97qr85Vc5JFDfzUeCryAy8bs74khHhXiMBBrN5sUvXXwZHQFqF3UUXL
	SNgxAotg==;
Received: from [2001:4bb8:199:7829:c604:55b0:ed6a:61ce] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7XrA-00BuI1-22; Tue, 20 Dec 2022 08:20:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org
Subject: fix GFP_COMP use in noncoherent dma allocators
Date: Tue, 20 Dec 2022 09:20:07 +0100
Message-Id: <20221220082009.569785-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixe the regression where dma-iommu stopped clearing
GFP_COMP from noncoherent dma allocations by never requesting those
in the sound code and rejecting them in the core DMA API code.

Diffstat:
 kernel/dma/mapping.c  |    4 ++++
 sound/core/memalloc.c |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)
