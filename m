Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD913AB290
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281503; cv=none; b=gI8bMATXUlZt3KIz5bDmwWUa4GwW1i34211LDUzh5hhrFAtBWQw+nzmjX0CX76jemA5Jtqo0iBlpPbEQFLGHfTsxJ98LyO5EBNBpfnSye+HH0vAid1eK7RSJ4XNDIWIjebNHu6XG2VPK5a4/oy6zyJED407zQNbgi43wAnHiM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281503; c=relaxed/simple;
	bh=GThMTUYv0X2eUWVbc3FKLVom4NcwLXi5gsOn2QtDYgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aBg9351WEX3LGFF2oIPUv4Ovonfl2Ec6aOZE+nlaam0vXU4UEd1pmN0AdRFzft+Ncl58Lhw/K4kMn53vi8IOWhfOgDrFGd3VeH5QJPxSRKQIzHFl3gFTJRKDa/0r/RKKOhW95wqJgEPk2/IL/mOt3ywyDDidkQXrQ2lnjCL3bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7hhX/ii; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7hhX/ii"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so116853a12.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774281501; x=1774886301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SyPHQzyI0AHwqMlFoboSet59W59Lm/9+xwH2RUG0miE=;
        b=F7hhX/iiuwpTom4NdxI6YwEW9cgXIS8stbCVjRqgwix8iUjY+xG24tKiqPHlnjNuG1
         JgfGizz9p/E4D9/wP36Xvm0kD+Me9z9fNp2CFku3fwKyY61gmWxIHaLoQBktddzumxPt
         5yQj/qiP/S9ttRVcxUrWntFXWa9m4Ritc+JwCjBBNbmceRChBNwXXwCbSsfV6Q92lZRY
         LjGYywR00xwkQ9zxJ6WBdgZA9YajUKps7/mPeaPS4i1l5RpE3khEVYvCnsWD/F5o8Ban
         cNQP3ePZuGIHxravGT5jJW1Rbr1vI/x5Hc63ywQj68nhHl9xReT/O9XB10+ExXc4EjPT
         oJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281501; x=1774886301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyPHQzyI0AHwqMlFoboSet59W59Lm/9+xwH2RUG0miE=;
        b=aN7pomgBrQjdPA54ktGr6Anrt3G4Ve9rKAr11rVHiFdnq+iIbkgsfyFmsaJxBFaAqQ
         o5SvF9fQQqA2+1CGxVN/X7s1gA7GnRth/dksl5nqdDZ5gj//UPeXAlMJInWmdTzYlWtO
         VYeZ0gwmwlWvbRws2OxwGf7sNsQc+OzCYKTzwHlaMqi5Yu9QLbUURS/4woafVIKknaIM
         hs3xhAtf/yZMj6Pt09mhjs5B065HYSnd5F1E5PqDLMXKCkYbnh77XCqxAE1AGBtwQWPm
         aeu0+B6DydnsGeYmvvEl6wBU2i6EFSow0omvJZfQk5n/qNXNSaUSUjUvD/yshIJWx+CB
         Q0dw==
X-Forwarded-Encrypted: i=1; AJvYcCUs4XmIGueK9qx7VINVvXzvxjiWYpU6XZgQwvziAO7Aoed81sRRH03As0rV2lu9ZloSPHRTyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5rM7ybX8uTpiXfaJiVOcgQrCGp3M7JnFbFKb1A6r70pBJtLZj
	gDcrt383IJGw16gt1jkYbzFXLYcV89kR8rYxJt74WSud1mDN2OheataM
X-Gm-Gg: ATEYQzwzfDKRqdFwsLHnL7Y0zjbKio3NJw1tmkU3Di+pWs6zTefJiml8frToXCbaeXm
	Vkc73JY2WHz/8/yEkNeAc+9xk9napoAfNI/o3MMAkoCABAwPmtFSG6YikVOjKL6O5BHVKJTpR8V
	60shcqpdGtQYohsiouJ2bCw7JaAtiIOStTnpqRxFWGctJl9lrmspFCpFoCDXgG2B/lRUPn5PKfm
	VSX29ZXpcl4C58Icun7IsZVS13PnKnT3GrVZ232WxvbjkqRaTuyUvXRvwWJcCxjW5K86NRrx/80
	S1dPNdhcepD47e6FI06GsWZ8FqBH1/9aBuZlu0eEhXc9eV76s16fmGv9jiTl/7nqh5OKyBpYywO
	3n49lE1mEE1JOtTfouIoZ9JzljIKFy/B32OU5ExZAM4x58QEc45x32A8f7UdDPK/CMRyf3q9Gjo
	dawHKhROy0lLEFGKzD6EO9Sd2/fn1CD3695AJ4M+zlmJk9Qy+83CAWnP62CD2XeZNLjoqvxcP7q
	NZzxYfrIw==
X-Received: by 2002:a05:6a20:a10c:b0:39b:9644:6ea4 with SMTP id adf61e73a8af0-39bce9f0e99mr11959607637.16.1774281500957;
        Mon, 23 Mar 2026 08:58:20 -0700 (PDT)
