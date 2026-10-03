Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F314756B1
	for <iommu@lists.linux.dev>; Sat,  3 Oct 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062580; cv=none; b=Ky4ylVNpiNjgkCb5fCnRHH+ZMDqcfcbEneE/CrX5P2Ge42kN7IY80eW3EWDUK1A/HnvWbMMtQyXvu1MqTj9fNMz6IUAI+6I3nebUlaNCVDnXumiHzORg/XzVvoU4rFp8Fx1ls+TN1XuUMhg/oaOoTmpSXrCiYihVu9WVgVELrVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062580; c=relaxed/simple;
	bh=U8RNAYPwdoQExd0IJwJncQoxnMffVhmPgyoptdGWgrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/x3H9CaQFYxYuo52LnnymBdT+5f1pmbPV25a8wIpYCpi7vJM6Hm0nG/7+Xc7B4y3fgPgHZX0bOyyFTHBZBcSYEIWBsEB0V+fuU3NW/3At8L9R5r80fT0JxQ0QGDYYrMLTDWP+iztDvMnDePegRyLw6OqxPzrZ0KJoI392JVkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjOp4Qwr; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjOp4Qwr"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6ae551724a0so366064a12.2
        for <iommu@lists.linux.dev>; Sat, 03 Oct 2026 14:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062575; x=1791667375; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agV1iLTkSM8BP/RETmEVpwWxRosSitnKJRX5SSlYpX4=;
        b=UjOp4QwrRtIKINUjVlycbZ92HMtvsoDJB/FF0pbGKCmVw38aBwu15dSQWnndlYjeu5
         QRQmdCKE0J1Fl49miG4LFFgtQwHG3wkyFxnLal9XNR1xpF3P7LsDofmvY8X4muFmaq3H
         EeYqNvw5QUL8ELtIMFmB3eEFmKZrgrDKkZx2MgfYoD1xiSG5GgOe00/APskbicm73Kn6
         Jsr3n5Ta5gOE+OOxriVS1ghgi8JUOaaOIRucYdfRulyinSAXFL5lYY1yj+p780eWQqm8
         YRX5tgxNLT4TWwHuYtsnCLKoDjezR+MIst6giYeAThfOOhFxHxFSGRxok1Bnf4D4RVqw
         HXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062575; x=1791667375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agV1iLTkSM8BP/RETmEVpwWxRosSitnKJRX5SSlYpX4=;
        b=nYqu2lwgkCSAfBsSgp0LdBy3twsWYk8Fop6q7JSSdHQbqGpKMXfRsWMOJYpba6MmWN
         +ifdZwI0eRHBEl8pt/xRoZaN1clgIkTTL6MppVvHDNG+uK5W6sE/f/5Y7dy8N49Zk1hn
         9OSvrvC3FkvB0ifXqjUF/3PmJjHdwb2I4rgODhGgpbDl3ndAfPRlc3qzDDHwd73CGYP8
         rNcIGRcze2SnYSagjnHF8ojpOW7SRvrskDZ+bcX4tTUfWNPcU/b3Ud5a5YVVG60Hds6F
         dRtEJ1o3B51M4B0hSI96s2XNx2uybC/fk1LfSC5/0Tg1J5RSbOBWFGxMI3UM8dQ1xLoG
         tX0w==
X-Forwarded-Encrypted: i=1; AKwUvBzGGNhzzew51EoaK3AvtpNTu3q+F1ns/IOCvU1iRjl1MJcjx0oHKUJrtA5+Oz7WSMSr0gWSng==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfCQcqYAjzO6c55uOqtBW9HPclW7a0xGHC67saj5/n1CF2Kn19
	qg0K/93T4Y6V49ZVHTtLFEtmVR+2i5ts7JLmghDllGhjTwfPPhYYeoy3izi0y4sgL9SZ0e9nQw1
	sUhsM0g==
X-Received: from edqh23.prod.google.com ([2002:aa7:c617:0:b0:6ab:70:34b5])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2753:b0:6aa:fc60:60b7
 with SMTP id 4fb4d7f45d1cf-6af9e349d83mr4895409a12.44.1791062574444; Sat, 03
 Oct 2026 14:22:54 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:22:25 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212241.3432303-7-lrizzo@google.com>
Subject: [RFC: DMA_PMD 06/22] iommu/dma: reserve a per-domain IOVA window for
 DMA_PMD pages
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Embed struct dma_pmd_window in struct iommu_dma_cookie to record the
per-domain IOVA range reserved for DMA_PMD mappings, and expose the
cookie accessors (dma_pmd_dma_window(), dma_pmd_dma_iovad(),
dma_pmd_window_owns()) and dma_info_to_prot() needed by the DMA_PMD
mapping layer in subsequent patches.

