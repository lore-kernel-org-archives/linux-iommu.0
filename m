Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67535625
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 09:06:35 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4MH1dP4SC3z4x08X
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 11:06:33 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.186.194])
	by michel.telenet-ops.be with bizsmtp
	id Dl6N2800C4C55Sk06l6Nko; Tue, 30 Aug 2022 11:06:26 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1oSxCP-003FId-PP; Tue, 30 Aug 2022 11:06:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1oSxCO-001yk5-W0; Tue, 30 Aug 2022 11:06:21 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3] dt-bindings: iommu: renesas,ipmmu-vmsa: R-Car V3U is R-Car Gen4
Date: Tue, 30 Aug 2022 11:06:19 +0200
Message-ID: <36400fe2cc6b6dcc0d6984fb77338d4d163e84dc.1661849638.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220830090619.rhEKnRvRsYjufNFOl2QBQQ85TcPi2uMtaFvj3dNRbDc@z>

Despite the name, R-Car V3U is the first member of the R-Car Gen4
family.  Hence move its compatible value to the R-Car Gen4 section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
v3:
  - Add Reviewed-by,

v2:
  - Add Acked-by, Reviewed-by,
  - Add blank lines to improve readability.
---
 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml       | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 8854569ca3a6c949..26d0a5121f02a153 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -29,6 +29,7 @@ properties:
               - renesas,ipmmu-r8a7793  # R-Car M2-N
               - renesas,ipmmu-r8a7794  # R-Car E2
           - const: renesas,ipmmu-vmsa  # R-Mobile APE6 or R-Car Gen2 or RZ/G1
+
       - items:
           - enum:
               - renesas,ipmmu-r8a774a1 # RZ/G2M
@@ -43,10 +44,11 @@ properties:
               - renesas,ipmmu-r8a77980 # R-Car V3H
               - renesas,ipmmu-r8a77990 # R-Car E3
               - renesas,ipmmu-r8a77995 # R-Car D3
-              - renesas,ipmmu-r8a779a0 # R-Car V3U
+
       - items:
           - enum:
-              - renesas,ipmmu-r8a779f0 # R-Car S4-8
+              - renesas,ipmmu-r8a779a0           # R-Car V3U
+              - renesas,ipmmu-r8a779f0           # R-Car S4-8
           - const: renesas,rcar-gen4-ipmmu-vmsa  # R-Car Gen4
 
   reg:
-- 
2.25.1

