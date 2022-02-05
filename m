Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9B9C433EF
	for <iommu@archiver.kernel.org>; Sat,  5 Feb 2022 00:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10A178291D;
	Sat,  5 Feb 2022 00:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDTLToggn2Ej; Sat,  5 Feb 2022 00:33:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B0600827A8;
	Sat,  5 Feb 2022 00:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792DCC001A;
	Sat,  5 Feb 2022 00:33:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC7EEC000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3AA860E81
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r5ujyHTcq8Mz for <iommu@lists.linux-foundation.org>;
 Sat,  5 Feb 2022 00:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0514760E80
 for <iommu@lists.linux-foundation.org>; Sat,  5 Feb 2022 00:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644021197; x=1675557197;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aJYy2vf0HRnoLnCXkWAcUv8uWypmISO27TeIxy+WR4A=;
 b=fBSjWmqVzJgtaTfDzcYbje8E59t+kR3Z2NgvCZzHuDxjXkoiDluF7OjS
 9F6wMLPl5LrSwbxdROLLBwsaPkjlYsHQ5AfCvw9gpN0WOy874q0KmuafW
 RM6p4qLmgJ+UzX0y84HoOTR0f6/6hpJa2xrNzew4JL3MCUabHU+7wLr3A
 DNEivMyE9cD2j4FJIGNu6vQwFL/9PGhdCITP0WrRfm71jGZBUuAGSqAd4
 UJ+z9tZQeRjVdwrU0ox+o99pHKKkw0yxVHJIrC+YsWfBYpIwC43Bl1OAD
 Ds+xeMbUScnWOTr28ixAK08nc5irCHW29y2V3sbLRzyJ2wkZO4lh3ad2x g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="229118551"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="229118551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 16:33:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; d="scan'208";a="535684857"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2022 16:33:17 -0800
Date: Fri, 4 Feb 2022 16:33:16 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Yf3FzOUSRpFUdM/q@otcwcpicx3.sc.intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
 <87r18ib2zz.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r18ib2zz.ffs@tglx>
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

On Sat, Feb 05, 2022 at 12:56:00AM +0100, Thomas Gleixner wrote:
> On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> > To avoid complexity of updating each thread's PASID status (e.g. sending
> > IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> > allocated and assigned to an mm, the PASID stays with the mm for the
> > rest of the mm's lifetime. A reference to the PASID is taken on
> > allocating the PASID. Binding/unbinding the PASID won't change refcount.
> > The reference is dropped on mm exit and thus the PASID is freed.
> >
> > Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> > the PASID operations handle the pasid member in mm_struct and should be
> > part of mm operations. Because IOASID's reference count is not used any
> > more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> > are deleted and ioasid_put() is renamed to ioasid_free().
> >
> > 20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
> > With cgroups and other controls that might limit the number of process
> > creation, the limited number of PASIDs is not a realistic issue for
> > lazy PASID free.
> 
> Please take a step back and think hard about it whether that changelog
> makes sense to you a year from now.
> 
> Let me walk you through:
> 
> > To avoid complexity of updating each thread's PASID status (e.g. sending
> > IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> > allocated and assigned to an mm, the PASID stays with the mm for the
> > rest of the mm's lifetime.
> 
> You are missing the oportunity to tell a story about the history of this
> decision here:
> 
>   PASIDs are process wide. It was attempted to use refcounted PASIDs to
>   free them when the last thread drops the refcount. This turned out to
>   be complex and error prone. Given the fact that the PASID space is 20
>   bits, which allows up to 1M processes to have a PASID associated
>   concurrently, PASID resource exhaustion is not a realistic concern.
> 
>   Therefore it was decided to simplify the approach and stick with lazy
>   on demand PASID allocation, but drop the eager free approach and make
>   a allocated PASID lifetime bound to the life time of the process.
> 
> > A reference to the PASID is taken on allocating the
> > PASID. Binding/unbinding the PASID won't change refcount.  The
> > reference is dropped on mm exit and thus the PASID is freed.
> 
> There is no refcount in play anymore, right? So how does this part of
> the changelog make any sense?
> 
> This is followed by:
> 
> > Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> > the PASID operations handle the pasid member in mm_struct and should be
> > part of mm operations. Because IOASID's reference count is not used any
> > more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> > are deleted and ioasid_put() is renamed to ioasid_free().
> 
> which does not provide much rationale and just blurbs about _what_ the
> patch is doing and not about the why and the connection to the
> above. And the refcount removal section contradicts the stale text
> above.
> 
> So this paragraph should be something like this:
> 
>   Get rid of the refcounting mechanisms and replace/rename the
>   interfaces to reflect this new approach.
> 
> Hmm?

Sure. I will update the commit message with your comments.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
