Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF7C433E9
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 01:29:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33C264DD8
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 01:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33C264DD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 236AD20780;
	Thu, 28 Jan 2021 01:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFHeTzlLAkRm; Thu, 28 Jan 2021 01:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8FA8420763;
	Thu, 28 Jan 2021 01:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B3BFC0FA7;
	Thu, 28 Jan 2021 01:29:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AC22C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2BA9A8669F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ad55lLzVp2a for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 01:29:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9E13B86690
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 01:29:05 +0000 (UTC)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DR2rv3Fv3z5LbD;
 Thu, 28 Jan 2021 09:27:27 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 09:28:27 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 09:28:27 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Thu, 28 Jan 2021 09:28:27 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4IAAmdoAgAKKrfA=
Date: Thu, 28 Jan 2021 01:28:26 +0000
Message-ID: <c4dc2cdf4a904e099641de21282f59d3@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <20210126182024.GA4605@ziepe.ca>
In-Reply-To: <20210126182024.GA4605@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.149]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Wednesday, January 27, 2021 7:20 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>; Zhangfei Gao
> <zhangfei.gao@linaro.org>; linux-accelerators@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-mm@kvack.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>; chensihang
> (A) <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> On Tue, Jan 26, 2021 at 01:26:45AM +0000, Song Bao Hua (Barry Song) wrote:
> > > On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song) wrote:
> > >
> > > > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > > > > mlock, while certainly be able to prevent swapping out, it won't
> > > > > > be able to stop page moving due to:
> > > > > > * memory compaction in alloc_pages()
> > > > > > * making huge pages
> > > > > > * numa balance
> > > > > > * memory compaction in CMA
> > > > >
> > > > > Enabling those things is a major reason to have SVA device in the
> > > > > first place, providing a SW API to turn it all off seems like the
> > > > > wrong direction.
> > > >
> > > > I wouldn't say this is a major reason to have SVA. If we read the
> > > > history of SVA and papers, people would think easy programming due
> > > > to data struct sharing between cpu and device, and process space
> > > > isolation in device would be the major reasons for SVA. SVA also
> > > > declares it supports zero-copy while zero-copy doesn't necessarily
> > > > depend on SVA.
> > >
> > > Once you have to explicitly make system calls to declare memory under
> > > IO, you loose all of that.
> > >
> > > Since you've asked the app to be explicit about the DMAs it intends to
> > > do, there is not really much reason to use SVA for those DMAs anymore.
> >
> > Let's see a non-SVA case. We are not using SVA, we can have
> > a memory pool by hugetlb or pin, and app can allocate memory
> > from this pool, and get stable I/O performance on the memory
> > from the pool. But device has its separate page table which
> > is not bound with this process, thus lacking the protection
> > of process space isolation. Plus, CPU and device are using
> > different address.
> 
> So you are relying on the platform to do the SVA for the device?
> 

Sorry for late response.

uacce and its userspace framework UADK depend on SVA, leveraging
the enhanced security by isolated process address space.

This patch is mainly an extension for performance optimization to
get stable high-performance I/O on pinned memory even though the
hardware supports IO page fault to get pages back after swapping
out or page migration.
But IO page fault will cause serious latency jitter for high-speed
I/O.
For slow speed device, they don't need to use this extension.

> This feels like it goes back to another topic where I felt the SVA
> setup uAPI should be shared and not buried into every driver's unique
> ioctls.
> 
> Having something like this in a shared SVA system is somewhat less
> strange.

Sounds reasonable. On the other hand, uacce seems to be an common
uAPI for SVA, and probably the only one for this moment.

uacce is a framework not a specific driver as any accelerators
can hook into this framework as long as a device provides
uacce_ops and register itself by uacce_register(). Uacce, for
itself, doesn't bind with any specific hardware. So uacce interfaces
are kind of common uAPI :-)

> 
> Jason

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
