Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663462;
	b=HfuHst5TzAagGNgpe6yeWJfqiZSbqcmtLSBcZoOvBCuO6zNEWzElXUqeD+ugFpWio8Q3
	 8+4WyIreCj2oEF2Q/dveMxD/AvJUWPQ+IKa4PsV1YRz5T+dWqDvX4zlGqqvJMR4guNVHj
	 iC6ptYMFYYU2q0u3C28Ihj86vA6KnEIrCR6bZ1t+QfP/JTvX4df8EkTqLRdqnCmioi3Zh
	 3i4jsui3Qjp69gOH+kTPsCvjA0JpnX/+EkEe9DemGLp0aZpw1ZjrCwuiVuuD8w9zqGtbp
	 arOKbTdZ8RYU92UuNu/UUbuvqC3vrEd5eUp4skONVt1CL9gcpCvz6IvhjM06i2Z+3TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663462;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1aisXE/Mnz/GaVHezDHTY2TUxsmFNrmsLepJDfVkiso=;
	b=g/OvZZgizmPJEGN4LyaLdQ+Vdt7S3GC1DwO4HJB35GUX3sMxb3xe0l3ODvWTK4S/E6Kc
	 e2prMsCWqojTxptvHKbb6lJBCBrVDvRxMOHidSz5OxNMDfpJBkrfzAqhayJrMGco+71wt
	 LTdntJ7a3m1/h+dbW6kdOyOkgcnieZCDWADM3hUzJGvOydNUFH9hBmTs/SemW4r2Rbhml
	 JtjjUwhJpgnDrz8c8tNRwFjPE3vVQi86gxDktNpwIdXdsFp5/DvnOFDkwxFwEwhUH/I7C
	 MgDh+NLpIcqkx/mY27njTl3u6wgyCjAn+hHWKWf3xqJ5Ow9EXbj9nY6sJ/jGTDOIXDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C47606A327
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 13:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43C47606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so26116185e9.0
        for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 05:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663460; x=1795268260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aisXE/Mnz/GaVHezDHTY2TUxsmFNrmsLepJDfVkiso=;
        b=VMDaN3HOREQ22qhIHYrKXfnSU4qxtZp91rz4+Csx34/mWxGhBJK2EZ+WPzRDQg9Z5h
         rfdnLXRZXzDv12JHUebCmhjhK/BoVJssX4YoVbBUUvRlH46ZhsimrtRLl5Gi7zUt5y8t
         cZmiefiRZafEmZwjbTLlinTNoaaYNysIQMJqI/7ntj6F8A0fopH25WATkWR9VV961Bgo
         TL7LkJxdZvPLwUBxchH8a6Kejf8izxqT9Zig2himaH5wgJUy2WYZRPOefhkLCsuV7OCD
         p5XVozQn8RPlJE6Ql8V9CY7eHjvZltJlqYC7MTP7wGjkNEm6cUG5SnpTKOWZJIAeFhh5
         /VBg==
X-Forwarded-Encrypted: i=1; AL+hErG6s0jsVsbTr7NtPHZkXI1uOpKTG9vCZTvz3GnGUna9hognKkcYvprl3kX/t5i8+A9zB7MsMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+AqcX1koeImLgSEFD+xPTRK1iBIanpSf5oJXV2frbwNAMqbOdT
	bt4y8gWTIMPgGCEnvFEfuemSDqnWoVS+KQaDnPozVwm69c57ZrANSezV
X-Gm-Gg: AYBFou2OvL3aW1EhmCgnHWIsWyBigFdgUjFLj5qgApynjUvurOER5g6zmaCK0Gktt0B
	DbvBQr+HqsOgdk2I0gS82+iptHURjuRzBSlpMkomYy1xzDgr6Rfue5e8lj5VjIZ/9kWPy+NsQBC
	7STeoFeZYjQyaMZKhKsw6Cfchd0U3qkzLlh2oOtN8ulYsmznqHZSS//rT4iYIYHcf5uJLM5/Okv
	LskJWgeTaNXPxVbm5ccJyEmB6X8bBKUEt6sRWbj/6Bb0TCSWJJR6FLu8e/tHl0wHZLvedoQ0D7f
	dSehZDC7ZL3SMsrZyMmXJtNO2krOOWKt0gmAP4iFF/JcCgt+Yjoa/n4PNnuvHS7WinMEz+kAh60
	p8WiCyh5iRHMTkg5AIyWKxnvu8i/HuUe6OWPlBKbSsmUQQLfNjSpTr6WCH4d7Fcr+AVCCobdbeC
	jozv63EXkpiRwTAxUkKeFdxPYRbatRfDxlQ/IwQ8YQIDz7bxPYuK8xyXSGnnNdq7jE0u3MhM5yy
	qRQOwfqyjSKytb8XhPl9wfuqUgFuWwjkueU4nRTYZXQdAaT2JYXy52Qdh7GxLZzYBEGRw1FIpE2
	jmlEOTh/tbDgrWxzfsxmw93SoRv4mDcStgVEHxlSFr8tCI8tKAtK2i/K8crharrewxoKkYWCG6n
	0LG976mICBrdKj0mcbWQzW5or
