Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999065;
	b=A9sX551O3NoeCuSuEUCyoI/6K636ZQo8hVtBsM/aMhrxfoiF5CzqarcG/Q9/668dXBVR
	 3DyuX+gRbiARZPuwxWttS8/wq7xaDIvOVcs9JI826RnoBBkfqxUIl8khu7YQsFqsGKwrL
	 uD7MGU478XzdtzloJ8sGEZ/63ZWz5FJ2nFEe17HLuy+7fCi4usemYDmkr+8KkiEZJRRMl
	 mqGq5ZCUP0/l6R4gVeHCIUHgLV28Bp0Ojt/v9fmhNaq/6Q6ygCvvagSP9JCoDHL/R1eBC
	 MZi8MeYG8OOljSFwInzWzltZ3dUpa8QzDlLvIqqdhiJpnx+n00/4CTsIwCsUGIklynA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999065;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=5R/XA924hf2/hl4m2jUdl12V8Kzuk7tpWfB2UcZ103k=;
	b=x2+LlJVGUvBzMCXEMe/liKQE/Ks9p/ws4tj5Meoe+jvQjiK3k0ldLXO+vuiBAJ7KGini
	 rimRIhm4ULLjFhTWOC+Ombcjo/Q8MS0tI19Ejm1JQljPjeeo28mgoR1bbxpQxcULsyazo
	 gMoyAHBPHQq9mRwaUYPTiRUFa+CbErgyUSAitGZ/qu+ANZ+qHEW0O1zY6aGGJ2ddLpsNr
	 bRvw6bu3pde+U2QKLKKm6IF/yu3/okl3NiXQ68mlFhgRjxTkH0B9LkzddyknlroRh4LU0
	 WLMiEV8OYnOyeT5H/qrLoC2yYLdGkhgqEsiu1b9eonMBOqKNfQKMWRm0wauzIsjj1sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=0ZdDc77E;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2D606A32C;
	Fri,  6 Nov 2026 21:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA2D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=0ZdDc77E
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5R/XA924hf2/hl4m2jUdl12V8Kzuk7tpWfB2UcZ103k=;
	b=0ZdDc77EQBpfMoPZnUC8Ssfx/XcokVPqcAkCOlzofP7BDD/otd752MbmKcoWDyBxg9Z0W/
	T0b99hoNYGMD4TzJPWkfa5vABHvF7YfHUVnPUZdeQ5UtjL5is2SQznTcp1o08yjZwTm0/F
	k7Qm876oF5g182D0vhmqz++uOs2hMRU=
Date: Fri, 06 Nov 2026 22:04:10 +0100
Subject: [PATCH 01/15] dt-bindings: nvme: apple: Add apple,t8140-nvme-ans2
 compatible
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-1-22f4827b4ece@cyberchaos.dev>
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

"apple,t8140-nvme-ans2" on the Apple A18 Pro SoC is compatible
with "apple,t8132-nvme-ans2" so add its per-SoC compatible.
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index 1179667d8723..da260cb5597b 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -21,6 +21,9 @@ properties:
               - apple,t8122-nvme-ans2
           - const: apple,t8103-nvme-ans2
       - const: apple,t8132-nvme-ans2
+      - items:
+          - const: apple,t8140-nvme-ans2
+          - const: apple,t8132-nvme-ans2
       - items:
           - enum:
               # Do not add additional SoC to this list.

-- 
2.56.0

