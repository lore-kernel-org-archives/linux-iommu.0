Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760C37E310
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832575; cv=none; b=t/zc78QerKyJKRM3ke9YcKhjb6EsNpIDL9XDcHIpNgjLS9fmst02+938RD/s9eWQ6kizTocqJJ55Pt/phQcRwQREtkXP+P7elCeHKjx610EWh5QbURTbf6qWZz8CX1pgL6FTO8JMZjNiQRnAMVunnkTSeqghooQLHpqs1y5Gsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832575; c=relaxed/simple;
	bh=w2scubrWigPI5aAVKJGSmibtcgc4McVhvAh8XisAp4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FXkLq+auLuUb5kPQLR8tycuYUsBZMRiPCeoB/5I7zGQo0wDsDLDpeRvdHFDU26ypeF7oHxCydMq5u05SiNVz2ubg3vI6MC8DCIHssBwEFOKKVKDxgNhluVpI6zUZi0xdL/W17rHH3Czmt9EnP55YiBkvjrEhCbbpfr8Lj5ju2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTzBJn5b; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTzBJn5b"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b871e14de77so1107231366b.2
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768832572; x=1769437372; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nuz806mp9+5PhIDWKxO6w4brkXaM9E/Fe3SahLfIE4=;
        b=mTzBJn5bem2EuKJAFn1msuT6F8e9AQLGHpubfl7iUtvv7gAkGs1bIjow9PKVxpl4t9
         /ralw8fvTXnzrcCjTfbmQLCvFrkbkRSNBugFiAFAiMnRUOS3iJvwxk3l+WqJnzMwmZzz
         V7xIEZAtFgzYJMi6UHbOmLhjIJ9x/g8MekLdgj+IVvHQZLcHi3Mr518805g/StOoATl/
         ceWekOoQLVoVa1T+fLzY0qD09/fj51lkkPKYBgT2vH5GGH5F3v0B7P2kAK/Xo/d+MCYF
         GuFEMAxHL/s9+CYUzZlF74rCaVtANQ/EVCiNMNAimdK7xLSPOGs76vP3NA0kciKC1BmM
         oC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832572; x=1769437372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nuz806mp9+5PhIDWKxO6w4brkXaM9E/Fe3SahLfIE4=;
        b=hSqGIzDZUObWTW8S8d/Z1UG6lpkcrfkG+PGUp/61LNDJPcpN1/LyJPptB0OYtH1T3R
         +icbktp6HrbAuvF5IqqmNK30v8+WTgwyV5azOvCk4J3C5mQEBlGzZhaLFFzcSTj+EHPn
         +PSXe/Y+06nPraNb7iMHMYb2ZxS3XNW8PBa5SFhOSRyBibIs9g73pLwxvuLfkD5gBPUo
         Poczk3WyuXFF/3ooQ+uPfo7ffHUTIpQ9XJPfDeh1ewFFznPu3PFt2Y6XKl5E1xygQUlh
         D53SAq+tuSn2UYNx0fXhF4myQw6lIa63v5XAqm+hYEt33r5ZIKhtN2wWVn8AcrVnlorx
         HIvw==
X-Forwarded-Encrypted: i=1; AJvYcCX/UAm86+ZEJnboUgpKSqNQldhZVqxp6cifkpCe4FXNym+Yv/18MruZaxKxGUsK1aDwJ1XFlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf7O9lfaPJb+a5467aKObLd4ULR+qzwoIpdH6yeECmd3FGIY5m
	19fQMQMI82dlg151XtJlJpllzpMgkML9bo6vu5MBwExMBcCS129M3cLGBg4c4WdtLmeUvvgd4rt
	ooza4vzTAp4r2pg==
X-Received: from edrb16.prod.google.com ([2002:aa7:d490:0:b0:650:5e46:20c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7ba5:b0:b87:191f:4f96 with SMTP id a640c23a62f3a-b87932557e2mr1034243266b.61.1768832572024;
 Mon, 19 Jan 2026 06:22:52 -0800 (PST)
Date: Mon, 19 Jan 2026 14:22:45 +0000
In-Reply-To: <20260119142246.3821052-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260119142246.3821052-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119142246.3821052-2-smostafa@google.com>
Subject: [PATCH 1/2] mm/page_ext: Add page_ext_get_phys()
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

In the next patches, IOMMU code will add data to page_ext.
The IOMMU code would operate on physical addresses which
can be outside of system RAM.

Add a new function page_ext_get_phys() to abstract the logic of
checking the address and returning the page_ext.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/page_ext.h |  6 ++++++
 mm/page_ext.c            | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 76c817162d2f..bd373496e166 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -93,6 +93,7 @@ static inline bool page_ext_iter_next_fast_possible(unsigned long next_pfn)
 #endif
 
 extern struct page_ext *page_ext_get(const struct page *page);
+extern struct page_ext *page_ext_get_phys(phys_addr_t phys);
 extern void page_ext_put(struct page_ext *page_ext);
 extern struct page_ext *page_ext_lookup(unsigned long pfn);
 
@@ -215,6 +216,11 @@ static inline struct page_ext *page_ext_get(const struct page *page)
 	return NULL;
 }
 
+static inline struct page_ext *page_ext_get_phys(phys_addr_t phys)
+{
+	return NULL;
+}
+
 static inline void page_ext_put(struct page_ext *page_ext)
 {
 }
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 297e4cd8ce90..5fe65a0ac4f3 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -538,6 +538,29 @@ struct page_ext *page_ext_get(const struct page *page)
 	return page_ext;
 }
 
+/**
+ * page_ext_get_phys() - Get the page_ext structure for a physical address.
+ * @phys: The physical address to query.
+ *
+ * This function safely gets the `struct page_ext` associated with a given
+ * physical address. It performs validation to ensure the address corresponds
+ * to a valid, online struct page before attempting to access it.
+ * It should return NULL for (MMIO, ZONE_DEVICE, holes, offline memory)
+ *
+ * Return: NULL if no page_ext exists for this physical address.
+ * Context: Any context.  Caller may not sleep until they have called
+ * page_ext_put().
+ */
+struct page_ext *page_ext_get_phys(phys_addr_t phys)
+{
+	struct page *page = pfn_to_online_page(__phys_to_pfn(phys));
+
+	if (!page)
+		return NULL;
+
+	return page_ext_get(page);
+}
+
 /**
  * page_ext_put() - Working with page extended information is done.
  * @page_ext: Page extended information received from page_ext_get().
-- 
2.52.0.457.g6b5491de43-goog

