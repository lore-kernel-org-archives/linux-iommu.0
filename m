From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 20/21] arm64: switch copyright boilerplace to SPDX in dma-mapping.c
Date: Wed, 27 Mar 2019 09:04:47 +0100
Message-ID: <20190327080448.5500-21-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index bf49e982c978..ad46594b3799 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * SWIOTLB-based DMA API implementation
- *
  * Copyright (C) 2012 ARM Ltd.
  * Author: Catalin Marinas <catalin.marinas@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/gfp.h>
-- 
2.20.1
