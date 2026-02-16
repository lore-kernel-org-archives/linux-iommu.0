Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6262F49EC
	for <iommu@lists.linux.dev>; Mon, 16 Feb 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235517; cv=none; b=MoNGeko9UnNUwA2U3g7D4biAq1c3eEn1FxFH8ZQ8IbNvOK4RUucBRizf2bTktZbgbe4M+t97XdLb/IjolKB1hvIvRghqn9dnvPSPrj/hTm46BGj/kNi9WWgUhRe1mH+U0rEVqjdlqdoh3aIpYhWFzPn7hbDReOKN+2rmfJx4SHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235517; c=relaxed/simple;
	bh=CHZfT/IKJiZGFKtOYY/Mprmvkw7BEC5CrXJh3PS9lyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e24EJYsmhF4rl8ihF7ziNnlskw1smzFFFiHmRlTvblxINplEl0kum94IaEBnIL2jouT5im1nfGo5hZvPiWeFhpQvW6K2VE8rF5ep/YtGD/Cg3M22PfHuYuOkH1F7i8GORjKlD0fTPCazYAgT0+ApQct3wZFfwT0rst34DFmFojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PCBD6VJv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PCBD6VJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771235513;
	bh=CHZfT/IKJiZGFKtOYY/Mprmvkw7BEC5CrXJh3PS9lyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCBD6VJv2YXp5qEMazNlob6GdFUXneSzRGBeeO+E5ksEi7nvx+1PZW6MJzuE6N4c9
	 Ek8HpumCSGmIJIPMEsC4uRHPDnunwfFrqWLWJCmwu679g/CCNoV3tesA16diN7V30F
	 8RcB61p/Q18pq7z/Rbl3keAlEKAl5kSGXlrGuxohrkp05YhW2rCd3VMZbliHLH68AE
	 8OWPrOfLTn1svT6jQJXQvApZo8x1RAdswivIeY0hK2jJDZygkRFpuzIWuYHfYyNrHP
	 Uiy1LFI1att9e12gkMqLU+cm0Wl4Vn7SwVQIQXV2xtNK6HR4Di29qgvhgMe2ZBe032
	 IMJXhrueb+14A==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f6d2:8ed9:560e:4f27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27F3B17E35C9;
	Mon, 16 Feb 2026 10:51:53 +0100 (CET)
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
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v13 6/6] arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588
Date: Mon, 16 Feb 2026 10:51:38 +0100
Message-ID: <20260216095144.107356-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
References: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
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
index 35e9eb180c9a..b56e666acf63 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1524,6 +1524,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

