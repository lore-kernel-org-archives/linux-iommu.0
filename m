Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E983823BD
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806983; cv=none; b=WwRExo83BGeFFIL6UTH5n2TRYnRw8n8BBg5tqByKrX2rjCfA4jbwBPb56lRVI19CJPrEkedn2QSilDPHaWs5wvP4o7VZkWKXp4bJyzWx2fQbSdAAU0WMAQgmxEbyTNDQRSqhD8/2YssGj6ES1N6dtvNRg1cT0eAdLq2eQAYjC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806983; c=relaxed/simple;
	bh=KQhGj4yMV2JJyYTphSuwtYusktgVAWzYxv4GDdmnyDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ps4bldzupIHUWrZfBASOVSf2yl6cj7JFPPjoUGqJE1h8zQc59TLhwcrM5vQzeKddbgtwX+Gv8qa6z5tjgiCTnzndWCQe9rsT7uSOrC0DmcXEm6vCixZ6CvlNPUANLqXftFpYBgyzahd+w7M+dt+9bxwPkxZtSqb9wDIUzCEyOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2oyJ8gc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2oyJ8gc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkrXh5PHMEq3NY5i+0892fbAshOERsmwyMLhbVIa0Cc=;
	b=U2oyJ8gcZWaRqvZbLlOpcGyc+KKbvBbNeLdciBF6tu4Gu2t3VVTb+MdG9gSW3pHlIDo+7j
	4gWiaNiLD6kKIXVSurvL1Rc1q8SmSkvl88b0Dki2tQ5DsXqz27lW1CgKYnPG1UZuVGIztO
	97kz6NgPF98sNAswfXmAoax31r8wFOg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-fxI_YwtDMl-c8RvFXxo16g-1; Thu, 21 Aug 2025 16:07:44 -0400
X-MC-Unique: fxI_YwtDMl-c8RvFXxo16g-1
X-Mimecast-MFC-AGG-ID: fxI_YwtDMl-c8RvFXxo16g_1755806864
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so7742295e9.1
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806863; x=1756411663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkrXh5PHMEq3NY5i+0892fbAshOERsmwyMLhbVIa0Cc=;
        b=chGhCUqkkHojBZoFtS+6WcAJn7cngpxXUqTgWBOs1r2leMeLeLPrLT3pIjdza38rny
         zzZVrHpfTYrIMCNKzzEvxG+VSTTF7KT+StArrg4/1ykHdFrkVbBr0z73BORxCYTX3qGo
         XfnJ7BH7DMj0poC1jr1QYgvVG9W/bxSoEM2CnzPdp1k04fsXd9doubXJwJQwpJwqbeZn
         52FTnrYh3lazotMlMHf42CamHrlx1gEIhhYleZ8OgEn5h4cb4GuRCWDqpkRjeKVYb/y1
         7bliJ/Mpqbobtvhn8c2qkVg99laXkUOfo37RRM9NPDu2qjdpL4Vf8AstAHJEkAZtcd9N
         4L2g==
X-Forwarded-Encrypted: i=1; AJvYcCULE58fAlwl0z5OgTXoeMWHYMlNCO+vve9rtLWk+fk/p1TC+faobYX2P6AJXqTVqZzr7j2VxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0jvbIpp2TPxcJT7G5UuloxrIrTZ/lyPsF4RnvH6l/IHg+lpwM
	dVWfqL7fb/PNq3JrG1ziu9NEIs3FVIoLXzBNdamB+bZtoXPJ1+FE6fTgGGGFCIrW/iJmWh5xMlh
	LCR/vDGQf6Mb+X4xybVUb+vf6M6JGTbG42kN4biDBopJSPTN/U/VejGFn
X-Gm-Gg: ASbGncvlMDD2UT+a+ncKe8uhlcZcic4EkcO66JWfO/HjexdA+IWAaND/qE3Qm03ziZQ
	SSpx7h/RSPvcWjivPT+8zfltLtv4g5tQaQXsTqZCKBTkmInLiVe0Cc4yPq5j+vVJtispP0wo3ei
	sH4xy6VIZgmUhHOOx/mdOR5rdRAsUXZ/8UfwuXOu3ru7376GRGXfOfp1SO5aia5Vqba9SAPxpiT
	dCNo1rweTLSVUkI7Ku3FIEChP9v0SQpRK7pLhnfDNaO+cuy8rNzjLcJFOX5k7Ntg0B81/DbAKnZ
	v3O+dQ7tBL3ySSv4ktGsINrdSGTCFu26rTPLUpemzSdvcghje6aNWtjxyI/1tWBDhj3HTB249Fg
	maa18wJy9SYZ/3xZX5B0u7A==
X-Received: by 2002:a5d:5d0a:0:b0:3b9:14f2:7eea with SMTP id ffacd0b85a97d-3c5daefc2a3mr192564f8f.18.1755806863494;
        Thu, 21 Aug 2025 13:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB28V/U3gI+p1afMr2c1HujEN1g59N1A45YIj+RBO5vrtdOMlsNhrN6BtrkE7YShkW7nBB8Q==
X-Received: by 2002:a5d:5d0a:0:b0:3b9:14f2:7eea with SMTP id ffacd0b85a97d-3c5daefc2a3mr192518f8f.18.1755806862961;
        Thu, 21 Aug 2025 13:07:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b51b61256sm1742995e9.3.2025.08.21.13.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:42 -0700 (PDT)
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
Subject: [PATCH RFC 13/35] mm: simplify folio_page() and folio_page_idx()
Date: Thu, 21 Aug 2025 22:06:39 +0200
Message-ID: <20250821200701.1329277-14-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -ATeKR5b9r57mJ5VCVUEoTDcmw4MRC9DrFEcs0aJQxw_1755806864
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Now that a single folio/compound page can no longer span memory sections
in problematic kernel configurations, we can stop using nth_page().

While at it, turn both macros into static inline functions and add
kernel doc for folio_page_idx().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h         | 16 ++++++++++++++--
 include/linux/page-flags.h |  5 ++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 48a985e17ef4e..ef360b72cb05c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,10 +210,8 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
 #else
 #define nth_page(page,n) ((page) + (n))
-#define folio_page_idx(folio, p)	((p) - &(folio)->page)
 #endif
 
 /* to align the pointer to the (next) page boundary */
@@ -225,6 +223,20 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
+/**
+ * folio_page_idx - Return the number of a page in a folio.
+ * @folio: The folio.
+ * @page: The folio page.
+ *
+ * This function expects that the page is actually part of the folio.
+ * The returned number is relative to the start of the folio.
+ */
+static inline unsigned long folio_page_idx(const struct folio *folio,
+		const struct page *page)
+{
+	return page - &folio->page;
+}
+
 static inline struct folio *lru_to_folio(struct list_head *head)
 {
 	return list_entry((head)->prev, struct folio, lru);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d53a86e68c89b..080ad10c0defc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -316,7 +316,10 @@ static __always_inline unsigned long _compound_head(const struct page *page)
  * check that the page number lies within @folio; the caller is presumed
  * to have a reference to the page.
  */
-#define folio_page(folio, n)	nth_page(&(folio)->page, n)
+static inline struct page *folio_page(struct folio *folio, unsigned long nr)
+{
+	return &folio->page + nr;
+}
 
 static __always_inline int PageTail(const struct page *page)
 {
-- 
2.50.1

