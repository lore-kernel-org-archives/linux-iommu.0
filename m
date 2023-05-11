Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB82F2D
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 02:16:22 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3078fa679a7so4707314f8f.3
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 19:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683771381; x=1686363381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7NhY70nKePpFKW1tNMvcsBAqsK2Oz2JiYYqlXCn6ek=;
        b=VzlDVeswYJTkHS18WfZGHZ94kK1HMGNiS+QWCFjD+YQvom1A9OAwXhkdBvdBe22xb1
         wo2+YNPN2MLaLnGPFkdicBRqtv0CqWMFPg8QmcSKYNV9CwYtC9HjcrmNGJ/D2dsCz3lb
         Z5PlRQDTuLjC9YYVM1X5I8xGDP/4vF1xu/GrZJojtbOuyCP+QJF9DWyY0/3Y99Q8a5ua
         eByKEUXFxYnoBU9GBECtwMdo6BJkmns+hZ8YD2GZV8eQReJfbHcXZ0zBy6866p8r3miX
         9dO9UeQ30UHWgOkJMCSmPXFkmsjsPkCrdbwew7yxIcitgBsJRx24CfkS0WtbbIPC8y/0
         lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683771381; x=1686363381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7NhY70nKePpFKW1tNMvcsBAqsK2Oz2JiYYqlXCn6ek=;
        b=a/dniEwqP3h72NL68cVqsGUqsFl0VA0c0pAUlvQyqBA3blLjjLiMyCJ19AoFhpmm4V
         1rSLl7AaS7bHYcmyObT3H8rYumMsVEhsM1J6md5aGsBssXZOA5U5Hnq/TC74Yk4Zc1YP
         IXtmn4ymZUfXg3PET1n0HI83G54LFdXZXDjDjcCZWKUPoSytXreFD41SYzitA0znzW0T
         3LjXjWnEjNs49wdOTjmybJdEvIuClJrUWWQVL9zLSMTfusNTr1SLfrclus3nWZpILsY3
         dimuIArZnrU5IYM2FM/YZzxPvhgXropDnqt/Iad+dOC55A9NcyZjO/54KW/qW06pB1Sb
         Awig==
X-Gm-Message-State: AC+VfDxNEYH9xNvKVOtnF1ykexB0Cc4AFo+fAW5XpiRuy4jRVXtghjaH
	QuYkVav8NS84PU9rj29ISWJ9nQ==
X-Google-Smtp-Source: ACHHUZ7Sd+QhrUQhXDP5FYiCHBKYHYlWW2eiRLWyVaZMfV2uj0aNLztC4C2YUrLSDZA108qzs4//xg==
X-Received: by 2002:a5d:45c7:0:b0:306:3bac:e235 with SMTP id b7-20020a5d45c7000000b003063bace235mr11720300wrs.10.1683771380676;
        Wed, 10 May 2023 19:16:20 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4492000000b003021288a56dsm18945908wrq.115.2023.05.10.19.16.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 May 2023 19:16:20 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	jean-philippe <jean-philippe@linaro.org>,
	Wangzhou <wangzhou1@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	iommu@lists.linux.dev,
	acc@lists.linaro.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Weili Qian <qianweili@huawei.com>
Subject: [PATCH] uacce: use filep->f_mapping to replace inode->i_mapping
Date: Thu, 11 May 2023 10:15:53 +0800
Message-Id: <20230511021553.44318-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inode can be different in a container, for example, a docker and host
both open the same uacce parent device, which uses the same uacce struct
but different inode, so uacce->inode is not enough.

What's worse, when docker stops, the inode will be destroyed as well,
causing use-after-free in uacce_remove.

So use q->filep->f_mapping to replace uacce->inode->i_mapping.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 16 +++++++++-------
 include/linux/uacce.h      |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 346bd7cf2e94..740ace422baa 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -166,8 +166,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 
 	init_waitqueue_head(&q->wait);
 	filep->private_data = q;
-	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
+	q->private_data = filep;
 	mutex_init(&q->mutex);
 	list_add(&q->list, &uacce->queues);
 	mutex_unlock(&uacce->mutex);
@@ -574,12 +574,6 @@ void uacce_remove(struct uacce_device *uacce)
 
 	if (!uacce)
 		return;
-	/*
-	 * unmap remaining mapping from user space, preventing user still
-	 * access the mmaped area while parent device is already removed
-	 */
-	if (uacce->inode)
-		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
 
 	/*
 	 * uacce_fops_open() may be running concurrently, even after we remove
@@ -589,6 +583,8 @@ void uacce_remove(struct uacce_device *uacce)
 	mutex_lock(&uacce->mutex);
 	/* ensure no open queue remains */
 	list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
+		struct file *filep = q->private_data;
+
 		/*
 		 * Taking q->mutex ensures that fops do not use the defunct
 		 * uacce->ops after the queue is disabled.
@@ -597,6 +593,12 @@ void uacce_remove(struct uacce_device *uacce)
 		uacce_put_queue(q);
 		mutex_unlock(&q->mutex);
 		uacce_unbind_queue(q);
+
+		/*
+		 * unmap remaining mapping from user space, preventing user still
+		 * access the mmaped area while parent device is already removed
+		 */
+		unmap_mapping_range(filep->f_mapping, 0, 0, 1);
 	}
 
 	/* disable sva now since no opened queues */
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 0a81c3dfd26c..64b800b74436 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -86,6 +86,7 @@ enum uacce_q_state {
  * @state: queue state machine
  * @pasid: pasid associated to the mm
  * @handle: iommu_sva handle returned by iommu_sva_bind_device()
+ * @private_data: private data for saving filep
  */
 struct uacce_queue {
 	struct uacce_device *uacce;
@@ -97,6 +98,7 @@ struct uacce_queue {
 	enum uacce_q_state state;
 	u32 pasid;
 	struct iommu_sva *handle;
+	void *private_data;
 };
 
 /**
@@ -114,7 +116,6 @@ struct uacce_queue {
  * @mutex: protects uacce operation
  * @priv: private pointer of the uacce
  * @queues: list of queues
- * @inode: core vfs
  */
 struct uacce_device {
 	const char *algs;
@@ -130,7 +131,6 @@ struct uacce_device {
 	struct mutex mutex;
 	void *priv;
 	struct list_head queues;
-	struct inode *inode;
 };
 
 #if IS_ENABLED(CONFIG_UACCE)
-- 
2.39.2 (Apple Git-143)

