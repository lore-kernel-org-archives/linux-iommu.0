Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF626FD93
	for <iommu@lists.linux.dev>; Mon, 16 Feb 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235515; cv=none; b=oeBHD7DaiI+Z5e36CuE5YZb+je6mSYgVgrArSDCziGx+9JsI8yexlry9CrFBrv//QytW9jKXjPLD4hK4ktnAlQGhX4iv9QVZnr1dLUYtZGLdY1m307eP6sSjnJuTIWtpZFS2qU5/u+8Uhca3ababQyDJoxtHBnBbBiubUV3S67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235515; c=relaxed/simple;
	bh=kzz1stJ/eG8rdi6weyOcBPC+8rDtte6uRtWAAV5e9pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToUkGyVQaU6JYT3mA4TQkD3070OWBSGCEwAD/zdtcPPIKV3Nk+dZXw14J/J0UWXmLCk3SyekK0w8ZSq1wzCFucF4zjKdOoiyqdojLUsplfq/jYmnuYOe3gTaX6vyqo8NdalLkyDjYbF8HKKoBQsbDLktNA73K0Gyuxy7TjR1aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kyohw4lI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kyohw4lI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771235510;
	bh=kzz1stJ/eG8rdi6weyOcBPC+8rDtte6uRtWAAV5e9pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kyohw4lIUiO3Vxhq7eB7WujZXVn0wRlfBIKmVfo992VdRgts8OklHX7TSAJjH/dGs
	 OhH2BDMzdqTibs7OZQYXuq+MzFkbpWqV9Uph4PT4gOPPaMXrDXik3y6XNX1JQId2++
	 5v6yIR9mkgPAO2wFS5aTECSWJrejsmSaVq83U108BT6v5LeRgcGezrS7JNXHTdeVjs
	 9k6YINUMPbQQx40L10Bj7a+LUzQp+E5vdYSMdrCrGsiRjGxoqNhnQrSQJunmUAjCn8
	 l8BiPBjZxN/SPA8g3oU88QfM/g+wdhHxx30uP9QSnEGg3id2CJDFvD37Z1wovuichm
	 PPfQhxFqxs+dQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f6d2:8ed9:560e:4f27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33D3817E137B;
	Mon, 16 Feb 2026 10:51:50 +0100 (CET)
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
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v13 1/6] dt-bindings: vendor-prefixes: Add Verisilicon
Date: Mon, 16 Feb 2026 10:51:33 +0100
Message-ID: <20260216095144.107356-2-benjamin.gaignard@collabora.com>
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

Verisilicon Microelectronics is a company based in Shanghai, China,
developping hardware blocks for SoC.

https://verisilicon.com/

Add their name to the list of vendors.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c7591b2aec2a..ce5c413948b1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1745,6 +1745,8 @@ patternProperties:
     description: Variscite Ltd.
   "^vdl,.*":
     description: Van der Laan b.v.
+  "^verisilicon,.*":
+    description: VeriSilicon Microelectronics
   "^vertexcom,.*":
     description: Vertexcom Technologies, Inc.
   "^via,.*":
-- 
2.43.0

