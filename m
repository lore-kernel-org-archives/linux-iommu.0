Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC2C2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 14:17:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7FB206E0
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 14:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7FB206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9AE1012E4;
	Fri,  7 Jun 2019 14:17:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C5BAC12DA
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 14:16:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 57CC5876
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 14:16:16 +0000 (UTC)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Jun 2019 07:16:15 -0700
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
	by orsmga002.jf.intel.com with ESMTP; 07 Jun 2019 07:16:14 -0700
Date: Fri, 7 Jun 2019 07:14:16 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v4 17/21] x86/tsc: Switch to perf-based hardlockup
	detector if TSC become unstable
Message-ID: <20190607141416.GA30499@ranerica-svr.sc.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<CABPqkBQP=JxpiQE7SVuJO3xPWvsFbAPj916RTYUgaMBDG1OdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABPqkBQP=JxpiQE7SVuJO3xPWvsFbAPj916RTYUgaMBDG1OdaQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86 <x86@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
	Andi Kleen <andi.kleen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Jun 06, 2019 at 05:35:51PM -0700, Stephane Eranian wrote:
> Hi Ricardo,

Hi Stephane,

> Thanks for your contribution here. It is very important to move the
> watchdog out of the PMU wherever possible.

Indeed, using the PMU for the hardlockup detector is still the default
option. This patch series proposes a new kernel command line to switch
to use the HPET.

> 
> On Thu, May 23, 2019 at 6:17 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The HPET-based hardlockup detector relies on the TSC to determine if an
> > observed NMI interrupt was originated by HPET timer. Hence, this detector
> > can no longer be used with an unstable TSC.
> >
> > In such case, permanently stop the HPET-based hardlockup detector and
> > start the perf-based detector.
> >
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  arch/x86/include/asm/hpet.h    | 2 ++
> >  arch/x86/kernel/tsc.c          | 2 ++
> >  arch/x86/kernel/watchdog_hld.c | 7 +++++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> > index fd99f2390714..a82cbe17479d 100644
> > --- a/arch/x86/include/asm/hpet.h
> > +++ b/arch/x86/include/asm/hpet.h
> > @@ -128,6 +128,7 @@ extern int hardlockup_detector_hpet_init(void);
> >  extern void hardlockup_detector_hpet_stop(void);
> >  extern void hardlockup_detector_hpet_enable(unsigned int cpu);
> >  extern void hardlockup_detector_hpet_disable(unsigned int cpu);
> > +extern void hardlockup_detector_switch_to_perf(void);
> >  #else
> >  static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
> >  { return NULL; }
> > @@ -136,6 +137,7 @@ static inline int hardlockup_detector_hpet_init(void)
> >  static inline void hardlockup_detector_hpet_stop(void) {}
> >  static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
> >  static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
> > +static void harrdlockup_detector_switch_to_perf(void) {}
> >  #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
> >
> This does not compile for me when CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
> is not enabled.
> because:
>    1- you have a typo on the function name
>     2- you are missing the inline keyword

I am sorry. This was an oversight on my side. I have corrected this in
preparation for a v5.

Thanks and BR,
Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
