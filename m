Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294665;
	b=wZuOUrKBhWblD+eAHHDPtuVHF9mM9zd1pS+hQ3e+mo4S4jkMnZvPhzbRxXLkk+alxmEn
	 cL1w0Fhkx8pR9tfBAnXw0l9SA9qwd44srywa0TPurWnonCNIX2/V/z3a9KIhZKqez8RNn
	 MUuLuBgoB6Lg/lTQ14LDnKIhtPT5G+gJ7p4etmWx86vglyrVKnE63zTO7mhrYmLyTaXS+
	 gVTb/2SX6ofnDfoXaJi790m1MU3Ru11Bi/4asXmx8eBLoQCkL9ta1boEaUDDLDJcEpioh
	 2wXI8WmIqSpJsTM8C7Qs3zBHFvNDx31bkQxx15CfDyN0WkweAMIv9rSRo/hcZhAHxAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294665;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l9NeHEnz1TMa9R4zZQlGMVr9N+Rkyp8M1rZ+xyQSjjw=;
	b=r+GEt1V/EMgRnV8i7EjdwwOeFiwlHQzQheGaQoM/Qm+R+yFx21RYoWCLJOruIshXQ3g5
	 tdh3jAbNyWIKiRllau+FT0Lq90O5+X31sLmWL6LyeExpy3HzpANzS9jhjte7XL8quNXsx
	 iJ7t8c40AUe6xQsgSRRKYNBeql1XlI/efu9DKasW219ngU6+mVCqQYZyngqKDWE4dkxMc
	 EmFEdtV3UClyoVZAwJRwHqiRydMctemqd+G1n21V8ptGo19udwZV15O3eDtaXP7UFO7Tn
	 cIdnBvrOzEo9fGsViCVO4LItITU3FbpsUHUNrgbPNQUyne9GNRKq74syD8IqI0Aj6cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrKDUlJG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116F60A2600;
	Tue, 10 Nov 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrKDUlJG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294665;
	b=Gk0vKb7FvqeeD6dueCuBr1jUrc9IZ9l0zszfXieCNqJnLVIStsEBSwGdzK/+M2zgCUul
	 XdHfzRIa/fsBMXDd2fiZHZ6HESMPMVZ2HkPY90BXe2qWZiovyTnkECin4ZAIimYbZAL2d
	 DGPH4UzHwSqvYW8tlCPW/HmDWROnt0ZhIK2BiwZHZ4WVqKx9B2TJTu319L9pyIPO1xFoE
	 p7AmPceXVfWGGZFXbQl3rqBTbNkO90qaRRC/A1hjoTYRTeAzE1GF5oIfRFNEOq/fmvlE/
	 KVxneuo3+nTRr8UYIz+9Kp7G3TOxJmgXqboLbBLR5iTER1sSKw1gNGlcrPNLDu18HTQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294665;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l9NeHEnz1TMa9R4zZQlGMVr9N+Rkyp8M1rZ+xyQSjjw=;
	b=HjLXbacTjaffZITGHhs8lis8jj8lth64afRNV80W8tY4d5BRMdayN9wHLbzT+RVkJfVA
	 vVeecWRhv69fkK5Vfnaj9wl7H9xDndrPXUi2RP6J+RrP3dOKLS7fvzMrhxh1EvNtazgFZ
	 P5umRiSkzpaDPUapKBkthaGqYTb179UbMwVnHG5YaU8pn4X4sA4b/pV3pXXh8xEv8LL4A
	 dfubF3UuYISzubTX+8vBbz8M3QozxlSiyH5tjzYHkfjVA/iIPgZKw4nEpMFSvLSIDD0gV
	 vCoZBSlrEVvrq6Bmow8miqleEh2WakjbtZ0rRT/Mmh+IngtipLtAMU0rODNa4mHuTmQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04BB31F008A5;
	Tue, 10 Nov 2026 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294665;
	bh=l9NeHEnz1TMa9R4zZQlGMVr9N+Rkyp8M1rZ+xyQSjjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nrKDUlJGvl0jVRTNCo3YMTLvRQXkruhxdI7UNMjrstquTX2/Bv0e9ocmZDlqxSuA5
	 3DI9Em2PNpgtDoBT+H6crei3x8cQsBPSQedSN+kN4ck9s+iBCblprbFO6mKaoeKQU8
	 q9WJVC8+qDKzSEWVn0KTowGqQEGNITak0v/JwzWu3pkkJpB88Wsthk+i+EttI7LT1+
	 uITPwrIZAG8d+WZ3Nn2nagV0B0X5dIk5SIlk3WuH15siCE/1dNvpFzu+vuNzERxtKz
	 /6NWMZ5ixy0HxqWJUi2VVvHDE2weAY77zmTd994hUiGsKBEpzitprddpioOmZceSIV
	 d9noBtw7Gcogw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94D6148935;
	Tue, 10 Nov 2026 07:11:02 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:06 +0000
