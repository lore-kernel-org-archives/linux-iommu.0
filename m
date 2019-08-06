Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38572C32754
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E095214C6
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EO1RyLd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E095214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D1AA3E30;
	Tue,  6 Aug 2019 23:16:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0137ECC6
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7283D875
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:18 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id w17so5816801qto.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pkHeCt/hoSJAt//UHPk0X0I7hZeOiqjMeNu5wqmOhVU=;
	b=EO1RyLd4d0AnXDRqElYRzxtyKz38WeGeNBRIkYdo+3VFgs/T0oIQs20Zy/5GKhTnqI
	UfyYPmrt29HX9vdxZVEwKEX/vOCaV33r4IcvjjLv+dvBVpY91WnTDcNJXzjaMgjBsFFt
	FdxAfV5Xk74BDXvs4obq2oP6Eu9zK7wtAWH8j4mJyF0Ged8Qf759ly97ojGQOxxLbF+m
	EBz8VKm2ELuy2OvTFchRCVHhBVH+J3NM3xKbJA1b+9RKe4syO0dO8Tpu7jcVbUS84W+G
	X1zRmwp67vSBaYZNs5bfg6X3fWLEdZzDSXoP+HJcr6VhTvigDkmOWFIoLfep3TCPpIME
	lbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pkHeCt/hoSJAt//UHPk0X0I7hZeOiqjMeNu5wqmOhVU=;
	b=JRlL6sktX0vqa9G17iJDEdVLmZuSRKFhfdIoG9PP4vDyyYm2sHKtgF0wuLaIDkltHg
	Bac7CQbH3vVsWSNnTGJwqFO7BJpmDtn9OpZ3RDtGgV6hSZiBuH20nZsFbG7n6hREWKye
	o/46lpNuufdJ4R829ZlRpjKG+TjmpTEpZGaINDolgTKeQhQZRDIBgCQnzm/GiDjOwtzm
	1in9hEpE/p4Ecu11f8q1iw9ibmfTn35NZ1rLwSDrMgp3dWknWLKykw/EUXdMZ+1SX2pC
	JyA+KQ5qRg3ndDqVJgEPHH9+sOJe03anik6BwT+1yeHhl6WGxma8Hk5188dHQKV75QaS
	P8ZQ==
X-Gm-Message-State: APjAAAW8ZWW5F0zzEf2KnEriUT2b7vkb3nAMM8H5zJ5O5oGgRGVnAmgO
	L9l18m5J7COUPAA3iXgetbMs9lvdm40=
X-Google-Smtp-Source: APXvYqy6Nsusk0wHFyYvRxTipEB7NphBo9CKaHBj+WOx7SnMsQAhKID5TREjs8PZo1+pA73I5XbxVg==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr5497725qtu.177.1565133377682;
	Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	r14sm36816958qkm.100.2019.08.06.16.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hv8gg-0006fG-Jc; Tue, 06 Aug 2019 20:16:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: [PATCH v3 hmm 11/11] mm/mmu_notifiers: remove unregister_no_release
Date: Tue,  6 Aug 2019 20:15:48 -0300
Message-Id: <20190806231548.25242-12-jgg@ziepe.ca>
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

mmu_notifier_unregister_no_release() and mmu_notifier_call_srcu() no
longer have any users, they have all been converted to use
mmu_notifier_put().

So delete this difficult to use interface.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h |  5 -----
 mm/mmu_notifier.c            | 31 -------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 31aa971315a142..52929e5ef70826 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -271,8 +271,6 @@ extern int __mmu_notifier_register(struct mmu_notifier *mn,
 				   struct mm_struct *mm);
 extern void mmu_notifier_unregister(struct mmu_notifier *mn,
 				    struct mm_struct *mm);
-extern void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
-					       struct mm_struct *mm);
 extern void __mmu_notifier_mm_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
 extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
@@ -513,9 +511,6 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
 	set_pte_at(___mm, ___address, __ptep, ___pte);			\
 })
 
-extern void mmu_notifier_call_srcu(struct rcu_head *rcu,
-				   void (*func)(struct rcu_head *rcu));
-
 #else /* CONFIG_MMU_NOTIFIER */
 
 struct mmu_notifier_range {
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4a770b5211b71d..2ec48f8ba9e288 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -21,18 +21,6 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
-/*
- * This function allows mmu_notifier::release callback to delay a call to
- * a function that will free appropriate resources. The function must be
- * quick and must not block.
- */
-void mmu_notifier_call_srcu(struct rcu_head *rcu,
-			    void (*func)(struct rcu_head *rcu))
-{
-	call_srcu(&srcu, rcu, func);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_call_srcu);
-
 /*
  * This function can't run concurrently against mmu_notifier_register
  * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
@@ -453,25 +441,6 @@ void mmu_notifier_unregister(struct mmu_notifier *mn, struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_unregister);
 
-/*
- * Same as mmu_notifier_unregister but no callback and no srcu synchronization.
- */
-void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
-					struct mm_struct *mm)
-{
-	spin_lock(&mm->mmu_notifier_mm->lock);
-	/*
-	 * Can not use list_del_rcu() since __mmu_notifier_release
-	 * can delete it before we hold the lock.
-	 */
-	hlist_del_init_rcu(&mn->hlist);
-	spin_unlock(&mm->mmu_notifier_mm->lock);
-
-	BUG_ON(atomic_read(&mm->mm_count) <= 0);
-	mmdrop(mm);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_unregister_no_release);
-
 static void mmu_notifier_free_rcu(struct rcu_head *rcu)
 {
 	struct mmu_notifier *mn = container_of(rcu, struct mmu_notifier, rcu);
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
