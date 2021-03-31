Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005DC433B4
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 18:18:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E9961059
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 18:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E9961059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89C0E40507;
	Wed, 31 Mar 2021 18:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 48_Tb03SrG3C; Wed, 31 Mar 2021 18:18:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6CA840518;
	Wed, 31 Mar 2021 18:18:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE255C000C;
	Wed, 31 Mar 2021 18:18:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10AE6C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 18:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F343060B3F
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 18:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PD8oJAQfvwRu for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 18:18:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD13860B3A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 18:18:19 +0000 (UTC)
IronPort-SDR: 43JPf36gn9N/y8DC2/YMDQiuXYBdPNdBAaskwa6o5+OBX+2jzM3tW9aXm3R1UI3uCTfJnkScVI
 IolgHtuv8p4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="277248607"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; d="scan'208";a="277248607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 11:17:59 -0700
IronPort-SDR: fOu2Q4kpYz95Wg8WRpseF+M0RoDDUeiB7sxcuwl5noXe/9+0xQhstvY2lKI0cJRNqcr9UwNITL
 6cFVDEeuSD/w==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; d="scan'208";a="394143752"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 11:17:59 -0700
Date: Wed, 31 Mar 2021 11:20:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210331112030.174e77b0@jacob-builder>
In-Reply-To: <20210331173148.GN1463678@nvidia.com>
References: <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <20210329155526.2ad791a9@jacob-builder>
 <20210330134313.GP2356281@nvidia.com>
 <20210330171041.70f2d7d0@jacob-builder>
 <20210331122805.GC1463678@nvidia.com>
 <20210331093457.753512d4@jacob-builder>
 <20210331173148.GN1463678@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
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

On Wed, 31 Mar 2021 14:31:48 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > We should try to avoid hidden behind the scenes kernel
> > > interconnections between subsystems.
> > >   
> > Can we? in case of exception. Since all these IOCTLs are coming from the
> > unreliable user space, we must deal all exceptions.
> >
> > For example, when user closes /dev/ioasid FD before (or w/o) unbind
> > IOCTL for VFIO, KVM, kernel must do cleanup and coordinate among
> > subsystems. In this patchset, we have a per mm(ioasid_set) notifier to
> > inform mdev, KVM to clean up and drop its refcount. Do you have any
> > suggestion on this?  
> 
> The ioasid should be a reference counted object.
> 
yes, this is done in this patchset.

> When the FD is closed, or the ioasid is "destroyed" it just blocks DMA
> and parks the PASID until *all* places release it. Upon a zero
> refcount the PASID is recycled for future use.
> 
Just to clarify, you are saying (when FREE happens before proper
teardown) there is no need to proactively notify all users of the IOASID to
drop their reference. Instead, just wait for the other parties to naturally
close and drop their references. Am I understanding you correctly?

I feel having the notifications can add two values:
1. Shorten the duration of errors (as you mentioned below), FD close can
take a long and unpredictable time. e.g. FD shared.
2. Provide teardown ordering among PASID users. i.e. vCPU, IOMMU, mdev.

> The duration between unmapping the ioasid and releasing all HW access
> will have HW see PCIE TLP errors due to the blocked access. If
> userspace messes up the order it is fine to cause this. We already had
> this dicussion when talking about how to deal with process exit in the
> simple SVA case.
Yes, we have disabled fault reporting during this period. The slight
differences vs. the simple SVA case is that KVM is also involved and there
might be an ordering requirement to stop vCPU first.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