Subject: [PATCH 5/5] iommu/rockchip: Hold the master in a page fault storm
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-iommu-rockchip-faults-v1-5-b1dda574dbb8@gmail.com>
References: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
In-Reply-To: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294661; l=8444;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=4zp/VLFVCPilsQkwznLyGs+jzibbKfJs9/IdoQHukWg=;
 b=7P8CMZwYh5IypdW41trMvO/0Qo4fGylRl6TRRoQ0zmjrh3N638KrKMyTgGcqdFZ3wr9i+rgf/
 hNf+bGbu3X4Bmp1L+MGCdORKREL8MqkMXc29QDOLcbbb1AvpBy3aib4
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

rk_iommu_irq() acknowledges every page fault with PAGE_FAULT_DONE at
once, which lets the master go on. A master whose job points at
unmapped memory keeps accessing it and faults again right away, until
its own driver stops it. On RK3588, a VEPU121 JPEG encoder core given an
unmapped input address retried the same few addresses (16 IOVAs in
0x1000000-0x1007080) for more than five minutes after one bad job:

  rk_iommu fdba0800.iommu: Page fault at 0x0000000001005280 of type read
  ...
  watchdog: BUG: soft lockup - CPU#0 stuck for 317s! [kworker/0:1:11]

The interrupt storm kept CPU0 in hard interrupt context, so the
encoder's own timeout work, queued on that CPU, never ran to reset the
core, and the board was reset by its hardware watchdog.

Count the faults of an IOMMU, and when more than 64 arrive within
100 ms, don't acknowledge the next one: the bank stays in
PAGE_FAULT_ACTIVE, which holds the master at its faulting access, and
its fault interrupt is masked. rk_iommu_enable() already acknowledges a
pending fault (see rk_iommu_enable_stall()) and sets the interrupt mask,
so a driver that resets its core and reattaches it (as the Hantro and
rkvdec drivers do after a timeout), and a runtime resume, end the hold.
If nothing does within 100 ms, a delayed work releases the master and
unmasks the interrupt, so that a master whose driver has no recovery is
throttled rather than stopped for good. A single fault, or a few, is
handled as before.

Measured with the same bad job, ten times: a storm was held after 65
faults, rk_iommu_irq() took 0.8 to 1.7 ms in total per bad job (2.02 s
without this change and the rate limit), and the encoder's timeout
reset the core every time; ten runs of the GStreamer pipeline that had
locked up the board ran to their end.

This is what the Rockchip BSP does for its video codecs, which mask the
IOMMU interrupt in their fault handler and leave the fault pending until
the hardware timeout and reset, but needs no help from the master driver.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 108 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index c57a1f8941c5..cbf9f81a775a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string_choices.h>
+#include <linux/workqueue.h>
 
 #include "iommu-pages.h"
 
@@ -48,6 +49,15 @@
 #define RK_MMU_FORCE_RESET_TIMEOUT_US	100000
 #define RK_MMU_POLL_TIMEOUT_US		1000
 
+/*
+ * More page faults than RK_MMU_FAULT_STORM_COUNT within
+ * RK_MMU_FAULT_STORM_MS make a storm: the next fault is held for
+ * RK_MMU_FAULT_HOLD_MS, with the interrupt masked.
+ */
+#define RK_MMU_FAULT_STORM_COUNT	64
+#define RK_MMU_FAULT_STORM_MS		100
+#define RK_MMU_FAULT_HOLD_MS		100
+
 /* RK_MMU_STATUS fields */
 #define RK_MMU_STATUS_PAGING_ENABLED       BIT(0)
 #define RK_MMU_STATUS_PAGE_FAULT_ACTIVE    BIT(1)
@@ -118,6 +128,10 @@ struct rk_iommu {
 	struct iommu_domain *domain; /* domain to which iommu is attached */
 	const struct rk_iommu_ops *rk_ops;
 	struct ratelimit_state fault_rs; /* for the fault reports */
+	unsigned long fault_window; /* jiffies: start of the storm window */
+	unsigned int fault_count; /* faults in the storm window */
+	unsigned long held_banks; /* banks holding a fault, interrupt masked */
+	struct delayed_work release_work; /* releases the held faults */
 };
 
 struct rk_iommudata {
@@ -638,6 +652,88 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 		rk_pte_is_page_valid(pte), &page_addr_phys, page_flags);
 }
 
