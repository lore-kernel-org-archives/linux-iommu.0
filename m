From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND 1/6] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
Date: Thu, 14 Jun 2018 12:48:21 +0200
Message-ID: <1528973306-7962-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Bump up the maximum numbers of micro-TLBS to 48.

Each IPMMU device instance get micro-TLB assignment via
the "iommus" property in DT. Older SoCs tend to use a
maximum number of 32 micro-TLBs per IPMMU instance however
newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.

At this point no SoC specific handling is done to validate
the maximum number of micro-TLBs, and because of that the
DT information is assumed to be within correct range for
each particular SoC.

If needed in the future SoC specific feature flags can be
added to handle the maximum number of micro-TLBs without
requiring DT changes, however at this point this does not
seem necessary.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e8..5c1ade7 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -194,7 +194,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 #define IMPMBA(n)			(0x0280 + ((n) * 4))
 #define IMPMBD(n)			(0x02c0 + ((n) * 4))
 
-#define IMUCTR(n)			(0x0300 + ((n) * 16))
+#define IMUCTR(n)			((n) < 32 ? IMUCTR0(n) : IMUCTR32(n))
+#define IMUCTR0(n)			(0x0300 + ((n) * 16))
+#define IMUCTR32(n)			(0x0600 + (((n) - 32) * 16))
 #define IMUCTR_FIXADDEN			(1 << 31)
 #define IMUCTR_FIXADD_MASK		(0xff << 16)
 #define IMUCTR_FIXADD_SHIFT		16
@@ -204,7 +206,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 #define IMUCTR_FLUSH			(1 << 1)
 #define IMUCTR_MMUEN			(1 << 0)
 
-#define IMUASID(n)			(0x0308 + ((n) * 16))
+#define IMUASID(n)			((n) < 32 ? IMUASID0(n) : IMUASID32(n))
+#define IMUASID0(n)			(0x0308 + ((n) * 16))
+#define IMUASID32(n)			(0x0608 + (((n) - 32) * 16))
 #define IMUASID_ASID8_MASK		(0xff << 8)
 #define IMUASID_ASID8_SHIFT		8
 #define IMUASID_ASID0_MASK		(0xff << 0)
@@ -955,7 +959,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	}
 
 	mmu->dev = &pdev->dev;
-	mmu->num_utlbs = 32;
+	mmu->num_utlbs = 48;
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = of_device_get_match_data(&pdev->dev);
-- 
2.7.4
