Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1453C2BA2B
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7375520771
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dffHTmwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7375520771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E9A62426B;
	Wed,  8 Apr 2020 21:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HDJ7VLpfGKC2; Wed,  8 Apr 2020 21:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EEE94221C6;
	Wed,  8 Apr 2020 21:21:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE2A3C1AE8;
	Wed,  8 Apr 2020 21:21:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2F8EC1AE8
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 931AE880C6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tGsGS2mXLja4 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E7143880D2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id u65so3033826pfb.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=V7GX9LZ+AhHUH4bwOJQnuEHVk4dK2rfBwPONnldpnt4=;
 b=dffHTmwO0tVlcdXkvNhhaUt0+yiOfFJR8UKtqG72G0vg0UBgDxhDLrmfswe6Iu9nro
 OfM3598qThzw8CALPlmFLzz+mSr/EBMPtRh/q1725AB+6isUxT1WCFp6PJLsWke3q+Kp
 tDM9ZsJ8mbLZxaWQYBx+cW4UcLHE4z83i53ZfZoSiJaxfA3sJF0R/Ld+ARI2r6t8zldi
 ishSudG5ynA3yXMXRidbNmBLcfEd9PtkLwcxLPHAy+6RWBgIPU66jJQ/ocN6oHM1J4Um
 RWd5EQGsLGa7csSIaQWNG1pqksJpqR8oRNonJEmljmQDqD6U1f4z3WyweSQs2WPUueI+
 Ljyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=V7GX9LZ+AhHUH4bwOJQnuEHVk4dK2rfBwPONnldpnt4=;
 b=QzTDlvMKl7BA5L+qnmRvcN7fXmMze+kbPL9uERfTjoeoXiNcz94BFOwQHS6RrJ94Ga
 DPe3LZ/IX8X9GMrjLEzL3y2IUI8jzRFbXTE3yVGoMYQodLc/skHwE+rFnUVSRm3irUzd
 7BhhF5B9c5Kj7xMrUW0KpqVbEvF5jt27be4BdaRd5VGO0v8hDGtptvKm9nUy7IucFR4K
 eTiO573wyKCUvY6jD3IC/8hVz3N9QR818Zz71mvC0UJbUbOUhn2RmPxo+7bkPAMcglKQ
 XpPITZF7IOHSjnSFseT3zbowRZmrUzQgJoxaYrw86bSuvMe84Xkcd19DsSYAsWWwVsXw
 2GPw==
X-Gm-Message-State: AGi0PuYoJwlCdj5eJ3oPimPmq+Q944c7+tKhS0pSv0k472g2HdM3L32H
 QBXo/KrMdlmpRjYhpkV6G4DJMA==
X-Google-Smtp-Source: APiQypJCa8TsaplVYhS9P0JzzjDY+IiLIaAE7LUfGVUKFymlGGpsyHJbOAOUCHLqZ/940cF64leUPQ==
X-Received: by 2002:a62:1cf:: with SMTP id 198mr9933881pfb.246.1586380873275; 
 Wed, 08 Apr 2020 14:21:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id q19sm2013938pgt.29.2020.04.08.14.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 14:21:12 -0700 (PDT)
Date: Wed, 8 Apr 2020 14:21:12 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc v2 6/6] dma-pool: scale the default DMA coherent pool size with
 memory capacity
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081420360.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Grimm, Jon" <jon.grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When AMD memory encryption is enabled, some devices may use more than
256KB/sec from the atomic pools.  It would be more appropriate to scale
the default size based on memory capacity unless the coherent_pool
option is used on the kernel command line.

This provides a slight optimization on initial expansion and is deemed
appropriate due to the increased reliance on the atomic pools.  Note that
the default size of 128KB per pool will normally be larger than the
single coherent pool implementation since there are now up to three
coherent pools (DMA, DMA32, and kernel).

Alternatively, this could be done only when CONFIG_AMD_MEM_ENCRYPT is
enabled.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 6685ab89cfa7..42bac953548c 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -18,8 +18,8 @@ static struct gen_pool *atomic_pool_dma __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
 
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+/* Size can be defined by the coherent_pool command line */
+static size_t atomic_pool_size;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -132,6 +132,16 @@ static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
 
+	/*
+	 * If coherent_pool was not used on the command line, default the pool
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
+	 */
+	if (!atomic_pool_size) {
+		atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
+					SZ_128K;
+		atomic_pool_size = min_t(size_t, atomic_pool_size,
+					 1 << (PAGE_SHIFT + MAX_ORDER-1));
+	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
 	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
