Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3EC433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 21:26:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6909F64FF3
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 21:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6909F64FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 204256ECE9;
	Thu,  4 Mar 2021 21:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1cnOBCWQcpIn; Thu,  4 Mar 2021 21:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id F21B76E83A;
	Thu,  4 Mar 2021 21:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA3DCC000B;
	Thu,  4 Mar 2021 21:25:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0C68C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 21:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2B336ECE9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 21:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjYPvOwENiZZ for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 21:25:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A6DE6E83A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 21:25:55 +0000 (UTC)
IronPort-SDR: FEj7oO3qgY9OYshL4fHOuWqVFiahy5dFlzuXMJO4Bg7oFN8dd4dKCRbU8viUxC45Yvn3yW8Usa
 9rQzQ9PU/Ryg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="185101900"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; d="scan'208";a="185101900"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 13:25:53 -0800
IronPort-SDR: MQ7Ih7H0p2xK1hWg7n4AeoanVjOPZRwTjBXJnjrogCBsf4jtzESf6/D/mAX8KKNBeg8DF+etxU
 JJCkaD1zIg3A==
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; d="scan'208";a="384637280"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 13:25:53 -0800
Date: Thu, 4 Mar 2021 13:28:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210304132809.75b3fa55@jacob-builder>
In-Reply-To: <20210304190253.GL4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder>
 <20210304175402.GG4247@nvidia.com>
 <20210304110144.39ef0941@jacob-builder>
 <20210304190253.GL4247@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, 4 Mar 2021 15:02:53 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Mar 04, 2021 at 11:01:44AM -0800, Jacob Pan wrote:
> 
> > > For something like qemu I'd expect to put the qemu process in a cgroup
> > > with 1 PASID. Who cares what qemu uses the PASID for, or how it was
> > > allocated?  
> > 
> > For vSVA, we will need one PASID per guest process. But that is up to
> > the admin based on whether or how many SVA capable devices are directly
> > assigned.  
> 
> I hope the virtual IOMMU driver can communicate the PASID limit and
> the cgroup machinery in the guest can know what the actual limit is.
> 
For VT-d, emulated vIOMMU can communicate with the guest IOMMU driver on how
many PASID bits are supported (extended cap reg PASID size fields). But it
cannot communicate how many PASIDs are in the pool(host cgroup capacity).

The QEMU process may not be the only one in a cgroup so it cannot give hard
guarantees. I don't see a good way to communicate accurately at runtime as
the process migrates or limit changes.

We were thinking to adopt the "Limits" model as defined in the cgroup-v2
doc.
"
Limits
------

A child can only consume upto the configured amount of the resource.
Limits can be over-committed - the sum of the limits of children can
exceed the amount of resource available to the parent.
"

So the guest cgroup would still think it has full 20 bits of PASID at its
disposal. But PASID allocation may fail before reaching the full 20 bits
(2M).
Similar on the host side, we only enforce the limit set by the cgroup but
not guarantee it.

> I was thinking of a case where qemu is using a single PASID to setup
> the guest kVA or similar
> 
got it.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
