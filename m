Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4599CC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 03:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6E0A4093E;
	Tue, 17 May 2022 03:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5q0l2_ATQIDS; Tue, 17 May 2022 03:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 522FE410C8;
	Tue, 17 May 2022 03:05:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3936EC0032;
	Tue, 17 May 2022 03:05:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18F28C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 03:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED2F940B95
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 03:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gRn6EMAvs6AW for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 03:05:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24F5C40408
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 03:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652756755; x=1684292755;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1eXK/Lt9/M/kHEgyQGFmbYTuXrCc0mJ/GpdZrACprGU=;
 b=LrNptuU15gmMN2Xl3jCq8LOjZdqZC7drZVVU7uKZ56vPVS6w4p71vS8E
 EQu1F/YNjNC6ecq4l0UhrQXju3nSFXtPzSA7LmRIOoaGZutyWACGVlsY7
 nW6HIuvvOkJoLpIBooYqz6Rqxw1NEp+ij/A/nh/YDDfge893cRc3TZ35I
 WpO/39GqG2DTvCnkCNxJT73RVKtqa/4ZKCgCjaZiHmVMHPsKqGBwslEH4
 T8mlIoaqox7/BRHX+Upd6Jl9HgnjaZ6WigPeqGjCJ9RDaMP90F5C3GLUo
 OlMivZ0YdqOgskzdmyjJZfr6cCn3dk355+mpnTBuj1l09dZGPrqib9QB9 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="334080353"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="334080353"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 20:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="660399844"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by FMSMGA003.fm.intel.com with ESMTP; 16 May 2022 20:05:54 -0700
Date: Mon, 16 May 2022 20:09:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 29/29] x86/tsc: Switch to perf-based hardlockup
 detector if TSC become unstable
Message-ID: <20220517030935.GA2678@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-30-ricardo.neri-calderon@linux.intel.com>
 <1652184158.yhzceh3nwk.astroid@bobo.none>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1652184158.yhzceh3nwk.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Tue, May 10, 2022 at 10:14:00PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> > The HPET-based hardlockup detector relies on the TSC to determine if an
> > observed NMI interrupt was originated by HPET timer. Hence, this detector
> > can no longer be used with an unstable TSC.
> > 
> > In such case, permanently stop the HPET-based hardlockup detector and
> > start the perf-based detector.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: x86@kernel.org
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v5:
> >  * Relocated the delcaration of hardlockup_detector_switch_to_perf() to
> >    x86/nmi.h It does not depend on HPET.
> >  * Removed function stub. The shim hardlockup detector is always for x86.
> > 
> > Changes since v4:
> >  * Added a stub version of hardlockup_detector_switch_to_perf() for
> >    !CONFIG_HPET_TIMER. (lkp)
> >  * Reconfigure the whole lockup detector instead of unconditionally
> >    starting the perf-based hardlockup detector.
> > 
> > Changes since v3:
> >  * None
> > 
> > Changes since v2:
> >  * Introduced this patch.
> > 
> > Changes since v1:
> >  * N/A
> > ---
> >  arch/x86/include/asm/nmi.h     | 6 ++++++
> >  arch/x86/kernel/tsc.c          | 2 ++
> >  arch/x86/kernel/watchdog_hld.c | 6 ++++++
> >  3 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
> > index 4a0d5b562c91..47752ff67d8b 100644
> > --- a/arch/x86/include/asm/nmi.h
> > +++ b/arch/x86/include/asm/nmi.h
> > @@ -63,4 +63,10 @@ void stop_nmi(void);
> >  void restart_nmi(void);
> >  void local_touch_nmi(void);
> >  
> > +#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR
> > +void hardlockup_detector_switch_to_perf(void);
> > +#else
> > +static inline void hardlockup_detector_switch_to_perf(void) { }
> > +#endif
> > +
> >  #endif /* _ASM_X86_NMI_H */
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cc1843044d88..74772ffc79d1 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1176,6 +1176,8 @@ void mark_tsc_unstable(char *reason)
> >  
> >  	clocksource_mark_unstable(&clocksource_tsc_early);
> >  	clocksource_mark_unstable(&clocksource_tsc);
> > +
> > +	hardlockup_detector_switch_to_perf();
> >  }
> >  
> >  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> > diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
> > index ef11f0af4ef5..7940977c6312 100644
> > --- a/arch/x86/kernel/watchdog_hld.c
> > +++ b/arch/x86/kernel/watchdog_hld.c
> > @@ -83,3 +83,9 @@ void watchdog_nmi_start(void)
> >  	if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
> >  		hardlockup_detector_hpet_start();
> >  }
> > +
> > +void hardlockup_detector_switch_to_perf(void)
> > +{
> > +	detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
> 
> Another possible problem along the same lines here,
> isn't your watchdog still running at this point? And
> it uses detector_type in the switch.
> 
> > +	lockup_detector_reconfigure();
> 
> Actually the detector_type switch is used in some
> functions called by lockup_detector_reconfigure()
> e.g., watchdog_nmi_stop, so this seems buggy even
> without concurrent watchdog.

Yes, this true. I missed this race.

> 
> Is this switching a good idea in general? The admin
> has asked for non-standard option because they want
> more PMU counterss available and now it eats a
> counter potentially causing a problem rather than
> detecting one.

Agreed. A very valid point.
> 
> I would rather just disable with a warning if it were
> up to me. If you *really* wanted to be fancy then
> allow admin to re-enable via proc maybe.

I think that in either case, /proc/sys/kernel/nmi_watchdog
need to be updated to reflect that the NMI watchdog has
been disabled. That would require to expose other interfaces
of the watchdog.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
