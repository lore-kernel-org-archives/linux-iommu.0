Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E7C2BA2B
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 23:49:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2452F206C0
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 23:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2452F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E85FE86C35;
	Wed,  8 Apr 2020 23:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id STQAWGMwtwIy; Wed,  8 Apr 2020 23:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5121686B77;
	Wed,  8 Apr 2020 23:49:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39BDCC1AE8;
	Wed,  8 Apr 2020 23:49:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3079C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 23:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E17FA88057
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 23:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4h+-bZeoUjJc for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 23:49:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 075ED88051
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 23:49:27 +0000 (UTC)
IronPort-SDR: TT0gDxPedQ7pdHMkdLEdJFQlAQdmcg5TccKXV/Dhs53EU4FwZY9OvHq4CKTph2LoIR4QQJR14y
 wQ/F9LeLWrPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2020 16:49:27 -0700
IronPort-SDR: f1DBreKqBywE+RdbrQfVEPHrDAn7IP+US7Vh3Uvz7ZHyNsKSxMLXnBAxLF+Y42tuMYJ1FH1Z4C
 y+GttCRDfFfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; d="scan'208";a="269906524"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 08 Apr 2020 16:49:27 -0700
Date: Wed, 8 Apr 2020 16:49:01 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200408234901.GA209499@romley-ivt3.sc.intel.com>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
 <20200408143552.57f5837c@jacob-builder>
 <20200408223218.GC11886@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408223218.GC11886@ziepe.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, linux-accelerators@lists.ozlabs.org
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

On Wed, Apr 08, 2020 at 07:32:18PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 08, 2020 at 02:35:52PM -0700, Jacob Pan wrote:
> > > On Wed, Apr 08, 2020 at 11:35:52AM -0700, Jacob Pan wrote:
> > > > Hi Jean,
> > > > 
> > > > On Wed,  8 Apr 2020 16:04:25 +0200
> > > > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> > > >   
> > > > > The IOMMU SVA API currently requires device drivers to implement
> > > > > an mm_exit() callback, which stops device jobs that do DMA. This
> > > > > function is called in the release() MMU notifier, when an address
> > > > > space that is shared with a device exits.
> > > > > 
> > > > > It has been noted several time during discussions about SVA that
> > > > > cancelling DMA jobs can be slow and complex, and doing it in the
> > > > > release() notifier might cause synchronization issues (patch 2 has
> > > > > more background). Device drivers must in any case call unbind() to
> > > > > remove their bond, after stopping DMA from a more favorable
> > > > > context (release of a file descriptor).
> > > > > 
> > > > > So after mm exits, rather than notifying device drivers, we can
> > > > > hold on to the PASID until unbind(), ask IOMMU drivers to
> > > > > silently abort DMA and Page Requests in the meantime. This change
> > > > > should relieve the mmput() path.  
> > > >
> > > > I assume mm is destroyed after all the FDs are closed  
> > > 
> > > FDs do not hold a mmget(), but they may hold a mmgrab(), ie anything
> > > using mmu_notifiers has to hold a grab until the notifier is
> > > destroyed, which is often triggered by FD close.
> > > 
> > Sorry, I don't get this. Are you saying we have to hold a mmgrab()
> > between svm_bind/mmu_notifier_register and
> > svm_unbind/mmu_notifier_unregister?
> 
> Yes. This is done automatically for the caller inside the mmu_notifier
> implementation. We now even store the mm_struct pointer inside the
> notifier.
> 
> Once a notifier is registered the mm_struct remains valid memory until
> the notifier is unregistered.
> 
> > Isn't the idea of mmu_notifier is to avoid holding the mm reference and
> > rely on the notifier to tell us when mm is going away?
> 
> The notifier only holds a mmgrab(), not a mmget() - this allows
> exit_mmap to proceed, but the mm_struct memory remains.
> 
> This is also probably why it is a bad idea to tie the lifetime of
> something like a pasid to the mmdrop as a evil user could cause a
> large number of mm structs to be released but not freed, probably
> defeating cgroup limits and so forth (not sure)

The max number of processes can be limited for a user. PASID is per
address space so the max number of PASID can be limited for the user.
So the user cannot exhaust PASID so easily, right?

Intel ENQCMD instruction uses PASID MSR to store the PASID. Each software
thread can store the PASID in its own MSR/fpu state.

If free PASID in unbind_mm(), the threads PASID MSRs need to be cleared
as well: tracking which thread has the MSR set up, searching the threads,
sending IPIs to the thread to clear the MSR, locking, etc. It's doable but
complex with low performance.

Binding the PASID to the mm and freeing the PASID in __mmdrop() can get
ride of the complexity.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
