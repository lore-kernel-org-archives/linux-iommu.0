Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A986334
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922960; cv=none; b=QWzTQNhxZcsURJqayWYrlzKM5syRD4pRA+RBzeHhmunD8ZGpkXxNJdIizO2L+aY2sZy596/xNTWsUqJ4gc+nBrriHBdJ/ukzjdgoxvWjZcboY2VnHpZftUtJvjwYR38TfII4CFwhS+AfxyXL0bxyfLJSPVe0YEn72WEIHG/wUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922960; c=relaxed/simple;
	bh=dknP9TWgNosCi5sh1QkgEVJLOLrIREEdfpe+SqFEniQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWIFehlOeANrgJiAx1vwKFba7gWi46sbo7cxEl6AKu447YQSFK0/+3EmOfjnfzIXfWeimXZOQ7O2x5UrOEYoZAqr0p01sL7l2EJeQD/txKAHNg4g+8C0S+Ito3GXaYvBkhqovKY2VcCjlm7eRMf4n2MCH7t3JwPL+rE05XK+yEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gHsgog38; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gHsgog38"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3595838a91.1
        for <iommu@lists.linux.dev>; Sun, 12 Jul 2026 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783922958; x=1784527758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zRVFbRCCSU313/FdRD3Vin4a5GxhaG0qQy0/ly3lbz0=;
        b=gHsgog38AjnuM8kSGZwqWxYC3LdWoDT8to0kTKbLvQpxrdnvlLSyndtAUGqBsSCM/T
         VxWSg3iOQIZQNSKcvlTXCwOl83wkAqgp6yQrkIzZXfrdOw13ZtCYtkKpqlxvpCUMWeVs
         akMJk4mVhzK2E8CUs/LQfIqv2qOAHdzkuc5IPan5KDpJ4VFzew787Y743SMpYMkzmDUY
         MMy1gUXiCUaCY5kkq1Vy1aPvijx+myMW3kGv7+mb+yPGHKrB2tR1KX3NjggjrVTY+b/p
         Aol53yeHztsACtVCpAflIBuPfa3UtjuO1hFD1+0E3ACvXeJbbCH3B+zS4YGy8EjkT+RL
         3QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783922958; x=1784527758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zRVFbRCCSU313/FdRD3Vin4a5GxhaG0qQy0/ly3lbz0=;
        b=pKQXlDUUaibg1jHke+gIhM8ugKOxWs2KJbiPDH6y/BoaKz1e+/x+5U1PVB3lPLRVXI
         KAj92uW1K2pbmh6wLUKbEVNSkGWzPUKOqoyP/PPR0j8aFd3/uvKeJD6v1AEWHgYmwotL
         33fMiWTX9xeBzJhhYj3s/VNa6s/jL3WhSodRkmeJRml0ZrHj7myGe/3PjPpy6SEy/Iep
         n7lGkcCg/0jSiusTk4ha0kFhGGXGAwgseJoozAe8s3m+7Kp/C/7J2NAxUEZ+JmtBvIA1
         GM9ogazzOswruqgxF1Fjw2Ndf95AUUl6K37nAbIvSttOAekIg98KRMCtRFFtzpErpPZO
         uihA==
X-Forwarded-Encrypted: i=1; AHgh+RrNikSfWQkhx560Y2aN+j2b+2155pZIskwI2e2sdcPGegMsCGh/KN4ptCJOvjx6TJUBn4zwSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaCUoxtaQ0CXlseT4N6h5aQn1EcR2IWqTiRQedqKyJHhTiGUag
	qXcX4D26UeIMJ0OuonCO1Fef08jiCxpUWk0OqGgnrmj1H+nlxV3CjBs6scq+TLvzsCw=
