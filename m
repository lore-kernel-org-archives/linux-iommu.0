Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999070;
	b=UY1hZsvKHBlIpI1YoUoJIepLEr1Ja4Cc1Q5Yu0lt0L1BwWsMMtm+wIG2s0X/A96uOrC3
	 SJgz33XSqlnufu/8Kvky4K6JRRI4SkY5zGi8kBiJDdhlCmZbwDsxosWO4hML4aHRkW7Ql
	 oCBzLS2e60T7ElnICk6JU302TpHBkuCdsn0bNI0CIhoQ/pfXUqwAigeqttsYjpfYf151q
	 T2kaVozVmatNUD7UF/+67lXvznT/rNRnaieiUta+YzERwnYNdcwVMuvVGdYtodlxzHkVb
	 wnb8vsHyeliKsHbhbcrQlo/BHYlakDkyTWnTXaqeErcTHkdP7K61+vu0JUgE+7lU+8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999070;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=xvD/KLvtYEzoiFwqKbyo0GkTrcq4CLL7Gr2fpgfmDIY=;
	b=uQW7PjPJNkfoxz8aX+cCjZ7/4saVN6fMVE8tkqsVk9ctWo3lQqmLVmVcLULSgTS+AS1e
	 kJP/hgtaeOtYyNKZi4o+uvpoo38g+VyrlsSvvAxNNnGLjZu6dwQ0cgcKTNR9JMa+al5HP
	 3VDSt3XCqdcsZcAyzO7X6lqokXyYilorpeT/X2H+cWkbobkRPlzGfNMNwKgEns+HKSbJu
	 B/Apks+v8JvY7VHOao2w8vRUkFBz5vGAma/eNRrtPexJw1JJhFU36FV0vCslfcyawzNby
	 nlmuP9aNUGweHe6v8SU0TdF5TxUOt023YQhKupuMiUYN2gpNVJK3QBQY0V874f2xOGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=fXlXlhX5;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2F606D814;
	Fri,  6 Nov 2026 21:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F2F606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=fXlXlhX5
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvD/KLvtYEzoiFwqKbyo0GkTrcq4CLL7Gr2fpgfmDIY=;
	b=fXlXlhX5bD5LtjHsCI5pubLHLhPoYX3jc50h1blHQ4cGmSsmQteeJgBptsLQYrJlmcVvUk
	sJkHbvyDEV1wdgwvlfZnPS6HeikihFK48KbsXWi83DndvJfK41ufwSl28Ls/hylrZGD4AW
	8ZwSDknTuitCE2rRVagcYVRaxEDTxOo=
Date: Fri, 06 Nov 2026 22:04:16 +0100
Subject: [PATCH 07/15] dt-bindings: mailbox: apple,mailbox: Add t8142
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-7-22f4827b4ece@cyberchaos.dev>
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

The mailbox hardware remains unchanged on M5 SoC so just add its per-SoC
compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 1fb943e0b587..dd1f0bc1830a 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -33,6 +33,7 @@ properties:
               - apple,t8122-asc-mailbox
               - apple,t8132-asc-mailbox
               - apple,t8140-asc-mailbox
+              - apple,t8142-asc-mailbox
               - apple,t6000-asc-mailbox
               - apple,t6020-asc-mailbox
               - apple,t6030-asc-mailbox

-- 
2.56.0

