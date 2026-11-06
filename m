Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999074;
	b=TXhr/kwAntZswtKcSEXj79sjDC8/adbnVbKJt+t5S28EKX0GdfIPcZk/5XiliBnrWCJL
	 GiDKKwowAQcFZ45Tij5AI+tbDdL5oTh3P8ORlUHXpm+l7B8klPtiY6Sv6mq/XZSliRwmK
	 Cq/j9TScK8nFzHRvelpNvFmqq4xlHXrqijQrdgH5Lq2hrQnSkUEuwQIGUfYBmBvqC79zE
	 KbpT6CwwftX6hEhIRlI7wLX/n0W0KlIV5qTgFIC9ZoRyKdDivafXZs1DZBz9i35X/A8t7
	 YNn2nz63WtiaD1bv1wQIJxsVLKosLrH045FaFC1LNdKxb9OZVi75lZDQ8a2wNR3zYtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999074;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=C8Bj/vOdToLYdeQCtg2KHzCECUKrUX5sFTGEc1W0N6U=;
	b=1DBW/60LK/67BBGI4WRfSKGJFr/aSG/zEPqPo59XbqgVRKAlr7oReKjFZYz2PrijjLyM
	 6hUykS6h5r7EjznS+MT+sj5a4jfOx/P7GWk28ASy4tkn/hh1kG6Kw8T3TczgCQwP5eVzK
	 z8HusXo13si4KYww/O9saLbmoFrLaAMb+nRK/NBGYed3PPtV5TBvWgYBAXBMkv0eIdLVr
	 ZkLB8CvIJk6ArYl4zIqiMGvrWA6CmfSJDnE78edP0H6jTfgAksLOCbl4ZeHOLtES9Hwq6
	 XlhCqzLHdxKPtE9VEDTKnB8KK5oZQrZoEVqEV3Te4M3w9hZEZ626PKzID6cG62LIP+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=N6DNO3Th;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE8606D82A;
	Fri,  6 Nov 2026 21:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62DE8606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=N6DNO3Th
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8Bj/vOdToLYdeQCtg2KHzCECUKrUX5sFTGEc1W0N6U=;
	b=N6DNO3Thk32qunzHrJSzmMm3+w6N5TvAAgOQYyfslw2Zxpnd0TCGg4SSQXg0mvwA+qnk5N
	ZblXCBOHrhjnXFnJytS8BfSvCp9xgshhlQmwPlwUCORVqwP0cit7X0iafRIe4y2cY/FPv2
	LHyhUMNyH+V4AWH6YV31xH99wYJM7bI=
Date: Fri, 06 Nov 2026 22:04:19 +0100
Subject: [PATCH 10/15] dt-bindings: iommu: apple,sart: Add t6041
 compatibles
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-10-22f4827b4ece@cyberchaos.dev>
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
In-Reply-To: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, Yureka Lilian <yureka@cyberchaos.dev>

The SART IOMMU in the Apple M4 Pro/Max SoCs is compatible to
"apple,t6000-sart".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index bf35ead191ec..f79242f112df 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -34,6 +34,7 @@ properties:
               - apple,t6020-sart
               - apple,t6030-sart
               - apple,t6031-sart
+              - apple,t6041-sart
               - apple,t8112-sart
               - apple,t8122-sart
               - apple,t8132-sart

-- 
2.56.0