X-Received: by 2002:a05:600c:8905:b0:4ba:4395:5755 with SMTP id 5b1f17b1804b1-4bb55a6a5fbmr77311935e9.5.1794663460057;
        Sat, 14 Nov 2026 05:37:40 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55a68c5asm131315015e9.1.2026.11.14.05.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:37:39 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/rockchip: do not walk the page tables of a disabled MMU
Date: Sat, 14 Nov 2026 13:37:37 +0000
Message-ID: <20261114133738.52817-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A page fault handler running while another CPU detaches the same IOMMU
can read a cleared RK_MMU_DTE_ADDR, turn it into a linear-map pointer
and dereference it, which panics the machine. A dummy or firmware-left
address is as unsafe.

Seen on PX30 at reboot: the display controller still fetched an
unmapped framebuffer, its IOMMU sat in a page fault, ignored the stall
and paging-disable commands, and had RK_MMU_DTE_ADDR cleared during
the handler's second run.

No wait works: the master shares the line, the RK3588 NPU driver
detaches from its interrupt thread, where synchronize_irq() deadlocks,
and synchronize_hardirq() skips a force-threaded handler. A spinlock
orders the walk against the register clear.

6.1 vendor kernel log, rk_pagefault_done is the walk, per CPU:

  CPU 1, init, reboot path:
  [ 1069.789374][    T1] rk_iommu ff460f00.iommu: Enable stall request timed out, retry_count = 0, status: 0x0002cb
  [ 1069.791314][    T1] rk_iommu ff460f00.iommu: Disable paging request timed out, retry_count = 0, status: 0x0002cb
  [ 1069.830197][    T1] Call trace:
  [ 1069.830922][    T1]  iommu_detach_device+0xd0/0xdc
  [ 1069.831483][    T1]  rockchip_drm_dma_detach_device+0x1c/0x34
  [ 1069.832033][    T1]  vop_crtc_atomic_disable+0xb0c/0xc44
  [ 1069.832751][    T1]  drm_atomic_helper_commit_modeset_disables+0x348/0x690
  ...
  [ 1069.836601][    T1]  drm_atomic_helper_shutdown+0xa0/0x158
  [ 1069.837152][    T1]  rockchip_drm_platform_shutdown+0x18/0x2c
  [ 1069.837870][    T1]  platform_shutdown+0x3c/0x54
  [ 1069.838599][    T1]  device_shutdown+0x194/0x260
  [ 1069.839160][    T1]  kernel_restart+0x40/0x128

  CPU 0, page fault handler:
  [ 1069.790364][    C0] rk_iommu ff460f00.iommu: Page fault at 0x00000000ffee0000 of type read
  [ 1069.792129][    C0] rk_iommu ff460f00.iommu: Page fault while iommu not attached to domain?
  [ 1069.792184][    C0] rk_iommu ff460f00.iommu: Page fault at 0x00000000ffee0280 of type read
  [ 1069.794604][    C0] Unable to handle kernel paging request at virtual address ffffff8000000ffc
  [ 1069.805998][    C0] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
  [ 1069.809484][    C0] pc : rk_pagefault_done+0x1b4/0x3c8
  [ 1069.810548][    C0] lr : rk_pagefault_done+0x19c/0x3c8
  [ 1069.832390][    C0] Call trace:
  [ 1069.833116][    C0]  rk_pagefault_done+0x1b4/0x3c8
  [ 1069.833844][    C0]  rk_iommu_irq+0x64/0xc8
  [ 1069.834395][    C0]  __handle_irq_event_percpu+0xe8/0x2ac
  [ 1069.834945][    C0]  handle_irq_event+0x40/0xbc
  [ 1069.835675][    C0]  handle_fasteoi_irq+0x118/0x28c
  [ 1069.836404][    C0]  generic_handle_domain_irq+0x44/0x6c
  [ 1069.836954][    C0]  gic_handle_irq+0x60/0xf0
  [ 1069.837505][    C0]  call_on_irq_stack+0x3c/0x5c
  [ 1069.838235][    C0]  do_interrupt_handler+0x4c/0x94
  [ 1069.838963][    C0]  el1_interrupt+0x44/0xa8
  [ 1069.839446][    C0]  el1h_64_irq_handler+0x18/0x2c
  [ 1069.839997][    C0]  el1h_64_irq+0x78/0x7c
  [ 1071.215224][    C0] Kernel panic - not syncing: Oops: Fatal exception in interrupt

