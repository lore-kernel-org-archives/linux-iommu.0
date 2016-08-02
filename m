From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 11/11] genirq/msi: Use the MSI doorbell's IOVA when
	requested
Date: Tue,  2 Aug 2016 17:23:37 +0000
Message-ID: <1470158617-7022-12-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently the msi_compose() uses the doorbell's physical address.

However in case the MSI doorbell is accessed through an IOMMU that
does not bypass the MSI transactions we need to use an IOVA instead.

iommu_msi_msg_pa_to_va helper, part of the iommu-msi API, detects
the above case and swaps the MSI doorbell physical address with a
pre-allocated/mapped IOVA.

That way the device will send the MSI with this IOVA and the address
will be translated by the IOMMU into the target MSI doorbell PA.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v11 -> v12:
- remove WARN_ON. iommu domain cannot dissapear while msi still are enabled
  so the userspace cannot induce a kernel panic.

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
index 6a3cb14..02c1c71 100644
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
+		ret = iommu_msi_msg_pa_to_va(dev, msg);
+	}
 
 	return ret;
 }
-- 
1.9.1
