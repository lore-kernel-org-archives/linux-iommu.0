Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD4258EE1;
	Thu, 21 Aug 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791857; cv=none; b=ouq37XseHnffVWLpGLbxzmDlYmfWNEm7hOzuqLNk2Ykpj175q2BZe4wvVgxPEv3uQNWZEc322NNa6WUS/yjX2m3kLqMmiyBBaUgb/joRmk9H4vnaalECF2wQPJpXHsV3l6ftzrfO6ACohNlF4U6OiIyFEknJZ8mFz+kzOplUtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791857; c=relaxed/simple;
	bh=v4OiVJFsSwjODAdi15xQbBcLXhKlJm7rChMF33HLKjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYpgbY0BfC9hmlZ/D7sQWRZh2zl8uf5gAAjm3IcqSKv3P9wFLKWO7d6r2Yfqi6NJvLK0muisEZ9zvr/W0EjE8aPmq3rFSNSvKEjEYCS2CYFbjl/R0L0waKXIR8r0R49sejJaHzHIO0/JWzkZ90ntckVPmEEf5k6Bitv2j8gSjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad0X01qE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad0X01qE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so1268383b3a.0;
        Thu, 21 Aug 2025 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791855; x=1756396655; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=;
        b=Ad0X01qE0jvU98t9nemz6abF8a7zEMUDxhEuBHe0OlFSpMQXkQGt4YfX435m7yhYs4
         1OczKwSlM59o6bUSeaQ5K2IuNBRHZdhSued+gYEXQslY/Ju90Umr+sZ85Oe789bbTKGm
         5afPnB1HZeziLwBCm4orKvU9ZdgeQSHqVlTtu+lwNtrTfWyUkCyzQKBkP4UijhMJ0RLS
         VelyQfh1Fa4BgiHJOq9E5oL/bWTofP4jNfRwueVzF/NF9XUqz4PL8XkyIvkDbpKapTEv
         RJkRLrjVYfjo5k9R8tH9pNo08B9l1CXap+iAaHjwhpXie3rdqlJrAZpsvW+HtSuBa/tj
         1ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791855; x=1756396655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+TLtxQE62J5KV0O9wYqUJlCIzAdogQJTkJBjLbCxYg=;
        b=OVsg+uNirx2eO/Fi4es+UMuwU43BSUJe05rSYMfxhZBMCq0FeBo2BO9NRnT5ay7plf
         uDVTBvMsp/Jqxz61KPfVc98YHgToWtpjVN4RN8imBfrM0n9+V9M427WEsKZ3Xn5zQw8I
         auSQRUsIQU/0ggpzgBDzyidI5O1XQRXOBSbcFoGdHhYiE7fTcSuU8CwEih9Co4f0+r/r
         CKTXyInMUsjvlFLfrGM/PfcuzN5hXICZqeXIHR5wXgjHetkJ4XU52nUWPr8huGbbAlLZ
         xoaCkocIPYCAMKfnRHhF+F/lZ4pgEuPushsX25bHPbdgNvrXnnuq2+QK2LK7kHl3xYrT
         fqjA==
X-Forwarded-Encrypted: i=1; AJvYcCWyg9dZWG1tDbgTj2AdY5XRUrqRp2hdx9FCVZMxXZiFz74OXvZhHG53POACZYHDnUCxT1hbig==@lists.linux.dev
X-Gm-Message-State: AOJu0YxacjDhaEHTp1UNITj0xfDK4+CIYKju7AhqKgf4MRUadS78d3EW
	ean6ekbwSP65tiZ44BA/QrSwgCp9h9OjfzyhjTDgrPoZutPCL89nGnQvl47X3Umy
X-Gm-Gg: ASbGncveYHN9sbgtO7oqgxuSq8qFe2oYzeRfNag01ZkaeyCrNdx3CQObJ749wNd+H3w
	fTpsFoc3KfB2Qee/z+2dhoK/gb6PUvf8T2VgIt3x3sMi/zTcO2h3A61tKP/0jhtOBCP8kUEdNhh
	w+uX0LHjJZI4Vnhf6k+Gm4HrlyhcOAfXX4PiUUAo4g8jgcVipSuNfCOV5TSisDFnyN/ZPP8v54D
	G0Hr9XhQdU0qyNC79Avsfe60UD1PMchxfrJ1NbZv8mTJAwQWiPztBzDMJitCqoK9B+0uvBiPX7b
	P6L3CexyXPFIalVQsxJrTTf1w50oRRoyK0o1kOExPQoiMFDteT0fF6fx3BZd2IcMKk2YXiHvMGq
	KNBRfSH8TCJoJ7hPNBCTV45RGvtbOlMA0wgeGpOmVUVjH1Cw=
X-Google-Smtp-Source: AGHT+IE0wcnJHKLEW1RO99lnzrgpQRtwp6zZL3gPMRllIkPxphhvBCZH1jAgYyHmbKF4OaX4kboVfA==
X-Received: by 2002:a05:6a20:3d1c:b0:240:1d13:ccc1 with SMTP id adf61e73a8af0-243307985dfmr3463057637.11.1755791854959;
        Thu, 21 Aug 2025 08:57:34 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:40 +0800
Subject: [PATCH v3 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-3-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=v4OiVJFsSwjODAdi15xQbBcLXhKlJm7rChMF33HLKjg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUF7nwsx/EDWK2zDtfXq72ykV0AI3cjgEEV
 9AO6pJUDl2JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JPjzD/9ULBgNc5mV2zbwjOSGof+wpPmRDRKVbasRayoFp2Fx2wctI/7F7cyPCE9Vb3aimuNSW0U
 pm77OfK34fZPTWk1BYskORnZHyFhJ2xQROrBFLne7E6gwWbuMLUpjPKZmfWoAWE8lIRwLVTyLku
 hENiMjSDmjT7t0M35bgMOWz40E5Dq6i+tRtnIXcvjOzQJJDG9Ir+ZrIeTAd4vEbv0WPmctsct/V
 RsIJ/+zK3gDLE69ojf6Xe0HbaxNvpG9sHtNWnOQF95PZlahElyHS/2LPkPkGkcOpDInKxIjrY30
 UjZ5Mqwh4TTQW3MZLEC5kMcTxtLUDCVE0UJF/duROcUkeNU3yBuBnq0yrHGctbrNIouX0F3zp6p
 86G/vg3AXEg+UfoOz20jaB8X7S2FWgMdgS1EL7pL4zs+QtFMUOn1Ow18Pb+0R5iOD2AWMxNcqB5
 znSdFSuFwV649uwTBtLSrsBksi3V/C6HVYCr8jM5/MXKoReGZqVv6P8CQL9LDGmm7kdWcyDu744
 VDoxJK9wDnDuMojz046T1LbYdMfyGOkrBWJTKl0FLP3wM8BRu5GhXZi+2/7a5Vl6lWzi1fTg/+a
 TN2vlU5yiz07qwLCsV+1lB2m36dMV+/4uX1V5KpG2WklJxNn+fcBEXJ9ZWezH4wtk1Uw8QCIzrk
 dG8n95wcQFyR2bQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for SARTv0 as found on Apple A11 SoC.

Reviewed-by: Sven Peter <sven@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..c8c62f32988238c5dab93bdb04cafcc41129b423 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -34,6 +34,7 @@ properties:
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart
+          - apple,t8015-sart
           - apple,t8103-sart
 
   reg:

-- 
2.50.1

