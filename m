Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AE66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:17 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id s9so7061808qkg.4
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5478I3WyUfDJcI1zhJnzCnFwBV1ia1XR+sLHu3XJI6Q=;
        b=ngWpsEYVUBqyRCK+w+5Ame50HZp1DYM8gstxDexc5gHtIO2fEu4wX/+7Noqq7EWBX5
         SX4JOXX5B1E8Qf1s/pvzk9Bz2iJJBgv4Hk3Ull+tKjmtldfM+s3z+vbM1B3di5w6gxjz
         dcVCWO2NZ50adOCK8bPYxw3tCqWOsDx7M7cTAjTnYf/V4tSaPDhi8fqtVljCEiP5o1JE
         EBkXOKZZNuxNzz6s5U3pOqHYezTLOaL4mQLClkKUJN8hT0raCVH32ZKrxQcROVGentqi
         38kFA0gMphAG/6qqKzQ2VCttdNXcqVd0gmzjLhB0hmlMfPBCKPcE2Rytw17lBrFXHH3/
         rqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5478I3WyUfDJcI1zhJnzCnFwBV1ia1XR+sLHu3XJI6Q=;
        b=Ps33aqoD3qg5qaYzysnLewvugFjekUcUAoJ3EuaHJ3WZBFza2+/1bydCvcnRwM4neG
         s67Yw8ejapcXE9QlNvq9N01BneWcYVc2GRKk8K6tlppdqf8E7AHhAP25+oTyXNuAVWtT
         aTRwbYJUL8MvM8cxRomux9F/z6EDv++EPEEk524fDkJOkRvEV83VVOJ7hu9AgEB7uq2c
         TASEFZyzVNwYg7iwI7GQf3tZ0BMbViafv7fLnoUcVNNceb0eMSrg7iszVpGsLJfdI05t
         Dr3bwexqnIs6wZWJmHD4p5vaXXkJUzbZJLuMIf+mgAY/jqfFmTW7hK58nU2Qir7E0VSR
         dd+g==
X-Gm-Message-State: ACgBeo11YMQupd1hGvqdxacYA+zj/xEWx4lsdcg6LB7s+BPUEibOenI0
	vHm89K06tE1gfE2G3tkjVlI=
X-Google-Smtp-Source: AA6agR5yg7LQIQNFFYJ0sDmMy6v2CLDWuXatdLv4m+yPVXKNj8MYR/nHEcTFAbCbbhbRcvfawH5dww==
X-Received: by 2002:a05:620a:4496:b0:6bb:8db4:6b49 with SMTP id x22-20020a05620a449600b006bb8db46b49mr24594751qkp.703.1663099096778;
        Tue, 13 Sep 2022 12:58:16 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:16 -0700 (PDT)
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
Subject: [PATCH 06/21] mm/hugetlb: add hugepage isolation support
Date: Tue, 13 Sep 2022 12:54:53 -0700
Message-Id: <20220913195508.3511038-7-opendmb@gmail.com>
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

When a range of pageblocks is isolated there is at most one
hugepage that has only tail pages overlapping that range (i.e.
a hugepage that overlaps the beginning of the range).

However, that hugepage is the first migration target for an
alloc_contig_range() attempt so it already receives special
attention.

Checking whether the pageblock containing the head of a hugepage
is isolated is an inexpensive way to avoid hugepage allocations
from isolated pageblocks which makes alloc_contig_range() more
efficient.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da80889e1436..2f354423f50f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -33,6 +33,7 @@
 #include <linux/migrate.h>
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
+#include <linux/page-isolation.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -1135,6 +1136,10 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (PageHWPoison(page))
 			continue;
 
+		/* Check head pageblock isolation */
+		if (is_migrate_isolate_page(page))
+			continue;
+
 		list_move(&page->lru, &h->hugepage_activelist);
 		set_page_refcounted(page);
 		ClearHPageFreed(page);
-- 
2.25.1

