Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0766EC2BB85
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 07:57:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA3B216FD
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 07:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA3B216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3941B204FF;
	Wed, 15 Apr 2020 07:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfIt8cAkUj6t; Wed, 15 Apr 2020 07:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 084192001A;
	Wed, 15 Apr 2020 07:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0155C1D7D;
	Wed, 15 Apr 2020 07:57:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66534C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5059D85F74
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id olEz0NJkZZL4 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 07:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7702E85F6E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 07:57:12 +0000 (UTC)
IronPort-SDR: WUC14gFyMMkfdlCC6HMfM2DJRP803+VTsd3IvpYGK2hUM5N8xSc5cEBvTXgH5u9yLP8Hoyt/JN
 ji/fYexwuAEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 00:57:11 -0700
IronPort-SDR: duupAcieAe2PFajTeb6R5W3wjVPdK9W9u9YT+zNk5DnJXl7l7cdULN187mGQvvosYMdxM1nNL+
 PisPjyxt6mjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="453838877"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 00:57:11 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 00:57:10 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 00:57:10 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.7]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 15:57:08 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v2 0/7] iommu/vt-d: Add page request draining support
Thread-Topic: [PATCH v2 0/7] iommu/vt-d: Add page request draining support
Thread-Index: AQHWEubGFdWwTRJ930mQo8Wb1/6Ng6h5z/pA
Date: Wed, 15 Apr 2020 07:57:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D820475@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200415052542.30421-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 15, 2020 1:26 PM
> 
> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in the software and
> remapping hardware. The pending page requests must be drained
> so that the pasid could be reused. The register level interface
> for page request draining is defined in 7.11 of the VT-d spec.
> This series adds the support for page requests draining.

7.11 doesn't include register-level interface. It just talks about
the general requirements on system software, endpoint device
and its driver.

Thanks
Kevin

> 
> This includes two parts:
>  - PATCH 1/7 ~ 3/7: refactor the qi_submit_sync() to support
>    multiple descriptors per submission which will be used by
>    PATCH 6/7.
>  - PATCH 4/7 ~ 7/7: add page request drain support after a
>    pasid entry is torn down due to an unbind operation.
> 
> Please help to review.
> 
> Best regards,
> baolu
> 
> Change log:
>  v1->v2:
>   - Fix race between multiple prq handling threads
> 
> Lu Baolu (7):
>   iommu/vt-d: Refactor parameters for qi_submit_sync()
>   iommu/vt-d: Multiple descriptors per qi_submit_sync()
>   iommu/vt-d: debugfs: Add support to show inv queue internals
>   iommu/vt-d: Refactor prq_event_thread()
>   iommu/vt-d: Save prq descriptors in an internal list
>   iommu/vt-d: Add page request draining support
>   iommu/vt-d: Remove redundant IOTLB flush
> 
>  drivers/iommu/dmar.c                |  63 +++--
>  drivers/iommu/intel-iommu-debugfs.c |  62 +++++
>  drivers/iommu/intel-pasid.c         |   4 +-
>  drivers/iommu/intel-svm.c           | 383 ++++++++++++++++++----------
>  drivers/iommu/intel_irq_remapping.c |   2 +-
>  include/linux/intel-iommu.h         |  12 +-
>  6 files changed, 369 insertions(+), 157 deletions(-)
> 
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
