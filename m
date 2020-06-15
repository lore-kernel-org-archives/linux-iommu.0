Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB859C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 13:56:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916D0207FF
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 13:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vplh0Fj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 681A887FCC;
	Mon, 15 Jun 2020 13:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l98Ejc4F+-Ff; Mon, 15 Jun 2020 13:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5CF687FC1;
	Mon, 15 Jun 2020 13:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E00C0890;
	Mon, 15 Jun 2020 13:56:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F38EFC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 13:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EFC2886E24
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 13:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gLn92l-zk7lY for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 13:56:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E4D50860EF
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 13:56:28 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id k1so6743657pls.2
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=+BfvoZ+77dTAo4L/XNf+TiVonlXEEViAwZrs/5d7U9U=;
 b=vplh0Fj9/eSjlcLM1uoaEHsnubxkfYZJQTNBNwkrq469Vg8oUjYF+ExpyWU8sd7dd2
 tu0PGAqL6qcINmBHnDVyQ36ihZLF+SSVIKjMIBGkAuq4wqViV2XX5wTl0MR/pNqN8vG8
 al5a1MDzOAECR74HCCZ1mGHac9BHtNf+VAaOCxp1il1dTV76bP3kxPZE3WayuJ3Kz0Qs
 5QEhfbvSs+KzWvj11Rj8s1Y8Nx3394hru2UVIsGXLlcyPmVC8qzWkzlMImHRAw0Y7IpH
 Ca/eCkdU4xiK9lPNFvYWrBSR4DCk4CqoByR3ISrODiT9CdYos8pLKcblYqUMvWGxR04m
 H9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+BfvoZ+77dTAo4L/XNf+TiVonlXEEViAwZrs/5d7U9U=;
 b=lFlGZxzE/CSPTaf2QG0ExL1luCvuiemPiwZzV4p3gy33PixyKVz3rWMKAB6kaLHfM3
 tnmLy1CWm650kwBMV+6NnUxODo/GrgCYv1WIlElI43MgzxoUaKn9OjSw4xnxFlvq2LqG
 2T0abyzkfx/TUuSTRjDYsDM7EVDJcRlWGRM1PIOP3O+aLm5e5MBNpdRHvS7n5Y3EbnI9
 Frnd4BrzG2SWoA2TKqkR0g1lTVOsekL3JITKmzYFNEieRoa9C/2WeuoYmjaXnFYpVIfH
 IHTdHkbwYAEpHuIMnyXEu8U1L0pNciN4PX7j4ayIJp2KfBKmbHZr5ChhhtPfBMmf6qrJ
 lbHA==
X-Gm-Message-State: AOAM5324U4g0g5pP71kh1nL04hmsA6fLP1ITL9jbKL9MSZju90FXPLJl
 mheV9ysI/cjkwexdc+Q6X2gL0g==
X-Google-Smtp-Source: ABdhPJwVhpIdNIqkhVyeCQ5zjjJWP0RCYj7RGnqZE1YV/4j4JxB8XfQa842SpJkUUSps8c9DQx5uIw==
X-Received: by 2002:a17:902:8b88:: with SMTP id
 ay8mr22252506plb.235.1592229388518; 
 Mon, 15 Jun 2020 06:56:28 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.20])
 by smtp.gmail.com with ESMTPSA id h20sm13751691pfo.105.2020.06.15.06.56.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 06:56:27 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jean-philippe <jean-philippe@linaro.org>, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>
Subject: [PATCH] uacce: remove uacce_vma_fault
Date: Mon, 15 Jun 2020 21:55:57 +0800
Message-Id: <1592229357-1904-1-git-send-email-zhangfei.gao@linaro.org>
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

Fix NULL pointer error if removing uacce's parent module during app's
running. SIGBUS is already reported by do_page_fault, so uacce_vma_fault
is not needed. If providing vma_fault, vmf->page has to be filled as well,
required by __do_fault.

Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 107028e..aa91f69 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -179,14 +179,6 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static vm_fault_t uacce_vma_fault(struct vm_fault *vmf)
-{
-	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
-		return VM_FAULT_SIGBUS;
-
-	return 0;
-}
-
 static void uacce_vma_close(struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = vma->vm_private_data;
@@ -199,7 +191,6 @@ static void uacce_vma_close(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct uacce_vm_ops = {
-	.fault = uacce_vma_fault,
 	.close = uacce_vma_close,
 };
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
