Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5B392814
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385375; cv=none; b=GlPrUJ/ZLeKwgaC+d3K/p+wtfhOsIW/M9vuZ6cK7IEmMFcD6pdQM2Vz1Y6kGafYPx43cwflggFzZ5Iq+gJVHCtuerV0hSI94xtYPYlu1pL5I4LUpPMYHUOF9DKzv2atbzwlg6vzcQP9HPafnxVgo+94LMACoPS/N2st4LAaurgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385375; c=relaxed/simple;
	bh=kfoyO6mLrJT+5jwg7vHiUeoqvatV7KVxcH5i/FCsdRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgTviB84gotPo9+06gsndKxT2Z6yNfEf2Jcod2VMA7YU1GZSGKJSGdTkkIx1Zdz3VK/q67YXp3GfzEyTg8onycXHTBhxo90nE9rJizYf4N8147krwxn5eP8kdm+gJeXrL7jXatqQHua/3V88eXQ2wHaxbXQgCybFnxYZUprA6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IhnVViit; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IhnVViit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768385371;
	bh=kfoyO6mLrJT+5jwg7vHiUeoqvatV7KVxcH5i/FCsdRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhnVViitxQ0X37IQlOUJcltVqn1USTYsKeU+mV4NKl6qBFJaR2LuYrl2B7J4Dw2c8
	 Ov0gO5HpqE1I0MnnVzeZRNGr5WC4jTnQVaskpcGTAvb4dOtoyyqDEQsgJ51KOA8RWU
	 KaStQfxiGLua5E/qy0oaavf75KM0lI6Gagc5kddo3WfqaK4mb++ZN1ekxdhmvDXtYN
	 LQltGJpP0MByFPRT4gOsLIxEnmwFguBttWQ+SpWqPptx0SK8Ymx+OFFVEUY/oePjsu
	 TjZ7MlyOJTiD+aXeNT+eFlNwavQuN+7a0uJs3Y9HlqF65JOyALCUPBgSBe3YRoFs+R
	 OZgq3EMJaqULA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:1dad:60e8:7174:bd20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 04E6C17E1525;
	Wed, 14 Jan 2026 11:09:30 +0100 (CET)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v12 6/6] arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588
Date: Wed, 14 Jan 2026 11:09:18 +0100
Message-ID: <20260114100922.149187-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114100922.149187-1-benjamin.gaignard@collabora.com>
References: <20260114100922.149187-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Verisilicon IOMMU used by Rockchip RK3588 AV1 hardware codec.
This hardware block could be found in Radxa Rock 5B board.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45288ec9eaf7..4751f7fa8bb0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1525,6 +1525,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

