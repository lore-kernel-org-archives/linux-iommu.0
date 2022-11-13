Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A31871
	for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=p8fZXFOilxr1b8Vw8YSIZYORkb8OJr3ydr3tjQdLjg4=; b=lSs7voTqaJMI0HO0w/yDtxu1V5
	bFe2oVzPY3oP8bREwzfNwOfWUgcPhllF1FYQEtFuUdqSntgGpVcEKGvjdMdeRZNgtepgsxwzJLiSn
	GvChig1xISPaA22YRe2fmw21MmtcqUGwGi1MQGchbpeaxiOepb97cZQSGxx7iCEz0vLWLoLK0kc3z
	YrVB1crY8jRv7Zr9cNcMJV+zZMfzYNgpLoWblTjEfj+DSomHWeqFcLXkIgabUpr2UAWzxcb1BU95i
	sOERMpomMz96rkOTLwN3fbdaqSgxsjj3g7QlZtlea2h4gsFZH2Nu8pE5vgZOBKQ0vsKohRmYD3rmk
	JdGh1NIA==;
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFxL-00CLQc-V1; Sun, 13 Nov 2022 16:35:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: stop drivers from passing GFP_COMP to dma_alloc_coherent
Date: Sun, 13 Nov 2022 17:35:28 +0100
Message-Id: <20221113163535.884299-1-hch@lst.de>
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

this series fixes up various drivers that either try to get a compound
page from dma_alloc_coherent or more often just did a bit of cargo
cult copy and paste, and then warns about this flag passed in the
DMA layer instead of silently clearing it like done by ARM and dma-iommu
before.

Diffstat:
 arch/arm/mm/dma-mapping.c                     |   17 -----------------
 drivers/infiniband/hw/hfi1/init.c             |   21 +++------------------
 drivers/infiniband/hw/qib/qib_iba6120.c       |    2 +-
 drivers/infiniband/hw/qib/qib_init.c          |   21 ++++-----------------
 drivers/iommu/dma-iommu.c                     |    3 ---
 drivers/media/v4l2-core/videobuf-dma-contig.c |   22 ++++++++--------------
 drivers/net/ethernet/broadcom/cnic.c          |    6 ++----
 drivers/s390/net/ism_drv.c                    |    3 ++-
 kernel/dma/mapping.c                          |    8 ++++++++
 sound/core/memalloc.c                         |    5 ++---
 10 files changed, 30 insertions(+), 78 deletions(-)
