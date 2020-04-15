Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEEC2BB1D
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D85420771
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="S+BkzuaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D85420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6E9786D13;
	Wed, 15 Apr 2020 00:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gHXYiJ0flzik; Wed, 15 Apr 2020 00:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7EEA486C1A;
	Wed, 15 Apr 2020 00:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB64C089E;
	Wed, 15 Apr 2020 00:05:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E01D8C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DB13886B94
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbncG4Qpy23R for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 55C6E86D13
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:05:04 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id x3so715310pfp.7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=ZqTkeiwENaudq21J8vTW1kd2VtXPsvTLGQP3XXO1NHU=;
 b=S+BkzuaFI/ql7zPm2jJufYxYG9LrRhNZMXcnwMDr7r8jFf1R3XOoh24P7ornVUb67I
 YnoIPO/xfD8edhC3LLxFzpaTtlRpgEOytqa8xPXxxqKqorQUvfz0wf8ZHtB5uGv0ZYVz
 qCBlHrTG4aJSE5yGfJsI37wsCiRMfGfxBRT2z9h5kbsqd+JhBFOC8+oF0kRc1t+emm+L
 msn8bCFxkGC6BDW+UG46VXrTXMQb6xMS6pbTr3Ee0LU4xkK3pHGDVgEBxgmItKzP8slj
 NK6YH0jTf2gwTzf64e5XUml8dQBx8sF1TInfy1UzMxRODBDmXLPg3IXznuV4qTtR0aKU
 wt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=ZqTkeiwENaudq21J8vTW1kd2VtXPsvTLGQP3XXO1NHU=;
 b=XxzGEdRzdjMcwVqBwdUvH2nvvKACL9yriZNRal0TxYXFJFxIcsTY5Pvvhg2aSIv6I9
 xg2EpRebTa+dIRvlvJMREDip6tvbjeLhFTLmb+IX4mMY/RDlojfoT6I9/jNdqZc/3vYN
 FCcEfmazR1+dzTaqJCriVnmvqiQbhgeEGmsvUj/Wvlv2fbuiCAl2fMhzw0an+ZLEStW3
 4bi0aR/4EjhyvaBvt0egppGTh/6+5HODNYaj6VzVJfQ/JysuFc2CAxGEPsx5TfPJY89a
 wnximQ+OwQO/h/BQQ3dFic74AmWmG6FlGLLuFTn6IUwtPk40EzgsjOWAlDlVDWtaXR6X
 +j0g==
X-Gm-Message-State: AGi0PubMdGRQz5qRlX2ca4RbkAfXybmB86iYgLMkCcVliyYoO+zgkPdj
 KmWIhUut9Qjs5XWOaPVpImcNHg==
X-Google-Smtp-Source: APiQypL9+7skSK7zQht9VcXx962nONsEqOmoABTSyGj/fSCQq8rGrYJUyLaBuqdKiaF9VGYSi3ZrQg==
X-Received: by 2002:a63:ff49:: with SMTP id s9mr5626054pgk.46.1586909103760;
 Tue, 14 Apr 2020 17:05:03 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id d203sm6772412pfd.79.2020.04.14.17.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 17:05:03 -0700 (PDT)
Date: Tue, 14 Apr 2020 17:05:02 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 7/7] dma-pool: scale the default DMA coherent pool size with
 memory capacity
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141704330.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: x86@kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
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

Note that even prior to this patch, coherent_pool= for sizes larger than
1 << (PAGE_SHIFT + MAX_ORDER-1) can fail.  With new dynamic expansion
support, this would be trivially extensible to allow even larger initial
sizes.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 3e22022c933b..763b687569b0 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -22,8 +22,8 @@ static unsigned long pool_size_dma32;
 static unsigned long pool_size_kernel;
 #endif
 
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+/* Size can be defined by the coherent_pool command line */
+static size_t atomic_pool_size;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -181,6 +181,16 @@ static int __init dma_atomic_pool_init(void)
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
