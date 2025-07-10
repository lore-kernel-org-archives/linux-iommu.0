Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC328C5BC
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135899; cv=none; b=IpGM7uR9K0xLUkrYuyqIiKYOWfach6+mVKN8JOSkjF0Ritwsyud73IY44b6xm+xD50tB0xo06AUwmI8A0/ubTOhgeG0G2equrqqDgmApMSdlo31kp99ftlWvIbW6yM+6Xmw7dwcIuYimBI3TO3bbdQ/DFPn/sJ5t22k3AMfK4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135899; c=relaxed/simple;
	bh=jWZNbtieMlukarfurzmaf+LlmGQDBBQxXt2OISoZBI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gitSotn7+H36VMhAuUhKxAOoAy2vgxptaXgCIPmt11JZWRrfehxL9f8xszy6zDf2rLySufnbzLBeOgkZ1Tcrx04k5V2Lp5IHQwcwq82WeaPtHLD2pl1SFFDI+BvQvHzIhsIyhRiWmgLU5uZgW/a4rETSB46tYpykdmMGqggwOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QPp1UkjZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QPp1UkjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752135896;
	bh=jWZNbtieMlukarfurzmaf+LlmGQDBBQxXt2OISoZBI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPp1UkjZaD7fb8bASUM6thKawtdikc/MiSmooeEKwWIB9kJRYmJgswcx3LWL82AsQ
	 TNcjPnj14/z4UVcWSBq9Hc+1S8viR/Umu2xceugtcqVBbo7aBXQ13zNXI6znA+poN/
	 OUNMx4wM9nsvNcjxS0UsazanGCGQ1o7VxkK5fr1n44MVz8HELr5cJ6jXRlslnA/ra3
	 WtvUU1yn24Jbm89Z49JBQiintwYPOR2chTYu4PNglTrCdzVImA5VWwP3EIrD8BJrxZ
	 Wu0r6U/VuDTWDkSMCs0MMc9W1Pcp4pdyLJxpmVvTrOlASUO18nVlpx35xBShrCEsKb
	 JQ8YY31/cSWlg==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9f5a:8ea0:8d89:78d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E89417E0FC7;
	Thu, 10 Jul 2025 10:24:55 +0200 (CEST)
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
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add Verisilicon
Date: Thu, 10 Jul 2025 10:24:42 +0200
Message-ID: <20250710082450.125585-2-benjamin.gaignard@collabora.com>
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
index 5d2a7a8d3ac6..1baf8304c9ac 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1635,6 +1635,8 @@ patternProperties:
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

