Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B4C433F5
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 00:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E353940961;
	Sat,  5 Feb 2022 00:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GuoRn8-N2CZ; Sat,  5 Feb 2022 00:25:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C01A8408DC;
	Sat,  5 Feb 2022 00:25:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F1DC001A;
	Sat,  5 Feb 2022 00:25:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74FA0C000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F67C40912
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rI_NDcPgPXvO for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 00:25:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88DFD408DC
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644020742; x=1675556742;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=seqp1K4lOkMWSGy1QhjFDo6IEhqcwqjPfzMecDFWN9w=;
 b=ZFwLYyvxCzmk5Nrjx85Sj6V0uKDqIPO2daFfUMW+Vew/+/izlEvxpvOA
 wmOb61KGsutm3y0sMHYn4YA+E2sLZWaT3oiJwnTyedGvv2EvcfLLfTp10
 juvh/adooxISGZkZtIM1ngUfFzsUZboSarIndRGvHLSgluVJ7o++Nm1ar
 f5QrTLzjOlYqihUbK1lqLDUYNOoxcmZQQqBERSZ6oytVqyD/08OIWN56X
 urIPcMpR6hyqPADw1T+CZ4syZLaCiZDEamcsgVQNA+oUaZ7mh4/mGkYLR
 HEIHyONZZLLcLN2VW2w+xJvzkNhGxkpToT3rfPhDZcL/gP/AClZklti4B Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="232034579"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="232034579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 16:25:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="539361229"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 16:25:41 -0800
Date: Fri, 4 Feb 2022 16:25:34 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 04/11] kernel/fork: Initialize mm's PASID
Message-ID: <Yf3D/ij6S8AbMwpF@otcwcpicx3.sc.intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-5-fenghua.yu@intel.com>
 <87wniab4kb.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wniab4kb.ffs@tglx>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
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

Hi, Thomas,

On Sat, Feb 05, 2022 at 12:22:12AM +0100, Thomas Gleixner wrote:
> On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> > A new mm doesn't have a PASID yet when it's created. Initialize
> > the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).
> 
> I must be missing something here.
> 
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index aa5f09ca5bcf..c74d1edbac2f 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/mm_types.h>
> >  #include <linux/gfp.h>
> >  #include <linux/sync_core.h>
> > +#include <linux/ioasid.h>
> >  
> >  /*
> >   * Routines for handling mm_structs
> > @@ -433,4 +434,13 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_IOMMU_SVA
> > +static inline void mm_pasid_init(struct mm_struct *mm)
> > +{
> > +	mm->pasid = INVALID_IOASID;
> > +}
> > +#else
> > +static inline void mm_pasid_init(struct mm_struct *mm) {}
> > +#endif
> > +
> >  #endif /* _LINUX_SCHED_MM_H */
> 
> So this adds mm_pasid_init() to linux/sched/mm.h which replaces:
> 
> > -static void mm_init_pasid(struct mm_struct *mm)
> > -{
> > -#ifdef CONFIG_IOMMU_SVA
> > -	mm->pasid = INIT_PASID;
> > -#endif
> > -}
> > -
> 
> I.e. already existing code which is initializing mm->pasid with
> INIT_PASID (0) while the replacement initializes it with INVALID_IOASID
> (-1).
> 
> The change log does not have any information about why INIT_PASID is the
> wrong initialization value and why this change is not having any side
> effects.

I should add the following info in the commit message to explain why
change INIT_PASID (0) to INVALID_IOASID (-1):

INIT_PASID (0) is reserved for kernel legacy DMA PASID. It cannot be
allocated to a user process. Initialize the process's PASID to 0 may
cause confusion that why the process uses reserved kernel legacy DMA
PASID. Initializing the PASID to INVALID_IOASID (-1) explicitly
tells the process doesn't have a valid PASID yet initially.

Is it OK for you?

> 
> It neither mentions why having this in a global available header makes
> sense when the only call site is in the C file from which the already
> existing function is removed.

This series defines three helpers mm_pasid_init(), mm_pasid_set(), and
mm_pasid_drop() in mm because they handle the pasid member in mm_struct
and should be part of mm operations. I explained why mm_pasid_set() and
mm_pasid_drop() are defined in mm, but I didn't explain why mm_pasid_init()
is define in mm.

Is it OK to add the following explanation on why mm_pasid_init() is defined?

mm_pasid_init() is defined in mm and replaces mm_init_pasid() because
the PASID init operation initializes the pasid member in mm_struct and
should be part of mm operations.

Thanks,

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
