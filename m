Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB5C433FE
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 22:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E99E441D5D;
	Fri, 29 Apr 2022 22:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7LCK6p07j_VY; Fri, 29 Apr 2022 22:19:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C67D41D42;
	Fri, 29 Apr 2022 22:19:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B9CEC0039;
	Fri, 29 Apr 2022 22:19:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB9FEC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 22:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4B9440142
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 22:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ld87kfCbbD2 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 22:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2D5F4002B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651270750; x=1682806750;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aAa0fJ78qBc0C3dnZn0iaoTUqMqzLiZJoB88GhSk4m8=;
 b=LwORgXpE62oWeA/Q/XKZAW1SFFqgBKnjt9TDRlz3gaA44yZdF3qZ+kEQ
 g2GVulh25ufp6jzfLyuhE1AvoU+OwteMfpoAlamOl0Hb1uL6KcLTQlytx
 qhBeBMYyjRtfejE3+xZnRr6+ow3mjbPPYV4TpyZ66ja5rryWRxGgzTABA
 9LocB4qPy/AgKVDRx82nnTMHCmMeTQ3BedUbrNrVBzQVCS9BgP2u7T6Hp
 hqZog7n3wE6M5ADvNNmpJSPAnaOqwvetc8q8M3G63VQub9kNG/QueDlmy
 EmnIt9R8GTU/gHt+S3BptxJc8NvDddM3eyQeokbDFgUvG2KA0sG9wWMoA w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264370522"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; d="scan'208";a="264370522"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 15:19:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; d="scan'208";a="597551432"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 15:19:09 -0700
Date: Fri, 29 Apr 2022 15:19:39 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
References: <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com> <Ymv3fC4xXqe+oMRK@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ymv3fC4xXqe+oMRK@myrica>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 will@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com
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

Hi, Jean and Baolu,

On Fri, Apr 29, 2022 at 03:34:36PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Apr 29, 2022 at 06:51:17AM -0700, Fenghua Yu wrote:
> > Hi, Baolu,
> > 
> > On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
> > > On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> > > > > The address space is what the OOM killer is after.  That gets refcounted
> > > > > with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> > > > > page freeing done in __mmput()->exit_mmap().
> > > > > 
> > > > > Also, all the VMAs should be gone after exit_mmap().  So, even if
> > > > > vma->vm_file was holding a reference to a device driver, that reference
> > > > > should be gone by the time __mmdrop() is actually freeing the PASID.
> > > > 
> > > > I agree with all that. The concern was about tearing down the PASID in the
> > > > IOMMU and device from the release() MMU notifier, which would happen in
> > > > exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> > > > since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> > > > and unbind(), I think Fenghua's fix works.
> > > 
> > > But I didn't find mmgrab()/mmdrop() get called in both arm and intel
> > > IOMMU drivers.
> > > 
> > > $ git grep mmgrab drivers/iommu/
> > > [no output]
> > > 
> > > Do we need to add these in a separated fix patch, or I missed anything
> > > here?
> > 
> > On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
> > sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().
> 
> Yes, although for Arm I realized the mmu_notifier grab wasn't sufficient
> so I sent a separate fix that should go in 5.18 as well
> https://lore.kernel.org/linux-iommu/20220426130444.300556-1-jean-philippe@linaro.org/
> The Arm driver still touches the arch mm context after mmu_notifier_put().
> I don't think X86 has that problem.

I think so too. On X86, the mm is not used after mmu_notifier_unregister().

In case of supervisor mode SVM (i.e. svm is bound to init_mm), the code
is right too because init_mm and its PASID cannot be dropped and
mmu_notifier_register()/mmu_notifier_unregister() are not called.

So I think no extra fix patch is needed on X86.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
