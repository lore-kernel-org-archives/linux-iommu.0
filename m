Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7F5C8EF
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579304; cv=none; b=nhgYqH9par0Nmv320HGe1TfX2jEtGNSQ8rjsh9a4G8xc9jibNBTwwLBYfoWVAbeODbCpia0KNUbQDCMoVE/RoT84IkzWHQzp6E+/MGOXwer+cs5t0SbXvgACkj5apc2JScaJXQMb/X4OxWNkWRkLEGSrSJ87ZNEcJNqvF6UO31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579304; c=relaxed/simple;
	bh=opuHax8roT2BI4Pe8lhdIpmMxaQdJCHbIPtuUoDKb6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ML9rfhBDsDrbZzq7EvTM3Ox4ydXXCNHy/LqOQN8zY52YaboVgIguTAti3XUxvKD6sufYgiW9zYjBq8P63lfCvrThkqweBB5agDBDRxs0NkUeCVzRYoZ+2AA7JlNq93QIGLqY+/MFyyR76YeUvH8YwPwFdR4hu7qUHHlqvag908c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hrtqGgZ7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hrtqGgZ7"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6fcbd812b33so80246b3a.3
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716579302; x=1717184102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6ZCRHhHgt+ykFdnp7Z2Pkv1IEgHCkkKr8xgjwZKIrg=;
        b=hrtqGgZ7CCn2Bwbrcq6t8l3Q37l7SUVepu9BJ6EXy85fGu/UE1S6i4mpd8QMRNoqs0
         NziX5bSNJIx7Gxq3rtrBd42kCA5V8ISuGQnMwSRHtKAqOB/uO/jG91+A8hKIphvMZake
         qt44tkUa37j/4ye8hh4BehJbqZMwIRWZnzWWwjtbOLzfZrTHHdN8auPiUWeXeTWQbLUc
         /dr0mCXyBBfOUbMPIoDIsmK8y8UNG8kWMK7dIFssnFhwSHHo1WDUF2BlqM82Lgm03cIP
         q3Q/ubvMvZZwmzDfrwaNS8oU3elFsC2OuTuWU+kBFRZuw7CCRvdmTeqhMHqR7oVQ5LrU
         jBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579302; x=1717184102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6ZCRHhHgt+ykFdnp7Z2Pkv1IEgHCkkKr8xgjwZKIrg=;
        b=S3SwRlpaeA6zeZJywUfXZUklN19qZbg1QWcdfMuAeVnmQ/nw3PQgnTW7DomfQV6sPK
         s4kC1eSxFd1lLHIuMB5Rl2UUdEW4GV4vujV1fE2KepSOPgumY33CkF+4BhVF4B9/hgSt
         IqSA+mfZcukPUZWFBLl2enSZd6yovjj0YTgQQXYBXdz272kjU97H2/cZWfecy60hQh2L
         +MTqA5dGZYO2KR/kTpONHr9gaAbYBHuDZPy7qh3Zj8VOHIyKjteenYVpVo485eKcMPRK
         WcCcQGhReFK7K0CeEJk3UUvdTTFI+o6gsB09aB6Ma8Sgp1y4KSNm64C8VtU0WDsqMutj
         2NKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXukyTzeLDomd1Lv9eyi/qE/wp3HoKVzCu+0+U+YM2rPIFn/0HrkA8dEbw0lJ5aVKgYNUzGKJlZVNuhpA1GPsDeX+zPZIo=
X-Gm-Message-State: AOJu0Ywf1J/pT2MKG9hN9CTtbFpoh+lMCPdnYAukhSGQr37XA2co+8SV
	7B1aBPuvIQeN/Tyne39ZPPPTnCEo+OI36RgqCBns1HX4IGFsLe67YkCud0cm1ms=
X-Google-Smtp-Source: AGHT+IHbCXkG7/ek0iarxD0p8XmVztOrJRu1qmKE1UuzfhJ7QqxEk9ZgWXIt4x1VA28ClJF/mouweQ==
X-Received: by 2002:a05:6a00:3007:b0:6ed:cd4c:cc11 with SMTP id d2e1a72fcca58-6f8f3f9f43amr3418278b3a.25.1716579301636;
        Fri, 24 May 2024 12:35:01 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d878esm1441684b3a.190.2024.05.24.12.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:35:00 -0700 (PDT)
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
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/7] dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
Date: Fri, 24 May 2024 12:34:41 -0700
Message-Id: <6777b49a702723f64bd83f96c4275452b56b7a02.1716578450.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716578450.git.tjeznach@rivosinc.com>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 .../bindings/iommu/riscv,iommu.yaml           | 147 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
new file mode 100644
index 000000000000..5d015eeb06d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -0,0 +1,147 @@
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
+              - qemu,riscv-iommu
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
+      of the IOMMU, as defined in the PCI Bus Binding reference.
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The single cell describes the requester id emitted by a master to the
+      IOMMU.
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
+        compatible = "qemu,riscv-iommu", "riscv,iommu";
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
+        compatible = "qemu,riscv-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupt-parent = <&aplic_smode>;
+        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+    };
+
+  - |+
+    /* Example 3 (IOMMU device with MSIs) */
+    iommu3: iommu@1bcdd000 {
+        compatible = "qemu,riscv-iommu", "riscv,iommu";
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
+            iommu-map = <0x0 &iommu0 0x0 0x8>,
+                        <0x9 &iommu0 0x9 0xfff7>;
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
index 27367ad339ea..1ce589eb9c15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19265,6 +19265,13 @@ F:	arch/riscv/
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

