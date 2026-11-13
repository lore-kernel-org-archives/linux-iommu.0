Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588035;
	b=bnn4jqegrsm7KmH4ULv3am7Ludb1dzR2C0smFgcmF3uY1RNEto8xfuL90vTRlM127WVx
	 90P9E1IKWBAf1pInsjGFvpyB7nwDIX12evGCg7eP0e66uNLbIo7SBRL06P5ebcQ93sfHz
	 tbhyllc6cXxgUV5ddmn0lrDv6xSZfQtJ/uF0KyYQT5kFQzN0x2eX3a+cL5TKCuTGLIaHL
	 v4RgCikImZtdYyGV2HXs2RYZ4MukCf6UFm7fU79+I9QThRZ5IYCmkETFoT9erXJ9chGid
	 ADe3bn8Xb4BGldcZUjqva3OWU3NhaBUvwZrLLrG3J3kE+lMwdsxyiZ2+1SSLUaVpz9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588035;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ec4zah7Q96HPfhyPhNGtgKfP11qpmETeWTwnBvitCPg=;
	b=e0RMnSEeDnOlV9JKnNzfPsGJ5Q1E9blQWPIm7uzRxaoOSBu+hwg5uh0+ITOBKO9AJ01H
	 mchTPLy1yJ6rzRDL7apq248rl5ZQ/wy0+O6yK8q8QDe1a4f32S1RRFslM8+99yYxczc/u
	 tvfkN2E1hi9QjnAlqlN5Gls977TOPqO+p3SBpn/nUboXga5lG4z4ZpJYHia5uQxdjX80S
	 61bEM6b9XHCDOpxBRxY/bn8ENVwgnKmfaER/b6/n0rgi1l1/eWGJEDmCmdFvGaks5GSLv
	 OFbu+xe07QXVBx6OViGP63UixIbR852iAmQpwkwlh7dlLoRFOqdzpfc1zHxRNT6KzoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKPGakWR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E74606E212;
	Fri, 13 Nov 2026 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKPGakWR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588035;
	b=J3+b5xxCLQVXT3KRIElQtYA8IiBFU0f4gQJpnv5Juu+ibKDpaVO6d0+TZFQ52dXfxanr
	 cIH0pcjOskJL2CDlm5f+/2doITDF0mY92m5EJg7zeSvLD+thwkKOm21MG2grbtvkMjc9N
	 jaf2eylkjQAxPESST71wAbyMwBPh8lwUea6/2acmnBajDQgFYKx+gEP++UqmpCI1dpYAt
	 32o2JrnNEkYh3gM8lqmOE11w3lgoSa0uiXJkUiXirVM5NmndH64bFGzX1diml+SbxIZmw
	 4g8/YRWXoXFuDz0CHcVfwzWeFr6Q8XhxzQN8NysBilGDmNzOyigV9b6tWRBU+M761PQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588035;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Ec4zah7Q96HPfhyPhNGtgKfP11qpmETeWTwnBvitCPg=;
	b=ILSgiod/YScamA1d/4QeB9l46xtMcEUfZ+ccCaNHajl8wXJIMdoDmD//+yrZBoPo55lt
	 J9PlwrTTboA+OeWhzo8ee1GtnGNX4JDiQDEh7R1zBSfm25I0xzVZU/uu94S4Ubre0raUa
	 ph/NQ72UWdP958Hdwl2cSlZU44Jpw09v1Hpgm9N/Q75uR+/8p2uoFK6vD358ZoPBQdtp8
	 o9yheFBZLvmVoWPBmkXsruRrjdJlS5jPNC57NTXSL1ochDh8+SwKuQHcI73CgYKSfayAr
	 aPc54xIp9fec6//ELkIXci1wZkpG0iXfYNrngtnluziigJtdLbXUqhFtJ4tD+GbA6Cg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 492D81F000CB;
	Fri, 13 Nov 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588035;
	bh=Ec4zah7Q96HPfhyPhNGtgKfP11qpmETeWTwnBvitCPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KKPGakWRk+HGoeq25uvTn1PB0W2En3CuhyeGYM3na5Z9r32rhuHO5FwX0ItX9JK81
	 Caqjv7HjJQkxKRUh2jZXgcfxz4Vkpx06to3WIfSOU4PcPGv3nEycPQNZVOK2GIMj5a
	 wZIL0XJd8qwmB1MnVt83Qp/fMkCzycnb8d5x9GRAPczVRss38/8F5cig7p7tMfSKyf
	 JtG0w/NNhHZ8HPkx+6HfnkWtGhru5wwNA2AK4yJTEp8GxUyio6o84FFy6VgAFlP+EW
	 1+rlT8K4NF/YstKYOE1XZoxgkHrPvbBIu4HEwVFILzqFPO5atPZsRzDoOhYEBsC1eE
	 Tbllw2/wNWOMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3DB29499EB;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:37 +0000
