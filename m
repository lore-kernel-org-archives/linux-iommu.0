From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 9/9] genirq/msi: use the MSI doorbell's IOVA when requested
Date: Tue,  7 Jun 2016 16:01:28 +0000
Message-ID: <1465315288-5931-10-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

On MSI message composition we now use the MSI doorbell's IOVA in
place of the doorbell's PA in case the device is upstream to an
IOMMU that requires MSI addresses to be mapped. The doorbell's
allocation and mapping happened on an early stage (pci_enable_msi).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v8 -> v9:
- Braces on both sides of the 'else' in msi_compose

v7 -> v8:
- use iommu_msi_msg_pa_to_va
- add WARN_ON

v6 -> v7:
- allocation/mapping is done at an earlier stage. We now just perform
  the iova lookup. So it is safe now to be called in a code that cannot
  sleep. iommu_msi_set_doorbell_iova is moved in the dma-reserved-iommu
  API: I think it cleans things up with respect to various #ifdef CONFIGS.

v5:
- use macros to increase the readability
- add comments
- fix a typo that caused a compilation error if CONFIG_IOMMU_API
  is not set
---
 kernel/irq/msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index a78db5f..e731949 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -63,10 +63,18 @@ static int msi_compose(struct irq_data *irq_data,
 {
 	int ret = 0;
 
-	if (erase)
+	if (erase) {
 		memset(msg, 0, sizeof(*msg));
-	else
+	} else {
+		struct device *dev;
+
 		ret = irq_chip_compose_msi_msg(irq_data, msg);
+		if (ret)
+			return ret;
+
+		dev = msi_desc_to_dev(irq_data_get_msi_desc(irq_data));
+		WARN_ON(iommu_msi_msg_pa_to_va(dev, msg));
+	}
 
 	return ret;
 }
-- 
1.9.1
