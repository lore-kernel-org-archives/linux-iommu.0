Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA13FB07F
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995824; cv=none; b=SZ5aBywZdlqhuiMr1vF5s762XGnJOOqcTpmwlIMMkZe51devPuCX3ZuUzDKEQzoNfU1xfDcLBOHXffzxWiH7ZSmLPCJRjajCP9L37adPQUtIH8iI/PR14koLIlgxj+mHXYwT+3ckye3LOLPKJjJShwknN7boxQMREUeU6Ru+OhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995824; c=relaxed/simple;
	bh=7nsiCepyNb7uhyn7v++Qgh6kBtGu5mTdr2I4JeUzJwg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nGwYYbWIju+3SbSxxGDkoqsM1Y3Kupf1XupIjH3jQelAtG+FTPlTsPASNSNutcoaff3mW3RGXQ4/ebcE5oQQW9WpU9whL7cen0ZGd0EsLJcesEov19N9zKvavRDz/QDPkSKWoFX6P+clo3j1TaKGV2GUoHxVpmQAwmEJcBYEEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsYZvTiW; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsYZvTiW"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-515224a8aa0so64276541cf.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779995821; x=1780600621; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ruTGaXcXn18lBWCvQSOsc+J+nN/WfLLq3tF9jPQMx3w=;
        b=NsYZvTiWwzJsctcH9BNIoGqnDD65LcxkH2a7cOeTf243KkfrTqRX9L/sXX2h6o3qIk
         gtyhKOIfKh8vMVew0qfq7S0vN1itI6OXAn7ZpZ+3tkc4PlV+YDjyqbHXjtQzoJYbzgTy
         I7uNkGC6LLFVD4XhYTsG3KF5DB2c1a3XZbZAxejR9dbVd4BhRcSJoXzLJBIZttvKTZdv
         hwCcYsLV2KjdHYSCrOtyHFoTfgu+jWcid/omCH6HwERyj0vHE4OlZHZJbfjgLb2i7vre
         HGwSv4VicFKxElyFcfLhjtaFFiR+BMSHxYQz/2DKemDGrQsDWItrj5Tc09R6VyATVWaM
         lUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779995821; x=1780600621;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruTGaXcXn18lBWCvQSOsc+J+nN/WfLLq3tF9jPQMx3w=;
        b=BIt8jgW6y4ABR4OxPwmNI6BIdONgW64wxegU3QcegqwfV8IrAAn7OqQNMZiNfLuzfz
         /8NGWJ1knuYPKDHiUAKRl9bEfzz7YRpMSsNwJlHOq1EoGrFaVDcDP7BIwb2HwQodAYTJ
         udzodjdhjK7Dc4F+djmPH/4toeHIcldEh3C722X8dwWTSZ7lJ+LPtkatRaaITIZ+L1FS
         x3JG1SAXFEbkGhlaj4r7WAdHPJ6quG5W+uq+vsPfRPIyH6kpGdzzm0tgafTtjzyahtg4
         EBKMmne9NXfeGdutZfXwGA1Gtijc5cg3oxd00qYFcDBVO3DXxnbjpR6f+VxI+zIdwkw4
         7Lgg==
X-Forwarded-Encrypted: i=1; AFNElJ/uc+ow+fqrjDVzkBWSESOMj37OxFqGLhLo6J0qWlVANlLzzeZpCspFV4mQbYZKB1zRtWG2hQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYmXk07NbixANBn/ToAZ1zvPYM7WkSGZwR95peRysW8q67BqiJ
	s/jOVgKLKHTFcasjPxl8ORcsN26UBK3qjBF/OHeFnbP3ToRcc030HdF0rCODUQE5MVgCniqvCbm
	bO49k+pKfcGdN
X-Received: from qtlo20.prod.google.com ([2002:ac8:4294:0:b0:50f:d8f5:705f])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4c8c:b0:516:e8aa:271 with SMTP id d75a77b69052e-5172cb95a12mr2327291cf.26.1779995821046;
 Thu, 28 May 2026 12:17:01 -0700 (PDT)
Date: Thu, 28 May 2026 19:16:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260528191658.2506362-1-xuehaohu@google.com>
Subject: [PATCH v4] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
	David Hu <xuehaohu@google.com>, stable@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

In case MMIO size is bigger than 4G and peer2peer DMA goes
through host bridge, we trigger a code path that assigns the
total linked IOVA (which is greater than 4G) to mapped_len.

Previously, `mapped_len` was declared as 32-bit `unsigned int`.
When accumulating `size_t` lengths, this leads to a silent wrap-around.
This truncation causes truncated lengths to be passed to functions
like `fill_sg_entry()`.

Fix this by changing `mapped_len` to `size_t` (64-bit). While
at it, fix similar potential overflow issues in `calc_sg_nents`
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v4:
 - Added WARN_ON_ONCE() to the nents overflow check to prevent silent
   failures (Claude Bot).

Changes in v3:
 - Removed leftover sentence fragment from the commit message.
 - Kept `nents = 0` initialization (previously stated as removed in the
   v2 changelog) as it is strictly required for the `+=` accumulation
   loop in `calc_sg_nents()`.

Changes in v2:
 - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 - Added Reverse Xmas tree formatting (Pranjal).
 - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 - Folded in type consistency fix for fill_sg_entry() (Pranjal).

 drivers/dma-buf/dma-buf-mapping.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..1aabc0ee70bb 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 				  struct phys_vec *phys_vec, size_t nr_ranges,
 				  size_t size)
 {
-	unsigned int nents = 0;
+	size_t nents = 0;
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
@@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		nents = DIV_ROUND_UP(size, UINT_MAX);
 	}
 
+	if (WARN_ON_ONCE(nents > UINT_MAX))
+		return 0;
+
 	return nents;
 }
 
@@ -95,9 +98,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
-	unsigned int nents, mapped_len = 0;
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
+	size_t mapped_len = 0;
+	unsigned int nents;
 	dma_addr_t addr;
 	size_t i;
 	int ret;
-- 
2.54.0.929.g9b7fa37559-goog

