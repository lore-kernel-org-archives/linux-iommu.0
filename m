Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B0C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 12:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C17CA60F9F;
	Fri, 10 Jun 2022 12:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7Q6qkUILRui; Fri, 10 Jun 2022 12:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B00BF60D70;
	Fri, 10 Jun 2022 12:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B006C0032;
	Fri, 10 Jun 2022 12:34:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E61A7C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 12:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6E82419C2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 12:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mewrH0v3EzT2 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 12:34:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B10E94196D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 12:34:38 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id c18so16315181pgh.11
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fTnCXFuyCstJMPBhMqFKxxK2N1Yz6X1NLjBKTceklwM=;
 b=vur4KePcrSZwfP7+Gdvgv0bt/L+tZYdakOo7NYRMZrInzrC3kXcg9wHBqc9MWv59Gj
 fi3P0bGnYTLmFOCZOY87UWoPPXuY7QJc+kIO6+6PEhjv/QoGHk5E8Xl1QDeHaoxjM925
 7xHg3+imavV8cUH2qIm005hgrV6avSWy6ajROWVEsYy7wiHGbBStoGiNN9f9L+gfFgpZ
 0hM+Bhq6E/tbkoP6LyawPOMZPovEbkWNCktkNCzVL5E8bPvYCQx+Fa/+mN4cjMn9Ikdx
 ZCD5YqgYZsorAql4dSYI3nUD28lL5b4p/v+pdAwut8e7y3TlwPgakW7CIcLmmASc46Jo
 k8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fTnCXFuyCstJMPBhMqFKxxK2N1Yz6X1NLjBKTceklwM=;
 b=csfeKjuxjPtauQiiEENBUGB0XOk97S+JBzI26aDHwdYqv15OzV7azVBS56RZYR3q8D
 t8Mr1j71o9NQdMF6G8l3GBecp5AfQPZ9UK2kdiPiOMPsNr47FpT/9qdntLeua6/q9k6J
 jKt7SXqZwgv4jewNPFv5rNzq6eBorEhYHKFaK/gQWPk5kP4f/sepDZpcnLU/mtDEI4oq
 f4EWvaFLHG+bsvt3FF7Bc8b7PxblgY3FGiClXVHaopidWwHrWiorDPgwEUV0cwjlY+hE
 C2N/lxlEFN00jrkUcRvZaz7QR48YzWdhPGvQEnzyVRS9f361Hl/5tTD/hlxyA1eutg8v
 l7JQ==
X-Gm-Message-State: AOAM533dRUiEhwCMgzFO1Mp6F6LJ+ZAYM5h4tcR1c2/1jFy6peuxKzyS
 OPi3OFNCqaY7Q+A3ayzqVTD/tw==
X-Google-Smtp-Source: ABdhPJye0lkqFNoSURlpFSaRubFAyvZ7H6pZUjfbwhCtArda1i/1Oz2vnL3TD6wFmZ1x8rh776n3gQ==
X-Received: by 2002:a63:2160:0:b0:3fc:b8ac:1976 with SMTP id
 s32-20020a632160000000b003fcb8ac1976mr40229774pgm.453.1654864478105; 
 Fri, 10 Jun 2022 05:34:38 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.5])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a1709027e4e00b0016892555955sm5867860pln.179.2022.06.10.05.34.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jun 2022 05:34:37 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jean-philippe <jean-philippe@linaro.org>,
 Wangzhou <wangzhou1@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Date: Fri, 10 Jun 2022 20:34:23 +0800
Message-Id: <20220610123423.27496-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: Yang Shen <shenyang39@huawei.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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

The uacce parent's module can be removed when uacce is working,
which may cause troubles.

If rmmod/uacce_remove happens just after fops_open: bind_queue,
the uacce_remove can not remove the bound queue since it is not
added to the queue list yet, which blocks the uacce_disable_sva.

Change queues_lock area to make sure the bound queue is added to
the list thereby can be searched in uacce_remove.

And uacce->parent->driver is checked immediately in case rmmod is
just happening.

Also the parent driver must always stop DMA before calling
uacce_remove.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 281c54003edc..b6219c6bfb48 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	if (!q)
 		return -ENOMEM;
 
+	mutex_lock(&uacce->queues_lock);
+
+	if (!uacce->parent->driver) {
+		ret = -ENODEV;
+		goto out_with_lock;
+	}
+
 	ret = uacce_bind_queue(uacce, q);
 	if (ret)
-		goto out_with_mem;
+		goto out_with_lock;
 
 	q->uacce = uacce;
 
@@ -153,7 +160,6 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
 
-	mutex_lock(&uacce->queues_lock);
 	list_add(&q->list, &uacce->queues);
 	mutex_unlock(&uacce->queues_lock);
 
@@ -161,7 +167,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 
 out_with_bond:
 	uacce_unbind_queue(q);
-out_with_mem:
+out_with_lock:
+	mutex_unlock(&uacce->queues_lock);
 	kfree(q);
 	return ret;
 }
@@ -171,10 +178,10 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 	struct uacce_queue *q = filep->private_data;
 
 	mutex_lock(&q->uacce->queues_lock);
-	list_del(&q->list);
-	mutex_unlock(&q->uacce->queues_lock);
 	uacce_put_queue(q);
 	uacce_unbind_queue(q);
+	list_del(&q->list);
+	mutex_unlock(&q->uacce->queues_lock);
 	kfree(q);
 
 	return 0;
@@ -513,10 +520,10 @@ void uacce_remove(struct uacce_device *uacce)
 		uacce_put_queue(q);
 		uacce_unbind_queue(q);
 	}
-	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
 	uacce_disable_sva(uacce);
+	mutex_unlock(&uacce->queues_lock);
 
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
