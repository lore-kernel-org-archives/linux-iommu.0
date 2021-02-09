Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F4DC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:58:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D529A64EEB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D529A64EEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A0948600D;
	Tue,  9 Feb 2021 13:58:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A59eiEH5RR2s; Tue,  9 Feb 2021 13:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45D3286055;
	Tue,  9 Feb 2021 13:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B90AC1D9F;
	Tue,  9 Feb 2021 13:58:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07BACC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 10:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E91EA871D8
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 10:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xZrPKPHNNMr for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 10:19:09 +0000 (UTC)
X-Greylist: delayed 01:13:25 by SQLgrey-1.7.6
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5D5CB871CC
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 10:19:09 +0000 (UTC)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 09 Feb 2021 19:19:07 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id E69CC2059027;
 Tue,  9 Feb 2021 19:19:07 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP;
 Tue, 9 Feb 2021 19:19:07 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 9 Feb 2021 19:19:07 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 9 Feb 2021 19:19:07 +0900
From: <obayashi.yoshimasa@socionext.com>
To: <gregkh@linuxfoundation.org>
Subject: RE: DMA direct mapping fix for 5.4 and earlier stable branches
Thread-Topic: DMA direct mapping fix for 5.4 and earlier stable branches
Thread-Index: AQHW/qowxPC004ZwL0WzBboqT0yFrapOzcOAgAAQ0oCAAAGYgIAAmb8Q//98PwCAAKOy0A==
Date: Tue, 9 Feb 2021 10:19:07 +0000
Message-ID: <ed485ad069af4d1481e3961db4a3e079@SOC-EX02V.e01.socionext.com>
References: <CAFA6WYNazCmYN20irLdNV+2vcv5dqR+grvaY-FA7q2WOBMs__g@mail.gmail.com>
 <YCIym62vHfbG+dWf@kroah.com>
 <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
 <YCJCDZGa1Dhqv6Ni@kroah.com>
 <27bbe35deacb4ca49f31307f4ed551b5@SOC-EX02V.e01.socionext.com>
 <YCJUgKDNVjJ4dUqM@kroah.com>
In-Reply-To: <YCJUgKDNVjJ4dUqM@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.1
x-shieldmailcheckerpolicyversion: POLICY200130
x-originating-ip: [10.213.24.1]
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 09 Feb 2021 13:58:38 +0000
Cc: sumit.garg@linaro.org, daniel.thompson@linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> How do you judge "mature"?

  My basic criteria are
* Function is exist, but bug fix is necessary: "mature"
* Function extension is necessary: "immature"

> And again, if a feature isn't present in a specific kernel version, why would you think that it would be
> a viable solution for you to use?

  So, "a feature isn't present in a specific kernel version", 
also means "immature" according to my criteria.

Regards.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, February 9, 2021 6:23 PM
> To: Obayashi, Yoshimasa/尾林 善正 <obayashi.yoshimasa@socionext.com>
> Cc: sumit.garg@linaro.org; hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; stable@vger.kernel.org;
> daniel.thompson@linaro.org
> Subject: Re: DMA direct mapping fix for 5.4 and earlier stable branches
> 
> On Tue, Feb 09, 2021 at 09:05:40AM +0000, obayashi.yoshimasa@socionext.com wrote:
> > > > As the drivers are currently under development and Socionext has
> > > > chosen 5.4 stable kernel for their development. So I will let
> > > > Obayashi-san answer this if it's possible for them to migrate to
> > > > 5.10 instead?
> >
> >   We have started this development project from last August, so we
> > have selected 5.4 as most recent and longest lifetime LTS version at
> > that time.
> >
> >   And we have already finished to develop other device drivers, and
> > Video converter and CODEC drivers are now in development.
> >
> > > Why pick a kernel that doesn not support the features they require?
> > > That seems very odd and unwise.
> >
> >   From the view point of ZeroCopy using DMABUF, is 5.4 not mature
> > enough, and is 5.10 enough mature ?
> >   This is the most important point for judging migration.
> 
> How do you judge "mature"?
> 
> And again, if a feature isn't present in a specific kernel version, why would you think that it would be
> a viable solution for you to use?
> 
> good luck!
> 
> greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
