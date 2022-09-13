Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFE66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:28 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id i3so4615408qkl.3
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kefl6D8eKpN1GxKRqpPd+2PbW8yMD7NaxrgEOy2EJKU=;
        b=byR/eekYsW9DhH0NqLev2fS+tpkFMN+hxgB8j3wmXvKTocIMCm6zZesYvYgQ87wjhP
         q+4AfKw8TXxcj2+vnpVcn5ECPh4qGk7Jtzj+zNbyb6YCFLIiwPOzRUIUuAqm/vme1CGD
         HXFFRmWffOsc2lXoXpa+V0KHw2MwGlrFjaT+dLfIFP4Da4Lspw/3GTIWmZkSLzazc/cQ
         hUYdezyBusY92UGvKeXjT7Rg0vsemlXyaK6ln+reN6yeiO3uNu7F3nGVR2B+OsucHch6
         d5MKRdQDkKjHro2ts06Z/prjBlf3W1AQZuN3IrXE7aLh74QN4KD+aUTWaAkLm41rgl56
         mOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kefl6D8eKpN1GxKRqpPd+2PbW8yMD7NaxrgEOy2EJKU=;
        b=CgVBjB52vsbYkfu1CGzR48mlnKrzFHh/vECQ8ZvaOimxBUVPxUtDc3D/xYF7FHm91J
         j/UyoviS+Vc69lQ+IIEDSNsmprB5Dt15zxVQoEwnWW1FJVVaolENY615aWuNWfOpDpMu
         zHIc65WdzuWW0yLhInOL2eYensfffEe26FFpD7383YFQdN+BORN0VLay7a1Dug4Pr94V
         Q7TW0ZJ4PL32zQFfpJ3VsYBLAChq92beWF+0vEhSsVVBH4bQChlyML3YhUUDwGzI2SSs
         R7QY172v9z6XurBwVAvq3FDWIN7eu/mu/d0e5Tb/xVtjN7Tk94WSYr4gHEIPEKslPo+k
         2CCQ==
X-Gm-Message-State: ACgBeo2G3aA7frX9eztEDLxVvnuMW3p5ytCwywhcrlYlStHDwhOQyrzW
	WLXqUlSrJsvnHkLrvPAab8w=
X-Google-Smtp-Source: AA6agR4kCtYZpwUOe+kdoRL5XUeDY9Udr6YA+L+RrDdkM+ZkGSBIa8BGCY7yWmaW8ey8FgVIise+hw==
X-Received: by 2002:a37:916:0:b0:6ce:5f1c:d5d9 with SMTP id 22-20020a370916000000b006ce5f1cd5d9mr5678519qkj.737.1663099107720;
        Tue, 13 Sep 2022 12:58:27 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:27 -0700 (PDT)
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
Subject: [PATCH 09/21] mm/page_alloc: calculate node_spanned_pages from pfns
Date: Tue, 13 Sep 2022 12:54:56 -0700
Message-Id: <20220913195508.3511038-10-opendmb@gmail.com>
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

Since the start and end pfns of the node are passed as arguments
to calculate_node_totalpages() they might as well be used to
specify the node_spanned_pages value for the node rather than
accumulating the spans of member zones.

This prevents the need for additional adjustments if zones are
allowed to overlap.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6bf76bbc0308..b6074961fb59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7452,7 +7452,7 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn)
 {
-	unsigned long realtotalpages = 0, totalpages = 0;
+	unsigned long realtotalpages = 0;
 	enum zone_type i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -7483,11 +7483,10 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		zone->present_early_pages = real_size;
 #endif
 
-		totalpages += size;
 		realtotalpages += real_size;
 	}
 
-	pgdat->node_spanned_pages = totalpages;
+	pgdat->node_spanned_pages = node_end_pfn - node_start_pfn;
 	pgdat->node_present_pages = realtotalpages;
 	pr_debug("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }
-- 
2.25.1

