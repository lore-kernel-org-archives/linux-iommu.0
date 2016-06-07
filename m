From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 6/9] irqchip/gicv2m: register the MSI global doorbell
Date: Tue,  7 Jun 2016 16:01:25 +0000
Message-ID: <1465315288-5931-7-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

Use the msi-doorbell API to register the global doorbell.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- introduce the registration concept in place of msi_doorbell_info
  callback

v8 -> v9:
- use global_doorbell instead of percpu_doorbells

v7 -> v8:
- gicv2m_msi_doorbell_info does not return a pointer to const
- remove spurious !v2m check
- add IOMMU_MMIO flag

v7: creation
---
 drivers/irqchip/irq-gic-v2m.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index ad0d296..11e039b 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -24,6 +24,8 @@
 #include <linux/of_pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/iommu.h>
+#include <linux/msi-doorbell.h>
 
 /*
 * MSI_TYPER:
@@ -366,12 +368,18 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 		goto err_iounmap;
 	}
 
+	ret = msi_doorbell_register_global(v2m, v2m->res.start, sizeof(u32),
+					   IOMMU_WRITE | IOMMU_MMIO, false);
+	if (ret)
+		goto err_free_bm;
+
 	list_add_tail(&v2m->entry, &v2m_nodes);
 
 	pr_info("range%pR, SPI[%d:%d]\n", res,
 		v2m->spi_start, (v2m->spi_start + v2m->nr_spis - 1));
 	return 0;
-
+err_free_bm:
+	kfree(v2m->bm);
 err_iounmap:
 	iounmap(v2m->base);
 err_free_v2m:
-- 
1.9.1
