Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60090309EE6
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506159; cv=none; b=AilHi3H64SOVksyWOlK3R9pVx83YarNkLVN5nM+ubCIDkBhpcVHhP0NMlOoDJBe80R/UcCm/9514pFnnmjNhiDQjFQhkpcN1YMES40ay6xYdg+zaCq08SIdl54LhDlxIW+35e01e2l7W20BizApEv0t0a+Ex7rBQYGBBW/qp2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506159; c=relaxed/simple;
	bh=l0nzXp1b7ruA9mG3eTZDZaMxq5094/rTnEzf7RxdeFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okDwIe5TogHj7JPxJ0WVTEc/Rxctqj48Hx2eKVWr/lfjMHNbW50U5S4rtl9MppiBOkfK1YlO3opWRRLqnPuHKlhRKG+o7tt0BR5Bmv76++F5+SeryvoMr/XnOCPCdX9iXROqPW9moLOGKG/anlFd7+8tUgk/jVyJh+XkpS7d0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R6P75Np+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R6P75Np+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2247e38eso27776445ad.3
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781506157; x=1782110957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybbv2WqemsTEWAq7K1IRQ6zQPJi/ktdHluf0py4HuKA=;
        b=R6P75Np+d/meGkMnxzmbXAhmRTK38UCiAdLV78i39Oz/QvuaEGTsaUr375yqSFwqQD
         rKpfeQgRzdPsg4N4qs+udOXxZgDxqf+iVw2FYtpKviLHaHsao4d0OTdTchSn86HsLS0F
         mUw1R8o3t+2L2LNY5HNEcGPP771uz2aLEJsi2q+aQF3FpCoT3TM/hvVjBIqvH+9ZJOdV
         SDajLJaCCDkUHHBuva91w5cjkBOPBY3bKj4DklJ/kLDms7PZsxIhUtntsBUkb4OiaDbY
         U1+CU76luJGAbov4fYd28gIzuiWK6Zor+EaW4JAVOhtOUEisfMUx+KYmVelGmuUQacGj
         GjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781506157; x=1782110957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybbv2WqemsTEWAq7K1IRQ6zQPJi/ktdHluf0py4HuKA=;
        b=GexauiJrw4uHt0YTdJZhjHi2C+p5cKUDJ26wJBEJqOShf+lrv17heJJ6lJJB19w0sq
         HFg4rLzozV5RKO1YrTAwBCp6fTzRGIhqOQXX2b3pq5sBBhBAp0ataxUb7W099xtjBvy6
         iQygALOZbOUQJ4ynQpStLGOGkc+gcoCme8rzD0W9/Gg5T9SreHp8EBHyLvEZq6fIzGLn
         tX48bASjnVsh1pbWBEmjGntCE6bkdDP1eX2tTj22NZ5FVXRKfUJ/JbP6gOIplpEbPbvk
         6JZOCk3w9lFP74KByjaAzxZZkVz+OyLEYiRrNoOXsCa8uO9D8cgkabl5tbjGEY5aMFLS
         g2QA==
X-Forwarded-Encrypted: i=1; AFNElJ+JT9Mbb6H2GtO6nix+paAssYnKkKiqlyy8OI0zlJtb7fNPCAXmzQVqFXQOd3hW/g5iKXY3xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLFxKFkDbHhQuNl6bd2NEVypeIESHLgDgFQ+KoO12XAwAD00Zb
	NelUO+OoWMO33Q5lIZXhTsM+lu4QXvmaXnkkroDjX9Ium6lH7C+k7yBD0W3+h3yumkg=
X-Gm-Gg: Acq92OEOuH1kiETnLpTtsKGkN6a6OeCGcUAd/ACk6uIo9aRqz3DW+vLkn4o4rX9I/KX
	NZFvzsVXdHGo7o7a0yvyKqRDZ+QmDvr7abWgTfDeamMCi74lEkaIYEh57jImFuMrgljuqzUWuet
	SMO9C0UI39sCABuqLQhK9CbyWw3eTc+CtqxJImSejOxLkhdZqZgGJW9c3dSewZjDPS67tI6LMV6
	K5wZ3LB0lA9Nleu0oztfGyYV4CWbtsoRziKQXMoTvZxutg4tgg87glmlEEOK2IJcrJgVHyzWekF
	JyPmfVGDVhvxNbYEoW+3HuMrIbnlh+QmjWXAbMLSLe3ycpbo6tcZ80dQFrUnvxzM5i1p5PY4wlQ
	5eJfQcmEpF4i9HuBDwZUyD8Kapm2twq2twylRgsyAmNsjrq7kIXvBfMHR0Qhu9mD7ri5nUk7++d
	BvKWEclMt84SladgyfXd2Z1FieUZmiloCAa9L1SZnVxO3JTTNUWDWcyAMq3Koizc10cUqXPshAq
	pXvG9zEFPwDlIE=
