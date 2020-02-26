Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC21C4BA0E
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 07:13:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9234721556
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 07:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHBsDuat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9234721556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 611E98594B;
	Wed, 26 Feb 2020 07:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZZozcTgL-lD; Wed, 26 Feb 2020 07:13:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B1BB982756;
	Wed, 26 Feb 2020 07:13:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95090C18DA;
	Wed, 26 Feb 2020 07:13:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B199C0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 07:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E851C8647E
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 07:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FjCnG2yUp0Fd for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 07:13:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B3E07862AB
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 07:13:02 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id ep11so880360pjb.2
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=wIycLtohJzZmgbz8Z9KTZsw/kqKcbNO/JXoVgPdvu5k=;
 b=nHBsDuatJbQdosdW7LvCk7lFzVSx5qBST4bfiBlRhLz/YLONy7ALUeY1N8NsOM3ddi
 ccg3145g8DOq5tDD4Kk6Y2IXGjRLgkoaGgpUPBxjfYQfp9PGONg/cwaKsxTbjTq8lkfJ
 NRJFrxTRFogiqdjs41Drldwj1fTeruCaeArsV8sNr3GeGM4aRH7QFYF/iAaYEqBvDxGE
 vWQWG1fdS5iHFQJECDt/ivKKRqMwmljNqXW5QUs0c/vpy7uJ/rll3Z7gnOy5HDfhcRP5
 4lAYLHe5Xc63mefpieyn7o/5F3Kwo/Xe8B1uigehlVZlvp/67qNFZDphtRp5zpsFV7h4
 bYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wIycLtohJzZmgbz8Z9KTZsw/kqKcbNO/JXoVgPdvu5k=;
 b=AOaJcyITv8G8+LnPf+H579SukjfDk/wBBM/W+CMOBmW1Q7t1T0PvAKHpA60vS+QrA1
 ZeX0hqdv48bUi3K1LrO3BVpPKvLw6JGgwWRVlIvl72jInd2xXbPUOXEDLfcrVIcU9Qkp
 RFnPFQhDQW0WBQsrRfPhxmznzfwlyEowwqwFGJR9SG0Ij+llDZA2RVIXJwDTkFGQJsus
 W9UkT0tunYMDTX1NZSxjlixx7zDWmaze0lsPT9h5MoA3pOK7ap1/0xVOlU6P6/FRpV6c
 lO6ksOpjHYbPVXs1BncpmstYi/ju2Tcqr+cxbB/rAyOBiZCoOIM86KHtkuacu9MqWGvr
 biGQ==
X-Gm-Message-State: APjAAAXRh/qD0G9sUaABiLeybUZ5vE5zkm/XvZCLGTJyFjNH49r+XkyH
 PH11pWsr2lB9bFb5sSrEEEca0g==
X-Google-Smtp-Source: APXvYqwB2yOYMGKYdF2cDBBA/GEj2xBPMsZ8piwV6gUkwS3YmQ2LmROMVi5lnWOaX8djXcAihN1Nxg==
X-Received: by 2002:a17:902:8688:: with SMTP id
 g8mr2603545plo.277.1582701182230; 
 Tue, 25 Feb 2020 23:13:02 -0800 (PST)
Received: from localhost.localdomain ([240e:362:4c3:8800:a057:bb7f:18d7:2e])
 by smtp.gmail.com with ESMTPSA id b24sm1400707pfo.84.2020.02.25.23.12.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Feb 2020 23:13:01 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [PATCH v2] uacce: unmap remaining mmapping from user space
Date: Wed, 26 Feb 2020 15:12:06 +0800
Message-Id: <1582701126-5312-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When uacce parent device module is removed, user app may
still keep the mmaped area, which can be accessed unsafely.
When rmmod, Parent device driver will call uacce_remove,
which unmap all remaining mapping from user space for safety.
VM_FAULT_SIGBUS is also reported to user space accordingly.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 v2: Unmap before put_queue, where memory is freed, commented from Zaibo.

 drivers/misc/uacce/uacce.c | 16 ++++++++++++++++
 include/linux/uacce.h      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index ffced4d..d39307f 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -224,6 +224,7 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 
 	init_waitqueue_head(&q->wait);
 	filep->private_data = q;
+	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
 
 	return 0;
@@ -253,6 +254,14 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static vm_fault_t uacce_vma_fault(struct vm_fault *vmf)
+{
+	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
+		return VM_FAULT_SIGBUS;
+
+	return 0;
+}
+
 static void uacce_vma_close(struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = vma->vm_private_data;
@@ -265,6 +274,7 @@ static void uacce_vma_close(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct uacce_vm_ops = {
+	.fault = uacce_vma_fault,
 	.close = uacce_vma_close,
 };
 
@@ -556,6 +566,12 @@ void uacce_remove(struct uacce_device *uacce)
 
 	if (!uacce)
 		return;
+	/*
+	 * unmap remaining mapping from user space, preventing user still
+	 * access the mmaped area while parent device is already removed
+	 */
+	if (uacce->inode)
+		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
 
 	/* ensure no open queue remains */
 	mutex_lock(&uacce->mm_lock);
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 904a461..0e215e6 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -98,6 +98,7 @@ struct uacce_queue {
  * @priv: private pointer of the uacce
  * @mm_list: list head of uacce_mm->list
  * @mm_lock: lock for mm_list
+ * @inode: core vfs
  */
 struct uacce_device {
 	const char *algs;
@@ -113,6 +114,7 @@ struct uacce_device {
 	void *priv;
 	struct list_head mm_list;
 	struct mutex mm_lock;
+	struct inode *inode;
 };
 
 /**
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
