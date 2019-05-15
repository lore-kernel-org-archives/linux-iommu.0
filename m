Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EEC04E53
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 15:56:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DE42084E
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 15:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DE42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 686B2AB9;
	Wed, 15 May 2019 15:56:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D1333AA5
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 15:56:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 21F32837
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 15:56:07 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 May 2019 08:56:06 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
	by orsmga006.jf.intel.com with ESMTP; 15 May 2019 08:56:04 -0700
Date: Wed, 15 May 2019 08:54:26 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v3 03/21] x86/hpet: Calculate ticks-per-second in a
	separate function
Message-ID: <20190515155426.GA10526@ranerica-svr.sc.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1557842534-4266-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<25922025-d551-0865-b364-b53ef34e6b6a@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <25922025-d551-0865-b364-b53ef34e6b6a@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux-foundation.org,
	Philippe Ombredanne <pombredanne@nexb.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, May 14, 2019 at 07:23:47AM -0700, Randy Dunlap wrote:
> On 5/14/19 7:01 AM, Ricardo Neri wrote:
> > It is easier to compute the expiration times of an HPET timer by using
> > its frequency (i.e., the number of times it ticks in a second) than its
> > period, as given in the capabilities register.
> > 
> > In addition to the HPET char driver, the HPET-based hardlockup detector
> > will also need to know the timer's frequency. Thus, create a common
> > function that both can use.
> > 
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Andi Kleen <andi.kleen@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: x86@kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  drivers/char/hpet.c  | 31 ++++++++++++++++++++++++-------
> >  include/linux/hpet.h |  1 +
> >  2 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> > index d0ad85900b79..bdcbecfdb858 100644
> > --- a/drivers/char/hpet.c
> > +++ b/drivers/char/hpet.c
> > @@ -836,6 +836,29 @@ static unsigned long hpet_calibrate(struct hpets *hpetp)
> >  	return ret;
> >  }
> >  
> > +u64 hpet_get_ticks_per_sec(u64 hpet_caps)
> > +{
> > +	u64 ticks_per_sec, period;
> > +
> > +	period = (hpet_caps & HPET_COUNTER_CLK_PERIOD_MASK) >>
> > +		 HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> > +
> > +	/*
> > +	 * The frequency is the reciprocal of the period. The period is given
> > +	 * femtoseconds per second. Thus, prepare a dividend to obtain the
> 
> 	 * in femtoseconds per second.
> 

Thanks for your review Randy! I'll fix this grammar issue.
> > +	 * frequency in ticks per second.
> > +	 */
> > +
> > +	/* 10^15 femtoseconds per second */
> > +	ticks_per_sec = 1000000000000000uLL;
> 
> 	ULL is overwhelmingly used in the kernel.
> 

Sure, I'll update it.

BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
