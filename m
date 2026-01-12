Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED4322537;
	Mon, 12 Jan 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201177; cv=none; b=YNIBmKXPlXjEKMQEUk57BknlAr0fG41cJc5SFINcD6HO5JjJUO1jw0o3YJiscks7z9UC4IUIqL2nr3CsLnGLSJD559w9INSmabVsBqf+CTQsRq0r2atnkSdpSA0E1kh8OBnxTKuoLcKb4dFGs9A6IU8+8hQT4rqnsJWCYuFVA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201177; c=relaxed/simple;
	bh=S86iPthB8Mz0CkECZazPVHa80rEM1013uyEDwE2IV5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1JXzXm4kWOKyeMuo/xcHiDvtDwT/ytqiziRFg35T2oIgf8F1QfIQke30Rbwh1Taw6InKx2DScY+Wqj6vzwnrxyKMLTnRMGPNh9/Mx8P5vvtuNd4Ogo8C/zkbN6ntv0uSxM8hqrJUvah0D+J17dEIjsPWjm1fF8C8bXKSg+oPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=PqCMs+Yo reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="PqCMs+Yo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1768201174; x=1799737174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S86iPthB8Mz0CkECZazPVHa80rEM1013uyEDwE2IV5A=;
  b=PqCMs+Yo+b6kCI/5KSyPmHs2HLqt6meWN5HpHkFDi4ETGwchoWazOljV
   ue3sRHYI7vU89SMqp37xmcUTFW9uBRzL+jIxeKkCic1GcL9gUIdP13HW9
   pyTy2mwbxyoqrtekJJQZqcwntixT3sMMEUOgjnFUHxrmMvrFLRZOcl5rL
   yQA8e7lEk02lik/nnIN2LT4Zbbb5Cyc6Ut7+YLARu7rcZotNkY7LrGIHd
   GeJQyq5+ohRkpJPwrY6mxdfs5oUP7PYSRk3vJ7FG0EtbzQzBD9exWODK/
   nRWCKMvwTJG4vVB7F9jtcu+yNF3losbVzIUlQFs2Jlwm1QgLSPdfssm8U
   g==;
X-CSE-ConnectionGUID: Drr0LerJRRSyEz5ou9sHvw==
X-CSE-MsgGUID: V/A2/8p6Qe25qMdG7JHeaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 08:59:24 +0200
X-CSE-ConnectionGUID: EsrqnE3ATQuiZ4VSoKzRGg==
X-CSE-MsgGUID: qZ26/BZARpCbFJcbJb1pDQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.6])
  by ces02_data.me-corp.lan with SMTP; 12 Jan 2026 09:01:12 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 12 Jan 2026 08:59:24 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
To: lkp@intel.com,
	mick@ics.forth.gr,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	vladimir.kondratiev@mobileye.com,
	Vladimir.Kondratiev@mobileye.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: [PATCH v2] dma-pool: don't allocate DMA32 pool if no 32-bit memory
Date: Mon, 12 Jan 2026 08:58:56 +0200
Message-ID: <20260112065857.3137331-1-vladimir.kondratiev@mobileye.com>
In-Reply-To: <202601120747.TAMpIDnI-lkp@intel.com>
References: <202601120747.TAMpIDnI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If system have no 32-bit memory, GFP_DMA32 pool allocation will
obviously fail, so skip it.

Changes in v2: use arch-independent "memblock_start_of_DRAM" to get
DRAM base address

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index ee45dee33d49..ecd77a0272f2 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -209,7 +209,7 @@ static int __init dma_atomic_pool_init(void)
 		if (!atomic_pool_dma)
 			ret = -ENOMEM;
 	}
-	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) && memblock_start_of_DRAM() < BIT_ULL(32)) {
 		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA32);
 		if (!atomic_pool_dma32)

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.43.0

