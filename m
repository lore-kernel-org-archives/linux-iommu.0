Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800361;
	b=GyDrxC8hHaw0p40t69p6ahL/ifpsnqVkQgZwV42uDFvJ4C6hMJPSQNZ1sCpAF9OkDmWX
	 2l/0a0winUt4HRYJI/IqLBp6QcFQ9PXGBhwXpXpxluvDO2gtZNstHqHuFE1lTghQMS++V
	 ERNHsbFxn6cFWswEIwwTKhUDqNkpUncPvsENuWPGnNh+wshFje5BIFxWqOI3XwBuF8uJG
	 GTDIE+Lif5VG3WrXYKd2l+f2AcSChlXvQpTDGre3jdVSZiJ+bRd+h3wxb15t6dz4UJYIl
	 MBP83ezHpJypqKVuCjywbaGMxKWmRhlZiHEXKhRino9r/HIzEMGNeOf3Add6DF3OVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800361;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W1vdO8a9mxhEayuDDyrm76yluN+B8zC339a6nO+fPrw=;
	b=yvTBao/wC9E21Jcl7l4ZYMtI0Ts71jFqTIOjcp2Bi/IpSBhTk/yA2syK2t40hyCA+IGV
	 UdmqbRAHvYGTLVEOBjd6omQAW4xfE9afrn/p5OtSCK7t92mbpVue3FtwhjB+AW5p97lJw
	 LLvJgzsPmF9y0Qwxk4H5FX83q7udZAyWhDqOXo+wCKlQsFU256WMuKHhpajddTXK5ehC2
	 XIBDemNq2BoZcOJTKUzhoett+/dK+l/LDmetKZI3N7MTUXf2Si5BJVFrQWjB2rITHmzmP
	 eZyYKCewXST437Q0s3kndo77PB7ELJVNrWxoBIXAmwaQ0loNALHLgM3p4zXJ046/G6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oKTvF63q;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA099606A31F
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 03:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA099606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oKTvF63q
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794800352; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=W1vdO8a9mxhEayuDDyrm76yluN+B8zC339a6nO+fPrw=;
	b=oKTvF63qcXcNcA97HrmQHZO1G87B1vrXhZH9FTaOS2uj1jfXOnjluFsMQX49BEbgJRTgfkt9LDH9E+fr/oa/mtcnX8yjbStoxT5A4hvm9U3o8H+ZyFKABf7YfBLQ8OwcKb7+tBLM7pKd42kne6f8oifAVZX0f34mdL0RndDjtQ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XElQojT_1794800342;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XElQojT_1794800342 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 11:39:11 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Do not clear unobserved log overflow status bits
Date: Mon, 16 Nov 2026 11:39:02 +0800
Message-ID: <20261116033902.3277875-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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

amd_iommu_handle_irq() clears the interrupt status with an unconditional
writel(mask, MMIO_STATUS_OFFSET), where mask is int_mask | overflow_mask.
The log overflow status bits (GALOverflow, EventOverflow, PprOverflow)
are RW1C and, per the AMD IOMMU spec, transitioning them from 0 to 1 does
not itself generate an interrupt; they can only be observed by an IRQ
round triggered by the corresponding log-interrupt bit.

If hardware sets an overflow bit after the status register is sampled at
the top of the loop but before the unconditional writel(), that write
clears the freshly-set bit while the stale sampled status does not
contain it, so overflow_handler() is skipped for an overflow that really
happened. For the GA log this is fatal: amd_iommu_restart_ga_log() is the
only recovery path, and per spec section 2.7.4 logging stays halted until
GALogEn is toggled. A bare W1C of GALOverflow is not part of the
documented recovery, so the GA log stays halted, no further entries are
written, GAInt never re-asserts and the GA log interrupt line goes
permanently silent, losing all AVIC non-running vCPU wakeups on that
IOMMU.

Clear only the bits actually observed this round by writing status & mask
instead of mask. An overflow bit set concurrently is then left asserted
and is picked up by the existing ERBT1312 status read-back at the bottom
of the loop, which re-enters the loop and runs overflow_handler().

Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d0d55c93a480..39254671b924 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1168,8 +1168,17 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
 	u32 mask = int_mask | overflow_mask;
 
 	while (status & mask) {
-		/* Enable interrupt sources again */
-		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
+		/*
+		 * Clear only the status bits observed in this round.  The log
+		 * overflow bits (GALOverflow/EventOverflow/PprOverflow) are RW1C
+		 * and do not raise an interrupt on their own; clearing them
+		 * unconditionally here would drop an overflow that hardware set
+		 * between the readl() above and this write, without ever running
+		 * overflow_handler().  Leaving such a bit asserted lets the
+		 * existing ERBT1312 read-back below re-observe it and re-enter
+		 * the loop so overflow_handler() runs.
+		 */
+		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
 
 		if (int_handler) {
 			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
-- 
2.43.7

