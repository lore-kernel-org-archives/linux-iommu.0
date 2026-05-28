Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62330BF6B
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984009; cv=none; b=U3IIJo/KJ+M8fezFLqTJ5szrLtLVTmGkTIBNgSxl9zvqtG3Fn6Yq7ipo/lRaK6MXJzFp07S4cGuzrCWSJS+YljycdSDiU5lRDVOL84/cx0ccAbspvJ7IQdY4nel2KZTbg/5a1yQlhzWqInxcX6U2aTWnCOimqik4j6kQkp2s+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984009; c=relaxed/simple;
	bh=k10mRhLr6t76p4jkzZqe4TGLVfCDjV4dlalSEfzSMXc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SJUkqpo92md46iOAQh2f85XZVLTrdk2Vc8s3PP7ikElK4UCuxwqZwZjpXSb221ztUJLXlzfNMtnW+JJsicfrrmFsllOwXi57D4uSwwNUye2j104gZaLKF2IRWaIdRv6dpLNYxzjS/7/GrTCvpTD0LnWNdpOsIWXNasSTIn+mCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TU67PEhJ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TU67PEhJ"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50edf01172bso183176331cf.2
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779984007; x=1780588807; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MmPFy91yuYd+9nLUOi1wu2JWcf7o4ksos6H5oNntzCU=;
        b=TU67PEhJxlnzwTQi6m+N3kv6/qk7h0mgVVL17r2pbwBbetR2tMLu4hoyhvqS+cfJlw
         bZcMeudKS2tAPeDLEkmygiUmtUhx32fHLc30FfARvjIsVQDYQWO4ZKs1W/fGy6kwFlHI
         MekxZSiPe4ioJf0mgSy3om08E1+56+QlVbrBzocvMQBLJCXU0M3Q7MVHCfsg7Q4RYeg1
         SS/4CvubXUnmysOEB4otiim+2RDWoY+d5nrHOibd0CUjOEZ+UGcKq6i/kBJqthPdKSLH
         7jaq6GDuO6edrKfFsVwKePEHlaDXcNt4+i+NHLRpPa9ErvIfWolQb4VnqzgEy6TOXH5P
         RJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984007; x=1780588807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmPFy91yuYd+9nLUOi1wu2JWcf7o4ksos6H5oNntzCU=;
        b=jPHLtUJfXftA0xnYxywI00ukbjKnCFTcF5Fwf2pwTyeXsReAnFgbHBihLaBOZM2ahg
         tasBHHcA5PlUd1ueQSfOwWDAuY6qFxHgznRL+6O+L5Nv4rXTh2aEoO4K2mEV7ZF1GUbG
         5m0QhHuuhBls1+0gYJ05LbUZtrFa2fTzI+arXSiwUVzBtgnIt43/C6LcKD++IQGGDs6o
         JwRGzICDZXW5ubVF+fHXoD+xJ5MezDukreB606KjymMnhFYt57j22pn9UGUKfLywFgUV
         pXOCLzFxFWAlIH5rpGoxb/p5XsbvAuoYZLyQ+wmD2XGXK+uKYED4G+qH9kcytiFT5UFe
         3SlA==
X-Forwarded-Encrypted: i=1; AFNElJ/SwaxWb7GeGmMVQwLfjFIEF60PNKbHHKwSAcKL26U02wmL4MlkRdJejNKcHrTVYbw6sW5hkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxblgUVKHdk0O7h3YESbzEb5Qhlz9GMyHlPH2lS8A4TG9aBRKUI
	ZNwdJ1WHanIC1uk7X+Z6k9eN6DJyejwgem3Ji1LGhWkNxkeEfmvUyLCMKDiU6zD2M0vRDmZfrPw
	jlBYbnmwW1iFO
X-Received: from qtxy12.prod.google.com ([2002:a05:622a:120c:b0:516:373e:a942])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1488:b0:516:d6a4:fd69 with SMTP id d75a77b69052e-516d6a4fe46mr371616761cf.12.1779984005890;
 Thu, 28 May 2026 09:00:05 -0700 (PDT)
Date: Thu, 28 May 2026 16:00:04 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528160004.2452461-1-xuehaohu@google.com>
Subject: [PATCH v3] dma-buf: Fix silent overflow for phys vec to sgt
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
index 794acff2546a..5bc769fc42ea 100644
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
-- 
2.54.0.794.g4f17f83d09-goog

