Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CE199EA6
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507363; cv=none; b=FIUaNmCNv4+5kpWrBJvbqr1ynS1rBgXSj0VmbepWQ+n/i+4qtVlWywAs+a8lSInmdR2mZw40AvF8FOXpZQQbhOWpmL/GSqgch8HzuE/qGSOuff65IuWzVF2gSm3CBRMhwrTJxevwwNZFk5c97eba4a41Qcxc2XbWHjqICVw87Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507363; c=relaxed/simple;
	bh=1EDa52wR7vW6R1hrhW9vs4jIkIJbYACFzLKkb2vfpyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PM8csGUuzWTOjTiMZKMs2nercpsl5qpLTcdxL7yyD4LS5N6CLxrx+Lvl7X0zz8aW5ZFRzPjlTDB9yq/ZOv+axCLiU1iRvkPxRKZXlDiQaat6O6ZelN6acKNOZEH+c57jgSjMcamQIg9exWgvlmNkxnKdsK8QQk2W9Mak9pU+zEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BWD8hDoK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BWD8hDoK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4f341330fso57020185ad.0
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714507360; x=1715112160; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woNMMspCQ7rRLAuMwQ/hkraoq5PRvRPYoGmq6YIz3FM=;
        b=BWD8hDoKMaseebiiF9CFOI2SFawMyeNpn8HJloRIJDJ46NwA51XWwLwM6kbGj9JIC0
         vqSNrWnpp2ZQnCdxAczJpSaP4UOEhtcxaSTj03DfPLSb4JILloEb75HabvplhrHKobzn
         nsni1eqslCzMXOzdd2DGdy1kx90sXIysXD/dTGWVc7NhjSqFbn1pZu0LFye0Dp/OnOUu
         UrM8f37FvqEDvPrnE1i6tCbp2w5eP8I2KehxjRcteE9ljCAw9zymI1ITHvI/fqnGkBoL
         rm8VoVj9tEczWNMsEdc1H7z2wq1vwojNm/mFS+dImablx6/ZoomlFL19kaBR+TATEZXU
         RQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507360; x=1715112160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woNMMspCQ7rRLAuMwQ/hkraoq5PRvRPYoGmq6YIz3FM=;
        b=bk58Mp6Ea7D6HIgxfkPXB+sAAQYjikIi4U6fqK3sVa6QNZNkoYkCNgLkFox4BBe5X0
         dVcGVkg3QJdE1MCsLiIWPvoLypBaCr0JZ6W6LaCv35AGipC2rGWsI1g9Fg/Hav4fw/72
         QXJ75OgQaUOXx14DRCONdPCwKG5TA4yvLRhEumP/GSZrOzasKGDgqiEF9WvViLrC/Yyn
         RU5+J58PPLCr6Gz2eA5ayYnDTagy+chlax2D/SwQHq5MDdepD4/ZnpwTq/p8wupSTFSG
         P+NP4Jaj9CSEeCL60P7EL5cLufwVNSEQli/JH7tWjkrk25CBrB5oNco8iXsTnb0VZtob
         ddDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmySEYg6+q5GZqUTols4qNOFVzrAqA5Zl9tMlIcFxjgR6+DWFIi4IhsbOl2P8ONocToPWXmf3gAw6RjJ+wJM4VYucjSWE=
X-Gm-Message-State: AOJu0YxJiQLYK3+ZDDQDSvETZm4Nr/iF5DnaXEPkUUblbricAbFvUrCR
	kx1VrvRMJikyWMWJAS5JlOpjSO8lkPKic84ndKX/Mm/71D7npVMoIYFfqgeJszyUOw9RI18tKZl
	t7Kc=
X-Google-Smtp-Source: AGHT+IFZ63r+P6/V/33l9FMPPZpUMxheVkxSIDjtaaDzMEyOzTm5XZvYGbPNkVeL1VzXOV2KHMaUiA==
X-Received: by 2002:a17:903:2444:b0:1eb:3dad:aced with SMTP id l4-20020a170903244400b001eb3dadacedmr531681pls.11.1714507360233;
        Tue, 30 Apr 2024 13:02:40 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm22809820pll.249.2024.04.30.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:02:39 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v3 1/7] dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
