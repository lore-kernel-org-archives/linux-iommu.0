Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206813E3E8
	for <iommu@lists.linux.dev>; Wed, 27 Mar 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546881; cv=none; b=pUcYDVBXUDvKHvt7LurYv7gwVfhK0qFv5v33Mn0AhyCLgZCKsJp7nfEXSRddrX25SvUQlKNpHkp5MtACCSS1unp3Rr6aYeqPSlq4aics4YhPBfPqu+o/1GhwMILkhBZ+yaGgEJ8qBD7qqdsTyQ1v+nSA4Iw+eV+JeiyWrOwsiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546881; c=relaxed/simple;
	bh=J1jG4kj0aYZKcUmMvtYUKNLJlJWsegdKYmIoMD1fTS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1U93C29JNHJQuJYmViLWTftIyEtVXudYCk4I8yD0HkdSJCrju1JYO+NLJbCe9nczOs465yQsQamWTI4dMrOCOCHrHJW7uWpWSMLu6/ptrRElcxA9ldy+giJpOTkAooP68ssBW5a5fVGsxk+gfK42xrLVgUCvSQsia17xAjvHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 086F6101AF36; Wed, 27 Mar 2024 14:41:18 +0100 (CET)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: linux-kernel@vger.kernel.org
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH v2 1/2] =?UTF-8?q?media:=20dt-binding:=20media:=20Document?= =?UTF-8?q?=20rk3588=E2=80=99s=20VEPU121?=
Date: Wed, 27 Mar 2024 14:41:11 +0100
Message-ID: <20240327134115.424846-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327134115.424846-1-linkmauve@linkmauve.fr>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This encoder-only device is present four times on this SoC, and should
support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
encoding).

According to the TRM[1], there is also the VEPU580 encoder which
supports H.264 and H.265, and various VDPU* decoders, of which only the
VDPU981 is currently supported.  This patch describes only the VEPU121.

[1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
index 9d90d8d0565a..4c6cb21da041 100644
--- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
@@ -15,8 +15,12 @@ description:
 
 properties:
   compatible:
-    enum:
-      - rockchip,rk3568-vepu
+    oneOf:
+      - const: rockchip,rk3568-vepu
+      - items:
+          - enum:
+              - rockchip,rk3588-vepu121
+          - const: rockchip,rk3568-vepu
 
   reg:
     maxItems: 1
-- 
2.44.0

