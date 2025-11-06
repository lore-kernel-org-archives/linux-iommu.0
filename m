Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30430346796
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447216; cv=none; b=QnqaVtwG5kUvBv2hW+DVkxWPJOOLQPtVy927bIo2Ij/VyBsVA+b4QrYotkmCtN3+wjkoK0ZNF+dZJ/E/PylqVM3Lg1Usn6dBChEvWSSWK3/cH1IzE0kLwjn0/NtXh6DCQ1AnHOqHUpncEpmB8T6tNFukoOct0Y2x2PtSlFuA7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447216; c=relaxed/simple;
	bh=QPnuTeoHkJAdsy3GLHh3OinUFPR46uTzV5UBwbwi06c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQ84w/BDbuQ9TGk+awPrJjHuX5M6RrRsJxgfnaknPGg8OKVXyPpGiGHQRCIdgx4iX1c1JRQKoly5+E+aGTqjSw9GS+gHMsPpFtuQaYqFhxoWYTwncLycvC2XPl62L4+TNUKoJD6zCcWu3tlJYzt7bn8t6OKKKFcXt5ESVE6+Mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ablX/9w; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ablX/9w"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso934035f8f.3
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447212; x=1763052012; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM/GZbyZiL8bh5z49/8PTeWfbgNSwSL55H6jI2E+lmQ=;
        b=0ablX/9wufQvKwrbeKCUI+R+uIqJmfETYB2sro/sQVPPaVs67XkJe7hPgTRSAVj1Br
         DvL1bROMlyIv34xMr/ORVPiPUtI0KUICMF7pTcZw5rDz6hknrmzrnxijSFljPtwPVEz9
         hJ1Pc53k9Umi5XijQbAhj5HLm47MenP1JJ83AKg6Ceyhz8JGAySLpBqPu8ks9UIfgqcz
         1eg7dsQbzty0R6my3g3k1lXMIvpWVSiSaMZzHBzM8qqrcvYBsze/YZlueFr/22uyRCXU
         Gt41R+VEazKMp4uhTdYgajR5eL/fPz3O4Ihx/RTUeEiIkhBc99pPJOEL/QtzxD5V4T2C
         L3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447212; x=1763052012;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NM/GZbyZiL8bh5z49/8PTeWfbgNSwSL55H6jI2E+lmQ=;
        b=vmyoPfV9tHC9iXCQRdyXWIY6GQ6pXM5XK19dTxwvUSqWOSxaAsmJS3bZlH1kX10Wd1
         OScZ07hHf43ulbr2Sk7NYyBTZ83gvZ9SmnfbJJC2BfjmWLFeghw1HexqAwG026maDR79
         DoDNgsHx4mhXFT6T/G5LqjaWsq42EXJ0tOh0hkahJUhjc3OIJPlyohxDP37dXOu80nfI
         sX7QlDeUFnnc7Y1E4Cb1T6ypwxU3oaOX4b+2aAYP8fSWXY2yNXReOutFMJRjcjeQixBO
         VEK/kH6oiYnn/A1rpWtLEnb2PkrnkraCKXLQOUqlLWrIjfy6y/n7bu/Z1JhsXTFfBoSQ
         XWfA==
X-Forwarded-Encrypted: i=1; AJvYcCXpXxrwg9Jf0Nt2xosZd2HAKdyMamzVp9aCowVAEPxt/X4k4jj5JxgfwZBL5JuPGkXInCXDew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrAm5TE295gV1vZx3suJ7jSQ3Zb75QpF0f/FI70zdbgXpVCwak
	PMOObkoPewhl6cu+UKvg7qZPDUkG6Klc7gfDBeuUMrOjofLimq/T7tWevByOvf8lfKy0xwskplF
	eYsniOub8dj1DbQ==
X-Google-Smtp-Source: AGHT+IFXE6Qsd8iIgYNiQDlI0sqI8FtMmoIupsqXvZU2YQ+mpshBBiH57cinC3fDVEftkTGmawxtksFJp1JKIw==
X-Received: from wrsy17.prod.google.com ([2002:a5d:4ad1:0:b0:429:dc18:dd64])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f87:0:b0:429:b7cd:47ff with SMTP id ffacd0b85a97d-429e33083c8mr6867222f8f.40.1762447212631;
 Thu, 06 Nov 2025 08:40:12 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:53 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-5-smostafa@google.com>
Subject: [PATCH v2 4/4] drivers/iommu-debug-pagealloc: Check mapped/unmapped
 kernel memory
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now, as the page_ext holds count of IOMMU mappings, we can use it to
assert that any page allocated/freed is indeed not in the IOMMU.

The sanitizer doesn=E2=80=99t protect against mapping/unmapping during this
period. However, that=E2=80=99s less harmful as the page is not used by the
kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 19 +++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h | 12 ++++++++++++
 include/linux/mm.h                    |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-de=
bug-pagealloc.c
index 0e14104b971c..5b26c84d3a0e 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -71,6 +71,25 @@ static size_t iommu_debug_page_size(struct iommu_domain =
*domain)
 	return 1UL << __ffs(domain->pgsize_bitmap);
 }
=20
+static unsigned int iommu_debug_page_count(unsigned long phys)
+{
+	unsigned int ref;
+	struct page_ext *page_ext =3D get_iommu_page_ext(phys);
+	struct iommu_debug_metadate *d =3D get_iommu_data(page_ext);
+
+	ref =3D atomic_read(&d->ref);
+	page_ext_put(page_ext);
+	return ref;
+}
+
+void __iommu_debug_check_unmapped(const struct page *page, int numpages)
+{
+	while (numpages--) {
+		WARN_ON(iommu_debug_page_count(page_to_phys(page)));
+		page++;
+	}
+}
+
 void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size=
_t size)
 {
 	size_t off;
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-de=
bug-pagealloc.h
index 180446d6d86f..84110e4ecfaa 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -22,6 +22,7 @@ void __iommu_debug_unmap(struct iommu_domain *domain, uns=
igned long iova,
 			 size_t size);
 void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova,
 			 size_t size);
+void __iommu_debug_check_unmapped(const struct page *page, int numpages);
=20
 static inline void iommu_debug_map(struct iommu_domain *domain,
 				   phys_addr_t phys, size_t size)
@@ -44,6 +45,12 @@ static inline void iommu_debug_remap(struct iommu_domain=
 *domain,
 		__iommu_debug_remap(domain, iova, size);
 }
=20
+static inline void iommu_debug_check_unmapped(const struct page *page, int=
 numpages)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_check_unmapped(page, numpages);
+}
+
 void iommu_debug_init(void);
=20
 #else
@@ -66,6 +73,11 @@ static inline void iommu_debug_init(void)
 {
 }
=20
+static inline void iommu_debug_check_unmapped(const struct page *page,
+					      int numpages)
+{
+}
+
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
=20
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..895a60a49120 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@
 #include <linux/rcuwait.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/iommu-debug-pagealloc.h>
=20
 struct mempolicy;
 struct anon_vma;
@@ -3811,12 +3812,16 @@ extern void __kernel_map_pages(struct page *page, i=
nt numpages, int enable);
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static inline void debug_pagealloc_map_pages(struct page *page, int numpag=
es)
 {
+	iommu_debug_check_unmapped(page, numpages);
+
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 1);
 }
=20
 static inline void debug_pagealloc_unmap_pages(struct page *page, int nump=
ages)
 {
+	iommu_debug_check_unmapped(page, numpages);
+
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, 0);
 }
--=20
2.51.2.1026.g39e6a42477-goog

