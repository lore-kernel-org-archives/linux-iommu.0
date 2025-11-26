Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48823313542
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146098; cv=none; b=BF9hRrOThEUb1BtZ0J6/cwFhwP6Cr3qLcexKpRS2N/NYmqfyWJEjhEejOdC5lYsFVToeVbN/FMNbkTrWcll+h1L/UYqEZgDno1bJZ9HfPZ08WFjeCkI823ue59U+/Kryj6PMo7CBQlX9CulYJTsuWVt4qLe4FqqMh9C+Xdv63S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146098; c=relaxed/simple;
	bh=dr4SOm92jHcnGXQ/thNFLXAMyQSt3snfzz493W109ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iQCyICI/dRO9x2zWriteTq3X2omz9GlNERluvTGXkmGZ8en/nsMNNt+buxWYlJ13jhUYWLcb1FFUYVYYk/dMsGrVsmcAkQHznhU8eCFagkGMy8TnJz58aZCwtEQNZ0Hp1ZvtFicnxiVnnvXPVoNuKqkTs8Og7y4Ud51vV0tsH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=cmZAmiYd; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="cmZAmiYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1764146042;
	bh=lW1MabH8TwyvbabLyjolWKrj+twdSqiGH4BPvNSLuws=;
	h=From:To:Subject:Date:Message-Id;
	b=cmZAmiYdgkZ0t0LFMAoENMuyc7GJVG8+HxxG2lkqM69RPyDPjahXyab/kuY5BYWwL
	 35r+tfZb48ELh2Hw0CXf4bW/QleL262SiLD/kqf47dsc6rffSbVbsbbDHQyA9hrm3P
	 U3VUkCHvoXFlDJVsn9mLPd1wYSWmJTvukjPLJi3o=
X-QQ-mid: zesmtpgz4t1764146033t0aba92f9
X-QQ-Originating-IP: bmKFoRbntIb+LrnhcHZ68Pi2yQdiUGGadX6Gt3Q2ucY=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:33:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18429734964785922997
From: Chaoyi Chen <kernel@airkyi.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 1/2] dt-bindings: iommu: rockchip: Add support for multiple interface clocks
Date: Wed, 26 Nov 2025 16:33:44 +0800
Message-Id: <20251126083345.88-2-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251126083345.88-1-kernel@airkyi.com>
References: <20251126083345.88-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OUC5DGN0mB58EiYTCXLwCx4O6Mt2SNu9yYmtvI/GNU6dmKmYVAG44rvI
	APUIwVqZbLikZD1oUnGUuMFMvtDvdt2+nhXc8G+tbkgp3uxDs+zoEKwRlAccI4yXE5jHg+8
	hkF8WLgf3vzPiVRgvqDy7Dh4li6Fiulj9XACDqvNLHmPTsYyFafpvk8fnlYbUipQHi3Q7j6
	+fIkQF4DvDbMGr5Irep/GCIDbL5ZwDnNt36q7uPMj1Cwa9NHuDq1vapLKwIhfPIU9LDYR2E
	93zs5yoNHF1Fb18UzTYkIFyU5NsU4HvaiPXR3MnkTM9PQgiJ7BPLMbEwrFakB9BpIkQ+fWC
	XYrDDkWub1S2AE4bJWl4xmL6UgjZUiDtrBrc6f1i2HwpRLquXUupBhGWrzFe/X4PUBxoeV6
	HgavrR1WSO4HheBsnuyIYkZuiNgQNYCZK0nq5IYjLdp7041syLSNSVARLFaRobviut7OEiP
	JKATcAHh7Maqmdm+ToWb2/X5cW9FKWDrK+BvOtwv0Hk6nm5y8JXzJuhJQRNt2mhaB/3FNKL
	HXrWW1LI1kphB7H1z9JcAIrZkP6veYgpd4B9vDm7AI73bvf4UCDXl0whWax6OFwFIrilAtA
	oaI47R/38pcDR9qEmC3/0n509ROYs5VjgoKxoaVoqm32qMCslN+VX23GozGwvedgGZzh5A1
	cKesyFR1obi/d41vuGS8qxhVkQAQyb1lFDlQR6JoauwXAsruE7ochikUGsYEVcgfxAePMz6
	QN4ucblvLBxjy1oH1HfKePvw5MY79I/y/rvGtSs38ijcj43Qfx+Ac1iZ+uyYAbJTIioIHLD
	5g7ulcgiuAqDuEn3LQA8OynxA+WsPpsiUM/oSyzLrdLoyJ3QXxz/xgm0/OIN33tF1JlKYcN
	ZSFfh/i/oiPSNuQYHp+ZC2BQS8GliJw1nqyQyFxtgVD62XWS78CbH9FQHgfIh5Uafs9vZMt
	2x9OVuWg8q3T88hsSfbSAR2u0AGRaFIFOQAKU2lQs6BwrHA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The iommu found on RK3576 NPU/RKVDEC may contains more than one
interface clock.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 .../devicetree/bindings/iommu/rockchip,iommu.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11ff5e..11cc22a0b1d3 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -42,14 +42,22 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Interface clock 1
+      - description: Interface clock 2
+      - description: Interface clock 3
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - const: iface
+      - const: iface_1
+      - const: iface_2
+      - const: iface_3
 
   "#iommu-cells":
     const: 0
-- 
2.51.1

