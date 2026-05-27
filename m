Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6653B47FA
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915053; cv=none; b=BQ8cE1Q8iThl4hM0lD7w1kBkXFLSYoi/xtX0oogoivIObGeT1aLimtRV24xG66qhu2b2sndMQfRFA3qjWdFwPN/o2Wkn77K4Hvl0R6brotO5X4IS2Nl2lUyTeR+4MCYuZiBc4gf9pzdZuVKyTCcrO5eHZS91cIc5OkUb7RxJiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915053; c=relaxed/simple;
	bh=eRR5kbIsSk8uR68Yt/RxW5wJjv4k6qQ3jUkESRdonS4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NQYlrmLHN50XfvBAcToWq4hnMoWiDEd8KYhXKBh+7m6JnZKQe9L+SVhGpbxpXdmi98FRHaRSk0h7x4scSCi1K7vUilCCYyb4dMdGbYePa1lMbr/qNdXbGjH6XW7agNusIGh0EPom5WrdsycvzicY+Dv4PTraRGHowLIJF9N36j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jz91Tmz6; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jz91Tmz6"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8acadca1ac4so85614956d6.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779915051; x=1780519851; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OnsOZAwcaFX6qrXTkZ3llO87kDjoRN0331vlXYrms0w=;
        b=Jz91Tmz6bRgiVlJPGIjab7WvrbGSmpfqAr7UOBhDvClrnenixqSCJrDVqwaPUnfVSg
         2juv5G8Efuh2NKkIlEtUtzjuMCFzkw/dpuV6hRyl4NiupHxe96NzT018AWqkEKya7L1h
         KnIqXqlCLCN6vqDczO4wXgWsRuXO4ZRrs8veVJUHi/3Tt/lCKKgHY1vH/OR25M6OIIxd
         2UrnVs52K03/yg83/ktCK9pEcxMvR/XwVW0PXsSzma8/msWqDLRLsZyZmtm/5bFq0zO9
         pP1y25N3+55eDqN86X6ujByN0F67LO6bLAdQUJoa2kkCr/DTHfSDI4Qkaccp0068qfA+
         LXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779915051; x=1780519851;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnsOZAwcaFX6qrXTkZ3llO87kDjoRN0331vlXYrms0w=;
        b=bnaJ/KMjec2GzwlaBmd0xQraPl5VCzL33EFSHm88C0IqbbtzCGkMZ2KiwYetXqDcI/
         GxsoXR/XEUTU04I+z/+urRJQsA+QWFQWdl0f9hBNagmRc3FrgJsUxkdyvsb426QLqeXM
         K/m+pksG/2ytFklVrX/roI41bgYW4gIEZMDoKNEhAZinS4gcPjkaLPcLAEMpXKIhJ7Fp
         JOzTYRerZ1LTT/vqHpqZrDmeCOgMdMP0KhUL1GE6DjZHUwrany0K9UIIDAup4bR1W/e9
         pF73ZwxSpXvEX5DOzMQngDP/ZnG6hjomf894uGBp3+Ih8tns4bIckJS9c2yzn8cC4d90
         qUdA==
X-Forwarded-Encrypted: i=1; AFNElJ87Nhtta4t4SKYzBHVihXQ5aXQgb38f5QFITNky3sIoWaWWSlAIXOHpnMQmffpAlLnbOjBnwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHnEnkwCcWX9QOW6yrpR/Eml0kJA9d4w6Zolffw2KUNbJ0xI9w
	dSnOVbBbvu7Xs8XdRq1dDYWMEazAT52BUSTFv55nB2MIAP8XwpswpVhEq51xnzJrfSwvsB5gTvM
	AdPa/GpyQdqMu
X-Received: from qviu6.prod.google.com ([2002:a0c:c486:0:b0:8cc:2486:6603])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:54ca:b0:8ac:b237:9fb5 with SMTP id 6a1803df08f44-8cc7b5fe0d8mr387104406d6.49.1779915050519;
 Wed, 27 May 2026 13:50:50 -0700 (PDT)
Date: Wed, 27 May 2026 20:50:47 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527205048.2168808-1-xuehaohu@google.com>
Subject: [PATCH v2] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
	leonro@nvidia.com, David Hu <xuehaohu@google.com>, stable@vger.kernel.org, 
	iommu@lists.linux.dev
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

to mapped_len, and leading to a silent overflow

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v2:
 Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 Added Reverse Xmas tree formatting (Pranjal).
 Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 Folded in type consistency fix for fill_sg_entry() (Pranjal).
 Droped unnecessary `nents = 0` initialization (Claude Bot).

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

