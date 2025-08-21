Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FB35209D
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806874; cv=none; b=s+IHpL6hBEMT1VEiCd1xR29yr0ouE2RUxI6t99R9D66r9fRv6Cz9qaD1dljX5glqrHYdS9SYyuj9SVv4V0UgzDEUDLQm95JjmqypISSQuJoTJWN9HtKhqgrAtZxRp/Q1OIAzY0ZLYDpmb/EyU9rGqNbbRG6jSCN2WDDcsctVBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806874; c=relaxed/simple;
	bh=d4tmPeOlqOBXo+X4Tiv9h/CbkpHAugux1EiNuLc/Y0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TGJcH4UhGXR9oK4i83RA0ZBhVZASFx4UBeeuzqUo8QkFhftzLyILmXUdoAYv05gPPp8672/89zTxZ2o5HktjnYJumVglI9/61RAM9ImZq3U0b0gUVYOpp4bjhLBMc1mAx/0skoCLPTAxFFiFVCXEeAybrId5EQUfnGWeTxWA6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWRZzC5I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWRZzC5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzMWVCGQW0mP4+/ULAfe7CdOmgWkAKLnoxAB4Fy092E=;
	b=IWRZzC5IsVlSxbV8LOgcIqYVH3xDPPkD5smnBkNlJmhYzdKrtZyyjbN2K76bWUFfqbwrs9
	ef5TOSeMjccHyioNA5TOo12Damqmlfl77rwzBVipmkAjBzNz9El3RETVsFS+m91rQMc1H9
	anmhqo6DtIkealFaAritIlt3tzVoDxI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-rLAZ0lqBO4aISFndJYAQlQ-1; Thu, 21 Aug 2025 16:07:50 -0400
X-MC-Unique: rLAZ0lqBO4aISFndJYAQlQ-1
X-Mimecast-MFC-AGG-ID: rLAZ0lqBO4aISFndJYAQlQ_1755806869
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso7258255e9.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806869; x=1756411669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzMWVCGQW0mP4+/ULAfe7CdOmgWkAKLnoxAB4Fy092E=;
        b=IHW+4N9/vGH/8ApUl0F3WYAKLyEhWlrGvRfPgZS3YO6/F1GQdLP17/aeNIeqVEkR1a
         A+XfXhINPp/LKgmqTg6WkxJ3+4JuSKLcMr0IvarZbG1lHcDrpPnUzBXegSTPjpUdFwRo
         7jW+ZiqD8fauMQasOs3jdnqcpwxSoeGZG25ilHgqv6L36D6EvjICq4dfA6GE6r18fGZf
         VL/mGjON4y/Ufb8tzipliF16PA5UY3o8++B3VRBb3ndzyStuMJQzxC9vi9nhr69VUmNc
         KvDt3GX5SKXI3aoH7j8P/MoaWzPEx75XmuROSPzX++X6By/anStLJq63+lAobxERqFvY
         +8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH5aV4BPuovFC86huJgNRrdnrATSQiW/wlK0Pdcvzwj6fD9/kc6hnq6Oj+7IXt5MSAVpblow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+26pJSa1H61VbvrnpTg9ocZUTufjzNR1E8hIXQ3aA9hjLEvG3
	PMb3MQu9ojuO3nxfuv/I9WLqoLvoYm0WLtpO6aOx5aPIjGQT8h6DJTl/725PJIxcxZdxJcQ8reg
	5WuLfoBJqUIPb0cscCJ6u/QwlVw3oyJBMZjMwm5rjli8GHJBZVinzaHOF
X-Gm-Gg: ASbGncsiCbVno+AyjBUbJLFz5PVcI0an6EBhRGzoi7U1pGSivNDoajtb2UM602+UmtD
	j3fe2Z+fxu682wUy/KQT2r0QNds3wjg3MXzx7VfseZfoY/hlKDI9YJAGSbnoDVEUxAjqX+un6xt
	tNNZwDiawiHEgvjKb/fddFLPgypqAmnsOatr6qxDgOV2puis6JGGmJ5TjkxSdL/GQ6U2cZWJbru
	hYOPzttz5E4tfe5ErPkElUKYnunbkAJClsFx1/4FyNYd/GCxw7+a0qnyziOUTtUFMoAik9PsdP3
	tij/w+KwbeqcQxgHUuOrXY11esT5T1T1b9GvMaKl0MrUWEbNCTUdXVYUVgwIMlPKBRT9885E60o
	vcMpMzQknuiC20eOdyc1u/Q==
X-Received: by 2002:a05:6000:2901:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3c5dcff5f3amr167801f8f.59.1755806868896;
        Thu, 21 Aug 2025 13:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCm64ALptQrKyrLlaLt4xJ2vziBy3gZm4Q1WMVX6wnWhr2W2tRcHnZJHBwxpAOnTfL4mKx+A==
X-Received: by 2002:a05:6000:2901:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3c5dcff5f3amr167760f8f.59.1755806868453;
        Thu, 21 Aug 2025 13:07:48 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c5826751d5sm1323274f8f.14.2025.08.21.13.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 15/35] fs: hugetlbfs: remove nth_page() usage within folio in adjust_range_hwpoison()
Date: Thu, 21 Aug 2025 22:06:41 +0200
Message-ID: <20250821200701.1329277-16-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lwpLZ3fPXq8alxUbvStTfJHYsfUwum5RVsRap_EDZpM_1755806869
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The nth_page() is not really required anymore, so let's remove it.
While at it, cleanup and simplify the code a bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/hugetlbfs/inode.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 34d496a2b7de6..dc981509a7717 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -198,31 +198,22 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 		size_t bytes)
 {
-	struct page *page;
-	size_t n = 0;
-	size_t res = 0;
+	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	size_t n, safe_bytes;
 
-	/* First page to start the loop. */
-	page = folio_page(folio, offset / PAGE_SIZE);
 	offset %= PAGE_SIZE;
-	while (1) {
+	for (safe_bytes = 0; safe_bytes < bytes; safe_bytes += n) {
+
 		if (is_raw_hwpoison_page_in_hugepage(page))
 			break;
 
 		/* Safe to read n bytes without touching HWPOISON subpage. */
-		n = min(bytes, (size_t)PAGE_SIZE - offset);
-		res += n;
-		bytes -= n;
-		if (!bytes || !n)
-			break;
-		offset += n;
-		if (offset == PAGE_SIZE) {
-			page = nth_page(page, 1);
-			offset = 0;
-		}
+		n = min(bytes - safe_bytes, (size_t)PAGE_SIZE - offset);
+		offset = 0;
+		page++;
 	}
 
-	return res;
+	return safe_bytes;
 }
 
 /*
-- 
2.50.1

