Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E0387590
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344018; cv=none; b=noj9C1s9rV/2LN7xzvwxVaogcdTlgbJ9q7n4JDCB+UUKLEq6iNvwc5H8P7kuQkaaDFQ5t5psc/jePag5rsdOtlFDphOulLkURZGnKYJp+meuoGrkxvCL6VB3dhprZS/IuQNyLdBIeZcVRAFe109SEUakqz3YN0oU4UI98aYzjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344018; c=relaxed/simple;
	bh=oyRMYCBipJFGfyqAL11a48wj6WtAhuqVNSVZiDf1eLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BBk3r6eHtTuI8tD6/Czn1f7PySDCsh1ZhW0/ek9Z2JhRBMigjSoOViLuCMHWyov27ScNKC0Osp329aRzz9PY9EOBfl2GfTMTNjILBXt1YFq24kwboWtqM3VPmL9bWHxKjZIjLGLdJN6JBW5R9tYLo/dovbNe85Yt4FWAKefRMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsRDaeLp; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsRDaeLp"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-914f037b7dfso1363258885a.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780344016; x=1780948816; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msbNDh9TiShw7R12hj6rcfm+XGYU44qZJxoBlWEONAk=;
        b=vsRDaeLpNtMK7KSb8rPeNYtli1JTxtoS1fcnXeJquOojnWd8HVtZCJZgWB387E8NB3
         0gdpRLaZIh5f1QzB5kLK+zbIlKCtSvEFhTnLUPmb9puCVRb1LeM14yeHzuJPCyFpNetN
         btpqUwdNAoBPUYOAXHfLkSIUGia8hG2wsXlmpme+d18rrjGEIyg7yQBw+WS7Hz92P9y/
         +DgxvTj6+HuKQm6GPZoVP/VwsujjylUN4Ct1ngbUHW3fIRxWG14+XYa4GcQRNscIu81i
         SSBMNt5TwF2A7w91ssXHWDygwejm9h7iGd6UnX8Bk7mySzdYqFKMSNZ0oxgTx2xPqozA
         j2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780344016; x=1780948816;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msbNDh9TiShw7R12hj6rcfm+XGYU44qZJxoBlWEONAk=;
        b=N4z2fk98GUEYHldQ65ehtKI/f7sMx9uDIFsYooftjG6vpVroCbGxIROKjJunv+szqY
         g3SAB2ZFOpJdxE18fsDN202CdWCv9Ooz+l2EC6C99hYj3zfYlCyvkvK5+m+Q489X1426
         cOSqG2w61emKNwApsPPqIdRQTUZvKUbbLAsJACBdEARaHdG4pmt9TUd+/OFpaviOwwCP
         UAMKhEJE3kYny3oGQQTSfy6kIdHm7CP0FlxX3/N26eOOF6K68TIo/OibWjcKT6oMMZgT
         6yx+MrhC27Lp5mtUiNU2IOR0wJ7YCpX/CZRC1ZPXSNN4kpKOeyfq4GrN0dK2rkpK3pL4
         7/mw==
X-Forwarded-Encrypted: i=1; AFNElJ/866e6XD05mxZmZLgMPkP6h2wtnaiyLwMhdaurLGJQbFp22Sd80lS5DQ9FrSVZ/eFCi4PPXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQG4OYpKzUys/hOgeDEq/xvJ05jVUHIiEIo0CZsLCM3hrduB5j
	PviyPrJ+vXFtFX5am06idDKd6Y1z9Jd5lnb+QqRZ9G3mEsKVNtGW8nhCt8z1frNpFI8Dzkqnjsn
	09PLwXsks6dlK
X-Received: from qknxz25.prod.google.com ([2002:a05:620a:5e19:b0:910:b90:6ec6])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4612:b0:915:5930:94f1 with SMTP id af79cd13be357-91559309603mr1224141185a.47.1780344015096;
 Mon, 01 Jun 2026 13:00:15 -0700 (PDT)
Date: Mon,  1 Jun 2026 20:00:12 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260601200012.3872274-1-xuehaohu@google.com>
Subject: [PATCH v5] dma-buf: Fix silent overflow for phys vec to sgt
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
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
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

 drivers/dma-buf/dma-buf-mapping.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..607b7998463d 100644
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
 
+	if (nents > UINT_MAX)
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
@@ -133,6 +137,11 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+	if (!nents) {
+		ret = -EINVAL;
+		goto err_free_state;
+	}
+
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.929.g9b7fa37559-goog

