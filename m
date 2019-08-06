Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E61C32754
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91BB20B1F
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lO1sgfmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91BB20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D2438DD1;
	Tue,  6 Aug 2019 23:16:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE520CB1
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 103E082D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:16 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id k10so17287229qtq.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=zMCnJFSOouEfBlilBoskv+IiaZaXJbwxtFCutX/1ZbM=;
	b=lO1sgfmmxfGlNqAPOvqLT1SGqrTemHFJclBTTUaP/JdfZebfYNEmZx12KN2d9x+t1K
	lII9WK9gYfQZPyWgyPFTPCoEGHZt8F0M7jQCLkLSlFxnaHHwQXPyY3CcqvQ580SczZfN
	qAhsOYwXpYzFayOyEW24oPZpEQGwPISo/iiZPCSocZqmP49DBEnHdgl5cijvZU770sK2
	rst5KmBjQuunoLWsnmCgllUhFH26FxYZrBl8qIJPrLLJfK3/2D+8ShVoV4s+9VzUPpPr
	JMuDt8hth2BUVJE2B6xnVe4lowU/3I7TBYPiS33xCwbY2pskYzWJYZAzDEPq+ODY5GTM
	Yhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zMCnJFSOouEfBlilBoskv+IiaZaXJbwxtFCutX/1ZbM=;
	b=qELdDEyzZv13ZZJA9y/XHVyNlQKabo0Jw9qxkiYyvHKpxXRvRuUAE4aAf84I6wyORG
	CRZHhADQSziMrYm8uJcXlfErUyxlEAIhYVrGaJicXCD5FjtVWUKa3XDcfgMU0tnqGDQQ
	IrSdW4c5BbwZxVajJ3tJW2PpzPECQvvEOY2kY/1DlagXZ875TqHDvegmQ45X6TZ+VRQg
	pnG9RvbtZjYkq/uQVK3Y/aVv9DsEDInH7d24V6FkrDAilVDSJCt/NLLHWEfnz2kfyjoB
	TWgwGmQYN9vl4m+D6/MYZ6Uw68Ui6EmtjuBbzzqZhT5oaUb/5GnFJTdythqxEPZIoLjX
	HMfw==
X-Gm-Message-State: APjAAAX0NTg0Aefmd90qkVW6H9r5mei8/nDSeiI38IoQN1twILHsU2Bk
	WOKFBxS6zcNpcb4lcb18C+USPg==
X-Google-Smtp-Source: APXvYqxMVRT0WflMzTw7hoNYehDw3sJ1fV7g1I1BCJ9PGgwnJ2UQq4JSqfd/nXhEpMBqp4lLxDXVKg==
X-Received: by 2002:a0c:9e27:: with SMTP id p39mr5387552qve.151.1565133375135; 
	Tue, 06 Aug 2019 16:16:15 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	d9sm38947489qke.136.2019.08.06.16.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hv8gg-0006eZ-5J; Tue, 06 Aug 2019 20:16:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: [PATCH v3 hmm 04/11] misc/sgi-gru: use mmu_notifier_get/put for
	struct gru_mm_struct
Date: Tue,  6 Aug 2019 20:15:41 -0300
Message-Id: <20190806231548.25242-5-jgg@ziepe.ca>
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

GRU is already using almost the same algorithm as get/put, it even
helpfully has a 10 year old comment to make this algorithm common, which
is finally happening.

There are a few differences and fixes from this conversion:
- GRU used rcu not srcu to read the hlist
- Unclear how the locking worked to prevent gru_register_mmu_notifier()
  from running concurrently with gru_drop_mmu_notifier() - this version is
  safe
- GRU had a release function which only set a variable without any locking
  that skiped the synchronize_srcu during unregister which looks racey,
  but this makes it reliable via the integrated call_srcu().
- It is unclear if the mmap_sem is actually held when
  __mmu_notifier_register() was called, lockdep will now warn if this is
  wrong

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/misc/sgi-gru/grufile.c     |  1 +
 drivers/misc/sgi-gru/grutables.h   |  2 -
 drivers/misc/sgi-gru/grutlbpurge.c | 84 +++++++++---------------------
 3 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufile.c b/drivers/misc/sgi-gru/grufile.c
index a2a142ae087bfa..9d042310214ff9 100644
--- a/drivers/misc/sgi-gru/grufile.c
+++ b/drivers/misc/sgi-gru/grufile.c
@@ -573,6 +573,7 @@ static void __exit gru_exit(void)
 	gru_free_tables();
 	misc_deregister(&gru_miscdev);
 	gru_proc_exit();
