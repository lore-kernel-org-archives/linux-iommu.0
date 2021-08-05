Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AABC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 06:54:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7221D6105A
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 06:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7221D6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34E5E605FB;
	Thu,  5 Aug 2021 06:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MxXabWNkvHrr; Thu,  5 Aug 2021 06:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AA0B60597;
	Thu,  5 Aug 2021 06:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9768C001A;
	Thu,  5 Aug 2021 06:54:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42271C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 06:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38B82403A0
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 06:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ETey0Ta228Zf for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 06:54:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E35A401EE
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 06:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628146458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j85DEN/GjXBt17nWPtFfA65KJvlMB121aW2wNcv0HLM=;
 b=bmvu6KQ2W+jWG7BMsCJtCFfmDVJ+A2XIWnL9H9Tn5lzS5mn842S6Iufn1g0hkHbQYsEjW2
 U5/L+1bxdYTOsx88pvBj4cJUP3sLBzv1e4R3uEi6737K58JKUaa2RkzzuJ95wy/u3fnb/X
 nrlaN83VZ4If9dM/c+KZVDmy83fiVP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-agHRmAA1PeKyjzdK13dT9A-1; Thu, 05 Aug 2021 02:54:16 -0400
X-MC-Unique: agHRmAA1PeKyjzdK13dT9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FB8100CF79;
 Thu,  5 Aug 2021 06:54:14 +0000 (UTC)
Received: from localhost (ovpn-12-115.pek2.redhat.com [10.72.12.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D23A751C63;
 Thu,  5 Aug 2021 06:54:13 +0000 (UTC)
Date: Thu, 5 Aug 2021 14:54:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210805065410.GA2051@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, rientjes@google.com
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

On 06/24/21 at 11:47am, Robin Murphy wrote:
> On 2021-06-24 10:29, Baoquan He wrote:
> > On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> > > So reduce the amount allocated.  But the pool is needed for proper
> > > operation on systems with memory encryption.  And please add the right
> > > maintainer or at least mailing list for the code you're touching next
> > > time.
> > 
> > Oh, I thoutht it's memory issue only, should have run
> > ./scripts/get_maintainer.pl. sorry.
> > 
> > About reducing the amount allocated, it may not help. Because on x86_64,
> > kdump kernel doesn't put any page of memory into buddy allocator of DMA
> > zone. Means it will defenitely OOM for atomic_pool_dma initialization.
> > 
> > Wondering in which case or on which device the atomic pool is needed on
> > AMD system with mem encrytion enabled. As we can see, the OOM will
> > happen too in kdump kernel on Intel system, even though it's not
> > necessary.

Sorry for very late response, and thank both for your comments.

> 
> Hmm, I think the Kconfig reshuffle has actually left a slight wrinkle here.
> For DMA_DIRECT_REMAP=y we can assume an atomic pool is always needed, since
> that was the original behaviour anyway. However the implications of
> AMD_MEM_ENCRYPT=y are different - even if support is enabled, it still
> should only be relevant if mem_encrypt_active(), so it probably does make
> sense to have an additional runtime gate on that.

> 
> From a quick scan, use of dma_alloc_from_pool() already depends on
> force_dma_unencrypted() so that's probably fine already, but I think we'd
> need a bit of extra protection around dma_free_from_pool() to prevent
> gen_pool_has_addr() dereferencing NULL if the pools are uninitialised, even
> with your proposed patch as it is. Presumably nothing actually called
> dma_direct_free() when you tested this?

Yes, enforcing the conditional check of force_dma_unencrypted() around
dma_free_from_pool sounds reasonable, just as we have done in
dma_alloc_from_pool().

I have tested this patchset on normal x86_64 systems and one amd system
with SME support, disabling atomic pool can fix the issue that there's no
managed pages in dma zone then requesting page from dma zone will cause
allocation failure. And even disabling atomic pool in 1st kernel didn't
cause any problem on one AMD EPYC system which supports SME. I am not
expert of DMA area, wondering how atomic pool is supposed to do in
SME/SEV system. 

Besides, even though atomic pool is disabled, slub page for allocation
of dma-kmalloc also triggers page allocation failure. So I change to
take another way to fix them, please check v2 post. The atomic pool
disabling an be a good to have change.

Thanks
Baoquan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
