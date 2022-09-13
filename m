Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8766E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:59:12 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id y9so10099711qvo.4
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=koBwJdR4HF2Mh9OkMa3nN+ZpGb/cJotv47IHPg3aLjM=;
        b=H9fVlQTVY6EaU+njTimAq+ibJtvJjx2vWGkJikgtxKpK4lpRvh7Gs0dhq+SfYU7Y1l
         ol227J1p7+D7fHpafEcMsArwK6zpQesHNLeCyw8pBBnlfTeZXRH0gTB01wVhDLo6ZqZ0
         2mt9ehwJJq5f5bEntKn/0aquyhMi35hMoNg4MgcTAFw56eJYhoioxREYotQhcXVzv4ef
         26N8v6sdGt7Ksl3t6WmZRbYcEffyv4LTbLh0c7Zn4Y23wzA2w1INQgl13/vOL+Z8k7Uy
         rhOg4rC2RHnt2n62JjXnioNT4+kK415lG500sJWQkISGfWvSLQb972JndYtjJi8pBB0H
         qioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=koBwJdR4HF2Mh9OkMa3nN+ZpGb/cJotv47IHPg3aLjM=;
        b=Ahdy4k3Vz0T8V6JE099zkmOw7uDIWgi0PnZ7O9rSA1VXZzjPTo/9rnvtuf6vgilBR9
         YHnUWlsCCUtyFcstdJyJNe8qmYfV5/o84d4CXYMDk/R8G9tc/YgZm1uT/gA+x4MZP0Pz
         g4FIu3LZNTM/hzKgORCUEH80HsXF5w4STtpQRf1c8zXKHhrqDmM+ZHQQRr9kGIOVMoil
         Io0kF/BgD88QqpJ7quN5ZfqZmJpb9PSsSkRs4ttO5aX5+8O8Wlgl69hOwU2bfjvyLzql
         pNj69mAubmnIKBkikfJtkSqHTAAjS8evwqEVb+vUJYS3BJ9eCK+YJCADWsEupgv046wx
         sicQ==
X-Gm-Message-State: ACgBeo2BUb4HbvrBoYaiIg6BKwE8UWYnoNz6nvzQhq3xoyPxzV9+y3Jm
	NCUXKZuWTay6sA50v/Vn6JE=
X-Google-Smtp-Source: AA6agR4KLeMksXEqgCvXkwrSYo6YaUFxsEGC4nazCYouj2Y6nxYnhGX19vjDfEjEBR3X6wdqMlktzg==
X-Received: by 2002:a05:6214:1c0a:b0:49d:87ff:e77c with SMTP id u10-20020a0562141c0a00b0049d87ffe77cmr28164232qvc.54.1663099151805;
        Tue, 13 Sep 2022 12:59:11 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:11 -0700 (PDT)
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
Subject: [PATCH 21/21] mm/hugetlb: introduce hugetlb_dmb
Date: Tue, 13 Sep 2022 12:55:08 -0700
Message-Id: <20220913195508.3511038-22-opendmb@gmail.com>
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

If specified on the kernel command line the hugetlb_dmb parameter
modifies the behavior of the hugetlb_cma parameter to use the
Contiguous Memory Allocator within Designated Movable Blocks for
gigantic page allocation.

This allows the kernel page allocator to use the memory more
agressively than traditional CMA memory pools at the cost of
potentially increased allocation latency.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 mm/hugetlb.c                                    | 16 +++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8141fac7c7cb..b29d1fa253d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1732,6 +1732,9 @@
 			hugepages using the CMA allocator. If enabled, the
 			boot-time allocation of gigantic hugepages is skipped.
 
+	hugetlb_dmb	[HW,CMA] Causes hugetlb_cma to use Designated Movable
+			Blocks for any CMA areas it reserves.
+
 	hugetlb_free_vmemmap=
 			[KNL] Reguires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2f354423f50f..d3fb8b1f443f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -54,6 +54,7 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 #ifdef CONFIG_CMA
 static struct cma *hugetlb_cma[MAX_NUMNODES];
 static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
+static bool hugetlb_dmb __initdata;
 static bool hugetlb_cma_page(struct page *page, unsigned int order)
 {
 	return cma_pages_valid(hugetlb_cma[page_to_nid(page)], page,
@@ -7321,6 +7322,14 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 
 early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
 
+static int __init cmdline_parse_hugetlb_dmb(char *p)
+{
+	hugetlb_dmb = true;
+	return 0;
+}
+
+early_param("hugetlb_dmb", cmdline_parse_hugetlb_dmb);
+
 void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
@@ -7396,10 +7405,11 @@ void __init hugetlb_cma_reserve(int order)
 		 * may be returned to CMA allocator in the case of
 		 * huge page demotion.
 		 */
-		res = cma_declare_contiguous_nid(0, size, 0,
+		res = __cma_declare_contiguous_nid(0, size, 0,
 						PAGE_SIZE << HUGETLB_PAGE_ORDER,
-						 0, false, name,
-						 &hugetlb_cma[nid], nid);
+						0, false, name,
+						&hugetlb_cma[nid], nid,
+						hugetlb_dmb);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
 				res, nid);
-- 
2.25.1

