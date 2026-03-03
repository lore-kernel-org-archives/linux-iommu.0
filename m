Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482634A3B4
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541292; cv=none; b=dJIh0N0/nNcqvDANOPCMkKJlFpbG4USMcwupbaK7ri+hkBVPr4yNpoWY0Y2Tw7Kocmnkqjh9M7zo6R2+AHfUw280Xv95HRzHlmkrchqzAc7gzFPhbymkEQMAyZGXZjUgWNSLrUnuz+JOy/BBdAmZh6/Cm4qvQYd0agxVrU80u5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541292; c=relaxed/simple;
	bh=lrvc9MWslkCTI2B+p97908kyghT5uZlrlNqzW9O5SpY=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=dyikXq6ZGs6ixPaAovmrmUpgLP5f8UQ7zF0QI7N4UXu2HjnABRreslBEEdQJVOyxYR/aK9dPcUXgHgVW4hD6KTWakNgiGPI1/6i8zUZ7By7H/Z6Xo7nVXbKtXaqXS0+QQaM/CSkKOQhdnxA1kSywIT3xsLCz7Hdl598N0IEcII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vd9/gPli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd9/gPli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1UE53XZ4lch6jevT017UAHnSaeVjSTyhkHggOjem0k=;
	b=Vd9/gPliAv9F3MKiXHENhM0GEKnEopOe//wWrWuLSaqp8Wh8txHoznGm+fF5Ck23G4C6j+
	NHcL7lyTUrgIybbegGdlqDKIwzvrkL9x03v8hVGY69Nd924H3eak89EaHhF6POAGFdo5ry
	7fI3I+3FgN8zEhUjExM/19357FnQsxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-U_kfqHQZPh6gdPfelQmprw-1; Tue,
 03 Mar 2026 07:34:45 -0500
X-MC-Unique: U_kfqHQZPh6gdPfelQmprw-1
X-Mimecast-MFC-AGG-ID: U_kfqHQZPh6gdPfelQmprw_1772541283
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542EA1956051;
	Tue,  3 Mar 2026 12:34:43 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.44.32.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 975DE30001B9;
	Tue,  3 Mar 2026 12:34:37 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 03 Mar 2026 13:33:48 +0100
Subject: [PATCH v2 5/6] dma: coherent: register to coherent heap
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260303-b4-dmabuf-heap-coherent-rmem-v2-5-65a4653b3378@redhat.com>
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
In-Reply-To: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
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
 Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772541243; l=2169;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=lrvc9MWslkCTI2B+p97908kyghT5uZlrlNqzW9O5SpY=;
 b=jLQqlRlnj7PRlCbO13o5sKaHNOI4ilEetAb8IzQq+Dinq87XdXnqlAWW/1/+f0nHz6U9Xht/K
 eb4/cQpBROmA/RFPjeX810ZnIgdDeGY5Lqjt+uKXdScoH64Zwa45gpV
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 4eAwatuslQcjSRM2TvWdW9Vbj79Yyd0mLvaT2GHqlPM_1772541283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add dma_heap_coherent_register() call within
reserved memory DMA setup logic for non-reusable
DT nodes.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 kernel/dma/coherent.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

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

