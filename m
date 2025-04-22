Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14721225A39
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303857; cv=none; b=rFXjAIVrvsRNOWybX6VYd++FHh+rrDwaIqzt6uP0y1aPWEnVa6iTd9aw/ePtPNNnqZcJoBGXq9aA68v30kVjE/R4+QnDFFPN1PSaUPW2TER3kQum7XG0KBNpBNATJvpSieoNG5RlIDXXADRtIgmRaALqJWYpwc3TCDHN51OO6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303857; c=relaxed/simple;
	bh=UcdEpiXFzC8AsBaOTOkXbBE+EOhb8L2+7Sb0WBfailQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmAtKb/gQBo1jYNXLLr+Rqlt4A4zW2A/D6QVtJVuyx+0dwu/s8wdblOEm5uBxQPa53c4XHab/YRyZoMPFu+76VbkNIqDelr4+FAc7FksLyiD7AojLRHREDPE23Bvmxng3rFLKKaqUkZWwZrmpS7/IfJLIRySuDe0aAz3bSfpuq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=ZgVX89uR; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="ZgVX89uR"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202504220637324f40b4107cd8a85b69
        for <iommu@lists.linux.dev>;
        Tue, 22 Apr 2025 08:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nt46wyX3vInf9nEJO3STUSubJKhNa7Mq0IAjgmyGm+I=;
 b=ZgVX89uRFaDVpnmoy6wTuTQjf50vAVEIjLhyw/3KF8CrzYvi8YKNa+jlj7HQ0p7LZT7QGR
 mwrkrTqyaAYHZ0xkw5oJcnaHS8O0s4+KpmjRrkRXCArzVUWAV7MIlVHMiW5/wm6xQFLAQvDx
 Yq46x7FUqamcQGXztfPQsNZsxo8WK14Kc+3DOmo8jN5JRdrtU+S2a4uitIICx2ufyufiB6dT
 ZsN07ne7sKAt9MblrA8UF/QKiVqD80MHpCIhvKqp1CXeHrn1G8pl5J92SQuSDRs8Th9dY2IT
 KbwsGRy272d2BgrcwHyIt7msyTcaKP3boJBDawQvvI9CmKQbPh/Kcd5Q==;
From: huaqian.li@siemens.com
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: baocheng.su@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] swiotlb: Make IO_TLB_SEGSIZE configurable
Date: Tue, 22 Apr 2025 14:37:19 +0800
Message-Id: <20250422063719.121636-2-huaqian.li@siemens.com>
In-Reply-To: <20250422063719.121636-1-huaqian.li@siemens.com>
References: <20250422063719.121636-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

In some applications, the default value of 128 is not sufficient for
memory allocation and can cause runtime errors. This change makes
IO_TLB_SEGSIZE configurable, allowing it to be increased if needed.

Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 include/linux/swiotlb.h | 2 +-
 kernel/dma/Kconfig      | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..145c71f8329d 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -23,7 +23,7 @@ struct scatterlist;
  * must be a power of 2.  What is the appropriate value ?
  * The complexity of {map,unmap}_single is linearly dependent on this value.
  */
-#define IO_TLB_SEGSIZE	128
+#define IO_TLB_SEGSIZE CONFIG_SWIOTLB_SEGSIZE
 
 /*
  * log of the size of each IO TLB slab.  The number of slabs is command line
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 31cfdb6b4bc3..38bfa84b96b6 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -102,6 +102,13 @@ config SWIOTLB_DYNAMIC
 
 	  If unsure, say N.
 
+config SWIOTLB_SEGSIZE
+	int "SWIOTLB segment size"
+	default 128
+	help
+	  Set the maximum allowable number of contiguous slabs to map.
+	  Must be a power of 2.
+
 config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
-- 
2.34.1

