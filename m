Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657D13D52E
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788680; cv=none; b=kRjvBxjoX2z4sSa24q6NgI0y1F6hJi+u/Et2O/NH1AeNkO0om2NWFre7aARb8+q9xF8l+/WXdcNHAHtHGH5YlWvIw1Apwrns4zZXFxP7M5eQZhy2kg9dI8rmT51cyj1k32FVzFoQwzHCwCHOU+NFz1GQoAXyvLBR8dgGYoZx55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788680; c=relaxed/simple;
	bh=6UzgLIUe6O/xs/jPdvGJJ+faNEedd7qkf6B6VnZnaMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCs9oeaxDZKdj7nsa7sSebtOoTVdzVerG8gHhLNK+Gp2B8jf3kKDS8KFPtMx46HXvDokMklNhY+fOIPW+ZPnmNOxrPsaSW0+vCb2T9Cbk5/e4vyfDm7MdnVeCid/PVdBry7Wn04q03kRMBKBTZMrKJUmV8n3DOoLYibulk14dQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJBa/hWC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJBa/hWC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so1134887a12.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718788677; x=1719393477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPjk/SGA+ZcN/4o+MHQo/WGtXiJoQP9htaHUILinkME=;
        b=DJBa/hWCS7zJ/ufbxBkJDoCkEZ2eEsjsVOnirxlMb1/ttidUd54mOfflaPGuEqQf5b
         ld1H8Hdll2BYlggbpqWhzwtBjnnQIncsz5F9+JqScbf4A1X8EOv/E3DsSTHEJ6ROcebv
         j1FOik/0h1iWK02/FomfX/2JxWS4xermA4qcWfhIKlz4G/Q6QPiZR56lLGoE7+yoXgjx
         NW3cay2TMW8xkwIsUUAVsbH/dQyJQwABLmxwJ5aIk4yr2TUCDYy0dGKmoco3PP5QznAF
         OGpbRqEkec6Xft1yY+yg5UVoQ4ZxYhaKT0t/5MDMPvoiGDhb52CGGYlCfxFKfsJVjx9I
         4avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788677; x=1719393477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPjk/SGA+ZcN/4o+MHQo/WGtXiJoQP9htaHUILinkME=;
        b=KP7QmaRbGyCm3QtF0w/tVjrDgZnKWMFSaiPLYo2kSfqBtLFf9nKTo3EKOY2D80DEiW
         KPZZJQbw5I4/LeTxikCo9GuHK65M81Cy64YAq/fhDg3LRCFt0zJcAb1LSTAwbgN1KsiY
         20JKRdCpXTU1uC6cYX9awS+mHOqofFyRmXEsWokqwPtS//LeofZbRyikD3vF6xLxBzIT
         dF1BnGdx24eV9ANohGEYnlrhwSIBljYp9VTuiXqYzW38/XxzO3x1Gzirj1BzOMMZcF3R
         UqEVNnZpEUH+T1dRkhZc1yc4smW2uyKSJPBeU8efFxIY32/iysNavaE7aD7plm0G0/WM
         c08g==
X-Gm-Message-State: AOJu0YzIjp7qW5ksO35OuUcCQtiq0cAT97E40isZwwVRZIuIKHEZaMjm
	4OKezlneyzV/svVgNZ2mOrxivteouXTgjwcWrTBFI/2YpycGw2+8
X-Google-Smtp-Source: AGHT+IHQhFY66fdqc5NDEVC0x8QMNLjL1+OzzoH1l3jp37dPjCvEv5i0s+oqLbjEpDVFCk1Qa/qiWw==
X-Received: by 2002:a50:8d58:0:b0:57c:5fcf:b570 with SMTP id 4fb4d7f45d1cf-57d07ed4c40mr845595a12.32.1718788676813;
        Wed, 19 Jun 2024 02:17:56 -0700 (PDT)
Received: from avengers.. (217-133-54-93.static.clienti.tiscali.it. [217.133.54.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm1993532f8f.2.2024.06.19.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:17:56 -0700 (PDT)
From: Alberto Secondi <albertosecondi@gmail.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alberto.secondi@abinsula.com,
	Davide Salaris <davide.salaris@abinsula.com>
Subject: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
Date: Wed, 19 Jun 2024 11:17:37 +0200
Message-Id: <20240619091737.669040-1-albertosecondi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alberto Secondi <alberto.secondi@abinsula.com>

The kernel assumes that 64-bit systems have 64-bit DMA support through
CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, several
iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit support.
This results in several drivers requesting DMA_BIT_MASK(64), which causes
malfunctions, particularly when systems have more than 3GB of DRAM (verified
with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, a new
config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems with 32-bit
DMA, which adjusts DMA_BIT_MASK(n) accordingly.

Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
---
 include/linux/dma-mapping.h | 4 ++++
 kernel/dma/Kconfig          | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f..629220a777e3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -74,7 +74,11 @@
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
+#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
+#define DMA_BIT_MASK(n)	(((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<(n))-1))
+#else
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
+#endif
 
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c06e56be0ca1..0a27eafed808 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
 config ARCH_DMA_ADDR_T_64BIT
 	def_bool 64BIT || PHYS_ADDR_T_64BIT
 
+config ARCH_64BIT_HAS_DMA32_ONLY
+        bool "64bit System has DMA32 only"
+        depends on ARCH_DMA_ADDR_T_64BIT
+        default n
+	help
+	  This enables forcing the maximum DMA_BIT_MASK to 32 bits for
+	  64-bit systems that have DMA support limited to 32 bits.
+
 config ARCH_HAS_DMA_SET_MASK
 	bool
 
-- 
2.34.1

