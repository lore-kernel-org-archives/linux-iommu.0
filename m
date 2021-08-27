Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A3C25AEB
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:21:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632E060FD9
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 632E060FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4681583B20;
	Fri, 27 Aug 2021 17:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUaeU6KLZGS5; Fri, 27 Aug 2021 17:21:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C99E83AEF;
	Fri, 27 Aug 2021 17:21:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E00AEC001A;
	Fri, 27 Aug 2021 17:21:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0619C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D02DA4278D
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4WU5-iBY9fV for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 17:21:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29EC242784
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:21:42 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id e1so4334078plt.11
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4dx9A/B3m5ysOD2+VzBoH5w81i27I/BMJvu/dVa7Ytg=;
 b=d6svu92zxjPI6sOGybaew8LGEzZQzVDWU73Js82UMmjRVPkircRHjJuTwevbiccRtw
 ZOHi8nITISKt1ONd0/XM2BKSMvAJmurxS00i1gBOaGuR027+Kyk7ZjDXFSFBUcP4bTCZ
 +mxTQlEetvL8su0/2uTAqa3IHgMTEZ7T+82SBtlXhSmpM7sNg5mVuophr86XcTcFPq2/
 w+EZ2tpFCYMRtm821G13jWV8IhGq8uTX0NcoMVXtQ+wE1Ha9RrqJUhReEosqrotUQCoQ
 IGgYsbYCnWTzEe07DlxvZ+deZdgduAL0Zs/sUPNCxPdbBV8fooS21ucdofpUlseeIhpm
 zgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4dx9A/B3m5ysOD2+VzBoH5w81i27I/BMJvu/dVa7Ytg=;
 b=CrL5HW6aHyfTt3067VJtnE4deDcui4oILOtowyNjHIF3uKXMaU8AWkNMZSuIQufTm4
 KtXs2+jwvvRrC6OxhZoFZmHOBHn4m7bpMuzAWkzKr6nHVw6vKqamr7jmSjHBm0WxKjNl
 6pNNXjBrdDkc/3VPnwEbnB5mRNXNM0s5FH+BYRbKvW0ApjYoZTG2oxLlegUQDeBm4ZFd
 1yNKMzZGsukPDv3JONFCKcTk4JQ6CuES4fU7pFfE02PuUX0srvLmQE0uC/6szx/+0Mzt
 euZwuFZ/5onyYxZuGcxRALbew5/jd0uurjfru4EbvOd8nTESlbREDe4oQMolLQP+dW3I
 9XKQ==
X-Gm-Message-State: AOAM532qDCz3QgHePk5gK9+Xak2g/UBwN/CnPqg3wyud/HVBzVomWF0R
 aH+3Fv4Zh6crkHaHOgEFLgE=
X-Google-Smtp-Source: ABdhPJwIY8QSecpkOYquBiJzV0Q22b9scRKmqtTl7kB/KD182fzIRPnUqvHG1miAckAMpUlV+5Pz6g==
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr9529029plo.37.1630084901556; 
 Fri, 27 Aug 2021 10:21:41 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:36:ef50:8fcd:44d1:eb17])
 by smtp.gmail.com with ESMTPSA id f5sm7155015pjo.23.2021.08.27.10.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Aug 2021 10:21:41 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org,
 joro@8bytes.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 brijesh.singh@amd.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 pgonda@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org,
 rientjes@google.com, ardb@kernel.org, michael.h.kelley@microsoft.com
Subject: [PATCH V4 08/13] hyperv/vmbus: Initialize VMbus ring buffer for
 Isolation VM
Date: Fri, 27 Aug 2021 13:21:06 -0400
Message-Id: <20210827172114.414281-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827172114.414281-1-ltykernel@gmail.com>
References: <20210827172114.414281-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

VMbus ring buffer are shared with host and it's need to
be accessed via extra address space of Isolation VM with
AMD SNP support. This patch is to map the ring buffer
address in extra address space via vmap_pfn(). Hyperv set
memory host visibility hvcall smears data in the ring buffer
and so reset the ring buffer memory to zero after mapping.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	* Remove hv_ringbuffer_post_init(), merge map
	operation for Isolation VM into hv_ringbuffer_init()
	* Call hv_ringbuffer_init() after __vmbus_establish_gpadl().
---
 drivers/hv/Kconfig       |  1 +
 drivers/hv/channel.c     | 19 +++++++-------
 drivers/hv/ring_buffer.c | 56 ++++++++++++++++++++++++++++++----------
 3 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index d1123ceb38f3..dd12af20e467 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -8,6 +8,7 @@ config HYPERV
 		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
