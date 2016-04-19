From: Eric Auger <eric.auger@linaro.org>
Subject: [PATCH v7 8/8] genirq/msi: use the MSI doorbell's IOVA when requested
Date: Tue, 19 Apr 2016 17:13:10 +0000
Message-ID: <1461085990-2547-9-git-send-email-eric.auger@linaro.org>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@st.com, eric.auger@linaro.org, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com
List-Id: iommu@lists.linux-foundation.org

On MSI message composition we now use the MSI doorbell's IOVA in
place of the doorbell's PA in case the device is upstream to an
IOMMU that requires MSI addresses to be mapped. The doorbell's
allocation and mapping happened on an early stage (pci_enable_msi).

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
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
 kernel/irq/msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e45907e..0ebb2d8 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,6 +19,7 @@
 
 /* Temparory solution for building, will be removed later */
 #include <linux/pci.h>
+#include <linux/dma-reserved-iommu.h>
 
 struct msi_desc *alloc_msi_entry(struct device *dev)
 {
@@ -64,8 +65,12 @@ static int msi_compose(struct irq_data *irq_data,
 
 	if (erase)
 		memset(msg, 0, sizeof(*msg));
-	else
+	else {
 		ret = irq_chip_compose_msi_msg(irq_data, msg);
+		if (ret)
+			return ret;
+		iommu_msi_mapping_translate_msg(irq_data, msg);
+	}
 
 	return ret;
 }
-- 
1.9.1
