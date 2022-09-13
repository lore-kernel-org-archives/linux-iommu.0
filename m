Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF866E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:32 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id r20so8905932qtn.12
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bjPZ9urefAsJcftBbAgQB1diXayOj809VCbylW0WU+4=;
        b=ElB8vGfwnTgMrOHPV8jOPMjX9e4dyOnpsA/daCy84nADITgBEDs0AWwUlYd7LmzJ4R
         Fd+wihlwr+eHGiOYJevIadmukrrhPQQQbV14He/EgVL8UId/ZjEQspu78E84lCBkqAk3
         9AGpDbnJvnF63g83iAedqf+9zINjZ62a64qbSfO2T1vB7Ckgl7brAPRPzZAIUuLk9YsF
         YnnaDAUhOF2TFJBs1+hdGFIi2/6/xETSCDXaO1b95XuqZwbhceSd0bqWp4uVAOWzs4lk
         zAxkAToGZXGzD1zml0W1YllS9/kHr+k5y9Z8yZENt9c1+33raLf8akoDdgYfGMOxfC4A
         ITFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bjPZ9urefAsJcftBbAgQB1diXayOj809VCbylW0WU+4=;
        b=RbnqelroCzJ1Lyde7fM6sUE0y3GC74ubcbW7ig1LoTTopHX13LR45OgHZZxKW8W3Q8
         fH1/BrOwNCsWEn2yGqC/tflHnzbB0yvC+v0tFgGOMaku4DkjMUqEpiE7D2dUlAY0p3S0
         lW41Dz2ZcTvKfKosPWDaDmw9lKML9iKLSuCijRGKKx2RTNcMJLAClwAwgv4nw7oiAH+N
         ephyY0CVP8EYOM1pk7kpgVMMtsn7riEGE3RSgi52dkhxFYL3Lw+4vdwIv6iTy2Sr7X03
         KzrSPVz4Wl29m49qZMCH9Cn2wxO6KguX6lbsUybq2UVB8K8X+DnmT3vviFvV5IHKDZX1
         WM4A==
X-Gm-Message-State: ACgBeo1+IzjWMO72NeYLQ3oI5GZwL2QB4wH+abDxZ3865C5SwGFd/aEn
	mn6xvW0KVy8KW3h1WHdOpJw=
X-Google-Smtp-Source: AA6agR4w6aZMPi6cpzcCwIclFPfEwGVo8/KdfU9B4JBAlrDz19GDQ32yg1HkC6aVwcDa1gVOoM50cA==
X-Received: by 2002:a05:622a:174b:b0:343:1fc:14d8 with SMTP id l11-20020a05622a174b00b0034301fc14d8mr29317121qtk.579.1663099111308;
        Tue, 13 Sep 2022 12:58:31 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:30 -0700 (PDT)
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
Subject: [PATCH 10/21] mm/page_alloc.c: allow oversized movablecore
Date: Tue, 13 Sep 2022 12:54:57 -0700
Message-Id: <20220913195508.3511038-11-opendmb@gmail.com>
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

Now that the error in computation of corepages has been corrected
by commit 9fd745d450e7 ("mm: fix overflow in
find_zone_movable_pfns_for_nodes()"), oversized specifications of
movablecore will result in a zero value for required_kernelcore if
it is not also specified.

It is unintuitive for such a request to lead to no ZONE_MOVABLE
memory when the kernel parameters are clearly requesting some.

The current behavior when requesting an oversized kernelcore is to
classify all of the pages in movable_zone as kernelcore. The new
behavior when requesting an oversized movablecore (when not also
specifying kernelcore) is to similarly classify all of the pages
in movable_zone as movablecore.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6074961fb59..ad38a81203e5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8041,13 +8041,13 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		corepages = totalpages - required_movablecore;
 
 		required_kernelcore = max(required_kernelcore, corepages);
+	} else if (!required_kernelcore) {
+		/* If kernelcore was not specified, there is no ZONE_MOVABLE */
+		goto out;
 	}
 
-	/*
-	 * If kernelcore was not specified or kernelcore size is larger
-	 * than totalpages, there is no ZONE_MOVABLE.
-	 */
-	if (!required_kernelcore || required_kernelcore >= totalpages)
+	/* If kernelcore size exceeds totalpages, there is no ZONE_MOVABLE */
+	if (required_kernelcore >= totalpages)
 		goto out;
 
 	/* usable_startpfn is the lowest possible pfn ZONE_MOVABLE can be at */
-- 
2.25.1

