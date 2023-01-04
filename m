Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F026810;
	Wed,  4 Jan 2023 11:01:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 89C5542037;
	Wed,  4 Jan 2023 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672830106; bh=GdWdary42rt3mIkDwajxrH/Zj4xVB5+w3NY679JEZNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpTG2zka6CyNNKdpuL96OZZMwFf+8/kOeBsENWCen3o9tmx+DtysRWubM674vQwa/
	 cMoO7nYy4W2gVwTambsC7COw/wWtVfFbiusGfzZjoPCjOcaBkHx3a/nGRBBYYwQ78y
	 xB0xknw+S9LHv7Ey41ZPjgXdO4XdmPFm2Q5ZfWtkEy5djNkqi5PzHdazkbQBSX/X6X
	 P1xZhSZh2qlmkWMJxYjgN5lXH/3HUiHeIcjeErStGz48Wrr3U4pxf+YTzuhdsFiM6R
	 FHiUs1ffSdhk5dmU4+FythUAs/b0QovHHeFnyCXGCXNhTWYJU2hpWss3Gt9njs5GZ2
	 GFEv0xOdnnseg==
From: Hector Martin <marcan@marcan.st>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH 1/7] dt-bindings: iommu: dart: add t8110 compatible
Date: Wed,  4 Jan 2023 20:00:07 +0900
Message-Id: <20230104110013.24738-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104110013.24738-1-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t600x SoCs use this DART style for the Thunderbolt ports, and t8112 SoCs
use them everywhere. Add a compatible for it. No other binding changes
necessary.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 06af2bacbe97..903edf85d72e 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - apple,t8103-dart
+      - apple,t8110-dart
       - apple,t6000-dart
 
   reg:
-- 
2.35.1

