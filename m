Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588037;
	b=ngPrC59+SgOgm1KS/032XVdE5ZWGEreJy+GbO2vKjhtFg4q25w0cXGuxWlDHV/f/V2G3
	 HDdJnySbABaxVu+0JbfGYouDDkBgjWYiN+0vXegGG+/d9R/aEOrym8VCeO46PCWWCo4NL
	 eTOKfoE3K+l+MgALT076ukmEH8PzUHRzPGgFxr2VOv4SvTe/AuDgfhiErMJkmYkYnZ6rk
	 WfkfzoJrVNhspUYAVZNln+nB0sWdzHUSGftgfTqmIKifccNi6XchdSPbolj+GKfnwgOfM
	 Vv4GHx+Z7YC+QYQGfFP9sRncTJqPApzEoT+633h89Krz7jdeMqfG81mZMfCdqz5s2qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588037;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FYkTaVV0fWzeKNMvIz4sq8rCJvyMBu+tL9eDOhLcs6U=;
	b=fiIAZuobx/++kRtj3HNTg1ZShq9Z3apqGYIvHB1eACUL5FpXjiE34LqdHkb4tYFXB3Rd
	 I083VDceX7xvXPycReKxgjDUuxyOdVl7Aup2QDmfNoaSuf2mr7g4plz+SLGnyl0qFBNOj
	 iD1Fwv5zojk6x+VqVe3JW2XpIL1lfekc6swLXQe1zBuAovMpFhXAZqHq8/yCXktgBLXAR
	 9uA07wa8ORbpMCDCVPiDcpgYwRKJdc0soW3mpgmwg8k3Fdr7MB2uW1hd+Gpn4pgBJM+Qh
	 s8Lv+5+8fKAlR/tBSXpUjALRijOodYgxUmCNc29CWYXKJjuXVP661sLPmbys/unhifQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgVwakdF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5391C606E23D;
	Fri, 13 Nov 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgVwakdF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588037;
	b=AJoUpa6L7W1TTTA4e74QojUIpU57ByPICiRkFOSH52/oUsVjPjTECTJkaP4jJhGXJXg7
	 2CtzIFwEj2cky8B+Cg/skKD1SvoemQOXVM1x9trWktdWwNIvDY7P5KyY4OyN5V+P2ueik
	 dAuyhdMoEAYFfmQCFyboMSg8VijSJ7gGHeU1Iyzz7+FFLvFJGWQuFfKwUx4h+53M4wqck
	 I3y/L4bZotbJvdmdZbP8zqscOQZhyJp7IF915eE16KEPuvh/0ziSCA1HVSmW1Ei4mm9vA
	 PMfVTcjTgV9nFLic3FE33MSAuRt2BmNRt2iK/px5WwnMcwqnuFkJy6dj1gFBfXvDqIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588037;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FYkTaVV0fWzeKNMvIz4sq8rCJvyMBu+tL9eDOhLcs6U=;
	b=gY/h8GxT3He0sZ9VN0NUp81r4kjdWssNUDHjGxPG14XraW8IpJJrCmcvWgkUDwnJGDPj
	 nyzY/G8oMNviTcij/Jjkl5N9PEdpK7hqbcV/kw1BLIFzKhGVuESkiDHmM8KPOvTzV4FJg
	 DImYu4fVnUPfSUj82mipHHJ2E0Ru66WMjYGyk330+6fXgYQo5xQiU2KpbN8d7bMl04yue
	 oFU/40KpbmJdTgGE1jyG+tN+RLjhNv3IdvNHMwEAKmamqewd7r7vucT6W2Y8i3IpAzwBg
	 NR/PYid8lBr16LBpNQw1Z0cLoX15sG1T1LlZvVFzYfiBbbpS5BPDkFY0uLcxGtxr0qQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 67CA21F0089E;
	Fri, 13 Nov 2026 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588037;
	bh=FYkTaVV0fWzeKNMvIz4sq8rCJvyMBu+tL9eDOhLcs6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fgVwakdFdY7nVBMvRAkKac17V42I97RIwa8DZoXIox3TtIk7PJJ5qFuZjBPbU8EV0
	 LIxm7NpH57WY0zRqt6CbqUOkvZ9KVLq5/QI8RtkiXIKX8P5PZ6fFe7496h5cbENipC
	 pyCy322tvOEq1VuEEbh9hwvjlZA8ZQtWrvaeoDjPkjLr/Mr/q29IpwYH9imxl2PY2E
	 TgYwy8HU8239f5vd+D2f3eGZJlJf01hmsMy5DT8MK7pu1vWDYBReS84XRFuMG2BhD0
	 wDWUe6dBg4Y7CsOuyt/cOtd/C/Ut2zTQvIaE/SXqo2jjHucP6KqokFb1UjWxxDv8Km
	 hV1046Rn/DiWg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94BD5499FB;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:41 +0000
Subject: [PATCH v3 10/12] iommu/vsi: Deassert the reset lines on probe
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
Message-Id: <20261113-hantro-robust-v3-10-82383c722ad2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=1757;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=7/YPVx4qDegy0I+GiqV2r/FsoZZRHAX+0GSiqjWtgfw=;
 b=RiRLVgOv5pP2Pg5WhcuY0uoPfjdZHU4KYIfUkYibCYOOm52LnjxGzvZnsvK/sAGVwxBHc7owp
 0UZfNiAFK65BlIdcxaALT7rfzaivOz8pb627vsKnG3AaDiutbEVuHuF
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The RK3588 AV1 IOMMU shares its reset lines with the decoder, and its
registers can't be accessed while they are asserted. It writes them on
attach, before the decoder's probe deasserts the resets.

Deassert the resets on probe. They are released exclusive controls,
acquired only for that, so the decoder can still use them.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/vsi-iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5dac20b143a5..a3ec2fe5ecd5 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -669,6 +670,7 @@ MODULE_DEVICE_TABLE(of, vsi_iommu_dt_ids);
 static int vsi_iommu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct reset_control *resets;
 	struct vsi_iommu *iommu;
 	int err;
 
@@ -688,6 +690,20 @@ static int vsi_iommu_probe(struct platform_device *pdev)
 	if  (iommu->num_clocks < 0)
 		return iommu->num_clocks;
 
+	/* Shared with the decoder. */
+	resets = devm_reset_control_array_get(dev, RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED);
+	if (IS_ERR(resets))
+		return PTR_ERR(resets);
+
+	err = reset_control_acquire(resets);
+	if (err)
+		return err;
+
+	err = reset_control_deassert(resets);
+	reset_control_release(resets);
+	if (err)
+		return err;
+
 	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
 	if (err)
 		return err;

-- 
2.55.0


