Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD4BC2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:30:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40070206C0
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40070206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0D53B23236;
	Wed,  8 Apr 2020 21:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TT2xdK+-vWOM; Wed,  8 Apr 2020 21:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 269C11FFFE;
	Wed,  8 Apr 2020 21:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 099BEC1AE8;
	Wed,  8 Apr 2020 21:30:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC48DC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A688388092
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o4t-6ZgovVTL for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 21:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B305788086
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:30:01 +0000 (UTC)
IronPort-SDR: aHGnpZm6DCqBZaZenwcKExsK0Ed0dXxuvWlCansPS6pT1lbm9hoB94r5la0DsRSjsAkFLkVSBb
 7juhurSsCgEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2020 14:30:01 -0700
IronPort-SDR: 2V0cb7RmO3DTlRgo7BF7xQG4/mpn525QQN8NjKYK3V9ejBqmMe0l1LnbqiTJX0GDKdu1+VOpV5
 lw4lSEr3cNBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; d="scan'208";a="425277868"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 08 Apr 2020 14:30:00 -0700
Date: Wed, 8 Apr 2020 14:35:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200408143552.57f5837c@jacob-builder>
In-Reply-To: <20200408190226.GA11886@ziepe.ca>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408113552.7888bfee@jacob-builder>
 <20200408190226.GA11886@ziepe.ca>
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

Hi Jason,

Thanks for the explanation, more comments/questions inline.

On Wed, 8 Apr 2020 16:02:26 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Apr 08, 2020 at 11:35:52AM -0700, Jacob Pan wrote:
> > Hi Jean,
> > 
> > On Wed,  8 Apr 2020 16:04:25 +0200
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > The IOMMU SVA API currently requires device drivers to implement
> > > an mm_exit() callback, which stops device jobs that do DMA. This
> > > function is called in the release() MMU notifier, when an address
> > > space that is shared with a device exits.
> > > 
> > > It has been noted several time during discussions about SVA that
> > > cancelling DMA jobs can be slow and complex, and doing it in the
> > > release() notifier might cause synchronization issues (patch 2 has
> > > more background). Device drivers must in any case call unbind() to
> > > remove their bond, after stopping DMA from a more favorable
> > > context (release of a file descriptor).
> > > 
> > > So after mm exits, rather than notifying device drivers, we can
> > > hold on to the PASID until unbind(), ask IOMMU drivers to
> > > silently abort DMA and Page Requests in the meantime. This change
> > > should relieve the mmput() path.  
> >
> > I assume mm is destroyed after all the FDs are closed  
> 
> FDs do not hold a mmget(), but they may hold a mmgrab(), ie anything
> using mmu_notifiers has to hold a grab until the notifier is
> destroyed, which is often triggered by FD close.
> 
Sorry, I don't get this. Are you saying we have to hold a mmgrab()
between svm_bind/mmu_notifier_register and
svm_unbind/mmu_notifier_unregister?
Isn't the idea of mmu_notifier is to avoid holding the mm reference and
rely on the notifier to tell us when mm is going away?
It seems both Intel and AMD iommu drivers don't hold mmgrab after
mmu_notifier_register.

> So the exit_mmap() -> release() may happen before the FDs are
> destroyed, but the final mmdrop() will be during some FD release when
> the final mmdrop() happens.
> 
Do you mean mmdrop() is after FD release? If so, unbind is called in FD
release should take care of everything, i.e. stops DMA, clear PASID
context on IOMMU, flush PRS queue etc.

Enforcing unbind upon FD close might be a precarious path, perhaps that
is why we have to deal with out of order situation?

> But, in all the drivers I've looked at the PASID and the mmu_notifier
> must have identical lifetimes.
> 
> > In VT-d, because of enqcmd and lazy PASID free we plan to hold on
> > to the PASID until mmdrop.
> > https://lore.kernel.org/patchwork/patch/1217762/  
> 
> Why? The bind already gets a mmu_notifier which has refcounts and the
> right lifetime for PASID.. This code could already be simplified by
> using the mmu_notifier_get()/put() stuff.
> 
Yes, I guess mmu_notifier_get()/put() is new :)
+Fenghua

> A reason to store the PASID in the mm_struct would be if some code
> needs fast access to it, but then I'm not sure how that works with
> SVM_FLAG_PRIVATE_PASID ..
> 
We plan to remove this flag.

> Jason

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
