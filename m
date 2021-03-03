Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1581C433E6
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 21:15:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B3064EF9
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 21:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B3064EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D08D16FAFB;
	Wed,  3 Mar 2021 21:15:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6E6Uh4mZKQE; Wed,  3 Mar 2021 21:15:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBC8E6F985;
	Wed,  3 Mar 2021 21:15:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6C13C000A;
	Wed,  3 Mar 2021 21:15:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 621D7C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 21:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5702984035
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 21:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXChyYEk79Ov for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 21:15:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE0C88428F
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 21:15:12 +0000 (UTC)
IronPort-SDR: akKkImNb9GL0WVcQprAZJI2Bj3nsBWR65GXoOeia6t3ngkFMM7HFkaIowLH1cZPNGAt+uWJV9x
 GdxaXC2c71MA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="251328623"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="251328623"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:15:11 -0800
IronPort-SDR: 4GumHzw+bqY2IuEknONcScAZW86HiX+ue90j58IjKak+hmhbzwOuAwfFlCGtOaA4n6eEKtFaub
 IoJjZGUM6C9g==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="406603184"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 13:15:11 -0800
Date: Wed, 3 Mar 2021 13:17:26 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210303131726.7a8cb169@jacob-builder>
In-Reply-To: <YD+u3CXhwOi2LC+4@slm.duckdns.org>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
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

Hi Tejun,

On Wed, 3 Mar 2021 10:44:28 -0500, Tejun Heo <tj@kernel.org> wrote:

> On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:
> > IOASIDs are used to associate DMA requests with virtual address spaces.
> > They are a system-wide limited resource made available to the userspace
> > applications. Let it be VMs or user-space device drivers.
> > 
> > This RFC patch introduces a cgroup controller to address the following
> > problems:
> > 1. Some user applications exhaust all the available IOASIDs thus
> > depriving others of the same host.
> > 2. System admins need to provision VMs based on their needs for IOASIDs,
> > e.g. the number of VMs with assigned devices that perform DMA requests
> > with PASID.  
> 
> Please take a look at the proposed misc controller:
> 
>  http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com
> 
> Would that fit your bill?
The interface definitely can be reused. But IOASID has a different behavior
in terms of migration and ownership checking. I guess SEV key IDs are not
tied to a process whereas IOASIDs are. Perhaps this can be solved by
adding
+	.can_attach	= ioasids_can_attach,
+	.cancel_attach	= ioasids_cancel_attach,
Let me give it a try and come back.

Thanks for the pointer.

Jacob

> 
> Thanks.
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
