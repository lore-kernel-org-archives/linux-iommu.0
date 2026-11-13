Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600277;
	b=fblm9PWMVcjE5Qhvz9JAWEkFqUXaeATmPIptx4XhaN2oKvep/mydxOkygH7rMuj8AYoO
	 afbDSSAFssE1NEZxwXnzlKAz/Kko1eosLG07aExhKOoZ7YxALEnME5xmw6cAjncIs+U1F
	 sflbJqpsQD60QQ0uI4gfce++/jpEvgwS7RyacPj/0iNt5nU8OKj+UUvYJQQ/AZjK4d+jU
	 6C2m58QckSRkm/9ai2+DI6JW1kit0wnDOieCvpenXSABTz6JL0ZXEKPfRAGHVhwOGDsS3
	 2O4MUY/oxL8/aMI+TJxaV7L2q5xDWGXQBnlkhZ17ti3VpRi2LSbN01v9tLKt332MetA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600277;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/wJ2mrH2WenYs3WJgOJsOBCLD9a0ckNwTvZEuj8DLUY=;
	b=hutCIN7S6J8i6JeiCwvPjIZeDPECxpe0hvHwijmOSLHMJ6w07Zc4KuwQif15zYnIrSuO
	 aoVmISAsK2gTLVkNHMB9DPXvKYm0bUwx9WlmeNHcLlh0XpOo/n9c27KMZ1zSDEx4exueC
	 NVhrPBO+FnJVFKriDleiHFQOIOROkPoOshygK9VcOcvseP4EhfLGtHg1C2eFB1s2aTH36
	 1C/IBj2DkGkozFnF7dsXl8+gfgl9iwKn1BGlLfIwfv2mzJvbuYx4zwgt4Vy+7/5uOXEIv
	 v0z9FpJCcbOpgKaERUBF+KghklkSGcM2YGPbgZaNb3vxdfwrWYJiUlqlMILSjQXYt/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFXlkYij;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72359606A337;
	Fri, 13 Nov 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFXlkYij
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794600277;
	b=0TmvGKjDoWzf3VEFox5XiGAWmYC4gthyC6XhllzTruqlrrqTQ0qKEFbtoDzEoUTszCdU
	 a3hDNin5niCnZ/iuH2QPKNF/HNH/o4Lk8swWPZMMJYunw66x7O72xWG1xMFPFdJixJL1V
	 pmmU973afiduWDoNMjMu8w5GZtF7+gBoIeLm6dDza0I7cJ52b/nYqAZe94Q/5LrzMz5Mw
	 VI8P+n95d9cnRPFFfb+Rr+XKSKWrYPQ2Pg81t+B0uAKZXMZTHkG1S1Ta/J3Ip68ydnW3q
	 PtX5KqwFMYYkv1M44wnXEugMLQln7tUmotsTZ6wVJttZffuYZQMQo2HC6W0Uto8v1WA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794600277;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/wJ2mrH2WenYs3WJgOJsOBCLD9a0ckNwTvZEuj8DLUY=;
	b=2dmxuggUBFrgf25N34wf19oIuCvDUFz977eLhY5KPIqWVWpdsairmvu9UqACaItqcw8L
	 JoOpoQxVnGjgYpBBKu6aNyjc7QMocenNK+F7f4X1KZ5EdxdgdIxU6j6lQl11japddsftY
	 34hjW3FLFhUvCUXkY+uUaMZpxrYWHuzXn+iOw6CMNZNrV6DJpRIR7zTq+dSRqhZZM3JHr
	 jFurVL6bn4fE3Per/Q/sTBylxJfWuXxPqaKEjsSJT3/PhnbM/w4jh8nZaRkrFPad+4Xev
	 NtFca7YRzu8dBk58MadaDhHy7RE+C6pqW418EuGsKmZcTpqTD45wPtd/g4dIortR2pQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AFD811F000C6;
	Fri, 13 Nov 2026 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600277;
	bh=/wJ2mrH2WenYs3WJgOJsOBCLD9a0ckNwTvZEuj8DLUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NFXlkYijYHhr5rafaP99cyAT8BZe8ZhzWcLXXKUhdM3AsD1AJUnV5o7zmy3qR3YM8
	 8eFo3/1uppUHpFoBSGll6x9apf9D85e36ruwA9Hb4o8dLfmhzQKPr2493nsbdgxh3k
	 6+1hoNJm1WM20cPeW12llHTBBC5WyXTDs06bd/3gXQ2PUQGM3sH+32UetnhrLg8wcf
	 oNCFCI1g4LYjxd7g5XWPr8PaSBTtPE7/vLnXMJvlVcMCbc4fpg+o0PqQ56po4CD3wf
	 hs0DOFwe73Xd2Vmish8+AfwffMJkZs/PPMaokpS9uxss/VszYyi1/3x0PRVQw5mV31
	 8E7LXxKV1cPGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 36A5C49ABD;
	Fri, 13 Nov 2026 20:04:36 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 20:04:37 +0000
Subject: [PATCH 2/2] iommu/vsi: Don't resume the IOMMU in its interrupt
 handler
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
Message-Id: <20261113-vsi-iommu-pm-ref-v1-2-fd917eebdf18@gmail.com>
References: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>
In-Reply-To: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794600275; l=827;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=WTwZnHxIRE4pAuSff5z0uY+0kBdGQgUKwB9X8xak2LE=;
 b=louZVW1zyVrXM2EJ1hqLYg09BtlMHeNjToEEW5k+ngtDcqdnzYQfUUXZBGZX2gvZLjtOb862S
 IZSZOEpGGiJCkjwvxbqkWuhGoOx/5R4R+q8VaD2EL0HK/EDxlGxNYKP
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The interrupt handler calls pm_runtime_resume_and_get(), which can
sleep, in hard IRQ context. Handle the interrupt only if the IOMMU is
active.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/vsi-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5d581be95333..3dec58224953 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -196,7 +196,7 @@ static irqreturn_t vsi_iommu_irq(int irq, void *dev_id)
 	dma_addr_t iova;
 	u32 status;
 
-	if (pm_runtime_resume_and_get(iommu->dev) < 0)
+	if (pm_runtime_get_if_active(iommu->dev) <= 0)
 		return IRQ_NONE;
 
 	spin_lock_irqsave(&iommu->lock, flags);

-- 
2.55.0


