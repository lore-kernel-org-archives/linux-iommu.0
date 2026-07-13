Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0737BE93
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945762; cv=none; b=BjBxtcKoksquajGGOz+bwO1xq9joQzZsvVgBMpmWAgidOtqJ92/2iAqklIevNELiRKGWYNWCI3to7Hm2uZjzPlQPP4zZfPgusmXj5rzyCgOR+AZyDcGoN11dUnS73OlcXDIkbx2tl7YK/wKK0ALcLkh2WL/Nc3I2ir9kfRBs80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945762; c=relaxed/simple;
	bh=Zcs2wNs6KJDk1sxJ/T0GL9ZM39phME3iNI+3dhsECfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGsLmDSZwxJoxrdu6FZGSZ0Vm+z0byvcxrNwAOP3Mqd17JcCEwC1RmVcNJsVP9uMR/UUbBsFh32PIpc3yltOXkjwLmE8/lu6Xjz5nD0YFJvCTe333nl1Y1dIMq2tIJzoaQUnYspa3Kvfh9sT2K46GbG9MKDEWDSWDhmhH3SbIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NTgngCd6; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NTgngCd6"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7ff05e5d009so35326617b3.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783945758; x=1784550558; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJPh3725ldS/I69LwFe7D4tI91unCJJw6+m/zaHdJkA=;
        b=NTgngCd6t9ghZ2b8KSxkmyzwyIoLxG5PFGrj89Folcc61gez8SGrygz969azqfudJG
         xrfCC8a0pv4agviCDmkcTop/+c6CJEWcfLdvcVYZMnA+YixsQhvezQz9cP7+vSCFE2de
         UN0xJN/NGjhEH88bPsKh1rXTzslunZF0ynJEeRmq2H9ra/ZfhpGxLZL5NOABqf1luCsb
         tY6jBZq21KDwV/ZRE21clX9nVf2Mk+88wPQZcqNeqUPebeAC9LcTAy/V1PdjanYcK6WZ
         msIxtyvoTeBBRjhZAZeeiXAmS0E53bKS2YXokcIjtNC3CwOGzmESt3E5wwubsNejATWJ
         4aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783945758; x=1784550558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJPh3725ldS/I69LwFe7D4tI91unCJJw6+m/zaHdJkA=;
        b=ku0P83OHhneMUwxzzlyWLLTVIWvpeHMMQCmqtGpevBnUhtGRsnY2UxquNCY9CTBy/g
         eFf7E3YADb/AanbRInVTP4a4U0bHQFoGY1onvJZ8/7mpfzwlYnN/Hku+yG5awwO1lR5u
         maSyu9Y2nIT7dSmeWRwQ63QZdky0c/211hB9JxNYxKWIR93q/UI1hqyG7mO6vMLFaEle
         QN9g0UaHR+nsnWLQdszc6tiV5Ml4G/p+QqEWRkx8nT7DMTnRHsVFx06+kJff8B6pa4IM
         P5z27xvp5mZ7Xl4ZolJUHy2Gm07t7+PIk3MZqeKsIXmgZqIlTJ/pimhs/mJbfVfoDgw1
         kqHA==
X-Forwarded-Encrypted: i=1; AHgh+RpAl+Y9HmxiBbCBc5FP8KcOPlgf/cQ4NydYn8+BP17Y2eLrJlVpbyXXcre6+g7kw5shRQoPow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzmkM2re2cvhwynrei1SoNROilpoLKMXg3NsR315kDjwPq0Mmf
	VPifrOnpaje70rwsei1tu1lDWo4gZdjFhku2vz91/AMXxquA7+JA1ErnFuBPYgNiYJc=
X-Gm-Gg: AfdE7ckad5+EM9o5hDm14uMsTfYKHaxrTmsPACLb2M0ICYOK3fPpO4i4QWSYKUCwlLF
	nfTZbcbM/vQAnK7FlZqfyjaREzYWjfKbdgntm33TNpnKXL0UipX8rg20VFFXjaXRfXUkHSzjD1M
	lEeVnW3wetWmnRDHeAaonTAVavxX7I4/eWlegMPbxJ/sC2pfsBVgw8+pwSYlfTjr9NaDWmCjRiM
	vpE0oo59np8xW4Se5H3No38MYyf8ppp2QgG8Y0mlSq+1KsSA4eDmfNYW6+Kha+CJFiTPc74ltE7
	Iflr57KsiQo6OiYcl+0ktRcVhBOyTz39kuzNLGbHHnCdmAfR3iTgzQQ3kP2VujdVFRLNZ1UXHZN
	EL0RcgiLQeKftz0fYtzYku+CYHHNZrDWEaUAnJHsWlGHT6V9FSScgzBtmioa0eV5dJKbhJA3SRa
	v3MFANMvsFIzuR9xKZiH0a/rNPrIS+ImHuVPOiwp3YdE9tuzez+FebN9HozFzDpJ329tVwPVsD
X-Received: by 2002:a05:690c:6304:b0:7ec:592a:a75c with SMTP id 00721157ae682-81e90105711mr65533197b3.39.1783945757952;
        Mon, 13 Jul 2026 05:29:17 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1feb43sm112700987b3.40.2026.07.13.05.29.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 05:29:17 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
Date: Mon, 13 Jul 2026 20:29:03 +0800
Message-ID: <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
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
for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low half,
then read the high half and compose the register value from the polled low
half. HPM counter reads require a rollover-aware sequence and remain
outside these accessors.

This follows the 32-bit access direction proposed by Guo Ren [2] and uses
the generic non-atomic MMIO helpers suggested by David Laight.

[1] https://docs.riscv.org/reference/iommu/
[2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org

Suggested-by: Guo Ren <guoren@kernel.org>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
Changes in v3:
- Use the DDTP access sequence from [1]: retain the low half returned by
  BUSY polling, read only the high half, and compose the DDTP value from
  those two 32-bit reads.

Changes in v2:
- Rework the patch based on Guo Ren's earlier proposal [1].
- Drop the build-time option and use 32-bit accesses unconditionally.
- Drop the global lock and use the generic high-low MMIO helpers, as
  suggested by David Laight.
- Poll DDTP.BUSY through its low half.

Link to v1: [2]
Specification discussion: [3]

[1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
[2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com
[3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765

 drivers/iommu/riscv/iommu.c | 9 ++++++---
 drivers/iommu/riscv/iommu.h | 9 +++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab1..d647b71ebec 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 
 #define riscv_iommu_read_ddtp(iommu) ({ \
 	u64 ddtp; \
-	riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
-				  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
+	u32 ddtp_lo, ddtp_hi; \
+	riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo, \
+				  !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10, \
 				  RISCV_IOMMU_DDTP_TIMEOUT); \
+	ddtp_hi = riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP + 4); \
+	ddtp = ((u64)ddtp_hi << 32) | ddtp_lo; \
 	ddtp; })
 
 static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
@@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
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
