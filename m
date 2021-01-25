Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC3C433E6
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 23:35:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082F422A84
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 23:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082F422A84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC24220506;
	Mon, 25 Jan 2021 23:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ca+ijXAdahkg; Mon, 25 Jan 2021 23:35:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 545E4203AF;
	Mon, 25 Jan 2021 23:35:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C97FC0FA7;
	Mon, 25 Jan 2021 23:35:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7BB2C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 23:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C0E4C872A9
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 23:35:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RDZPFHWMGAdS for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 23:35:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D5BD987205
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 23:35:26 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DPmRG2ZPfzR7MJ;
 Tue, 26 Jan 2021 07:34:18 +0800 (CST)
Received: from dggpemm100010.china.huawei.com (7.185.36.24) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 26 Jan 2021 07:35:23 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 07:35:22 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 26 Jan 2021 07:35:22 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vWniUnMS+RFOU2UJJCa8sDlvKo39q+AgADtcaD//5AFgIAAh9tQ
Date: Mon, 25 Jan 2021 23:35:22 +0000
Message-ID: <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
In-Reply-To: <20210125231619.GY4605@ziepe.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.227]
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
> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of
> Jason Gunthorpe
> Sent: Tuesday, January 26, 2021 12:16 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>; Zhangfei Gao
> <zhangfei.gao@linaro.org>; linux-accelerators@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-mm@kvack.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>; chensihang
> (A) <chensihang1@hisilicon.com>
> Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> 
> On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> > mlock, while certainly be able to prevent swapping out, it won't
> > be able to stop page moving due to:
> > * memory compaction in alloc_pages()
> > * making huge pages
> > * numa balance
> > * memory compaction in CMA
> 
> Enabling those things is a major reason to have SVA device in the
> first place, providing a SW API to turn it all off seems like the
> wrong direction.

I wouldn't say this is a major reason to have SVA. If we read the
history of SVA and papers, people would think easy programming due
to data struct sharing between cpu and device, and process space
isolation in device would be the major reasons for SVA. SVA also
declares it supports zero-copy while zero-copy doesn't necessarily
depend on SVA.

Page migration and I/O page fault overhead, on the other hand, would
probably be the major problems which block SVA becoming a 
high-performance and more popular solution.

> 
> If the device doesn't want to use SVA then don't use it, use normal
> DMA pinning like everything else.
> 

If we disable SVA, we won't get the benefits of SVA on address sharing,
and process space isolation.

> Jason

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
