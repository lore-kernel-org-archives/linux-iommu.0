Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A5286D77
	for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606250; cv=none; b=i/sGCuK6gz0fJsY5fyXEQt2ycqizsefCVgdEZS38reugUnxFZ3HVqvOYBwT0Ob2BKMY5ZyO5B6L2WDZ50p2hcYW3qIa/fdlyfLGfuEaTnMS+7uxoIgmTSq3hTVzqzxPbF0tLkdE49SlQseiMicD+kD/LcRHePSrgU/eS92cLOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606250; c=relaxed/simple;
	bh=LMd/HnzJP0wRzEJcI4/mU30dNm9tR2JbINi9Suua6pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxD0uyKwroKR9kVS2dIxetQwdLRyWlyphvaHK62JYIdF44tEnWkiOE5TRJuWob0ZlNs/EyqxzTV5sdLCWIP9NuPrRs4CBJvtZgDHb8cOLezzZB33LOLXTZXxNvl4E1MpZY41K/r/XvBTzKW0IS+Bt7BjPy236DOL/DC1GfhBuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XYgs1OQh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XYgs1OQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757606247;
	bh=LMd/HnzJP0wRzEJcI4/mU30dNm9tR2JbINi9Suua6pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYgs1OQhFnmqD55dC6slv547XBxsnGI02l9rlrokZ4iBtC+ggsAoxS7qvIbIuZg/y
	 +Zgqa11thKuvNqXNDKZCCLpRXFYl4QABE37E84O8IlvbXgAYoUVxOvV7vWZ/GpZf4P
	 L55k5UHAq03zbkLckSXMDDGQyQpXapq9Ivx21m9DLe/TRPqkVdvUY8mL6r/Br3rTEQ
	 Bv1x1LaC/sJlyBHUeibvFmVLyyN4CBLFmMn3ksD+oEhFLdLvzMT36mBQHiFOjLQXCe
	 DFuyHTXF557Goy+r5aZzKcGTH9wMNoQ+PhRv2kvuIODYBybk+MLJu1IcKZgWLkXC0e
	 uSB6bueIfVR6w==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36e5:357f:56a7:54dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B225817E0DD7;
	Thu, 11 Sep 2025 17:57:26 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
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
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 1/7] dt-bindings: vendor-prefixes: Add Verisilicon
Date: Thu, 11 Sep 2025 17:57:11 +0200
Message-ID: <20250911155720.180465-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
References: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
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
index 9ec8947dfcad..52b3495ff4db 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1656,6 +1656,8 @@ patternProperties:
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

