Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66124EAB1
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338765; cv=none; b=Rk0AgcisJ+gyWbuAv6qIx2s5REfFBtbdmVhBoVKL+6RW20J9e8pDRx9reDfQELEFiIqzOrOkKOOJRzUcA5XfT1gBsbREMyeegaGPQFEFtZjus7UhFwu4Mw7/fVeQQXzXpPfuZ3QGbotAoZ5fK6BDJhIQMv4yNbumkPN94fcMxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338765; c=relaxed/simple;
	bh=Z78NWR7QyeVMigQFDY67KY2IgrDEq55C5grWjS25FAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K67k9lmXwq3fvM1gzNIc8G3l9QkoVmVMTeVhuVK6S8n5BOaIl3YNvpA8Sp7fF7vXNs9S84nzdcj51/6YI+bg77XwhxdoKdlT9Ec/7cu+aD5Z/0qM8pLpmWdDcka32VddDxYaU8pqxYMei8XbsPuFAx13z1R5UeLGjG6msbtBe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U4RKiBhm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U4RKiBhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750338760;
	bh=Z78NWR7QyeVMigQFDY67KY2IgrDEq55C5grWjS25FAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4RKiBhmILzi/KWLUQ19nHOBAApZDOYBl6lHwlG5+xdPFC2UQ4P0zxHWKYcm/qb/D
	 amWo8qkqi2ukixzW9BsNWdCVOsTX6AFiNaBRHTu/MRMME99Mw1tEIqfDNoL9Vj0Xv/
	 Q/TorqS+WIeoakla64ukAiBC0LD1IXWS7bAFTm0aFllGy9MvIl+bo7nHP3+0U3JyAw
	 Sn4Xm6pQyPCJFja5K0Nz6cNnDZnJ25PF308/fmaQNanSlTrQHkg1+2aAoJtwR+wj/k
	 sbdWHAOyajtsQxbTXobic73Jf/ydhEiosLFOIhFvuJvzSaRkHK4Z6FEJUQiMzJUizB
	 66vyVfwvuRe9Q==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ba4e:a6e2:6d63:7f02])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F38B217E0CF6;
	Thu, 19 Jun 2025 15:12:39 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Thu, 19 Jun 2025 15:12:26 +0200
Message-ID: <20250619131232.69208-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Verisilicon IOMMU used by RK3588 AV1 hardware codec.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 3:
- Set CONFIG_VSI_IOMMU as module in defconfig

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..a5122990ecfa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1451,6 +1451,7 @@ CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
+CONFIG_VSI_IOMMU=m
 CONFIG_REMOTEPROC=y
 CONFIG_IMX_REMOTEPROC=y
 CONFIG_MTK_SCP=m
-- 
2.43.0

