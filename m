Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CCBC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 03:47:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41D264ED3
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 03:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41D264ED3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8689020338;
	Tue,  2 Feb 2021 03:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOwG8YJQDaXg; Tue,  2 Feb 2021 03:47:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E6D920016;
	Tue,  2 Feb 2021 03:47:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA95C0174;
	Tue,  2 Feb 2021 03:47:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3377CC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 03:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 21A9E87042
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 03:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FOXBidXwlobc for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 03:47:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3468587041
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 03:47:38 +0000 (UTC)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DV9hv28l2zR5KD;
 Tue,  2 Feb 2021 11:46:23 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 2 Feb 2021 11:47:33 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 11:47:33 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 2 Feb 2021 11:47:33 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ//+YwwCAAIUv4IAEx5CAgAWazQCAADRGAIAAkKkA
Date: Tue, 2 Feb 2021 03:47:33 +0000
Message-ID: <06924f5853c24f99a4b1f5683bdc74e4@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
 <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210201234424.GI4718@ziepe.ca>
 <MWHPR11MB1886464FFEF10DF9AE708C4A8CB59@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1886464FFEF10DF9AE708C4A8CB59@MWHPR11MB1886.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.106]
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
> Sent: Tuesday, February 2, 2021 3:52 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; chensihang (A)
> <chensihang1@hisilicon.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-mm@kvack.org; Zhangfei Gao
> <zhangfei.gao@linaro.org>; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> linux-accelerators@lists.ozlabs.org
> Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, February 2, 2021 7:44 AM
> >
> > On Fri, Jan 29, 2021 at 10:09:03AM +0000, Tian, Kevin wrote:
> > > > SVA is not doom to work with IO page fault only. If we have SVA+pin,
> > > > we would get both sharing address and stable I/O latency.
> > >
> > > Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying
> > > cpu_va of the memory pool as the iova?
> >
> > I think their issue is the HW can't do the cpu_va trick without also
> > involving the system IOMMU in a SVA mode
> >
> 
> This is the part that I didn't understand. Using cpu_va in a MAP_DMA
> interface doesn't require device support. It's just an user-specified
> address to be mapped into the IOMMU page table. On the other hand,

The background is that uacce is based on SVA and we are building
applications on uacce:
https://www.kernel.org/doc/html/v5.10/misc-devices/uacce.html
so IOMMU simply uses the page table of MMU, and don't do any
special mapping to an user-specified address. We don't break
the basic assumption that uacce is using SVA, otherwise, we
need to re-build uacce and the whole base.

> sharing CPU page table through a SVA interface for an usage where I/O
> page faults must be completely avoided seems a misleading attempt.

That is not for completely avoiding IO page fault, that is just
an extension for high-performance I/O case, providing a way to
avoid IO latency jitter. Using it or not is totally up to users.

> Even if people do want this model (e.g. mix pinning+fault), it should be
> a mm syscall as Greg pointed out, not specific to sva.
> 

We are glad to make it a syscall if people are happy with
it. The simplest way would be a syscall similar with
userfaultfd  if we don't want to mess up mm_struct.

> Thanks
> Kevin

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
