Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA11283FD9
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051230; cv=none; b=XBRGwW/MzWtEvdYL9xM4adQQdKym3FfOzHmrVzCw+bJ3Ng2XXmpHv3rmzc6tlaz/V3KQWCwdUdcFYEJcdWCDrIVnGG3vWHODX/Edr8jtVEjqmfPkyKePGxm7KY2jpUv6KYbMFEeqCtUwcnKJ/X+oXk70dqvvoLCMD3lvQjwRSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051230; c=relaxed/simple;
	bh=QYXHcCL2Vs79N2X0jF3tLL5lpOOl+YSA52sVaeKfUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNflpVgoMf0OdDeIeWyx3XRPmICMFG7H8dlJRQyaUqmBydFMXs8MHTJ+mOn27SOOGdJB64mclWmqqnXwFEQHQDFcIrAHNMS3tPIJt3zK4CvK16L8dg+hIeZRS9Pj12Kom/WW3/SvZbo7Bqd04FVh5cwpdddC4srKudJsPskXBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m3hO8Z/H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m3hO8Z/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752051225;
	bh=QYXHcCL2Vs79N2X0jF3tLL5lpOOl+YSA52sVaeKfUeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3hO8Z/Hm/WU0S2/37/px10JjlMVhXiD/fzyJW0SGXHoI8NvJNx04URZMYlnuna0q
	 4W7Jk3s0WDiWqE3t/HabB5kpht0mAhHhQE3FBsb40PNpaNyWLfpmxiRQMvVTr9+HRq
	 aJn3FnC1s3VbAraASXGMoNm9b6ATG8WZXnk3zs0+gRnlczo+7ykdEt+EzjE1WmfzRC
	 yzuXt08zNRT8Srax5ietcZ39lylFVwNwpxA98mlmA/WDU2vdGbbGHCarb/70Me85vv
	 JnpSwi2Kw62X7rfrcXp60jDfAXzv0M4q+Zb0sTZmdzvW40ca8Xsw6C3xB29aCY68Bx
	 Yy6b1u24sghSA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8d6b:4a4d:ad13:46c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 41E4217E1110;
	Wed,  9 Jul 2025 10:53:45 +0200 (CEST)
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
Subject: [PATCH v5 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Wed,  9 Jul 2025 10:53:30 +0200
Message-ID: <20250709085337.53697-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
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
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7e04a2905ce4..a639388298e7 100644
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

