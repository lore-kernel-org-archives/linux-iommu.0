Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6C66E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:02 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id b23so4695357qtr.13
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ae0x/cYtHCzUmIbnlOleUipnU3BBydliG8CbSfbHHfI=;
        b=lQy156yj9m33v2+lsCppN/1SSiL1+HSKUeGu4OKDvKzsWQP9uaxSZeRF6KYff4/ZX1
         T8ar9K8mrC7poQnpcOlicqZBPrnyrX4lQmy/efXceAo8c/r+O7+kebNQPiRqxM6b8RHk
         nqDdqIjYqMl2UkmBaLyC3jNoxqdBf+LTtzsYTc4L2U/V/TdvsthKIhCb1FgggCffFcVL
         4UCRPgfEkwehGvOaibbczRrkl3etaXkViPMT1ZepP3U6LDqZx2jP70X41REaFOYLplOf
         cOzr55DR2HMCT6kc/P98YRx0lPP2AD9Ny8hyMOuXORVZJrRjvmaKZrJZ1BXySGhbtpI9
         HDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ae0x/cYtHCzUmIbnlOleUipnU3BBydliG8CbSfbHHfI=;
        b=SKQoQwSZV0TlZmmtrATB99qKmYGCn+qUx845W/BtSXI8T4oPEcCYsM4GfRN4bRx7C3
         QIbqg/DXw2dtiSwponqhtTDOnCroTV8ut3hyplVAw9UIbzcG2mIbLhg7XMeHxFmCQG8V
         3gGWBfxTV6dxm01c0pGzvscS/76XmJu0Wdcu2HwbkVeXLOZiWP9VI0lldJGHwYHuzvAP
         lmvThywTVVouCNb0MLkmjxNdrYzVxWtlNg3AheyI2tMxB+frbbYiqt7LCtvRKBl0TyR/
         xpv6pXsmxR7goR/IRLoKC+ixwa81N/3IoUHqVLJB8wPhRRv58KHw0ZGUIItJUi3H/+Dr
         FzkA==
X-Gm-Message-State: ACgBeo3WAssMHFa/77kt4qrnFdkNzO/3AwjDikHkSzayxTBnz5eG+w1u
	er+EH0ARuXyfLSwsvDZ94xI=
X-Google-Smtp-Source: AA6agR5RQ3Vz73r+e9pp4sPmIM/iMa/zHS6QVY1LvvDFqMY99XQUTUB/nmtdr1ce7F9gfpRjTDrD5Q==
X-Received: by 2002:ac8:5790:0:b0:35b:fd92:6fb8 with SMTP id v16-20020ac85790000000b0035bfd926fb8mr4051143qta.53.1663099081690;
        Tue, 13 Sep 2022 12:58:01 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:01 -0700 (PDT)
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
Subject: [PATCH 02/21] mm/hugetlb: correct max_huge_pages accounting on demote
Date: Tue, 13 Sep 2022 12:54:49 -0700
Message-Id: <20220913195508.3511038-3-opendmb@gmail.com>
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

When demoting a hugepage to a smaller order, the number of pages
added to the target hstate will be the size of the large page
divided by the size of the smaller page.

Fixes: 8531fc6f52f5 ("hugetlb: add hugetlb demote page support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e070b8593b37..79949893ac12 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3472,7 +3472,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	 * based on pool changes for the demoted page.
 	 */
 	h->max_huge_pages--;
-	target_hstate->max_huge_pages += pages_per_huge_page(h);
+	target_hstate->max_huge_pages += pages_per_huge_page(h) /
+					 pages_per_huge_page(target_hstate);
 
 	return rc;
 }
-- 
2.25.1