X-Gm-Gg: AfdE7cna3Ypgb1MV7MgdPGMUSKWGvjBy3Hf/JQ/kj1RM358E7bjv1Cr7y6pTq/2GrcL
	s894WR7pjK9CZZdShyuPw06La3kG9dKCpxN1gLryu33iRCgazzEDmni1RcyKuYlAhbo4cSqjq2A
	2o7XhN/IYgr42UiVTX/wQFVq8aAwmf5Qd7ACiILAGGRU11LMQEk3LgvmA2ZqRJDGQwA7qyIX3J/
	JLfFB97bN8kptCk7wTQCV40tE00GRxdKbGMRqtzD8HZjqDLreBeqVTIsnkK1XHaM/E5rud7Kwlt
	Sfn2CHdeWkaWJtEC2ONDDzV0Oeo7hruyfpr3BwDQyYmmyMqix7jGfrAVmkUOExSh9mEhNp5ZMlm
	1Aaa1EVD3SLnI042UlvE5apepCbAts9wA35TsPmBCjwFp4ozWf7QFc+fdYWzi/ayOKjFX+3yrTf
	D3Q381vPD2SR0Xn3A4nL0TPTEDxwo43mUZ5xfavIspUBvrgt+kUaWiAIRvAYipfA==
X-Received: by 2002:a17:90b:5863:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-38dc73bcfdfmr7418132a91.1.1783922957998;
        Sun, 12 Jul 2026 23:09:17 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5564f58csm6035548a91.8.2026.07.12.23.09.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Jul 2026 23:09:17 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Zong Li <zong.li@sifive.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [PATCH v2] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
Date: Mon, 13 Jul 2026 14:09:02 +0800
Message-ID: <20260713060902.15161-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V IOMMU specification [1] permits 64-bit registers to be accessed
using two 32-bit transactions, high half first, and leaves the single-copy
atomicity of 8-byte IOMMU register accesses unspecified.

Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helpers
for ordinary 64-bit IOMMU registers. Poll DDTP.BUSY in the low half before
reading the full register from high to low. HPM counter reads require a
rollover-aware sequence and remain outside these accessors.

This follows the 32-bit access direction proposed by Guo Ren [2] and uses
the generic non-atomic MMIO helpers suggested by David Laight.

[1] https://docs.riscv.org/reference/iommu/
[2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org

Suggested-by: Guo Ren <guoren@kernel.org>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
Changes in v2:
- Rework the patch based on Guo Ren's earlier proposal [1].
- Drop the build-time option and use 32-bit accesses unconditionally.
- Drop the global lock and use the generic high-low MMIO helpers, as
  suggested by David Laight.
- Poll DDTP.BUSY through its low half before reading the full register.

Link to v1: [2]
Specification discussion: [3]

[1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
[2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com
[3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765

 drivers/iommu/riscv/iommu.c | 18 +++++++++++-------
 drivers/iommu/riscv/iommu.h |  9 +++------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab1..14b572058ed 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -668,12 +668,16 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
 }
 
-#define riscv_iommu_read_ddtp(iommu) ({ \
-	u64 ddtp; \
-	riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
-				  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
-				  RISCV_IOMMU_DDTP_TIMEOUT); \
-	ddtp; })
+static u64 riscv_iommu_read_ddtp(struct riscv_iommu_device *iommu)
+{
+	u32 ddtp_lo;
+
+	riscv_iommu_readl_timeout(iommu, RISCV_IOMMU_REG_DDTP, ddtp_lo,
+				  !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10,
+				  RISCV_IOMMU_DDTP_TIMEOUT);
+
+	return riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
+}
 
 static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
 {
@@ -1501,7 +1505,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 	 * regular boot flow and disable translation when we boot into a kexec
 	 * kernel and the previous kernel left them enabled.
 	 */
-	ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
+	ddtp = riscv_iommu_read_ddtp(iommu);
 	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
 		return -EBUSY;
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 46df79dd549..1b03790fbe1 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -11,6 +11,7 @@
 #ifndef _RISCV_IOMMU_H_
 #define _RISCV_IOMMU_H_
 
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
@@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
 	readl_relaxed((iommu)->reg + (addr))
 
 #define riscv_iommu_readq(iommu, addr) \
-	readq_relaxed((iommu)->reg + (addr))
+	hi_lo_readq_relaxed((iommu)->reg + (addr))
 
 #define riscv_iommu_writel(iommu, addr, val) \
 	writel_relaxed((val), (iommu)->reg + (addr))
 
 #define riscv_iommu_writeq(iommu, addr, val) \
-	writeq_relaxed((val), (iommu)->reg + (addr))
-
-#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
-	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
-			   delay_us, timeout_us)
+	hi_lo_writeq_relaxed((val), (iommu)->reg + (addr))
 
 #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
 	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
-- 
2.50.1 (Apple Git-155)
