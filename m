Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E307A3093CD
	for <iommu@lists.linux.dev>; Sun, 11 Jan 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768145206; cv=none; b=jPfTMI+FrI8gu7wBNF4ets32O2QqNDkEG+64pkXI0VG/x6/0Nj18BIzrMDviUeljVNmLefs56tw5sOO5n2NkJ0MwoWQkgqrKAqwd1Sv3Id0QG+Ys35M2oeakiDkR3VV0Muj5d14MOazbOX+DmAWmyyLw72TtNDbFYwmsMnTqsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768145206; c=relaxed/simple;
	bh=UlIt9s9yR8yKhklSg4J+BuQNVNApOmRJVqMCK94UDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9RaoKyWLOiZuV423XgJ4znbr3cwf98MtkcHHW1cuVDLC5eWxoP2a/82i0jnjOXFaUr0+VBimk1HMLtEvWnuYZyLpesqFXYo32rVy+5c9cWW/t/C08lQOmeFZimHyH2A8yJBWDpOt7hSJMC4b2Szq5gMMouZYfTQo+uC6d73M/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=T6yMu1md reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="T6yMu1md"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1768145203; x=1799681203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UlIt9s9yR8yKhklSg4J+BuQNVNApOmRJVqMCK94UDEI=;
  b=T6yMu1mdCLvVs4HcJ/txWB0JrsxTqvajuOEUUAgXLl0ia0qascn4wjm/
   elu6VRYz+udkbDFZTAmXE5qAyyM8gjcRrQpfrAl7iK5mBsRgn8I2z4T1m
   uU4R1vPGj/ppsOVeE3IeLrflKfVqE4aGQS+1CjhORsOuK0aUSUPMENiF7
   pF0+KVynDHK/3Gpux5huCBqRGouAC06yitSG4bG++cMCG/OeXQmHFYySZ
   jLvDTFA/LlEIGggSF5TJKwhKxy7pJjyGB/VQkysBmwUhXjLqMAQC5raLv
   2+Y7gwuY3N4F+x3nkmhBnE2Nz7+j3eKI5FQCBliBGXN8eGPaRptkmHb1n
   w==;
X-CSE-ConnectionGUID: 2NEocV4GTpOQvwVO6weIJA==
X-CSE-MsgGUID: lCKPUEawS92HcxMfG6KCoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 17:26:36 +0200
X-CSE-ConnectionGUID: vwqIJSXJSUGiSA4bh2/gwg==
X-CSE-MsgGUID: 9HF6WbLXSE+cE/1sFrLwNQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.6])
  by ces02_data.me-corp.lan with SMTP; 11 Jan 2026 17:28:22 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 11 Jan 2026 17:26:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-pool: don't allocate DMA32 pool if no 32-bit memory
Date: Sun, 11 Jan 2026 17:26:32 +0200
Message-ID: <20260111152632.2133580-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If system have no 32-bit memory, GFP_DMA32 pool allocation will
obviously fail, so skip it.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index ee45dee33d49..f38170f6635b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -209,7 +209,7 @@ static int __init dma_atomic_pool_init(void)
 		if (!atomic_pool_dma)
 			ret = -ENOMEM;
 	}
-	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) && phys_ram_base < BIT_ULL(32)) {
 		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
 						GFP_KERNEL | GFP_DMA32);
 		if (!atomic_pool_dma32)

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.43.0

