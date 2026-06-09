Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5953A874B
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023252; cv=none; b=X1DJ8fztPZ4qBYXniWqWcV42b1RkL01aan79UhiTlKcG4x9yD6SVU63tstQ6gaqvpZve82kWTV5tOPrgA1lM4caUcEJ/ZkOl6lzzX+F9zzJuX1Syj6u2OIZcZPZFs9TMmVuknwNXecpPbaAgW8681JdN1zmTp8t4iaMelgsRkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023252; c=relaxed/simple;
	bh=mRpuGl0D1H2bzUSwzdITFxJNbHejE1me4vdFfTd/szY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bJ33UEm7vMwLtnhpls7vGC7f1A59GkMx1Yh7ShpIvq5229/Phit2EC9Z3Aw88Cs+kRLQEhEw+baFu6TBD70HwY1kmdBRv1Mgnmkmubi+qeDOVNYTlD95pTNqYxvdrJCXkmVrHHfm/5T9s7NsprIl2sKQsIo6aPdG0/ZyuPhCoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxT3j8mB; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxT3j8mB"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51772325a64so78092951cf.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781023250; x=1781628050; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1z3n2byYHJNT9ADexfLlseOwhmDm+N+V4xdURWkL6nU=;
        b=BxT3j8mBFMBy7wcJEadvrb1A/SgLuzlfHM0xhJ33WWMYF2LPJa4sHs3wJgn+By++4I
         QOMM+3YxLGCNBSF+uiS5QpAWMs4E1cvSsnz9hOhc1YYvG5RwSSrFiHp2pyCOBLPIhDLh
         nbX2Rl9WmfieNWFNg3nFKNunF5LP7U+hOuL96W+/HwjKq1bTvciJ4tslushhEMkk/dii
         ZH8ykUIQ7B4sLq2fDxcvv7SeI0SqirRGS5fyyqlUEl+Gnw0LoYqZj4xpzKzw17rtkUxD
         rooes7TlY8wS8MWDJEGPkxFBAgwjRoPra7+TEichBn4GYPcHGJK0a4ONu7jiLYKMwdV/
         dnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023250; x=1781628050;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1z3n2byYHJNT9ADexfLlseOwhmDm+N+V4xdURWkL6nU=;
        b=eHWN3k0FQGmwYKtN8vGtciaAP3vSsftg5Y4je44D+DyEFyCTvSe8CHudbnHsXINn8I
         4X1OHLXy2XqDnCdq/6R5h3/fZ/hksbEs9kB3VxtyhO2BegNvQqQjie9tIZ+B5ZReDF4O
         MBp5b27Fn+mcBnP8ViZQeIsI+fwXcsCwvglb8mbPWA0hI2hQ7TCOZUpEwz88BTphM4bT
         Z8IaO+004xLYcnBQ63DmzmbrcW8e/q/pe+NsgjBSHHm+DKBaoWW+rqfQkHST85qFEUBA
         JQcZFYNKvBYuxbULW4vrQZojRYxdrK0/0Lr6uZQGZbad4/glZr9nerkoIRgQBsvDpUme
         prtA==
X-Forwarded-Encrypted: i=1; AFNElJ+Vbp2cQlQC/ENZurp0mUnewHIsU3gjC8AFc+m0+hru5+s75Y1t5Zow9T89EziNXhZFr7zBXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZAk+BWc4ndnRYni79QxRjaj24xIPEi95wX+0+12Gd8hM5OHdm
	elHon7bFv1ArvgNOiKAsSpo1SXdMSHfhT2N1IeXw3a3IcuEigzQ1NgNklTm7m6y7JN3zRJa1ct/
	Ul1f7vFiU0ElR
X-Received: from qtlp5.prod.google.com ([2002:ac8:4085:0:b0:517:58ba:db97])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1794:b0:517:899b:7f73 with SMTP id d75a77b69052e-51795be1395mr297673871cf.30.1781023249210;
 Tue, 09 Jun 2026 09:40:49 -0700 (PDT)
Date: Tue,  9 Jun 2026 16:40:47 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609164047.486227-1-xuehaohu@google.com>
Subject: [PATCH v7] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, David Hu <xuehaohu@google.com>, stable@vger.kernel.org
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
by using `check_add_overflow()` for `nents` and using
`unsigned int` for the loop iterator in `fill_sg_entry` to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v7:
 - Added a missing blank line after local variable declaration in
   `calc_sg_nents()` (Leon).
 - Collected Reviewed-by from Leon Romanovsky.

Changes in v6:
 - Used `check_add_overflow()` in `calc_sg_nents()` for safer
   accumulation (Leon).
 - Dropped explicit `!nents` check and added a comment noting that
   `sg_alloc_table` handles `nents == 0` (Leon).
 - Collected Reviewed-by from Kevin Tian.

Changes in v5:
 - Removed WARN_ON_ONCE from calc_sg_nents() to avoid log noise (Jason).
 - Added explicit check for `!nents` in dma_buf_phys_vec_to_sgt() to
   cleanly return -EINVAL on overflow (Jason).

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
 - Collected Reviewed-by from Pranjal Shrivastava.

 drivers/dma-buf/dma-buf-mapping.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..80f6ab2f4809 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,12 +5,13 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/overflow.h>
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
-		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+		for (i = 0; i < nr_ranges; i++) {
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+
+			if (check_add_overflow(nents, added, &nents))
+				return 0;
+		}
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
@@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
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
@@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.1064.gd145956f57-goog

