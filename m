Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999066;
	b=enfHsNgnweBZMtnncEtF3JK94YpbLc3KgQvj7AEJ3rl7HQ82SsLoZtwIihun5AdiS4G2
	 3RV4lqq/mxnehfKTpQykPbnjXsRg/6IevFmoC/UfLs8NwEFWaltSi+JbikTHR3KoEmMjl
	 /HInd1rT2Ne25L5slgyCQsVfBVBsDfq61F5+4Nm/Ipd/6ZjycDCb3s6hJV4MwNwA6hhGa
	 woUQDzcDiIbBkfkTv3Sn5LJKo1fPHkxVRz9OE+dRVQsewlHDO+BTwByZDFR4dcHFNJh0Y
	 3Co35acHDA+rhKKwewePdTO1av0mq9d+oAFKYfJDWwbzqHO1K07vXYYOp66dEYrahYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999066;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=LdUco0IIu2WNvQ3HelRhrLk7d+A8em9tLh77azy1Ojs=;
	b=f1TFNe/13f5UuByuSuhGawHkJlvWnjF2Nt1UnAoYaqxv0GHnn+KzQRni4iOhewUjKJSo
	 Ji1yairUnSl4NHikN+4eQbw9ZA624qctld9dIK38DVIAubchpFMDPKOO1qCUklO2evH4z
	 bRljb2y3QX7c8rnDCyshYUfGVAPx6nfrbaPHw/lfjL4yJ5y6YBbneU/w+b/28Uwkv1Up5
	 DjYnfmEDcluap9CxkwBrz2wsH44PWWxeGOHqh8cDsc/Q67dXVmgya+MC/9xz5bq/ebhkV
	 Dx6L/8nnG5p0Bc3NhSaNFdHIL96o+rRuPlHrbiuEbZmdegrDQYkCu0jb2RGxITwa+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=p+fE5CBk;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF1606D801;
	Fri,  6 Nov 2026 21:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4DF1606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=p+fE5CBk
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdUco0IIu2WNvQ3HelRhrLk7d+A8em9tLh77azy1Ojs=;
	b=p+fE5CBkiybwX3xjTAfsxh2AJzYlxQQ+I0ripjHdQey8ogzQCsJG+9MRMoAA0H4Pm0LXxD
	YLEsBX6tCJZeS3ggeMWF1xagFdu+ncq1PyB2ZQ10VjITwhZCW3NjQ2M2nErQMBq3V+cqAZ
	2dcjQSrRQ5BPFQDkRS5yMtXpSUmExeQ=
Date: Fri, 06 Nov 2026 22:04:12 +0100
Subject: [PATCH 03/15] dt-bindings: nvme: apple: Add apple,t8142-nvme-ans2
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-3-22f4827b4ece@cyberchaos.dev>
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

"apple,t8142-nvme-ans2" on the Apple M5 SoC is compatible with
"apple,t8132-nvme-ans2" so add its per-SoC compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index 24c2be3b9544..b8b779f050bc 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - enum:
               - apple,t8140-nvme-ans2
+              - apple,t8142-nvme-ans2
               - apple,t6041-nvme-ans2
           - const: apple,t8132-nvme-ans2
       - items:

-- 
2.56.0

