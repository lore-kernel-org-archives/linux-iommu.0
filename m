Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999085;
	b=GSs4ou1NTN1JccuS/GmP9rms/p/SdJ61lEFZ9vYCHz8Xn/JLQaIhJQmV29q1+Ln+4S6J
	 J1Lwo2XHFZ5mjHy/E+GG62Uj5J66sgXEuukNMdHFiLdkw9KkVh4jVLZksKmlSSlqdVjyh
	 wYnCQdzS1L056nKZLAnFKFcIyxsFI2xiOUS3Fc1dyHwidccHqrL06yyaIN28M4NfM010d
	 +EKx1rbSjMBIT/YiETQb0392u+j0jlw5AXyW3k+q5XXCPnPpB+g6VbIgBXATtzgtz60IZ
	 ry0csgmYIaa6L73SgtG8+cfF1Lat27z1ABR/C3vJf19215WrvyEIhEmfMseJNlyHkWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999085;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=5triKr4rWQNxHPSUFjuxeCn4xvtnFfYzHmRmVnByAwk=;
	b=xNiI0tJBiex49faO+AWe0zH7EnIObSar04DUY6OhKcKWEDWhpP8RE9S6b20DxjXtFwu6
	 +JZeZxpTInFeJEknZb2QlKCeZ6caqMO+QRjk34xCkSWQ2pRBNIbEkJfPLMXQYi+6cYMKL
	 5GHKF0f0qgpc3qB9dOuU7/BDvocSoL6rBlfQk+IOJVJ/th1vF7t4KLlAHEIwPsztaAtoo
	 ayikPi99Sakmf/4mCmuND2LtonOKKG0BqP6rKRFyNxCTMGoyynu7SFa9ZNAEDjfZ80Hfe
	 ah6Q9lHwTobJyp4ZJmaDd0G7O3tsCSTDTxS7E9w+1YkW6Vw/R+Q4Z44jdZyM5zWD9lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=vAzfAhT2;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13957606EE82;
	Fri,  6 Nov 2026 21:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13957606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=vAzfAhT2
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5triKr4rWQNxHPSUFjuxeCn4xvtnFfYzHmRmVnByAwk=;
	b=vAzfAhT2ifQjmGW+amZ6BcB6Fz40QRShUJXE5+S9b6z+HcRyks+HCN7kZEsxwF57sri++p
	wFm568xmArVEGbbPHZ0MGesOhISUJdqr9deTcTCCXldt4ig/zBQzndDwka73IYS01HlmGf
	miqonh2HztGmhUOeiKdtipCN2Qzg0/8=
Date: Fri, 06 Nov 2026 22:04:20 +0100
Subject: [PATCH 11/15] dt-bindings: iommu: apple,sart: Add t8142
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-11-22f4827b4ece@cyberchaos.dev>
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

The SART IOMMU in the Apple M5 SoC is compatible to "apple,t6000-sart".

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index f79242f112df..e6482453d6da 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -39,6 +39,7 @@ properties:
               - apple,t8122-sart
               - apple,t8132-sart
               - apple,t8140-sart
+              - apple,t8142-sart
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart

-- 
2.56.0

