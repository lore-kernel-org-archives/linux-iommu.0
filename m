Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51B1C754
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 09:59:49 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3077d134028so4759400f8f.3
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683799187; x=1686391187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YviNjDFHhOqwkOhoUfFml83L4Enfc2RqdN30M/s6IK4=;
        b=aGrI7+aNFi4ljfy8dR3J49VBbZoM70kswN+XaFAVWv+4rpWu/UfZHTPJMy4NJQdHW7
         VmN2CxovXzriyOKSBzoNIjeffT1d9k7WirSXXr6q0sTubF8BnyOpe2xR6hqsFCSRIsDZ
         J577lClwPZ5CTyTMwOgHdVzDgaVm7F2F904SH0OgAhTJ2uOATb+ApXJ4hZgk8wjmZJdj
         MdmK5lcJvYN1a2teXAKfVi7qjaEccBEn0sNUxaFjvQUWu6SCIYdxrzH5RxO4dZIPDWsX
         eKH+3PDzcjA65fRvSzAHBd32uAjnnnR7yCCwD3ZA+EVwJTF7zwnRQ6tB6vGstEsak6qL
         n+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683799187; x=1686391187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YviNjDFHhOqwkOhoUfFml83L4Enfc2RqdN30M/s6IK4=;
        b=QQEUCI+KDP24eb7uBX/YsczKzHaJu9oDVbC+KMa/UdyrLfazz0aAVBu2Oe4D7C/3aS
         peMplStN7w/vO4IMCLNrr7Z8NWsQJZdWlLdT1TRWqPAA1j6w+F999w+EKNGkv5Eb23wZ
         74dBTfrt911RgoxtNeVIfPWolxgIx/DvciwZYuwjfrt5Q3IPUwDzLdHhlIfvbdRGKF3g
         5YF76bONyt+l7QdOUxvI3nCRU+xsh/kx67ABdpqvhfSi76RAdqNV7hVhe08d3I9NCw2/
         6oQML5uvEbSw1hiX5O56sEyOjYQLOdN65nxCVicl7T/juoBYf2Cg5vl2FhW8vQX4LDOQ
         S5dg==
X-Gm-Message-State: AC+VfDwdiX0FWVZY/V2R4f16gEOgSVmpThZCt2L+hTaX2zxWvnAW//g4
	TiNv10bOp8kxWQAWaV1Hg68DUQ==
X-Google-Smtp-Source: ACHHUZ6Wbdt/vmNtSDQSPAiAevcSGV91xq3D2Xpdm/EOIJxZ4lFkHeSGe2T/08MoEZv8Nk3hgv86fg==
X-Received: by 2002:adf:f30b:0:b0:2cd:bc79:5432 with SMTP id i11-20020adff30b000000b002cdbc795432mr15948521wro.25.1683799187295;
        Thu, 11 May 2023 02:59:47 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm12122791wms.2.2023.05.11.02.59.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 May 2023 02:59:46 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	jean-philippe <jean-philippe@linaro.org>,
	Wangzhou <wangzhou1@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	iommu@lists.linux.dev,
	acc@lists.linaro.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Weili Qian <qianweili@huawei.com>
Subject: [PATCH v2 1/2] uacce: use q->mapping to replace inode->i_mapping
Date: Thu, 11 May 2023 17:59:20 +0800
Message-Id: <20230511095921.9331-2-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230511095921.9331-1-zhangfei.gao@linaro.org>
References: <20230511021553.44318-1-zhangfei.gao@linaro.org>
 <20230511095921.9331-1-zhangfei.gao@linaro.org>
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

So use q->mapping to replace uacce->inode->i_mapping.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 14 +++++++-------
 include/linux/uacce.h      |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 346bd7cf2e94..338b59ef5493 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -166,8 +166,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 
 	init_waitqueue_head(&q->wait);
 	filep->private_data = q;
-	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
+	q->mapping = filep->f_mapping;
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
@@ -597,6 +591,12 @@ void uacce_remove(struct uacce_device *uacce)
 		uacce_put_queue(q);
 		mutex_unlock(&q->mutex);
 		uacce_unbind_queue(q);
+
+		/*
+		 * unmap remaining mapping from user space, preventing user still
+		 * access the mmaped area while parent device is already removed
+		 */
+		unmap_mapping_range(q->mapping, 0, 0, 1);
 	}
 
 	/* disable sva now since no opened queues */
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 0a81c3dfd26c..e290c0269944 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -86,6 +86,7 @@ enum uacce_q_state {
  * @state: queue state machine
  * @pasid: pasid associated to the mm
  * @handle: iommu_sva handle returned by iommu_sva_bind_device()
+ * @mapping: user space mapping of the queue
  */
 struct uacce_queue {
 	struct uacce_device *uacce;
@@ -97,6 +98,7 @@ struct uacce_queue {
 	enum uacce_q_state state;
 	u32 pasid;
 	struct iommu_sva *handle;
+	struct address_space *mapping;
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

