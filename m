Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88441C83000
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 22:24:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F7820757
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 22:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F7820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 03F9B20BF8;
	Wed, 29 Apr 2020 22:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXvm+BiOiKHV; Wed, 29 Apr 2020 22:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 95173204AB;
	Wed, 29 Apr 2020 22:24:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC4BC0865;
	Wed, 29 Apr 2020 22:24:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4622EC0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 22:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2EBEC87BAD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 22:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aaWwAgV65Xke for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 22:24:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 605D987B72
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 22:24:02 +0000 (UTC)
IronPort-SDR: Y/r0WOinsuaYRvRIrArrZRdtcL8+HWrypOplPjynOH7MvH83h2QfSyxdaW1Bt/XEqA5cyMCV0G
 X2nvJRlxK+TQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 15:24:02 -0700
IronPort-SDR: QmHGe38YMh/15b3Az8RAY2FiSQGf0moHXjggntwMvaFvKgufCh1vejIfwUqtMw+VgsIpnWWIlK
 tYmtAtx/DxNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; d="scan'208";a="367944111"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2020 15:24:01 -0700
Date: Wed, 29 Apr 2020 15:30:03 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 4/8] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200429153003.31d2edf7@jacob-builder>
In-Reply-To: <72d52eba-8c78-9d99-2537-b03dbfb3b543@redhat.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1587495165-80096-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8A0D03@SHSMSX104.ccr.corp.intel.com>
 <20200427133409.47ba22b2@jacob-builder>
 <72d52eba-8c78-9d99-2537-b03dbfb3b543@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, 29 Apr 2020 16:12:01 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> >> in last review Eric raised the open about what about binding the
> >> same PASID to the same pdev multiple times. We discussed that
> >> should be disallowed. Here can you check whether aux_domain is
> >> enabled on pdev to restrict multiple-binding only for
> >> sub-devices?  
> > Why aux_domain is sufficient? A pdev could have aux_domain enabled
> > but still bind pdev many times more than its mdevs.
> > 
> > Either we allow multiple bind or not.  
> 
> I tried to figure out whether binding the same PASID to the same pdev
> was meaningful. I understood it is not. If this case can be detected
> at VFIO level I am fine as well.
I will remove the multiple bind support for now. Reintroduce it when we
enable mdev.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
