Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A14381AE5;
	Wed,  2 Sep 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376750; cv=none; b=LL95J61sstHX+s7g5XEgWfJVTEnbuCRE3ZRx/jeejb3cIElnfEHYZb6OrTB0kUAOlrFphMFtLR/EVjW+NzM/UBi0Qh0QUIiJh4mk0jcWTklMpgtjBXBIwX/eWqHonUcJLsUROlYXFgCSV0b2QIeRIe/CFxe9UUnr0shCFKfV04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376750; c=relaxed/simple;
	bh=8Rv9OVc1AW97l/UiCVzPt+gRZOTmtkExTv7zaq6GYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZxd6338um/a0EtbUtYIlwDfOYtcBsVNPecGhV0UVjdVkDAc4U7EpGQ0lvvzsbWIPkII/mnMTv4wjhTTf+Bf/cqlzEAir1K8MV0p7VOQ+ZlAAv3ebJSB+98lWvyVOpQYsZbmwe4eCFpYe/yVHV4JCOd8wKTGTxeTFYq2UH8qA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Kd+TffTV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvbDMkGc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Kd+TffTV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvbDMkGc"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D8E814001E8;
	Wed,  2 Sep 2026 15:19:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 15:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788376747;
	 x=1788463147; bh=QR9hH2qCFCqj8AmL9TfSa9UfhVhgFX2hAhjrgRMsWck=; b=
	Kd+TffTVcDSMc5PNgNWEtMj5CQvR4VoGRJmfXT0Q7t0Jifr0msF29Dd/LPmdMRhj
	7sJ4JWHex5TpZNlMNWsOR/eA+rOg0FXJ6qNNPZofBwIbuu8wmwmHW4QJobNjrD/2
	B6zyoKsgSQvrETFnTcEQKMqxZh4CjwlJ8rBpqTKWR4e981iZx5ni3/GLFjof/ys4
	D4RXcxbtmNS2U6nS/QH08nSdjqh1H+RIZGw1LuPMY5psorOIwl3LMKk8NxwoOt5A
	oRn3UGyrgo8geO6U6CTlgQe3eOKX7xXu0st8sesNFKLWY+RPywzu1HsiiccP9ZU3
	Edq+AckPwsmqnuZw2LvXeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788376747; x=
	1788463147; bh=QR9hH2qCFCqj8AmL9TfSa9UfhVhgFX2hAhjrgRMsWck=; b=h
	vbDMkGc/3d9pe1obvBPf1Yj7VmD/ofcL+cznaT0qOtPrMRcEF/d6pyGJ1PnyHKpa
	mQOkM42YatoA/uzfn2Tl/rKe9VUjiRdnuwdWv7rm8uywiediwlWqIgERbZMLkBfo
	CuHP4eHFoEwmFgbzJnCmx/q0gP/cGF2jpcrBgLSYDoWVerzI5siloJCJKK9iEvs9
	ZUY1cI8ViYcOkkIgDJjV94pTZ+6PWCpxmEtR0ykhoCub2i+MZOZZEHYlutAZbi5s
	M9qgEQcmzW3r91XPD5EIRXL4gqKfDScwnYnHHNLTWh5wTJQ+VoojE3fZTeRkBrIu
	uyJdy7pcAA6wq7S4KCiFA==
X-ME-Sender: <xms:q3aYaiiz_dVN5-mcRDC4chueqd_mmmO5005ZGG47SBLtEfOU8_Y-QQ>
    <xme:q3aYau3XoZEc5F8W7eHs4F2xr2nYFbq97lJ5UkXpm-QlyKujVJ5up41YWVB0Ps5PM
    8HUk_Bjb6FeyXPPYjFyiRVQLfoqQhkrK_Bhyikrfl6mrGhp1riS0mFL>
