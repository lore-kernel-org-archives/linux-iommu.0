Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999071;
	b=nVUtu8Iob0yaRuH7EToulse11+fDqxQza+U8qN202OvMq/LQI0Ir9uRO+aieHROfqejV
	 hxh0V73WpLt9OAwdT6vqHPpD0sjX8jxTT2pDbgBYkLHP49Jwd2yHwtgoUNi0vEtmwYE6q
	 4TnKrs3XZVNK9zwnC2LTnRhF81JrXxFpWLvwBx0u3enSquGfSExK7WMxnjtmjsN0S1Y7x
	 qu7Eqnmh/sc8EQSK2iDZA0GHzYYpMtqIV4S6z9EqcxcoMgCfDVT4pMJJAlpGjJbLE9O60
	 EY7o/2KZjJ27pr0yqbx/Nyp7vnuPzKnQPbWe6dhqnimvgKW7Et3+PmAgi5m4KjVs0Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999071;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=tje/iAOgXLkukdf7IpTXxmJRYT/oZk9KALyauIZxbAo=;
	b=l+YiyCVpTerPcZOm4FpWbalgfq2/YgrurRdAAq9d+4AQGQqi17tZ+f530DFSYUe7tom4
	 3RlUHQHhTMp9k/BaTNx8qwrrJHACzju6wW9MbFta6advl4rS6IJLN8AdzipWpagLfo0nI
	 +nlzWCLDA5/SFZkVqOeS1UPJd8oTl6igwqNZkuc+zWXkoHQr1HGA6AAmv5PoSWgXgDgrH
	 3TlXLP8sQqrBa3ocoUXJSMajCb4uB+ayhlkmN/NYoXXia61UrWlI8ENDRsIW3lBfNstjx
	 yLvIK5zhKN2ypG14OXxhg4ostMJ9o6YEdWj4Z1YyzoqCfgJLnaaMa0GlEuDnPND7kvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=PODu4cFA;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDC606D820;
	Fri,  6 Nov 2026 21:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BDC606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=PODu4cFA
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tje/iAOgXLkukdf7IpTXxmJRYT/oZk9KALyauIZxbAo=;
	b=PODu4cFAfBCRmLvtm28kAPn82pmLcRFFLyT7RHSNr7UgEbNvbyrVT/GzaNy0qiq6UDTQHk
	GQVM3OiaHd4hJpYHhK05GWyZjpqsYC3WgDtUS36uz6QUt15NoIoUGoD8Ez7iR822ZYOerZ
	XkNfsyW0g8Ywf3q/AEZxNu5QbLDQG6k=
Date: Fri, 06 Nov 2026 22:04:17 +0100
Subject: [PATCH 08/15] dt-bindings: iommu: apple,sart: Add t8132
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-8-22f4827b4ece@cyberchaos.dev>
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

The SART IOMMU in the Apple M4 SoC is compatible to "apple,t6000-sart".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index 015158a9676b..8cf41473b808 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -36,6 +36,7 @@ properties:
               - apple,t6031-sart
               - apple,t8112-sart
               - apple,t8122-sart
+              - apple,t8132-sart
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart

-- 
2.56.0

