Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5754A7F1;
	Mon, 31 Aug 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183994; cv=none; b=AFcGepCRrDxZ+1CZ+xJwB910MCJPGCtCQz3oMGn1IPddCaSKkqQNu6BH6zNW6oIO1aka5h/ndKGsYFm2MN+HzNxq2DKHlz2E4vzFghxG6OlWLT6QleZHB2EbmWXZBz7ho2XSqkGZQ3TqGXdbmy5IlxIlKxeil27V72tsVXq593s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183994; c=relaxed/simple;
	bh=8Rv9OVc1AW97l/UiCVzPt+gRZOTmtkExTv7zaq6GYSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYbK8hQI2SnTh92/bVsa/bR47XAqE/2/bJmHW+aC+aONU4VF9g/YXrEaZujArF6VSte9sb2OFT+w0Vo8Kb0OFkb/9FctOvb3+CPfAN3J7uHkHSxbW/lb641Z5CHMqxeiltJTfp5YbL9/zWw60fX+CTUDwwqRbWgCuyfY6uVbAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=YIYN2iZs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDNE1ccg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="YIYN2iZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDNE1ccg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5AF0F14000E1;
	Mon, 31 Aug 2026 09:46:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 09:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788183986;
	 x=1788270386; bh=QR9hH2qCFCqj8AmL9TfSa9UfhVhgFX2hAhjrgRMsWck=; b=
	YIYN2iZsgvCB7XHtF3OC+M+il3i6fbu6wFpRTNS7gPGMy/vo6R/I26tNerm+qYeD
	4yIfH2JJQUjNbGWdqM9yp+soKKf6aDNS8XaCOGtGO6KNS/0eKkMvK5Jvbu+lUJ7U
	C+cAHIuGO8Cnc75pzcf1UF4b+BSIBUbsdMfOravj8nlSX9JhDEBJyqKjNP0xnc2s
	Iw5qpfxfOY9Ke8q6HKH0veCCQHoX3DMCQsTzojNtaKUm06hj9T2ivf6ZyaG4GaMY
	v7pp8xuwEX0dCOQZ0wf5jNGmvf4hzrcvb6SbfhIK5htF0rKXIlvqnGPO3SQ3C7ZQ
	5k6jxYaIgwx8Uiww61fAJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788183986; x=
	1788270386; bh=QR9hH2qCFCqj8AmL9TfSa9UfhVhgFX2hAhjrgRMsWck=; b=J
	DNE1ccg3xnCF7NQ+RJgkNeDSobAXZ/hfT8e0mczXvdIDMpPTUb8MdJ2i1k4kF+9y
	JfM8VqjNFslFq7TVLM9JsEFgyvLvmja3zz2Vk42OrykHML47IyK5fJKI2PZDZGqA
	0NANcdaF/v6O0OtE13vugRBIpKSLesY8Wt5hiaaPsou/ZcdyhRw9H6Engji6PNiS
	2VgHphCZNYvzWl4SG2N1YlcnwGqRLvBIyvnPoEzOc5sols+X3YLs/cekdvs3XkK8
	0SZ3H4S1Se/3amvNgVfFOjRbAFmjHYWpunZbw0y/t2sZpZKARVSb8CfvtjURMetS
	U5fEyUgq73vnMSmtrA8vQ==
X-ME-Sender: <xms:soWVajqviKyUBxzLpxHWTwaiUZ65kQHKYuvcRWO22bvujjAxGNWszg>
    <xme:soWVaoDMTaAtPeSjZPjLg-UoOsEiknA1O9bZoRKbg0ap7Hy9BSjomDm4Jt474n58T
    qWCU8vzvEif0vi_m0DOfjdRHf9-4oDrln_PWz7LZ1TeiuFFfGW_iMFq>
X-ME-Received: <xmr:soWVamWyoVly-MHnzwcKiH7DUcmS1OVb3JXO_Xx36ILy-p0h8THOyaG2kzXKhnlUf6XDHfNIGBKKT6_738SfubRuWcg25AYpsINanA>
X-ME-Proxy-Cause: dmFkZTEuyEFcOjU0cTbo0+jvHR3ugKYgYQC82+6geliAeEgQYiGJ2PoFhaYIOXtBFBPMgv
    N0Yb9itjHB70kUIpYa2ZqpInnrlpamY3sS9Gw3ozWxyeWN4qicyEC/SHtrX+8DNmqbhtWF
    hA3C9An2Oy9iJQxv68cR9vReBMChe/EEdbruzcRM/eTvqxBDcrwplsbypj97UAORs0M/UL
    pf0nR34hybavI1wIxXCFk/MKrsAABTJveZ6tlpXuwBZy66TvyVL4f5uLDAosxyZ67iJHFX
    fYAhg4GD1vt+2mqJ8KdUTywOD9HRjmqcss2+F3QcUkFLvmFWtfNkObhZIJCaXwSfLavCIj
    7n0u6YtQcMvCE4vpLo1qynVsnX6+xRxO8Sa9tMYIofnJaXgAH/u9UI6lWpmaiyLS6csJz0
    Y3HARO5pAPJt4D/tig73jaUyiymbbYoHpkZmjGabWoujR9WTBCYlUWVxUeJprL6dgkRBoM
    E1Vnds5z1eKyXRgj03/EWvJoUKEEx0ECBSLsYoAZI2BKaD6YhGW9sxHtGMoDU9YHa+tJev
    8q6Ct8dQ1FY6InxVYOKVp5kYrdd3VePpP0ELmp1mO+U6+d1xgJC6+3GJiuBKjSUcWCp5Oq
    76/dJufDKhzks3ocbzcTP6pw1rxlvDDjlbj2pMgqnbrMbRzZmTuy4Pig2Tcg
X-ME-Proxy: <xmx:soWVaiDXopZvDhIYVOwxgpCohWK3sBRnsZPV_0Wa4EOepD_hddW8Lw>
    <xmx:soWVarddRxbkR3jCzRX2vwUuuEevIfQ4IqJoZ4X6WcH6xavEJWEsOA>
    <xmx:soWVahrE8-SV2GwuvZbw2lwU_JahunpjzqpU8qHKiYjbnq5Njc9Wvg>
    <xmx:soWVakRL1TIJdk4M0drTPcCzS9B8F0V-6zloc0RRp1C3n_u8veGuDA>
    <xmx:soWVavyo4k99avn0w7TJ4sNRUedRD1GriNXaK3nI0D8vS1PocitpmdOB>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 09:46:25 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 31 Aug 2026 15:46:08 +0200
Subject: [PATCH v2 1/2] dt-bindings: iommu: dart: Support specifying the
 DMA aperture
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-iommu-apple-dart-aperture-v2-1-d16ce3770299@jannau.net>
References: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
In-Reply-To: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
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
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqyprWtub7LOiK28Fp1ceuGM2+b9CXY6AjlaT34JLuSb5
 K26ad75jlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABMR62b4799/j//EIikur0+d
 2tcP8ch5JR0V0EgR+vvq+z7xMz8fLmFk6IybsIptVuTx5fw+c3ju9dUGByZ4ewdfaC+aYX3GNeo
 AMwA=
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

