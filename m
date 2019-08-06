Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DBC31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6448A20B1F
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WIvITimi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6448A20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0819FE1A;
	Tue,  6 Aug 2019 23:16:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D244CD36
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
	[209.85.160.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 54C2682F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:16 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id n11so86410660qtl.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qo3M/m6bAMWNKeEf1KSsSvYS6KA/79bnXZ/MG9HQ7+c=;
	b=WIvITimiWkKwXR9MAnwvbjPd/jMGoFdgSbKJFYsFUTclr60pQsMdghZmIOiCh5YXC0
	UttFPobZS06cPlOZT0PF7D3HVksfWxSV4t/CAk8TXFyUTmugFgIF0+8oo8kipepx+JH2
	FaOArh02dXo+Kn1J1o19Ll/t6xFzUWU5L8C0euhgPJsWnHYPCsSB+yc+FHlEmVCAuX1U
	+F5OWyMlJ9C8l6nJvwq0WdkKMN98R7WVkx30edRvtFR93R5JGnJIrzkZgNRu9P36xdgz
	ULUtU6UxEUUqnG9agwf1nN+Htatwu+jA9bbrHaEueg4ngKDbsCMWsyahgp9VLjoDhgxe
	+acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qo3M/m6bAMWNKeEf1KSsSvYS6KA/79bnXZ/MG9HQ7+c=;
	b=cCnU8jK4XD99XakpcD+VeZjm5mp15TeobJiVDCoqynIXA2JrCh5JyMcBv6ofxbvxrU
	gIrJXlSwlDMKWan3R8Yn31XyD+LfCehoA0GiFEYkDaQFvBbDMc+bdsja9b/KiPd7CEyJ
	gTrRuHqrnvGZep6Hvepcqvdqg34cPYlhIg7nejD7pdls5scBOr+E3shxJclifMHr9kju
	Rq4pW5UrMNO5Tgmk17n/SBzPp+hQ+HczeqJuqX/QUWaN98BiP1J2gW1amBX8pPKphOxA
	qk9vIUt9GXkW4XdJPdBysKlxhGtAhNCWIdMhtMLm5CITmOkRra2e/jwFDlqEvcm18bDE
	+Whg==
X-Gm-Message-State: APjAAAXJR81Y3yJ030lZJINrtpl2pBwbel96b9duZ/U9x9tgE4V//yE7
	WjAz/pRtOmI+j/osmTjKK+ET3YHHYOQ=
X-Google-Smtp-Source: APXvYqwzSzqBhit7womFZned74qAW6JuvC+DaQssS9gJgppa+iNTQrGgfDRkcUg2AKLeoxFn+koswg==
X-Received: by 2002:a0c:ad6f:: with SMTP id v44mr5590212qvc.40.1565133375491; 
	Tue, 06 Aug 2019 16:16:15 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100])
	by smtp.gmail.com with ESMTPSA id l5sm38853627qte.9.2019.08.06.16.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hv8gg-0006eL-1z; Tue, 06 Aug 2019 20:16:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: [PATCH v3 hmm 02/11] mm/mmu_notifiers: do not speculatively allocate
	a mmu_notifier_mm
Date: Tue,  6 Aug 2019 20:15:39 -0300
Message-Id: <20190806231548.25242-3-jgg@ziepe.ca>
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

A prior commit e0f3c3f78da2 ("mm/mmu_notifier: init notifier if necessary")
made an attempt at doing this, but had to be reverted as calling
the GFP_KERNEL allocator under the i_mmap_mutex causes deadlock, see
commit 35cfa2b0b491 ("mm/mmu_notifier: allocate mmu_notifier in advance").

However, we can avoid that problem by doing the allocation only under
the mmap_sem, which is already happening.

Since all writers to mm->mmu_notifier_mm hold the write side of the
mmap_sem reading it under that sem is deterministic and we can use that to
decide if the allocation path is required, without speculation.

The actual update to mmu_notifier_mm must still be done under the
mm_take_all_locks() to ensure read-side coherency.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/mmu_notifier.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 218a6f108bc2d0..696810f632ade1 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -242,27 +242,32 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
  */
 int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct mmu_notifier_mm *mmu_notifier_mm;
+	struct mmu_notifier_mm *mmu_notifier_mm = NULL;
 	int ret;
 
 	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	mmu_notifier_mm = kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
-	if (unlikely(!mmu_notifier_mm))
-		return -ENOMEM;
+	if (!mm->mmu_notifier_mm) {
+		/*
+		 * kmalloc cannot be called under mm_take_all_locks(), but we
+		 * know that mm->mmu_notifier_mm can't change while we hold
+		 * the write side of the mmap_sem.
+		 */
+		mmu_notifier_mm =
+			kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
+		if (!mmu_notifier_mm)
+			return -ENOMEM;
+
+		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
+		spin_lock_init(&mmu_notifier_mm->lock);
+	}
 
 	ret = mm_take_all_locks(mm);
 	if (unlikely(ret))
 		goto out_clean;
 
-	if (!mm_has_notifiers(mm)) {
-		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
-		spin_lock_init(&mmu_notifier_mm->lock);
-
-		mm->mmu_notifier_mm = mmu_notifier_mm;
-		mmu_notifier_mm = NULL;
-	}
+	/* Pairs with the mmdrop in mmu_notifier_unregister_* */
 	mmgrab(mm);
 
 	/*
@@ -273,14 +278,19 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * We can't race against any other mmu notifier method either
 	 * thanks to mm_take_all_locks().
 	 */
+	if (mmu_notifier_mm)
+		mm->mmu_notifier_mm = mmu_notifier_mm;
+
 	spin_lock(&mm->mmu_notifier_mm->lock);
 	hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
 	spin_unlock(&mm->mmu_notifier_mm->lock);
 
 	mm_drop_all_locks(mm);
+	BUG_ON(atomic_read(&mm->mm_users) <= 0);
+	return 0;
+
 out_clean:
 	kfree(mmu_notifier_mm);
-	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__mmu_notifier_register);
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
