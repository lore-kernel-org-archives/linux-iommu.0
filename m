Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF21AC433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 19:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DC888294A;
	Wed,  1 Dec 2021 19:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4yEIfE8CHIIT; Wed,  1 Dec 2021 19:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E77C8829AF;
	Wed,  1 Dec 2021 19:07:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB3D4C0012;
	Wed,  1 Dec 2021 19:07:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B52BC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 19:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B13A60766
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 19:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fi8jo2Bqm_3q for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 19:07:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 314136063E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GjHBl1+/CwPHKTVR/f8ORsKmJRUSdIW+S2uB+MujBiI=; b=wZESZkica5ceEZQ6YDd2YCeaJ6
 +cw182OK6Ct7BeOeJ0COz5RCw4qLOpeMKU/V8lTZL+maVaJWEyRde8LuRji4y58dSl1RW4X+svdyq
 hH8mjmArSAuGPs3XX0uGcmmxHKFYxOU1MBdqVAN3KuTvq31tu6XG9Pox+fzRzVl/VW1Rgx4bj++rs
 wXZ8cnkaOPrHuiNBfH9fsu4NVZAM62/icFFLAzhTKzr4ZWKTw1My0PGfpXJj5cprO/lYQHOoy/6Gx
 l2Bd7Ekav8n/vvdnR0i8EiCvpcvbOa+8zNe1/mOtS85NxRMJjUzXX6QSh57Kh8zDhyj5Wx2QZ7Rgm
 GLXRP1lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1msUwb-000aw3-T2; Wed, 01 Dec 2021 19:07:06 +0000
Date: Wed, 1 Dec 2021 19:07:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 29/33] iommu: Use put_pages_list
Message-ID: <YafH2YT+uxn/y4sV@casper.infradead.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <20211201181510.18784-30-vbabka@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211201181510.18784-30-vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, patches@lists.linux.dev,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, David Rientjes <rientjes@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
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

On Wed, Dec 01, 2021 at 07:15:06PM +0100, Vlastimil Babka wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> page->freelist is for the use of slab.  We already have the ability
> to free a list of pages in the core mm, but it requires the use of a
> list_head and for the pages to be chained together through page->lru.
> Switch the iommu code over to using put_pages_list().

FYI, this is going to have conflicts with
https://lore.kernel.org/lkml/cover.1637671820.git.robin.murphy@arm.com/

I'm not sure what the appropriate resolution is going to be here;
maybe hold back part of this patch series to the following merge
window to give the iommu people time to merge their own patches?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
