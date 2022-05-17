Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8425C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 22:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92B7340377;
	Tue, 17 May 2022 22:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUuruXi8iCSe; Tue, 17 May 2022 22:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68D3E400FB;
	Tue, 17 May 2022 22:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34199C0032;
	Tue, 17 May 2022 22:04:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BD49C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09E9960E07
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HHrBltm6EejL for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 22:04:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31F7E60B7D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652825069; x=1684361069;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DYnEdSppO39yh6uNPMT5k/kcPnrUIqJqd4/BSKdNERc=;
 b=e/pz44afZ6dfqdRgjFlUY5BG1zioYDm8TmV9psyaS3K2N6HDpCehOXoS
 NtqfjhEZ2KLEMdEuhD8/G9ei8g0TJw3WM07GUqkRmZU46aHkXigl7Xir9
 2zcEjIsjYbPZs4Eznuc6pOpacJX9FW3Xm3VQLFIiMtQ1b1dnbHa5EC9KU
 hoKwOogNN+qPgO9yd53wGlBnLTf1+FzSzNYEvYd/K6IuENgI8qy9IAroW
 OzsxjNf1ltra3HC3KQDiME5sg2ogdRvrSU2gLo7oLk98GF7kPZ41Tjz8K
 LIaRW2rvvYvKesjttLz1osUMylFRsty7FD9YxtSAMXsrLotDVeuoGexuC w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="258915642"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="258915642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2022 15:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; d="scan'208";a="673075036"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga002.fm.intel.com with ESMTP; 17 May 2022 15:04:27 -0700
Date: Tue, 17 May 2022 15:08:10 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
Message-ID: <20220517220810.GB6711@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
 <1652180070.1r874kr0tg.astroid@bobo.none>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1652180070.1r874kr0tg.astroid@bobo.none>
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

On Tue, May 10, 2022 at 09:16:21PM +1000, Nicholas Piggin wrote:
> Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> > The HPET hardlockup detector relies on tsc_khz to estimate the value of
> > that the TSC will have when its HPET channel fires. A refined tsc_khz
> > helps to estimate better the expected TSC value.
> > 
> > Using the early value of tsc_khz may lead to a large error in the expected
> > TSC value. Restarting the NMI watchdog detector has the effect of kicking
> > its HPET channel and make use of the refined tsc_khz.
> > 
> > When the HPET hardlockup is not in use, restarting the NMI watchdog is
> > a noop.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: x86@kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v5:
> >  * Introduced this patch
> > 
> > Changes since v4
> >  * N/A
> > 
> > Changes since v3
> >  * N/A
> > 
> > Changes since v2:
> >  * N/A
> > 
> > Changes since v1:
> >  * N/A
> > ---
> >  arch/x86/kernel/tsc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index cafacb2e58cc..cc1843044d88 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1386,6 +1386,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
> >  	/* Inform the TSC deadline clockevent devices about the recalibration */
> >  	lapic_update_tsc_freq();
> >  
> > +	/*
> > +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
> > +	 * Reconfigure it to make use of the refined tsc_khz.
> > +	 */
> > +	lockup_detector_reconfigure();
> 
> I don't know if the API is conceptually good.
> 
> You change something that the lockup detector is currently using, 
> *while* the detector is running asynchronously, and then reconfigure
> it. 

Yes, this is what happens.

> What happens in the window? If this code is only used for small
> adjustments maybe it does not really matter

Please see my comment

> but in principle it's a bad API to export.
> 
> lockup_detector_reconfigure as an internal API is okay because it
> reconfigures things while the watchdog is stopped

I see.

> [actually that  looks untrue for soft dog which uses watchdog_thresh in
> is_softlockup(), but that should be fixed].

Perhaps there should be a watchdog_thresh_user. When the user updates it,
the detector is stopped, watchdog_thresh is updated, and then the detector
is resumed.

> 
> You're the arch so you're allowed to stop the watchdog and configure
> it, e.g., hardlockup_detector_perf_stop() is called in arch/.

I had it like this but it did not look right to me. You are right, however,
I can stop/restart the watchdog when needed.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