Subject: [PATCH v3 06/12] media: verisilicon: Reset the Rockchip encoder
 cores on timeout
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
Message-Id: <20261113-hantro-robust-v3-6-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=2987;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=q6Pq46ig5sFzVhXewo4JD0YaRvjUliQqE72OFoEItyg=;
 b=bCV7tBrPCKFdbUpYscknizIlwUrT56Wl9krvpZSnskbprlbtyeqZRtn0SbCoHIOkl7HdMgZqb
 SKRHwEqYZGmCwh9i7cDGNjLtbh15HYxzVa7dJOGYwHEXgD5BAV3OIMD
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

On a job timeout, the Rockchip VEPU1 and VEPU2 reset operations mask the
interrupt and clear the encode enable and AXI control registers. On
RK3588, when a VEPU121 core reads an IOVA that isn't mapped, the IOMMU
reports a page fault and the core never becomes idle again: its AXI
transactions stay outstanding, the IOMMU can't be stalled anymore
("Enable stall request timed out", then "Disable paging request timed
out" on runtime suspend), and every later job times out as well.

Pulse the optional reset lines in the encoder reset operations, after
stopping the core through its registers, as the Rockchip BSP MPP driver
does. The job that timed out still holds the clocks. Nothing changes
for device trees without the resets.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 .../media/platform/verisilicon/rockchip_vpu_hw.c   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index ce3dbea70a8d..1467ae2bed1a 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 #include "hantro.h"
 #include "hantro_jpeg.h"
@@ -468,6 +469,31 @@ static void rk3066_vpu_dec_reset(struct hantro_ctx *ctx)
 	vdpu_write(vpu, G1_REG_CONFIG_DEC_CLK_GATE_E, G1_REG_CONFIG);
 }
 
+/*
+ * A core stuck on the bus, e.g. after an IOMMU fault, can't be stopped
+ * through its registers and keeps the IOMMU from stalling. Pulse its reset
+ * lines, if any.
+ */
+static void rockchip_vpu_enc_hw_reset(struct hantro_dev *vpu)
+{
+	int ret;
+
+	if (!vpu->resets)
+		return;
+
+	ret = reset_control_assert(vpu->resets);
+	if (ret) {
+		dev_warn(vpu->dev, "Failed to assert resets: %d\n", ret);
+		return;
+	}
+
+	udelay(5);
+
+	ret = reset_control_deassert(vpu->resets);
+	if (ret)
+		dev_err(vpu->dev, "Failed to deassert resets: %d\n", ret);
+}
+
 static void rockchip_vpu1_enc_reset(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
@@ -475,6 +501,7 @@ static void rockchip_vpu1_enc_reset(struct hantro_ctx *ctx)
 	vepu_write(vpu, H1_REG_INTERRUPT_DIS_BIT, H1_REG_INTERRUPT);
 	vepu_write(vpu, 0, H1_REG_ENC_CTRL);
 	vepu_write(vpu, 0, H1_REG_AXI_CTRL);
+	rockchip_vpu_enc_hw_reset(vpu);
 	/* Only the interrupt handler writes this register: enable the interrupt again. */
 	vepu_write(vpu, 0, H1_REG_INTERRUPT);
 }
@@ -495,6 +522,7 @@ static void rockchip_vpu2_enc_reset(struct hantro_ctx *ctx)
 	vepu_write(vpu, VEPU_REG_INTERRUPT_DIS_BIT, VEPU_REG_INTERRUPT);
 	vepu_write(vpu, 0, VEPU_REG_ENCODE_START);
 	vepu_write(vpu, 0, VEPU_REG_AXI_CTRL);
+	rockchip_vpu_enc_hw_reset(vpu);
 	/* Only the interrupt handler writes this register: enable the interrupt again. */
 	vepu_write(vpu, 0, VEPU_REG_INTERRUPT);
 }

-- 
2.55.0