+/*
+ * PAGE_FAULT_DONE lets the faulting master go on. A master whose job points
+ * at unmapped memory, such as a codec core given a bad address, keeps
+ * accessing it and faults again right away, many thousands of times a
+ * second, until its own driver resets it; and an encoder core was seen to
+ * retry the same few addresses for minutes. That interrupt storm keeps one
+ * CPU in hard interrupt context, which can also keep the master's driver
+ * from ever running the timeout that would stop it.
+ *
+ * In a storm, don't acknowledge the fault: the master is held at its
+ * faulting access, as the bank stays in PAGE_FAULT_ACTIVE, and the fault
+ * interrupt of the bank is masked. rk_iommu_enable() (an attach, as done by
+ * a driver that resets its core, or a runtime resume) acknowledges the
+ * fault and unmasks the interrupt, and so does release_work after
+ * RK_MMU_FAULT_HOLD_MS if nothing did, so that a master whose driver has no
+ * recovery isn't stopped for good.
+ */
+static bool rk_iommu_fault_storm(struct rk_iommu *iommu)
+{
+	unsigned long now = jiffies;
+
+	if (time_after(now, iommu->fault_window +
+		       msecs_to_jiffies(RK_MMU_FAULT_STORM_MS))) {
+		iommu->fault_window = now;
+		iommu->fault_count = 0;
+	}
+
+	return ++iommu->fault_count > RK_MMU_FAULT_STORM_COUNT;
+}
+
+static void rk_iommu_hold_fault(struct rk_iommu *iommu, int index)
+{
+	rk_iommu_write(iommu->bases[index], RK_MMU_INT_MASK, 0);
+	if (!test_and_set_bit(index, &iommu->held_banks))
+		dev_warn_ratelimited(iommu->dev,
+				     "page fault storm: holding the master for %u ms\n",
+				     RK_MMU_FAULT_HOLD_MS);
+	mod_delayed_work(system_wq, &iommu->release_work,
+			 msecs_to_jiffies(RK_MMU_FAULT_HOLD_MS));
+}
+
+static void rk_iommu_release_work(struct work_struct *work)
+{
+	struct rk_iommu *iommu = container_of(to_delayed_work(work),
+					      struct rk_iommu, release_work);
+	void __iomem *base;
+	int i, ret;
+
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (ret <= 0) {
+		/* a runtime resume reprograms the IOMMU */
+		WRITE_ONCE(iommu->held_banks, 0);
+		return;
+	}
+
+	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
+		goto out;
+
+	for (i = 0; i < iommu->num_mmu; i++) {
+		if (!test_and_clear_bit(i, &iommu->held_banks))
+			continue;
+
+		/* Nothing to do if the IOMMU was enabled or disabled since */
+		base = iommu->bases[i];
+		if (rk_iommu_read(base, RK_MMU_INT_MASK) ||
+		    !(rk_iommu_read(base, RK_MMU_STATUS) &
+		      RK_MMU_STATUS_PAGING_ENABLED))
+			continue;
+
+		if (rk_iommu_read(base, RK_MMU_STATUS) &
+		    RK_MMU_STATUS_PAGE_FAULT_ACTIVE) {
+			rk_iommu_base_command(base, RK_MMU_CMD_ZAP_CACHE);
+			rk_iommu_base_command(base, RK_MMU_CMD_PAGE_FAULT_DONE);
+		}
+		rk_iommu_write(base, RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+	}
+
+	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
+out:
+	pm_runtime_put(iommu->dev);
+}
+
 static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 {
 	struct rk_iommu *iommu = dev_id;
@@ -698,8 +794,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 			else if (print)
 				dev_err(iommu->dev, "Page fault while iommu not attached to domain?\n");
 
-			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
-			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_PAGE_FAULT_DONE);
+			if (rk_iommu_fault_storm(iommu)) {
+				rk_iommu_hold_fault(iommu, i);
+			} else {
+				rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
+				rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_PAGE_FAULT_DONE);
+			}
 		}
 
 		if ((int_status & RK_MMU_IRQ_BUS_ERROR) &&
@@ -1029,6 +1129,8 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 	}
 
 	ret = rk_iommu_enable_paging(iommu);
+	/* enable_stall() acknowledged any held fault, INT_MASK is set again */
+	WRITE_ONCE(iommu->held_banks, 0);
 
 out_disable_stall:
 	rk_iommu_disable_stall(iommu);
@@ -1322,6 +1424,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 					"rockchip,disable-mmu-reset");
 	ratelimit_state_init(&iommu->fault_rs, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
+	INIT_DELAYED_WORK(&iommu->release_work, rk_iommu_release_work);
 
 	/*
 	 * Take every clock the devicetree provides.  Most IOMMU instances
@@ -1387,6 +1490,7 @@ static void rk_iommu_shutdown(struct platform_device *pdev)
 
 		devm_free_irq(iommu->dev, irq, iommu);
 	}
+	cancel_delayed_work_sync(&iommu->release_work);
 
 	pm_runtime_force_suspend(&pdev->dev);
 }

-- 
2.55.0