Received: from sean-All-Series.. (1-160-195-162.dynamic-ip.hinet.net. [1.160.195.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a801701sm8487398a12.4.2026.03.23.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:58:20 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH] iommu/riscv: Add DebugFS support for register dump
Date: Mon, 23 Mar 2026 23:58:06 +0800
Message-Id: <20260323155806.97130-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a DebugFS interface to allow users to dump the internal state of
the RISC-V IOMMU hardware. This is essential for diagnosing hardware
initialization issues and debugging driver-hardware communication
such as Command or Fault queue stalls.

The implementation exposes a "registers" file under the device's
debugfs directory. It uses the standard debugfs_regset32 structure
to dump core registers:

* Global configuration: capabilities, fctl, ddtp
* Command Queue: cqb, cqh, cqt, cqcsr
* Fault Queue: fqb, fqh, fqt, fqcsr
* Interrupts: ipsr, icvec

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/iommu/riscv/Kconfig   | 11 ++++++++
 drivers/iommu/riscv/Makefile  |  1 +
 drivers/iommu/riscv/debugfs.c | 53 +++++++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c   |  3 ++
 drivers/iommu/riscv/iommu.h   | 12 ++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 drivers/iommu/riscv/debugfs.c

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index b86e5ab94183..c2ba12d97e98 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -22,3 +22,14 @@ config RISCV_IOMMU_PCI
 	def_bool y if RISCV_IOMMU && PCI_MSI
 	help
 	  Support for the PCIe implementation of RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_DEBUGFS
+    bool "RISC-V IOMMU Debugfs Support"
+    depends on RISCV_IOMMU
+    depends on IOMMU_DEBUGFS
+    help
+      Expose RISC-V IOMMU internals via debugfs. This includes
+      register dumps, queue status, and other hardware-specific
+      information useful for debugging.
+
+      If unsure, say N.
diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index b5929f9f23e6..9658a10d8b24 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o iommu-platform.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
+obj-$(CONFIG_RISCV_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/riscv/debugfs.c b/drivers/iommu/riscv/debugfs.c
new file mode 100644
index 000000000000..52dc50a7fa20
--- /dev/null
+++ b/drivers/iommu/riscv/debugfs.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+
+#include "iommu.h"
+
+static const struct debugfs_reg32 riscv_iommu_regs[] = {
+	/* --- Global Configuration --- */
+	{ .name = "capabilities",       .offset = RISCV_IOMMU_REG_CAPABILITIES  },
+	{ .name = "fctl",               .offset = RISCV_IOMMU_REG_FCTL          },
+	{ .name = "ddtp",               .offset = RISCV_IOMMU_REG_DDTP          },
+	/* --- Command Queue --- */
+	{ .name = "cqb",                .offset = RISCV_IOMMU_REG_CQB           },
+	{ .name = "cqh",                .offset = RISCV_IOMMU_REG_CQH           },
+	{ .name = "cqt",                .offset = RISCV_IOMMU_REG_CQT           },
+	{ .name = "cqcsr",              .offset = RISCV_IOMMU_REG_CQCSR         },
+	/* --- Fault Queue --- */
+	{ .name = "fqb",                .offset = RISCV_IOMMU_REG_FQB           },
+	{ .name = "fqh",                .offset = RISCV_IOMMU_REG_FQH           },
+	{ .name = "fqt",                .offset = RISCV_IOMMU_REG_FQT           },
+	{ .name = "fqcsr",              .offset = RISCV_IOMMU_REG_FQCSR         },
+	/* --- Interrupts --- */
+	{ .name = "ipsr",               .offset = RISCV_IOMMU_REG_IPSR          },
+	{ .name = "icvec",              .offset = RISCV_IOMMU_REG_ICVEC         },
+};
+
+void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu)
+{
+	struct debugfs_regset32 *regset;
+
+	if (!iommu_debugfs_dir)
+		return;
+
+	iommu->debugfs_dir = debugfs_create_dir(dev_name(iommu->dev), iommu_debugfs_dir);
+	if (IS_ERR_OR_NULL(iommu->debugfs_dir))
+		return;
+
+	regset = devm_kzalloc(iommu->dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs = riscv_iommu_regs;
+	regset->nregs = ARRAY_SIZE(riscv_iommu_regs);
+	regset->base = iommu->reg;
+
+	debugfs_create_regset32("registers", 0444, iommu->debugfs_dir, regset);
+}
+
+void riscv_iommu_debugfs_remove(struct riscv_iommu_device *iommu)
+{
+	debugfs_remove_recursive(iommu->debugfs_dir);
+}
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 368f3cbd2d0a..a4fa0307b32a 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1466,6 +1466,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+	riscv_iommu_debugfs_remove(iommu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1526,6 +1527,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	riscv_iommu_debugfs_init(iommu);
+
 	return 0;
 
 err_remove_sysfs:
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd5495..1084e4e77455 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -60,6 +60,10 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+#ifdef CONFIG_RISCV_IOMMU_DEBUGFS
+	struct dentry *debugfs_dir;
+#endif
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
@@ -86,4 +90,12 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
 			   delay_us, timeout_us)
 
+#ifdef CONFIG_RISCV_IOMMU_DEBUGFS
+void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu);
+void riscv_iommu_debugfs_remove(struct riscv_iommu_device *iommu);
+#else
+static inline void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu) { }
+static inline void riscv_iommu_debugfs_remove(struct riscv_iommu_device *iommu) { }
+#endif
+
 #endif
-- 
2.34.1

