From: Andrew Jones <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] ACPI/IORT: Handle potential overflow in iort_dma_setup
Date: Tue, 18 Dec 2018 19:48:40 +0100
Message-ID: <20181218184841.20034-2-drjones@redhat.com>
References: <20181218184841.20034-1-drjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181218184841.20034-1-drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The sum of dmaaddr and size may overflow, particularly considering
there are cases where size will be U64_MAX.

Signed-off-by: Andrew Jones <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/acpi/arm64/iort.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..a0f4c157ba5e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1002,7 +1002,12 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	}
 
 	if (!ret) {
-		msb = fls64(dmaaddr + size - 1);
+		u64 dmaaddr_max = dmaaddr + size - 1;
+		if (dmaaddr_max >= dmaaddr)
+			msb = fls64(dmaaddr_max);
+		else
+			msb = 64;
+
 		/*
 		 * Round-up to the power-of-two mask or set
 		 * the mask to the whole 64-bit address space
-- 
2.17.2
