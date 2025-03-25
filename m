Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5172571A8
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913783; cv=none; b=iuYQZOaakqgR4XVdNeDAyHKBay38IVI4i7SlGACNnAZjLTlgjCh4166he5gufPS53gHiPHH0umLLzcZ3e+dCeqIwCp2vyA20vX7dA71VXqoKkzrZdOK/XxC9LGyDh6RXjouDiPOZT0jvq34MksSCQC95nEt3T1dV1J1HWKU6rRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913783; c=relaxed/simple;
	bh=LOKRyJPlx4ALshCfaoPz7qjsvhH7B9FDI6EixCfAYBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjRPaq4McPpCKPEFigu/pei4YZY3QHWZj2Q0bSriUBvNmW3IkhMOUAtPAkoUJG3R7MIhTgtjosYTg1vVLQQhpiZISjGI+cDfRWK4A7r6OF3GEufL+IKMfnydd0gZrtWQhY9F5XSuhCRaY2NTC4UyUE03UejIYohxGBnxthViqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PvUNYO57; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PvUNYO57"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-226185948ffso110154205ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742913781; x=1743518581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bljuQ7L2ZXdxWuOFhGPKf4EDYNcT12ia204eGvgijaA=;
        b=PvUNYO5736D7B43eNlGl5tLHh/SXcc/ZQJzlNh/LqAtzGhXg14/Vl3F4T+P0SuXUce
         /n5Fj/Gr+WwW2nSFejIT6u7NGe4Jo/C1fYvKEBn3UOhFGkgae9Jrl1ZCM5tjsYnxK80A
         /KeCaCt9GzSjbzjxcP4zppY6ushqlwQdJgpwcAYRb6tW/zzKvl2WVPTPMNXO1KEWonKz
         okasSva4TypXp0+5FZGVrHwsufJ3HDgIxgFMtIQqS2Uy1vrPaCAdBXCf+GHsNR1s2bx4
         gfZ0teNVY6dnjt0QVVxHLhmXC30xOxPZrzFHSGUHh+llC8CEqYa1SeqLgfnL6q48P9Xl
         VIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913781; x=1743518581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bljuQ7L2ZXdxWuOFhGPKf4EDYNcT12ia204eGvgijaA=;
        b=nIZdiMeZtDtjxXUQyi6tT5EquDmet+nwv5grO9YVK9bkpF1EV+FwsheXlXyEmBGzxV
         UKJ9S+EBO4/7Y2JhhK0+bx7fRMR944+bTykkZszXUW/O9Q3PCdAVUjcjoXPoAbEJkVmm
         3NypYuwGTFTkmohWngpyMrjiVJl1uXOqQPSz8v0oOwkYOQ5mFvmWMRyNzgZq0//UhhlW
         hFc5scizoBHMo0r6lXkzPxPghi5hFhcbrsTpgK8HQ3lXbdSIeVsPVAZiI4N46xcmbuxl
         RCiMHyg6vYBP8Qzl1FV5Gn/nlt4/nNi0n6ErSeVWXXuWfY13DonP/m324c6MNoVw+sHI
         e+9w==
X-Forwarded-Encrypted: i=1; AJvYcCV2eK6XbQXwW+T14PhRTp2HSWkF9jGgB5VV2qPrvDNu50mZM91FHZQPysTB5xFYTbUFw2GetA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvpmyuKWCYn+Kv1Z6NSxp54lvSrkLNdsAtCVY92oYjr/l9hAUw
	UnSyeW46+o/+TZ0g8BdQdLUNk48IkTpHdqZTXJ4BmWR/UQK1UW1yrpd0rCX63JM=
X-Gm-Gg: ASbGncv+CY49W3OU4UwnXo0xTbGNPdFFwRykg8ROUfmHlposH2XqSUERCndskU9Jw9h
	YuIxk/QCbcqcvvwFo5hDncuSBX8JKJAQIsDeqlyaY/QIgzwRWWDbasT6/R8nUqfu25eBS9C4llx
	F9X84LNPPhOlZtOG92hdQNkwLKse4gxClEyaXCD+Ti7A1S3fSEbFB71sYIKQJZvTUiiaWljjMH1
	fYAc9iRSbl6XA8DGABDV1m/uYdij6ViUG8340xnop1Yhx0MMm18DHtyLig2kcnBVxxIAojqi31o
	N7Xy/ftTVgmfMyxUkoXRpMudUyU4rHd1HyabQKHcYX9JdKHlit21ZgwX5gNzxopZZVeMQElSNtK
	Ce7lAlwUFIc5oC4q4da/cp8hle7bUFyV5mR/HTg==
X-Google-Smtp-Source: AGHT+IHfViq5we3BRjn4gQvEwpQaIGaX5+RcC5JvR41oDoMV13Q99xQsSECoVp76jMvqJK4oIhXprQ==
X-Received: by 2002:a17:902:d484:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22780e239e1mr244870085ad.45.1742913780671;
        Tue, 25 Mar 2025 07:43:00 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f39656sm90623745ad.5.2025.03.25.07.42.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Mar 2025 07:43:00 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	alex@ghiti.fr
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] iommu: riscv: Split 8-byte accesses on 32 bit I/O bus platform
Date: Tue, 25 Mar 2025 22:42:52 +0800
Message-Id: <20250325144252.27403-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
splitting 8-byte access into 4-byte transactions for hardware platform
whose I/O bus limits access to 4-byte transfers.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/Kconfig |  9 +++++++++
 drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index c071816f59a6..b7c9ea22d969 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
 	def_bool y if RISCV_IOMMU && PCI_MSI
 	help
 	  Support for the PCIe implementation of RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_32BIT
+	bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
+	depends on RISCV_IOMMU
+	default n
+	help
+	  Support hardware platform whose I/O bus limits access to 4-byte
+	  transfers. When enabled, all accesses to IOMMU registers will be
+	  split into 4-byte accesses.
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..0e3552a8142d 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,6 +14,10 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#ifdef CONFIG_RISCV_IOMMU_32BIT
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#endif
 
 #include "iommu-bits.h"
 
@@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-#define riscv_iommu_readq(iommu, addr) \
-	readq_relaxed((iommu)->reg + (addr))
-
 #define riscv_iommu_writel(iommu, addr, val) \
 	writel_relaxed((val), (iommu)->reg + (addr))
 
+#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
+			   delay_us, timeout_us)
+
+#ifndef CONFIG_RISCV_IOMMU_32BIT
+#define riscv_iommu_readq(iommu, addr) \
+	readq_relaxed((iommu)->reg + (addr))
+
 #define riscv_iommu_writeq(iommu, addr, val) \
 	writeq_relaxed((val), (iommu)->reg + (addr))
 
 #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
 			   delay_us, timeout_us)
+#else /* CONFIG_RISCV_IOMMU_32BIT */
+#define riscv_iommu_readq(iommu, addr) \
+	hi_lo_readq_relaxed((iommu)->reg + (addr))
 
-#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
-	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
+#define riscv_iommu_writeq(iommu, addr, val) \
+	((addr == RISCV_IOMMU_REG_IOHPMCYCLES) ? \
+	 lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
+	 hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
+
+#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, cond, \
 			   delay_us, timeout_us)
+#endif /* CONFIG_RISCV_IOMMU_32BIT */
 
 #endif
-- 
2.20.1

