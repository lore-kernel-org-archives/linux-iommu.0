Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077635;
	b=oTOglywyCR1z4OR6dvU811mvDmK4O6hXG3z3UoNb9Ig299Nsu14zTlIGOCvP8VlRAoU1
	 vaxZdbgntq8w1L8zBNMNCZoy8auko/WmAkrEZ6KjWWQenLR33HbIm5nAIQyok39GFX1wn
	 v1dxjFd9ogcYQSbZIC6S6oajzE4lOoINqkkj1vzQMfdluw91AEABj90mZnjZHn61VlGfy
	 TN7FRLV2YU1uSIOV9GddpQaiXWqEDHiA55MXzwxpfdngXe1iTpN/dgdYk1rahEDjxSbkq
	 MmklV7unpiABTIzGTLeSp1DpAogH+Ivkc60amX7tZFaiwEmsTWPfs/BD5Vr/+gqtokQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077635;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fypsmh/yalmylSlR4JWqGqknVIfjPZ3AfNYwQxJkT78=;
	b=KKqBlT6uD51Jf0H1UZWsiWM2WXBxVzRR9VEzYVVmsCuZtkIT8FVmZGz03QAuN/WCJmBn
	 s+ABLqNoNeeNVqsotQrRqUoA8YssVFCa3V3vj2KwpGrcpnONU31KuBJ6LMOPJoX8A25IH
	 CTPPNW/jhsA/77VRJJKZmEbsNPcPBPwxGSOTva+odXk29k1KLIdbfJ8R0zVUaO7CZbEsP
	 kSIZTlfCCYB2bKwapT4pfFiVxM2gchuH+VUBbPQSH4VdrpRuBa04feqGacC1dAgoZOTRM
	 w3uJSWxlcujb0Hc8wtijoXI1mGL6F7mLHNVqqKLPxVgw7RBHlj6+j7hrMBGfIazyJ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DhgOlSo8;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4160A6F61
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 08:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F4160A6F61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DhgOlSo8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=DhgOlSo8ucLm1RtvW2+pJEPUAmE0+8OXc+rtX1kNNc8cEUFMQ4PmvjfhO/B6i6K34xdCRsxK8bPp7
	 58zcZlhPP3bM7P2B8jpD1/k0Y2gDjglHcZGZ151gN/upTiCxvxLZeEDdg28+nKnXk/RiHeSY2+sSq6
	 Hj7iQpjZlHxhgDik=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afeb5ffe07-bc4c9;
	Thu, 19 Nov 2026 16:40:31 +0800 (CST)
X-RM-TRANSID:2ee86afeb5ffe07-bc4c9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46afeb5fe31f-f6eb7;
	Thu, 19 Nov 2026 16:40:31 +0800 (CST)
X-RM-TRANSID:2ee46afeb5fe31f-f6eb7
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>,
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com, Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: [PATCH v2 1/2] mm/gup: add file_is_memfd_compatible() helper
Date: Thu, 19 Nov 2026 16:35:31 +0800
Message-ID: <20261119163531.788514-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memfd_pin_folios() accepts only shmem and file-hugetlb files and enforces
that inline with shmem_file() and is_file_hugepages().  A caller that has
to know up front whether a file may be handed to memfd_pin_folios()
cannot use those predicates: since d3710111839d ("mm/shmem: make
shmem_file() check the file's inode") shmem_file() is an out-of-line
function in mm/shmem.c which is not exported, so modules cannot call it,
and is_file_hugepages() on its own is not the same question.

Provide the check as an exported helper next to memfd_pin_folios() and
use it inside memfd_pin_folios() itself, so that a single place decides
which files may be pinned.

Signed-off-by: Jiahao Xu <xujiahao@cmss.chinamobile.com>
---
v2:
 - Rename memfd_pin_folios_supported() to file_is_memfd_compatible(),
   suggested by David Hildenbrand: the predicate asks about the file, not
   about the memfd interface.
v1: https://lore.kernel.org/all/20261119104417.312237-1-xujiahao@cmss.chinamobile.com/
---
 include/linux/mm.h |  1 +
 mm/gup.c           | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 040cff643..dffcc0b5a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3600,6 +3600,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		      struct folio **folios, unsigned int max_folios,
 		      pgoff_t *offset);
+bool file_is_memfd_compatible(struct file *file);
 int folio_add_pins(struct folio *folio, unsigned int pins);
 
 int get_user_pages_fast(unsigned long start, int nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 7605da0e0..da8a2c29b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3449,6 +3449,27 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(pin_user_pages_unlocked);
 
+/**
+ * file_is_memfd_compatible() - check if a file may be used with
+ *				memfd_pin_folios()
+ * @file: the file to check
+ *
+ * memfd_pin_folios() only accepts files backed by shmem or by hugetlb.
+ * This is wider than "is a memfd": every shmem file matches, not only the
+ * unlinked ones memfd_create() produces, and file-hugetlb files are not
+ * memfds at all.
+ *
+ * Callers that have to validate a file before pinning it, or before taking
+ * a reference to it, can use this helper instead of duplicating the check.
+ *
+ * Return: true if @file may be passed to memfd_pin_folios().
+ */
+bool file_is_memfd_compatible(struct file *file)
+{
+	return shmem_file(file) || is_file_hugepages(file);
+}
+EXPORT_SYMBOL_GPL(file_is_memfd_compatible);
+
 /**
  * memfd_pin_folios() - pin folios associated with a memfd
  * @memfd:      the memfd whose folios are to be pinned
@@ -3493,7 +3514,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 	if (!memfd)
 		return -EINVAL;
 
-	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
+	if (!file_is_memfd_compatible(memfd))
 		return -EINVAL;
 
 	if (end >= i_size_read(file_inode(memfd)))
-- 
2.43.0


