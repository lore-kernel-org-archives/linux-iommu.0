From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v9 8/8] genirq/msi: use the MSI doorbell's IOVA when requested
Date: Wed,  4 May 2016 15:18:14 +0000
Message-ID: <1462375094-2390-9-git-send-email-eric.auger@linaro.org>
References: <1462375094-2390-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1462375094-2390-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On MSI message composition we now use the MSI doorbell's IOVA in
place of the doorbell's PA in case the device is upstream to an
IOMMU that requires MSI addresses to be mapped. The doorbell's
allocation and mapping happened on an early stage (pci_enable_msi).

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

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
index d654524..082e6de 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -62,10 +62,18 @@ static int msi_compose(struct irq_data *irq_data,
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
