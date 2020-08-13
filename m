Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82EC433DF
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 08:02:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6ED20781
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="j/2W25yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6ED20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DAAF486A9E;
	Thu, 13 Aug 2020 08:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GIDwJM2i5z3; Thu, 13 Aug 2020 08:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5EEBB86A79;
	Thu, 13 Aug 2020 08:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D86C013C;
	Thu, 13 Aug 2020 08:02:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42260C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 03:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2AD2386079
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 03:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nIMyF9FALB1V for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 03:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com
 [209.85.219.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 008A585D50
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 03:22:17 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id x10so2502375ybj.13
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:user-agent:mime-version;
 bh=d5gM963jXgjoG9xSkVthzNFdGJ4ytytBPjGpdNfGwQE=;
 b=j/2W25yrTTTJa0lxgxJG+ghzhZ7OSp8SEds1Qz1gC1lDAfGWdRKzSnU9ZDd0tlVpg1
 dwF3sBJmqO0/UhaKTXEsXbsKrcXcGZDjqBaWEMWp40j4ryEIGBzDxyOO8nlQZNq+zLK7
 TKx2rkqUEMRF6hQsjmnfxlXDK/iMFAhbsexlq2lYgjCMvl3giIXtf3mIwnQb0x4eHS1b
 U2sHqoTUa3RzXlOzKz9HkcxjDEEL22k+w++oTqxtGWddSuDC5h+6Y/8DO64Owyi4htmJ
 ZMeR+G/d4jk+nXOcz3by/QX77MMpF6NvnZptI6Mi1kVQdLZNZl3N0yFzcZXAQ2+HK8By
 YRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
 :mime-version;
 bh=d5gM963jXgjoG9xSkVthzNFdGJ4ytytBPjGpdNfGwQE=;
 b=pzsmiK5uGFSTs1okO3SXTCpm5Irr+BzqRrDR8nItwfvmATatPb7JtEkeqmUNKm9gLt
 nwO3oIW7yX4OKD26nXIGehvUXBYia4nlGjLB6/SBmwBcBZlGkYBJiW+JyjJfvnD9dmFY
 pYf/0I/o3ReOoHD6cAieUurf825EBj6n0L7Ve4Gw66ezylKanCN8YcPa8bUQB0fhU/iD
 Hep738wDPzqMbRPMwOir1asaRONEQ/bzk7o1w73w7wtf9fbEo0G6o0cbhkr9dys0F5q9
 lMRAeeFUMZLam9n74d2Lz1RpCFcH0V2XTYiM9UnJSj2G8+y1o5wnKqSl5fTQj2RhHreQ
 9zug==
X-Gm-Message-State: AOAM5310KBFK+n+cQ6dW31Y2PStYuUR2vts0bMzLzQdC1UtxUWMmhwE1
 FgpJ1hSaz2dqCvmYjkPBatPlSiWyJck=
X-Google-Smtp-Source: ABdhPJz3Ahiq/PDZ7De+xF095uaVH1Vh3EB/+6umE8wxr7Ev1HWhGWS6bGlZEUajwVigJFocX+Qi2A==
X-Received: by 2002:a4a:ac0e:: with SMTP id p14mr2860150oon.26.1597288635333; 
 Wed, 12 Aug 2020 20:17:15 -0700 (PDT)
Received: from eggly.attlocal.net
 (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
 by smtp.gmail.com with ESMTPSA id p9sm861601oti.22.2020.08.12.20.17.13
 (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
 Wed, 12 Aug 2020 20:17:14 -0700 (PDT)
Date: Wed, 12 Aug 2020 20:17:00 -0700 (PDT)
X-X-Sender: hugh@eggly.anvils
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] dma-debug: fix debug_dma_assert_idle(), use
 rcu_read_lock()
Message-ID: <alpine.LSU.2.11.2008122005240.11996@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 13 Aug 2020 08:02:19 +0000
Cc: Hugh Dickins <hughd@google.com>, Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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
From: Hugh Dickins via iommu <iommu@lists.linux-foundation.org>
Reply-To: Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Since commit 2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")
improved unlock_page(), it has become more noticeable how cow_user_page()
in a kernel with CONFIG_DMA_API_DEBUG=y can create and suffer from heavy
contention on DMA debug's radix_lock in debug_dma_assert_idle().

It is only doing a lookup: use rcu_read_lock() and rcu_read_unlock()
instead; though that does require the static ents[] to be moved onstack...

...but, hold on, isn't that radix_tree_gang_lookup() and loop doing quite
the wrong thing: searching CACHELINES_PER_PAGE entries for an exact match
with the first cacheline of the page in question?  radix_tree_gang_lookup()
is the right tool for the job, but we need nothing more than to check the
first entry it can find, reporting if that falls anywhere within the page.

(Is RCU safe here?  As safe as using the spinlock was.  The entries are
never freed, so don't need to be freed by RCU.  They may be reused, and
there is a faint chance of a race, with an offending entry reused while
printing its error info; but the spinlock did not prevent that either,
and I agree that it's not worth worrying about.)

Fixes: 3b7a6418c749 ("dma debug: account for cachelines and read-only mappings in overlap tracking")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 kernel/dma/debug.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

--- v5.9-rc/kernel/dma/debug.c	2020-08-05 18:17:57.544203766 -0700
+++ linux/kernel/dma/debug.c	2020-08-12 19:53:33.159070245 -0700
@@ -565,11 +565,8 @@ static void active_cacheline_remove(stru
  */
 void debug_dma_assert_idle(struct page *page)
 {
-	static struct dma_debug_entry *ents[CACHELINES_PER_PAGE];
-	struct dma_debug_entry *entry = NULL;
-	void **results = (void **) &ents;
-	unsigned int nents, i;
-	unsigned long flags;
+	struct dma_debug_entry *entry;
+	unsigned long pfn;
 	phys_addr_t cln;
 
 	if (dma_debug_disabled())
@@ -578,20 +575,14 @@ void debug_dma_assert_idle(struct page *
 	if (!page)
 		return;
 
-	cln = (phys_addr_t) page_to_pfn(page) << CACHELINE_PER_PAGE_SHIFT;
-	spin_lock_irqsave(&radix_lock, flags);
-	nents = radix_tree_gang_lookup(&dma_active_cacheline, results, cln,
-				       CACHELINES_PER_PAGE);
-	for (i = 0; i < nents; i++) {
-		phys_addr_t ent_cln = to_cacheline_number(ents[i]);
+	pfn = page_to_pfn(page);
+	cln = (phys_addr_t) pfn << CACHELINE_PER_PAGE_SHIFT;
 
-		if (ent_cln == cln) {
-			entry = ents[i];
-			break;
-		} else if (ent_cln >= cln + CACHELINES_PER_PAGE)
-			break;
-	}
-	spin_unlock_irqrestore(&radix_lock, flags);
+	rcu_read_lock();
+	if (!radix_tree_gang_lookup(&dma_active_cacheline, (void **) &entry,
+				    cln, 1) || entry->pfn != pfn)
+		entry = NULL;
+	rcu_read_unlock();
 
 	if (!entry)
 		return;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
