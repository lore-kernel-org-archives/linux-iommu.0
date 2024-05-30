Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90E186287;
	Thu, 30 May 2024 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112376; cv=none; b=E+I07+i2LFcq10WeNMoV97PsL00gaZzP/D5CH+HSvYinYXobaDQOaRqQekCtsV+hnePFRxICF+KVciuQKBB7N1qTYFrtYJCSXWTELqFq7iw9U8DH7+QiMb0ISwTlvbI8i2wbCAlFF017tCQRsiXz4MBJBtv3gFvo3SB/b0E4SRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112376; c=relaxed/simple;
	bh=qJcReu0KyKO9dd0p82AbmhSJuFTuEkgkOWAHVz4oZn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTy5BlNv4DMdz2puaDB7zQ3WTU8HaL4zE05sZB21tQ7KMMSGx7F175Yv/QJ6l9Lc0Qnwl1tDaM2Rn9irqUmQaYpJpkeOgQc9pi6gByYBEQEoEzZAEw7AkkIZE3sNYV2qXkaYGqyGvREukyLo3yKQ3fhf2mRjNnc6glk/2iLHfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C021682;
	Thu, 30 May 2024 16:39:58 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527A13F792;
	Thu, 30 May 2024 16:39:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] dt-bindings: iommu: add new compatible strings
Date: Fri, 31 May 2024 00:37:58 +0100
Message-Id: <20240530233800.27705-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240530233800.27705-1-andre.przywara@arm.com>
References: <20240530233800.27705-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 and A523 contain IOMMU IP very similar to the H6, but
use a different reset value for the bypass register, which makes them
strictly speaking incompatible.

Add a new compatible string for the H616, and a version for the A523,
falling back to the H616.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml          | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
index e20016f120175..a8409db4a3e3d 100644
--- a/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
@@ -17,7 +17,12 @@ properties:
       The content of the cell is the master ID.
 
   compatible:
-    const: allwinner,sun50i-h6-iommu
+    oneOf:
+      - const: allwinner,sun50i-h6-iommu
+      - const: allwinner,sun50i-h616-iommu
+      - items:
+          - const: allwinner,sun55i-a523-iommu
+          - const: allwinner,sun50i-h616-iommu
 
   reg:
     maxItems: 1
-- 
2.35.8

