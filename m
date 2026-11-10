Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294664;
	b=BoxMwaC6qADP7askHwIgh/a8qEQkfKM3iDR714z/kOpnVKb2OQDCFD0tOw/L2GBtDGsL
	 ZAmR4Gv7AetsdjJulLNUzybdxI+0eX5AQQbJSQkA8ixfR+KHvdsIbaryUkFsQEtlZJZnG
	 XaHX/MiUAQRlC5puMuNR/rZ5HXTMYEewIpy+vLO6NGZ8amryqTbgMsvHezCrSZKV2B0MS
	 BCjJcVMZUxhEev3z3VfzMjaAuHzA7CAY0Thfpsp09x6+QztieCC5vt1ofqKyhjCTEGZWg
	 a/Urh135w/tBCUuARRt+tQpP0cs5A+q/Srx39POvAsl+qXjslcOE3Qxvlk+Q/3gERhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294664;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YGGZEiEJQx2SumZHGaufpsqGi14CEpKUSOIlgf0CmYc=;
	b=ZPWVfbnTSvd+LqvaE0rdwK5rE/fZhrsk363dk94SA2EEpdG/0w0G0uFvYgNpe17VbUZz
	 9/7mbN5sS2VdOkeP4WgVvOw1FP6YRb1mRWM4gxqg6a+BPVMGryXy/7K9LrTX3j3OfPDFI
	 I4mHzwCFH1LPRq/rJWeigFeS2+eKooZZqgPVAH3z1Vd5/kY8huFvLwNh5cuE6PluYv5q6
	 f8Car506IVnHDLBcME9IGRVFMkdzUAeZi1Oy3lfAyDTM5Um0lLplGzKy9Gjz5YUeNeemq
	 /pMaZFWYzeUDnnjXa6XrcQLTrGmoBsfr0f3u2OS7GdYaKoR9/WYFX5cGPCoRWd+ncUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoHHgvQj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000B606A331;
	Tue, 10 Nov 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoHHgvQj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294664;
	b=l/2PKg3ReK36Ju4+ONWmy9OqzwN6jH9mhYJur0wBGFCtbW9PDBZhP3iXPDRXl7Gw6fQl
	 YlU/H1rhE6uaaLCXxFpXPoy4O6IuF8HzxphdaKjwaNen+MCSgMw+Y2HGx38Fe86nxkMh+
	 GwNh2TWTivPAbkxjPiT//fU9PTM20yRHCr06+V+YOYrGCOL0DNni2J3xTip8C5z/kqnaF
	 XL0cIUOyt+hEg5GBNmTFSEtAESOWV+yFoJQ69ZYokpAuY/nyVbWhysKbNiFtMAQZXpMqp
	 Hga5OTVwYU+pbSZeFpz+EvctMIJUEJkB4PimbVetjVKvu+VPoYIDbJNjKlxWBJyNhQQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294664;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YGGZEiEJQx2SumZHGaufpsqGi14CEpKUSOIlgf0CmYc=;
	b=sHzePI8yjVAQc5HCLVs5KYdkOOt220FrToxxpshK6g31PsD43xvODlzAHrXmTA9QRjZ8
	 vNxUpHAT/B9IPHP16r6slEnItKbaY08TcrUl+Gv3MpLqYR1a7hjWfsH93DtpPkiHGSwxK
	 cqSrvweqGc4m5UJsOkT1RE/E179SW0Xm5aEcBybCfV/Q2oZ/xxMhU5+ikO8RLqXa29lMO
	 5uOHX3YkvdgeJHN58nckI7Inw7fvzgewZe/RIzhhssQISJ0o81WQkcJVoY/vJZiJh29Be
	 dKlvLVk085LMc0gtcIzRNsIooOAEUZBwrHrzlTj4p8Pql5SUULn3do0IKbXDVMLSq+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 00C531F008A4;
	Tue, 10 Nov 2026 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294664;
	bh=YGGZEiEJQx2SumZHGaufpsqGi14CEpKUSOIlgf0CmYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aoHHgvQjvZEibXjt5qNqA9ShcpFAhAF3czoEYUhgX8AD40vyiYI+9lQvjlfmrQGn0
	 s2omJhsNJP0c4bjaLpT1gD+DYZ1Qv4wVEEYkVRQoVkcwu/yj36Iiy9ILFOMTMQKaE6
	 8ZH5V8+J6CmXOp/O/OE0PS+iOwGxDb9d1CqODAYTGhWwLAy0ni7HcjJVZLZJKG2Nft
	 gWo4GgUFap/YtGK1HswmfPMOD5lbFeg24mlyyKJN1igPBLVZMkFKd0XhQTtDQ2nPJN
	 4X+MJFZFzYFVBaPrUjG+xjXND/usCDT6+Hf5slDY4pRS4sKksJQhMgnSYPApS/xW9L
	 Wcdx4bW5lrcbg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 841B148931;
	Tue, 10 Nov 2026 07:11:02 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:05 +0000
Subject: [PATCH 4/5] iommu/rockchip: Don't skip a bank whose state differs
 from the others
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
Message-Id: <20261110-iommu-rockchip-faults-v1-4-b1dda574dbb8@gmail.com>
References: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
In-Reply-To: <20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294661; l=5294;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=L9f0wyXmMnNV1dCgWV8ug4pooU6+g7FsJrT7QDfrfBM=;
 b=tst6AZMqcHDHHTM8PLQucpyaC55w/AQCxb1enJGg8azycfkR/0PThyeykdVM8jJhszOUJ2PAI
 EwbS/V4A8fZBNpkXwAMKoImm3YOlWndHQ6vdFLMPUvq6r3Pj3bUvunF
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

