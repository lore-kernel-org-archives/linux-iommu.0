Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626BDC433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 16:12:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF5E6124C
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 16:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CF5E6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1C2440764;
	Fri, 24 Sep 2021 16:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAQMhGsw2lHc; Fri, 24 Sep 2021 16:12:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 42E4140760;
	Fri, 24 Sep 2021 16:12:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF52C0011;
	Fri, 24 Sep 2021 16:12:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB4DC000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 16:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51CC3840F7
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 16:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0FrNTLiurICd for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 16:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 889D8840E2
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 16:12:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211182491"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="211182491"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 09:12:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="559675914"
Received: from agluck-desk2.sc.intel.com (HELO
 agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 09:12:08 -0700
Date: Fri, 24 Sep 2021 09:12:07 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k0j6dsdn.ffs@tglx>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

It would be possible to avoid a per-task reference to the PASID by
taking an extra reference when mm->pasid is first allocated using
the CONFIG_PASID_TASK_REFS you proposed yesterday to define a function
to take the extra reference, and another to drop it when the mm is
finally freed ... with stubs to do nothing on architectures that
don't create per-task PASID context.

This solution works, but is functionally different from Fenghua's
proposal for this case:

	Process clones a task
	task binds a device
	task accesses device using PASID
	task unbinds device
	task exits (but process lives on)

Fenghua will free the PASID because the reference count goes
back to zero. The "take an extra reference and keep until the
mm is freed" option would needlessly hold onto the PASID.

This seems like an odd usage case ... even if it does exist, a process
that does this may spawn another task that does the same thing.

If you think it is sufficiently simpler to use the "extra reference"
option (invoking the "perfect is the enemy of good enough" rule) then we
can change.

-Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
