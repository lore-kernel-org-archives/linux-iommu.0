Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95F66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:54 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id h28so9344055qka.0
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0ytqVsMPjuVvTMmUHQDgw++YWpDMZOL8Z97lPlE2FVY=;
        b=io9Nt4/RcZ2YZMphnT4cANVUYCQB6U7tpDHWWA0ymeRAMaiACQe59CDdxV3fKa+Hsn
         xNls20lsFyfw6rNS33zM5vtcFodTEOrCxgBbNhbWX8T1mEeMX+VwfC33CIm+xfP758LM
         zM7bYSmAZtJOGaBc2/pCs2H6YwEWsP5kO079m4wM+f6s/zfDbHxnmlkNGrxVR7sLq2J2
         vi+KzltoxbcgQVb6NYjPdS8rs20FudQRcZ6AiEV/jd58a8RhxFomEIPJSEoUVrySG9CU
         fGCpRyRxdV4msiy4sXSvtH2LCG/1JOnoJrLiDkFSx8Zr9e7tZ4S5+YfhjAOUxZaXHtxy
         O3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0ytqVsMPjuVvTMmUHQDgw++YWpDMZOL8Z97lPlE2FVY=;
        b=gaGXxwCOkR/BaPCMY9jN3M2JXjXhLfPLVF49oQV5/0NhuIeyF0y0Cyubm9SRV+YSMO
         f44fPaCYx4eWKB+S6fd2BVxVTYHucTqfTnsCgKoQzh5Go1HEw0609BhpKuGDjTZjVqZI
         lJDOE8i6suAx4HSw77z+SPivoG+oUqX8J0QBIPtaeRAitjPmBZE12fr8IzR2emRVDZOl
         /RHZROm7pOcoshwQ4pjNIA/Q1/1WwBzDb2y/pp1BtYouHKR+SZR7HnUR+uvg/n+dtFGj
         HUbvjoa0pT/SOvuD1fTDsdQEHeZC3D6RAQuOB9/AlAtN9t/hsGxLOYvCv8U5Gv55Innt
         /6mQ==
X-Gm-Message-State: ACgBeo1mIML8o3gKgkYcoE1ix9XQtUlXT3WluH/Z8cXZWWx9FV7AqRgs
	HD3HSUYqglKEbZxVpqfpRT4=
X-Google-Smtp-Source: AA6agR6d/FiwNOHoDQ8OKNxH916Sryp0qXJllILzqqegobMzkZRMGgPUcF2Qjw5zlXSo5I0Sdx+6eA==
X-Received: by 2002:a05:620a:4407:b0:6cb:e111:32c2 with SMTP id v7-20020a05620a440700b006cbe11132c2mr18923399qkp.415.1663099133214;
        Tue, 13 Sep 2022 12:58:53 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:52 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH 16/21] dt-bindings: reserved-memory: introduce designated-movable-block
Date: Tue, 13 Sep 2022 12:55:03 -0700
Message-Id: <20220913195508.3511038-17-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce designated-movable-block.yaml to document the
devicetree binding for Designated Movable Block children of the
reserved-memory node.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../designated-movable-block.yaml             | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
new file mode 100644
index 000000000000..42f846069a2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/designated-movable-block.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory Designated Movable Block node binding
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: designated-movable-block
+    description:
+      This indicates a region of memory meant to be placed into
+      ZONE_MOVABLE.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reusable
+
+examples:
+  - |
+      reserved-memory {
+          #address-cells = <0x2>;
+          #size-cells = <0x2>;
+
+          DMB0@10800000 {
+               compatible = "designated-movable-block";
+               reusable;
+               reg = <0x0 0x10800000 0x0 0x2d800000>;
+          };
+
+          DMB1@40000000 {
+               compatible = "designated-movable-block";
+               reusable;
+               reg = <0x0 0x40000000 0x0 0x30000000>;
+          };
+
+          DMB2@80000000 {
+               compatible = "designated-movable-block";
+               reusable;
+               reg = <0x0 0x80000000 0x0 0x2fc00000>;
+          };
+      };
-- 
2.25.1

