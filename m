Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BF3AE706
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237841; cv=none; b=F/SIOQwABKexYoiHLnkxWCk0aGM26xjX/ETNg36a469+FmNSY3ltlEOWzFhZGGnE0emnO9ee07I8i0rtgpjvMpi8bEFogMEQaJe4BAZapUHgqepIPJTH2/G4NferXK52M487qERyrbSAIccQurLnRWtf4Shx3d3FPFipRCpSEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237841; c=relaxed/simple;
	bh=xq0NdgL1l0loSI+nYSoGevbj/g7OgzAQZIHb15BgSgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9b9awb2Z1TkaBOMiS4GvkMegdo6iJzWQHu9ji7kGQ3RJIpciT2bzHTQP1O+CXOZZhRj6fXSkjOgdWKwfLinQDd/JNC8Ru/6uUbfK9ljRvbZEWixYCc6u43I4V+W8uasn0aX1kMZMT+iYXGVCqRMu9nSnKqJqBv4ozz7i2IOaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kxwvc+cI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kxwvc+cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776237837;
	bh=xq0NdgL1l0loSI+nYSoGevbj/g7OgzAQZIHb15BgSgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxwvc+cIAiSunnmoPcL8rhk101yoZ2cnPxwWQqYtanKdl6pfGjrgBV7Hm+0WuHlK/
	 TmG7pckOBUtrXLTrYtwNnbUgBdE9bSIFxoFPqo8yXOyy1ahFApLpEKYDWlEScrj4Mw
	 +9vxA2OmPvPfnFPiXvwbsJu3iEIAUjrmLhJruKmANGjYztd3kVL+LiS+5dKhtHttbV
	 OFoDpCW6OdkS4gA1wE1WmCUhI1j9wcPiKpXbsc8lk89k4Tn55npJ8niaHEiaNJnf1n
	 vhAxqiVHDjyHCRup9jKsFYJNdYQupFiM+JwtuXcww1jNcsJ0ipWZ1OlTQ3N9rNRSle
	 UJBycQWFA38yQ==
Received: from benjamin-XPS-13-9310.. (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62A0717E144F;
	Wed, 15 Apr 2026 09:23:57 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v14 5/5] arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588
Date: Wed, 15 Apr 2026 09:23:41 +0200
Message-ID: <20260415072349.44237-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Verisilicon IOMMU used by Rockchip RK3588 AV1 hardware codec.
This hardware block could be found in Radxa ROCK 5B board.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..b97f5008f6be 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1592,6 +1592,7 @@ CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_APPLE_DART=m
+CONFIG_VSI_IOMMU=m
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

