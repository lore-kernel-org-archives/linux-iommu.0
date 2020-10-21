Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C2C4363A
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 22:15:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BF5241A3
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 22:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BF5241A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 663F286CD7;
	Wed, 21 Oct 2020 22:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5AQsg5q6ZfE; Wed, 21 Oct 2020 22:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B9B786CB5;
	Wed, 21 Oct 2020 22:15:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23984C08A1;
	Wed, 21 Oct 2020 22:15:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2871C0052
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 22:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ABB5520463
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 22:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4lKPCgdxp377 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 22:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id A88302E2EC
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 20:03:17 +0000 (UTC)
IronPort-SDR: f2M1BN95XvDh3+AND4F94elaVZqJf5zTdJOv9hBtPFo/jLN+wSqEq+B5girNk3a6uGLoA24Iae
 BbY3ZVfu1Kpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="166649240"
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; d="scan'208";a="166649240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 13:03:17 -0700
IronPort-SDR: xEyG+1n/eDzjVR0+DtrXQn5yv9QrenhZiu6V46hIeKkpLXZlWavLw7Y1PgxgjOpAwXqjOjTx+Y
 jH17pp8imlug==
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; d="scan'208";a="392836909"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 13:03:16 -0700
Date: Wed, 21 Oct 2020 13:03:15 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201021200315.GA93724@otc-nc-03>
References: <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com>
 <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com>
 <20201020200844.GC86371@otc-nc-03>
 <20201020201403.GP6219@nvidia.com>
 <20201020202713.GF86371@otc-nc-03>
 <20201021114829.GR6219@nvidia.com>
 <20201021175146.GA92867@otc-nc-03>
 <20201021182442.GU6219@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201021182442.GU6219@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Oct 21, 2020 at 03:24:42PM -0300, Jason Gunthorpe wrote:
> 
> > Contrary to your argument, vDPA went with a half blown device only 
> > iommu user without considering existing abstractions like containers
> 
> VDPA IOMMU was done *for Intel*, as the kind of half-architected thing
> you are advocating should be allowed for IDXD here. Not sure why you
> think bashing that work is going to help your case here.

I'm not bashing that work, sorry if it comes out that way, 
but just feels like double standards.

I'm not sure why you tie in IDXD and VDPA here. How IDXD uses native
SVM is orthogonal to how we achieve mdev passthrough to guest and vSVM. 
We visited that exact thing multiple times. Doing SVM is quite simple and 
doesn't carry the weight of other (Kevin explained this in detail 
not too long ago) long list of things we need to accomplish for mdev pass through. 

For SVM, just access to hw, mmio and bind_mm to get a PASID bound with
IOMMU. 

For IDXD that creates passthough devices for guest access and vSVM is
through the VFIO path. 

For guest SVM, we expose mdev's to guest OS, idxd in the guest provides vSVM
services. vSVM is *not* build around native SVM interfaces. 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
