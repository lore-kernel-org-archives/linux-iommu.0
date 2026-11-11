Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395309;
	b=O55xOGgq6FpzED/QNVhZxFQsQQt0UeswyCPiUS1CVSwYN0e8bB/vH2U5DhpO/unBOd7O
	 8eXuz8Y1Mj9K6U6yeqEdrxGpjwrB7oEv5pGTT4KwnuzlM468SDyhEquzaFTLwroBVLGyL
	 BzVFmSA+pPOTgyEgvHBWQJsdoMfDEX8rOjj1Pes/CqwvmapXagBY9ImJhAiVj4WywWfJx
	 GwWBHtJVajXSSVwejVRaIjTZ9zNJNdnvozNRRzR/KOBd577W0Zj1hX4gZCm7fftV59COv
	 WKxwHZaLMtCOlak0qg+A3T/Sq5ByeyalAnc0l38O4+SrDp3zyvgfbLibmxV2FNveHZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VViZS2bb3pZ4FEd6v4FhPEGdFU0OwPB+qGWSqpoqEsA=;
	b=SA5RQ+ITs0nA7vbYsI5g2koIpCLEtEG4QsEka/ki4hLsa8lcs80c4uaLl6IUUH7lJJZd
	 map4uAOIR/yKF+EUaSKFya/LIPr4tPWmLkwc3/uGDERJspmnpEgfEtrFrP3x8pCkRx6yV
	 oBgfRFVZb0hxPq6vA3mCnywBbT/rWSTAT8B10Geq8UQRYmdnHK/mocZv1LXYNn5vIdwSK
	 03x8U0cvqXxFPgVjZy5QkMApPqmvY0x22Udh0b8NKBIAJfRmBT1WqcWO+c6RR/JD8Y8au
	 gUCLtiba9jh8CbOI9RopesCIIlBNyxrzjvr2nvXfXNUFj6SfkhfsrfO4tMbkSYa4erg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b1kyacKK;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95560A3829
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB95560A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=b1kyacKK
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so23182975e9.3
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395307; x=1795000107; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VViZS2bb3pZ4FEd6v4FhPEGdFU0OwPB+qGWSqpoqEsA=;
        b=b1kyacKKepQAZQpENiNJMv/W5HOYAug+2lTKKZrC5Kz5oS0HNxTcxSJuIzyII0uahF
         2fHLP442aR5teDw86fsQus32b5TNaz+eWCxoNE46MBAw0LzzUIDpoMabubJe2PM/d7TK
         IXXrqd+Fs1XriTGZtRcIQBGnKgzcHR05gdquIgT5I1aiEQFD34xNcNTKPs178hNj8QZl
         cbpmYxW027tinexCyMP02oq9IQYEQsIGGn7pGnKu+JOiTmEU1t8G67rAVZcCjj7HLQzG
         FpOk7F0C/1vgngrV1u0lY6JcVHACFiPiTJw6XOpQwsAKCdLF2sTz/xLZHYYhpr6PFIR8
         97SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395307; x=1795000107;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VViZS2bb3pZ4FEd6v4FhPEGdFU0OwPB+qGWSqpoqEsA=;
        b=p1jiPwfTRjOesft1OKu43czNKYFGOYfu7EhDnvUjcHG7z4IFSXf2PMUXuGoM6Toy3U
         Zp2XnB3VvKOYpAMCPCCTO5fyHuOZ6+m03+Anu0oikRdTXXITaS3yCT5p7N7FRe24VQd3
         ljVbtIcvWgZTkR+aWYP3vqaJMe5NvxSSBK2/UOJNpSvW2hly+fLUsISnGcGeorkvvVRL
         G/EP6wpYA6Prx4yVf39MfJXTytoowBBsukrwwcQTd6jG/v2v3oohlTy4VCaKxty+Qw1u
         FLvJ7CwgY+kaajA966khWfd0q/2MBG9RibNyRVbdCLLGPwXeIvabAKNobKfo7RFpsE9V
         Dk6Q==
X-Forwarded-Encrypted: i=1; AL+hErFuZzW2uzYGMsrXfiVviJ+LmNxFuSWoiv0jVnCAyAIuvgN6al4U7Fzz0Nyvf5PIfFNHvmZ48A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+XpKhMxKZrTMhJTyKYiWwSYD43JLW/DGcmwwoQSWpHgp1OpmL7
	xRSLjulOgJczPvwKTgt+aR+B8vJEvgMlaGplEtyofzxLwLRrVOP/ssnjtHmDm+0B085f9qtZv9/
	evMtgTdFXiKmTYczQpcI66A==
X-Received: from wmgb22.prod.google.com ([2002:a05:600c:1516:b0:4b8:b187:f0cd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b83:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4ba0935dbfcmr39556605e9.10.1794395307014;
 Wed, 11 Nov 2026 03:08:27 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:34 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-5-vdonnefort@google.com>
Subject: [PATCH v3 4/8] dt-bindings: reserved-memory: Add lendable-dma-pool
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
	ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add bindings for the "lendable-dma-pool" reserved-memory CMA pool, used
to dynamically unmap pages from the kernel direct map before lending
them to a secure world.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 .../reserved-memory/lendable-dma-pool.yaml    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
new file mode 100644
index 000000000000..0b924d941b4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/lendable-dma-pool.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory Lendable DMA Pool
+
+maintainers:
+  - Vincent Donnefort <vdonnefort@google.com>
+
+description: |
+  This indicates a region of memory meant to be used as a pool of DMA buffers
+  that can be dynamically unmapped from the kernel direct map (e.g. before
+  lending to a secure world such as via Arm FF-A).
+
+  On architectures where the direct map cannot be arbitrarily modified at
+  runtime (such as arm64 without BBML3 or without rodata=full), the operating
+  system ensures this pool is mapped using last-level (PTE) page table entries.
+
+  The reusable property must be set, and no-map must not be set.
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: lendable-dma-pool
+
+  linux,cma-default:
+    type: boolean
+    description: >
+      If this property is present, then Linux will use the region for
+      the default pool of the contiguous memory allocator.
+
+  no-map: false
+
+required:
+  - compatible
+  - reusable
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        linux,cma {
+            compatible = "lendable-dma-pool";
+            reusable;
+            size = <0x4000000>;
+            alignment = <0x200000>;
+            linux,cma-default;
+        };
+    };
-- 
2.56.0.542.g3ef89b7020-goog

