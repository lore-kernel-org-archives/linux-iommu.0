Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DBBC3A5A8
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 08:34:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE1D21874
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 08:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYu84DUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE1D21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4E977CBF;
	Mon,  2 Sep 2019 08:34:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBD79CB7
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 08:34:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D808709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 08:34:55 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id l21so7137055pgm.3
	for <iommu@lists.linux-foundation.org>;
	Mon, 02 Sep 2019 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=uFmY0zGFn+EQnA57VOg3VeO9qiRTqjJoOe1gdV98IwA=;
	b=cYu84DUjPTKSgEfeLZtea5ZEO+oEaJLALl1KB7muOH5m/fFs57yP+LCBWA6ArhPio2
	WkWh2wrJ47bV5YbLwT4iwCqb0Ai/rODNnzr2DLp/L4oyyVLmYnl8diGTiWZcLmPts4RT
	Fvycb5VDcIqhCDQUwOkf5B/KrPFRGEDMpFQ0ye36mXAuIE2ktSav4aoIKXNO5UKgjCs9
	XeRU/NPTPSKO6SIsAXPP6l9CAopbF2aMh6wQABGv4Bll8xPxRW8O0MHHWhR31XaYpl8N
	rSDNcLd/VdJKmITmEkdXcJB0iI2uADXabuFqj6oUAtUumdu4JVui5i97iRe4w4fSGhL9
	VORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=uFmY0zGFn+EQnA57VOg3VeO9qiRTqjJoOe1gdV98IwA=;
	b=sEEYrxTTsAAEoziLLVR3rutr5ogyr6uuVsU1+sJmseKi4Psb/GADmHJ+zCpFR5kaTM
	eUUwOxZ0MqMg0wVY0qMZO/1wDEvAUQCiEAMwRmG2OlwWK5RcpDqu4TmxzrVDp8Y51bDW
	m9BBnRxrxehGFAVX0FAAw1YBvIrZlcJ7JwQudry7rcm/z1hggMvQYpFplTlRmvgwKsj2
	Hupu4ym3622Pie4VljVFTBwQRwYp+3/Gjyjd+Bm1zqmudt3nBPdi2LUjWI4PgraKgH6l
	36lE2yFCK/TIURQjZnkp3b06ykgTQ4h7jVdn0U6Q0EQiN8LE+mRMhP69QJuuCKLWRiHf
	Ot8g==
X-Gm-Message-State: APjAAAU1S0AldZg8LUqleH0c3DvPrdwhdEHqfIYpzDnznjXMBXyaE3UF
	JDH7h5K85+2fRWyN208GKao=
X-Google-Smtp-Source: APXvYqykyTr1V1UXoAhEng9PvF5ygE64bFW8pzDF90EN8gbWoiWOHtdCIKRzyJWgs9NYY7KHzCPF3A==
X-Received: by 2002:a63:184b:: with SMTP id 11mr25468636pgy.112.1567413294974; 
	Mon, 02 Sep 2019 01:34:54 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.39])
	by smtp.gmail.com with ESMTPSA id g9sm6977813pjl.0.2019.09.02.01.34.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 02 Sep 2019 01:34:53 -0700 (PDT)
From: Souptick Joarder <jrdr.linux@gmail.com>
To: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
	sstabellini@kernel.org
Subject: [PATCH v2] swiotlb-xen: Convert to use macro
Date: Mon,  2 Sep 2019 14:09:58 +0530
Message-Id: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: Souptick Joarder <jrdr.linux@gmail.com>, xen-devel@lists.xenproject.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	sabyasachi.linux@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Rather than using static int max_dma_bits, this
can be coverted to use as macro.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ae1df49..d1eced5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -38,6 +38,7 @@
 #include <asm/xen/page-coherent.h>
 
 #include <trace/events/swiotlb.h>
+#define MAX_DMA_BITS 32
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
  * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
@@ -114,8 +115,6 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 	return 0;
 }
 
-static int max_dma_bits = 32;
-
 static int
 xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 {
@@ -135,7 +134,7 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 				p + (i << IO_TLB_SHIFT),
 				get_order(slabs << IO_TLB_SHIFT),
 				dma_bits, &dma_handle);
-		} while (rc && dma_bits++ < max_dma_bits);
+		} while (rc && dma_bits++ < MAX_DMA_BITS);
 		if (rc)
 			return rc;
 
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
