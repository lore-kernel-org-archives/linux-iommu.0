From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 5/5] ARM: dma-mapping: Introduce dma_map_linear_attrs() for IOVA
	linear map
Date: Wed, 29 Aug 2012 09:55:35 +0300
Message-ID: <1346223335-31455-6-git-send-email-hdoyu@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1346223335-31455-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Introduce a helper function, dma_map_linear(_attrs)() to create IOVA
linear map, where IOVA and kernel virtual addresses are mapped at the
same address linearly. This is useful to support legacy device drivers
which expects no IOMMU.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h       |   13 +++++++++++++
 include/asm-generic/dma-mapping-common.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index f04a533..7a78dd4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -212,6 +212,19 @@ static inline size_t dma_iova_get_free_max(struct device *dev)
 	return ops->iova_get_free_max(dev);
 }
 
+static inline dma_addr_t dma_map_linear_attrs(struct device *dev, void *va,
+				      size_t size, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	dma_addr_t da;
+
+	da = dma_iova_alloc_at(dev, (dma_addr_t)va, size);
+	if (da == DMA_ERROR_CODE)
+		return DMA_ERROR_CODE;
+
+	return dma_map_single_at_attrs(dev, va, da, size, dir, attrs);
+}
+
 /**
  * arm_dma_mmap - map a coherent DMA allocation into user space
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index eada2d8..4564bf0 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -191,6 +191,7 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
 #define dma_map_single_at(d, a, h, s, r)		\
 	dma_map_single_at_attrs(d, a, h, s, r, NULL)
+#define dma_map_linear(d, a, s, r) dma_map_linear_attrs(d, a, s, r, NULL)
 #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
 #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
-- 
1.7.5.4
