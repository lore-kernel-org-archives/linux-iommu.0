Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1064C433DB
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 22:24:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C53564E35
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 22:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C53564E35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CDE6B20773;
	Sun,  7 Feb 2021 22:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K11aB2gfv2Ho; Sun,  7 Feb 2021 22:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 58C7D204AD;
	Sun,  7 Feb 2021 22:24:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4744DC0174;
	Sun,  7 Feb 2021 22:24:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5909C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 22:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B7CBE86D85
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 22:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DZDCQ++SGP-4 for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 22:24:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C50B385CE3
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 22:24:33 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DYkFH2dR4zY664;
 Mon,  8 Feb 2021 06:23:15 +0800 (CST)
Received: from dggpemm100012.china.huawei.com (7.185.36.212) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 8 Feb 2021 06:24:29 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 06:24:29 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 06:24:29 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Matthew Wilcox <willy@infradead.org>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>
Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Thread-Topic: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Thread-Index: AQHW/SrsWWMRpilf2UC1Pz29QqsBVqpMsX2AgACQE1A=
Date: Sun, 7 Feb 2021 22:24:28 +0000
Message-ID: <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
In-Reply-To: <20210207213409.GL308988@casper.infradead.org>
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
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Monday, February 8, 2021 10:34 AM
> To: Wangzhou (B) <wangzhou1@hisilicon.com>
> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-mm@kvack.org; linux-arm-kernel@lists.infradead.org;
> linux-api@vger.kernel.org; Andrew Morton <akpm@linux-foundation.org>;
> Alexander Viro <viro@zeniv.linux.org.uk>; gregkh@linuxfoundation.org; Song
> Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; jgg@ziepe.ca;
> kevin.tian@intel.com; jean-philippe@linaro.org; eric.auger@redhat.com;
> Liguozhu (Kenneth) <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org;
> chensihang (A) <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> pin
> 
> On Sun, Feb 07, 2021 at 04:18:03PM +0800, Zhou Wang wrote:
> > SVA(share virtual address) offers a way for device to share process virtual
> > address space safely, which makes more convenient for user space device
> > driver coding. However, IO page faults may happen when doing DMA
> > operations. As the latency of IO page fault is relatively big, DMA
> > performance will be affected severely when there are IO page faults.
> > >From a long term view, DMA performance will be not stable.
> >
> > In high-performance I/O cases, accelerators might want to perform
> > I/O on a memory without IO page faults which can result in dramatically
> > increased latency. Current memory related APIs could not achieve this
> > requirement, e.g. mlock can only avoid memory to swap to backup device,
> > page migration can still trigger IO page fault.
> 
> Well ... we have two requirements.  The application wants to not take
> page faults.  The system wants to move the application to a different
> NUMA node in order to optimise overall performance.  Why should the
> application's desires take precedence over the kernel's desires?  And why
> should it be done this way rather than by the sysadmin using numactl to
> lock the application to a particular node?

NUMA balancer is just one of many reasons for page migration. Even one
simple alloc_pages() can cause memory migration in just single NUMA
node or UMA system.

The other reasons for page migration include but are not limited to:
* memory move due to CMA
* memory move due to huge pages creation

Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
in the whole system.

On the other hand, numactl doesn't always bind memory to single NUMA
node, sometimes, while applications require many cpu, it could bind
more than one memory node.

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
