From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu/ipmmu-vmsa: Don't truncate ttbr if LPAE is not enabled
Date: Tue, 22 Dec 2015 20:01:06 +0100
Message-ID: <1450810866-4716-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

If CONFIG_PHYS_ADDR_T_64BIT=n:

    drivers/iommu/ipmmu-vmsa.c: In function 'ipmmu_domain_init_context':
    drivers/iommu/ipmmu-vmsa.c:434:2: warning: right shift count >= width of type
      ipmmu_ctx_write(domain, IMTTUBR0, ttbr >> 32);
      ^

As io_pgtable_cfg.arm_lpae_s1_cfg.ttbr[] is an array of u64s, assigning
it to a phys_addr_t may truncates it.  Make ttbr u64 to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index e08f4945cd5abb0c..83d7f0c7f47f1296 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -385,7 +385,7 @@ static struct iommu_gather_ops ipmmu_gather_ops = {
 
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
-	phys_addr_t ttbr;
+	u64 ttbr;
 	u32 tmp;
 	int ret;
 
-- 
1.9.1

