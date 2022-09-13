Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266DA66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:47 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id g12so9223758qts.1
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Q4ZU5cexm9Q08qLiEijmmMTjwuY3GlJ1Cn90C3bzJMU=;
        b=DPtm4ok3PSf82mq7JMYxEELlSbe2Rh/g3fQ51ooEmzdbhvAmX7bq1p/PDmYadgyeC1
         zi9y/jcGd3D1R6ZJkZ/FQsWIwfFLD+Pb0MJITbf3fgUqnK83ONtjfJ+HMIIxaq6Be8T0
         7yW02a5Gpkn6GV6C9TtbKwXcBYYQfckEhhDlRw3kQGNLccCEAsysOi1687eQCVwa1Snz
         UzUeXpguUoApWzimdM3XamY7zoYoXwniOBrFXnFh1C31eUhw4i9vT9n/3okZ8ZMJuUbE
         x2Q9CpCURykZLJagLzDO5v/o6/9ctT6KeQ6BSDQrVAvGz6WE7hB0JQGNvnw+QEyD9e4R
         S75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q4ZU5cexm9Q08qLiEijmmMTjwuY3GlJ1Cn90C3bzJMU=;
        b=HylbJ6zZpMbYzJF1ApDt6bxrRXlN8SrlA9Q+zIK343OtR9tJpM6cqryNR5lf8OW2TW
         Gsxzq8Cf75vIKx8ftuYIrOaajNhH2di9kHabeEUBS153cYs1lw+3ChhAdM2jEXl0tim8
         pQ7zBhCQ2tdqO7y/jc4bfDgPJU6Qq+s2vWnx4uoegkcNoNOfIERbcYvcnKx2kdjMGIu/
         W0pyb0szpMClNscWCIs+J0pVQiJA63zaBVtjRsO1gKDze3vyhLJqJTzcus599C4I/kPE
         Z67Jh3QSBSUXX/T1J+sEr75nxnv+LGi5GPgR1xahS6XuERzRJ350GwJ7+aUjVkK5+oCg
         aMLQ==
X-Gm-Message-State: ACgBeo17PFVKPeiUTrkRW62wg+cgjD8UzoFT64LqwIxt5/fVdL//Bh0j
	6z5Set3bQ4zCDkKwfR2N3uc=
X-Google-Smtp-Source: AA6agR79LKnSKwsuEjaHOZbqMf9sDJeff1s7ltAoeOd0yWLYcv6FI23B3yp+SehZLzBtT5Q7988TlQ==
X-Received: by 2002:a05:622a:174b:b0:343:1fc:14d8 with SMTP id l11-20020a05622a174b00b0034301fc14d8mr29317695qtk.579.1663099126048;
        Tue, 13 Sep 2022 12:58:46 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:45 -0700 (PDT)
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
Subject: [PATCH 14/21] mm/page_alloc: make alloc_contig_pages DMB aware
Date: Tue, 13 Sep 2022 12:55:01 -0700
Message-Id: <20220913195508.3511038-15-opendmb@gmail.com>
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

Designated Movable Blocks are skipped when attempting to allocate
contiguous pages. Doing per page validation across all spanned
pages within a zone can be extra inefficient when Designated
Movable Blocks create large overlaps between zones. Use
dmb_intersects() within pfn_range_valid_contig as an early check
to signal the range is not valid.

The zone_movable_pfn array which represents the start of non-
overlapped ZONE_MOVABLE on the node is now preserved to be used
at runtime to skip over any DMB-only portion of the zone.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e723094d1e1e..69753cc51e19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -435,7 +435,7 @@ static unsigned long required_kernelcore_percent __initdata;
 static unsigned long required_movablecore __initdata;
 static unsigned long required_movablecore_percent __initdata;
 static unsigned long min_dmb_pfn[MAX_NUMNODES] __initdata;
-static unsigned long zone_movable_pfn[MAX_NUMNODES] __initdata;
+static unsigned long zone_movable_pfn[MAX_NUMNODES];
 bool mirrored_kernelcore __initdata_memblock;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
@@ -9370,6 +9370,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 	unsigned long i, end_pfn = start_pfn + nr_pages;
 	struct page *page;
 
+	if (dmb_intersects(start_pfn, end_pfn))
+		return false;
+
 	for (i = start_pfn; i < end_pfn; i++) {
 		page = pfn_to_online_page(i);
 		if (!page)
@@ -9426,7 +9429,10 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
 					gfp_zone(gfp_mask), nodemask) {
 		spin_lock_irqsave(&zone->lock, flags);
 
-		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
+		if (zone_idx(zone) == ZONE_MOVABLE && zone_movable_pfn[nid])
+			pfn = ALIGN(zone_movable_pfn[nid], nr_pages);
+		else
+			pfn = ALIGN(zone->zone_start_pfn, nr_pages);
 		while (zone_spans_last_pfn(zone, pfn, nr_pages)) {
 			if (pfn_range_valid_contig(zone, pfn, nr_pages)) {
 				/*
-- 
2.25.1

