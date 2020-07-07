Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D50C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 01:14:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446F7206F6
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 01:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446F7206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F067F20104;
	Tue,  7 Jul 2020 01:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6NCyHfe1rjA3; Tue,  7 Jul 2020 01:14:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0CF22002C;
	Tue,  7 Jul 2020 01:14:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82876C0893;
	Tue,  7 Jul 2020 01:14:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C494EC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 01:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AF98E88882
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 01:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hcRgwMzIE1fr for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 01:14:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn
 [202.108.3.162])
 by whitealder.osuosl.org (Postfix) with SMTP id 03DBD864F3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 01:14:34 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([221.219.171.29])
 by sina.com with ESMTP
 id 5F03CC75000190B2; Tue, 7 Jul 2020 09:14:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 37209149283360
From: Hillf Danton <hdanton@sina.com>
To: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
Date: Tue,  7 Jul 2020 09:14:19 +0800
Message-Id: <20200707011420.1416-1-hdanton@sina.com>
In-Reply-To: <69f9079f-b1b0-3296-4536-8f0a051a96c2@web.de>
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
MIME-Version: 1.0
Cc: Hillf Danton <hdanton@sina.com>, Yan Zhao <yan.y.zhao@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Christoph Hellwig <hch@lst.de>
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


On Mon, 6 Jul 2020 16:04:13 +0200 Markus Elfring wrote:
> 
> Can another design approach make sense here?
> 
> +	bool thread_use_mm = ((current->flags & PF_KTHREAD) && !current->mm);
> +	if (thread_use_mm)

Good. See below.
> 
> 
> >  		kthread_use_mm(mm);


--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2798,7 +2798,7 @@ static int vfio_iommu_type1_dma_rw_chunk
 	struct mm_struct *mm;
 	unsigned long vaddr;
 	struct vfio_dma *dma;
-	bool kthread = current->mm == NULL;
+	bool kthread_load_mm;
 	size_t offset;
 
 	*copied = 0;
@@ -2812,11 +2812,12 @@ static int vfio_iommu_type1_dma_rw_chunk
 		return -EPERM;
 
 	mm = get_task_mm(dma->task);
-
 	if (!mm)
 		return -EPERM;
 
-	if (kthread)
+	kthread_load_mm = current->flags & PF_KTHREAD &&
+				current->mm == NULL;
+	if (kthread_load_mm)
 		kthread_use_mm(mm);
 	else if (current->mm != mm)
 		goto out;
@@ -2843,7 +2844,7 @@ static int vfio_iommu_type1_dma_rw_chunk
 	} else
 		*copied = copy_from_user(data, (void __user *)vaddr,
 					   count) ? 0 : count;
-	if (kthread)
+	if (kthread_load_mm)
 		kthread_unuse_mm(mm);
 out:
 	mmput(mm);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
