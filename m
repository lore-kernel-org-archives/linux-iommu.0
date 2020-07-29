Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C87C433E0
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:24:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A222067D
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A222067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 81F5C847BD;
	Wed, 29 Jul 2020 20:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N_8juNGH8Vgc; Wed, 29 Jul 2020 20:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89593847D5;
	Wed, 29 Jul 2020 20:24:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73A5AC004F;
	Wed, 29 Jul 2020 20:24:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79B97C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7440187935
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v7YzM58yVJwi for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 20:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 818B487916
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:24:39 +0000 (UTC)
IronPort-SDR: tYqMVmAlljnJIG8SKYHokwb47XFnerawm2vinI7ixQSw/o6h4nky52GAJyUKDwYxoyJxgFV009
 pkYa7VJWqKug==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="131559045"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="131559045"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 13:24:38 -0700
IronPort-SDR: SbLGSd4PxzqdaIniLvoXaonH5YsNE5jn6/GtoVeJa/IztLGobnz2oHr7IYSlamrn4FFxFJ8z8O
 JHxYARwMX2jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; d="scan'208";a="490407845"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2020 13:24:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jul 2020 13:24:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 Jul 2020 13:24:37 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 29 Jul 2020 13:24:37 -0700
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH V5 0/3] iommu: Add support to change default domain of an
 iommu group
Thread-Topic: [PATCH V5 0/3] iommu: Add support to change default domain of an
 iommu group
Thread-Index: AQHWYfQuScDXRzNFE0q8ss0qD77FfKke+3SAgAAG7MA=
Date: Wed, 29 Jul 2020 20:24:37 +0000
Message-ID: <de9ca422bda4445f89b412c24d8b8d4c@intel.com>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
 <20200729123722.GC23653@8bytes.org>
In-Reply-To: <20200729123722.GC23653@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
x-originating-ip: [10.1.200.100]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Joerg,

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Wednesday, July 29, 2020 5:37 AM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: iommu@lists.linux-foundation.org; Christoph Hellwig <hch@lst.de>; Raj,
> Ashok <ashok.raj@intel.com>; Will Deacon <will.deacon@arm.com>; Lu Baolu
> <baolu.lu@linux.intel.com>; Mehta, Sohil <sohil.mehta@intel.com>; Robin
> Murphy <robin.murphy@arm.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
> Subject: Re: [PATCH V5 0/3] iommu: Add support to change default domain of
> an iommu group
> 
> Hi,
> 
> On Fri, Jul 24, 2020 at 12:51:57PM -0700, Sai Praneeth Prakhya wrote:
> > Tested only for intel_iommu/vt-d. Would appreciate if someone could
> > test on AMD and ARM based machines.
> 
> This looks good to me now, but I want to test it some more on other hardware
> and look up the implications of the probe_finalize calls when changing the
> default domain.

Makes sense to me.

> Since I am technically on vacation this week and next and don't have the
> resources around to do proper testing, I defer this for the next round.
> Please re-send this patch-set when the merge window closes.

Sure! Makes sense. I will resend the patch-set after this merge window closes.

Regards,
Sai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
