Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CD1891AB
	for <iommu@lists.linux.dev>; Wed, 21 May 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747840589; cv=none; b=oYlhgi+6A1lUGn/b/vnA065R3M8Inqz+SqkjAGz4SzTEnLkPh0e9cEuyR8BKwrniXN/FkhXu4gEg1+i/mhTf6p523XOHz3HuVRxpNeSR0TH092/aahqJcqwCkkTkFzxoAzuTAS8UrlWw41+RsRD6MIVrcmVUnvtzF4ZEb/JMp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747840589; c=relaxed/simple;
	bh=rcecCSZgxXYbmeK45/Qv2JiTu7qRTSgAZkm1G2Upf04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVNqZkB3Ov16NesecyFZicK4KO0JweSLKna0uIMqu/BDX4diNvMvBUXqfnuoCwt2cj//1Lnrt3IgZM71y6Xj6Gz3bjUwRnTvgOpy57Jflx+tGnOe/c4TddA01rskOc8SDfbme99rBHKZttAvOfscNVsNcTQsvyOm7Wqg3XkEFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i6l38Y+D; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i6l38Y+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747840585;
	bh=rcecCSZgxXYbmeK45/Qv2JiTu7qRTSgAZkm1G2Upf04=;
	h=From:To:Cc:Subject:Date:From;
	b=i6l38Y+D8kDPWlbyUwquPW1SyH14xcmf0O23Ucu9qhRxkQRbFGZrdhiVmQpNE3vZE
	 eGWl1jUD2+dKK3WWpexvl9YrZuPMOTBn/35BaHGSfL3obFsPmi+kNwLkEtzokD03NA
	 7iXhWRinAHXlg1QID6KVdVFYL7qrSZp3lVm4CR9mijsPSZNU6uWB7fKmFLrMaJ6sHW
	 YY9euo++/N+MPN8+HUj76Dw3teuE5EgWLVye494KBSBe060/AIheIvfOarbmv+PTSu
	 GJu70haZPT3ja7RE5uMSFWNMciJUnifA7/j6papGU4ghSK2QjodvprHbj4ZEVhXHJI
	 TtG3LzKLoGO5w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C19217E0FD4;
	Wed, 21 May 2025 17:16:25 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	robh@kernel.org
Subject: [PATCH] iommu/mediatek: Fix compatible typo for mediatek,mt6893-iommu-mm
Date: Wed, 21 May 2025 17:15:48 +0200
Message-ID: <20250521151548.185910-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the "mediatek.mt6893-iommu-mm" compatible string typo, as the
dot was actually meant to be a comma: "mediatek,mt6893-iommu-mm".

Fixes: f6a1e89ab6e3 ("iommu/mediatek: Add support for Dimensity 1200 MT6893 MM IOMMU")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0a54c6521bf5..cb95fecf6016 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1791,7 +1791,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
 	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
-	{ .compatible = "mediatek.mt6893-iommu-mm", .data = &mt6893_data},
+	{ .compatible = "mediatek,mt6893-iommu-mm", .data = &mt6893_data},
 	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
-- 
2.49.0

