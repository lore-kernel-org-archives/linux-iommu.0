Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C1C433E3
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3A220792
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XQjGhruF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3A220792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F382489670;
	Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHhraix72nYw; Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75B56895B8;
	Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62917C0865;
	Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24353C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1269B878BE
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sWCgVueLPScC for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 19:20:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 69828881BC
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:32 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id b201so3112055pfb.0
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=9bbiOsDMVztchdkicPMjy84vDC6pYDsE3gWzL9+ymoc=;
 b=XQjGhruFzMHHQgB4Zy4X5dQbcKz9vjEXrit5SAvrCK5QPKjZ+l7tvfR0ba69ZgL9gm
 khfTkDKN8XAcKs1zfblop0/zLzMvz3pjzXbUrKQ/Qf+Qxy2nBR4KfsQctcPX4udAbTSl
 vcpR5dUEZuKk8N+ph6X73T9PyDMMabM6s1iYI86eKrsRsNyBgvmhf6uMxObDipndNKdn
 5w7E9XWjkPxPkLsr9C82PeAxJXWtZ3GIePeerssU3YedpZMYKLcAyOJCBqEt74cKiucW
 XTf3ch1vyHKbxRoEIYQ6OflS0ecdgSEoBAUej0v28MsNiVlcykmMkHX7Ok2pNzyiQqeT
 W5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=9bbiOsDMVztchdkicPMjy84vDC6pYDsE3gWzL9+ymoc=;
 b=HMqeTQUM00UzNoYNFEovUoN/4ugvqStEscpcfJ4vL/ulhsX7UocZr+Aj2NjKvJI9h7
 uz9M/42Hfu7WibSqu9xYA73QshYVSUkmNTLcxO/i1Sar0i2eRpNTC4QH5GYO/U5NMIdD
 EPt/NyuM6Sf/beTE9TICCbH547enTqWJEu6gIcgOOSHWMD7V8MOcMER2j+PDUsl4QdoW
 i1JEnUyLWd4AH2cpbUTAugzeg/Y9zDY+0gM1bqxnav80iWjaOJu31YFTfTN2N+bBxv+z
 e9GozdOYNIWB+WYJqxrDvr4/dn3iCcAPdAAhexhpIoNwNye5MBzJMCw3WQzui+xJ/Kqr
 wf8w==
X-Gm-Message-State: AOAM532SNqwrYDjI6LbjXuoCJBr6Ojrl8r6bD5sU0c3rXTcjRM/E5ppV
 PruaqO+nBCTGGukijAWLM2cHtrERkf8=
X-Google-Smtp-Source: ABdhPJxG2P9nH5r1G62i8Rxg0NJO4j6KzhMS4gR9YqZWKYkkG/6xq6nFS6lpMXkiRAG6l5IgQPXfTg==
X-Received: by 2002:a05:6a00:1486:: with SMTP id
 v6mr8211804pfu.83.1591903231866; 
 Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id k126sm4135905pfd.129.2020.06.11.12.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 12:20:31 -0700 (PDT)
Date: Thu, 11 Jun 2020 12:20:30 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: [patch for-5.8 3/4] dma-direct: check return value when encrypting
 or decrypting memory
In-Reply-To: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2006111219410.153880@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Thomas Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

__change_page_attr() can fail which will cause set_memory_encrypted() and
set_memory_decrypted() to return non-zero.

If the device requires unencrypted DMA memory and decryption fails, simply
free the memory and fail.

If attempting to re-encrypt in the failure path and that encryption fails,
there is no alternative other than to leak the memory.

Fixes: c10f07aa27da ("dma/direct: Handle force decryption for DMA coherent
buffers in common code")
Cc: stable@vger.kernel.org # 4.17+
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -158,6 +158,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 {
 	struct page *page;
 	void *ret;
+	int err;
 
 	size = PAGE_ALIGN(size);
 
@@ -210,8 +211,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
-	if (force_dma_unencrypted(dev))
-		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
+	if (force_dma_unencrypted(dev)) {
+		err = set_memory_decrypted((unsigned long)ret,
+					   1 << get_order(size));
+		if (err)
+			goto out_free_pages;
+	}
 
 	memset(ret, 0, size);
 
@@ -229,9 +234,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
 out_encrypt_pages:
-	if (force_dma_unencrypted(dev))
-		set_memory_encrypted((unsigned long)page_address(page),
-				     1 << get_order(size));
+	if (force_dma_unencrypted(dev)) {
+		err = set_memory_encrypted((unsigned long)page_address(page),
+					   1 << get_order(size));
+		/* If memory cannot be re-encrypted, it must be leaked */
+		if (err)
+			return NULL;
+	}
 out_free_pages:
 	dma_free_contiguous(dev, page, size);
 	return NULL;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
