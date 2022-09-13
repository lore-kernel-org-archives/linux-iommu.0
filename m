Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07366E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:59:04 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id i3so4616726qkl.3
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Iv6LAHuQtTXeYWyq0DEDKZbOD/1nb3ztqrePD2HtkIE=;
        b=YrAFBuuyJkwRgGb5yJxtoTNNKh/7y4BOHe54UWWbwGw/7zVyvD5YS3xh6wOizb8P5y
         WPvQ65cSNAdgAQQ5wDi83N9jAKpum/P9kqfXIHyP2JYI4r5D1linVF+pAeO7tMTGeNJd
         s10XvBpPDdlS4NQdOIfsc4Y86zu8zbnj/iRe9JIr+LJQn5lsr3jvpDq8YkHXv8CVoVQ9
         l1Y7VxuX7aqVyF4T9IwYMUdPvuZE/+WFrgImMS1687EPItdw+VwpQNOwUoolbQ3Hf9aR
         Ox2qAlcyZj/+2EVV8HvGsz7p+nWwMiSQtDYItBS1H3jfaKi/gJ7kAUpfhR4jWWYZpfwT
         Vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Iv6LAHuQtTXeYWyq0DEDKZbOD/1nb3ztqrePD2HtkIE=;
        b=cGEiBmsGIbMXNnfGXvRxiVONpr4lp4nEmu7NmmXs8CXtAPY5QygOE6e3gGnjrgUaPj
         k2dKdoBRBlbaRoTBjXjrpEZqOYfB3M43yCgglyxcHh2Sxk80EFZEELyt3kAA9o1jWIwl
         LxIwJ9/+XtRpQe5o3UkAE7n5KU7Fu8C7FyoueQfcK0mKa34YayOEIiHYa9Z/nzz/sAOk
         jsL59D2AGXsNqXOfHRp5Vkt/iswM7wm6RzuYBbarn/lTz5IfSqXlf7VqCrxNmoM+3fSN
         V+zGPeR5pjHwvaFarGCM9myKO4nD/tkUyrOQPKodFmQ1KsOhOi1yfh1D4nwVUd9yhNOE
         K4Jw==
X-Gm-Message-State: ACgBeo1VdqRkbnf6Erm5OG2djj+gBRo1m2hIQM6cz7TibuxB86wRacR1
	xc7aFC9ryYjr+kz2FqvHnFI=
X-Google-Smtp-Source: AA6agR6fK874H1rNDTk5i/hsxGcmtY4AZlr+R557N3WVBFwFecth0fyDkTeEea5ukgS/JNJqcxXZjQ==
X-Received: by 2002:a37:916:0:b0:6ce:5f1c:d5d9 with SMTP id 22-20020a370916000000b006ce5f1cd5d9mr5679706qkj.737.1663099144354;
        Tue, 13 Sep 2022 12:59:04 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:03 -0700 (PDT)
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
Subject: [PATCH 19/21] dt-bindings: reserved-memory: shared-dma-pool: support DMB
Date: Tue, 13 Sep 2022 12:55:06 -0700
Message-Id: <20220913195508.3511038-20-opendmb@gmail.com>
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

The shared-dmb-pool compatible string creates a Designated Movable
Block to contain a shared pool of DMA buffers.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../bindings/reserved-memory/shared-dma-pool.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
index 618105f079be..85824fe05ac9 100644
--- a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
@@ -22,6 +22,14 @@ properties:
           operating system to instantiate the necessary pool management
           subsystem if necessary.
 
+      - const: shared-dmb-pool
+        description: >
+          This indicates a shared-dma-pool region that is located within
+          a Designated Movable Block. The operating system is free to
+          use unallocated memory for movable allocations in this region.
+          Devices need to be tolerant of allocation latency to use this
+          pool.
+
       - const: restricted-dma-pool
         description: >
           This indicates a region of memory meant to be used as a pool
-- 
2.25.1