No functional change.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/dma-iommu.c     | 39 ++++++++++++++++++-
 drivers/iommu/dma-iommu.h     |  8 ++++
 drivers/iommu/dma-pmd-kunit.c | 19 +++++++++
 drivers/iommu/dma-pmd-priv.h  | 72 +++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd43..70aee7a3020c8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -18,6 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/huge_mm.h>
 #include <linux/iommu.h>
+#include <linux/dma-pmd.h>
 #include <linux/iommu-dma.h>
 #include <linux/iova.h>
 #include <linux/irq.h>
@@ -36,6 +37,7 @@
 #include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
+#include "dma-pmd-priv.h"
 #include "iommu-pages.h"
 
 struct iommu_dma_msi_page {
@@ -75,6 +77,8 @@ struct iommu_dma_cookie {
 	struct iommu_domain *fq_domain;
 	/* Options for dma-iommu use */
 	struct iommu_dma_options options;
+	/* IOVA window reserved for DMA_PMD pages. Nothing else can go here. */
+	struct dma_pmd_window win_dma_pmd;
 };
 
 struct iommu_dma_msi_cookie {
@@ -732,7 +736,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
  *
  * Return: corresponding IOMMU API page protection flags
  */
-static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
+int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 		     unsigned long attrs)
 {
 	int prot;
@@ -1214,6 +1218,39 @@ static inline size_t iova_unaligned(struct iova_domain *iovad, phys_addr_t phys,
 	return iova_offset(iovad, phys | size);
 }
 
+/**
+ * dma_pmd_dma_window - This domain's IOVA window for DMA_PMD
+ * @domain: Domain to look at
+ *
+ * For the DMA_PMD code's slow paths, which need a window but do not have the
+ * cookie layout. The DMA map path is handed the pointer by its caller instead,
+ * so this is never called at map frequency.
+ *
+ * Return: the window, or NULL if @domain is NULL or does not carry a DMA-IOVA
+ * cookie. The cookie shares a union with the MSI, iommufd and fault-handler
+ * ones, so the type has to be tested rather than the pointer. An identity,
+ * passthrough, or MSI-only domain has no window, and a device can be moved to
+ * one after its pool was created (e.g. via sysfs domain type changes or VFIO
+ * attachment).
+ */
+struct dma_pmd_window *dma_pmd_dma_window(struct iommu_domain *domain)
+{
+	/*
+	 * Also decline in kdump kernels (iommu_deferred_attach_enabled);
+	 * dma_pmd_dma_iovad() uses this check so win->size stays 0.
+	 */
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled) ||
+	    !domain || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
+		return NULL;
+
+	return &domain->iova_cookie->win_dma_pmd;
+}
+
+struct iova_domain *dma_pmd_dma_iovad(struct iommu_domain *domain)
+{
+	return dma_pmd_dma_window(domain) ? &domain->iova_cookie->iovad : NULL;
+}
+
 dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d002525632..241f8de002e50 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -7,6 +7,9 @@
 
 #include <linux/iommu.h>
 
+struct dma_pmd_window;
+struct iova_domain;
+
 #ifdef CONFIG_IOMMU_DMA
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
@@ -22,6 +25,11 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 		     phys_addr_t msi_addr);
 
+int dma_info_to_prot(enum dma_data_direction dir, bool coherent, unsigned long attrs);
+
+struct iova_domain *dma_pmd_dma_iovad(struct iommu_domain *domain);
+struct dma_pmd_window *dma_pmd_dma_window(struct iommu_domain *domain);
+
 extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
diff --git a/drivers/iommu/dma-pmd-kunit.c b/drivers/iommu/dma-pmd-kunit.c
index 4e38cc5970433..16312014b8976 100644
--- a/drivers/iommu/dma-pmd-kunit.c
+++ b/drivers/iommu/dma-pmd-kunit.c
@@ -140,11 +140,30 @@ static void test_pool_alloc_and_recycle(struct kunit *test)
 	dma_pmd_pool_destroy(pool_wm);
 }
 
+static void test_window_helpers(struct kunit *test)
+{
+	struct dma_pmd_window win = {};
+
+	KUNIT_ASSERT_EQ(test, dma_pmd_meta_init(), 0);
+
+	/* Empty window (size == 0) never owns any IOVA. */
+	KUNIT_EXPECT_FALSE(test, dma_pmd_window_owns(&win, 0));
+	KUNIT_EXPECT_FALSE(test, dma_pmd_window_owns(&win, SZ_4G));
+
+	win.base = SZ_4G;
+	win.size = SZ_2G;
+	KUNIT_EXPECT_FALSE(test, dma_pmd_window_owns(&win, SZ_4G - 1));
+	KUNIT_EXPECT_TRUE(test, dma_pmd_window_owns(&win, SZ_4G));
+	KUNIT_EXPECT_TRUE(test, dma_pmd_window_owns(&win, SZ_4G + SZ_2G - 1));
+	KUNIT_EXPECT_FALSE(test, dma_pmd_window_owns(&win, SZ_4G + SZ_2G));
+}
+
 static struct kunit_case dma_pmd_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_init_and_roundtrip),
 	KUNIT_CASE(test_meta_invalid_phys),
 	KUNIT_CASE(test_meta_pooled_toggle),
 	KUNIT_CASE(test_pool_alloc_and_recycle),
