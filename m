Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993553451B2
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285704; cv=none; b=SVCKFaOecPcNpFEQolfXG6cEkZgipyrEVYznILhLrH/02kfkK6rqkaAXixK4r0PjGbGaQoUUMA5MISrxLyr1mXV/PEu4hNuzR8XziPuwg+aj1hoSUt6sZ/xCU1uwi0f35bUMj89GkBItffhYY09IobMvBVamJ+yNs2teyX/hidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285704; c=relaxed/simple;
	bh=7oF5B1NcfXS5Ejllve18Lu8CkCdO1s4cDKW0kAkJT9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgG0xXlrgFi0OizImSN97nBLo3HOK3wYRSPOBE1NDhMXntzVNd9lHV5zJLGqCTEjsBNjimzGR2WPQOjK9s3N1P6t1jrR+lVtCz/GuZpMr8jozYGMD+6a0/bnrBVhwVqKwJigFwLJ6zsCMnwk2qMLunRAmBcx+dWZxtG620SV2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BYls46lp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BYls46lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756285699;
	bh=7oF5B1NcfXS5Ejllve18Lu8CkCdO1s4cDKW0kAkJT9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYls46lpujxTxM7N/tSNSzrIau2E1ZcS7Rlv2EV0UrWJl1zAnWsTF8Ru+y0rUPMC4
	 LBWM1xfAQ3sJfEhKAuWjcXW+bb0BlVDBtMZaT5FAkU4f/1e6xZ10leiQ0N0InwHadA
	 fWn8dpB8xlIJ8gGPgbxz7PR97zniRWXmzOpZiFWjFE9DcRrqrjSctqrft2vw2sCU5f
	 hmME174if+hz7l14Wd2rp8ZMu1ZvlLUQ3wLrrlSy9ktWxF3wBm3w1rouyx7yGG7Zl/
	 4YqH7CxlqFwvax2NjS9qzZMXYodnZiGJs0dnQQw7BRy99tbige2KcqmHcuZej1ocgJ
	 FfDGmAUp5Fwpw==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4be:99b9:5069:3bef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 264D917E10F3;
	Wed, 27 Aug 2025 11:08:19 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	linux-media@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v8 7/7] arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588
Date: Wed, 27 Aug 2025 11:08:03 +0200
Message-ID: <20250827090809.34555-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827090809.34555-1-benjamin.gaignard@collabora.com>
References: <20250827090809.34555-1-benjamin.gaignard@collabora.com>
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
changes in version 8:
- Include board name in defconfig patch commit message

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366c..04547bcc904b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1470,6 +1470,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=m
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

