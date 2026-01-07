Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC630FC25
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780621; cv=none; b=ffb1Cf2P+Om2MBvX+4NAQLGWJl5gyVAnfWcY8uXpbylKYsOv3LbOkPVQsZSLe4JG2Q/hvx4qc7zffGWym2Rlyst63Zr5WMVTHmD9AnrjZAtBAxurBERhr61jZos2HnQoG3x7d0asjuCY5uMBsx5lkzB8e6jGTlhnhc9urLpaNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780621; c=relaxed/simple;
	bh=WA6auRFS5Bfnp0uakdsPfWC/OFowwBAKHJjwEBGZtZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFFoS4MwmIZkNjhvTgDEBQxptHsmA6XVF4oftAmY7H8c+9zR31FsAo9d5MPYrq0DW7pSey2TS8UHkHB41RCrFL8Q2aGCcQR4Po80ylEWFFIZz4zKMttohqRC6yyPwYoJY48/lHpjdo27Zgb98/hXrtHsebjJSIfgXMET0Gh/b/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jmpkTyQh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jmpkTyQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1767780617;
	bh=WA6auRFS5Bfnp0uakdsPfWC/OFowwBAKHJjwEBGZtZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmpkTyQhF6IjrPhTHQY6R+1A52SAiMX/zCayQz6gJ8yYs+JLLbI3Hmmr/dVBHjbPU
	 4Fcl+R1uK6E/AJEF0MVvVxFfePQBEROGy7nR9SDExYt8eDywhiJFr81MeUMtP7aXrL
	 6qqmjA8Bw5posKOtWIjYbzdkmw9uINdiwgxFFWa6+rG5drID8kfTPHHodavUNkzYZE
	 0P443Wsc8p7/XPLp0NCc5ThRnxfQn8+rOytUGP4AHrRQIJsJzErUBlP2pnGF8KARAn
	 8j8nmIJSz6q1UodSfXJKTCqoIb3n2O4FZ23Qk0SVOgUSt6dJSCfh430R+R1/YMxRPo
	 i2GkzHveQkgrQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7e36:2305:d47f:6e43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D7F2E17E35C6;
	Wed,  7 Jan 2026 11:10:16 +0100 (CET)
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
Subject: [PATCH v11 4/7] MAINTAINERS: Add entry for Verisilicon IOMMU driver
Date: Wed,  7 Jan 2026 11:09:54 +0100
Message-ID: <20260107101005.84039-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107101005.84039-1-benjamin.gaignard@collabora.com>
References: <20260107101005.84039-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainer for Verisilicon iommu driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0dd762f5648..baf09a3d60b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27315,6 +27315,14 @@ F:	drivers/media/v4l2-core/v4l2-isp.c
 F:	include/media/v4l2-isp.h
 F:	include/uapi/linux/media/v4l2-isp.h
 
+VERISILICON IOMMU DRIVER
+M:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
+F:	drivers/iommu/vsi-iommu.c
+F:	include/linux/vsi-iommu.h
+
 VF610 NAND DRIVER
 M:	Stefan Agner <stefan@agner.ch>
 L:	linux-mtd@lists.infradead.org
-- 
2.43.0

