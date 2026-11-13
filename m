Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600403;
	b=LO02SP8Qxp9DKnJ7kxRHgGFRZYkrhQFacp/aIpQBmFOLItYjnWJWuEEX82nTaGcKnMr/
	 /0hRCqgv8Abk+DN89+dfKfCjtpMzo4S9BarYtBj6IUfE0pmdyEiNYBK6l9nUDysGldOMZ
	 1C9TpdBU3OdAe0NyZcnwEOnhI6mYHnkCppHpypYXsuMwv+7in39fkFeMWzVlKR05iD9jT
	 NS+SOw0mrzD9R8jFEzJLZCJD3jxk50sboZmYAqHF1jcFuIGIoHTzPQkPcXDElD/ciLYDv
	 vUWy2G42BbKfVwJbtxBvxCOeTpCkpjX4iWq1Db5oukm91kY2hmZOsuoe3kcpL8dzYiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600403;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=naWA0LNFRDx3oJtDCNX9oIDZ90ywR8sYo5ZRufD3QUw=;
	b=bAzMcrkmyDVwY/Iuf6ajPfTStffoz9hx3l34z1/Lav2Ul5fqyYx7hqicZOQfLiYJ6Owe
	 uqBnPei9rn5ZnpANRXIA+be9goOLvGjxbzYKLMlb0DOk6egBjSZMw7nAkq93ktdqlHQQD
	 AJECXiu+c1pGVC+Zjj6e5XHDOfAcmKnzPgbR0uqsnotmoiKrtJNzfq6EPwBchnvdWKd/Y
	 X5KqBKKTRDNbneWGOHvQqdlt7GgM4Qekt1R+LRohOfXJrfpyTLpYE7FUnFu5v25sq6vB4
	 4vx4ER7dcKiKnI/roa+AfDYytlU5mRqX7zcXOi1V3ulby5x8E8r/UK31lt7rvYDfDQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBHiH9O4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D95606A32E;
	Fri, 13 Nov 2026 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBHiH9O4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794600403;
	b=cpjmM/wtDmRYEJun3jTL41TnZTw9SsNlVfLAmMjJ8obHv3XGpCvMaQiOfZ4fsP3lYcyo
	 tdinw6hkhrwVhinB5VdfCd0RbD6R139SrJzC5xZA9+SNNXwpOyeVurrwRerYELNA1ikge
	 PolPXI4Y8SFTcMpthrZGzAUuE+CKA2daoNbOV8MJ6TbyhlkzqjVU11kKBecIewa4b7u/B
	 r4a4I6SZR69chTJWuUi+S/NYw8McouvKm5KNwfsiTwVKK7sTl6vXCUWGHZpWHyd/6v7he
	 anpxAG93qnV4aqsg0X5ickydvvMpagP2r0Zu5ZigVtazjEowwaquDserTF2TUjq8C3w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794600403;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=naWA0LNFRDx3oJtDCNX9oIDZ90ywR8sYo5ZRufD3QUw=;
	b=rIy1PfTZa283ihYIuU8mJK3Aw/hB1IGa9D8QDWTRCY4Dem++lWig6q46yggNUxPQ5l2v
	 m6sBseuIZgFSX6hHiq671SO/qTv5gjby5aFl/QokeJkalhD4Y+n5hxzGnX/5EREn1Lrqm
	 0oMRmoN0uSanQREX1+ojgVnQ3h7DaFP7q+Lm8lFysUPYttNyoZc3BXf5UF05zVqTBRBiA
	 9ixmTX2/34jg5PJ0CFcESDYbvOWU9mv39Vy21fhq8SaBoSNe6o6ynNdC+td7+qscTqQ3d
	 r6ep7MUVzAhyJbhm2rx6Zv4xCc4zt2kt+QDNg3IBOZIeIKKWxJP6g9F1j5iSSN97f/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 209031F000C4;
	Fri, 13 Nov 2026 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600403;
	bh=naWA0LNFRDx3oJtDCNX9oIDZ90ywR8sYo5ZRufD3QUw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=MBHiH9O4x78rcSnfH0D1HMsCw0lPD/gbkDfuIUuRE5UYrKCmstvdbfBs6nZF1ZSgV
	 0ZNCCZ/jp+5D2fm983R5xwWtPh51Tq8tB73kYjyXj2sNozGJ6TdflYOXFJjkIWZ/O5
	 z0dRqVxuyFlVdfySee+9JP93bV/RqvjyJ+yQusJsU3LiybtQEUoQG2Hl5iZUI1lTbL
	 y4ThV9iqP4C+RPQAXvODoE44px2SfEAgLbxoS12pLdaacdCzicBxa9bi/7i61g+ZsK
	 pqF0BwmfnEgkJ1bpnDfixGIS7LiP6hbAFlQV91zEGbypS2EY3G9SL/hjgSZ6XF4Erw
	 tNjbAn8755ihg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9302E49AAF;
	Fri, 13 Nov 2026 20:06:42 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 20:06:43 +0000
Subject: [PATCH] iommu/vsi: Don't write the enable register on suspend
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
Message-Id: <20261113-vsi-iommu-disable-v1-1-94f7f44540b3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IUgm0VxEX6kx1SqOSUSkE7
 260y7f4P4FyFFZ4FQki76IyTxm2LKAf22lgFMoGZ5y31j5wV0GZQ9iQRNvuy1g5JvLOkzFPyN0
 S+S2/+1k3f+vWfbhfrxEcxwll7r8XdQAAAA==
X-Change-ID: 20261113-vsi-iommu-disable-42edd626d009
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794600402; l=1969;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=uftO9/StWDRCH/AfNoCaBYaLw8jONKGe5KoaJEmiG08=;
 b=y7eNt27TUkgxu4uCnx3TKetXTmEPoFfqs/j1r46vKVfhIhhpXMPBwxTcrKJGIbkM3oUZmEAK9
 wme1g+bGihiA0Utpxf5tmDqLALSf4NhU5r0LpuEWxwWfxbhQdGaukwI
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Benjamin Gaignard pointed out that, per the IOMMU documentation, the
IOMMU can't be disabled once enabled. Drop the write on suspend:
resume reprograms the IOMMU anyway.

Suggested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Benjamin suggested this in the hantro-robust review:
https://lore.kernel.org/r/f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com

Identity attach keeps the write. On RK3588 it does clear the enable
bit (AHB_CONTROL reads 0x1 before, 0x0 after), and without it the
IOMMU would keep using the old domain's page table. Benjamin, should
that one go too?

Tested on RK3588S (Orange Pi 5), v7.3-based kernel with [1] and
hantro-robust v3 [2]: AV1 fluster unchanged (203/242), 20 AV1 decoder
unbind/bind cycles, 3 s2idle cycles. The IOMMU runtime suspended
after each step; no SError or IOMMU fault.
Not tested: identity domains, suspend to RAM.
No conflict with [1] or with patch 10 of [2].

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed it.

[1] https://lore.kernel.org/r/20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com
[2] https://lore.kernel.org/r/20261113-hantro-robust-v3-0-82383c722ad2@gmail.com
---
 drivers/iommu/vsi-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5dac20b143a5..bd984060253b 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -740,7 +740,7 @@ static int __maybe_unused vsi_iommu_suspend(struct device *dev)
 {
 	struct vsi_iommu *iommu = dev_get_drvdata(dev);
 
-	vsi_iommu_disable(iommu);
+	iommu->enable = false;
 
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 

---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261113-vsi-iommu-disable-42edd626d009

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


