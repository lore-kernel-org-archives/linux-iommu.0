Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7F3FC7
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8Zxq5hWw3dwWVl94CNuif+2iRYCx3CT0GqUzeTrazVE=; b=SyvjYhlEwRWBlrCStiersLnd80
	451SbV7bHO6K3sGKIMyjTLheYvpbXjkP+wPPiqRea/UswW+hLRRKRCO1Sv8WM+bONXvvZP7nzaDfE
	e8qaAflvcAtkpBOVw/JJycvSFjQsRXS9GB2M4vXwCUx1jgeditQ0iMECKNhg8tM3deIlw2aqREhis
	iRpSQhB/uignjMvCLVA4W1IwHPHOVc2Fj1bhqeXYwSVsw5LX4emHsehSBPNOOQK1sf7m7C8OHPdIX
	TmSEjv27LsOpHPfAWDQcpr0PwyQiHeDfTtPrz48HLOfrmXRnCbe7aIlEvnWGTgxIVJ6hyvB3VYobg
	p2JUoZVQ==;
Received: from [2001:4bb8:199:6d04:9a88:dc19:c657:d17f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox6ew-00DwvD-A8; Mon, 21 Nov 2022 13:16:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: RFC: switch to use the generic remapping dma-allocator
Date: Mon, 21 Nov 2022 14:16:21 +0100
Message-Id: <20221121131623.228727-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently parisc has it's own implementation of the dma-coherent
allocator that sets up PTEs with the uncached bit.  I can't see any
reason why using vmap to do the same kind of setup shouldn't work.
This small series shows how that could work, but due to a lack of
actual parisc hardware it is compile tested only and not only needs
a careful review but also actual testing on hardware.

Diffstat:
 arch/parisc/Kconfig               |    4 
 arch/parisc/include/asm/pgtable.h |    1 
 arch/parisc/kernel/pci-dma.c      |  446 +-------------------------------------
 include/linux/dma-map-ops.h       |    1 
 kernel/dma/Kconfig                |    3 
 kernel/dma/direct.c               |    4 
 6 files changed, 24 insertions(+), 435 deletions(-)