Date: Tue, 30 Apr 2024 13:01:51 -0700
Message-Id: <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714494653.git.tjeznach@rivosinc.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the RISC-V IOMMU device drivers.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 .../bindings/iommu/riscv,iommu.yaml           | 150 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
new file mode 100644
index 000000000000..16817525e157
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V IOMMU Architecture Implementation
+
+maintainers:
+  - Tomasz Jeznach <tjeznach@rivosinc.com>
+
+description: |
+  The RISC-V IOMMU provides memory address translation and isolation for
+  input and output devices, supporting per-device translation context,
+  shared process address spaces including the ATS and PRI components of
+  the PCIe specification, two stage address translation and MSI remapping.
+  It supports identical translation table format to the RISC-V address
+  translation tables with page level access and protection attributes.
+  Hardware uses in-memory command and fault reporting queues with wired
+  interrupt or MSI notifications.
+
+  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
+
+  For information on assigning RISC-V IOMMU to its peripheral devices,
+  see generic IOMMU bindings.
+
+properties:
+  # For PCIe IOMMU hardware compatible property should contain the vendor
+  # and device ID according to the PCI Bus Binding specification.
+  # Since PCI provides built-in identification methods, compatible is not
+  # actually required. For non-PCIe hardware implementations 'riscv,iommu'
+  # should be specified along with 'reg' property providing MMIO location.
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qemu,iommu
+          - const: riscv,iommu
+      - items:
+          - enum:
+              - pci1efd,edf1
+          - const: riscv,pci-iommu
+
+  reg:
+    maxItems: 1
+    description:
+      For non-PCI devices this represents base address and size of for the
+      IOMMU memory mapped registers interface.
+      For PCI IOMMU hardware implementation this should represent an address
+      of the IOMMU, as defined in the PCI Bus Binding reference. The reg
+      property is a five-cell address encoded as (phys.hi phys.mid phys.lo
+      size.hi size.lo), where phys.hi should contain the device's BDF as
+      0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
+
+  '#iommu-cells':
+    const: 1
+    description:
+      Has to be one. The single cell describes the requester id emitted
+      by a master to the IOMMU.
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+    description:
+      Wired interrupt vectors available for RISC-V IOMMU to notify the
+      RISC-V HARTS. The cause to interrupt vector is software defined
+      using IVEC IOMMU register.
+
+  msi-parent: true
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |+
+    /* Example 1 (IOMMU device with wired interrupts) */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu1: iommu@1bccd000 {
+        compatible = "qemu,iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupt-parent = <&aplic_smode>;
+        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
+                     <33 IRQ_TYPE_LEVEL_HIGH>,
+                     <34 IRQ_TYPE_LEVEL_HIGH>,
+                     <35 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+    };
+
+    /* Device with two IOMMU device IDs, 0 and 7 */
+    master1 {
+        iommus = <&iommu1 0>, <&iommu1 7>;
+    };
+
+  - |+
+    /* Example 2 (IOMMU device with shared wired interrupt) */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu2: iommu@1bccd000 {
+        compatible = "qemu,iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupt-parent = <&aplic_smode>;
+        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+    };
+
+  - |+
+    /* Example 3 (IOMMU device with MSIs) */
+    iommu3: iommu@1bcdd000 {
+        compatible = "qemu,iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        msi-parent = <&imsics_smode>;
+        #iommu-cells = <1>;
+    };
+
+  - |+
+    /* Example 4 (IOMMU PCIe device with MSIs) */
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@30000000 {
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x0 0x30000000  0x0 0x1000000>;
+            ranges = <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x0f000000>;
+
+            /*
+             * The IOMMU manages all functions in this PCI domain except
+             * itself. Omit BDF 00:01.0.
+             */
+            iommu-map = <0x0 &iommu0 0x0 0x8
+                         0x9 &iommu0 0x9 0xfff7>;
+
+            /* The IOMMU programming interface uses slot 00:01.0 */
+            iommu0: iommu@1,0 {
+               compatible = "pci1efd,edf1", "riscv,pci-iommu";
+               reg = <0x800 0 0 0 0>;
+               #iommu-cells = <1>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f6dc90559341..7fcf7c27ef6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18958,6 +18958,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V IOMMU
+M:	Tomasz Jeznach <tjeznach@rivosinc.com>
+L:	iommu@lists.linux.dev
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.34.1