+	KUNIT_CASE(test_window_helpers),
 	{}
 };
 
diff --git a/drivers/iommu/dma-pmd-priv.h b/drivers/iommu/dma-pmd-priv.h
index 39295d0add51d..8104897572921 100644
--- a/drivers/iommu/dma-pmd-priv.h
+++ b/drivers/iommu/dma-pmd-priv.h
@@ -9,10 +9,46 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+/**
+ * struct dma_pmd_window - A domain's IOVA window reserved for DMA_PMD pages
+ * @base: First IOVA of the window. A page at @phys is mapped, in every domain
+ *        that has a window, at @base + @phys.
+ * @size: Window size in bytes, or 0 if this domain has no window, either
+ *        because nothing has pooled through it yet, or because it could not
+ *        find a free range that large. 0 must make both the map and the unmap
+ *        side decline, see dma_pmd_window_owns().
+ * @domain_idx: Dense domain index + DMA_PMD_IDX_FIRST, used for per-PMD-page
+ *       presence (bit @domain_idx - DMA_PMD_IDX_FIRST), or one of
+ *       DMA_PMD_IDX_NONE, DMA_PMD_IDX_NOHUGE or DMA_PMD_IDX_NOSPACE while
+ *       @size is 0. Of the three sentinels, only DMA_PMD_IDX_NONE is retried.
+ *
+ * Lives in the domain's iommu_dma_cookie. The window is a real allocation out
+ * of the domain's iova_domain, so no ordinary IOVA can ever fall inside it,
+ * which is what lets the unmap path recognise a pooled IOVA by range alone.
+ */
+struct dma_pmd_window {
+	dma_addr_t base;
+	u64 size;
+	u16 domain_idx;
+};
+
 #ifdef CONFIG_DMA_PMD
 
 #define DMA_PMD_BLOCKS(order)		(1U << (PMD_ORDER - (order)))
 
+/*
+ * Sentinel values of dma_pmd_window.domain_idx below DMA_PMD_IDX_FIRST:
+ * never attempted (0, matching kzalloc), or permanently declined. A real
+ * domain index is >= DMA_PMD_IDX_FIRST (subtract DMA_PMD_IDX_FIRST for
+ * the bitmap bit position).
+ */
+enum {
+	DMA_PMD_IDX_NONE,	/* not attempted yet */
+	DMA_PMD_IDX_NOHUGE,	/* @domain can never pool */
+	DMA_PMD_IDX_NOSPACE,	/* no index or no IOVA range */
+	DMA_PMD_IDX_FIRST,	/* first valid domain index */
+};
+
 /*
  * Locking
  * -------
@@ -167,5 +203,41 @@ struct dma_pmd_meta *dma_pmd_meta_from_phys(phys_addr_t pa);
 unsigned long dma_pmd_meta_to_pfn(const struct dma_pmd_meta *m);
 phys_addr_t dma_pmd_meta_to_phys(const struct dma_pmd_meta *m);
 
+static inline bool dma_is_pmd_phys(phys_addr_t phys)
+{
+	return dma_is_pmd_page(phys >> PAGE_SHIFT);
+}
+
+/**
+ * dma_pmd_window_owns - Was @dma handed out by a DMA_PMD mapping?
+ * @win: The unmapping domain's window
+ * @dma: IOVA being unmapped
+ *
+ * Only DMA_PMD pages can be mapped within the reserved IOVA window
+ * so a range check suffices.
+ * A domain that has no window has @size 0, so the unsigned subtraction
+ * underflows to a huge value and the test is always false. That is the same
+ * check that stops the map path from using a window the domain does not own.
+ */
+static inline bool dma_pmd_window_owns(const struct dma_pmd_window *win, dma_addr_t dma)
+{
+	/* Acquire pairs with the release of @size in dma_pmd_window_assign(). */
+	u64 size = smp_load_acquire(&win->size);
+
+	return size && dma - win->base < size;
+}
+
+#else /* !CONFIG_DMA_PMD */
+
+static inline bool dma_is_pmd_phys(phys_addr_t phys)
+{
+	return false;
+}
+
+static inline bool dma_pmd_window_owns(const struct dma_pmd_window *win, dma_addr_t dma)
+{
+	return false;
+}
+
 #endif /* CONFIG_DMA_PMD */
 #endif /* _DRIVERS_IOMMU_DMA_PMD_PRIV_H */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

