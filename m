Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15BEC433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 16:41:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA3A22273
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 16:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA3A22273
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB8E51FC71;
	Tue, 26 Jan 2021 16:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3yy7jjkJWmkW; Tue, 26 Jan 2021 16:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 524D71FE0A;
	Tue, 26 Jan 2021 16:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 287F5C0FA7;
	Tue, 26 Jan 2021 16:40:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC492C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0ADAA1FE0A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5F5h4AAzVTCd for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by silver.osuosl.org (Postfix) with ESMTPS id 35D761FC71
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:40:52 +0000 (UTC)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DQC9x6499z5JF7;
 Wed, 27 Jan 2021 00:39:17 +0800 (CST)
Received: from dggemm753-chm.china.huawei.com (10.1.198.59) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 27 Jan 2021 00:40:48 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemm753-chm.china.huawei.com (10.1.198.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 00:40:47 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Tue, 26 Jan 2021 16:40:45 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Topic: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Index: AQHW8+RNdZVLOLYLIk+ZoY3uV2Gpc6o57K4AgAAuUAA=
Date: Tue, 26 Jan 2021 16:40:45 +0000
Message-ID: <8654e506fa26443f8f4413ec8fd96bf7@huawei.com>
References: <20210126130629.8928-1-shameerali.kolothum.thodi@huawei.com>
 <20210126135039.000039a0@arm.com>
In-Reply-To: <20210126135039.000039a0@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.74]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "will@kernel.org" <will@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 26 January 2021 13:51
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> jean-philippe@linaro.org; will@kernel.org; linuxarm@openeuler.org; Zengtao
> (B) <prime.zeng@hisilicon.com>
> Subject: Re: [PATCH] iommu: Check dev->iommu in iommu_dev_xxx functions
> =

> On Tue, 26 Jan 2021 13:06:29 +0000
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> =

> > The device iommu probe/attach might have failed leaving dev->iommu to
> > NULL and device drivers may still invoke these functions=A0resulting a
> > crash in iommu vendor driver code. Hence make=A0sure we check that.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/iommu.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> > ffeebda8d6de..cb68153c5cc0 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2867,7 +2867,7 @@ bool iommu_dev_has_feature(struct device *dev,
> > enum iommu_dev_features feat) {
> >  	const struct iommu_ops *ops =3D dev->bus->iommu_ops;
> >
> > -	if (ops && ops->dev_has_feat)
> > +	if (dev->iommu && ops && ops->dev_has_feat)
> >  		return ops->dev_has_feat(dev, feat);
> =

> Might make sense to make these more self-contained, e.g.:
> =

> 	if (dev->iommu && dev->iommu->ops->foo)
> 		dev->iommu->ops->foo()

Right. Does that mean adding ops to "struct dev_iommu" or retrieve ops like
below,

if (dev->iommu && dev->iommu->iommu_dev->ops->foo)
 		dev->iommu->iommu_dev->ops->foo()
 =

Sorry, not clear to me.

Thanks,
Shameer
 =


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
