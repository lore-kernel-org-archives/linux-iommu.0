Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5DFC433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 22:12:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0442661400
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 22:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0442661400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A199284527;
	Fri,  7 May 2021 22:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GCxYoWa71844; Fri,  7 May 2021 22:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9286583CD9;
	Fri,  7 May 2021 22:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A46C000E;
	Fri,  7 May 2021 22:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 781D1C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 22:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 653FE40342
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 22:12:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gvLwZjT-lXNf for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 22:12:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AB5640333
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 22:12:49 +0000 (UTC)
IronPort-SDR: Q5j9KsHWaUsDdc4lYujvHWclMLa7qYciNKmoNdhjgK3xx6wZ6I0X3UOgZPREg8isVDB4hHiGaQ
 k8ebsHR/tqYA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198475062"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="198475062"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 15:12:48 -0700
IronPort-SDR: 7WNbQ0A1+3oGRBKbWEfzfOFJWCNFKRgaATZCvUAV4vlGVej4zXBduyRXqZ3lghhLF9/05JQlSR
 LNS1KAx8QGWQ==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; d="scan'208";a="429156396"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2021 15:12:48 -0700
Date: Fri, 7 May 2021 15:15:11 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210507151511.612d1424@jacob-builder>
In-Reply-To: <20210507192810.GY1370958@nvidia.com>
References: <20210505102259.044cafdf@jacob-builder>
 <20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder> <YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>
 <20210506163240.GA9058@otc-nc-03>
 <20210507172051.GW1370958@nvidia.com>
 <20210507181458.GA73499@otc-nc-03>
 <20210507182050.GX1370958@nvidia.com>
 <20210507192325.GB73499@otc-nc-03>
 <20210507192810.GY1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, 
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jason,

On Fri, 7 May 2021 16:28:10 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > The unanswered question is how do we plumb from vIOMMU without a custom
> > allocator to get a system wide PASID?   
> 
> PASID allocation is part of the iommu driver, it really shouldn't be
> global.
> 
In the current code, the pluggable custom allocator *is* part of the iommu
vendor driver. If it decides the allocation is global then it should be
suitable for the platform since there will never be a VT-d IOMMU on another
vendor's platform.

It is true that the default allocator is global which suites the current
needs. I am just wondering if we are solving a problem does not exist yet.

> When the architecture code goes to allocate a single PASID for the
> mm_struct it should flag that allocation request with a 'must work for
> all RIDs flag' and the iommu driver should take care of it. That might
> mean the iommu driver consults a global static xarray, or maybe it
> does a hypercall, but it should be done through that API, not a side
> care global singleton.
Why do we need to flag the allocation every time if on a platform *every*
PASID can potentially be global? At the time of allocation, we don't know
if the PASID will be used for a shared (ENQCMD) or a dedicated workqueue.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
