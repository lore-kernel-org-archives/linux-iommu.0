Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E516C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 02:28:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0401E64E37
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 02:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0401E64E37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB3A120414;
	Mon,  8 Feb 2021 02:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id deAbEJ9q5225; Mon,  8 Feb 2021 02:28:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F0D57203CF;
	Mon,  8 Feb 2021 02:28:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7BAAC0174;
	Mon,  8 Feb 2021 02:28:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3C51C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 02:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9904686FCC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 02:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Evbu+A7KRtPl for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 02:28:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8B9D386FC7
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 02:28:17 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DYqfS6xxczRCKl;
 Mon,  8 Feb 2021 10:26:56 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 8 Feb 2021 10:27:06 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 10:27:06 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 10:27:06 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Thread-Topic: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpMsX2AgACQE1D//7IVAIAAi2xQ
Date: Mon, 8 Feb 2021 02:27:06 +0000
Message-ID: <b4e2acc237e44ffe916135e96ad3ef20@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
 <20210208013056.GM308988@casper.infradead.org>
In-Reply-To: <20210208013056.GM308988@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chensihang \(A\)" <chensihang1@hisilicon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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



> -----Original Message-----
> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of
> Matthew Wilcox
> Sent: Monday, February 8, 2021 2:31 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
> gregkh@linuxfoundation.org; jgg@ziepe.ca; kevin.tian@intel.com;
> jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
> <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
> <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> pin
> 
> On Sun, Feb 07, 2021 at 10:24:28PM +0000, Song Bao Hua (Barry Song) wrote:
> > > > In high-performance I/O cases, accelerators might want to perform
> > > > I/O on a memory without IO page faults which can result in dramatically
> > > > increased latency. Current memory related APIs could not achieve this
> > > > requirement, e.g. mlock can only avoid memory to swap to backup device,
> > > > page migration can still trigger IO page fault.
> > >
> > > Well ... we have two requirements.  The application wants to not take
> > > page faults.  The system wants to move the application to a different
> > > NUMA node in order to optimise overall performance.  Why should the
> > > application's desires take precedence over the kernel's desires?  And why
> > > should it be done this way rather than by the sysadmin using numactl to
> > > lock the application to a particular node?
> >
> > NUMA balancer is just one of many reasons for page migration. Even one
> > simple alloc_pages() can cause memory migration in just single NUMA
> > node or UMA system.
> >
> > The other reasons for page migration include but are not limited to:
> > * memory move due to CMA
> > * memory move due to huge pages creation
> >
> > Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
> > in the whole system.
> 
> You're dodging the question.  Should the CMA allocation fail because
> another application is using SVA?
> 
> I would say no.  

I would say no as well.

While IOMMU is enabled, CMA almost has one user only: IOMMU driver
as other drivers will depend on iommu to use non-contiguous memory
though they are still calling dma_alloc_coherent().

In iommu driver, dma_alloc_coherent is called during initialization
and there is no new allocation afterwards. So it wouldn't cause
runtime impact on SVA performance. Even there is new allocations,
CMA will fall back to general alloc_pages() and iommu drivers are
almost allocating small memory for command queues.

So I would say general compound pages, huge pages, especially
transparent huge pages, would be bigger concerns than CMA for
internal page migration within one NUMA. 

Not like CMA, general alloc_pages() can get memory by moving
pages other than those pinned.

And there is no guarantee we can always bind the memory of
SVA applications to single one NUMA, so NUMA balancing is
still a concern.

But I agree we need a way to make CMA success while the userspace
pages are pinned. Since pin has been viral in many drivers, I
assume there is a way to handle this. Otherwise, APIs like 
V4L2_MEMORY_USERPTR[1] will possibly make CMA fail as there
is no guarantee that usersspace will allocate unmovable memory
and there is no guarantee the fallback path- alloc_pages() can
succeed while allocating big memory.

Will investigate more.

> The application using SVA should take the one-time
> performance hit from having its memory moved around.

Sometimes I also feel SVA is doomed to suffer from performance
impact due to page migration. But we are still trying to
extend its use cases to high-performance I/O.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/v4l2-core/videobuf-dma-sg.c

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
