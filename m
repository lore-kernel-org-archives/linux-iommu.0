Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999068;
	b=cBG0r8J1ej/ieq64TEEPoUmGWmYsfQimr8LoAqp+CvqtXvbLhT76wLYP8Vwv+2c/uudE
	 Si9WK9i2tYkB/qY0iQC5gnDKf21zRYEL2ugSL3Xn+0ijpk6vopXbCrF17R+LgiTOGO9DT
	 U8Tnor/4B+mrpv0umqefiZfesLckGPlkT8IZpMfpJazbUb3ZoSnaR6veTdRDs0Bx8vx8G
	 Gt+UQ/gXHMxQlJo07IFC1tsiTfOthVdWjKJTKldlA48i0fBd0x3FPYyvJcLw3rydFQD1z
	 9HGvD2C8kJnZSXYYyEoRzx7s3LfPkrCr90PhaSD3sp3yiepMaHGjyyX0lNc6tI2S3fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999068;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=2Yj9uXfNvECITTH5PNv2goHZJzdSLFM4IX9SvvHkH7M=;
	b=lJaDWejdIoWX5K5No6NrtPbrTQJKOuGK+HEZRDqdZFJoYam/z8uVFjEtdtEyPRKwwguP
	 Qfwk7kxE3WXh//GkmD3UNwsNVB3R2W7QEcPIBdZYY4NEjpZ6R1kGewMrSuEkhmkCg+/sB
	 DjF6zrZ/nE0/WK3jfBkQRfw/50wCWDuSMcL84uqZ3j2VQpxXx7dG7obs2wSHSXpj1tHpg
	 KyL9XSTpNQcumBll23S5MUcbF1iCfRYHcnELVpdduxPr+WwWxN71inZ1vJnDVKL4B9aeF
	 RZt+WVMTMTVuuFN+uuhJJWUA7/Zw3l+bgXtGR5L6/Qz72DSQhvHRbUE9SUSqE8Y/WbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=B3piowaU;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDD606D80D;
	Fri,  6 Nov 2026 21:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DDD606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=B3piowaU
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Yj9uXfNvECITTH5PNv2goHZJzdSLFM4IX9SvvHkH7M=;
	b=B3piowaURxduETghUwcykSW590YjNnVPogiryIvOuogOzl2H8qnjedDPuCT7ERURfM3D9P
	O2ld6EqIq+SmIqdOTrK9600Xt/tz4NxUpfUsUAfCYs1Gh1VLlkIUOp+usTVNXfVAVyxzl/
	0Bo99Clcqr/6KCsctIvFfRu5t1Zlwk8=
Date: Fri, 06 Nov 2026 22:04:14 +0100
Subject: [PATCH 05/15] dt-bindings: mailbox: apple,mailbox: Add t8140
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-5-22f4827b4ece@cyberchaos.dev>
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

The mailbox hardware remains unchanged on A18 Pro SoC so just add its
per-SoC compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index e870003d6cfd..774f63f0839e 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -32,6 +32,7 @@ properties:
               - apple,t8112-asc-mailbox
               - apple,t8122-asc-mailbox
               - apple,t8132-asc-mailbox
+              - apple,t8140-asc-mailbox
               - apple,t6000-asc-mailbox
               - apple,t6020-asc-mailbox
               - apple,t6030-asc-mailbox

-- 
2.56.0

