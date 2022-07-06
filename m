Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55B7C
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 19:51:35 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id fd6so20574619edb.5
        for <iommu@lists.linux.dev>; Wed, 06 Jul 2022 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uVRJxLaJq0X2dTEVHdjs/5npr6gEQxLAwcn1IdURs/k=;
        b=eJwRJaLjPY6p5OlY+dBZS+pQVxXthYVL1N5jmkzT/c94q/b9iLcykBlgK1Du7PYrbj
         MxeFxICUJdjjcV4pgyo6rucoawbvITuvIkDRgC3y6E0n3STMKsOWkCwG5d7oPtTTKfaQ
         CFJbvl3MaraUV2zfvMLcdpwYHQKkjh3E7iJ+ZuipphJXXm+sIz2ZtJKGA+lV1IAJKXp6
         gIDZb7UUy806TIzAtvVMLr5gXqD9LzJuCS61E1hq0d01/JhNgeMip92sz5laViF3SkKM
         OJDCVy+nMHqMI6LD/lQHtr3WAK81du9NPbq0PKiyiXcAkgdviF3QyjkUjKFU06wnf7Gi
         pZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uVRJxLaJq0X2dTEVHdjs/5npr6gEQxLAwcn1IdURs/k=;
        b=ZPR7XAUUfBPQ+pbvYjJueWHYEDl7EDIqPQGxoRAEfZ+nZlwCieJY70XvnXLfK96Sqr
         Fk2uDFu8572hIPzT7VF8q8Q39PBCT9v/OhrfVb8hPRAbv93UNIW/kouinCJM8f0WHvPZ
         bmyE06zcZokacylcZzaqt4qcSrF184Y126YTze703RhGtQgS5wHCEekLqsXCidCy0IUR
         IugJNG0ZTJTCOek39yfimYQTnnl02DUJmLOVtbvSK8HCcEywbSml4MBgXi8KmVek8Alp
         Gjwrx0KUflHF4lLBM1SF+6639aknmJsPHMq82MOaBOJxmU5KSSUZHlRK+4l/tNm+JjOq
         tXzg==
X-Gm-Message-State: AJIora9LT6bpgk8fPMSaHRz3e1EHO8RZJm2v98XsfvNwpJYuYspBk6jN
	km2aINbElwfEgZ+aJHcMGFY=
X-Google-Smtp-Source: AGRyM1tywxH6QPdE1PtguR+LhaF12MVypJNb2omAg0HEbg3t9kWKGwOUtVflZEIr6YXGTMyib1Cy6w==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr56253345edr.158.1657137093482;
        Wed, 06 Jul 2022 12:51:33 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-199-193.retail.telecomitalia.it. [79.49.199.193])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b0072af18329c4sm1968127ejc.225.2022.07.06.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:51:33 -0700 (PDT)
From: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	"Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 2/2] dma-direct: Fix dma_direct_{alloc,free}() for Hyperv-V IVMs
Date: Wed,  6 Jul 2022 21:50:27 +0200
Message-Id: <20220706195027.76026-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706195027.76026-1-parri.andrea@gmail.com>
References: <20220706195027.76026-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Hyper-V AMD SEV-SNP Isolated VMs, the virtual address returned by
dma_direct_alloc() must map above dma_unencrypted_base because the
memory is shared with the hardware device and must not be encrypted.

Modify dma_direct_alloc() to do the necessary remapping.  In
dma_direct_free(), use the (unmodified) DMA address to derive the
original virtual address and re-encrypt the pages.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Co-developed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 kernel/dma/direct.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06b2b901e37a3..c4ce277687a49 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/slab.h>
+#include <linux/io.h> /* for memremap() */
 #include "direct.h"
 
 /*
@@ -305,6 +306,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
 			goto out_free_pages;
+#ifdef CONFIG_HAS_IOMEM
+		/*
+		 * Remap the pages in the unencrypted physical address space
+		 * when dma_unencrypted_base is set (e.g., for Hyper-V AMD
+		 * SEV-SNP isolated guests).
+		 */
+		if (dma_unencrypted_base) {
+			phys_addr_t ret_pa = virt_to_phys(ret);
+
+			ret_pa += dma_unencrypted_base;
+			ret = memremap(ret_pa, size, MEMREMAP_WB);
+			if (!ret)
+				goto out_encrypt_pages;
+		}
+#endif
 	}
 
 	memset(ret, 0, size);
@@ -360,11 +376,23 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
-	if (is_vmalloc_addr(cpu_addr)) {
+	/*
+	 * If dma_unencrypted_base is set, the virtual address returned by
+	 * dma_direct_alloc() is in the vmalloc address range.
+	 */
+	if (!dma_unencrypted_base && is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
+#ifdef CONFIG_HAS_IOMEM
+		if (dma_unencrypted_base) {
+			memunmap(cpu_addr);
+			/* re-encrypt the pages using the original address */
+			cpu_addr = page_address(pfn_to_page(PHYS_PFN(
+					dma_to_phys(dev, dma_addr))));
+		}
+#endif
 		if (dma_set_encrypted(dev, cpu_addr, size))
 			return;
 	}
-- 
2.25.1

