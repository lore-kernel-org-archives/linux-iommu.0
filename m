Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC028DB7E
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135902; cv=none; b=OufcZjNZWUYq9P6EuVziK/o83KReQHK5KEacUXn5gJvIHupN98tlnIQ6n2up3AFCjd4WRBojdWqx9p5S13jOURTKCgNTfqKrOEX5jeoDPXevhor4tYCp/eMbKFtV2WQ3kLfM4SNPb43wRMab50aN2vEcMHEHKC3vz/JcT4Q/RAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135902; c=relaxed/simple;
	bh=QYXHcCL2Vs79N2X0jF3tLL5lpOOl+YSA52sVaeKfUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POmQ2NJX/TnegkQwt7M9e/CZ2NK4ZNc5ER5+SrP4mMuFvwODTXnxmIXqOuLEmhyYt0/MX1VkyT1bDW0Mgy4PmGmeoYgPFIibTXwTQRcjfgHccizjeJZW8VfFSXCQ+CiJriIDNw+S58q8gC7rJySbrqWnkf08Z2D26cCLK0IjJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nHNDQfAm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nHNDQfAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752135898;
	bh=QYXHcCL2Vs79N2X0jF3tLL5lpOOl+YSA52sVaeKfUeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHNDQfAm4FeDmZOdE1oe11s+h5sMBYNc0tdZiWYMWI9mZmlLLAAeOtCYpv84T8G23
	 N76pxcUbeSLEMj18WBcCRtuqn0aVT2ci0KJm2zbHzFWSPQtXGlTlfizXdjUQpDVBS5
	 tOtdGN5PfPLG91BpFeGC3OF0R2REZN+jlqMyfvHqYDkgfZtwG5mmUPYea6RYJ5JVGt
	 /tzOQRjw4s8BVLQh8HG615nzBr1lKUuv58pdcik2yQDtAqHdvnPRgONIwMqlaNWRlm
	 tx1fJLyOrfun38+34jt1wnX/Vz7gLftnCzWczkLlrqxlA/eQ+ZPT/1JrIs5qEn6p7y
	 8nhEGIS7vXycQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9f5a:8ea0:8d89:78d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D551517E10D0;
	Thu, 10 Jul 2025 10:24:57 +0200 (CEST)
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
Subject: [PATCH v6 5/5] arm64: defconfig: enable Verisilicon IOMMU
Date: Thu, 10 Jul 2025 10:24:46 +0200
Message-ID: <20250710082450.125585-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
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

