Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D8C11D34
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EDF20CC7
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxwepHpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EDF20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5005834ED;
	Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JguB6GtYtZj8; Mon, 24 Feb 2020 18:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 765C4834D7;
	Mon, 24 Feb 2020 18:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63A52C18DA;
	Mon, 24 Feb 2020 18:24:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44185C18DA
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26E8E20414
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fr1gBDDNC71z for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id A364D20498
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:32 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id m3so160645wmi.0
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kbHJ4C4uglc6rYdZYTlW3Ff7m1UL228yD2k/lvDMteQ=;
 b=BxwepHpIFjHRcQQpVZG+EplOFBe3rPSTVBngLVdFteqRT2sLkmijWsDNxP3gXAef7v
 A9Ki3xgUFAgIDFoku0kKMZVVruyvYqZ8P8ImelWV3mtAtcAJTUGNA/kEnXYxrutWTloe
 fmjk12xB0K+ir7axe3XxEzuiqhFr0/u9/5K9kFOyGIdcu5bt5VVq83gQymC8zsmkJCrv
 voT9EkmQHwO+gN+4rzvID2aVflV2VnNv2bi6U866Sm6W2RilOTdNfOLgBgPttVSwqcS3
 OsiGL9oPhNzw8EjsxCP7KMoEV62b+oEAsAdB6DLym25mnnvzgc/nSHXSofYo+yTjBwRE
 C0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kbHJ4C4uglc6rYdZYTlW3Ff7m1UL228yD2k/lvDMteQ=;
 b=rf4/04tNqPJdwEWhe4JrmF32xfkMl1KwiJXpfDKfgRoTSE8MsBtAkrek6T+uEfNwg6
 0pS+4eYBOVKE12rc+J7mCvWGzL+5U+hhIrIVRMBzANJOv4SgGnZ10Ws8TAD0AbhrRfrV
 jBDjVcupQZwZjFbm3SrC8yjuIDF4WPAcimKOF3DERt7IQWbVCbpzHxq42/vKmCBvixyP
 QNM61eaZ0ngM88KtCZjUqFxqt0PdlZrCfNfi2nDHsdMPG2ePT6ksSb9uYx0Qma3xs6JC
 TTqr1AGA3gUPoqa5fxpfaBiQ0Le4HyUXotXihw5/twFU5NZbSx85AlhLav1TlieMCF/o
 76Tg==
X-Gm-Message-State: APjAAAUucPU9O2CSEMJrqAvcpsAYoRC5XIXTiRCtxKRWg42fHUoz4uQz
 o/sEe9+hKrI+cHDeYY+brtdNzqLdQ5Y=
X-Google-Smtp-Source: APXvYqxeEVL2FgAN9u8VRKK0cl4gGMwWc0V5xlt1mC7IWnfDQ/iqcXGTBT4xHtfN+pJg9F8k5m70JQ==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr284798wme.135.1582568670689; 
 Mon, 24 Feb 2020 10:24:30 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:30 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Date: Mon, 24 Feb 2020 19:23:36 +0100
Message-Id: <20200224182401.353359-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com,
 Dimitri Sivanich <sivanich@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, catalin.marinas@arm.com,
 robin.murphy@arm.com, Jason Gunthorpe <jgg@ziepe.ca>, robh+dt@kernel.org,
 zhangfei.gao@linaro.org, Andrew Morton <akpm@linux-foundation.org>,
 will@kernel.org, christian.koenig@amd.com
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

The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
add a get/put scheme for the registration") provides a convenient way
for users to attach notifier data to an mm. However, it would be even
better to create this notifier data atomically.

Since the alloc_notifier() callback only takes an mm argument at the
moment, some users have to perform the allocation in two times.
alloc_notifier() initially creates an incomplete structure, which is
then finalized using more context once mmu_notifier_get() returns. This
second step requires carrying an initialization lock in the notifier
data and playing dirty tricks to order memory accesses against live
invalidation.

To simplify MMU notifier allocation, pass an allocation context to
mmu_notifier_get().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/misc/sgi-gru/grutlbpurge.c |  4 ++--
 include/linux/mmu_notifier.h       | 10 ++++++----
 mm/mmu_notifier.c                  |  6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608d..77610e1704f6 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -235,7 +235,7 @@ static void gru_invalidate_range_end(struct mmu_notifier *mn,
 		gms, range->start, range->end);
 }
 
-static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
+static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm, void *privdata)
 {
 	struct gru_mm_struct *gms;
 
@@ -266,7 +266,7 @@ struct gru_mm_struct *gru_register_mmu_notifier(void)
 {
 	struct mmu_notifier *mn;
 
-	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm);
+	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm, NULL);
 	if (IS_ERR(mn))
 		return ERR_CAST(mn);
 
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335e..06e68fa2b019 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -207,7 +207,7 @@ struct mmu_notifier_ops {
 	 * callbacks are currently running. It is called from a SRCU callback
 	 * and cannot sleep.
 	 */
-	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm);
+	struct mmu_notifier *(*alloc_notifier)(struct mm_struct *mm, void *privdata);
 	void (*free_notifier)(struct mmu_notifier *subscription);
 };
 
@@ -271,14 +271,16 @@ static inline int mm_has_notifiers(struct mm_struct *mm)
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
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ef3973a5d34a..8beb9dcbe0fd 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -734,6 +734,7 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  *                           the mm & ops
  * @ops: The operations struct being subscribe with
  * @mm : The mm to attach notifiers too
+ * @privdata: Initialization data passed down to ops->alloc_notifier()
  *
  * This function either allocates a new mmu_notifier via
  * ops->alloc_notifier(), or returns an already existing notifier on the
@@ -747,7 +748,8 @@ find_get_mmu_notifier(struct mm_struct *mm, const struct mmu_notifier_ops *ops)
  * and can be converted to an active mm pointer via mmget_not_zero().
  */
 struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
-					     struct mm_struct *mm)
+					     struct mm_struct *mm,
+					     void *privdata)
 {
 	struct mmu_notifier *subscription;
 	int ret;
@@ -760,7 +762,7 @@ struct mmu_notifier *mmu_notifier_get_locked(const struct mmu_notifier_ops *ops,
 			return subscription;
 	}
 
-	subscription = ops->alloc_notifier(mm);
+	subscription = ops->alloc_notifier(mm, privdata);
 	if (IS_ERR(subscription))
 		return subscription;
 	subscription->ops = ops;
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
