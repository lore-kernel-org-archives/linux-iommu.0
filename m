Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30597C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 04:02:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D75A64E37
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 04:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D75A64E37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E40540102;
	Fri, 19 Mar 2021 04:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gK-Uv35xKERA; Fri, 19 Mar 2021 04:02:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53720400FC;
	Fri, 19 Mar 2021 04:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 281CDC000B;
	Fri, 19 Mar 2021 04:02:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27650C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 147ED4EC4F
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gzf879oF6OtS for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 04:02:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 724254ECA1
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 04:02:07 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id h3so4952371pfr.12
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 21:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G7mFIfrzw76jaQ9BbBSTUMUy/Bx5PZFnj8PSi3nxWPw=;
 b=vT5gF/rP53wrLkt5FgWCnTvzL2Lm4+0MTd2LwNkfliI0IofCaUUuhYXBqnGH8mgQse
 XVRj9uu6bkRZ6TnndZ88Via39/wpmpS0U7pogW2EtRIk5hI896hyTVe9S2E1Zj5MZoMB
 WLIWtZYnsytiJ7l3VGQgZbDeQLPIe6yQAfIU0oPK4kGMQtCZoVxDTY8/guk+M9ZCS8YE
 NCeFxN6Y30db9cdXAPgn7UyKg5RtQZWd43qWuFWe51rF/gOApFxwsMGpf03s6OC2YFJZ
 LRsPB+10LblXK4BlELJjHLCIYPMwEoMwzJMT82XSrN8jTlQ94VM7wa6diGZpUXjoiy5r
 6DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G7mFIfrzw76jaQ9BbBSTUMUy/Bx5PZFnj8PSi3nxWPw=;
 b=GS+kkG9w1t8VrY90+cfjEm219zBAGwRRBSd5Zk1+Zcmo2uJZsv54z6hI/YmjfLVNnB
 NvVT4E0q3SkJdk3UQhBih4tH7b78RoX+iFiGZ3Wt3gX3cqc+1cbch/g6cdr+A3YCjPvX
 ljXFwrmZ24gV3eX+04woWyD9HfqvQL3zIKu8ZHu13UVZ7NSlsAuv6cXHK73QZ/eoXqXu
 IFVi2YxrHa0Fx/ToU2GN9V85qKHiFQt5Q9NI52Sp/heKnu2+39PCQCWKx50WhA5EdKmS
 IlzaJ8gxX3AC8R9nN6aPz2Rxj4UFRtOV4rP5aGgA4TaSwpwTbsunZh6tIKIzPUcM3aMZ
 jMPg==
X-Gm-Message-State: AOAM532O9xp0NODlNapgfF9FVt5REUntl6AdCHS2OfdWjlo6viiaIq6g
 6Kq6q2ZigaiAKZk9Q10vZTY=
X-Google-Smtp-Source: ABdhPJwOT5v2SjIr5oPyeuziHKydK5prtvXzLz9YHJ/Nhd6vYqvzGx7avXYViGHQxS9NCyperggkcg==
X-Received: by 2002:a62:cfc4:0:b029:200:49d8:6f29 with SMTP id
 b187-20020a62cfc40000b029020049d86f29mr7012389pfg.45.1616126526798; 
 Thu, 18 Mar 2021 21:02:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s22sm3347487pgv.94.2021.03.18.21.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 21:02:06 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Date: Thu, 18 Mar 2021 21:00:54 -0700
Message-Id: <20210319040055.183433-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318191816.4185226-1-f.fainelli@gmail.com>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 opendmb@gmail.com, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

When SWIOTLB_NO_FORCE is used, there should really be no allocations of
io_tlb_nslabs to occur since we are not going to use those slabs. If a
platform was somehow setting swiotlb_no_force and a later call to
swiotlb_init() was to be made we would still be proceeding with
allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
was set on the kernel command line we would have only allocated 2KB.

This would be inconsistent and the point of initializing io_tlb_nslabs
to 1, was to avoid hitting the test for io_tlb_nslabs being 0/not
initialized.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/dma/swiotlb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c10e855a03bc..526c8321b76f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -121,12 +121,10 @@ setup_io_tlb_npages(char *str)
 	}
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force")) {
+	if (!strcmp(str, "force"))
 		swiotlb_force = SWIOTLB_FORCE;
-	} else if (!strcmp(str, "noforce")) {
+	else if (!strcmp(str, "noforce"))
 		swiotlb_force = SWIOTLB_NO_FORCE;
-		io_tlb_nslabs = 1;
-	}
 
 	return 0;
 }
@@ -284,6 +282,9 @@ swiotlb_init(int verbose)
 	unsigned char *vstart;
 	unsigned long bytes;
 
+	if (swiotlb_force == SWIOTLB_NO_FORCE)
+		goto out;
+
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
@@ -302,6 +303,7 @@ swiotlb_init(int verbose)
 		io_tlb_start = 0;
 	}
 	pr_warn("Cannot allocate buffer");
+out:
 	no_iotlb_memory = true;
 }
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
