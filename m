Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B60C04E84
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 15:57:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C477B205ED
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C477B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BE1065AA;
	Wed, 15 May 2019 15:57:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 69456481
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 15:57:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C584F837
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 15:57:44 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	15 May 2019 08:57:44 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
	by orsmga004.jf.intel.com with ESMTP; 15 May 2019 08:57:43 -0700
Date: Wed, 15 May 2019 08:56:04 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v3 04/21] x86/hpet: Add hpet_set_comparator() for
	periodic and one-shot modes
Message-ID: <20190515155604.GB10526@ranerica-svr.sc.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1557842534-4266-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<3c82f3e0-999c-b389-aa9b-f06919800bb4@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c82f3e0-999c-b389-aa9b-f06919800bb4@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
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

On Tue, May 14, 2019 at 07:24:38AM -0700, Randy Dunlap wrote:
> On 5/14/19 7:01 AM, Ricardo Neri wrote:
> > Instead of setting the timer period directly in hpet_set_periodic(), add a
> > new helper function hpet_set_comparator() that only sets the accumulator
> > and comparator. hpet_set_periodic() will only prepare the timer for
> > periodic mode and leave the expiration programming to
> > hpet_set_comparator().
> > 
> > This new function can also be used by other components (e.g., the HPET-
> > based hardlockup detector) which also need to configure HPET timers. Thus,
> > add its declaration into the hpet header file.
> > 
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Andi Kleen <andi.kleen@intel.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Cc: x86@kernel.org
> > Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  arch/x86/include/asm/hpet.h |  1 +
> >  arch/x86/kernel/hpet.c      | 57 ++++++++++++++++++++++++++++---------
> >  2 files changed, 45 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> > index f132fbf984d4..e7098740f5ee 100644
> > --- a/arch/x86/include/asm/hpet.h
> > +++ b/arch/x86/include/asm/hpet.h
> > @@ -102,6 +102,7 @@ extern int hpet_rtc_timer_init(void);
> >  extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
> >  extern int hpet_register_irq_handler(rtc_irq_handler handler);
> >  extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
> > +extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
> >  
> >  #endif /* CONFIG_HPET_EMULATE_RTC */
> >  
> > diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> > index 560fc28e1d13..c5c5fc150193 100644
> > --- a/arch/x86/kernel/hpet.c
> > +++ b/arch/x86/kernel/hpet.c
> > @@ -289,6 +289,46 @@ static void hpet_legacy_clockevent_register(void)
> >  	printk(KERN_DEBUG "hpet clockevent registered\n");
> >  }
> >  
> > +/**
> > + * hpet_set_comparator() - Helper function for setting comparator register
> > + * @num:	The timer ID
> > + * @cmp:	The value to be written to the comparator/accumulator
> > + * @period:	The value to be written to the period (0 = oneshot mode)
> > + *
> > + * Helper function for updating comparator, accumulator and period values.
> > + *
> > + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> > + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> > + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> > + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> > + *
> > + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> > + *
> > + * See the following documents:
> > + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> > + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> > + */
> > +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> > +{
> > +	if (period) {
> > +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> > +
> > +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> > +	}
> > +
> > +	hpet_writel(cmp, HPET_Tn_CMP(num));
> > +
> > +	if (!period)
> > +		return;
> > +
> > +	/* This delay is seldom used: never in one-shot mode and in periodic
> > +	 * only when reprogramming the timer.
> > +	 */
> 
> comment style warning ;)
>

Uh! I'll correct this. Strangely, I reran checkpatch and it didn't catch
it.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
