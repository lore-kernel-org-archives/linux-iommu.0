Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B9CC433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 21:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FF184015A;
	Fri, 13 May 2022 21:25:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVbuDQ9ENxqq; Fri, 13 May 2022 21:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 63B3840241;
	Fri, 13 May 2022 21:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9CAC0032;
	Fri, 13 May 2022 21:25:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF0B3C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 21:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A690E83F2F
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 21:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qVyZF-MunJ6Y for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 21:25:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 105A483F11
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652477129; x=1684013129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=l6Vls9wnN+x00vvDZEEHtOYdZPzsd8ahPI1ukzsIW6A=;
 b=M8uYktimlCBQbO8kwV+v9s9Mj+jgIDFRF3kKoF6MwadyiCHL/yHkq7nQ
 B1QGRizAOML1XLD2ARqlzCQfeVLV/IIgef1xOcnvuofShPNg3ACpsjJ3s
 szbDdNkijedbtwiJ0W64hzNBNtms2o+dZwphPmM9SSP3EUYyVFDMtocce
 jUTg4EM07XE3+WYxzuwd9FXDNvsOk+64qZAVkyLVr94K6q9tq+Tye+3rB
 lcciR2LttwargCYldDX18N8hCdboQheDdpfib+ZYyKaeixLlRZZGpexIl
 0iwObs2vcqJDfr8Zv8TwBGV6A23sMtGMVkQbxxd29KJZ6LvObyGnvJguO g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270547856"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="270547856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 14:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="712562541"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 14:25:28 -0700
Date: Fri, 13 May 2022 14:29:03 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
Message-ID: <20220513212903.GF22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx> <87ilqifhxj.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilqifhxj.ffs@tglx>
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

On Fri, May 06, 2022 at 11:51:52PM +0200, Thomas Gleixner wrote:
> On Fri, May 06 2022 at 23:41, Thomas Gleixner wrote:
> > On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> >> Programming an HPET channel as periodic requires setting the
> >> HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
> >> register must be written twice (once for the comparator value and once for
> >> the periodic value). Since this programming might be needed in several
> >> places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
> >> add a helper function for this purpose.
> >>
> >> A helper function hpet_set_comparator_oneshot() could also be implemented.
> >> However, such function would only program the comparator register and the
> >> function would be quite small. Hence, it is better to not bloat the code
> >> with such an obvious function.
> >
> > This word salad above does not provide a single reason why the periodic
> > programming function is required and better suited for the NMI watchdog
> > case and then goes on and blurbs about why a function which is not
> > required is not implemented. The argument about not bloating the code
> > with an "obvious???" function which is quite small is slightly beyond my
> > comprehension level.
> 
> What's even more uncomprehensible is that the patch which actually sets
> up that NMI watchdog cruft has:
> 
> > +       if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
> > +               hld_data->has_periodic = true;
> 
> So how the heck does that work with a HPET which does not support
> periodic mode?

If the HPET channel does not support periodic mode (as indicated by the flag
above), it will read the HPET counter into a local variable, increment that
local variable, and write comparator of the HPET channel.

If the HPET channel does support periodic mode, it will not kick it again.
It will only kick a periodic HPET channel if needed (e.g., if the NMI watchdog
was idle of watchdog_thresh changed its value).

> 
> That watchdog muck will still happily invoke that set periodic function
> in the hope that it works by chance?

It will not. It will check hld_data->has_periodic and act accordingly.

FWIW, I have tested this NMI watchdog with periodic and non-periodic HPET
channels.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
