Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056751;
	b=HfA2wqwn05wvQdAf73V/MkcOaOESKrmqKGuSsHTxhqQF7xytjyAToAZ5FSxClF/Qdr9o
	 MFcs8hC0vNQx8akYWdovxI2k0qmEnhZZO5pAGZdxr2JFR/FgxPxl65VxcTuKertRoEqSe
	 kHfZAjpErwIvETfTkoo6sovKr2Mjiq3zmBX6BON8n9qAsuMuKB9yDz0rBOGRrevuJm1gZ
	 hQ55tv/80mWy/ui6VrTmXNdeDIHQG/9OPwzb67QIwQiUb+Dk4WVqeL/X3XA+Khddfbern
	 YcjRzbw8Ycf0okp9z7aUCxsvS0NyEHFIRqvD8OFP7NNKqFrq5g/BiEu/hrZTX5266wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056751;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0aPRA4hpiTz1kk65aoPPE1Fyhse+uJcCQXxjdxwawZE=;
	b=aLKL/IFckshhShf/59vhAQDmqdkIb5c/zpDd5sInLlJUbLrd++MVC1uTS1uCqYfr2+9F
	 if65/53Da6zcH4fbDO2q9xSPEtac5xMI1CwlWwRWCpwKDraJZyWoVQOFFxP4qhFyG52Vc
	 u9YwJkm/SuDg+cx485SLR2ft0ZAvKQN2WIgJuF7rk6PiRHGQwpb2zzzE2L1/pzfKc/Eab
	 q7x+lHm+fj5KKJCS3yOWqPo3NpOfIQmKAZ1bAXkOvHn+YMyJPazgstmDIA4PbYSCcyG25
	 cQmHe1j5hI9D0BWTKwfaENX1i0t0HDDepiN0G7WOKsXAdct+USkdcril6rB/VYIb0Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=exaZl6bG;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED42606A320
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 02:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED42606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=exaZl6bG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=exaZl6bGXPTmhuXRv0ayXIUs5qcodj7bz/4qOEuJ/vC9nqxUfX2E1Df0kJY05Ed7CIfW5b2w9mQd2
	 vGheyZW4ToLKwfHjdVhD699P2SBdMVCgqoC6ohb1hWYLUfmm9n8ZyursfHUqSFRsrNFdDxlzsH49N7
	 k/wp0jR+HoB1iZs0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36afe6441bca-e4af9;
	Thu, 19 Nov 2026 10:51:45 +0800 (CST)
X-RM-TRANSID:2ee36afe6441bca-e4af9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96afe643e04d-ecf5b;
	Thu, 19 Nov 2026 10:51:45 +0800 (CST)
X-RM-TRANSID:2ee96afe643e04d-ecf5b
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>,
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com, Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: [PATCH 1/2] mm/gup: add memfd_pin_folios_supported() helper
Date: Thu, 19 Nov 2026 10:44:17 +0800
Message-ID: <20261119104417.312237-1-xujiahao@cmss.chinamobile.com>
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
 include/linux/mm.h |  1 +
 mm/gup.c           | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 040cff643..e401edc93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3600,6 +3600,7 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 		      struct folio **folios, unsigned int max_folios,
 		      pgoff_t *offset);
+bool memfd_pin_folios_supported(struct file *file);
 int folio_add_pins(struct folio *folio, unsigned int pins);
 
 int get_user_pages_fast(unsigned long start, int nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 7605da0e0..90ac51207 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3449,6 +3449,22 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(pin_user_pages_unlocked);
 
+/**
+ * memfd_pin_folios_supported() - check if memfd_pin_folios() can pin a file
+ * @file: the file to check
+ *
+ * memfd_pin_folios() only accepts files backed by shmem or by hugetlb, so
+ * callers that have to validate a file before pinning it, or before taking a
+ * reference to it, can use this helper instead of duplicating the check.
+ *
+ * Return: true if @file may be passed to memfd_pin_folios().
+ */
+bool memfd_pin_folios_supported(struct file *file)
+{
+	return shmem_file(file) || is_file_hugepages(file);
+}
+EXPORT_SYMBOL_GPL(memfd_pin_folios_supported);
+
 /**
  * memfd_pin_folios() - pin folios associated with a memfd
  * @memfd:      the memfd whose folios are to be pinned
@@ -3493,7 +3509,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 	if (!memfd)
 		return -EINVAL;
 
-	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
+	if (!memfd_pin_folios_supported(memfd))
 		return -EINVAL;
 
 	if (end >= i_size_read(file_inode(memfd)))
-- 
2.43.0


