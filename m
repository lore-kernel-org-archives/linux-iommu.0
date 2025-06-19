Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5482459FE
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338762; cv=none; b=BthLEw129+IEEMmCajFhSp0frs4XBbc8GVRYCq4h3IU+V4s+jMrFOO21792N+zKcb/hOIxn/3mYnvBaP3qsdsRaYVZKV0UGtZotjhAzZx6W88qTHqyAn1jDangn0dzhKhGme0lh5BY9SSx4HO6cTKKkrLWK4gYRNVlzfD2y7Iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338762; c=relaxed/simple;
	bh=jWZNbtieMlukarfurzmaf+LlmGQDBBQxXt2OISoZBI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWxVoLLbGdvf/HJIwIUpB5eNgLlzowaqBhBxYLSzy5NoIj+iV98De95wdZide51zLlS6J7QRPW1hgVENzh3wCcDlEydRStoTDuJE0+ePelrJnH2dBsjOOgV0k3RdAYQRMWDyqscp8QpEKtieCy/l+fxakKvB6VttHHJjKH6ygB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pdHjIPrn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pdHjIPrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750338758;
	bh=jWZNbtieMlukarfurzmaf+LlmGQDBBQxXt2OISoZBI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdHjIPrn6GIJmUX9XuUufRCVVMosnE2E4P/D18SECKQfjBQ1RZGKMjbiVOPKiS+gk
	 jjwf1QA8fbdFaMwTpgQRckQxw/RFcTdRLfjeZzceJu2Z0N6KLmMranqio1ZhdeRUSv
	 1OtZlEE5lrULmJ2XOhyewPewWIu0gtA/S75qY0tqvJocq7JveBJuSCKtLC88Fi5HcG
	 AxqvIjQjcEsz8xTXXhM6LviESP3BfWko369YdWFfHj65/O420fQSRXOujKtvIKm+Xs
	 DtrZnuRSJJcHnYEwAYufH7HvSxWRtQ/OZqerNLldb+IKDb1bsZrkcJZJ+8LiZyfCV/
	 um+UB8b9Zzu3g==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ba4e:a6e2:6d63:7f02])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A011917E06BF;
	Thu, 19 Jun 2025 15:12:37 +0200 (CEST)
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
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add Verisilicon
Date: Thu, 19 Jun 2025 15:12:22 +0200
Message-ID: <20250619131232.69208-2-benjamin.gaignard@collabora.com>
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

