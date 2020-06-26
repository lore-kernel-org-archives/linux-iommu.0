Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F59C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 18:35:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDD6206B7
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 18:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDD6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED9B087EB1;
	Fri, 26 Jun 2020 18:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrS2uQj4I-Xu; Fri, 26 Jun 2020 18:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B11887E59;
	Fri, 26 Jun 2020 18:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E17D4C0863;
	Fri, 26 Jun 2020 18:35:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC41C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 639E086C11
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dqFGPnMW0qKi for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 18:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6BAA386B8E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:35:10 +0000 (UTC)
IronPort-SDR: +s3oRioaRX4qEh99v+/PUSfW7Hl06IUb8OHXWZEjel7aqC51bBXP7oij8BgzosqUvfjVmP/rq/
 IeRraMV291Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="133810385"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; d="scan'208";a="133810385"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 11:35:09 -0700
IronPort-SDR: uvkTFVZRaS6JS8v8WDYQ5dmIl4d3QnNTjBf7VV/f4oh3VKY3z0ElanX0EujJhiVTgnod+lcir8
 kslSIWX+t6Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; d="scan'208";a="354849489"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga001.jf.intel.com with ESMTP; 26 Jun 2020 11:35:07 -0700
Date: Fri, 26 Jun 2020 11:35:07 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200626183506.GB32961@romley-ivt3.sc.intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
 <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
 <20200626181000.GA22833@agluck-desk2.amr.corp.intel.com>
 <aa3d7b7c-d6aa-06b4-30f7-0e90af50a1f3@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa3d7b7c-d6aa-06b4-30f7-0e90af50a1f3@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Luck,
 Tony" <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Christoph Hellwig <hch@infradeed.org>, Thomas Gleixner <tglx@linutronix.de>,
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

Hi, Dave,

On Fri, Jun 26, 2020 at 11:23:12AM -0700, Dave Hansen wrote:
> On 6/26/20 11:10 AM, Luck, Tony wrote:
> > On Fri, Jun 26, 2020 at 11:44:50AM +0200, Peter Zijlstra wrote:
> >> On Thu, Jun 25, 2020 at 01:17:22PM -0700, Fenghua Yu wrote:
> >>
> >>> +static bool fixup_pasid_exception(void)
> >>> +{
> >>> +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> >>> +		return false;
> >>> +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> >>> +		return false;
> >>
> >> elsewhere you had another variation:
> >>
> >> +       if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> >> +               return;
> >> +
> >> +       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> >> +               return;
> >>
> >> Which is it, and why do we need the CONFIG thing when combined with the
> >> enabled thing?
> > 
> > Do we have a standard way of coding for a feature that depends on multiple
> > other features?  For this case the system needs to both suport the ENQCMD
> > instruction, and also have kernel code that programs the IOMMU.
> 
> Not really a standard one.
> 
> We could setup_clear_cpu_cap(X86_FEATURE_ENQCMD) during boot if we see
> that CONFIG_INTEL_IOMMU_SVM=n or if we don't have a detected IOMMU.
> That would at least get static value patching which would make some of
> the feature checks very cheap.
> 
> That means we can't use ENQCMD at all in the kernel, though.  Is that an
> issue?  Is the CPU feature truly dependent on IOMMU_SVM?

ENQCMD instruction needs bind_mm()/unbind_mm() defined in svm.c
which is only compiled by:
obj-$(CONFIG_INTEL_IOMMU_SVM) += intel/svm.o

So I think ENQCMD instruction is truly dependent on CONFIG_INTEL_IOMMU_SVM.

> 
> > And/or guidance on when to use each of the very somewhat simlar looking
> > 	boot_cpu_has()
> > 	static_cpu_has()
> > 	IS_ENABLED()
> > 	cpu_feature_enabled(X86_FEATURE_ENQCMD)
> > options?
> 
> cpu_feature_enabled() is by go-to for checking X86_FEATUREs.  It has
> compile-time checking along with static checking.
> 
> If you use cpu_feature_enabled(), and we added:
> 
> #ifdef CONFIG_INTEL_IOMMU_SVM
> # define DISABLE_ENQCMD         0
> #else
> # define DISABLE_ENQCMD           (1 << (X86_FEATURE_ENQCMD & <bitval>))
> #endif
> 
> to arch/x86/include/asm/disabled-features.h, then we could check only
> X86_FEATURE_ENQCMD, and we'd get that IS_ENABLED() check for "free".

This makes code simpler and cleaner.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