X-ME-Received: <xmr:q3aYaggCyxlNR85GJ-MTs2tM4GCrAeBAkhq-uVMYDBngrAsvKvAC9c1lcO6c6uNx8D9SFI_Z6vr6qxtC44I5AB-_oib0SVeH25vzqQ>
X-ME-Proxy-Cause: dmFkZTFQ80BQ8y9z/ksxzIu+u1KCHp9sDl92lTo61ffLa70nJ1hlaumln8PTa7TjEGVGmG
    OxaLJCLNxn78gkoJ1fkMmhBvP15zPz/pklDJMfTZzvs/BljAU46a3ReBzGx/XFz5udidth
    BL7cvbmjaDhWK0PxsjIueQbxY67eTcMlHwjCey97chTvnS9ssKH7FX64SxVQF1uP44aUiX
    d0QMim9BVRCLqTEGdp95PxDcAF6A1QXWMoXXmVqdQg0fO271cwzSUsV/bYxv83G5gKMTm0
    aQuDw9nClzjO58SOPDKposjdmYiqOTrXegZCC+4HfUflHioGe/yFKBWwReUIl11HFEXWto
    2sHxVV5X5H9nFZd9YRNwVhEmHDNE2EWI46+PM8MW8yIyMzCQyizhLXPlCH+F1117Y1Kb2R
    9W1DRBnYyEKsiYJNqm12GHNMePmIVXdmF51x5ZtUkV3/4RMrmvrmfl760knvOqHgXgEgzv
    k6FWXLQFg0hp2a7O4tLqED16zJSmBm+w5E0PucTlXh0w5lKqH97LY8wdkXwMSLOAnf5gv2
    B6AUSAFr8zB6Diijk/T0AhoVwDosrvBWZiBw2pN4xD5LCzZ0uC/EXG6BGNzT1O0RqE+X1S
    tk/MGmAId6lXeJqGxTSIOxaATc5zXyIXux4p2vMH4FXWufy55yO+xWGrVk0A
X-ME-Proxy: <xmx:q3aYan8SzsIgDX-IMMiDbUHoWozFhVFeEx_md0KdbHKjMZFLVXKpgw>
    <xmx:q3aYakJtGnkC1VuGcVfh90ddmoyp-zSNkJVgdOw9KJAqNHeoaJsr-Q>
    <xmx:q3aYakxBJaRzaBowOlUKXx75zevAHjHwNI5e_7n5xm5RbZfyJoswaA>
    <xmx:q3aYav3kKM0sXykyvetWn6p9IlrJQt-CMAaee2r24jDWvZttscubxQ>
    <xmx:q3aYarJuer6FHgWmGVq0-86Q1CM_h5qULh80VkUm5ElcqoL8uOsp8fiY>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:19:06 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Wed, 02 Sep 2026 21:18:54 +0200
Subject: [PATCH v3 1/2] dt-bindings: iommu: dart: Support specifying the
 DMA aperture
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-iommu-apple-dart-aperture-v3-1-252ce55b7001@jannau.net>
References: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
In-Reply-To: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=8Rv9OVc1AW97l/UiCVzPt+gRZOTmtkExTv7zaq6GYSo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwZZcsfWj5gSPxnyvlnt07hpieXJ/Zcfdj7Zlet85vk7
 rr4r6s0OkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExk6VpGhqW/53mdcjxqWPBr
 gf+mvTYBxZZGOzZpLHCq6V1y44jN+hiG/4HeWxdpTvpTw/Znve/e2Fz5lNvCbsuXL3359sz+Y79
 NEpgB
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Apple DARTs are often connected directly to devices that expect only a
portion of their address space to be used for DMA (for example, because
other ranges are mapped directly to something else).

Follow the "#iommu-cells = <4>" example from iommu.txt and allow
specifying the DMA aperture via additional cells. Since DART is used on
64-bit Apple silicon systems use two cells to specify the start and
length of the aperture. A common aperture starts at 0x100_0000_0000
and spans a 36-bit address space.

This corresponds to the vm-base and vm-size properties on the Apple
device tree side of things.

As not all devices require this and to keep compatibility with existing
device trees allow 1 and 5 as values for #iommu-cells.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 47ec7fa52c3a..6efbe732b4ce 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -44,10 +44,12 @@ properties:
       Optional since not all IOMMUs are attached to a clock gate.
 
   '#iommu-cells':
-    const: 1
+    enum: [ 1, 5 ]
     description:
-      Has to be one. The single cell describes the stream id emitted by
-      a master to the IOMMU.
+      Has to be one or five. The first cell describes the stream id emitted by
+      a master to the IOMMU. The optional second and third cell describe the
+      aperture start of a master's DMA window and fourth and fifth cell describe
+      the size of DMA window.
 
   power-domains:
     maxItems: 1
@@ -66,11 +68,11 @@ examples:
       compatible = "apple,t8103-dart";
       reg = <0x82f80000 0x4000>;
       interrupts = <1 781 4>;
-      #iommu-cells = <1>;
+      #iommu-cells = <5>;
     };
 
     master1 {
-      iommus = <&dart1 0>;
+      iommus = <&dart1 0 0x100 0x0 0x10 0x0>;
     };
 
   - |+

-- 
2.55.0

