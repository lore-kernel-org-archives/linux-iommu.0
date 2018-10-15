From: <hannah@marvell.com>
Subject: [PATCH 3/4] dt-bindings: iommu/arm,
 smmu: add compatible string for Marvell
Date: Mon, 15 Oct 2018 15:00:45 +0300
Message-ID: <1539604846-21151-4-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, corbet@lwn.net, joro@8bytes.org, robh+dt@kernel.org, gregory.clement@bootlin.com, mark.rutland@arm.com, jason@lakedaemon.net, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, robin.murphy@arm.com
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Hanna Hawa <hannah@marvell.com>, omrii@marvell.com, linux-kernel@vger.kernel.org, nadavh@marvell.com, iommu@lists.linux-foundation.org, thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Hanna Hawa <hannah@marvell.com>

Add specific compatible string for Marvell usage due errata of
accessing 64bit registers of ARM SMMU, in AP806.

AP806 SOC use the generic ARM-MMU500, and there's no specific
implementation of Marvell, this compatible is used for errata only.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce..92d7263 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -16,6 +16,7 @@ conditions.
                         "arm,mmu-400"
                         "arm,mmu-401"
                         "arm,mmu-500"
+                        "marvell,mmu-500"
                         "cavium,smmu-v2"
 
                   depending on the particular implementation and/or the
-- 
1.9.1
