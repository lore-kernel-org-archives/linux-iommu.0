Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4348122F
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581186; cv=none; b=ujE1lKKLD/kKzP+gXVG2ay9YGFIsuUVyKJfiJHtVsvQbJKzVod13oIyJWKMy1vj+fnMtGtCi4Foy8N7nAU4CNcUutRrSMGizjI9SUlx9WqZSnwWfJHnqxoIgRY2lrPiB53q6sZZe//7+gn4kcnCZfMH65bo+AkiiUl8C5pxo7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581186; c=relaxed/simple;
	bh=O8Ms3qpIJaPqvvfdUy5Pzd6rw9MEf+RBk9h7q8KnQiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khTflFDQ9HSamprjlS//2DUDQDgUIdNmf63eZDZ0fP/GC2aSTBibk+tiWyGdcsf8BSYw7nHg+DcTauY9tDB5xCzpHJwnBbq4oOcbFUA0b3yDIePcNTSzSZ5TicvFXhquh8Y246Ux9Lmd8Arergfmp5Y0oyEMDXEQ8XkBehk15Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1eUX/C4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1eUX/C4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45efa80e0afso629959f8f.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581183; x=1781185983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLUAaZps1w8Jl8h4U5vkB2L5GVDJaAP0Yeaa4HLYIr8=;
        b=C1eUX/C4TcBDoZzunUcbWJUhmTTN4ZCsRxXtA7MRHiSEb8AsIkdFNOFoJeApucr/aA
         ZOziaF46FsQQwGlBhN+jEpRSFj9WtZKTmu98niue4z9/N93q/MnoXXgUbDGDksleVoMJ
         xOI65Xpqsjf14fkBEDFL/K3a9bf8HpzPIGyE9c1U8WiqHC34iXwzzwWcZmgfS4QP6Tvg
         DnggYfnqukn59Tn1/yPWggrpKvUG4sbh6idIEm6fz9IxiKRUCpZhLfZbjB63UcWN7XGj
         wxRlxQqJulSL18ZIIcLxeJ27hf58HzQjSQ7Q5s2+xkFV0k4ENUa1HSl4lrXgA9wKFaGr
         eJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581183; x=1781185983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLUAaZps1w8Jl8h4U5vkB2L5GVDJaAP0Yeaa4HLYIr8=;
        b=r8lwhduNX/Kw9XiEOBDY2Z7/yS9JSV9HXzvZE2fw8nwONHZQLaZWtdB3QUdfm+bvi5
         gvszCQkf/z6iCqqXiSP4IZ1uq6rK/mLKIvJL25Tt3DLi376BbHCggH0J43NQBKPSp5AY
         ZIFrUVP2AXWC0MVR44fGA43au0/ouwNOxJuMJLbflQp3QMZkm+LGF+0v827ANFYDxHWC
         FHOFfdIkGXUpL3czkQ/tis5MZ3sN0D2ANc+iSySEl0RRXA/3ULy3C/xl8PAcn/R7MoGQ
         QQAgyLoOQn3yFo/97E+sfKU9FZa46KHGcI8kN8pTJmlZh4u3e3c0gwrN9OY/viprgntB
         VUlA==
X-Forwarded-Encrypted: i=1; AFNElJ+XtW4Fh7rlLDlyJxiBkVeqZkjXrUnpu5Vm1dZsKk3fzOAfqHg8DU6kYKNDsUO2GALER5ng8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ+FQYAUtEnc3CMl1JoBAiUCIDt/3h5QYkCpeChQuKOB9+I5G+
	BjBVCPgRQmUXAMa/s/9H1/z+kOMEfPcdvx1HNgVjouFY/2JSpsF2Kvll
X-Gm-Gg: Acq92OE97rGDwzwBcSN4LjEiMe6kSS8mx4pj6aWCW1j9VJoi9FF4ThgS+FrnXog8Uym
	96L/gbAKmZZjLq/6cOK2bcKnrkl5bLEj9Bsoz+ETZL3PR4Xd9i4xfEru6sjooxPqY2VJ+tFw45D
	s2zu9DzGjY7wmcRJTvJbrPa1RHzpbLfxuS9uvxU5gyW8PCaw2pYXuNBodwXzRtL7jTqbohYTi/s
	7MldBoyEnxpzpha/hWty9bkb+Rz4aZ9YVP4jTS2ft03uHaB378/eEImvHhq9b1A7h2GpSgy2oxC
	ncA9EXCfdfZPg8EKalQ0kTMi95yndNpLgx3iQYn9+4m4bYXqqt8vtT/hVGJGfRpsulKZ29MlwOW
	oBza2AK8/29ggwsNCUlOlaeqyHR1s1hMoMUOzdVFLJRmo/xh2PsYO397v1wVrDpCkJndYjcBSTh
	wnmLifysKEGjnQtw/2NCRwmX4dE4dWyM+DqkcYiF+tC/qOIjGSwm0RiLcUoO0e9XE=
X-Received: by 2002:a05:6000:982:b0:460:2d57:fcf2 with SMTP id ffacd0b85a97d-4602d58034emr3094425f8f.10.1780581182959;
        Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 7/9] dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
Date: Thu,  4 Jun 2026 13:52:53 +0000
Message-Id: <20260604135255.62682-8-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
RK3588.  Add its compatible.

On RK3568 the NPU NOC bus-idle and power gating are controlled through the
system PMU rather than a dedicated register block, so add a rockchip,pmu
phandle to that syscon.  The RK3568 NPU has no dedicated SRAM rail, so
sram-supply is required only on RK3588.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..af9936b32e9fe 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3568-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -50,6 +51,13 @@ properties:
 
   npu-supply: true
 
+  rockchip,pmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the PMU syscon.  On RK3568 the NPU's NOC bus-idle and
+      power gating are controlled through the PMU; this points to that
+      syscon so those registers can be reached.
+
   power-domains:
     maxItems: 1
 
@@ -75,7 +83,15 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3588-rknn-core
+then:
+  required:
+    - sram-supply
 
 additionalProperties: false
 
-- 
2.39.5

