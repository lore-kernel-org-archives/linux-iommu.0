Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA79C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D80216F4
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Aqt2P6wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D80216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84664E21;
	Tue,  6 Aug 2019 23:16:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C8A88CC6
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 75C9B82F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:17 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id d23so86477199qto.2
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=mjtpPFkSq3UiLsyLXzaYFfxy47hSUzru4mJ5ITxeLVU=;
	b=Aqt2P6wkNDk7Ey4zJ/R2dr20/+p+3YhHJwj0w4amgSQKlEOzS7bH+L1Oepqzsr46++
	aqXCSW5qQ+ZwByqVsAB+aLiCdaOPYHZoHMNlOBje6tt/3/uvpiTCTJbTvN+WthemRndl
	/kJKQxc7MJH2ISRonRwzYob3+PusKHZyNLKSSWfe24VwuwxIhBYqxbeduEP8ekflzqn+
	3yA1G3kjs09AVnNH83BdYQtbyyY6PmgYHmcfgbvOmvx4hl79v7MqlTCtxlX6HMoPt34s
	F8GhD+KbHjGiBPnxWQSt/UpHQqEubqay3aXPCjsT8vtbafoNOzsV5GtwtBxXRIkev7JZ
	fWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=mjtpPFkSq3UiLsyLXzaYFfxy47hSUzru4mJ5ITxeLVU=;
	b=WZ2/gIfKA5c2mwQRJ7edAa1r+Wd/AvZdS8wILrcF+pW23wYGwR+nxklCwtm1pAggDY
	vfWmE564su20u9J0TZf9xSyqFqYSt3oR0aJ1HxfN8fI7jNwo1/mHQvDtdYHd5+rNfYpc
	BAp8UWWSsDhMSKADt19vYo1m+o9IKWrNQu5PRMlE3mmDaf61pm+5fNmy1TVxcKYt9aRC
	ba6i8QidJUJTBbE1opwnCU0Scnn5czQW8We8Ce8C8ACHHCs1zTIcc+H5Pnb4d+dDb53Q
	nH5iVyGfuPCiDBk9z25bHtwTb4U+kB9uk8MZfQF3I+G4JbUozebifO8q6G2IMlyVgff1
	uOHg==
X-Gm-Message-State: APjAAAVrXnT9qqAr5Kd3mY9FDt5guEh2hz47FOUhzQ59SbH7uW5iUuKw
	zAJFMATlWS8Ry/KZYkCHsGEKng==
X-Google-Smtp-Source: APXvYqz63tweA2E8MzBrzK5yWz5htOs/6XLwX1oleep4fUjPNFszgc4r2awnmY97Q4W0cA2HokN6fA==
X-Received: by 2002:aed:2435:: with SMTP id r50mr1433667qtc.43.1565133376646; 
	Tue, 06 Aug 2019 16:16:16 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	x206sm40603751qkb.127.2019.08.06.16.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hv8gg-0006es-Bw; Tue, 06 Aug 2019 20:16:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: [PATCH v3 hmm 07/11] RDMA/odp: remove ib_ucontext from ib_umem
Date: Tue,  6 Aug 2019 20:15:44 -0300
Message-Id: <20190806231548.25242-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Ralph Campbell <rcampbell@nvidia.com>, Dimitri Sivanich <sivanich@sgi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>,
	linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@mellanox.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Jason Gunthorpe <jgg@mellanox.com>

At this point the ucontext is only being stored to access the ib_device,
so just store the ib_device directly instead. This is more natural and
logical as the umem has nothing to do with the ucontext.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem.c     |  4 ++--
 drivers/infiniband/core/umem_odp.c | 13 ++++++-------
 include/rdma/ib_umem.h             |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c59aa57d36510f..5ab9165ffbef0a 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -242,7 +242,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 			return ERR_PTR(-ENOMEM);
 	}
 
-	umem->context    = context;
+	umem->ibdev = context->device;
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = ib_access_writable(access);
@@ -370,7 +370,7 @@ void ib_umem_release(struct ib_umem *umem)
 		return;
 	}
 
-	__ib_umem_release(umem->context->device, umem, 1);
+	__ib_umem_release(umem->ibdev, umem, 1);
 
 	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
 	__ib_umem_release_tail(umem);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index a02e6e3d7b72fb..da72318e17592f 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -103,7 +103,7 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
 		 */
 		smp_wmb();
 		complete_all(&umem_odp->notifier_completion);
-		umem_odp->umem.context->device->ops.invalidate_range(
+		umem_odp->umem.ibdev->ops.invalidate_range(
 			umem_odp, ib_umem_start(umem_odp),
 			ib_umem_end(umem_odp));
 	}
@@ -116,7 +116,7 @@ static int invalidate_range_start_trampoline(struct ib_umem_odp *item,
 					     u64 start, u64 end, void *cookie)
 {
 	ib_umem_notifier_start_account(item);
-	item->umem.context->device->ops.invalidate_range(item, start, end);
+	item->umem.ibdev->ops.invalidate_range(item, start, end);
 	return 0;
 }
 
@@ -319,7 +319,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 	if (!umem_odp)
 		return ERR_PTR(-ENOMEM);
 	umem = &umem_odp->umem;
-	umem->context = context;
+	umem->ibdev = context->device;
 	umem->writable = ib_access_writable(access);
 	umem->owning_mm = current->mm;
 	umem_odp->is_implicit_odp = 1;
@@ -364,7 +364,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
 	umem = &odp_data->umem;
-	umem->context    = root->umem.context;
+	umem->ibdev = root->umem.ibdev;
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = root->umem.writable;
@@ -477,8 +477,7 @@ static int ib_umem_odp_map_dma_single_page(
 		u64 access_mask,
 		unsigned long current_seq)
 {
-	struct ib_ucontext *context = umem_odp->umem.context;
-	struct ib_device *dev = context->device;
+	struct ib_device *dev = umem_odp->umem.ibdev;
 	dma_addr_t dma_addr;
 	int remove_existing_mapping = 0;
 	int ret = 0;
@@ -691,7 +690,7 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 {
 	int idx;
 	u64 addr;
-	struct ib_device *dev = umem_odp->umem.context->device;
+	struct ib_device *dev = umem_odp->umem.ibdev;
 
 	virt = max_t(u64, virt, ib_umem_start(umem_odp));
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 1052d0d62be7d2..a91b2af64ec47b 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -42,7 +42,7 @@ struct ib_ucontext;
 struct ib_umem_odp;
 
 struct ib_umem {
-	struct ib_ucontext     *context;
+	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
 	size_t			length;
 	unsigned long		address;
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
