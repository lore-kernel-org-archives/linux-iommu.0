Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBC16415
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IkODTfco"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lk2hjH1J0z+vDraZqP1FiMVLedAUOQE0Xu6QSSkdeMA=; b=IkODTfco0inGQHF15O+RlwwVUO
	uyzV4qCSEoVwBecQK2ZtYgWfG55JGXH4i4m0yYkdWNozPWmlrpmGxjo3844SQlwA1agw0Qud1EH3g
	wPcOkezghCHw/1fMp1HrZiMKLQyNBJENnYgGrg+qjnTFpNpr6oqEGLfB6c6UEqVLIA0BU0nZ1XI6L
	O3Mcsr5dvr9V5U/JeSZ6eVdISZ5eokTIVUc5KoPdAGaDZpaoSof5Op3RgnSq6+uv5sBY7PFyXchn7
	ZcfqYW9ivyW/BLXe4HSi0ynWkJoZLdYX5UHlOzRuvJzes54o/zmL13LaW7d8PxPBNeeu3wFXkxGq+
	OMDVkeww==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGSq-008R1r-2l;
	Mon, 16 Oct 2023 05:48:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH 12/12] m68k: remove unused includes from dma.c
Date: Mon, 16 Oct 2023 07:47:54 +0200
Message-Id: <20231016054755.915155-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016054755.915155-1-hch@lst.de>
References: <20231016054755.915155-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

dma.c doesn't need most of the headers it includes.  Also there is
no point in undefining the DEBUG symbol given that it isn't used
anywhere in this small file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/kernel/dma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index eef63d032abb53..16063783aa80c6 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -4,17 +4,8 @@
  * for more details.
  */
 
-#undef DEBUG
-
 #include <linux/dma-map-ops.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/scatterlist.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/export.h>
-
 #include <asm/cacheflush.h>
 
 #ifndef CONFIG_COLDFIRE
-- 
2.39.2

