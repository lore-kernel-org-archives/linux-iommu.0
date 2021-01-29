Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9883CC433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 10:33:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A305164E6E
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 10:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A305164E6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1DB658749C;
	Fri, 29 Jan 2021 10:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7jmJuV6fmWl; Fri, 29 Jan 2021 10:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8AA5287490;
	Fri, 29 Jan 2021 10:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60509C0FA7;
	Fri, 29 Jan 2021 10:33:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E74A6C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 10:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D336C87494
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 10:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BEBd+GW5HIu0 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2370D87490
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 10:33:32 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRtt86zqhz13nFt;
 Fri, 29 Jan 2021 18:31:28 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 18:33:29 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 18:33:29 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 29 Jan 2021 18:33:29 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4IAEx5CAgACGO9A=
Date: Fri, 29 Jan 2021 10:33:28 +0000
Message-ID: <234b8c25afc440ce8245aca9081652fb@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.74]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> From: Tian, Kevin [mailto:kevin.tian@intel.com]
> Sent: Friday, January 29, 2021 11:09 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jason Gunthorpe
> <jgg@ziepe.ca>
> Cc: chensihang (A) <chensihang1@hisilicon.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-mm@kvack.org; Zhangfei Gao <zhangfei.gao@linaro.org>; Liguozhu
> (Kenneth) <liguozhu@hisilicon.com>; linux-accelerators@lists.ozlabs.org
> Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> > From: Song Bao Hua (Barry Song)
> > Sent: Tuesday, January 26, 2021 9:27 AM
> >
> > > -----Original Message-----
> > > From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> > > Sent: Tuesday, January 26, 2021 2:13 PM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>;
> > Zhangfei Gao
> > > <zhangfei.gao@linaro.org>; linux-accelerators@lists.ozlabs.org;
> > > linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> > > linux-mm@kvack.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> > chensihang
> > > (A) <chensihang1@hisilicon.com>
> > > Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> > >
> > > On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song)
> > wrote:
> > >
> > > > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song)
> > wrote:
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
> >
> > And then we move to SVA case, we can still have a memory pool
> > by hugetlb or pin, and app can allocate memory from this pool
> > since this pool is mapped to the address space of the process,
> > and we are able to get stable I/O performance since it is always
> > there. But in this case, device is using the page table of
> > process with the full permission control.
> > And they are using same address and can possibly enjoy the easy
> > programming if HW supports.
> >
> > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > we would get both sharing address and stable I/O latency.
> >
> 
> Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying
> cpu_va of the memory pool as the iova?

I think it enjoys the advantage of stable I/O latency of
traditional MAP_DMA, and also uses the process page table
which SVA can provide. The major difference is that in
SVA case, iova totally belongs to process and is as normal
as other heap/stack/data:
p = mmap(.....MAP_ANON....);
ioctl(/dev/acc, p, PIN);

SVA for itself, provides the ability to guarantee the
address space isolation of multiple processes.  If the
device can access the data struct  such as list, tree
directly, they can further enjoy the convenience of
programming SVA gives.

So we are looking for a combination of stable io latency
of traditional DMA map and the ability of SVA.

> 
> Thanks
> Kevin

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
