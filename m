Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999066;
	b=FnykSrig+7AS2tXiixXB8rufFl5fMzoVx/EHK9AGW0+n1kTvwLRTL1pUcu+LFzSws9r8
	 I4jkU6URgcufJ6V1JouOdHIzkuQU0kgtCdmkRFbuAgJrT55QAX2Vv97Bcf+2wUy2SZPcD
	 Wp//FPm47k5mZtnvFVf8n0+Ai0MBGzi8YAXLi4z+u5ktNqohK5SObluBeNwotnbgSrNTg
	 7Xftb5EBsvkNrqHKHmM1zQvKlIzdMalzLK0y1SFyuFBGJzkc1kseGvUySsJDxxLbG40Xk
	 wzbrhLsydiqK12bfDEkhExFFo+qH3Z8WmnHs2vKclMV4TQJ18lgu8d5t5zkKBkwwkTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999066;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=vm1P29Q9pGIVuMvApDwWtOHri36Bhi1asrJ/ETI2sEA=;
	b=04i8/KBTLY9/GpKK6WhSt964D7dGTSEQQd9+wErQCCV2GtiqY0RDJtLUDpyhjpQuL8C+
	 oDTmqDAs7xQSUPHUMpVPbr4dkKfFG49XTTXvlzg1UD2yvvaO1Jt0G6VkwinfmHWD+ulop
	 s2AHibWxMP4I3nvOstG2meMcQnlRzopLlgXqPPpurd5qSo0sodZ8PaEBvqa3t1K4SmFNf
	 Xfb9ZD5hsE/lkPADNDg8lUauk8Qk6MV7ZeC5Vvb7eGqeYfK99WiJk3XM1+NhIFNqLU0B4
	 mWcZmK/6iVyWQO5uFdiCFuDLtd/Xok4sAw5LmZNUCT5HRoDiKKCWLBjQipuef/54vdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=mKzXtMPg;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C30606A339;
	Fri,  6 Nov 2026 21:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C30606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=mKzXtMPg
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vm1P29Q9pGIVuMvApDwWtOHri36Bhi1asrJ/ETI2sEA=;
	b=mKzXtMPgtwT9JeGa8yf26RcZBkyDWsxcqmktl5FZMfFmOoebEWNzqP3OIq7NGPFQgK8X+r
	4C3k4+Mi8GwMaltwSSFH3ik9mTxPcHX8LJZp0eT8fETfWCmQUpbcrTdIpV40F74yr+yAii
	BMPUrTwc633PDwFz8LK4/KACwpkMqIc=
Date: Fri, 06 Nov 2026 22:04:11 +0100
Subject: [PATCH 02/15] dt-bindings: nvme: apple: Add apple,t6041-nvme-ans2
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-2-22f4827b4ece@cyberchaos.dev>
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

"apple,t6041-nvme-ans2" on the Apple M4 Pro/Max SoCs is compatible with
"apple,t8132-nvme-ans2" so add the per-SoC compatible.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index da260cb5597b..24c2be3b9544 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -22,7 +22,9 @@ properties:
           - const: apple,t8103-nvme-ans2
       - const: apple,t8132-nvme-ans2
       - items:
-          - const: apple,t8140-nvme-ans2
+          - enum:
+              - apple,t8140-nvme-ans2
+              - apple,t6041-nvme-ans2
           - const: apple,t8132-nvme-ans2
       - items:
           - enum:
@@ -84,6 +86,7 @@ if:
           - apple,t6000-nvme-ans2
           - apple,t6020-nvme-ans2
           - apple,t6031-nvme-ans2
+          - apple,t6041-nvme-ans2
 then:
   properties:
     power-domains:

-- 
2.56.0

