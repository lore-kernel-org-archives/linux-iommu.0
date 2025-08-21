Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0F35E4E8
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806880; cv=none; b=ef97SAgPbfoAzu3+DCa2jFku++o5UGQ0MrBqt9i93mg2msaxPwCOyqo+i9LyWIHlKEChabUSFdqs4tppUMr2x+uQLAAosxBfgCYiD2yGQEmb9VZJ7cMenUB0MWURGEq/+g9QiQ2Q3/MZcC94kDUBM2yQPJ1u2iYuLGaxtKNyZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806880; c=relaxed/simple;
	bh=jeuBd6AEd//7dLky0U/9/K8CcfgAIF74DmeLEQ7xh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TR+KRUtmIx2xjCjN1ZjWy8sUGJKhF3nu6ZaqCP4deRPu9HGB3F76CJpiADTzLoz03v2A19rPgEpJ9/ppUjrXCwn+GIdNSq4ktu+/06y51HKd9ejMfWIo7woGgvibRP6eblqBQMNasMqWBrwQ4GdYpRO8B+sfri5r+08IhDCET8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEc/ixVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEc/ixVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
	b=FEc/ixVICnw8V0P32ZbsdqRyeMv5FyRbJKdSAbLGDxqeG/a9uo40Ij8nhW+SV6xNCFpE8/
	xC86E4obxyA9N/IdytmeQWP/ZdVM3m4oPa4PhmUGQCZ92Juvw+uHbCf1fq9klrN+nAcE9/
	0JAH6u3T9oQGr2IILZsnO5QN0Nzt/Lk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-7BGOMZ9tPqG9nXtF23DHXA-1; Thu, 21 Aug 2025 16:07:55 -0400
X-MC-Unique: 7BGOMZ9tPqG9nXtF23DHXA-1
X-Mimecast-MFC-AGG-ID: 7BGOMZ9tPqG9nXtF23DHXA_1755806874
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so6771705e9.1
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806874; x=1756411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
        b=cejymXkLLxdFQDZfdgFq5mTkfmNvc6Kok15QLJYeOslcKg5gUbrXCsr6tSURTHJ+sN
         1UY2WVBLlYMdMdKPxKW5MqHJU6cdEiQ2LmmA/xvy6bu38J5ElHn3xbTR59oLyPTK3cA+
         2NjIqY2NWbIKuljdHvmHffZi+YAT1wX9pl2bCWIh7W3VmpjxUh25fjgGYk/wBz1s+BxF
         c12kuT3yGEwBTVqsqcvT5KDpCCDYISnXv4ll8f812oP/Tm3VmEaUodD1YjITbqrwEvfY
         m1fyoykyjyZeZ5f0Rp6tiTHK3XOnTTL6WFiGSB2dy92krvYB49uU9JvuWvGUJehPJGh6
         dgqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqYKL5q5j8HJQ+p1wXgg3iG2xzxLpiOX93h1nn/0v8Zr5nkuNyyhDkIKAME4ioQLGtxVDlOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjbojevOHydby3F/8dMVHFFg2/3P6dQXV5XzY9L9KR9dx1ovLa
	oH1DL3arEUAVnSMeisl4r6gUBemT7W/VYNNLmm7AERPUXfykDtEVGOyMkS176IMTqlAlQzFcCY8
	0eDTtmrWHqr3JOEz1vCurXGHd/OJ4BhyFgQCHetmoO1Io4dRaokJQgWMP
X-Gm-Gg: ASbGncvkpVk6cIWWi58HorxfjPmNfaLkzoBzovMBT0Zkcr4S546E3QZZF9+R+dMnmNr
	SliUlKmi8uyI9T5PUWQruDK2lYZyoF2pdYx2AyoG6VkspC4YB6+V1ng6uHiqCXiX0brHDM/Gxe9
	9U7lkAVOHMlb403P0+Vd3I13FCIOW2nhO+nAtOF7LxUoAG4n7IHG9CepRbR767iyIw4h2HaqmDq
	h2XFwCbYPbvZPdVgAr5QMJhWoZ6/aoPg0hJxb2fuTZUtgSt9KLew7C56b81PWp3SxDwbm9vezeF
	APH4MkqziZrHwoXeZusIdUjEovNvBf6m+C6ccPAE4fwYh/cQwBSNv+wEh4bZt0yInva1Wu3P9+i
	+7cBZerqRvwkl35mvaEdymg==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2554475e9.24.1755806874327;
        Thu, 21 Aug 2025 13:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8ikhW4DoWVw60oDeAXqMRvn4UERlcVawLCjGel2pacwRc1R1ONhYVQm5EzuW0YIJQT4FDg==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2553905e9.24.1755806873856;
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487a009sm12690403f8f.11.2025.08.21.13.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
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
Subject: [PATCH RFC 17/35] mm/gup: drop nth_page() usage within folio when recording subpages
Date: Thu, 21 Aug 2025 22:06:43 +0200
Message-ID: <20250821200701.1329277-18-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: MMdqqVN__1ivgBQ4q0S8r62U5lZtWZ58s1wwv5DsTOY_1755806874
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

nth_page() is no longer required when iterating over pages within a
single folio, so let's just drop it when recording subpages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b2a78f0291273..f017ff6d7d61a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -491,9 +491,9 @@ static int record_subpages(struct page *page, unsigned long sz,
 	struct page *start_page;
 	int nr;
 
-	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
+	start_page = page + ((addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(start_page, nr);
+		pages[nr] = start_page + nr;
 
 	return nr;
 }
@@ -1512,7 +1512,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			}
 
 			for (j = 0; j < page_increm; j++) {
-				subpage = nth_page(page, j);
+				subpage = page + j;
 				pages[i + j] = subpage;
 				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
 				flush_dcache_page(subpage);
-- 
2.50.1

