Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77B37D10D
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793461; cv=none; b=ugt0EEnSGJbi3O7mQ3zF9rzGU0xdi0Dqcf2X1WCk9dOuvJZHsgGoDk92OiOFDid9tsZd6YImH+GJu4takVT2oED6BJ3VDPZcF4xnfPPChnVTBOtMgGLiCy3nO/9vjU7LNQ2KdtWoxAnZ9zH0UOMeCnrDH+YRMba62a96tuArLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793461; c=relaxed/simple;
	bh=u/febRDM30JzV4zi0O2oWhXMCmjL4J3mUC+OUI296Uo=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=rPN1CVb94+1oMlOBQZ445XlPXNY4uFk5jYj98DRA1bsHPQW7v9DCV+9KeYe2PeGyB3wL0dkbNSG1t+5NOwDOMPyhckJSFUuu2dJYJYitOYGaB5oirvXZBuWQAGngvXOT5u1HaLrqRvgkU39Rd8xsuLv65skTwlaanYKxXsc6SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4pr6TGJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4pr6TGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772793459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1W1JFb09fQZLTmuNIkzg7O2smMWNXHTw+tCky9f0yA=;
	b=G4pr6TGJcJJwnp3PsWrqOH8+NQ0+xbIrPPjee3AlDjBpfOeFj5P7OPI/f09HFXQvb6hDtN
	vGhDM9+ZnkLa0SAYSJlZ3IYpIC1YxrUhTOo9TM/8bfm3dJW+7qqPEg+w9fxV9rKSLPEHWn
	Hzyti1JAyeij9aVdxY7L16KfGadzjM0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-MnqftG4TNyCRK-vj5TQNCg-1; Fri,
 06 Mar 2026 05:37:34 -0500
X-MC-Unique: MnqftG4TNyCRK-vj5TQNCg-1
X-Mimecast-MFC-AGG-ID: MnqftG4TNyCRK-vj5TQNCg_1772793452
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0F7D18005B0;
	Fri,  6 Mar 2026 10:37:32 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C717180035F;
	Fri,  6 Mar 2026 10:37:27 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 06 Mar 2026 11:36:35 +0100
Subject: [PATCH v3 4/6] dma: coherent: store reserved memory coherent
 regions
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260306-b4-dmabuf-heap-coherent-rmem-v3-4-3d00d36c9bc4@redhat.com>
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
In-Reply-To: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@redhat.com, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772793417; l=3959;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=u/febRDM30JzV4zi0O2oWhXMCmjL4J3mUC+OUI296Uo=;
 b=ox/FLKFGG37y3D4eZEeuwpjANM+kMoZ40TSyVRxSl1Ey8IISOiKa4rN8VqUqJSo2qSnDVNqH6
 fpEmrmFeDwyCRLDpE2qyCTx7NCMG7X+GpX6EubQV3mDuWjEh1pthLL6
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 9-yZkPs3TtN1qQ9uZinThI_ej93kriQ2t7iLLZgEZOA_1772793452
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Create the logic to store coherent reserved memory regions
within the coherent DMA code; and provide an iterator
(i.e., dma_coherent_get_reserved_region()) to allow
consumers of this API retrieving the regions.

Note: since the consumer of this iterator is going
to be the specific coherent memory dmabuf heap module, this
commit introduces a check for CONFIG_DMABUF_HEAPS_COHERENT,
which is defined in the subsequent patch, to maintain a
clean split between the kernel code and the heap
module code.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/linux/dma-map-ops.h |  7 +++++++
 kernel/dma/coherent.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 60b63756df821..c87e5e44e5383 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -12,6 +12,7 @@
 
 struct cma;
 struct iommu_ops;
+struct reserved_mem;
 
 struct dma_map_ops {
 	void *(*alloc)(struct device *dev, size_t size,
@@ -161,6 +162,7 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
+struct reserved_mem *dma_coherent_get_reserved_region(unsigned int idx);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -172,6 +174,11 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
 static inline void dma_release_coherent_memory(struct device *dev) { }
+static inline
+struct reserved_mem *dma_coherent_get_reserved_region(unsigned int idx)
+{
+	return NULL;
+}
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 1147497bc512c..d0d0979ffb153 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
+#include <linux/dma-heap.h>
 
 struct dma_coherent_mem {
 	void		*virt_base;
@@ -334,6 +335,31 @@ static phys_addr_t dma_reserved_default_memory_base __initdata;
 static phys_addr_t dma_reserved_default_memory_size __initdata;
 #endif
 
+#define MAX_COHERENT_REGIONS 64
+
+static struct reserved_mem *rmem_coherent_areas[MAX_COHERENT_REGIONS];
+static unsigned int rmem_coherent_areas_num;
+
+static int rmem_coherent_insert_area(struct reserved_mem *rmem)
+{
+	if (rmem_coherent_areas_num >= MAX_COHERENT_REGIONS) {
+		pr_warn("Deferred heap areas list full, dropping %s\n",
+			rmem->name ? rmem->name : "unknown");
+		return -EINVAL;
+	}
+	rmem_coherent_areas[rmem_coherent_areas_num++] = rmem;
+	return 0;
+}
+
+struct reserved_mem *dma_coherent_get_reserved_region(unsigned int idx)
+{
+	if (idx >= rmem_coherent_areas_num)
+		return NULL;
+
+	return rmem_coherent_areas[idx];
+}
+EXPORT_SYMBOL_GPL(dma_coherent_get_reserved_region);
+
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
 	struct dma_coherent_mem *mem = rmem->priv;
@@ -393,6 +419,14 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	rmem->ops = &rmem_dma_ops;
 	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+
+	if (IS_ENABLED(CONFIG_DMABUF_HEAPS_COHERENT)) {
+		int ret = rmem_coherent_insert_area(rmem);
+
+		if (ret)
+			pr_warn("Reserved memory: failed to store coherent area for %s (%d)\n",
+				rmem->name ? rmem->name : "unknown", ret);
+	}
 	return 0;
 }
 

-- 
2.52.0

