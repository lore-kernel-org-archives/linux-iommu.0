Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8F4C433F5
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 18:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23C7682AEF;
	Thu, 10 Feb 2022 18:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SzjjJqyVJ5MV; Thu, 10 Feb 2022 18:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E347F827BB;
	Thu, 10 Feb 2022 18:31:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1FAAC0011;
	Thu, 10 Feb 2022 18:31:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7394CC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5360560ADC
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ULFlB4Mk5LKE for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 18:31:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9487760757
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644517904; x=1676053904;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FlFaC+FPw/XthIPB5ReSE0a0cEsKH2AB9QD90on8UY8=;
 b=Bs3oGDVnaJW2Fcb5EQ9xVS4mrsi4eVCR67zfq4uf8SjVrq+rNYD8QPkS
 2a0CoCBqvdxNQEG8+NofmoGuEKMMnYQ3Koha5n4GHqNYLVIa/kPbkGtbA
 dMHzr8gCOhc7i7O8rLHtJctGB9a2zE6YlIo8LKVY+WRsbU7s3HnyYlBEm
 cXFV48hQksSsegOhbEvyUvNiRC9MweFFClfgjUrPwIYkMraxHsPc3BGKR
 OKJloVFKQrkM5NwYcCSdRnKg1puL/mS01F45ywEOvjNiF/2mNZnTO/Xzd
 wBw99WBsNegyL3Z8/prWjTCxbvK9FuzK0TPkR1PBpFi/bv78mtyOWONyn Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249312096"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="249312096"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 10:31:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="541737864"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 10:31:40 -0800
Date: Thu, 10 Feb 2022 10:31:35 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgVaB2kcqeGL+/Or@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
 <YgU9Bsq8a2NWzBvE@otcwcpicx3.sc.intel.com>
 <YgVKYgby67brla9Z@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgVKYgby67brla9Z@agluck-desk3.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

Hi, Tony,

On Thu, Feb 10, 2022 at 09:24:50AM -0800, Luck, Tony wrote:
> On Thu, Feb 10, 2022 at 08:27:50AM -0800, Fenghua Yu wrote:
> > Hi, Jacob,
> > 
> > On Wed, Feb 09, 2022 at 07:16:14PM -0800, Jacob Pan wrote:
> > > Hi Fenghua,
> > > 
> > > On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > 
> > > > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > > > *dev, struct mm_struct *mm, void }
> > > >  
> > > >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > > > -	if (IS_ERR_OR_NULL(sva))
> > > > -		intel_svm_free_pasid(mm);
> > > If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
> > > free here.
> > 
> > The PASID can not be freed even if bind fails. The PASID allocated earlier
> > (either in this thread or in another thread) might be populated to other
> > threads already and being used now.
> > 
> > Without freeing the PASID on bind failure, the worst case is the PASID might
> > not be used in the process (and will be freed on process exit anyway).
> > 
> > This all matches with the PASID life time described in the commit message.
> 
> But what does this mean for the user that failed that intel_svm_bind_mm()?
> 

That means the user may have a PASID but there is no PASID entry for the
device. Then ENQCMD cannot be executed successfully.

> Here's a scenario:
> 
> Process sets up to use PASID capable device #1. Everything works,
> so the process has mm->pasid, and the IOMMU has the tables to map
> virtual addresses coming from device #1 using that PASID.
> 
> Now the same process asks to start using PASID capable device #2,
> but there is a failure at intel_svm_bind_mm().
> 
> Fenghua is right that we shouldn't free the PASID. It is in use
> by at least one thread of the process to access device #1.
> 
> But what happens with device #2? Does the caller of intel_svm_bind()
> do the right thing with the IS_ERR_OR_NULL return value to let the
> user know that device #2 isn't accessible?

A driver caller of intel_svm_bind() should handle this failure, i.e. fail
the binding and let the user know the failure.

Even if the driver doesn't do the right thing to handle the failure,
intel_svm_bind() doesn't set up a PASID entry for device #2.

One example is IDXD driver. User calls open()->IDXD driver idxd_cdev_open()
->intel_svm_bind()->intel_svm_bind_mm(). idxd_cdev_open() gets failed "sva"
and passes the PTR_ERR(sva) to the user and the user cannot open the device.
Due to the failure, no PASID entry is set up for the device.

Even if the user ignores the open() failure and tries to run ENQCMD on
device #2, a PASID table fault will be generated due to no PASID entry
for the device and the ENQCMD execution will fail.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