+	mmu_notifier_synchronize();
 }
 
 static const struct file_operations gru_fops = {
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index 438191c220570c..a7e44b2eb413f6 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -307,10 +307,8 @@ struct gru_mm_tracker {				/* pack to reduce size */
 
 struct gru_mm_struct {
 	struct mmu_notifier	ms_notifier;
-	atomic_t		ms_refcnt;
 	spinlock_t		ms_asid_lock;	/* protects ASID assignment */
 	atomic_t		ms_range_active;/* num range_invals active */
-	char			ms_released;
 	wait_queue_head_t	ms_wait_queue;
 	DECLARE_BITMAP(ms_asidmap, GRU_MAX_GRUS);
 	struct gru_mm_tracker	ms_asids[GRU_MAX_GRUS];
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 59ba0adf23cee4..10921cd2608dfa 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -235,83 +235,47 @@ static void gru_invalidate_range_end(struct mmu_notifier *mn,
 		gms, range->start, range->end);
 }
 
-static void gru_release(struct mmu_notifier *mn, struct mm_struct *mm)
+static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
 {
-	struct gru_mm_struct *gms = container_of(mn, struct gru_mm_struct,
-						 ms_notifier);
+	struct gru_mm_struct *gms;
+
+	gms = kzalloc(sizeof(*gms), GFP_KERNEL);
+	if (!gms)
+		return ERR_PTR(-ENOMEM);
+	STAT(gms_alloc);
+	spin_lock_init(&gms->ms_asid_lock);
+	init_waitqueue_head(&gms->ms_wait_queue);
 
-	gms->ms_released = 1;
-	gru_dbg(grudev, "gms %p\n", gms);
+	return &gms->ms_notifier;
 }
 
+static void gru_free_notifier(struct mmu_notifier *mn)
+{
+	kfree(container_of(mn, struct gru_mm_struct, ms_notifier));
+	STAT(gms_free);
+}
 
 static const struct mmu_notifier_ops gru_mmuops = {
 	.invalidate_range_start	= gru_invalidate_range_start,
 	.invalidate_range_end	= gru_invalidate_range_end,
-	.release		= gru_release,
+	.alloc_notifier		= gru_alloc_notifier,
+	.free_notifier		= gru_free_notifier,
 };
 
-/* Move this to the basic mmu_notifier file. But for now... */
-static struct mmu_notifier *mmu_find_ops(struct mm_struct *mm,
-			const struct mmu_notifier_ops *ops)
-{
-	struct mmu_notifier *mn, *gru_mn = NULL;
-
-	if (mm->mmu_notifier_mm) {
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list,
-					 hlist)
-		    if (mn->ops == ops) {
-			gru_mn = mn;
-			break;
-		}
-		rcu_read_unlock();
-	}
-	return gru_mn;
-}
-
 struct gru_mm_struct *gru_register_mmu_notifier(void)
 {
-	struct gru_mm_struct *gms;
 	struct mmu_notifier *mn;
-	int err;
-
-	mn = mmu_find_ops(current->mm, &gru_mmuops);
-	if (mn) {
-		gms = container_of(mn, struct gru_mm_struct, ms_notifier);
-		atomic_inc(&gms->ms_refcnt);
-	} else {
-		gms = kzalloc(sizeof(*gms), GFP_KERNEL);
-		if (!gms)
-			return ERR_PTR(-ENOMEM);
-		STAT(gms_alloc);
-		spin_lock_init(&gms->ms_asid_lock);
-		gms->ms_notifier.ops = &gru_mmuops;
-		atomic_set(&gms->ms_refcnt, 1);
-		init_waitqueue_head(&gms->ms_wait_queue);
-		err = __mmu_notifier_register(&gms->ms_notifier, current->mm);
-		if (err)
-			goto error;
-	}
-	if (gms)
-		gru_dbg(grudev, "gms %p, refcnt %d\n", gms,
-			atomic_read(&gms->ms_refcnt));
-	return gms;
-error:
-	kfree(gms);
-	return ERR_PTR(err);
+
+	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm);
+	if (IS_ERR(mn))
+		return ERR_CAST(mn);
+
+	return container_of(mn, struct gru_mm_struct, ms_notifier);
 }
 
 void gru_drop_mmu_notifier(struct gru_mm_struct *gms)
 {
-	gru_dbg(grudev, "gms %p, refcnt %d, released %d\n", gms,
-		atomic_read(&gms->ms_refcnt), gms->ms_released);
-	if (atomic_dec_return(&gms->ms_refcnt) == 0) {
-		if (!gms->ms_released)
-			mmu_notifier_unregister(&gms->ms_notifier, current->mm);
-		kfree(gms);
-		STAT(gms_free);
-	}
+	mmu_notifier_put(&gms->ms_notifier);
 }
 
 /*
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
