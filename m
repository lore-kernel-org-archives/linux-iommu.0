From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/7] iommu/ipmmu-vmsa: Call ipmmu_ctx_write_root() instead of open coding
Date: Wed, 20 Feb 2019 16:05:26 +0100
Message-ID: <20190220150531.2462-3-geert+renesas@glider.be>
References: <20190220150531.2462-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220150531.2462-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

There is a helper to write to the root IPMMU instance's registers, so
let's use it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f2b781e20a0eba6..ac70cb967ff821c6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -280,8 +280,7 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
 		ipmmu_write(domain->mmu,
 			    domain->context_id * IM_CTX_SIZE + reg, data);
 
-	ipmmu_write(domain->mmu->root,
-		    domain->context_id * IM_CTX_SIZE + reg, data);
+	ipmmu_ctx_write_root(domain, reg, data);
 }
 
 /* -----------------------------------------------------------------------------
-- 
2.17.1
