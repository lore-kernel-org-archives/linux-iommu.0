From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V9 4/9] common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
Date: Fri,  6 Jan 2017 18:58:11 +0530
Message-ID: <1483709296-32761-5-git-send-email-sricharan@codeaurora.org>
References: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483709296-32761-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

This patch adds the DMA_ATTR_PRIVILEGED attribute to the DMA-mapping
subsystem.

Some advanced peripherals such as remote processors and GPUs perform
accesses to DMA buffers in both privileged "supervisor" and unprivileged
"user" modes.  This attribute is used to indicate to the DMA-mapping
subsystem that the buffer is fully accessible at the elevated privilege
level (and ideally inaccessible or at least read-only at the
lesser-privileged levels).

Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 Documentation/DMA-attributes.txt | 10 ++++++++++
 include/linux/dma-mapping.h      |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 98bf7ac..44c6bc4 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -143,3 +143,13 @@ So, this provides a way for drivers to avoid those error messages on calls
 where allocation failures are not a problem, and shouldn't bother the logs.
 
 NOTE: At the moment DMA_ATTR_NO_WARN is only implemented on PowerPC.
+
+DMA_ATTR_PRIVILEGED
+------------------------------
+
+Some advanced peripherals such as remote processors and GPUs perform
+accesses to DMA buffers in both privileged "supervisor" and unprivileged
+"user" modes.  This attribute is used to indicate to the DMA-mapping
+subsystem that the buffer is fully accessible at the elevated privilege
+level (and ideally inaccessible or at least read-only at the
+lesser-privileged levels).
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 10c5a17b1..c24721a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -63,6 +63,13 @@
 #define DMA_ATTR_NO_WARN	(1UL << 8)
 
 /*
+ * DMA_ATTR_PRIVILEGED: used to indicate that the buffer is fully
+ * accessible at an elevated privilege level (and ideally inaccessible or
+ * at least read-only at lesser-privileged levels).
+ */
+#define DMA_ATTR_PRIVILEGED		(1UL << 9)
+
+/*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
  * reference a dma_addr_t directly because there may be translation between
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
