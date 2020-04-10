Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A66C2BA2B
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 15:47:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22D220CC7
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 15:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22D220CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B65FF881E1;
	Fri, 10 Apr 2020 15:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XSW1Uj-v60VV; Fri, 10 Apr 2020 15:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2842788141;
	Fri, 10 Apr 2020 15:47:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F414C089F;
	Fri, 10 Apr 2020 15:47:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB1FC0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 15:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 273B887A04
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 15:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfGy-r9t6NG8 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 15:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 93840861E3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 15:46:58 +0000 (UTC)
IronPort-SDR: 4As8AwqYxv6MriKGLVlTdPgG6uqrIk+Ib23Cpe1Xn1dMV/63Y3nHV4mR08/hZS3unVBGKuBk1A
 59Jsy039OB8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 08:46:58 -0700
IronPort-SDR: XVgMf3eLPvE+b73mIM4THi7Q1+QOjERmHWs05f5RBY/9sirEPoT11DReiZZ3BasQQLPqdMgFxA
 slMXHmceV6ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,367,1580803200"; d="scan'208";a="453535990"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2020 08:46:57 -0700
Date: Fri, 10 Apr 2020 08:52:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200410085249.04eeae4e@jacob-builder>
In-Reply-To: <20200409145058.GB69482@myrica>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
 <20200408164802.155a69e3@jacob-builder>
 <20200409063905.GA2435@myrica>
 <20200409071424.1653b889@jacob-builder>
 <20200409145058.GB69482@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@ziepe.ca>, zhangfei.gao@linaro.org,
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

On Thu, 9 Apr 2020 16:50:58 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> > So unbind is coming anyway, the difference in handling in mmu
> > release notifier is whether we silently drop DMA fault vs.
> > reporting fault?  
> 
> What I meant is, between mmu release notifier and unbind(), we can't
> print any error from DMA fault on dmesg, because an mm exit is easily
> triggered by userspace. Look at the lifetime of the bond:
> 
> bind()
>  |
>  : Here any DMA fault is handled by mm, and on error we don't print
>  : anything to dmesg. Userspace can easily trigger faults by issuing
> DMA : on unmapped buffers.
>  |
> mm exit -> clear pgd, invalidate IOTLBs
>  |
>  : Here the PASID descriptor doesn't have the pgd anymore, but we
> don't : print out any error to dmesg either. DMA is likely still
> running but : any fault has to be ignored.
>  :
>  : We also can't free the PASID yet, since transactions are still
> coming : in with this PASID.
>  |
> unbind() -> clear context descriptor, release PASID and mmu notifier
>  |
>  : Here the PASID descriptor is clear. If DMA is still running the
> device : driver really messed up and we have to print out any fault.
> 
> For that middle state I had to introduce a new pasid descriptor state
> in the SMMU driver, to avoid reporting errors between mm exit and
> unbind().
I must have missed something, but why bother with a state when you can
always check if the mm is dead by mmget_not_zero()? You would not
handle IOPF if the mm is dead anyway, similarly for other DMA errors.

Also, since you are not freeing ioasid in mmu_notifier release anymore,
does it mean the IOASID notifier chain can be non-atomic?

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
