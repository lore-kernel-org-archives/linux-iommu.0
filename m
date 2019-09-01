Return-Path: <SRS0=2m50=W4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8555CC3A5A4
	for <iommu@archiver.kernel.org>; Sun,  1 Sep 2019 19:23:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFD22190F
	for <iommu@archiver.kernel.org>; Sun,  1 Sep 2019 19:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjHWNZc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFD22190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 210C2CAB;
	Sun,  1 Sep 2019 19:23:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA096CA8
	for <iommu@lists.linux-foundation.org>;
	Sun,  1 Sep 2019 19:23:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 82D99709
	for <iommu@lists.linux-foundation.org>;
	Sun,  1 Sep 2019 19:23:48 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id az1so4632926plb.6
	for <iommu@lists.linux-foundation.org>;
	Sun, 01 Sep 2019 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=MYmyqV51fBjQuhWN4wRJPBtp4cf5jebojptEpCVLVOk=;
	b=TjHWNZc0ZSAdLlICAmRNnY+1VKMb8ksQKlv2+3dqXX/Od6eAOEyRzvUwKpJvFshVrH
	HrrR7AzO7vyxkqqq8e3qYBKsKhC710WpwJN5/HLGqabKuwsVKvT8Sxq69tP2BrP4baWQ
	TA1MQp/Z3dMDgmRYKP/hQw4iGFquZ8eBXYA2xQazOg9QcT0Mqd4MnqWbbiBmuBpqBjle
	PLMS6HCjOTxicYWnq0Tbkd59InVsarbuDZZylarrhkkwwRu1H69HlAunEjCuH+pw53pV
	iqK/4yVXBpneAsahpXA1yg5WXLEApVp2prY059J8ZTkETMIFe9z2++wpWf0qXGy8sUHH
	AT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=MYmyqV51fBjQuhWN4wRJPBtp4cf5jebojptEpCVLVOk=;
	b=M2K92hupOs2/kVDr7UJCTG36qFd8Ec6gw0yC+7fpEc+wZpC/+eZN0MfpjF+dOzZuP9
	+ScLk/goMsoL4ys+wYmAPYOlH9jWqFwH9rCIQFpir03G1r4QDtrNXfaEZ+0Gs0II6vYc
	OZ08y/0rFaWRWXeCznsUHibNKqur6c8QhvM4p0M0JidsFzjdk+kwzpiV/JR+I5c1Udtu
	NvLfRZrUSPZgQ8gre7EnUKreib03febuXhewGU3BJWd0Holvy/mt4RQXeQJglwpsPijU
	DMJxq3tcXfRk6e2ZU7u67q0qwSJyPcn8VGUwOin2+JGQ8PcbS8UjtgjM9J20618IxW0J
	hs8Q==
X-Gm-Message-State: APjAAAW2mLE/OyycShp8jbVfYZu2muaPKUwHWWgM7kgHEFLKhaIjA7bH
	3ZowSuIMprlK4IrCeH8Wevg=
X-Google-Smtp-Source: APXvYqxVwAyX5i9CZCLq1N9HsR4W+F1HPa3PbBb79wf4iu91tGmUo6frN78M/h5qjGemTUYvUXOSQQ==
X-Received: by 2002:a17:902:744a:: with SMTP id
	e10mr20291723plt.239.1567365828132; 
	Sun, 01 Sep 2019 12:23:48 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.20.96])
	by smtp.gmail.com with ESMTPSA id
	s7sm21910679pfb.138.2019.09.01.12.23.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 01 Sep 2019 12:23:46 -0700 (PDT)
From: Souptick Joarder <jrdr.linux@gmail.com>
To: konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
	sstabellini@kernel.org
Subject: [PATCH] swiotlb-zen: Convert to use macro
Date: Mon,  2 Sep 2019 00:58:56 +0530
Message-Id: <1567366136-874-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>
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
