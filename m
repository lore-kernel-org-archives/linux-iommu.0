Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7EBC433FE
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 16:12:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E6061242
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 16:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6E6061242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFDEE421DC;
	Fri, 24 Sep 2021 16:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n9QaQJ2Jf-rz; Fri, 24 Sep 2021 16:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80381421D7;
	Fri, 24 Sep 2021 16:12:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5957AC0011;
	Fri, 24 Sep 2021 16:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7518AC000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 16:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57F8E421D7
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 16:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6u_xYSOwn4QD for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 16:12:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACD94421D2
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 16:12:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="224153109"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="224153109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 09:12:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="559676132"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 09:12:49 -0700
Date: Fri, 24 Sep 2021 16:12:43 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YU34+1J4v0cn9ZRs@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0j6dsdn.ffs@tglx>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, "Luck,
 Tony" <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
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

On Fri, Sep 24, 2021 at 03:18:12PM +0200, Thomas Gleixner wrote:
> On Thu, Sep 23 2021 at 19:48, Thomas Gleixner wrote:
> > On Thu, Sep 23 2021 at 09:40, Tony Luck wrote:
> >
> > fpu_write_task_pasid() can just grab the pasid from current->mm->pasid
> > and be done with it.
> >
> > The task exit code can just call iommu_pasid_put_task_ref() from the
> > generic code and not from within x86.
> 
> But OTOH why do you need a per task reference count on the PASID at all?
> 
> The PASID is fundamentaly tied to the mm and the mm can't go away before
> the threads have gone away unless this magically changed after I checked
> that ~20 years ago.

There are up to 1M PASIDs because PASID is 20-bit. I think there are a few ways
to allocate and free PASID:

1. Statically allocate a PASID once a mm is created and free it in mm
   exit. No PASID allocation/free during the mm's lifetime. Then
   up to 1M processes can be created due to 1M PASIDs limitation.
   We don't want this method because the 1M processes limitation.

2. A PASID is allocated to the mm in open(dev)->bind(dev, mm). There
   are three ways to free it:
   (a) Actively free it in close(fd)->unbind(dev, mm) by sending
       IPIs to tell all tasks using the PASID to clear the IA32_PASID
       MSR. This has locking issues similar to the actively loading
       IA32_PASID MSR which was force disabled in upstream. So won't work.
   (b) Passively free the PASID in destroy_context(mm) in mm exit. Once
       the PASID is allocated, it stays with the process for the lifetime. It's
       better than #1 because the PASID is allocated only on demand.
   (c) Passively free the PASID in deactive_mm(mm) or unbind() whenever there
       is no usage as implemented in this series. Tracking the PASID usage
       per task provides a chance to free the PASID on task exit. The
       PASID has a better chance to be freed earlier than mm exit in #(b).

This series uses #2 and #(c) to allocate and free the PASID for a better
chance to ease the 1M PASIDs limitation pressure. For example, a thread
doing open(dev)->ENQCMD->close(fd)->exit(2) will not occupy a PASID while
its sibling threads are still running.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
