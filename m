Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEABC54FD3
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83D42074D
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/49gtTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83D42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 13AA3203A4;
	Tue, 14 Apr 2020 17:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bbj41F8dpP72; Tue, 14 Apr 2020 17:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A821F2152C;
	Tue, 14 Apr 2020 17:04:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C35C089E;
	Tue, 14 Apr 2020 17:04:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76D0FC0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6642D87E14
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MO8JW68dSJgr for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CF0A687E24
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id y24so14904814wma.4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pm90KHnx8uK8AXrbNapri8S3uUJ3F4SFKQZ/TEPP7D0=;
 b=H/49gtTyBTSYl8Y/NsAtw8/g2zInRHKwlAM06dE15HfIZYVeRpp26xgT3c6zafASzi
 7uDVin3Kh8IClWDwqrYvKeFnyEB6udiDwCzxx2XTV4flbL6HH0XG9E/oPAZMxmIEDG2M
 jnmEkxuf7GeDgwVmmZ4SS2Ai+L4FsU4qiAepIcf4xzuUgNOcUilebN8pD4B0N++nF8Vq
 Zp/DuX2F1sTJiHAzOXJwPFc6HbGiFHxiJnEcW/IlfA8fGtHRi7Np+xmoeh36HV8dpfll
 4HfN46I/PT6emJf6bvhw3gp7qf7nU5c8gXH7dohtjLBTfv8wGTTZmGm7nQ70C7xIRVtp
 OYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pm90KHnx8uK8AXrbNapri8S3uUJ3F4SFKQZ/TEPP7D0=;
 b=WODZtYKxYRAQRS+75J98q0EEeA6ah8kzLxvtVJdtBhOsB/8rjYXBJODNVwsb/+q30f
 grqNjlwY8juDi6+bjJiR/fGF7tlXX+WEzfraw5BjYHNJCnMqs4uvQrIkkfE9EYJsa6oE
 oZIroIkkYiGsjzNkeYUfXa1GGU3KGKPOB/XkFbSHp3vlCfvgg+I0tcHWLp3DhMBntP6u
 Ortd6bceO0Tt7YnONupc+esc6oVQhZrK2P2Vp0KyM/3nyD1GY7/fCHFrZEOfHnvRMb81
 Lf/ijdy6H6l11ipNd4HkblflVTfF6iXBsVV7wRcjMkqGb8lK4maZKL94xmQ+XpjYHWAx
 8F3A==
X-Gm-Message-State: AGi0PubbRsKZ1TArme1bKNekV8uvrc8KE1SqcR3d2dGxBmrBze/3vKB0
 gAWpBJiwSCDyfKAjIicYQY64J3WXeQP3kw==
X-Google-Smtp-Source: APiQypJk/dl8CBfLNh5x7aucnzwvWIEs4TpxXFyGB0h6saUKXXv74fXgKyRLf7k//vQrLyri2cta5A==
X-Received: by 2002:a1c:998b:: with SMTP id b133mr767731wme.65.1586883865987; 
 Tue, 14 Apr 2020 10:04:25 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:25 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 06/25] iommu/sva: Register page fault handler
Date: Tue, 14 Apr 2020 19:02:34 +0200
Message-Id: <20200414170252.714402-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
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

When enabling SVA, register the fault handler. Device driver will register
an I/O page fault queue before or after calling iommu_sva_enable. The
fault queue must be flushed before any io_mm is freed, to make sure that
its PASID isn't used in any fault queue, and can be reallocated.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/iommu-sva.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bf620bf48da03..411a7ee2ab12d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -106,6 +106,7 @@ config IOMMU_DMA
 config IOMMU_SVA
 	bool
 	select IOASID
+	select IOMMU_PAGE_FAULT
 	select IOMMU_API
 	select MMU_NOTIFIER
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b177d6cbf4fff..00d5e7e895e80 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -420,6 +420,12 @@ void iommu_sva_unbind_generic(struct iommu_sva *handle)
 	if (WARN_ON(!param))
 		return;
 
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	iopf_queue_flush_dev(handle->dev, bond->io_mm->pasid);
+
 	mutex_lock(&param->sva_lock);
 	mutex_lock(&iommu_sva_lock);
 	io_mm_detach(bond);
@@ -457,6 +463,10 @@ int iommu_sva_enable(struct device *dev, struct iommu_sva_param *sva_param)
 		goto err_unlock;
 	}
 
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		goto err_unlock;
+
 	dev->iommu->sva_param = new_param;
 	mutex_unlock(&param->sva_lock);
 	return 0;
@@ -494,6 +504,7 @@ int iommu_sva_disable(struct device *dev)
 		goto out_unlock;
 	}
 
+	iommu_unregister_device_fault_handler(dev);
 	kfree(param->sva_param);
 	param->sva_param = NULL;
 out_unlock:
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
