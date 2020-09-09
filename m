Return-Path: <SRS0=bsOk=CS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5BAC433E2
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 05:39:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7D4215A4
	for <iommu@archiver.kernel.org>; Wed,  9 Sep 2020 05:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YslrSU8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D4215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5012B874D4;
	Wed,  9 Sep 2020 05:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y9Wz23s231q5; Wed,  9 Sep 2020 05:39:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DD1B874D0;
	Wed,  9 Sep 2020 05:39:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71560C0859;
	Wed,  9 Sep 2020 05:39:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B54C0051
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 05:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CF7E42E146
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 05:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55mJSwmA3ecN for <iommu@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 05:39:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 59D242E15F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Sep 2020 05:39:06 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id z19so1152533pfn.8
 for <iommu@lists.linux-foundation.org>; Tue, 08 Sep 2020 22:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=rZs5/qThJgbqO8YqJOp1eEHnebIHaFEtXXl91F8jl2A=;
 b=YslrSU8KqaqEnx/54qD5LexXZKdcw6uaXadQu7jKPZZYbgKe81YCKhCdGNCh8cMfVc
 l9TAkUNmvj3YVhmfq3P8qMJ02GQwJO7Y/+F5OkgyEjMIfxuBKvrYfsGu3/bUoFaniwKc
 shcZzMvquqojMuOhgAL+KZH8abqvjuR8J5EeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rZs5/qThJgbqO8YqJOp1eEHnebIHaFEtXXl91F8jl2A=;
 b=s3fmf+9B3tYKMt/ycjPyP7Fj2i2FXT5RQ1hyKvI+DvdFMfZRdRI9YjLPxTi9IrmSGx
 aKZyodfoDk4x9eXnQ2zUcrMLHk3TB8k86GkW7LJBu1wFG1epsqZcMKkp4HK/tQ1je5gQ
 YgfX925lpzQx8USCT3YZz9G0f/DPIx77zI9wmzzXheAkGrHFkwrGB8wTz23TXQax9lIk
 oP0yxjOSI6IaMPyyC20QRIg5E0lAoi2bUbeFpaJlB9vr6wSmF+ZH1/NVdq8Q8VympkAh
 PNwxLCS/TT/0M6HqXIw7KiH1M51RK7XddVen1WeVnd3HpQOYaGXZXhNCTDaBFe7jppvo
 UVEg==
X-Gm-Message-State: AOAM531dq3G6U+trxgJ476+pIjCxXU81hliXlnU9sSVtY7fnt0xg1tWn
 6F6jS3iYWND9TCjBqHhXNisjO9V51SXicaLc
X-Google-Smtp-Source: ABdhPJxCZK1FhqkwUgTtKJozciIvYxg2nj5pVXQhC4T8g71p4oTLqM/35nswkzPPVtFDRAn9Ve5LRQ==
X-Received: by 2002:aa7:9494:: with SMTP id z20mr2145768pfk.144.1599629599200; 
 Tue, 08 Sep 2020 22:33:19 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id w192sm1181791pfd.156.2020.09.08.22.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 22:33:18 -0700 (PDT)
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Subject: [PATCH] iommu/dma: Fix IOVA reserve dma ranges
Date: Wed,  9 Sep 2020 11:02:34 +0530
Message-Id: <20200909053234.17027-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Cc: Srinath Mannam <srinath.mannam@broadcom.com>,
 iommu@lists.linux-foundation.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fix IOVA reserve failure for memory regions listed in dma-ranges in the
following cases.

- start address of memory region is 0x0.
- end address of a memory region is equal to start address of next memory
  region.

Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/iommu/dma-iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..0a3f67a4f9ae 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -213,14 +213,21 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 	resource_list_for_each_entry(window, &bridge->dma_ranges) {
 		end = window->res->start - window->offset;
 resv_iova:
+		if (end < start) {
+			/* dma_ranges list should be sorted */
+			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			return -EINVAL;
+		}
+		/*
+		 * Skip the cases when start address of first memory region is
+		 * 0x0 and end address of one memory region and start address
+		 * of next memory region are equal. Reserve IOVA for rest of
+		 * addresses fall in between given memory ranges.
+		 */
 		if (end > start) {
 			lo = iova_pfn(iovad, start);
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
-		} else {
-			/* dma_ranges list should be sorted */
-			dev_err(&dev->dev, "Failed to reserve IOVA\n");
-			return -EINVAL;
 		}
 
 		start = window->res->end - window->offset + 1;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
