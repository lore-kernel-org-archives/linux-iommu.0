Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478538;
	b=zUeVsLNrcGghfwUAUk2I6rjdd1KBQmRi2DO5todk4CkFcF3pwR7P6xULyvRpIEymH4iX
	 KSF9ISN1xlKd88GDzhBEzNoHH/fmE0HCUaHfkMfUK/eGVcSoDXubyCKJOt74iaPSOotwf
	 YkDj82jhVMag6unybcA30aPPTwS0dwftgLcO6Yi0PdK20QyIsxnhq64f0n6ixZ4fXB0RX
	 ng60hqjZgtHlEir2/I1HeFdAUODjon8+S9JqQsjSFAn3eAs+kox8+tBatlGnHVGuIHjLj
	 DD77bJ0fnr63eMDv20fkJbPOzV1sRnoB3Mgr6ueIXXR2AlmjVCMQF/6F2Uqogbe/kgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478538;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JL3Qgy6Zdu9V5GN8HWvkTl1Wq1sYl2OXZMXf1JcFhGo=;
	b=mzRxrt1jUL/dqCtD/2ixXqBU6laWV+9vKQBiAGf8MCT/YzDe0ALYgXNOS0dmnO4lKgvD
	 TYfzbxT97KSgaflxm0/E19B8EBoAOd2uzXIpkrAL5m6CA4uHL88/dq5JwH5HWHHkNIJz+
	 56HYAapr/uz5ZWs0BpR2sKd6uVMj7FeuvVOH+whwAbjq0QJL+OsJ08GQzMyNd/VUzAPJq
	 Ligwj447/dXydC9JeXy/ctVSvBNOSeiFMnvrw8XTJstNnXGjdUO90q1EO8xZ/k4x/kb9x
	 1Gq+l8x6CKPcmzhWjdcFnQWGLySqVCF467A7DoryDNup31lC14HVn33LaPh/RCaDJNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=ZFKqow3A;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g2IaOFE3;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF1606A321
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 00:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4FF1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=ZFKqow3A;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g2IaOFE3
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9B24140038F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:02:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 23 Nov 2026 19:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795478536; x=
	1795564936; bh=JL3Qgy6Zdu9V5GN8HWvkTl1Wq1sYl2OXZMXf1JcFhGo=; b=Z
	FKqow3AO/RPA2d6U0v60HnuCsT6mJQv6h9SgGEGOTg4/tetQuhYXCeItn82qnCMx
	8xrSqUgXiEPpW32Em1lud9QD/Sd4xyO/aJl96h/0DVC8XuaA5VtvmiXG06djhS9O
	51o0l2h2Ixt5M+uWZvJhuqR2cCzu5jRdX2T8ZckKdK3auy+cPepI4puebhrSQ1zr
	Dkofgpzq0X1F4mJRbjhelY4ToR2xiQki9mzKzgIOv3PWGeDCKK0NtaMiInq+66eN
	Bo7hDatiupC0NtI7v5nH2/O/rIWQr9neBe9dTpiTPB6ICcHT19cYX31MWlGa8hN5
	SwkLGoasTailIMd29S+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795478536; x=1795564936; bh=J
	L3Qgy6Zdu9V5GN8HWvkTl1Wq1sYl2OXZMXf1JcFhGo=; b=g2IaOFE3ABFa8U0PB
	ctXwvD2URDVaTqo5Ryn/Z7ePXj/1Iw2dobgx/yUWHmQ/KyH2uKcLBpYn7i5z+rUN
	zqWyazHalAR7Vtq73O9vJqA1ZkK43z+KhSXNWqYYFlxeNa2U9V2yTT6tZkRWA7wQ
	EFHp0wa5B9jBscfYP5B1qK9hwWt2Eh+1NVBds1Koys76FlBr+Qo2d633c5Z87wx5
	d8dXTe9ARGGvt4Zd+AyZPZA8Nt9HuEJqEqFV3JBpxxWLbW3847zY2QNrQEmrE5zp
	0p+EIGxJ12RpsnUzqJU8GfWvl8KTiy6ODE4TvtR9E5kVIN7HV2SGw+1+xK1//Emf
	6xLBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478536; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:NrOz1hoY1miP1wQZ9iDMlRAzgw/O7JcKAUamkNpO6adBJQd
	wqcSsXV9KmjagrVmYRNCoQlKaTkFevliOT5meBjhs+VEdVnjpQsP3NQUTXhzWuY+
	/l5U9vw9DHUGSmD3Jz/bCyAFxTobHvF8Jd35exyF84g8qIFs/tvFj/kTrxkD5Q1q
	zuK99JJC1WxIVdd1caaQCiQsaFUZXSut4FSkUPXXtMg9g6TTFdz887VOw1blXRcW
	PBzPU0pDUKmhgm2OqxWcPrDQIqRqrfw1EsXOQsPJs1hbZqUEXSXxaDc3BnkwuT3N
	duZ7GslFmX9jpFKd5leMcBd6M3xqUXRKet63tyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jiVJd3R6hdy1hOaQm+GRtS/51voX6k7EnP0kvg7Pe5E=:ANkstA5lYKTOgLdpX3zjs2D2gIDyAH3ceoRvnlM8StI=;
