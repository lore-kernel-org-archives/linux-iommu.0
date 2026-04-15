Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6723A0B3F
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237838; cv=none; b=h0WqGfMnPHXhScGJQDid76KGKP1qq/Fp60rNmTDhsxoigTQAkxkJWiJE4z0SfULRY4CKO/cUlVtJ9Le5eL1XRwNbP/oOHC1nhazpTTS2PA6dHxEHVjW2as9A5g+F5DfIO6wv750WfOpkKAgjyCvN32I7rLeRPZp/te8wQts1UR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237838; c=relaxed/simple;
	bh=8xvsn+jlVFtEMiQtA9C/Ao3q3yPX51zlgfCHv14LOWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHRRBiB0NhXb+dMwX1UcdiIMMDRhJeoY5o9+1Y1JwpfY9lbPJZT357Bc4cXT78vwZIHEhgptMMiP6EaKYBwtiq53oaVJr+Lcn/1UzgoAO9GqrMuYYZPnFJUscpivtXgHoxuwevPz788X3WnKapa6OT2+egelv8ytqKGbG8ZDgms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bdmay8HF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bdmay8HF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776237835;
	bh=8xvsn+jlVFtEMiQtA9C/Ao3q3yPX51zlgfCHv14LOWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdmay8HFjz5HNg6PH1QWH0WKOpCgnsegKR+Fo00JO3BRCG0yfuBX5GUxYs6oGOKF6
	 Fz8AP/wkbziKAjB1ngLhMKoz9KlhZXtwrspfc4winkC6JhrQ02oo6eDozUWr13oVKI
	 ULU9jD0EAPpaDB5+F/y8uornUbNa6inl3YsgxNaXOoFvcXFjukLgxmRtIXGn8E1p/t
	 fk9X9oPgk07faQLx9kqeekiY0qEJeTiJ6ziRSNKG3HloZN6VDHIE4Apg5glmmXDl2f
	 0/gCfv7IyxSVOnL16DuN892p9BzOqQMGhNH9qCA7kzlSvYJ5jbOf8BlvNpkj3YpsXX
	 BQfbXCfOCC48Q==
Received: from benjamin-XPS-13-9310.. (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 469BB17E1340;
	Wed, 15 Apr 2026 09:23:55 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v14 1/5] dt-bindings: vendor-prefixes: Add Verisilicon
Date: Wed, 15 Apr 2026 09:23:37 +0200
Message-ID: <20260415072349.44237-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
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
index ee7fd3cfe203..ebd9072300a8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1761,6 +1761,8 @@ patternProperties:
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

