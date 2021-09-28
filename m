Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C5C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 16:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0660A61058
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 16:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0660A61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD81A40204;
	Tue, 28 Sep 2021 16:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DFQFEiTfJDm; Tue, 28 Sep 2021 16:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1731C40105;
	Tue, 28 Sep 2021 16:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB54EC0011;
	Tue, 28 Sep 2021 16:36:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72A29C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 16:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59246401CA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 16:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id otz7HGgRFI-D for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 16:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D562240105
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 16:36:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="221547358"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; d="scan'208";a="221547358"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 09:36:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; d="scan'208";a="554132908"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 09:36:30 -0700
Date: Tue, 28 Sep 2021 16:36:25 +0000
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVNEiUMUTQezzH6f@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-6-fenghua.yu@intel.com>
 <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
 <YU34+1J4v0cn9ZRs@otcwcpicx3.sc.intel.com> <87mto0ckpd.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mto0ckpd.ffs@tglx>
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

On Sun, Sep 26, 2021 at 01:13:50AM +0200, Thomas Gleixner wrote:
> Fenghua,
> 
> On Fri, Sep 24 2021 at 16:12, Fenghua Yu wrote:
> > On Fri, Sep 24, 2021 at 03:18:12PM +0200, Thomas Gleixner wrote:
> >> But OTOH why do you need a per task reference count on the PASID at all?
> >> 
> >> The PASID is fundamentaly tied to the mm and the mm can't go away before
> >> the threads have gone away unless this magically changed after I checked
> >> that ~20 years ago.
> >
> > There are up to 1M PASIDs because PASID is 20-bit. I think there are a few ways
> > to allocate and free PASID:
> >
> > 1. Statically allocate a PASID once a mm is created and free it in mm
> >    exit. No PASID allocation/free during the mm's lifetime. Then
> >    up to 1M processes can be created due to 1M PASIDs limitation.
> >    We don't want this method because the 1M processes limitation.
> 
> I'm not so worried about the 1M limitation, but it obviously makes sense
> to avoid that because allocating stuff which is not used is pointless in
> general.
> 
> > 2. A PASID is allocated to the mm in open(dev)->bind(dev, mm). There
> >    are three ways to free it:
> >    (a) Actively free it in close(fd)->unbind(dev, mm) by sending
> >        IPIs to tell all tasks using the PASID to clear the IA32_PASID
> >        MSR. This has locking issues similar to the actively loading
> >        IA32_PASID MSR which was force disabled in upstream. So won't work.
> 
> Exactly.
> 
> >    (b) Passively free the PASID in destroy_context(mm) in mm exit. Once
> >        the PASID is allocated, it stays with the process for the lifetime. It's
> >        better than #1 because the PASID is allocated only on demand.
> 
> Which is simple and makes a lot of sense. See below.
> 
> >    (c) Passively free the PASID in deactive_mm(mm) or unbind() whenever there
> >        is no usage as implemented in this series. Tracking the PASID usage
> >        per task provides a chance to free the PASID on task exit. The
> >        PASID has a better chance to be freed earlier than mm exit in #(b).
> >
> > This series uses #2 and #(c) to allocate and free the PASID for a better
> > chance to ease the 1M PASIDs limitation pressure. For example, a thread
> > doing open(dev)->ENQCMD->close(fd)->exit(2) will not occupy a PASID while
> > its sibling threads are still running.
> 
> I'm not seeing that as a realistic problem. Applications which use this
> kind of devices are unlikely to behave exactly that way.
> 
> 2^20 PASIDs are really plenty and just adding code for the theoretical
> case of PASID pressure is a pointless exercise IMO. It just adds
> complexity for no reason.
> 
> IMO reality will be that either you have long lived processes with tons
> of threads which use such devices over and over or short lived forked
> processes which open the device, do the job, close and exit. Both
> scenarios are fine with allocate on first use and drop on process exit.
> 
> I think with your approach you create overhead for applications which
> use thread pools where the threads get work thrown at them and do open()
> -> do_stuff() -> close() and then go back to wait for the next job which
> will do exactly the same thing. So you add the overhead of refcounts in
> general and in the worst case if the refcount drops to zero then the
> next worker has to allocate a new PASID instead of just moving on.
> 
> So unless you have a really compelling real world usecase argument, I'm
> arguing that the PASID pressure problem is a purely academic exercise.
> 
> I think you are conflating two things here:
> 
>   1) PASID lifetime
>   2) PASID MSR overhead
> 
> Which is not correct: You still can and have to optimize the per thread
> behaviour vs. the PASID MSR: Track per thread whether it ever needed the
> PASID and act upon that.
> 
> If the thread just does EMQCMD once in it's lifetime, then so be
> it. That's not a realistic use case, really.
> 
> And if someone does this then this does not mean we have to optimize for
> that. Optimizing for possible stupid implementations is the wrong
> approach. There is no technial measure against stupidity. If that would
> exist the world would be a much better place.
> 
> You really have to think about the problem space you are working
> on. There are problems which need a 'get it right at the first shot'
> solution because they create user space ABI or otheer hard to fix
> dependencies.
> 
> That's absolutely not the case here.
> 
> Get the basic simple support correct and work from there. Trying to
> solve all possible theoretical problems upfront is simply not possible
> and a guarantee for not making progress.
> 
> "Keep it simple" and "correctness first" are still the best working
> engineering principles.
> 
> They do not prevent us from revisiting this _if_ there is a real world
> problem which makes enough sense to implement a finer grained solution.

Sure. Will free the PASID in destroy_context() on mm exit and won't track
the PASID usage per task. The code will be simpler and clearer.

Thank you very much for your insight!

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
