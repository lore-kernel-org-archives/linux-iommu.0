From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
	protection attributes
Date: Tue, 25 Jun 2013 13:52:26 +0200
Message-ID: <20130625.145226.1632119404634300971.hdoyu@nvidia.com>
References: <1370889285-22799-4-git-send-email-will.deacon@arm.com><20130625131215.d3cea2a5668a3d41dbbeb064@nvidia.com><20130625113714.GF31838@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130625113714.GF31838-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Tue, 25 Jun 2013 13:37:14 +0200:
...
> > Do we need similar changes for map_sg case as well? They still passes '0' as prot.
> 
> Yes, we could use the same trick there (probably worth moving the logic into
> a helper function for translating dma_data_direction into IOMMU_* values).
> 
> There are also iommu_map calls when allocating DMA buffers, but I think 0 is
> the right thing to pass there (i.e. no permission until pages have been
> explicitly mapped). Although, to be honest, I don't see why we need to map
> the buffer at all when we allocate it.

Yes, I thought too. I have a patch for that as below. If you like,
I'll rebase and send for merge with the one which changes
dma-mapping.c.

>From 699e6bd4fef86383d197775486b47bcbdc594f4a Mon Sep 17 00:00:00 2001
From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Tue, 25 Jun 2013 13:43:29 +0300
Subject: [PATCH 1/2] iommu/core: convert DMA direction into IOMMU protection
 attributes

Introduce a new function to convert DMA direction into IOMMU
protection attributes.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/iommu.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 00af00f..ce3be78 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -21,11 +21,26 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
+#include <linux/dma-direction.h>
 
 #define IOMMU_READ	(1)
 #define IOMMU_WRITE	(2)
 #define IOMMU_CACHE	(4) /* DMA cache coherency */
 
+static inline int to_iommu_prot(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		return IOMMU_READ | IOMMU_WRITE;
+	case DMA_TO_DEVICE:
+		return IOMMU_READ;
+	case DMA_FROM_DEVICE:
+		return IOMMU_WRITE;
+	default:
+		return 0;
+	}
+}
+
 struct iommu_ops;
 struct iommu_group;
 struct bus_type;
-- 
1.8.1.5
