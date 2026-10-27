Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067969;
	b=q1xlirvW7viKX1rrcbfa8GSgzW0vd4imy/a8VFYx0Bp9MHBtk1n/ukHbfibbJ/0FFlpi
	 Xyo+1+zsh/bWKC+I3yw7w7/co4PM/Iov5hvdgf9M74g9efWk+WuvgBfAkjm2eIhSXN9N3
	 fDp1gK+mMDrm60InEyto0U9pmDsKmicA0ZUeJrXexieNi6pAoh9xMYKqz+Nyhyu/L9eDJ
	 hD+AVhJZqhVdb+b89dIVAU+Lnuhvwfff0DizJXTusnGx0+Wc7JVy+bl848ZZxo0lx73eW
	 5k9MudMJZppYvcpR4mNPmxSysvH9Unb5rW+CIQbHhdlaquj/yKTARBhlTyzuy8gqxZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kSo9ezB/nyoRpQu8DQsgyWH7OReT/JhttByezR12QfI=;
	b=BX6f9Sjn8Qcyr2yGRaEhuHU9Nsrzzb/8gLF/G9Diz1A6owkotG0gvNnI07OLSKZsJoS2
	 a6j463GmqgtbIa/zwBD4SXmLSNNsrl66/nEUB5u74LzXqqg7124iLJ+5nV9Z08VbciN20
	 EXMRGtlAPCdN7VrPOqHp+W3r1zGLff87uotAybS2ZocwLhjdwKNDAN6Kx344iJb821QlB
	 Xu89M9w0xGo94UPYdHzsEIj4hrMqFXxP//yke9chxy6vUci+dbaTtII79TV+jJcFsX+AI
	 D/5GnT2lw+xhKzH77nmflNA+8Ibel5y0cEBor4Y2iK/vtXy8yFrrf16EFFW+AYpjLig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhxTCwMF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A2606A33B;
	Tue, 27 Oct 2026 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhxTCwMF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D271F031E1;
	Tue, 27 Oct 2026 02:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067969;
	bh=kSo9ezB/nyoRpQu8DQsgyWH7OReT/JhttByezR12QfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jhxTCwMFLgEcx0qW+GqDMPrAO/pdR+F4j7I8rT5CS1M2vJETUrIrGaH75xx79tMl6
	 S05ilT67HA1WahhJOmrzmR8lPKhNd6GOZUt0yu+vguX6bB8w5hxxGi++fIem8OJwT7
	 GmbZP7CPgXfL85PgOoBmD2Tvds4kKjm/1GOUggXMJEgdCVEDhoNL4q8aXBDuxbyRvs
	 O7I7uu4RZWinHnkvww8HK06JO+2aA9r9kASw+2wJYvJ6jBfLObsvEITgQfgniwYt6v
	 29rJYmb4F6+mnGfOXA7xD65mVypWnJMW2lDACRok40k6Qm6zQgPEgmTqdmN7Z8j50H
	 xecWBlSWsXYFg==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: tglx@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:21 -0700
Message-ID: <20261027022528.633359-5-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027022528.633359-1-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
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
dev_to_node(). The node is only a preference, the same as for
kmalloc_node(). It is honored by dma-direct and iommu-dma, for both
the page allocator and the per-numa CMA areas. Allocations from fixed
pools and from dma_map_ops->alloc implementations ignore it.

The memory is freed with the existing dma_free_attrs() /
dma_free_coherent(), freeing does not depend on the node.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/core-api/dma-api.rst | 15 ++++++++++++++
 include/linux/dma-mapping.h        | 14 +++++++++++++
 kernel/dma/mapping.c               | 32 ++++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index ba23a472f794..f9a32b8c338f 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -57,6 +57,21 @@ The flag parameter allows the caller to specify the ``GFP_`` flags (see
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
+descriptor rings serviced by that CPU. Pass NUMA_NO_NODE for no preference.
+
+Like with kmalloc_node() the node is only a preference. Memory allocated from
+per-device or restricted pools, or by platforms with custom DMA ops may come
+from a different node. The memory is freed with dma_free_coherent().
+
 ::
 
 	void
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a3e880649fa4..71fbfc101ab9 100644
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
index 4ace4b68c9c2..9a90790d5c66 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -630,8 +630,24 @@ u64 dma_get_required_mask(struct device *dev)
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
+ * Allocations served from per-device or restricted pools, atomic pools,
+ * or by dma_map_ops implementations do not take @node into account.
+ *
+ * Return: the CPU address of the allocation, or NULL on failure.
+ */
+void *dma_alloc_attrs_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs, int node)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
@@ -666,10 +682,10 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs,
-					    dev_to_node(dev));
+					    node);
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs,
-					   dev_to_node(dev));
+					   node);
 	} else if (ops->alloc) {
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
 	} else {
@@ -683,6 +699,14 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
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

