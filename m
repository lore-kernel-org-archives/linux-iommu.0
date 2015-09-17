From: jglisse@redhat.com
Subject: [RFC PATCH] dma/swiotlb: Add helper for device driver to opt-out from swiotlb.
Date: Thu, 17 Sep 2015 14:22:38 -0400
Message-ID: <1442514158-30281-1-git-send-email-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Joerg Roedel <jroedel@suse.de>, Konrad Rzeszutek Wilk <Konrad.wilk@oracle.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

=46rom: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>

The swiotlb dma backend is not appropriate for some devices like
GPU where bounce buffer or slow dma page allocations is just not
acceptable. With that helper device drivers can opt-out from the
swiotlb and just do sane things without wasting CPU cycles inside
the swiotlb code.

Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
To: iommu@lists.linux-foundation.org
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Konrad Rzeszutek Wilk <Konrad.wilk@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
CC: Dave Airlie <airlied@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/dma-mapping.h       |  3 +++
 arch/x86/kernel/pci-swiotlb.c            | 18 ++++++++++++++++++
 include/asm-generic/dma-mapping-common.h |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/=
dma-mapping.h
index 953b726..b50745f 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -46,6 +46,9 @@ bool arch_dma_alloc_attrs(struct device **dev, gfp_t =
*gfp);
 #define HAVE_ARCH_DMA_SUPPORTED 1
 extern int dma_supported(struct device *hwdev, u64 mask);
=20
+#define HAVE_ARCH_DMA_OVERRIDE_SWIOTLB 1
+int dma_override_swiotlb(struct device *dev);
+
 #include <asm-generic/dma-mapping-common.h>
=20
 extern void *dma_generic_alloc_coherent(struct device *dev, size_t siz=
e,
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotl=
b.c
index adf0392..6a9efab 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -117,3 +117,21 @@ void __init pci_swiotlb_late_init(void)
 		swiotlb_print_info();
 	}
 }
+
+/* dma_override_swiotlb() -  Override swiotlb with nommu.
+ *
+ * @device: Device for which to disable swiotlb.
+ *
+ * The swiotlb infrastructure just get in the way for some devices lik=
e GPU,
+ * where things like bounce pages can not work properly or for which w=
e do not
+ * want to take slow page allocation code path. This function allows d=
evice
+ * driver opportunity to opt-out from swiotlb.
+ */
+int dma_override_swiotlb(struct device *dev)
+{
+	if (dev->archdata.dma_ops !=3D &swiotlb_dma_ops)
+		return 1;
+	dev->archdata.dma_ops =3D &nommu_dma_ops;
+	return 1;
+}
+EXPORT_SYMBOL(dma_override_swiotlb);
diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-gen=
eric/dma-mapping-common.h
index b1bc954..452d947 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -355,4 +355,11 @@ static inline int dma_set_mask(struct device *dev,=
 u64 mask)
 }
 #endif
=20
+#ifndef HAVE_ARCH_DMA_OVERRIDE_SWIOTLB
+static inline int dma_override_swiotlb(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 #endif
--=20
2.1.0
