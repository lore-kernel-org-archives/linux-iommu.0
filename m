Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992115C603
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661512; cv=none; b=tI3IWBkFD9RLWIMZVhQsXG9HmGcSfm1RDtq0DQdNy3GQ2L/PRKxv218fe8ZTz7EmVkFb/po9b+n2WL+qvmKyqyarH1/yso9jZU3Vt6TszqEPVwnRnuAma5Xr0eAr8dx/ngnN2zPeuxD53NdMkfr4cOmUhWqkZUn5iu9c26hierU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661512; c=relaxed/simple;
	bh=auEFOPcNo9yn9FubishFy/St3OM2rHNq3Vzpu75gWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIVMG3sSXpSygbsUl8mRsJH/z3s+0oqBYjFatSdOqqizv0Ul/1Vga/qdMnvvY9BGh6HZ4+w4bNCr2nUMoZM5W+4sGkiu/CO8qcXsSayUUuHHtOb+nTrLFsJaLU7FoBXyEPlNBnCGgQgadUZ+h5p//v3YupSRrKmcFc7YYSHHkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yOGSNltG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yOGSNltG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=S0D2q0CRtr7nsIrC2QE+pdlycYvNfEIhHHD+EVRR84A=; b=yOGSNltGTKa74bm7s79mWGUqmT
	CxNszCYC+HUVJlDaOEtZZnaL5ejzGLnmmH3ATV30sglJgJz0ywg0uB+P+XM8lW3GKHGodpQr1GNWn
	PUJ1JuLvA6VWnEqZ7iacFWhoRFmQ92MGkjMyUD1t55zF/HMovaDyn7fACtYWCdjuwxRlrMSHy4ZAK
	LjjvW4uR2/ZGqgdPzDGWCvokPaIs4EycHOaAWkrtHJ7nngTB+aZyM+l5oZYZoa9DyjngyX6X2W4VJ
	lgq/WXgc76Q6SDusemcJW5TwpDXHK4t61tCQxTjflMGErwo5RcBXRltuQh7MUL1kfM52UDIKe0T35
	jNdj8agg==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3TyH-0000000D3O3-0Jzw;
	Wed, 23 Oct 2024 05:31:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] dma-mapping.h: drop unneeded includes
Date: Wed, 23 Oct 2024 07:31:38 +0200
Message-ID: <20241023053146.310113-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Back in the day a lot of logic was implemented inline in dma-mapping.h and
needed various includes.  Move of this has long been moved out of line,
so we can drop various includes to improve kernel rebuild times.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/pseries/svm.c | 1 +
 include/linux/dma-mapping.h          | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 3b4045d508ec..384c9dc1899a 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -8,6 +8,7 @@
 
 #include <linux/mm.h>
 #include <linux/memblock.h>
+#include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 1524da363734..b79925b1c433 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -2,15 +2,11 @@
 #ifndef _LINUX_DMA_MAPPING_H
 #define _LINUX_DMA_MAPPING_H
 
-#include <linux/cache.h>
-#include <linux/sizes.h>
-#include <linux/string.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
-#include <linux/mem_encrypt.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
-- 
2.45.2

