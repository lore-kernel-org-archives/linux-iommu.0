Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E204C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:40:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325F9206F1
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 02:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlmH5eOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325F9206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC886874E3;
	Fri, 19 Jun 2020 02:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eSfAeWqfk7Dk; Fri, 19 Jun 2020 02:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38E8E87378;
	Fri, 19 Jun 2020 02:40:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F443C07FF;
	Fri, 19 Jun 2020 02:40:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2212C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 886B6888B0
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3zmG-JmDQ-f for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 02:40:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 90F31888AE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592534435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ATi+E/1Y7wX1OXWf6v2SEFQsF6SBblKqHdhAPCibPk0=;
 b=IlmH5eOwYxDiFplixMZLHtLnM5xjUYb2xky7Wxrn99hs75NTT6riXYwkM7aaesLX65Glps
 6ULNtwvxRmWOIHnf7yJJeab3h0Hebu2jdUSOr+YS9St1Ac9b+u0aZrNmWYPW61UunBKQYw
 kxqWgNdbdUWhCQc9X5Ko0gLNNMdOMfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-qD6JRbmPMnOp4Z4IAuqLjA-1; Thu, 18 Jun 2020 22:40:29 -0400
X-MC-Unique: qD6JRbmPMnOp4Z4IAuqLjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FF32107ACCA;
 Fri, 19 Jun 2020 02:40:27 +0000 (UTC)
Received: from mail (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 213C95D9E5;
 Fri, 19 Jun 2020 02:40:27 +0000 (UTC)
Date: Thu, 18 Jun 2020 22:40:26 -0400
From: Andrea Arcangeli <aarcange@redhat.com>
To: Roman Gushchin <guro@fb.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200619024026.GB21081@redhat.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Yang Shi <shy828301@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

Hello,

On Thu, Jun 18, 2020 at 06:14:49PM -0700, Roman Gushchin wrote:
> I agree. The whole
> 
> 	page = alloc_pages_node(nid, alloc_flags, order);
> 	if (!page)
> 		continue;
> 	if (!order)
> 		break;
> 	if (!PageCompound(page)) {
> 		split_page(page, order);
> 		break;
> 	} else if (!split_huge_page(page)) {
> 		break;
> 	}
> 
> looks very suspicious to me.
> My wild guess is that gfp flags changed somewhere above, so we hit
> the branch which was never hit before.

Right to be suspicious about the above: split_huge_page on a regular
page allocated by a driver was never meant to work.

The PageLocked BUG_ON is just a symptom of a bigger issue, basically
split_huge_page it may survive, but it'll stay compound and in turn it
must be freed as compound.

The respective free method doesn't even contemplate freeing compound
pages, the only way the free method can survive, is by removing
__GFP_COMP forcefully in the allocation that was perhaps set here
(there are that many __GFP_COMP in that directory):

static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
{
	gfp_t gfp_flags;

	gfp_flags = GFP_KERNEL
		| __GFP_COMP	/* compound page lets parts be mapped */

And I'm not sure what the comment means here, compound or non compound
doesn't make a difference when you map it, it's not a THP, the
mappings must be handled manually so nothing should check PG_compound
anyway in the mapping code.

Something like this may improve things, it's an untested quick hack,
but this assumes it's always a bug to setup a compound page for these
DMA allocations and given the API it's probably a correct
assumption.. Compound is slower, unless you need it, you can avoid it
and then split_page will give contiguous memory page granular. Ideally
the code shouldn't call split_page at all and it should free it all at
once by keeping track of the order and by returning the order to the
caller, something the API can't do right now as it returns a plain
array that can only represent individual small pages.

Once this is resolved, you may want to check your config, iommu passthrough
sounds more optimal for a soundcard.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f68a62c3c32b..3dfbc010fa83 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -499,6 +499,10 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 
 	/* IOMMU can map any pages, so himem can also be used here */
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+	if (unlikely(gfp & __GFP_COMP)) {
+		WARN();
+		gfp &= ~__GFP_COMP;
+	}
 
 	while (count) {
 		struct page *page = NULL;
@@ -522,13 +526,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 				continue;
 			if (!order)
 				break;
-			if (!PageCompound(page)) {
-				split_page(page, order);
-				break;
-			} else if (!split_huge_page(page)) {
-				break;
-			}
-			__free_pages(page, order);
+			split_page(page, order);
+			break;
 		}
 		if (!page) {
 			__iommu_dma_free_pages(pages, i);
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 6850d13aa98c..378f5a36ec5f 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -28,7 +28,6 @@ static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
 	gfp_t gfp_flags;
 
 	gfp_flags = GFP_KERNEL
-		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
 	dmab->area = dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
