Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CB1C754
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 09:59:57 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-30626f4d74aso5448891f8f.0
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683799195; x=1686391195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gMr5NOPVmuNsZ2AgAQsBS1s/tGTLr7USPVZEmTtLAM=;
        b=P69Q7bzbfakRA/K9JgmDghQPAMnRpt0SCpQ7ZEumIPlKWL6gppMxmleXCq84NRDQec
         L2leVzR/3FWZLsOj6Tl6Lex+dPFazIfbltuPkNdELguYK9TjZf/WA3SwYldnKNuD33cY
         i6uyQL+VVn9SJjeCEw1kfc9ZC3MC3bElmvRDJRLebt/SEChGfGw+F+z5Xcf2FixWs+Xp
         Sg7ShRary7Rz+qfF4Bwfz3G5Fgox00N/+dYFL+zNdz36daMbcPuLYtYVi8wEXEoFrAq3
         tYrRDOVU9B+js8/ZnaxWh01dOtRU60ZLFi0ybj43WSF9n9IwXb3clh60dC0V+yh+OPsZ
         m9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683799195; x=1686391195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gMr5NOPVmuNsZ2AgAQsBS1s/tGTLr7USPVZEmTtLAM=;
        b=eODYyoIYRz08cl34dOUDVCfxZEUgRKe2bfLJO++6+3M7US6TMRQmoL4F6rFpl1TieU
         bx7LjaamrdpGkkWlnfyG/qr2UQUQ5o5SxqnRfXu2jwBQZr6IgDKbQqoM/jacdJeX2Lja
         eFP1U+Rmz/tSWgfZD5973QSp4t9TPynzCXY7eRo/ORkZTJ1xLoC1saJZMyg14C7tDgwm
         A2/F2AMCQtoYAvN9GGXXg/SLAF2fULnzh7krvNPtws4hiKwhTMrRzTZ6qgtwGiTohqnz
         ZMQ9kyIfOlo3EVzcKC0EbjWzv8bdEVWupTWi8x4VfjzDnG4o5CxMi80LBv2kaeLdwVF5
         ZxSg==
X-Gm-Message-State: AC+VfDy/MG6TbF6ExrG3WtwF2MQ8mb12yXapxN/Ga0aRiTphvMyA55BY
	vND0Ba8nXS9nYmDeP//R2YZd8Q==
X-Google-Smtp-Source: ACHHUZ4pzscXK11l7u6GlPD+PahTw1+974nMATdOD8dNFVVaDttsw1qXyCihSWf8jbDdM1+W/oZSLg==
X-Received: by 2002:adf:d0c7:0:b0:306:372d:7891 with SMTP id z7-20020adfd0c7000000b00306372d7891mr14334874wrh.59.1683799195475;
        Thu, 11 May 2023 02:59:55 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm12122791wms.2.2023.05.11.02.59.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 May 2023 02:59:55 -0700 (PDT)
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
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 2/2] uacce: vma_close clears q->qfrs when freeing qfrs
Date: Thu, 11 May 2023 17:59:21 +0800
Message-Id: <20230511095921.9331-3-zhangfei.gao@linaro.org>
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

vma_close frees qfrs but not clears q->qfrs, which still points
to the freed object, leading to subsequent mmap fail.
So vma_close clears q->qfrs as well.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 338b59ef5493..930c252753a0 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -200,12 +200,15 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 static void uacce_vma_close(struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = vma->vm_private_data;
-	struct uacce_qfile_region *qfr = NULL;
 
-	if (vma->vm_pgoff < UACCE_MAX_REGION)
-		qfr = q->qfrs[vma->vm_pgoff];
+	if (vma->vm_pgoff < UACCE_MAX_REGION) {
+		struct uacce_qfile_region *qfr = q->qfrs[vma->vm_pgoff];
 
-	kfree(qfr);
+		mutex_lock(&q->mutex);
+		q->qfrs[vma->vm_pgoff] = NULL;
+		mutex_unlock(&q->mutex);
+		kfree(qfr);
+	}
 }
 
 static const struct vm_operations_struct uacce_vm_ops = {
-- 
2.39.2 (Apple Git-143)

