Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B3385D70
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333923; cv=none; b=NBiHUCge0rEyFrbR6a9WHp/4bqaUt5QHa8w8wHNVIOPJBS6Xn1e8G7WVdl4ktaqbJIhjfLAiYZ6brmWY7Ru9GzFeZno2uMHLDZ9/aIyMD4+EJsKF9ZeoGipN8RoLJml9RMvl0oRd1EqqXsExWgmQgq46buGcLlj4MVWHqhRCGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333923; c=relaxed/simple;
	bh=7jgzTiHZ5krI2MA++B97YNG6+febRofoGXHNduodpd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQJzry0f5hdAjO4dfS9LVldAPDQ1BHyLhjgqUgArGQ5gKzXNU4j3a5xxeQ07d3rz7P/l4iVOeO4wbewZ/CmfXvftXUSkAxR8+m5iw3t+LI7SeeR8r2fZIabK/qalhBiY8lDu+k7rTg8BdJWnp9rAW+Rg2QXleoplNdCmniCKfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY3SMsOt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY3SMsOt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so10925595e9.0
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333919; x=1781938719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ66LcteqJ4QI9hjgF9HToSLQnhyQKu6uHIFWcsfYcU=;
        b=RY3SMsOthjGCxFnkEX4kjwE2MfUzIZRLlnMNWcp+yMjb6Y9Lo9DNXSUCmXNqhvlLHC
         sou+HOXbicZg28Cf/grI1R3fD1KsHn+6hirEWNJJY519bYqw/g+aA3jFVIctYp31IW2C
         12Pw9jUB2EnTx9+1UYlp8zPPX2btanvrfiDIhOvH3J+cIuHpP+ROmP5k50wkOyOOU6q6
         2GkaWPKICS7oZE9VVvBDhT1NeHC/Cf6U18nN0HSAN6SHBhHDiA/qnhk8C72KOKoa9Vch
         5fa77REzQDO0CeAlbsp54UBx1kQDZB6ePVgfph64v+ks2pwbj95lOogVo1Reat+md2OJ
         mcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333919; x=1781938719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZ66LcteqJ4QI9hjgF9HToSLQnhyQKu6uHIFWcsfYcU=;
        b=mqckqBxcT/yHZz1TvFuUniDeNYFPfC/GLB8n9bW+Ra4Z53Lm/bU88cUhGcbZmG+ss/
         1icP0u49Pe4/1EToCXlOd3QesEGLh234Ui4UD8wow0Xz2hZ3gFGNxcOYg4m30L6Jcwp4
         l3A85Pzrz+1cGzAzcj303ycR0rUiGw5gqb0/95Viflm9lGVRFJNr0J5Z9CXOwGgk9EA3
         vuEHI0aM0tTNVhijofshICt2H01FX3JAur95dtyu3BwJyZ6mVZpR4/FoqABkAmlws/qw
         TlDFQzKF1lJFNgpXx/m1BTvsyGW9ZA/H3/HmkE9Vx6mzLxvoP/XrT9DJ1V6LUaBFYI1W
         +wOA==
X-Forwarded-Encrypted: i=1; AFNElJ+bSbaQMs1xh0bOMzKhU+6ELu4qUizWYIsuPLAnLAE6iyRg+ySlIdkMTleLjJHNYr5q1e4XiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd8Y4/FIQQqTk0cgDilODa++hIY8LJ4iEM9u5Szpz09Z/s8fnz
	xy6JlHqd34DMzsGuolaMpFzUkRT+fbbwmuHwu/x84bPSxQwPZ3ay0/jB
X-Gm-Gg: Acq92OF0P5U6l0ffu2dfbKYzpDkgnncCjDdUWwL3ubqk/nmD+UtdlSBMNY9GW2+hZrt
	PfyDsKvl05PiMhpKDVXRb/+zuMHZevT7JjCOvT56LtTeqh7mXDs/y/9UNduIEpNlYAgzoAM+/Ml
	uJZ/RGD1Zb+gLViyoXpe3Yv0xKPyLjGThkQbP3DMETrnpX1SRwQH17k8BgRvUApG9bqcGUDICkc
	FLwPKmymVGoF32BqLv188tLNYEoqgNdtLQLulKEbsv9OI05KCRz85jZ0uRQ0pdE9NgGJFt+doxo
	Vc4JYkgg7hiZdnyFiMS9kxFapT5T2/Fgn6UGsFbmhcFdSJ1egA1Vi66ByS+DNY0KSfq9ZaW1Gun
	gNtudHZe2FEODI8t035VPHMqmZ1dqOY6dajhR5GRuBmK5BRELwBrudVyq6ZoKTgxPxhYcMTy63S
	/GgWNV1f2+GtxyfQqkvBquBulimIT0ASayD/VSAJlNJg==
X-Received: by 2002:a05:600c:4ed0:b0:490:5e2a:f924 with SMTP id 5b1f17b1804b1-4922008485fmr28715325e9.7.1781333919182;
        Fri, 12 Jun 2026 23:58:39 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:38 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 6/9] dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
Date: Sat, 13 Jun 2026 09:01:13 +0200
Message-Id: <20260613070116.438906-7-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
RK3588.  Add its compatible.

On RK3568 the NPU NoC bus-idle and power gating are controlled through the
system PMU rather than a dedicated register block, so add a rockchip,pmu
phandle to that syscon.  The RK3568 NPU has no dedicated SRAM rail, so
sram-supply is required only on RK3588.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..e0b948ac47d45 100644
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
+      Phandle to the PMU syscon.  On RK3568 the NPU's NoC bus-idle and
+      power gating are controlled through the PMU; this points to that
+      syscon so those registers can be reached.
+
   power-domains:
     maxItems: 1
 
@@ -75,7 +83,24 @@ required:
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
+      required:
+        - sram-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-rknn-core
+    then:
+      required:
+        - rockchip,pmu
 
 additionalProperties: false
 
-- 
2.39.5

