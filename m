Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3E3E6DD4
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947807; cv=none; b=GQpJGB61qlk7Rlwb/DghRwIZov3UKN0nXH9OlPeeLtwS01E2UlkBwoDMzrGWbMLKSQXKzW2xRRX4HMHihk5hE7JrqzNlEsPSvoEgJWP02j89VzvsI2I2WLs2U+k2Oj5dzvtcQ/Gj9dRizZBo88JeXfC55AIP4YZoH87uA6YASZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947807; c=relaxed/simple;
	bh=gJ6qO82cunFkHH/YI0cpZWB+99vzwtO076qzoKQb8zA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m4ipUXhT8a9th1gG0fWd7Mmyqo9M5BvGSBqqRe2D62FFgVErb+LF+K1nHTaMFFoui917NtWvHChHb8hgfkziD62xMPT5pbIwuRLZlSL2jYlTegKNQf5GFrSoP9O/TpQFZmVVR6wBQi7vch2jPEoN/PmEmkrr8VNjWRi7AUpjZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3QaQNt5; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3QaQNt5"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5174a236220so92971261cf.3
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780947804; x=1781552604; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1WPgK4XhrSsWKxtc0VlcZjNH1lHogrTgrVmSMDXRnU=;
        b=S3QaQNt5YbnSd/z9XqAjg4agpdmNbSq8Ih6lsspFFmcPIi9FgOZrPXyNyS08fcFoue
         Bberfn9roi2ilRlDwQB+nNeeqzAIQjLxSlhuazWqGTyCI3TdCpPTagu0Ffzri0QDpgfN
         vdqe34Ns2awBOusJXWYF0IYP8+13DfECWkZFsbcEIT0Wdxhcz7OcmZPx7KD032uK0UaY
         VYJDamU5yAfFzGGcGWs4cAfeCVLT0jU9xfP2Wku7LOFaQX2AC+hYK+SiBdOBkS3i/g5T
         vVus2MSYZwlqz7JwofQdznM40mdm6ghZ7jfDoF+6PnHMsCiys311C14srGevbl6GenBl
         ZYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947804; x=1781552604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1WPgK4XhrSsWKxtc0VlcZjNH1lHogrTgrVmSMDXRnU=;
        b=aVbOw2hwGhME+7jzP90+FUr2w2JA2ZIjpdqklDKmxKfDOwhy5uMh/lBw+NjX0qUpV2
         08zaD/Lts9wrJB3F9uBr0kLCuvBiN+ufwIBM8WnQ4frUCUFlRNofk3xX3kGE7nnBGQQ7
         HJW/EqZhBlQjw8WQAqtZLWyLq9OetxbMP57s96uzTh+GkDUxoYBuKRtytLCK8n8/bOhD
         0gjZmg8CXsiZ7hE5qCrXaZ8MgPJ8rwpyRUsCD+9V1FZD4KXFiUPi45NkS9rVSwrKZHDg
         cqh16kb/6wJv0zS7N9Rf1Aqvw+gXsW1kZ0d9XkvHO+FWe6yX1oTjlblTADqTJcyYhO9P
         8+YA==
X-Forwarded-Encrypted: i=1; AFNElJ+1Q9/sWG53E5M+M6gtTzfNk7wPqWnhlz5j9/tjxbGeZOr6s7pYnr/EK9L/lhhqThypmHBX/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI/oX8BUaFIBNw0q0FXPvuRV47J2DF7XHv8UUEhOlaDlx69Omj
	1jjJoVhdt+Y2bf0515PBqwhO4+ekDPHmfWNPmCYJIhRU7CW7d5CArfVEnEOkn/ApXWsAuB1MEoe
	08O3ekxUU8iUU
X-Received: from qtss4-n2.prod.google.com ([2002:a05:622a:a9c4:20b0:517:85d0:ad3a])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5cd1:0:b0:516:df62:bde3 with SMTP id d75a77b69052e-51795c47f23mr242075611cf.54.1780947803937;
 Mon, 08 Jun 2026 12:43:23 -0700 (PDT)
Date: Mon,  8 Jun 2026 19:43:21 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260608194321.150838-1-xuehaohu@google.com>
Subject: [PATCH v6] dma-buf: Fix silent overflow for phys vec to sgt
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
Signed-off-by: David Hu <xuehaohu@google.com>
---
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

 drivers/dma-buf/dma-buf-mapping.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..67a8ff52fb8f 100644
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
@@ -40,8 +41,11 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
-		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+		for (i = 0; i < nr_ranges; i++) {
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			if (check_add_overflow(nents, added, &nents))
+				return 0;
+		}
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
@@ -95,9 +99,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
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
@@ -133,6 +138,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;
-- 
2.54.0.1064.gd145956f57-goog

