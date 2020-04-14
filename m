Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEAFC38A2F
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568CB206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWE+Ha3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568CB206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 30BDA87E14;
	Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5r52tn0K8LvR; Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7850487E1D;
	Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 666E0C1D8D;
	Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFBE5C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DE93785736
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tXQe21nxHXWS for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C501C8685D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:20 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x4so13826206wmj.1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b6r9zjaLOb/GY5SoRpnEsPfEzGNaayu9MqJdVBCZ20o=;
 b=iWE+Ha3lwIqVGIoKielsz3b3GDoqi8l3C468or7bgi54G/h1gdEn0dD/YvuAMHgCeJ
 EMqOZbJZx5U5awxLOQAd2pINRO8y8sNmo7jLhIBYvGyt19LoEB9d7iUIzre18QneTMXO
 LqFGxoLmiYcy+EhTcPGD3P50QcwUTSk+obkjlzR6wyD7Cu8axRt34C4qoR19Q4fY/qPu
 6cYohrZxSw/fNyRoRu7miy+Fp0/LP/4nC/zrXgblHo9xmLPZQrrkD5FpmmKK22xAGV8L
 lCjeZ0jBo7yLQuG0hyuY2ROHJ2xc1P/6x6Aq3o5kGd0600JT2eI6K17NmBDNHw+mYaTf
 G5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b6r9zjaLOb/GY5SoRpnEsPfEzGNaayu9MqJdVBCZ20o=;
 b=thoz73oYI6FSTY3oSxMDB6uW7CZI/0Hbi7HnPSuJKJAX9yMmiSYmQcLp63WsvNziD3
 gwMxd1AKyW+pIoyn29SlPxdqzTtSOlvXZIDMVQkWWqg+U7vrqbKw17J1a5w4PIF6TLYQ
 Cee1gu8yk1/KBU7792W0ybDJ36R162AXezSEL4ZMazFBxryaAEzB+QJjP/AQnHdzIGmR
 5ClJChSH6z8sKwp3epRw+OZgwW6pSRa5ZGdo83n9aJkS9MBU7RI0u265w3vx9vCbI3gX
 uXfRNwG2oHooN95XP4WpZvZlKxaGOiqv7tMZZULM3q9PoxRicimhbK9DKUD5UA/TuZqE
 Z/7Q==
X-Gm-Message-State: AGi0PuZZ1qLQImOTY+E06ZcuYHclF7AQI3HJJzTeI/6kw063lOr7cMTv
 0Jg1A5TSck0GDkDVSGGW94Htieoe2bm0EQ==
X-Google-Smtp-Source: APiQypLthjr9z+as/UbmGxH1LFQNNhaVrNfKWpaF3zHP/bGjSokMXTPjjI6Xd6SCr4lJr4d8XHGMDw==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr814161wmy.30.1586883858934; 
 Tue, 14 Apr 2020 10:04:18 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:18 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 01/25] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Date: Tue, 14 Apr 2020 19:02:29 +0200
Message-Id: <20200414170252.714402-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, catalin.marinas@arm.com,
 robin.murphy@arm.com, jgg@ziepe.ca, Dimitri Sivanich <sivanich@sgi.com>,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The new allocation scheme introduced by commit 2c7933f53f6b
("mm/mmu_notifiers: add a get/put scheme for the registration") provides
a convenient way for users to attach notifier data to an mm. However, it
would be even better to create this notifier data atomically.

Since the alloc_notifier() callback only takes an mm argument at the
moment, some users have to perform the allocation in two times.
alloc_notifier() initially creates an incomplete structure, which is
then finalized using more context once mmu_notifier_get() returns. This
second step requires extra care to order memory accesses against live
invalidation.

The IOMMU SVA module, which attaches an mm to multiple devices,
exemplifies this situation. In essence it does:

	mmu_notifier_get()
	  alloc_notifier()
	     A = kzalloc()
	  /* MMU notifier is published */
	A->ctx = ctx;				// (1)
	device->A = A;
	list_add_rcu(device, A->devices);	// (2)

The invalidate notifier, which may start running before A is fully
initialized, does the following:

	io_mm_invalidate(A)
	  list_for_each_entry_rcu(device, A->devices)
	    device->invalidate(A->ctx)

The invalidate() thread must observe the initialization (1) before (2),
which is easily solved by fully initializing object A in
alloc_notifier(), before publishing the MMU notifier.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: provide example in commit message, fix style.
---
 include/linux/mmu_notifier.h       | 11 +++++++----
 drivers/misc/sgi-gru/grutlbpurge.c |  5 +++--
 mm/mmu_notifier.c                  |  6 ++++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335ed..0536fe85e7457 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -207,7 +207,8 @@ struct mmu_notifier_ops {
 	 * callbacks are currently running. It is called from a SRCU callback
 	 * and cannot sleep.
 	 */
-	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm);
+	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm,
+					       void *privdata);
 	void (*free_notifier)(struct mmu_notifier *subscription);
 };
 
@@ -271,14 +272,16 @@ static inline int mm_has_notifiers(struct mm_struct *mm)
 }
 
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
-					     struct mm_struct *mm);
+					     struct mm_struct *mm,
+					     void *privdata);
 static inline struct mmu_notifier *
-mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm)
+mmu_notifier_get(const struct mmu_notifier_ops *ops, struct mm_struct *mm,
+		 void *privdata)
 {
 	struct mmu_notifier *ret;
 
 	down_write(&mm->mmap_sem);
-	ret = mmu_notifier_get_locked(ops, mm);
+	ret = mmu_notifier_get_locked(ops, mm, privdata);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608df..336e1b1df072f 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -235,7 +235,8 @@ static void gru_invalidate_range_end(struct mmu_notifier *mn,
 		gms, range->start, range->end);
 }
 
-static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
+static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm,
+					       void *privdata)
 {
 	struct gru_mm_struct *gms;
 
@@ -266,7 +267,7 @@ struct gru_mm_struct *gru_register_mmu_notifier(void)
 {
 	struct mmu_notifier *mn;
 
-	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm);
+	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm, NULL);
 	if (IS_ERR(mn))
 		return ERR_CAST(mn);
 
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 06852b896fa63..6b9bfb8ca94d2 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -743,6 +743,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  *                           the mm & ops
  * @ops: The operations struct being subscribe with
  * @mm : The mm to attach notifiers too
+ * @privdata: Initialization data passed down to ops->alloc_notifier()
  *
  * This function either allocates a new mmu_notifier via
  * ops->alloc_notifier(), or returns an already existing notifier on the
@@ -756,7 +757,8 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  * and can be converted to an active mm pointer via mmget_not_zero().
  */
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
-					     struct mm_struct *mm)
+					     struct mm_struct *mm,
+					     void *privdata)
 {
 	struct mmu_notifier *subscription;
 	int ret;
@@ -769,7 +771,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 			return subscription;
 	}
 
-	subscription = ops->alloc_notifier(mm);
+	subscription = ops->alloc_notifier(mm, privdata);
 	if (IS_ERR(subscription))
 		return subscription;
 	subscription->ops = ops;
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
