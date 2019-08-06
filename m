Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49788C433FF
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D96A20B1F
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cVCEAFYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D96A20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5FE73E29;
	Tue,  6 Aug 2019 23:16:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 17300E1E
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
	[209.85.160.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 075BB82D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:17 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id z4so86496455qtc.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MRWnXiD/uGXKgJU9OoKKBGSTnw65zc5ohVNCn5Ladgo=;
	b=cVCEAFYu3kKP8uCjesyCqUuge//F+lRMQ01eE/SDhD70YhMTF3HbtusJNVW2GMywCv
	4VCvMBAkdjjh0NSJXtoxdhaVFbVOyoxt8f4T62ct8t+2BDxe3Tk7qhFhd7R/0e4cmzZP
	6hd7zbqogcJgbY2+Q2Z3U81kwQsf61kL7PT4AC+Vfe/XZxWBGhHv43c1bv/2pdCb/cTc
	Za7656UQb3s75IzTwKUXgOMle+zu6eXHiImOpSiBagC2JxdIq/RIFD1AiuIU4hzzm0y+
	Q9HWzl+WiWJKLbmyYqIM0SIGUu2JiDqjWLP1dsRgQZsYxAoH57HC4ve3ELGcAJBFLquU
	nXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MRWnXiD/uGXKgJU9OoKKBGSTnw65zc5ohVNCn5Ladgo=;
	b=lO1NZipL2QlDyQxbDBnKIZzA17SSm2ku77vb5FAatQgC5VVQ/NpZZZnD3CQKV5avHb
	I6vFocoF9/yRWSqNcINSPVngqvaOZVJVvN6l12WCHIqWrMNkC4EXIIvoILZxQ9ODMnRe
	/Q2MkxsEEegfqjLqEb9g3GnhjjM6ZcyEYgUkzQ8P3O9iKqrCJc6PSmnalmMCrjv1Xad7
	rWn5T3H3Vx3q6a/C65H9wU+XT6Av9h3XCr5LhE8vyukLXxPI7dWIJnuvtb0mvK5MJd9o
	YbwIMJOGsfi/Ggl91qeag2pmRx3jT8mDIrBO7A7QjqTecgJgR+eESSH7yQCADVDGVWLE
	4scw==
X-Gm-Message-State: APjAAAWUGl1VPw/l+K4qDIQLMs+WmeLLOyNVf4bMWOv6Dj3XAPckEPly
	q8+s1lK8PKVeoy2bm0qg1eRH/g==
X-Google-Smtp-Source: APXvYqypQ9RNoQFEs+bodGIjrbmV6xyvFjawz3KagGpOLfACvZgt4hS7Bv0ktSusA1dSv+gHTZoAKg==
X-Received: by 2002:ac8:2d19:: with SMTP id n25mr5581133qta.180.1565133376052; 
	Tue, 06 Aug 2019 16:16:16 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	s127sm38747936qkd.107.2019.08.06.16.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hv8gg-0006em-9U; Tue, 06 Aug 2019 20:16:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: [PATCH v3 hmm 06/11] RDMA/odp: use mmu_notifier_get/put for 'struct
	ib_ucontext_per_mm'
Date: Tue,  6 Aug 2019 20:15:43 -0300
Message-Id: <20190806231548.25242-7-jgg@ziepe.ca>
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

This is a significant simplification, no extra list is kept per FD, and
the interval tree is now shared between all the ucontexts, reducing
overhead if there are multiple ucontexts active.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c    | 170 ++++++++------------------
 drivers/infiniband/core/uverbs_cmd.c  |   3 -
 drivers/infiniband/core/uverbs_main.c |   1 +
 drivers/infiniband/hw/mlx5/main.c     |   5 -
 include/rdma/ib_umem_odp.h            |  10 +-
 include/rdma/ib_verbs.h               |   3 -
 6 files changed, 54 insertions(+), 138 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index c6a992392ee2b8..a02e6e3d7b72fb 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -82,7 +82,7 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
 	struct rb_node *node;
 
 	down_read(&per_mm->umem_rwsem);
-	if (!per_mm->active)
+	if (!per_mm->mn.users)
 		goto out;
 
 	for (node = rb_first_cached(&per_mm->umem_tree); node;
@@ -132,7 +132,7 @@ static int ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	else if (!down_read_trylock(&per_mm->umem_rwsem))
 		return -EAGAIN;
 
-	if (!per_mm->active) {
+	if (!per_mm->mn.users) {
 		up_read(&per_mm->umem_rwsem);
 		/*
 		 * At this point active is permanently set and visible to this
@@ -165,7 +165,7 @@ static void ib_umem_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	struct ib_ucontext_per_mm *per_mm =
 		container_of(mn, struct ib_ucontext_per_mm, mn);
 
-	if (unlikely(!per_mm->active))
+	if (unlikely(!per_mm->mn.users))
 		return;
 
 	rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, range->start,
@@ -174,125 +174,47 @@ static void ib_umem_notifier_invalidate_range_end(struct mmu_notifier *mn,
 	up_read(&per_mm->umem_rwsem);
 }
 
-static const struct mmu_notifier_ops ib_umem_notifiers = {
-	.release                    = ib_umem_notifier_release,
-	.invalidate_range_start     = ib_umem_notifier_invalidate_range_start,
-	.invalidate_range_end       = ib_umem_notifier_invalidate_range_end,
-};
-
-static void remove_umem_from_per_mm(struct ib_umem_odp *umem_odp)
-{
-	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
-
-	if (umem_odp->is_implicit_odp)
-		return;
-
-	down_write(&per_mm->umem_rwsem);
-	interval_tree_remove(&umem_odp->interval_tree, &per_mm->umem_tree);
-	complete_all(&umem_odp->notifier_completion);
-	up_write(&per_mm->umem_rwsem);
-}
-
-static struct ib_ucontext_per_mm *alloc_per_mm(struct ib_ucontext *ctx,
-					       struct mm_struct *mm)
+static struct mmu_notifier *ib_umem_alloc_notifier(struct mm_struct *mm)
 {
 	struct ib_ucontext_per_mm *per_mm;
-	int ret;
 
 	per_mm = kzalloc(sizeof(*per_mm), GFP_KERNEL);
 	if (!per_mm)
 		return ERR_PTR(-ENOMEM);
 
-	per_mm->context = ctx;
-	per_mm->mm = mm;
 	per_mm->umem_tree = RB_ROOT_CACHED;
 	init_rwsem(&per_mm->umem_rwsem);
-	per_mm->active = true;
 
+	WARN_ON(mm != current->mm);
 	rcu_read_lock();
 	per_mm->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
 	rcu_read_unlock();
-
-	WARN_ON(mm != current->mm);
-
-	per_mm->mn.ops = &ib_umem_notifiers;
-	ret = mmu_notifier_register(&per_mm->mn, per_mm->mm);
-	if (ret) {
-		dev_err(&ctx->device->dev,
-			"Failed to register mmu_notifier %d\n", ret);
-		goto out_pid;
-	}
-
-	list_add(&per_mm->ucontext_list, &ctx->per_mm_list);
-	return per_mm;
-
-out_pid:
-	put_pid(per_mm->tgid);
-	kfree(per_mm);
-	return ERR_PTR(ret);
+	return &per_mm->mn;
 }
 
-static struct ib_ucontext_per_mm *get_per_mm(struct ib_umem_odp *umem_odp)
+static void ib_umem_free_notifier(struct mmu_notifier *mn)
 {
-	struct ib_ucontext *ctx = umem_odp->umem.context;
-	struct ib_ucontext_per_mm *per_mm;
-
-	lockdep_assert_held(&ctx->per_mm_list_lock);
-
-	/*
-	 * Generally speaking we expect only one or two per_mm in this list,
-	 * so no reason to optimize this search today.
-	 */
-	list_for_each_entry(per_mm, &ctx->per_mm_list, ucontext_list) {
-		if (per_mm->mm == umem_odp->umem.owning_mm)
-			return per_mm;
-	}
-
-	return alloc_per_mm(ctx, umem_odp->umem.owning_mm);
-}
-
-static void free_per_mm(struct rcu_head *rcu)
-{
-	kfree(container_of(rcu, struct ib_ucontext_per_mm, rcu));
-}
-
-static void put_per_mm(struct ib_umem_odp *umem_odp)
-{
-	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
-	struct ib_ucontext *ctx = umem_odp->umem.context;
-	bool need_free;
-
-	mutex_lock(&ctx->per_mm_list_lock);
-	umem_odp->per_mm = NULL;
-	per_mm->odp_mrs_count--;
-	need_free = per_mm->odp_mrs_count == 0;
-	if (need_free)
-		list_del(&per_mm->ucontext_list);
-	mutex_unlock(&ctx->per_mm_list_lock);
-
-	if (!need_free)
-		return;
-
-	/*
-	 * NOTE! mmu_notifier_unregister() can happen between a start/end
-	 * callback, resulting in an start/end, and thus an unbalanced
-	 * lock. This doesn't really matter to us since we are about to kfree
-	 * the memory that holds the lock, however LOCKDEP doesn't like this.
-	 */
-	down_write(&per_mm->umem_rwsem);
-	per_mm->active = false;
-	up_write(&per_mm->umem_rwsem);
+	struct ib_ucontext_per_mm *per_mm =
+		container_of(mn, struct ib_ucontext_per_mm, mn);
 
 	WARN_ON(!RB_EMPTY_ROOT(&per_mm->umem_tree.rb_root));
-	mmu_notifier_unregister_no_release(&per_mm->mn, per_mm->mm);
+
 	put_pid(per_mm->tgid);
-	mmu_notifier_call_srcu(&per_mm->rcu, free_per_mm);
+	kfree(per_mm);
 }
 
-static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
-				   struct ib_ucontext_per_mm *per_mm)
+static const struct mmu_notifier_ops ib_umem_notifiers = {
+	.release                    = ib_umem_notifier_release,
+	.invalidate_range_start     = ib_umem_notifier_invalidate_range_start,
+	.invalidate_range_end       = ib_umem_notifier_invalidate_range_end,
+	.alloc_notifier		    = ib_umem_alloc_notifier,
+	.free_notifier		    = ib_umem_free_notifier,
+};
+
+static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp)
 {
-	struct ib_ucontext *ctx = umem_odp->umem.context;
+	struct ib_ucontext_per_mm *per_mm;
+	struct mmu_notifier *mn;
 	int ret;
 
 	if (!umem_odp->is_implicit_odp) {
@@ -338,18 +260,13 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 		}
 	}
 
-	mutex_lock(&ctx->per_mm_list_lock);
-	if (per_mm) {
-		umem_odp->per_mm = per_mm;
-	} else {
-		umem_odp->per_mm = get_per_mm(umem_odp);
-		if (IS_ERR(umem_odp->per_mm)) {
-			ret = PTR_ERR(umem_odp->per_mm);
-			goto out_unlock;
-		}
+	mn = mmu_notifier_get(&ib_umem_notifiers, umem_odp->umem.owning_mm);
+	if (IS_ERR(mn)) {
+		ret = PTR_ERR(mn);
+		goto out_dma_list;
 	}
-	per_mm->odp_mrs_count++;
-	mutex_unlock(&ctx->per_mm_list_lock);
+	umem_odp->per_mm = per_mm =
+		container_of(mn, struct ib_ucontext_per_mm, mn);
 
 	mutex_init(&umem_odp->umem_mutex);
 	init_completion(&umem_odp->notifier_completion);
@@ -363,8 +280,7 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 
 	return 0;
 
-out_unlock:
-	mutex_unlock(&ctx->per_mm_list_lock);
+out_dma_list:
 	kvfree(umem_odp->dma_list);
 out_page_list:
 	kvfree(umem_odp->page_list);
@@ -409,7 +325,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 	umem_odp->is_implicit_odp = 1;
 	umem_odp->page_shift = PAGE_SHIFT;
 
-	ret = ib_init_umem_odp(umem_odp, NULL);
+	ret = ib_init_umem_odp(umem_odp);
 	if (ret) {
 		kfree(umem_odp);
 		return ERR_PTR(ret);
@@ -455,7 +371,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
 	umem->owning_mm  = root->umem.owning_mm;
 	odp_data->page_shift = PAGE_SHIFT;
 
-	ret = ib_init_umem_odp(odp_data, root->per_mm);
+	ret = ib_init_umem_odp(odp_data);
 	if (ret) {
 		kfree(odp_data);
 		return ERR_PTR(ret);
@@ -498,11 +414,13 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 		up_read(&mm->mmap_sem);
 	}
 
-	return ib_init_umem_odp(umem_odp, NULL);
+	return ib_init_umem_odp(umem_odp);
 }
 
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 {
+	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
+
 	/*
 	 * Ensure that no more pages are mapped in the umem.
 	 *
@@ -512,8 +430,24 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
 				    ib_umem_end(umem_odp));
 
-	remove_umem_from_per_mm(umem_odp);
-	put_per_mm(umem_odp);
+	down_write(&per_mm->umem_rwsem);
+	if (!umem_odp->is_implicit_odp) {
+		interval_tree_remove(&umem_odp->interval_tree,
+				     &per_mm->umem_tree);
+		complete_all(&umem_odp->notifier_completion);
+	}
+	/*
+	 * NOTE! mmu_notifier_unregister() can happen between a start/end
+	 * callback, resulting in an start/end, and thus an unbalanced
+	 * lock. This doesn't really matter to us since we are about to kfree
+	 * the memory that holds the lock, however LOCKDEP doesn't like this.
+	 * Thus we call the mmu_notifier_put under the rwsem and test the
+	 * internal users count to reliably see if we are past this point.
+	 */
+	mmu_notifier_put(&umem_odp->per_mm->mn);
+	up_write(&per_mm->umem_rwsem);
+
+	umem_odp->per_mm = NULL;
 	kvfree(umem_odp->dma_list);
 	kvfree(umem_odp->page_list);
 }
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 8f4fd4fac1593a..7c10dfe417a446 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -252,9 +252,6 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 	ucontext->closing = false;
 	ucontext->cleanup_retryable = false;
 
-	mutex_init(&ucontext->per_mm_list_lock);
-	INIT_LIST_HEAD(&ucontext->per_mm_list);
-
 	ret = get_unused_fd_flags(O_CLOEXEC);
 	if (ret < 0)
 		goto err_free;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 11c13c1381cf5c..e369ac0d6f5159 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1487,6 +1487,7 @@ static void __exit ib_uverbs_cleanup(void)
 				 IB_UVERBS_NUM_FIXED_MINOR);
 	unregister_chrdev_region(dynamic_uverbs_dev,
 				 IB_UVERBS_NUM_DYNAMIC_MINOR);
+	mmu_notifier_synchronize();
 }
 
 module_init(ib_uverbs_init);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index cdb6bbbaa14fd8..4400ff7457c7c8 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1995,11 +1995,6 @@ static void mlx5_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	struct mlx5_ib_dev *dev = to_mdev(ibcontext->device);
 	struct mlx5_bfreg_info *bfregi;
 
