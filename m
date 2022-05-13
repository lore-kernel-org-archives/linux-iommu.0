Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82274C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 21:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 302F041942;
	Fri, 13 May 2022 21:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KhudZyeZy3cK; Fri, 13 May 2022 21:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDD4341929;
	Fri, 13 May 2022 21:16:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E24EC0032;
	Fri, 13 May 2022 21:16:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D68DC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 21:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7551841942
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 21:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KE7onN21A0V3 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 21:16:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83EE541929
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652476570; x=1684012570;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9Gskyxl5a38unKZlQosOqjGR7Ihzv9T1bkSU8Qq82ZE=;
 b=Z4e0QweYuX5H3ldZ/nqKu/gbH8lZPaqo6v/LdeSXgMpsHchvj7BLXUq1
 4dpLaF4MAuER0yp9FIilcPWca6QZf72V0zdw9IHvwvFtpS1y5QrYbeTRK
 1OvefIlVatBOkRd6yNrRK8BsTisXo6zRxgx6zncE5gvVT6CWDibJCEnWV
 a8pBydRo/F7DXkxmJCbro54IQaqiUQh9oZGcRyUtU/BmcmvnqCV25BNkj
 oGVAgsJyKBEyMBtyiuyXWZ+ISkyj4qkqh0ZgCSTadX2Tl5UFU3k6Ql9qQ
 4CMQTP1MPCA03GowwrOWYRXXdw94fUVVpYtkPf3BGUqcEb+95O9DapN/6 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="331018649"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="331018649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2022 14:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; d="scan'208";a="595421000"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga008.jf.intel.com with ESMTP; 13 May 2022 14:16:09 -0700
Date: Fri, 13 May 2022 14:19:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 15/29] x86/hpet: Add helper function
 hpet_set_comparator_periodic()
Message-ID: <20220513211944.GE22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-16-ricardo.neri-calderon@linux.intel.com>
 <87mtfufifa.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtfufifa.ffs@tglx>
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

On Fri, May 06, 2022 at 11:41:13PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > Programming an HPET channel as periodic requires setting the
> > HPET_TN_SETVAL bit in the channel configuration. Plus, the comparator
> > register must be written twice (once for the comparator value and once for
> > the periodic value). Since this programming might be needed in several
> > places (e.g., the HPET clocksource and the HPET-based hardlockup detector),
> > add a helper function for this purpose.
> >
> > A helper function hpet_set_comparator_oneshot() could also be implemented.
> > However, such function would only program the comparator register and the
> > function would be quite small. Hence, it is better to not bloat the code
> > with such an obvious function.
> 
> This word salad above does not provide a single reason why the periodic
> programming function is required and better suited for the NMI watchdog
> case

The goal of hpet_set_comparator_periodic() is to avoid code duplication. The
functions hpet_clkevt_set_state_periodic() and kick_timer() in the HPET NMI
watchdog need to program a periodic HPET channel when supported.


> and then goes on and blurbs about why a function which is not
> required is not implemented.

I can remove this.

> The argument about not bloating the code
> with an "obvious???" function which is quite small is slightly beyond my
> comprehension level.

That obvious function would look like this:

void hpet_set_comparator_one_shot(int channel, u32 delta)
{
	u32 count;

	count = hpet_readl(HPET_COUNTER);
	count += delta;
	hpet_writel(count, HPET_Tn_CMP(channel));
}

It involves one register read, one addition and one register write. IMO, this
code is sufficiently simple and small to allow duplication.

Programming a periodic HPET channel is not as straightforward, IMO. It involves
handling two different values (period and comparator) written in a specific
sequence, one configuration bit, and one delay. It also involves three register
writes and one register read.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
