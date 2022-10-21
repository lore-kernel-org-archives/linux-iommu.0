Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BED20E1
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 14:13:23 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4Mv5qD3Bw6z4x0Zt
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:06:16 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:8c7:6dd8:b0ce:eea6])
	by laurent.telenet-ops.be with bizsmtp
	id ae652800b5BCT2h01e65J9; Fri, 21 Oct 2022 16:06:09 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1olsey-000etQ-Nv; Fri, 21 Oct 2022 16:06:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
	(envelope-from <geert@linux-m68k.org>)
	id 1olsey-001L2g-7S; Fri, 21 Oct 2022 16:06:04 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Joerg Roedel <jroedel@suse.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 resend] dt-bindings: iommu: renesas,ipmmu-vmsa: R-Car V3U is R-Car Gen4
Date: Fri, 21 Oct 2022 16:06:02 +0200
Message-Id: <c1fb71448a8400986fd30d51a1bb2704376c0306.1666361055.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

