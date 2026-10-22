Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683980;
	b=oqZBevkGmYQ/FqXUilCPMfFfnhWDdorzC7Nx4RqI4NOec+ln9Lp6mdC6UbbXQjmY0uqn
	 qOhXFD0muI4Ih3fJ4V9PxUhQAamZ8TFAHSw2VdGoPgGFHpKLlxv6H2gTiLvjXQ86M/3cg
	 +fDOj+GRY80WgW4ny7Ki7b1nQGfc+oApX6jIJ5fAF9wR5+26PtLew7cuSKFeg/SaVK5Wd
	 PHmRUSwMcgYs4Iu5LZMtb98+fj3A1CsjqzfRhPnys9aTXJL9fkqU+vNn6OXpNCK6gV6Yk
	 iWpSn8+GzM7hmzDvZXn8sOpaLgHCQiUH3CFuMrkJRbSg8YTrp8/18iy9m7MIkv5/LnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683980;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xxTPejnJdS/vYzb8yPb8KkE7+Hf7lZNZOOc1KdjszKc=;
	b=lWsdLqoSP0ri50POvZIYta25UngnCXod7W6CfCWcn4CzI9pJjmiN8pCGJFt70Js6Fsyr
	 ummmfmS67J1dUBdf6zyyUWkxhS+ms0A5NrlJIDio/WORRKh2N5stw4A+6vgtQ1Ae1OOGB
	 Uzbhxvg7SPrBPY73gafaTsYpCA/t3vnNI9Y4Hy4tfacjsCHLEKl6vHR59WHS5RgPSRhvC
	 0Hn2T4ZwQZR7RoQ5oZHmbpYtI3wkK0pOYYRUM7Lh5d06tku6GPd2hbAI+GIGnKQBFsmbm
	 PUs7Hy9/vvbIszBPfaUqLBpHkAPJ45KjbJ9N1ibLa2SkpxkXGYkInt+KrfyGAiaacqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lxBBVpbF;
	arc=none smtp.remote-ip=91.218.175.91
Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7EB606A320
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 15:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED7EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lxBBVpbF
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=b9aN3UoXeOF4eAVozHhQBDfnYXVjdCGwCFhe2u2yLGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792683978; v=1; x=1793288778;
 b=lxBBVpbFUM6j/QvZQMW4notzewuwIabFr7/AIsutSlYHjabP5CYz0TWA6XIjUuQ3oysIgolr
 X2cZKFyYVLH38E7ORtYPCPFzQVvS6Cw/aLP4/Ii90PQmLyfLOhdJ2jFItjCZTPAedR1PQ3dkB9o
 26ct4ypGSoIIyVPv/wv/QXe4=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b707346131377bb7;
	Thu, 22 Oct 2026 15:46:18 +0000
X-Mizu-Trace-ID: b707346131377bb7
X-Migadu-Flow: FLOW_OUT
From: Andrew Jones <andrew.jones@linux.dev>
To: linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tomasz.jeznach@linux.dev,
	jgg@ziepe.ca,
	jgg@nvidia.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	anup@brainfault.org,
	tglx@kernel.org,
	kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com,
	nutty.liu@hotmail.com
Subject: [PATCH v7 2/5] iommu/dma: Introduce iommu_dma_prepare_msi_list()
Date: Thu, 22 Oct 2026 17:46:00 +0200
Message-ID: <20261022154603.1374754-3-andrew.jones@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154603.1374754-1-andrew.jones@linux.dev>
References: <20261022154603.1374754-1-andrew.jones@linux.dev>
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

IMSIC needs an interface to prepare all MSI targets before an IRQ
affinity change can select one in atomic context.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  9 +++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..b8d4d601efd4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4266,4 +4266,47 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	mutex_unlock(&group->mutex);
 	return ret;
 }
+
+/**
+ * iommu_dma_prepare_msi_list() - Map the complete list of MSI targets
+ * @desc: MSI descriptor to receive the base IOVA and granule shift
+ * @phys_addrs: Ordered array of target physical addresses
+ * @nr_addrs: Number of targets in the array
+ * @granule: Size and alignment of each target mapping
+ *
+ * Every call for a DMA domain must supply the same complete list, order and
+ * granule. The first call maps the targets into one contiguous IOVA range;
+ * subsequent calls use the cached base. The array is consumed synchronously
+ * and is not retained.
+ *
+ * Each target must be aligned to @granule, which must match the DMA domain's
+ * granule and be at least PAGE_SIZE.
+ *
+ * Without a translated domain, @desc is left unchanged. Only DMA-IOMMU
+ * domains currently support translated MSI target lists.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int iommu_dma_prepare_msi_list(struct msi_desc *desc, const phys_addr_t *phys_addrs,
+			       unsigned int nr_addrs, size_t granule)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_domain *domain;
+	int ret;
+
+	if (!group)
+		return 0;
+
+	ret = iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev));
+	if (ret)
+		return ret;
+
+	guard(mutex)(&group->mutex);
+	domain = group->domain;
+	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	return iommu_dma_sw_msi_list(domain, desc, phys_addrs, nr_addrs, granule);
+}
 #endif /* CONFIG_IRQ_MSI_IOMMU */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 95e32c78dcb7..cf33169ec3e3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1560,12 +1560,21 @@ static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 #ifdef CONFIG_IRQ_MSI_IOMMU
 #ifdef CONFIG_IOMMU_API
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+int iommu_dma_prepare_msi_list(struct msi_desc *desc, const phys_addr_t *phys_addrs,
+			       unsigned int nr_addrs, size_t granule);
 #else
 static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
 					phys_addr_t msi_addr)
 {
 	return 0;
 }
+
+static inline int iommu_dma_prepare_msi_list(struct msi_desc *desc,
+					     const phys_addr_t *phys_addrs,
+					     unsigned int nr_addrs, size_t granule)
+{
+	return 0;
+}
 #endif /* CONFIG_IOMMU_API */
 #endif /* CONFIG_IRQ_MSI_IOMMU */
 
-- 
2.56.0

