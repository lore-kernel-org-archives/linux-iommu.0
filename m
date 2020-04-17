Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43561C2BA2B
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 02:45:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E3621841
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 02:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E3621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD5D686BB7;
	Fri, 17 Apr 2020 02:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SxxBWK+AXss; Fri, 17 Apr 2020 02:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C413C86B28;
	Fri, 17 Apr 2020 02:45:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7572C089E;
	Fri, 17 Apr 2020 02:45:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A366DC0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 02:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 980C984EA7
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 02:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OktSYginT5NM for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 02:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0089E84D62
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 02:45:33 +0000 (UTC)
IronPort-SDR: qJANlBHD54LS9dh+SbJn9Ao8EwwSf7Kz+dsFDlFSdfLwIEzywPZiC4bXrzxwvh5kTTpRbhLlW+
 I2zwgfaNu4vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 19:45:32 -0700
IronPort-SDR: eCPijPNfhNoemscwgxRcefwZ2Y8SDR6sV++TqTEKQKEU4t7fpT3657DIOrOonPGx1svabfdC4R
 GFebdUbl5iyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; d="scan'208";a="278222332"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 19:45:32 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 19:45:32 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 19:45:32 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Fri, 17 Apr 2020 10:45:23 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Auger Eric <eric.auger@redhat.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Thread-Topic: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Thread-Index: AQHWCebOp12IiW87IUSByO2zgM/w7qhv6qkAgAJcu4CACNZVgIABkaSw
Date: Fri, 17 Apr 2020 02:45:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D824106@SHSMSX104.ccr.corp.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
 <20200410124557.4012b99b@jacob-builder>
 <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
In-Reply-To: <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Yi L <yi.l.liu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

> From: Auger Eric
> Sent: Thursday, April 16, 2020 6:43 PM
> 
[...]
> >>> +	if (svm) {
> >>> +		/*
> >>> +		 * If we found svm for the PASID, there must be at
> >>> +		 * least one device bond, otherwise svm should be
> >>> freed.
> >>> +		 */
> >>> +		if (WARN_ON(list_empty(&svm->devs))) {
> >>> +			ret = -EINVAL;
> >>> +			goto out;
> >>> +		}
> >>> +
> >>> +		for_each_svm_dev(sdev, svm, dev) {
> >>> +			/* In case of multiple sub-devices of the
> >>> same pdev
> >>> +			 * assigned, we should allow multiple bind
> >>> calls with
> >>> +			 * the same PASID and pdev.
> >>> +			 */
> >>> +			sdev->users++;
> >> What if this is not an mdev device. Is it also allowed?
> > Yes. IOMMU and VT-d driver is not mdev aware. Here mdev is just an
> > example of normal use case. You can bind the same PCI device (PF or
> > SRIOV VF) more than once to the same PASID. Just need to unbind also.
> 
> I don't get the point of binding a non mdev device several times with
> the same PASID. Do you intend to allow that at userspace level or
> prevent this from happening in VFIO?

I feel it's better to prevent this from happening, otherwise VFIO also
needs to track the bind count and do multiple unbinds at mm_exit.
But it's not necessary to prevent it in VFIO. We can check here
upon whether aux_domain is valid, and if not return -EBUSY.

> 
> Besides, the comment is a bit misleading as it gives the impression it
> is only true for mdev and there is no associated check.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
