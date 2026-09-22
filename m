Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FD3B960F;
	Tue, 22 Sep 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079332; cv=none; b=uExuS8MbTPbKZ2GpNymPbxexPzfFUFUNuBAhhR8qDkY/oPEyae8ncm2QMggvUTuArxRyMnxW8EMq9JMcr9vdEpTugB1kxIE6XFALvI3snFSkpLv9MAZM44HCF3JKGv0iVMwG177iE42UnUWYARcHxmTliMD6a7ePR2Xy/YsXaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079332; c=relaxed/simple;
	bh=mWGI8zMyu63FKU4aLR8gpRTMsWDVmk3cHLrr+0tbaIQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oklwblLsBa6w6G51MXNYHah3Fkqbxj+5CAHwg7+T28W/ZSPGSCDAw9CJEZ3QoRjdu4klMzTU3bdCQi8FO+sYWZMfIjbFVomOARcB3DIVSu3HMZRVvyPljfjFpuiIb2CfTxzfJ748iz00BR5afmwEwj0z6USMFdTHcnSi902jgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+eo7Duc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+eo7Duc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7BA1F000FF;
	Tue, 22 Sep 2026 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790079331;
	bh=ivDHyFqa8SoU2LaRSfZjm/tpGYSoAtZgsYprPZioFLg=;
	h=Subject:To:Cc:From:Date;
	b=c+eo7DucjFLS+elSOGhzgN2UANL8SOMHS9PQTCNUT1lHesNxJ0mvUKFZp3zvtR5l6
	 YjpC09XJIraApD2UctGSA2bHjQBtCVaL7oVGIoEKuOl1OEOYzV+wfktCdrPJMXm2YR
	 rv4FvOOU0rAfq1FoatmqonjxL/FSitAMinnYRtAc=
Subject: Patch "dma-buf: Fix silent overflow for phys vec to sgt" has been added to the 7.2-stable tree
To: christian.koenig@amd.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,kevin.tian@intel.com,leon@kernel.org,praan@google.com,xuehaohu@google.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:43:25 +0200
Message-ID: <2026092225-whoopee-audition-4862@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore


This is a note to let you know that I've just added the patch titled

    dma-buf: Fix silent overflow for phys vec to sgt

to the 7.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     dma-buf-fix-silent-overflow-for-phys-vec-to-sgt.patch
and it can be found in the queue-7.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From b344ca94e8cc85796f16ea25e2e5a8e0303fe813 Mon Sep 17 00:00:00 2001
From: David Hu <xuehaohu@google.com>
Date: Tue, 1 Sep 2026 17:08:48 +0000
Subject: dma-buf: Fix silent overflow for phys vec to sgt
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Hu <xuehaohu@google.com>

commit b344ca94e8cc85796f16ea25e2e5a8e0303fe813 upstream.

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
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260901170849.4052816-2-dhu@x6u.co
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma-buf/dma-buf-mapping.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

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
@@ -40,8 +41,12 @@ static unsigned int calc_sg_nents(struct
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
@@ -95,9 +100,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt
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
@@ -133,6 +139,8 @@ struct sg_table *dma_buf_phys_vec_to_sgt
 	}
 
 	nents = calc_sg_nents(dma->state, phys_vec, nr_ranges, size);
+
+	/* sg_alloc_table will cleanly fail and return -EINVAL if nents == 0 */
 	ret = sg_alloc_table(&dma->sgt, nents, GFP_KERNEL | __GFP_ZERO);
 	if (ret)
 		goto err_free_state;


Patches currently in stable-queue which might be from xuehaohu@google.com are

queue-7.2/dma-buf-fix-silent-overflow-for-phys-vec-to-sgt.patch
queue-7.2/dma-buf-split-sgl-by-largest-page-aligned-chunk.patch
