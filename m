Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A933232;
	Sat, 28 Jan 2023 11:11:33 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 909FC3200645;
	Sat, 28 Jan 2023 06:11:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 28 Jan 2023 06:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1674904291; x=
	1674990691; bh=Kk810rg+RVOB5XK0ZliSwtvtlzIioFE7/7PlCxDb0yo=; b=B
	Zs0REhpeGi4qAgvF6M6jxcZnfiWEABCXp03lhPKPgJkEbrADRSn+UyrdT6oScv9M
	wb8LgaWVgpalFa4HFICIJZuWjqeE++0OQGbbzIuLASByVVJKHpq6E1cPJ42Z/ib0
	G4nnEDLj+ysAxf3Bd9t/8wE+0ABHjuf3HcNXDWX8/Ti3qzd913RpxLILujCTTGnQ
	bAQgxhAXoMKHT4c6n+C5JdNsfRW7Dlll3BO9ZRj94Cb2gKUoVXjSTf+ySrs6YYYF
	4pcixC3LrpcNZqL3cBnRjVBJo1x/4BOnm7M440EhuyX6bn1DSmUL3z3KZNEM+/Dn
	QCmZ0ZfdTEC48yTlHCcZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1674904291; x=1674990691; bh=Kk810rg+RVOB5
	XK0ZliSwtvtlzIioFE7/7PlCxDb0yo=; b=nsfXtrfLzur4tjURrL3Hnf5V90fMq
	/G3PtcWdvN2frV/qb0+XbtkqIi3DhcMRls7MLzQAUA8+YZ+jQr75ZOLJYkjVBf0/
	zHJlkNcRcrJOzZdmoJ2V9vOfGf+yCCjIEpD7uK4BGodIEqEUA58YpzJa2OOjus9A
	NugYi+On2f77w4FH/WF9dQVa63jCYbzGCbanrW7h6euJmtzD4iRY6596Rxe7l1HL
	3a0ljOcQnlWUKPXRJjpTv7crJ1lxNcyw9CwOJ4enbH7Ms6qVlIZV19NNKrte0KLZ
	o7Xi50+CpDLl3/mMNXMKG2f9ZOX1I+wQ1qayE6PBSTvs9Wu24LmgtA38g==
X-ME-Sender: <xms:4gLVY_wGgoq4W_I6gS2j2RmqycFv54_aG5ZYp8kxj9aj2_NA4rLtRA>
    <xme:4gLVY3R96Qs4BQbZoHPB0AMRXvvmY_rVXysbNIQMZkLMHRSIgPOf713gaDYhfzNsk
    2exydzV-P9gKrhWe6A>
X-ME-Received: <xmr:4gLVY5X6cA-kGlGcAGz1dZ8RJnvGhhJRg_-ycBk67RGB6nAtOilBGL0gz9R6FMz0axpENyrGUq_1dqHH-Ma_xZ-tg7yPy5lN7xyCi_ytfmuD0W9nFqo2rvivPAJeog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:4gLVY5j7e5D5KvYy4WIefukhMf372nTAnM8S5UqvwH7a-_N4CzVg0A>
    <xmx:4gLVYxB0OOXKZk7KP6FIrAkbkFuu3Jop7tjaVmHaKFfoJxOk4hD4Lg>
    <xmx:4gLVYyJn9rAPcjHs4b6PDPxN5Rn7OiNZzwVkQhj3tSFD2v7kBVa0uw>
    <xmx:4wLVY2KGXJWrtt1f-_PWpjR8d7lUGa1aiSX0plFNJRt9C96e3BT6Pg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 06:11:28 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
Date: Sat, 28 Jan 2023 12:11:11 +0100
Message-Id: <20230128111114.4049-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230128111114.4049-1-sven@svenpeter.dev>
References: <20230128111114.4049-1-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This DART variant is found in the t8103 (M1) SoCs and used for the
USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
up to 64 SIDs and require a slightly different MMIO layout. This variant
is only found on the M1 SoCs.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 903edf85d72e..f9c1843c074d 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - apple,t8103-dart
+      - apple,t8103-dart-usb4
       - apple,t8110-dart
       - apple,t6000-dart
 
-- 
2.25.1