X-Received: by 2002:a17:902:d4cd:b0:2c2:245a:3368 with SMTP id d9443c01a7336-2c410fbb052mr150983355ad.14.1781506156572;
        Sun, 14 Jun 2026 23:49:16 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6511sm83532935ad.24.2026.06.14.23.49.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 23:49:16 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Date: Mon, 15 Jun 2026 14:48:55 +0800
Message-ID: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some RISC-V IOMMU implementations cannot perform 64-bit MMIO accesses
to the IOMMU register file. The RISC-V IOMMU architecture allows 64-bit
registers to be accessed using 32-bit accesses, provided the accesses are
properly aligned and do not span multiple registers.

Add a config option for such implementations and access 64-bit IOMMU
registers as paired 32-bit MMIO operations when it is enabled. Serialize
the paired accesses so the high and low halves cannot interleave with
another CPU. Full 64-bit register programming writes the high half before
the low half.

This option describes the register access width. It is not an RV32 kernel
mode and does not describe a 32-bit IOMMU architecture.

Co-developed-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
This is needed for platforms whose RISC-V IOMMU register window does not
support naturally aligned 64-bit MMIO accesses.

 drivers/iommu/riscv/Kconfig | 11 ++++++++
 drivers/iommu/riscv/iommu.c |  4 +++
 drivers/iommu/riscv/iommu.h | 55 +++++++++++++++++++++++++++++++++----
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index b86e5ab94183..54d624b9b2ef 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -22,3 +22,14 @@ config RISCV_IOMMU_PCI
 	def_bool y if RISCV_IOMMU && PCI_MSI
 	help
 	  Support for the PCIe implementation of RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_32BIT_ACCESS
+	bool "Use 32-bit accesses for RISC-V IOMMU registers"
+	depends on RISCV_IOMMU
+	help
+	  Say Y when the RISC-V IOMMU MMIO window cannot be accessed
+	  using naturally aligned 64-bit loads and stores.
+
+	  When enabled, 64-bit IOMMU registers are accessed as paired
+	  32-bit MMIO operations. This option does not describe an RV32
+	  kernel or a 32-bit IOMMU architecture.
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a31f50bbad35..7fa1721b5728 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -53,6 +53,10 @@ struct riscv_iommu_devres {
 	void *addr;
 };
 
+#ifdef CONFIG_RISCV_IOMMU_32BIT_ACCESS
+DEFINE_RAW_SPINLOCK(riscv_iommu_32bit_access_lock);
+#endif
+
 static void riscv_iommu_devres_pages_release(struct device *dev, void *res)
 {
 	struct riscv_iommu_devres *devres = res;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..ba78ef1858c5 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,6 +14,9 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#ifdef CONFIG_RISCV_IOMMU_32BIT_ACCESS
+#include <linux/spinlock.h>
+#endif
 
 #include "iommu-bits.h"
 
@@ -69,21 +72,61 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
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
+#ifndef CONFIG_RISCV_IOMMU_32BIT_ACCESS
+#define riscv_iommu_readq(iommu, addr) \
+	readq_relaxed((iommu)->reg + (addr))
+
 #define riscv_iommu_writeq(iommu, addr, val) \
 	writeq_relaxed((val), (iommu)->reg + (addr))
 
 #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
 			   delay_us, timeout_us)
+#else /* CONFIG_RISCV_IOMMU_32BIT_ACCESS */
 
-#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
-	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
-			   delay_us, timeout_us)
+extern raw_spinlock_t riscv_iommu_32bit_access_lock;
+
+static inline u64 __riscv_iommu_readq_relaxed(void __iomem *addr)
+{
+	u32 lo, hi;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&riscv_iommu_32bit_access_lock, flags);
+	do {
+		hi = readl_relaxed(addr + sizeof(u32));
+		lo = readl_relaxed(addr);
+	} while (hi != readl_relaxed(addr + sizeof(u32)));
+	raw_spin_unlock_irqrestore(&riscv_iommu_32bit_access_lock, flags);
+
+	return ((u64)hi << 32) | (u64)lo;
+}
+
+static inline void __riscv_iommu_writeq_relaxed(u64 value, void __iomem *addr)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&riscv_iommu_32bit_access_lock, flags);
+	writel_relaxed((u32)(value >> 32), addr + sizeof(u32));
+	writel_relaxed((u32)value, addr);
+	raw_spin_unlock_irqrestore(&riscv_iommu_32bit_access_lock, flags);
+}
+
+#define riscv_iommu_readq(iommu, addr) \
+	__riscv_iommu_readq_relaxed((iommu)->reg + (addr))
+
+#define riscv_iommu_writeq(iommu, addr, val) \
+	__riscv_iommu_writeq_relaxed((val), (iommu)->reg + (addr))
+
+#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(__riscv_iommu_readq_relaxed, (iommu)->reg + (addr), \
+			   val, cond, delay_us, timeout_us)
+#endif /* CONFIG_RISCV_IOMMU_32BIT_ACCESS */
 
 #endif
-- 
2.50.1 (Apple Git-155)
