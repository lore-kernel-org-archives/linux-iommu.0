Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911511BB3E
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 19:34:28 +0000 (UTC)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7836164a08aso390526239f.1
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795267; x=1690400067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdGmPDy4n8Vb9yckrY3NHJ0yplI6UyLJ02ulp/zmXZw=;
        b=HecAfKZg9Xu/PFX1+zVYZYlqqow6E/dqLCp2s59n3O/xfMNhZ1IcSBmsZ+yJK5yNZL
         N5QknaUrOuOpLSTFmj+MWb/R4/rP7abzfMWRnDK/dpQ/I6huV/G8S6SoVAYQf3jyjBYc
         ITXB1yxmxSgIKH+s1sMPFwsyhlwsCD3w0so/PM12hwEOfcikG3bfcZdbu0ypKBEuN/gu
         VP71K10oPMLxWNldnN5H5JKrGbSGgWpQLr4SMMleYtLvyes4e4RlNw7G1q4GorTf0DJt
         gAqzhs9DEql29OqfU1pSrU/R0JUUn/T1cffMhVSuj+e5CHeakg/+oKqiTz3fVOG0oVX+
         1rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795267; x=1690400067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdGmPDy4n8Vb9yckrY3NHJ0yplI6UyLJ02ulp/zmXZw=;
        b=NTjbNzlBvVHNQFfODdQ10jJtrp0ArylyOP0B749adgzP7y/6U4U2bhxzwhkjdCQv6D
         0bVBuIDh4qA6ZE5jw2438zSFg5wTmySfef4Lljkv4CoW5dKoz0S0nf9dIAq3I2QskXtY
         +G+tAoaNCBgpJ83OoiUoD3rfa3BNpYJlg2oJa6c3HZQPV2hcTKceVxvcQx2czoH67oDe
         SvufHwkDb7TJkrNfLwAGXCOWxDOrdlzSwIh5186MotuXIQp20axff4bJVPrHU4EOnf/m
         3GGowW1z16iqZKI2Oq3omoiykyWqTkkJWJRHd+ktimzEnjX06mGze+ORJXyu/YAZTJQn
         iVGQ==
X-Gm-Message-State: ABy/qLabWBBxPorfgEDe97ISwZzUezpSlsWiYtAyMKenUACVp0pxEuUx
	e3PbMwYHTGXWCaGbwIIi7HKtqA==
X-Google-Smtp-Source: APBJJlGN7srrpW1Dfo4Ygw07TXS+Dfssh8mV+rp8AEjMaeoQuXFsWsSaJe/QFh3kOeDRzzfvovNgSA==
X-Received: by 2002:a05:6e02:12ed:b0:348:936b:ae12 with SMTP id l13-20020a056e0212ed00b00348936bae12mr3737637iln.11.1689795267467;
        Wed, 19 Jul 2023 12:34:27 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:27 -0700 (PDT)
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com
Subject: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
Date: Wed, 19 Jul 2023 12:33:47 -0700
Message-Id: <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689792825.git.tjeznach@rivosinc.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anup Patel <apatel@ventanamicro.com>

We add DT bindings document for RISC-V IOMMU platform and PCI devices
defined by the RISC-V IOMMU specification.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
new file mode 100644
index 000000000000..8a9aedb61768
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V IOMMU Implementation
+
+maintainers:
+  - Tomasz Jeznach <tjeznach@rivosinc.com>
+
+description:
+  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platforms
+  which can be a regular platform device or a PCI device connected to
+  the host root port.
+
+  The RISC-V IOMMU provides two stage translation, device directory table,
+  command queue and fault reporting as wired interrupt or MSIx event for
+  both PCI and platform devices.
+
+  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
+
+properties:
+  compatible:
+    oneOf:
+      - description: RISC-V IOMMU as a platform device
+        items:
+          - enum:
+              - vendor,chip-iommu
+          - const: riscv,iommu
+
+      - description: RISC-V IOMMU as a PCI device connected to root port
+        items:
+          - enum:
+              - vendor,chip-pci-iommu
+          - const: riscv,pci-iommu
+
+  reg:
+    maxItems: 1
+    description:
+      For RISC-V IOMMU as a platform device, this represents the MMIO base
+      address of registers.
+
+      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI bridge
+      details as described in Documentation/devicetree/bindings/pci/pci.txt
+
+  '#iommu-cells':
+    const: 2
+    description: |
+      Each IOMMU specifier represents the base device ID and number of
+      device IDs.
+
+  interrupts:
+    minItems: 1
+    maxItems: 16
+    description:
+      The presence of this property implies that given RISC-V IOMMU uses
+      wired interrupts to notify the RISC-V HARTS (or CPUs).
+
+  msi-parent:
+    description:
+      The presence of this property implies that given RISC-V IOMMU uses
+      MSIx to notify the RISC-V HARTs (or CPUs). This property should be
+      considered only when the interrupts property is absent.
+
+  dma-coherent:
+    description:
+      Present if page table walks and DMA accessed made by the RISC-V IOMMU
+      are cache coherent with the CPU.
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
+  - |
+    /* Example 1 (IOMMU platform device with wired interrupts) */
+    immu1: iommu@1bccd000 {
+        compatible = "vendor,chip-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupt-parent = <&aplic_smode>;
+        interrupts = <32 4>, <33 4>, <34 4>, <35 4>;
+        #iommu-cells = <2>;
+    };
+
+    /* Device with two IOMMU device IDs, 0 and 7 */
+    master1 {
+        iommus = <&immu1 0 1>, <&immu1 7 1>;
+    };
+
+  - |
+    /* Example 2 (IOMMU platform device with MSIs) */
+    immu2: iommu@1bcdd000 {
+        compatible = "vendor,chip-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        msi-parent = <&imsics_smode>;
+        #iommu-cells = <2>;
+    };
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        /* Device with IOMMU device IDs ranging from 32 to 64 */
+        master1 {
+                iommus = <&immu2 32 32>;
+        };
+
+        pcie@40000000 {
+            compatible = "pci-host-cam-generic";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x0 0x1>;
+
+            /* CPU_PHYSICAL(2)  SIZE(2) */
+            reg = <0x0 0x40000000 0x0 0x1000000>;
+
+            /* BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2) */
+            ranges = <0x01000000 0x0 0x01000000  0x0 0x01000000  0x0 0x00010000>,
+                     <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;
+
+            #interrupt-cells = <0x1>;
+
+            /* PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(2) */
+            interrupt-map = <   0x0 0x0 0x0  0x1  &aplic_smode  0x4 0x1>,
+                            < 0x800 0x0 0x0  0x1  &aplic_smode  0x5 0x1>,
+                            <0x1000 0x0 0x0  0x1  &aplic_smode  0x6 0x1>,
+                            <0x1800 0x0 0x0  0x1  &aplic_smode  0x7 0x1>;
+
+            /* PCI_DEVICE(3)  INT#(1) */
+            interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
+
+            msi-parent = <&imsics_smode>;
+
+            /* Devices with bus number 0-127 are mastered via immu2 */
+            iommu-map = <0x0000 &immu2 0x0000 0x8000>;
+        };
+    };
+...
-- 
2.34.1

