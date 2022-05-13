Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C4C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 22:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A41B34015A;
	Fri, 13 May 2022 22:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bldEUCndl99l; Fri, 13 May 2022 22:13:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 92EE840207;
	Fri, 13 May 2022 22:13:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68536C0039;
	Fri, 13 May 2022 22:13:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABFCC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 22:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C421410DC
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 22:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXW12Le3tAKl for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 22:13:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30C4640988
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652479997; x=1684015997;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cxef9S28Y+ZsR9yxpw47GL3tVgcHUSJqzLfqt+5PNSo=;
 b=F4LQdEuNvQZHZXbbAxUDbmPaMfSCUfgdmVmb9EHgatssfaulY9QRdzdC
 5mh74yj6TA/lAvvxhMzCw/JqSLJyatnhPGD9LRb4AEcKl6AwyJNc34B/G
 fYPSc7R+IUfCgkL7T99Bd+yNz1oLLxpAMPSrwzU4OzO030lJHctDn1cE1
 NbUFWu7jCsKF+u+AoMi7vJ+C6wlDqjdqgZ3YYwkL6cxy7Sigt12NiM99M
 C9scF6WD7z8yQaSWbqBXzF9o+/et6ki+l5nsRzy1RlMyvDSpGTWXWzcUe
 vNv3mCxFQZMjBsg9uXCGL/EFVhULf817hmTfopLiuKXqO9+x8eYEjDllA A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250330937"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="250330937"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 15:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="543454884"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga006.jf.intel.com with ESMTP; 13 May 2022 15:13:15 -0700
Date: Fri, 13 May 2022 15:16:50 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 22/29] x86/watchdog/hardlockup: Add an HPET-based
 hardlockup detector
Message-ID: <20220513221650.GA8691@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-23-ricardo.neri-calderon@linux.intel.com>
 <877d6uref8.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877d6uref8.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
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

On Mon, May 09, 2022 at 04:03:39PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 17:00, Ricardo Neri wrote:
> > +	if (is_hpet_hld_interrupt(hdata)) {
> > +		/*
> > +		 * Kick the timer first. If the HPET channel is periodic, it
> > +		 * helps to reduce the delta between the expected TSC value and
> > +		 * its actual value the next time the HPET channel fires.
> > +		 */
> > +		kick_timer(hdata, !(hdata->has_periodic));
> > +
> > +		if (cpumask_weight(hld_data->monitored_cpumask) > 1) {
> > +			/*
> > +			 * Since we cannot know the source of an NMI, the best
> > +			 * we can do is to use a flag to indicate to all online
> > +			 * CPUs that they will get an NMI and that the source of
> > +			 * that NMI is the hardlockup detector. Offline CPUs
> > +			 * also receive the NMI but they ignore it.
> > +			 *
> > +			 * Even though we are in NMI context, we have concluded
> > +			 * that the NMI came from the HPET channel assigned to
> > +			 * the detector, an event that is infrequent and only
> > +			 * occurs in the handling CPU. There should not be races
> > +			 * with other NMIs.
> > +			 */
> > +			cpumask_copy(hld_data->inspect_cpumask,
> > +				     cpu_online_mask);
> > +
> > +			/* If we are here, IPI shorthands are enabled. */
> > +			apic->send_IPI_allbutself(NMI_VECTOR);
> 
> So if the monitored cpumask is a subset of online CPUs, which is the
> case when isolation features are enabled, then you still send NMIs to
> those isolated CPUs. I'm sure the isolation folks will be enthused.

Yes, I acknowledged this limitation in the cover letter. I should also update
Documentation/admin-guide/lockup-watchdogs.rst.

This patchset proposes the HPET NMI watchdog as an opt-in feature.

Perhaps the limitation might be mitigated by adding a check for non-housekeeping
and non-monitored CPUs in exc_nmi(). However, that will not eliminate the
problem of isolated CPUs also getting the NMI.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
