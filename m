Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518781E7C0F
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589712; cv=none; b=he7SY1P2EUfLPciyjsqwbTDC54N2xiB9Hgbw6vdArFiOyZqgyVapSmiKo/LU01nvvsJpw7H4vWSkcstVKwOw3MmniGXjXB478s8rqxPz7WH76jfKM+sAOEtf0dKmaI68oWQpdK5170mej6tg8EVyK3axJ/znpM/QheZ4Z1RFnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589712; c=relaxed/simple;
	bh=C5Jq5H36gJf1Xwq8XVVQ2KjAC3IQ9QtXIDfhTyfnmZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqmNs7d3oJAB1fsMc3zYycI0Y9FgUF/6uwBMEAQvAAXALbdijKTAX1SKroY3mRNxF69Rjae1D/CFNPnExCGp0Nufb3cdxYOxIWQpCyS7nDsT6G2TP4lCvTvz/6RQx6gCzWeMSUQGWdK2HV9iULh5/7t7pPxgarwC0FCYjG1ujjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yRw0d9zf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yRw0d9zf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71dff3b3c66so916883b3a.0
        for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728589709; x=1729194509; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5xid5eYrdu+scPSzIVukKQMRzibQ5L681G//KIqVXs=;
        b=yRw0d9zfW/v4tZl0N03BAo+YHjgOnluHRzAkEfaptJ1jBrMRGxuKgHg6qmEtTqkZnz
         wn6MWxYub5BHHB2mhixR3CCwE7CTg1eRr14u56xALgU6xQFtnWZpj2IVtf4rGOe5CFFo
         bV6tq0yokpbotIodWxlfiBYEOZ3v5grLJO0j2Qc84WCRqvdVYZfQ8uZwBChO1u1tTPn1
         WXYi9aLo2CX8J3qMDevMcO3CDPFK47IRU2lf8/QJBEHxrLIxzSapzGH1JwGtYDMDa9d4
         KLIg0xxj8KemleEu0fZeTGLWvJOiaxCdNhQI4rdaBN9QTrNNH4NLYujTCCajD7b3JPAu
         aTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589709; x=1729194509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5xid5eYrdu+scPSzIVukKQMRzibQ5L681G//KIqVXs=;
        b=srlXzwLnq7JItgZZqu3/doijkrP8SROTvMpwN4u/gTXhQY4t2tTZOvuKcVFbkV98n2
         u3ehZNoMY6Skl15n+5H/S8HnIYn0FNuXud5M1qn1YQtNoE5HICn3yURV8+9Lm4iY5xAc
         HF+LoyVPohcR55DPZkYrvw11dA5m7IBrTUMlhW3pf99Cw6koo2LkrKy2XaNZuSIceuXs
         e83duz5+C7aQ6rzouaR88YVjaewno5WGy8MHpLXGGSYZma9hZoSanCWx7BYjNbQf4N/A
         /YVxBYCVgXtYvzfaNjh9NOpl7nXqd0OEHcW3PxnMVAGrgDJpM0CU8tgu9kGYVCdcMm4R
         F7FA==
X-Forwarded-Encrypted: i=1; AJvYcCVGv+pJFrW/YV+0N1lD2vFM8YMXt7gT6ISlDa3EPJs3RXSzUu92Ll6GU+xfAKZKCoL7go7QDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2Jes0TIcmCL2lvwm9ekRxPyVS8Qw+40uUBE/eGDOzv2SLvyHy
	AZhc9BdlIo0BUeNjmjic9LZHqlEKbUN4bPt5MgZyUJPFRiJKHBgWKWOIMrotit+nEybwWpydt6W
	J
X-Google-Smtp-Source: AGHT+IEJdL5WnShTAnYbQhRjzJ2xY9oIXG5WsKDJkfLl5/eAhlWdDaXpUXot+smDcSpiSw02k8Mqog==
X-Received: by 2002:a05:6a20:c888:b0:1d0:3a32:c3f8 with SMTP id adf61e73a8af0-1d8bcfaa0ffmr131437637.39.1728589709534;
        Thu, 10 Oct 2024 12:48:29 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm749135a91.49.2024.10.10.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:48:29 -0700 (PDT)
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
Subject: [PATCH v9 1/7] dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
Date: Thu, 10 Oct 2024 12:48:04 -0700
Message-Id: <b9135dcc5227ef428d7566e178ab2d282a633c48.1728579958.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728579958.git.tjeznach@rivosinc.com>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
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
index a097afd76ded..839554c5ff06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19885,6 +19885,13 @@ F:	arch/riscv/
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

