Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBD66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:06 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id o13so10085771qvw.12
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dgAC9wdSWdNnQd7c6lUo6ch6gbgfZ8Ik+m13B5omrFE=;
        b=pgU7qB1cfn3bbb6aqaPKVsP0QULztBXM6ZTdmlLajCShk8VBE78cxzG8Cv0iNse9pr
         raJ8GgLPcDyEkXzvMHViIvbgw2EPxCCCxmBWVydWXsbvHPXhV9LnTIQcxrhx+uvf4Xru
         5WYEg1qQVSMXl/Ik2LXwDiiTB+uN5XnQ7jp32HYymQ2HZJZADmguB3tnteKHk9qIukRc
         jpn8LdBlaPcxTkVAmOKzkV+NLvIVifwROYLBZ5KLKak/eoCCJdA+KloOJgYdmZJeYMVG
         xPc5vPtISXEXXxdKiktdhoBVSWbwV6cguyuU1u/JwyBG7hVEPpa11URawNPjZH6cK9Db
         YImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dgAC9wdSWdNnQd7c6lUo6ch6gbgfZ8Ik+m13B5omrFE=;
        b=PBiB44Sj94PpEq77Irx1qN0FbUxiu2EMTx9lJ45g+0Fj8TKKUvqeif4p/xptA0SSPX
         C8OXQSfp+S/K4uvdcpWcJiafoEsnGRoB7c7aw/j/B18a11ufR98EF1sEPskrEoARTmsu
         HShiKXQiOfZaZZD28lgtUYY1UdgKJ0LfjXjqPVCDa3PuAXop2PNcH0oLiSZBGuLwT3Z1
         LN9N60hoN9YfTLUW5g3LIEsdfZYV8NzHdz/TeBMUlA6YrTzuI2eYsrCgfZdzgiztfekQ
         wF1b9K2fmQJDle5qLwcJyV5hEPFhsyqzhdQt22wq6ei1gc6pvTqjeQTVQbWHqqwMiM2W
         XvpA==
X-Gm-Message-State: ACgBeo3l+/NT5LJQJrwpxMvXYKitn8ZPZHqhra152gY4Ay5Q3zgbI4tJ
	SxIplt5j5ZosD55+eYfMTUo=
X-Google-Smtp-Source: AA6agR5N0IDxlcIGSy6m2BrDrpoJ44hk3cGJOE0+/g5noyEETZjDxRdlg2yegkHVtpvIIdmASzximw==
X-Received: by 2002:a0c:a901:0:b0:4aa:a283:ef4a with SMTP id y1-20020a0ca901000000b004aaa283ef4amr28465376qva.53.1663099085481;
        Tue, 13 Sep 2022 12:58:05 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:04 -0700 (PDT)
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
Subject: [PATCH 03/21] mm/hugetlb: correct demote page offset logic
Date: Tue, 13 Sep 2022 12:54:50 -0700
Message-Id: <20220913195508.3511038-4-opendmb@gmail.com>
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

With gigantic pages it may not be true that struct page structures
are contiguous across the entire gigantic page. The mem_map_offset
function is used here in place of direct pointer arithmetic to
correct for this.

Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 79949893ac12..a1d51a1f0404 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3420,6 +3420,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 {
 	int i, nid = page_to_nid(page);
 	struct hstate *target_hstate;
+	struct page *subpage;
 	int rc = 0;
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
@@ -3453,15 +3454,16 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	mutex_lock(&target_hstate->resize_lock);
 	for (i = 0; i < pages_per_huge_page(h);
 				i += pages_per_huge_page(target_hstate)) {
+		subpage = mem_map_offset(page, i);
 		if (hstate_is_gigantic(target_hstate))
-			prep_compound_gigantic_page_for_demote(page + i,
+			prep_compound_gigantic_page_for_demote(subpage,
 							target_hstate->order);
 		else
-			prep_compound_page(page + i, target_hstate->order);
-		set_page_private(page + i, 0);
-		set_page_refcounted(page + i);
-		prep_new_huge_page(target_hstate, page + i, nid);
-		put_page(page + i);
+			prep_compound_page(subpage, target_hstate->order);
+		set_page_private(subpage, 0);
+		set_page_refcounted(subpage);
+		prep_new_huge_page(target_hstate, subpage, nid);
+		put_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
 
-- 
2.25.1

