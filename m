Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990688;
	b=s2jeKkHYUzthj8035V0in4dy0K2nhi9L9GV7MJIMuR24aJK6aclDFW+Rti1E/6v/MTnT
	 WDoJGAWxGp/vjHhQAdYPEPVEAGWLojrpxx8ymAUJBcaN1Zoe8SM8/xiX9bgJoiObzD7VO
	 mh4b/bR6wXCJbSAOv8fMyGpdsrDww/wAT/uAXgfvJRJb80dTB8zgRrkcdbfUrAGwgBMDM
	 XthhYuhp59KkxuraFGL1E0WhclmfzdNLqoiTaGdO1wGSLfEBSB503oWguYG8xZ3y12LhB
	 3MPBR6Loe15rOTDvcv+IGJahQujX9jyk4/CIlBsvHcCKwY3//MQGoQzo/z7tFa8OH+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QmFP7520H75kzWI9PTpYCXoHZvyfrvHeprqX3YXP2M0=;
	b=UmmoGj90KHnPGN0t6FELpmyeh8uuc+L6U+9KtM7hf0kJOAxr28AuQgBNf8rxPOltABEm
	 kwy8xc0DW11uBzNgqnnOP8b3a05uK67PQrBLjd7PIUPQK9Rw4lFgkaA/75CXRNcR03xtT
	 2D/xGgIX8h+8EPIeGNIB11iB2ejvbJFrvo0hzpVeAGen4RnV6aqjc0Of49OS9EBbgZL0E
	 3JZRdGdpn+cCWdbuDQcZTX7AZESPW6OkJKH8akl/pFYucH3j094iuIZlQ2eZP6UAtGBbf
	 zKBjRGJKBgaOlLB19rU1egFTqjBqgjig2oVG4/xcwn4wBp10M+EcIdnSR0L+t/0f/rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZojH4oS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC0606A332;
	Fri,  6 Nov 2026 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZojH4oS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E291F008A1;
	Fri,  6 Nov 2026 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990687;
	bh=QmFP7520H75kzWI9PTpYCXoHZvyfrvHeprqX3YXP2M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZojH4oSyrlIqKHzS8VOsI/dkde+Bj2Om9CREJhHuw6iczlu9rp+yaQNj9DsgGW4i
	 rRxYZTRInWHATEo9b4NIXZMKMvy0Br5Ac/wG47xxiwRgFijENHkeShtbwNIw+fS8Pv
	 1GejHC2tBWasKEmZS5vG5mBnc6u5kbKfTYiS0dB53CNzsqCmV0rTbCmyYVEBYmaGO3
	 arWXAqCQEGrmKp+QFc6uiKQSGBcTHbsNbqH0GI+zpvrw2VUDhlBRfhYfSlcB06or3Q
	 Eu/WmQDFkP6OGCCGQ3Fo3cZ19TetjuzCkiWaE0Vp6bCKbiDrxdsvcymbj/CIdnn4ku
	 DRX2QUHuwiFzA==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 01/11] dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:23 -0800
Message-ID: <20261106184433.761422-2-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Coherent DMA memory is always allocated on the NUMA node of the device.
That's the right choice for memory mostly accessed by the device, but
some coherent allocations are accessed by the CPU on every operation.
For example a NIC's descriptor and completion rings are written and
read by the CPU servicing the queue, which may well be on a different
node than the device. Placing such rings on the device's node means
the CPU accesses remote memory in the fast path.

Drivers work around this today by temporarily changing the node
of the device with set_dev_node() around dma_alloc_coherent()
(mlx4, mlx5, ixgbe, xgbe). This is racy against anything else
looking at the device's node at the same time.

Add dma_alloc_attrs_node() which takes the node explicitly, and
a dma_alloc_coherent_node() wrapper. dma_alloc_attrs() now passes
dev_to_node().

The node is only a preference, the same as for kmalloc_node().
Nothing takes it into account yet, following patches wire it up
in dma-direct and iommu-dma. Allocations from fixed pools and from
dma_map_ops->alloc implementations will keep ignoring it.

Add an explicit new export instead of using static inline wrappers
because we want the new API to be GPL-only.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1:
 - move before the patches wiring up the node in dma-direct, iommu-dma
   and CMA (Robin)
 - dma-api.rst: drop the NUMA_NO_NODE suggestion (Björn)
 - docs: describe how the node is handled in the patches wiring it up,
   drop the mention of dma_free_coherent()
 - explain the separate GPL-only export in the commit message (Marek)
rfc: https://lore.kernel.org/20261027022528.633359-5-kuba@kernel.org
---
 Documentation/core-api/dma-api.rst | 13 +++++++++++++
 include/linux/dma-mapping.h        | 14 ++++++++++++++
 kernel/dma/mapping.c               | 26 ++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 69d4ebe4f96d..5d079507ffa1 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -57,6 +57,19 @@ The flag parameter allows the caller to specify the ``GFP_`` flags (see
 kmalloc()) for the allocation (the implementation may ignore flags that affect
 the location of the returned memory, like GFP_DMA).
 
+::
+
+	void *
+	dma_alloc_coherent_node(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flag, int node)
+
+Same as dma_alloc_coherent(), but places the memory on the given NUMA node
+rather than on the node of the device. This is useful for memory accessed
+frequently by both the device and a CPU on a different node, for example
+descriptor rings serviced by that CPU.
+
+Like with kmalloc_node() the node is only a preference.
+
 ::
 
 	void
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index efde0e5a58dc..f8529f761823 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -188,6 +188,8 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
+void *dma_alloc_attrs_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_handle, unsigned long attrs);
 void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
@@ -273,6 +275,11 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 {
 	return NULL;
 }
+static inline void *dma_alloc_attrs_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node)
+{
+	return NULL;
+}
 static inline void dma_free_attrs(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
 {
@@ -626,6 +633,13 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline void *dma_alloc_coherent_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, int node)
+{
+	return dma_alloc_attrs_node(dev, size, dma_handle, gfp,
+			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0, node);
+}
+
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 82e701648d60..1b1cd3bc4a40 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -630,8 +630,22 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
-void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t flag, unsigned long attrs)
+/**
+ * dma_alloc_attrs_node - allocate coherent memory on a given NUMA node
+ * @dev: device to allocate the memory for
+ * @size: size of the allocation
+ * @dma_handle: returns the DMA address of the allocation
+ * @flag: GFP flags for the allocation
+ * @attrs: DMA_ATTR_* flags for the allocation
+ * @node: NUMA node to allocate the memory on, NUMA_NO_NODE for no preference
+ *
+ * Same as dma_alloc_attrs() but places the memory on @node rather than on the
+ * node of @dev. Like with kmalloc_node() the node is only a preference.
+ *
+ * Return: the CPU address of the allocation, or NULL on failure.
+ */
+void *dma_alloc_attrs_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
@@ -681,6 +695,14 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
 	return cpu_addr;
 }
+EXPORT_SYMBOL_GPL(dma_alloc_attrs_node);
+
+void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t flag, unsigned long attrs)
+{
+	return dma_alloc_attrs_node(dev, size, dma_handle, flag, attrs,
+				    dev_to_node(dev));
+}
 EXPORT_SYMBOL(dma_alloc_attrs);
 
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-- 
2.56.0