An IOMMU with more than one bank (MMU register set) is commanded through
all of its banks at once, and the state helpers report a state only when
every bank is in it: rk_iommu_is_paging_enabled() and
rk_iommu_is_stall_active() AND the status of all banks. The callers then
skip a command when the banks don't all agree:

 - rk_iommu_disable_paging() sends no DISABLE_PAGING unless every bank is
   paging, so a bank that still translates while another one is in
   bypass keeps translating after rk_iommu_disable(), through whatever
   its DTE_ADDR then points to, while the driver considers it detached;
 - rk_iommu_enable_stall() doesn't stall a translating bank when another
   bank is in bypass;
 - rk_iommu_disable_stall() doesn't release a stalled bank when another
   bank isn't stalled, which leaves the master blocked.

The banks do get out of step. The two banks of an RK3588 video decoder
IOMMU were read back with bank 0 paging, DTE_ADDR still holding the
DTE_ADDR_DUMMY pattern of rk_iommu_force_reset() (0xcafeb000, STATUS
0x11), and bank 1 in bypass (DTE_ADDR 0, STATUS 0x18), after a
FORCE_RESET that timed out on a decoder that had not gone idle made the
attach fail with -ETIMEDOUT. From that state, rk_iommu_disable() sends
no DISABLE_PAGING and no ENABLE_STALL.

Decide per bank: wait until every translating bank is stalled (a bank
in bypass cannot stall), release the stall while any bank is stalled
and disable paging while any bank translates. When all banks agree,
which is the normal case, nothing changes.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 63 ++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a81da8115085..c57a1f8941c5 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -373,16 +373,54 @@ static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova_start,
 	}
 }
 
+/*
+ * The banks of one IOMMU are commanded together but don't always share one
+ * state: a reset of the master, or a FORCE_RESET that times out, can put one
+ * bank into bypass and leave another one translating. The helpers below look
+ * at every bank on its own, so that no command is skipped for a bank only
+ * because another one is in a different state.
+ */
+
+/* Every bank that translates is stalled (a bank in bypass cannot stall). */
 static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)
 {
-	bool active = true;
+	u32 status;
+	int i;
+
+	for (i = 0; i < iommu->num_mmu; i++) {
+		status = rk_iommu_read(iommu->bases[i], RK_MMU_STATUS);
+		if ((status & RK_MMU_STATUS_PAGING_ENABLED) &&
+		    !(status & RK_MMU_STATUS_STALL_ACTIVE))
+			return false;
+	}
+
+	return true;
+}
+
+/* No bank is stalled. */
+static bool rk_iommu_is_stall_inactive(struct rk_iommu *iommu)
+{
 	int i;
 
 	for (i = 0; i < iommu->num_mmu; i++)
-		active &= !!(rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
-					   RK_MMU_STATUS_STALL_ACTIVE);
+		if (rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
+		    RK_MMU_STATUS_STALL_ACTIVE)
+			return false;
 
-	return active;
+	return true;
+}
+
+/* No bank translates. */
+static bool rk_iommu_is_paging_disabled(struct rk_iommu *iommu)
+{
+	int i;
+
+	for (i = 0; i < iommu->num_mmu; i++)
+		if (rk_iommu_read(iommu->bases[i], RK_MMU_STATUS) &
+		    RK_MMU_STATUS_PAGING_ENABLED)
+			return false;
+
+	return true;
 }
 
 static bool rk_iommu_is_paging_enabled(struct rk_iommu *iommu)
@@ -413,13 +451,10 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 	int ret, i;
 	bool val;
 
+	/* Stall can only be enabled on the banks that translate */
 	if (rk_iommu_is_stall_active(iommu))
 		return 0;
 
-	/* Stall can only be enabled if paging is enabled */
-	if (!rk_iommu_is_paging_enabled(iommu))
-		return 0;
-
 	/*
 	 * Boot firmware can leave a bank in PAGE_FAULT_ACTIVE with no handler
 	 * (PAGE_FAULT_ACTIVE & !STALL_ACTIVE & IDLE).  Such a bank ignores
@@ -451,13 +486,13 @@ static int rk_iommu_disable_stall(struct rk_iommu *iommu)
 	int ret, i;
 	bool val;
 
-	if (!rk_iommu_is_stall_active(iommu))
+	if (rk_iommu_is_stall_inactive(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_STALL);
 
-	ret = readx_poll_timeout(rk_iommu_is_stall_active, iommu, val,
-				 !val, RK_MMU_POLL_PERIOD_US,
+	ret = readx_poll_timeout(rk_iommu_is_stall_inactive, iommu, val,
+				 val, RK_MMU_POLL_PERIOD_US,
 				 RK_MMU_POLL_TIMEOUT_US);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)
@@ -493,13 +528,13 @@ static int rk_iommu_disable_paging(struct rk_iommu *iommu)
 	int ret, i;
 	bool val;
 
-	if (!rk_iommu_is_paging_enabled(iommu))
+	if (rk_iommu_is_paging_disabled(iommu))
 		return 0;
 
 	rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_PAGING);
 
-	ret = readx_poll_timeout(rk_iommu_is_paging_enabled, iommu, val,
-				 !val, RK_MMU_POLL_PERIOD_US,
+	ret = readx_poll_timeout(rk_iommu_is_paging_disabled, iommu, val,
+				 val, RK_MMU_POLL_PERIOD_US,
 				 RK_MMU_POLL_TIMEOUT_US);
 	if (ret)
 		for (i = 0; i < iommu->num_mmu; i++)

-- 
2.55.0


