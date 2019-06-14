Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E1BC31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 16:10:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A4A20850
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 16:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 57A5115B3;
	Fri, 14 Jun 2019 16:10:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 135FF15B2
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 16:10:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8EA00E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 16:10:35 +0000 (UTC)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hbomR-0002i5-69; Fri, 14 Jun 2019 18:10:19 +0200
Date: Fri, 14 Jun 2019 18:10:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 05/21] x86/hpet: Reserve timer for the HPET
	hardlockup detector
In-Reply-To: <20190614011454.GA6347@ranerica-svr.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1906141726190.1722@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-6-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906112152430.2214@nanos.tec.linutronix.de>
	<20190614011454.GA6347@ranerica-svr.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
	Ashok Raj <ashok.raj@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Randy Dunlap <rdunlap@infradead.org>, Clemens Ladisch <clemens@ladisch.de>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>,
	Ingo Molnar <mingo@kernel.org>
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

On Thu, 13 Jun 2019, Ricardo Neri wrote:

> On Tue, Jun 11, 2019 at 09:54:25PM +0200, Thomas Gleixner wrote:
> > On Thu, 23 May 2019, Ricardo Neri wrote:
> > 
> > > HPET timer 2 will be used to drive the HPET-based hardlockup detector.
> > > Reserve such timer to ensure it cannot be used by user space programs or
> > > for clock events.
> > > 
> > > When looking for MSI-capable timers for clock events, skip timer 2 if
> > > the HPET hardlockup detector is selected.
> > 
> > Why? Both the changelog and the code change lack an explanation why this
> > timer is actually touched after it got reserved for the platform. The
> > reservation should make it inaccessible for other things.
> 
> hpet_reserve_platform_timers() will give the HPET char driver a data
> structure which specifies which drivers are reserved. In this manner,
> they cannot be used by applications via file opens. The timer used by
> the hardlockup detector should be marked as reserved.
> 
> Also, hpet_msi_capability_lookup() populates another data structure
> which is used when obtaining an unused timer for a HPET clock event.
> The timer used by the hardlockup detector should not be included in such
> data structure.
> 
> Is this the explanation you would like to see? If yes, I will include it
> in the changelog.

Yes, the explanation makes sense. The code still sucks. Not really your
fault, but this is not making it any better.

What bothers me most is the fact that CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
removes one HPET timer unconditionally. It neither checks whether the hpet
watchdog is actually enabled on the command line, nor does it validate
upfront whether the HPET supports FSB delivery.

That wastes an HPET timer unconditionally for no value. Not that I
personally care much about /dev/hpet, but some older laptops depend on HPET
per cpu timers as the local APIC timer stops in C2/3. So this unconditional
reservation will cause regressions for no reason.

The proper approach here is to:

 1) Evaluate the command line _before_ hpet_enable() is invoked

 2) Check the availability of FSB delivery in hpet_enable()

Reserve an HPET channel for the watchdog only when #1 and #2 are true.

Thanks,

	tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