+	select VMAP_PFN
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 82650beb3af0..81f8629e4491 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -679,15 +679,6 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (!newchannel->max_pkt_size)
 		newchannel->max_pkt_size = VMBUS_DEFAULT_MAX_PKT_SIZE;
 
-	err = hv_ringbuffer_init(&newchannel->outbound, page, send_pages, 0);
-	if (err)
-		goto error_clean_ring;
-
-	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
-				 recv_pages, newchannel->max_pkt_size);
-	if (err)
-		goto error_clean_ring;
-
 	/* Establish the gpadl for the ring buffer */
 	newchannel->ringbuffer_gpadlhandle = 0;
 
@@ -699,6 +690,16 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	if (err)
 		goto error_clean_ring;
 
+	err = hv_ringbuffer_init(&newchannel->outbound,
+				 page, send_pages, 0);
+	if (err)
+		goto error_free_gpadl;
+
+	err = hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
+				 recv_pages, newchannel->max_pkt_size);
+	if (err)
+		goto error_free_gpadl;
+
 	/* Create and init the channel open message */
 	open_info = kzalloc(sizeof(*open_info) +
 			   sizeof(struct vmbus_channel_open_channel),
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 2aee356840a2..24d64d18eb65 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -17,6 +17,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
+#include <linux/io.h>
+#include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
 
@@ -183,8 +185,10 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *channel)
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
 {
-	int i;
 	struct page **pages_wraparound;
+	unsigned long *pfns_wraparound;
+	u64 pfn;
+	int i;
 
 	BUILD_BUG_ON((sizeof(struct hv_ring_buffer) != PAGE_SIZE));
 
@@ -192,23 +196,49 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 	 * First page holds struct hv_ring_buffer, do wraparound mapping for
 	 * the rest.
 	 */
-	pages_wraparound = kcalloc(page_cnt * 2 - 1, sizeof(struct page *),
-				   GFP_KERNEL);
-	if (!pages_wraparound)
-		return -ENOMEM;
+	if (hv_isolation_type_snp()) {
+		pfn = page_to_pfn(pages) +
+			HVPFN_DOWN(ms_hyperv.shared_gpa_boundary);
 
-	pages_wraparound[0] = pages;
-	for (i = 0; i < 2 * (page_cnt - 1); i++)
-		pages_wraparound[i + 1] = &pages[i % (page_cnt - 1) + 1];
+		pfns_wraparound = kcalloc(page_cnt * 2 - 1,
+			sizeof(unsigned long), GFP_KERNEL);
+		if (!pfns_wraparound)
+			return -ENOMEM;
 
-	ring_info->ring_buffer = (struct hv_ring_buffer *)
-		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP, PAGE_KERNEL);
+		pfns_wraparound[0] = pfn;
+		for (i = 0; i < 2 * (page_cnt - 1); i++)
+			pfns_wraparound[i + 1] = pfn + i % (page_cnt - 1) + 1;
 
-	kfree(pages_wraparound);
+		ring_info->ring_buffer = (struct hv_ring_buffer *)
+			vmap_pfn(pfns_wraparound, page_cnt * 2 - 1,
+				 PAGE_KERNEL);
+		kfree(pfns_wraparound);
 
+		if (!ring_info->ring_buffer)
+			return -ENOMEM;
+
+		/* Zero ring buffer after setting memory host visibility. */
+		memset(ring_info->ring_buffer, 0x00,
+			HV_HYP_PAGE_SIZE * page_cnt);
+	} else {
+		pages_wraparound = kcalloc(page_cnt * 2 - 1,
+					   sizeof(struct page *),
+					   GFP_KERNEL);
+
+		pages_wraparound[0] = pages;
+		for (i = 0; i < 2 * (page_cnt - 1); i++)
+			pages_wraparound[i + 1] =
+				&pages[i % (page_cnt - 1) + 1];
+
+		ring_info->ring_buffer = (struct hv_ring_buffer *)
+			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
+				PAGE_KERNEL);
+
+		kfree(pages_wraparound);
+		if (!ring_info->ring_buffer)
+			return -ENOMEM;
+	}
 
-	if (!ring_info->ring_buffer)
-		return -ENOMEM;
 
 	ring_info->ring_buffer->read_index =
 		ring_info->ring_buffer->write_index = 0;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
