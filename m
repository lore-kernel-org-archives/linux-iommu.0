Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5D3F4DEB;
	Sun, 18 Oct 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341525; cv=none; b=MCPXEFkAGtFgIaV2l36DwFiV59MMe38n962FsCanIg5nu6y3x0Q3hpKBO1dzmjxJ8yjp4Y04jZ5D5CyKY5k3yqBsOJ/oryuF2I/yIO5S4PphKvuyNAqx0xiR1GpqS7nyuBi44o2lzk7AzxlZSCCpgQTxcr2MDriJPwMr7E5QoH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341525; c=relaxed/simple;
	bh=UDHszNuWmQbq3Wu7Bs2AhnZdXhL6cRT0VdJSJ+6uM64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZvqBk2Rc3dlYTgIpCFh6W3AeVmmNBKzWFvjbstEbzzvILwkBigjGuV2tK+c0HgRTcXyrqTvvH2UJr9eHGDrvUYeV9hH1aUhZcG8whpQz8BmKmdskaOCNLWDy8kKQSpHBVItQQ0l6yGKdbtCQsxA6MX5peClA00nIZiNSKGcdE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=atA6yuZi; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="atA6yuZi"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1792341505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emJJkhshzeK8P+If+K2qks4eZgheDqgrDrDeTe9jGqs=;
	b=atA6yuZiFe5joFM10lquRpZ+3zbhop7/gWmncclhAls+SRCX6WKogikmlepluLLojl4l3E
	dSNnlEk0vrzHOfs6nRpWhXBpSWAhmCre2NUeVIrwKTL7YFGWC/sTr0iV0WWiqXk47U3vcN
	Tb0SlshEDgTjjkzuWEZv6td3AHmF9/o=
Date: Sun, 18 Oct 2026 18:38:10 +0200
Subject: [PATCH 1/2] dt-bindings: iommu: apple,sart: Add apple,t6050-sart
 compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-apple-sartv4-v1-1-1eaa5d63f6a2@cyberchaos.dev>
References: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
In-Reply-To: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

The SART4 is on Apple M5 Pro/Max (t6050) SoCs. It has 50% more entries
than its SART3 predecessor and is otherwise the same.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index 88e66d4b13c6..d081dde44b05 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -36,6 +36,7 @@ properties:
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart
+          - apple,t6050-sart
           - apple,t8015-sart
           - apple,t8103-sart
 

-- 
2.55.0

