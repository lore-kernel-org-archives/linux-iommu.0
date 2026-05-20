Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70727B32C;
	Wed, 20 May 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258194; cv=none; b=RhmFSizyMkPXDS8IsOvCSZoJvwNlnhKH0wRPOGf0cV3fq5f0Kv/GFMmRC88kV9VM0t3gkiZN5UtrWe0lRWXYVh5wfE30sEXmLtIUgA+8bGb4tIx1+pTIIYbfL1nn3XL0ExJisl1EsPUwjmRX/rLWnyvb3RO/9Ec4JEdkLp0e/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258194; c=relaxed/simple;
	bh=zKtZBs4+DNKlTJleTEkfKxS92FfxfBpi6JQq3Do+za4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jr/s0UL7E5p0Zi/CY/u0h3OteM9B4REoziBy0mD8knnyoA3GYmgY1AWPdhL1dBfMn+fU57e+QDAGQgSbx7Ai1LaaPDFi0qcAsA8lx/iuHnur7BQiZZKqKyiqyREJzwJXAylzNg+z5T/ptv57+Zf6GtHQRMuSNqkm4wrnF7VA1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BawfeZcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BawfeZcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D91F000E9;
	Wed, 20 May 2026 06:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258193;
	bh=OE2c8bPw7nhkBWpehAwsa5TVWWPe81JyALMv/ywT5ls=;
	h=From:To:Cc:Subject:Date;
	b=BawfeZcwx/l62q4AD+Bv9vp+17T1tfp7BSedNUh6JNX99A9lD+yUu3UI8Ek2m9sWa
	 dBlToWhOXyN1uYRA5a3JUBw9crZ8V7/x8kkuqcZMIaYyVmkeN0YbBk8G04x0Ri+aTV
	 JknkdWXDPCPH89ucQBAEyA2ZlxYtNNRfcw8A+Xp0tyGVyzEOhHk3Z99trgUtdZLCa3
	 rQi7DGzZYsWVOcT5w/qN+RJPMo/lbcNlUq2RDPlCGbvpSbKtGvpUZ0bm4TuY/xVgsS
	 H9cr8jVTfKLX/2jt5g1+ZvXBGaALxrHWvBiklSIV3GVrOsJMA8zVS3PICaNTnG3nIK
	 4OknLK6HZbCdA==
From: Drew Fustini <fustini@kernel.org>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2] dt-bindings: iommu: riscv: Add bindings for Tenstorrent RISC-V IOMMU
Date: Tue, 19 May 2026 23:16:28 -0700
Message-ID: <20260520061855.1623468-4-fustini@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

Extend the binding to cover details specific to the Tenstorrent RISC-V
IOMMU. In particular, a second register range is added which contains
M-privileged registers, e.g., PMAs and PMPs.

The RISC-V spec S-privileged registers remain in the first register
range and are compatible with "riscv,iommu" so the Linux driver does not
notice any difference, but the binding will be used by OpenSBI and
potentially other M-mode software.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Acked-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[fustini: fix dt_binding_check errors]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
v2 changes:
- Fix dt_binding_check errors
- Add the Acked-by: from Joerg
- Drop RFC prefix

Link to v1:
https://lore.kernel.org/lkml/20260310003850.3837030-1-npiggin@gmail.com/

 .../bindings/iommu/riscv,iommu.yaml           | 62 ++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
index d4838c3b3741..5aad8cf67840 100644
--- a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -32,22 +32,35 @@ properties:
   # should be specified along with 'reg' property providing MMIO location.
   compatible:
     oneOf:
-      - items:
+      - description: Platform (non-PCIe) IOMMU implementations
+        items:
           - enum:
               - qemu,riscv-iommu
           - const: riscv,iommu
-      - items:
+      - description: PCIe IOMMU implementations
+        items:
           - enum:
               - pci1efd,edf1
           - const: riscv,pci-iommu
+      - description: Tenstorrent IOMMUs implementing "riscv,iommu"
+        items:
+          - enum:
+              - tenstorrent,riscv-iommu
+          - const: riscv,iommu
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
     description:
-      For non-PCI devices this represents base address and size of for the
-      IOMMU memory mapped registers interface.
-      For PCI IOMMU hardware implementation this should represent an address
-      of the IOMMU, as defined in the PCI Bus Binding reference.
+      For non-PCI devices the first item represents base address and size of
+      for the IOMMU memory mapped registers interface.
+      For PCI IOMMU hardware implementation the first item should represent
+      an address of the IOMMU, as defined in the PCI Bus Binding reference.
+
+  reg-names:
+    items:
+      - const: base
+      - const: machine
 
   '#iommu-cells':
     const: 1
@@ -75,6 +88,31 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tenstorrent,riscv-iommu
+    then:
+      properties:
+        reg:
+          items:
+            - description: IOMMU base registers
+            - description: Tenstorrent IOMMU machine mode registers.
+        reg-names:
+          items:
+            - const: base
+            - const: machine
+              description:
+                Region containing platform specific MMRs for machine-mode
+                configuration, such as PMA and PMP registers.
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
 examples:
   - |+
     /* Example 1 (IOMMU device with wired interrupts) */
@@ -145,3 +183,13 @@ examples:
             };
         };
     };
+
+  - |+
+    /* Example 5 (Tenstorrent IOMMU device with MSIs) */
+    iommu5: iommu@d2020000 {
+        compatible = "tenstorrent,riscv-iommu", "riscv,iommu";
+        reg = <0xd2020000 0x10000 0xaa000000 0x10000>;
+        reg-names = "base", "machine";
+        msi-parent = <&imsics_smode>;
+        #iommu-cells = <1>;
+    };
-- 
2.43.0