Fixes: c68a292152d3 ("iommu/rockchip: rk3288 iommu driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/iommu/rockchip-iommu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 1fa3110b142a..0f40d9678344 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -115,6 +115,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	spinlock_t lock;
 	const struct rk_iommu_ops *rk_ops;
 };
 
@@ -543,7 +544,8 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
-static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
+static void log_iova(struct rk_iommu *iommu, struct iommu_domain *domain,
+		     int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
 	u32 dte_index, pte_index, page_offset;
@@ -563,6 +565,12 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
 	mmu_dte_addr_phys = iommu->rk_ops->pt_address(mmu_dte_addr);
+	if (domain == &rk_identity_domain ||
+	    mmu_dte_addr_phys != to_rk_domain(domain)->dt_dma) {
+		dev_err(iommu->dev, "iova = %pad: page directory %#x is not the attached domain's, not walked\n",
+			&iova, mmu_dte_addr);
+		return;
+	}
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -593,6 +601,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 {
 	struct rk_iommu *iommu = dev_id;
+	struct iommu_domain *domain;
 	u32 status;
 	u32 int_status;
 	dma_addr_t iova;
@@ -606,6 +615,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
 		goto out;
 
+	spin_lock(&iommu->lock);
+	domain = READ_ONCE(iommu->domain);
 	for (i = 0; i < iommu->num_mmu; i++) {
 		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
 		if (int_status == 0)
@@ -625,15 +636,15 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 				&iova,
 				str_write_read(flags == IOMMU_FAULT_WRITE));
 
-			log_iova(iommu, i, iova);
+			log_iova(iommu, domain, i, iova);
 
 			/*
 			 * Report page fault to any installed handlers.
 			 * Ignore the return code, though, since we always zap cache
 			 * and clear the page fault anyway.
 			 */
-			if (iommu->domain != &rk_identity_domain)
-				report_iommu_fault(iommu->domain, iommu->dev, iova,
+			if (domain != &rk_identity_domain)
+				report_iommu_fault(domain, iommu->dev, iova,
 						   flags);
 			else
 				dev_err(iommu->dev, "Page fault while iommu not attached to domain?\n");
@@ -651,6 +662,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_status);
 	}
+	spin_unlock(&iommu->lock);
 
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 
@@ -921,16 +933,19 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 /* Must be called with iommu powered on and attached */
 static void rk_iommu_disable(struct rk_iommu *iommu)
 {
+	unsigned long flags;
 	int i;
 
 	/* Ignore error while disabling, just keep going */
 	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
 	rk_iommu_enable_stall(iommu);
 	rk_iommu_disable_paging(iommu);
+	spin_lock_irqsave(&iommu->lock, flags);
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
 	}
+	spin_unlock_irqrestore(&iommu->lock, flags);
 	rk_iommu_disable_stall(iommu);
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 }
@@ -997,7 +1012,7 @@ static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
 	if (iommu->domain == identity_domain)
 		return 0;
 
-	iommu->domain = identity_domain;
+	WRITE_ONCE(iommu->domain, identity_domain);
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_del_init(&iommu->node);
@@ -1051,7 +1066,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	iommu->domain = domain;
+	WRITE_ONCE(iommu->domain, domain);
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_add_tail(&iommu->node, &rk_domain->iommus);
@@ -1227,6 +1242,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	iommu->domain = &rk_identity_domain;
+	spin_lock_init(&iommu->lock);
 
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
-- 
2.56.1

