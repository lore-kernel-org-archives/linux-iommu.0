From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v3 3/6] common: DMA-mapping: add DMA_ATTR_PRIVILEGED attribute
Date: Tue, 19 Jul 2016 13:36:52 -0700
Message-ID: <20160719203655.16629-4-mitchelh@codeaurora.org>
References: <20160719203655.16629-1-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160719203655.16629-1-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Patrick Daly <pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Thomas Zeng <tzeng-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds the DMA_ATTR_PRIVILEGED attribute to the DMA-mapping
subsystem.

Some advanced peripherals such as remote processors and GPUs perform
accesses to DMA buffers in both privileged "supervisor" and unprivileged
"user" modes.  This attribute is used to indicate to the DMA-mapping
subsystem that the buffer is fully accessible at the elevated privilege
level (and ideally inaccessible or at least read-only at the
lesser-privileged levels).

Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

Notes:
    v2..v3
    
      - Not worrying about executability.

 Documentation/DMA-attributes.txt | 10 ++++++++++
 include/linux/dma-attrs.h        |  1 +
 2 files changed, 11 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index e8cf9cf873b3..d985effd0053 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,13 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
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
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 5246239a4953..3bc2208e1765 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -19,6 +19,7 @@ enum dma_attr {
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_FORCE_CONTIGUOUS,
 	DMA_ATTR_ALLOC_SINGLE_PAGES,
+	DMA_ATTR_PRIVILEGED,
 	DMA_ATTR_MAX,
 };
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