-	/* All umem's must be destroyed before destroying the ucontext. */
-	mutex_lock(&ibcontext->per_mm_list_lock);
-	WARN_ON(!list_empty(&ibcontext->per_mm_list));
-	mutex_unlock(&ibcontext->per_mm_list_lock);
-
 	bfregi = &context->bfregi;
 	mlx5_ib_dealloc_transport_domain(dev, context->tdn, context->devx_uid);
 
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 468c9afabbb2fd..5a6c7cd3f33388 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -116,20 +116,12 @@ static inline unsigned long ib_umem_end(struct ib_umem_odp *umem_odp)
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
 
 struct ib_ucontext_per_mm {
-	struct ib_ucontext *context;
-	struct mm_struct *mm;
+	struct mmu_notifier mn;
 	struct pid *tgid;
-	bool active;
 
 	struct rb_root_cached umem_tree;
 	/* Protects umem_tree */
 	struct rw_semaphore umem_rwsem;
-
-	struct mmu_notifier mn;
-	unsigned int odp_mrs_count;
-
-	struct list_head ucontext_list;
-	struct rcu_head rcu;
 };
 
 int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 16196196659a4c..9bd3cde7e8dbe9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1417,9 +1417,6 @@ struct ib_ucontext {
 
 	bool cleanup_retryable;
 
-	struct mutex per_mm_list_lock;
-	struct list_head per_mm_list;
-
 	struct ib_rdmacg_object	cg_obj;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
