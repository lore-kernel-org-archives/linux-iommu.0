Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF87C433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:18:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801AC64F2A
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801AC64F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20DE8400C9;
	Thu, 18 Mar 2021 19:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uer1ij9sBOdQ; Thu, 18 Mar 2021 19:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C2AC400BC;
	Thu, 18 Mar 2021 19:18:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D76C1C000B;
	Thu, 18 Mar 2021 19:18:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED2C5C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6184400C7
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HM617s7yHw4T for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 19:18:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CBFE400BC
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:18:34 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id bt4so3428017pjb.5
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u/NaYdFXtlzFcS9g4jr5fVZB7FIesAp70iyBKhysIZI=;
 b=S0Zl/LTLeEBUdhTC+jeUj9e95tgW/RcRt/AX0TMM2jIpbbW2Y7vJrG074gPvuuSLxo
 7VtIgGJt6nwy82W8O8lxgolf2Ck3hN+HHVro9iciIAaM2LjxlD7t+wjiJj0d/oOYtp35
 tMQ4zUOgwoYGKljQ/wHxLrKLiyvvQq3Mz0kr5tR7tOx4g3Al1xl5Hq5Ije5p7zHFCN3m
 sX3nGd/+MryD8ECQddM5GtWXLa2RbTz3b49uLM/i3iktD9F/9ifDzFyNcc7FQa3UKcaH
 qP+cWZKlKel+xHotoEqKhTh2ngTgJOa7CdPE6D6zZdxg6w/UODrxIsvm7RUYK60E49Z7
 9wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u/NaYdFXtlzFcS9g4jr5fVZB7FIesAp70iyBKhysIZI=;
 b=mhD/3kX+hIOhRqQ1p3tW5zSUUDdXRKLvOr53MUWAS2n3hWBfUIWzIIzAvjylTD74c+
 iTHDGrrWNDWlPV+TzfSvG4mMBDGa0eptFnKWXoGt0Tu3RuhfvXXuH9/d/frP0tuA4qHq
 Zzb10E9WOwTehNnae/RNjsFRYmNkrekHrrIw3ZLhOyQBK0VHU8+Ww9mj/oVT/X01BGlh
 u9dQ4v2OwojfoL4Phsmjn35olrzwkJy6E2YVB3TWjBo28uPkdtofyAH2wQ3LABjkAKQZ
 0zSFyuk0Mp9F2TFelez7b2Yk203uryj6QncvurNo/s3//qlaBh7afVWfusv2iGmzlsXy
 fnrw==
X-Gm-Message-State: AOAM531q5cGJ+9XsvRb+1qsbZei7pe5iuvSfmaCflz/iyGqJ9RaxuYgX
 59AeP4W3XP/i6l7Pe4xJDLk=
X-Google-Smtp-Source: ABdhPJwm9cn3+ty6m9bscYeLI1ObHPxvuox7k4plqvKWGjZFP9XWBv0av+F/gOX0yt4i11b/fwP6RA==
X-Received: by 2002:a17:902:7609:b029:e6:9f29:625f with SMTP id
 k9-20020a1709027609b02900e69f29625fmr11336669pll.80.1616095113517; 
 Thu, 18 Mar 2021 12:18:33 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h2sm2896177pfq.139.2021.03.18.12.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 12:18:33 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
Date: Thu, 18 Mar 2021 12:18:14 -0700
Message-Id: <20210318191816.4185226-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 opendmb@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Robin Murphy <robin.murphy@arm.com>,
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

It may be useful to disable the SWIOTLB completely for testing or when a
platform is known not to have any DRAM addressing limitations what so
ever.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 include/linux/swiotlb.h                         | 1 +
 kernel/dma/swiotlb.c                            | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..b0223e48921e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5278,6 +5278,7 @@
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			off -- Completely disable SWIOTLB
 
 	switches=	[HW,M68k]
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5857a937c637..23f86243defe 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,6 +15,7 @@ enum swiotlb_force {
 	SWIOTLB_NORMAL,		/* Default - depending on HW DMA mask etc. */
 	SWIOTLB_FORCE,		/* swiotlb=force */
 	SWIOTLB_NO_FORCE,	/* swiotlb=noforce */
+	SWIOTLB_OFF,		/* swiotlb=off */
 };
 
 /*
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c10e855a03bc..d7a4a789c7d3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -126,6 +126,8 @@ setup_io_tlb_npages(char *str)
 	} else if (!strcmp(str, "noforce")) {
 		swiotlb_force = SWIOTLB_NO_FORCE;
 		io_tlb_nslabs = 1;
+	} else if (!strcmp(str, "off")) {
+		swiotlb_force = SWIOTLB_OFF;
 	}
 
 	return 0;
@@ -229,6 +231,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	unsigned long i, bytes;
 	size_t alloc_size;
 
+	if (swiotlb_force == SWIOTLB_OFF)
+		return 0;
+
 	bytes = nslabs << IO_TLB_SHIFT;
 
 	io_tlb_nslabs = nslabs;
@@ -284,6 +289,9 @@ swiotlb_init(int verbose)
 	unsigned char *vstart;
 	unsigned long bytes;
 
+	if (swiotlb_force == SWIOTLB_OFF)
+		goto out;
+
 	if (!io_tlb_nslabs) {
 		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
 		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
@@ -302,6 +310,7 @@ swiotlb_init(int verbose)
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
