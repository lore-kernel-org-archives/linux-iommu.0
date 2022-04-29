Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA5C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 13:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 946E48405E;
	Fri, 29 Apr 2022 13:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id joTOdG4DSvjl; Fri, 29 Apr 2022 13:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7048C84062;
	Fri, 29 Apr 2022 13:50:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16FABC0032;
	Fri, 29 Apr 2022 13:50:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4166FC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 13:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AE1E84064
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 13:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bU9GKfj-zuLf for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 13:50:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 723058405E
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651240252; x=1682776252;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=I1IC3ER1bbr2Gmvx8B3VxE2I1iNqvQIOt1Apf8a8gjM=;
 b=DOGVGLmbcqrBzMT8MzV2vDlTzHLZwZHoFxKGG78rwPP1ra6cZhdJGFru
 RaSCNzA/NqfOrT315y3NqSyxv/tTACah7FXFIXbi3O2AfPnU+PadRvf3H
 0IDitNDt+lzj62FvuKno7x3yGnwsuWVoNkI2TrKleh3si0COgDrgk9+gI
 WMgnhrE7CTU/hT098cwekKF5H4yMs3yXki7Kza1AQcR9e0ArRo3eq36mu
 IssVdFbVA9UrypfcAjVXyv0EI424ljfGhBS2YCEE4eEyiWYmoE8GEqlBC
 vJeiodZ1dWhM9U7bfh9sLigqPCVN7NI6G+SKzX9txVvf6oPIIMbZabw9T Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="327144229"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; d="scan'208";a="327144229"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 06:50:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; d="scan'208";a="560349710"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2022 06:50:47 -0700
Date: Fri, 29 Apr 2022 06:51:17 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
References: <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

Hi, Baolu,

On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
> On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> > > The address space is what the OOM killer is after.  That gets refcounted
> > > with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> > > page freeing done in __mmput()->exit_mmap().
> > > 
> > > Also, all the VMAs should be gone after exit_mmap().  So, even if
> > > vma->vm_file was holding a reference to a device driver, that reference
> > > should be gone by the time __mmdrop() is actually freeing the PASID.
> > 
> > I agree with all that. The concern was about tearing down the PASID in the
> > IOMMU and device from the release() MMU notifier, which would happen in
> > exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> > since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> > and unbind(), I think Fenghua's fix works.
> 
> But I didn't find mmgrab()/mmdrop() get called in both arm and intel
> IOMMU drivers.
> 
> $ git grep mmgrab drivers/iommu/
> [no output]
> 
> Do we need to add these in a separated fix patch, or I missed anything
> here?

On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().

So mm->mm_count are already counted in existing ARM and X86 binding and
unbinding. The fix patch just frees the PASID in __mmdrop() after
no more mm->mm_count.

There is no need to add extra  mmgrab() and mmdrop() pair.

Thanks.

-Fenghua

 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
