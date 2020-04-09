Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA6C2BA2B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 16:15:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79CD20753
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 16:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79CD20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A442C86AC6;
	Thu,  9 Apr 2020 16:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LUUzjaOJqPQo; Thu,  9 Apr 2020 16:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00550868A9;
	Thu,  9 Apr 2020 16:15:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE85EC089F;
	Thu,  9 Apr 2020 16:15:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50304C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 39B9520397
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Hsoyy8U27X4 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 16:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id 4BD51203C2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 16:15:43 +0000 (UTC)
IronPort-SDR: k1UmDwpdusBc4DZZbC2n/gQGAPsgawdJCKKfHJnvD6OY9f0DOE1W5SDcVZXbqXg/46Wag2Zorw
 NG9FQCfFctlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 09:15:42 -0700
IronPort-SDR: F3lTLkK3FD4wrOb6yAx2aqirsWwa25HXU0oFAetbjQHjD7i8mWvBu/aMxwvi1hkfEXgFW3lGDD
 Vu1M+E7zrFsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="255203432"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 09 Apr 2020 09:15:42 -0700
Date: Thu, 9 Apr 2020 09:21:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200409092134.0c427b95@jacob-builder>
In-Reply-To: <20200409142519.GH11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
 <20200409063905.GA2435@myrica>
 <20200409071424.1653b889@jacob-builder>
 <20200409142519.GH11886@ziepe.ca>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de, "Yu,
 Fenghua" <fenghua.yu@intel.com>, gregkh@linuxfoundation.org,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-accelerators@lists.ozlabs.org
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

On Thu, 9 Apr 2020 11:25:19 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Apr 09, 2020 at 07:14:24AM -0700, Jacob Pan wrote:
> > > When the process is killed, mm release can happen before fds are
> > > released. If you look at do_exit() in kernel/exit.c:
> > > 
> > > 	exit_mm()
> > > 	  mmput()  
> > > 	   -> mmu release notifier    
> > > 	...
> > > 	exit_files()
> > > 	  close_files()
> > > 	    fput()
> > > 	exit_task_work()
> > > 	  __fput()  
> > > 	   -> unbind()    
> > >   
> > So unbind is coming anyway, the difference in handling in mmu
> > release notifier is whether we silently drop DMA fault vs.
> > reporting fault?  
> 
> Userspace can significantly delay the final fput triggering the
> unbind, the above is only for the trivial case where the process
> owning the mm_struct is the only process holding the fd.
> 
Are you talking about FDs owned buy children after fork() or FDs sent
over to another process. I think, in either case SVA is not supported.

> The destruction of a mm_struct should be treated the same as unmapping
> every vma in the process. The observable effect should be no different
> than munmap.
> 
Good point. I agree, we should suppress the error in the window before
unbind.

> Jason

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