X-ME-Sender: <xms:CNQEa0QU7nxzDePsyr8i3xmbbF2mw0BTLTz1rauGUn9evoliHXYBZQ>
    <xme:CNQEa8KgtFxzU4Vh8AB9FVycAB_21RCNerJ5Mov0pRfxRaYwfJhD55MfQXLxHwOsf
    N1yoaF2T3N_NhyFZOOebenvnd5afuWg5iMpg4sXC8YBU1vfWU2emmCy>
X-ME-Received: <xmr:CNQEa9Y_CMwvJS2Dwc6tlby5OQOLikjLl1j1_86j54kg_RUhkyP0Ttm2_G7qWLgu_Dqj9w3r>
X-ME-Proxy-Cause: dmFkZTGEhlIT9xPRA8308BbHtqEEwMB/QskSvZlBy2+jFJwvtvfCirBVTmQimOCxW6z0/I
    N3fQ54j2uzkfIPiLqru0ODAgPBYDp/gZpGlhkMMOs9hof9ZG9GEOWdivyiuw2bnIONku0f
    WjmY8ul15onHL4eXgbBkYGjVGEM6SHV1iLYZaKVJkdDH3DHIqCHks7YrVY+mw1lm/Lplg4
    vSpMyj3j9q6sOZaTJVZd7ureJCnCjHJkmaDoA65nKLS/dXaLRNB8dxmmJokxzDm7a1gLZe
    vv+kmS5leROp3LsXetZXye6uoB1rh5Trh3ziYwSHciSyu7VL/LnTqx4QcFZ369FhHiPhX6
    7qMgCUUgRTYvnSceX6g8TlNjrvseGChimQ2uL5/UPnolD9ExtQx90gU5jyLWx+p3EDQlT4
    UDArTfpc/8Z5L6LrFf6GVl6VPvZVPOoVG9Ef+PjEsOTZrxzQn41TuJgMsxtwgpN9tica3k
    /bM28FMyvcoIjOtpkDXjDdu+DDK8CLsohz94hhBnXq5e9Is699FOHYUZLZiwL5ZxgG5Spo
    9ZWuC4ZluNyOzq9If9HUZ/+5+TfGiMQoR3WAdtp/G8jauX4kI+4GYW/kLVIWh1Q9d2pDzC
    JGmZPMPrhqxFo9TXatBlDsIJ7gyWPgwoJhGO1q+Q9SRgBO4qclrJxac8MNNg
X-ME-Proxy: <xmx:CNQEayAtxQOnJk6XgF2DU0tPHIoWvGW2Ms5epOyl-KGWRiPKpKQqiw>
    <xmx:CNQEa3WIN-rUiySS5myOFEKopLwsvTWvBUy0BV3ScBCFoCcjzUiPGA>
    <xmx:CNQEaz0EQrI-v8c62I9ve8TAhE1ha1U37j-NiW68ffEfvEPhOi7nFQ>
    <xmx:CNQEawVUDg6r2Af-WMgS1kSMJ1nLokV_3ElVm8PctJSwCVO3Z1nuUQ>
    <xmx:CNQEa_Eve3L4R8gm5f2Sj2bW2NUBo-6MWorniFLENug8K8BMWuGRyWrM>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:02:07 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: ddrake@baylibre.com,
	royalnet026@gmail.com,
	sidong.yang@furiosa.ai,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v18 2/8] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Tue, 24 Nov 2026 13:01:37 +1300
Message-ID: <eea37bd2f486b5855b314014d2e4c3049c666bb0.1795478392.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795478392.git.gahing@gahingwoo.com>
References: <cover.1795478392.git.gahing@gahingwoo.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 uses the same NPU block as the RK3588. Each of its two cores
has six clocks (aclk_cbuf and hclk_cbuf on top of the RK3588's four), one
reset and no sram-supply. Describe each SoC in allOf; the RK3588 still
requires sram-supply.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd..2eb9337819e6 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -33,14 +34,18 @@ properties:
       - const: core # Main NPU core processing unit registers
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: aclk
       - const: hclk
       - const: npu
       - const: pclk
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   interrupts:
     maxItems: 1
@@ -54,9 +59,11 @@ properties:
     maxItems: 1
 
   resets:
+    minItems: 1
     maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ -75,7 +82,36 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+      required:
+        - sram-supply
+    else:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+        sram-supply: false
 
 additionalProperties: false
 
-- 
2.43.0

