Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2774C433DF
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 21:57:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B80D2073E
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 21:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz7Kv1Cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B80D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1A5487483;
	Mon, 22 Jun 2020 21:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rb-_SmwJrwjb; Mon, 22 Jun 2020 21:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F9A68742A;
	Mon, 22 Jun 2020 21:57:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41DC3C0891;
	Mon, 22 Jun 2020 21:57:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C886C016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 21:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 00C16892A3
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 21:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CbqAxgV5A-mQ for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 21:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DCD70892A0
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 21:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592863026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMbPsqGUvOKb001hQipRcEAVs1+07nW6ycVZC/UvqlI=;
 b=fz7Kv1CjoiaPMNbJ+KExNNKkk22EEd2lGZQnOCWW6cOIleTZ4VQqEVgpDyZymzh9DJEi5u
 QhlORtsdICb5sT1hGgAsJAYcaz3nnaG8ezCt5oaCZSOH9uzwmH+Q6orhopzXcoSigpWu+f
 NRYGHtX444jNdDO8g9Jb5aoxSuPMpbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-zgop9R65Nc-KYu6Pt_FCgw-1; Mon, 22 Jun 2020 17:57:02 -0400
X-MC-Unique: zgop9R65Nc-KYu6Pt_FCgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 557691883608;
 Mon, 22 Jun 2020 21:57:00 +0000 (UTC)
Received: from mail (ovpn-112-10.rdu2.redhat.com [10.10.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B76D410013D2;
 Mon, 22 Jun 2020 21:56:59 +0000 (UTC)
Date: Mon, 22 Jun 2020 17:56:58 -0400
From: Andrea Arcangeli <aarcange@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: kernel BUG at mm/huge_memory.c:2613!
Message-ID: <20200622215658.GC12414@redhat.com>
References: <20200619001938.GA135965@carbon.dhcp.thefacebook.com>
 <CAHbLzkrDcn-GQOrAM=m7+2g5_J6obsz4K50Oqb-1RD5p1iWTPQ@mail.gmail.com>
 <20200619011449.GC135965@carbon.dhcp.thefacebook.com>
 <20200619024026.GB21081@redhat.com>
 <20200622124646.GI3701@8bytes.org>
 <e31308f7-4e3c-b6bc-7201-3861b062d257@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e31308f7-4e3c-b6bc-7201-3861b062d257@arm.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
 iommu@lists.linux-foundation.org, Wei Yang <richardw.yang@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <shy828301@gmail.com>,
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

On Mon, Jun 22, 2020 at 04:30:41PM +0100, Robin Murphy wrote:
> On 2020-06-22 13:46, Joerg Roedel wrote:
> > + Robin
> > 
> > Robin, any idea on this?
> 
> After a bit of archaeology, this dates back to the original review:
> 
> https://lore.kernel.org/linux-arm-kernel/54C285D4.3070802@arm.com/
> https://lore.kernel.org/linux-arm-kernel/54DA2666.9030003@arm.com/
> 
> In summary: originally this inherited from other arch code that did 
> simply strip __GFP_COMP; that was deemed questionable because of the 
> nonsensical comment about CONFIG_HUGETLBFS that was stuck to it; the 
> current code is like it is because in 5 and a half years nobody said 
> that it's wrong :)
> 
> If there actually *are* good reasons for stripping __GFP_COMP, then I've 
> certainly no objection to doing so.

The main question is if there's any good reasons for not forbidding
__GFP_COMP to be specified in the callers. The reason given in the
comment isn't convincing.

I don't see how a caller that gets a pointer can care about how the
page structure looks like and in turn why it's asking for __GFP_COMP.

As far as I can tell there are two orthogonal issues in play here:

1) The comment about __GFP_COMP facilitating the sound driver to do
   partial mapping doesn't make much sense. It's probably best to
   WARN_ON immediately in dma_alloc_coherent if __GFP_COMP is
   specified, not only down the call stack in the
   __iommu_dma_alloc_pages() path.

   Note: the CMA paths would already ignore __GFP_COMP if it's
   specified so that __GFP_COMP request can already be ignored. It
   sounds preferable to warn the caller it's asking something it can't
   get, than to silently ignore __GFP_COMP.

   On a side note: hugetlbfs/THP pages can only be allocated with
   __GFP_COMP because for example put_page() must work on all tail
   pages (you can't call compound_head() unless the tail page is part
   of a compound page). But for private driver pages mapped by
   remap_pfn_range, any full or partial mapping is done manually and
   nobody can call GUP on VM_PFNMAP|VM_IO anyway (there's not even the
   requirement of a page struct backing those mappings in fact).

2) __iommu_dma_alloc_pages cannot use __GFP_COMP if it intends to
   return an array of small pages, which is the only thing that the
   current sg_alloc_table_from_pages() supports in input. split_page
   will work as expected to generate small pages from non-compound
   order>0 pages, incidentally it's implement on mm/page_alloc.c, not
   in huge_memory.c.

   split_huge_page as opposed is not intended to be used on newly
   allocated compound page. Maybe we should renamed it to
   split_trans_huge_page to make it more explicit, since it won't even
   work on hugetlbfs (compound) pages.

Thanks,
Andrea

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
