Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3DC433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 15:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE3E64EFC
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 15:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE3E64EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4D9B83ED4;
	Wed, 17 Mar 2021 15:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5TZ-iQZ1uo8; Wed, 17 Mar 2021 15:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C775830A7;
	Wed, 17 Mar 2021 15:18:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D893C000A;
	Wed, 17 Mar 2021 15:18:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E8CAC0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 15:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C29D4EDB9
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 15:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e_RcHg-YDFwj for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 15:18:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 408244EDB4
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615994307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WweFpqYPPp1PxeahFEtVPdauE7cc3RkHtQdhRhNh4Lw=;
 b=eBiz8yccujkSF80u6VkIwt+T3dNIdCaPbIcqgLqlX4fAcoGzdmCJgiSY4QAnEbd4WRUQ92
 DP5ocx34OppasaNqCunKN1TxUXrOmRVbCrgAHhFrfuGhfXIgvwAXQvno6CsR/b+khQc5QD
 Yu1Cu1KnbTQR66NVaEMe3EFuTVDmeHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Ay-bCL7yMjeinaiYmuah3w-1; Wed, 17 Mar 2021 11:18:23 -0400
X-MC-Unique: Ay-bCL7yMjeinaiYmuah3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0AC1CC624;
 Wed, 17 Mar 2021 15:18:21 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FC7E6E419;
 Wed, 17 Mar 2021 15:18:21 +0000 (UTC)
Date: Wed, 17 Mar 2021 09:18:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: A problem of Intel IOMMU hardware =?UTF-8?B?77yf?=
Message-ID: <20210317091820.5f4ab69e@omen.home.shazbot.org>
In-Reply-To: <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: chenjiashang@huawei.com, dwmw2@infradead.org,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, "Longpeng \(Mike,
 Cloud Infrastructure Service Product Dept.\)" <longpeng2@huawei.com>,
 will@kernel.org
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

On Wed, 17 Mar 2021 13:16:58 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Longpeng,
> 
> On 3/17/21 11:16 AM, Longpeng (Mike, Cloud Infrastructure Service 
> Product Dept.) wrote:
> > Hi guys,
> > 
> > We find the Intel iommu cache (i.e. iotlb) maybe works wrong in a special
> > situation, it would cause DMA fails or get wrong data.
> > 
> > The reproducer (based on Alex's vfio testsuite[1]) is in attachment, it can
> > reproduce the problem with high probability (~50%).
> > 
> > The machine we used is:
> > processor	: 47
> > vendor_id	: GenuineIntel
> > cpu family	: 6
> > model		: 85
> > model name	: Intel(R) Xeon(R) Gold 6146 CPU @ 3.20GHz
> > stepping	: 4
> > microcode	: 0x2000069
> > 
> > And the iommu capability reported is:
> > ver 1:0 cap 8d2078c106f0466 ecap f020df
> > (caching mode = 0 , page-selective invalidation = 1)
> > 
> > (The problem is also on 'Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz' and
> > 'Intel(R) Xeon(R) Platinum 8378A CPU @ 3.00GHz')
> > 
> > We run the reproducer on Linux 4.18 and it works as follow:
> > 
> > Step 1. alloc 4G *2M-hugetlb* memory (N.B. no problem with 4K-page mapping)  
> 
> I don't understand 2M-hugetlb here means exactly. The IOMMU hardware
> supports both 2M and 1G super page. The mapping physical memory is 4G.
> Why couldn't it use 1G super page?
> 
> > Step 2. DMA Map 4G memory
> > Step 3.
> >      while (1) {
> >          {UNMAP, 0x0, 0xa0000}, ------------------------------------ (a)
> >          {UNMAP, 0xc0000, 0xbff40000},  
> 
> Have these two ranges been mapped before? Does the IOMMU driver
> complains when you trying to unmap a range which has never been
> mapped? The IOMMU driver implicitly assumes that mapping and
> unmapping are paired.
>
> >          {MAP,   0x0, 0xc0000000}, --------------------------------- (b)
> >                  use GDB to pause at here, and then DMA read IOVA=0,  
> 
> IOVA 0 seems to be a special one. Have you verified with other addresses
> than IOVA 0?

It is???  That would be a problem.

> >                  sometimes DMA success (as expected),
> >                  but sometimes DMA error (report not-present).
> >          {UNMAP, 0x0, 0xc0000000}, --------------------------------- (c)
> >          {MAP,   0x0, 0xa0000},
> >          {MAP,   0xc0000, 0xbff40000},
> >      }

The interesting thing about this test sequence seems to be how it will
implicitly switch between super pages and regular pages.  Also note
that the test is using the original vfio type1 API rather than the v2
API that's more commonly used today.  This older API allows unmaps to
split mappings, but we don't really know how much the IOMMU is
unmapping without reading the unmap.size field returned by the ioctl.
What I expect to happen is that the IOMMU will make use of superpages
when mapping the full range.  When we unmap {0-bffff}, that's likely
going to be covered by a 2M (or more) superpage, therefore the unmap
will actually unmap {0-1fffff}.  The subsequent unmap starting at
0xc0000 might already have {a0000-1fffff} unmapped.  However, when we
then map {0 - bffff} the IOMMU will (should) switch back to 4K pages.
The mapping at 0xc0000 should use 4K pages up through 0x1fffff, then
might switch to 2M or 1G pages depending on physical memory layout.  So
the {0-2MB} IOVA range could be switching back and forth between a
superpage mapping and 4K mapping, and I can certainly imagine that
could lead to page table, if not cache management bugs.  Thanks,

Alex


> > 
> > The DMA read operations sholud success between (b) and (c), it should NOT report
> > not-present at least!
> > 
> > After analysis the problem, we think maybe it's caused by the Intel iommu iotlb.
> > It seems the DMA Remapping hardware still uses the IOTLB or other caches of (a).
> > 
> > When do DMA unmap at (a), the iotlb will be flush:
> >      intel_iommu_unmap
> >          domain_unmap
> >              iommu_flush_iotlb_psi
> > 
> > When do DMA map at (b), no need to flush the iotlb according to the capability
> > of this iommu:
> >      intel_iommu_map
> >          domain_pfn_mapping
> >              domain_mapping
> >                  __mapping_notify_one
> >                      if (cap_caching_mode(iommu->cap)) // FALSE
> >                          iommu_flush_iotlb_psi  
> 
> That's true. The iotlb flushing is not needed in case of PTE been
> changed from non-present to present unless caching mode.
> 
> > But the problem will disappear if we FORCE flush here. So we suspect the iommu
> > hardware.
> > 
> > Do you have any suggestion ?  
> 
> Best regards,
> baolu
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
