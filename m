Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3561C433FE
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 22:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5695341956;
	Tue, 17 May 2022 22:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iJMcdIT6Kng3; Tue, 17 May 2022 22:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CF2B4182B;
	Tue, 17 May 2022 22:49:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32B4AC0039;
	Tue, 17 May 2022 22:49:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E1ABC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38337830A8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G2HJuQe4GF6u for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:49:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D45A83004
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652827767; x=1684363767;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eW9eeCQ/ZnkVlQzYhrGw1tL7ydi/5swHvLwwK3+msYw=;
 b=Jw7hZwxAwdHLKbRYWIIS0eCGAJEQKbbdPmLD7/YbId+GIoPScP0Rujr3
 jZaZK3COFb8ERX9oS486L0ptycsubVnpM25JHXxLnoBi7sxea9ZIh4TwE
 Fe3kvlVHoZ6GZOvkL1vfqKpF8kTUyYsdZIqwRlGQPBCHZ/SGRHE9YMu1m
 o5DPl+rHWlvneCCT/dH7hSz7iODgjEnf6pteB1LHHPBam+gvzFOY/rfNv
 vywOUYhCtma4nrNy4FXHJeL+80jk/UpygncDAkZVtGpAg0jVbt75pfKcV
 NKhWX1Lh+s0TOlQ8ZHyuDUqIhfsqwBecd55Jmu3VvYE1A75S3cB5XHw7f A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331980534"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="331980534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2022 15:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="626709312"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga008.fm.intel.com with ESMTP; 17 May 2022 15:49:25 -0700
Date: Tue, 17 May 2022 15:53:08 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
Message-ID: <20220517225308.GC6711@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
 <1652180070.1r874kr0tg.astroid@bobo.none> <87ilqdpq7u.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilqdpq7u.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Stephane Eranian <eranian@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, May 10, 2022 at 01:44:05PM +0200, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 21:16, Nicholas Piggin wrote:
> > Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> >> +	/*
> >> +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
> >> +	 * Reconfigure it to make use of the refined tsc_khz.
> >> +	 */
> >> +	lockup_detector_reconfigure();
> >
> > I don't know if the API is conceptually good.
> >
> > You change something that the lockup detector is currently using, 
> > *while* the detector is running asynchronously, and then reconfigure
> > it. What happens in the window? If this code is only used for small
> > adjustments maybe it does not really matter but in principle it's
> > a bad API to export.
> >
> > lockup_detector_reconfigure as an internal API is okay because it
> > reconfigures things while the watchdog is stopped [actually that
> > looks untrue for soft dog which uses watchdog_thresh in
> > is_softlockup(), but that should be fixed].
> >
> > You're the arch so you're allowed to stop the watchdog and configure
> > it, e.g., hardlockup_detector_perf_stop() is called in arch/.
> >
> > So you want to disable HPET watchdog if it was enabled, then update
> > wherever you're using tsc_khz, then re-enable.
> 
> The real question is whether making this refined tsc_khz value
> immediately effective matters at all. IMO, it does not because up to
> that point the watchdog was happily using the coarse calibrated value
> and the whole use TSC to assess whether the HPET fired mechanism is just
> a guestimate anyway. So what's the point of trying to guess 'more
> correct'.

In some of my test systems I observed that, the TSC value does not fall
within the expected error window the first time the HPET channel expires.

I inferred that the error computed using the coarser tsc_khz was wrong.
Recalculating the error window with refined tsc_khz would correct it.

However, restarting the timer has the side-effect of kicking the timer and,
therefore pushing the first HPET NMI further in the future.

Perhaps kicking HPET channel, not recomputing the error window, corrected
(masked?) the problem.

I will investigate further and rework or drop this patch as needed.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
