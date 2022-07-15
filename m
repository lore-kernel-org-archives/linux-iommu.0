Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448A2C9E
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 11:03:43 +0000 (UTC)
Received: from lemmy.home.8bytes.org (p4ff2bb8b.dip0.t-ipconnect.de [79.242.187.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by theia.8bytes.org (Postfix) with ESMTPSA id D95CB49B;
	Fri, 15 Jul 2022 13:03:38 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] MAINTAINERS: Add Robin Murphy as IOMMU SUBSYTEM reviewer
Date: Fri, 15 Jul 2022 13:03:34 +0200
Message-Id: <20220715110334.6969-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

Robin has been acting as a reviewer of the IOMMU Subsystem for a long
time. He is also defacto maintaining the IOMMU DMA-API Layer, so make
both roles official by adding Robin to the MAINTAINERS file.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f9ed151ad4c..029f49f29982 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10448,9 +10448,20 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 F:	fs/iomap/
 F:	include/linux/iomap.h
 
-IOMMU DRIVERS
+IOMMU DMA-API LAYER
+M:	Robin Murphy <robin.murphy@arm.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
+F:	drivers/iommu/dma-iommu.c
+F:	drivers/iommu/iova.c
+F:	include/linux/dma-iommu.h
+F:	include/linux/iova.h
+
+IOMMU SUBSYSTEM
 M:	Joerg Roedel <joro@8bytes.org>
 M:	Will Deacon <will@kernel.org>
+R:	Robin Murphy <robin.murphy@arm.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
-- 
2.36.1

