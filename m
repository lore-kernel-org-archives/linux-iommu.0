Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B4BC31E5E
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 22:45:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610322084D
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 22:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE3CEC77;
	Tue, 18 Jun 2019 22:45:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E1FC7C6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 22:45:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 60E682C3
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 22:45:41 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	18 Jun 2019 15:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,390,1557212400"; d="scan'208";a="358421836"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
	by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2019 15:45:40 -0700
Date: Tue, 18 Jun 2019 15:45:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
	remampping table entry for watchdog
Message-ID: <20190618224519.GA30488@ranerica-svr.sc.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Stephane Eranian <eranian@google.com>, Ingo Molnar <mingo@kernel.org>,
	Wincy Van <fanwenyi0529@gmail.com>,
	Ashok Raj <ashok.raj@intel.com>, x86@kernel.org,
	Andi Kleen <andi.kleen@intel.com>, Borislav Petkov <bp@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Jacob Pan <jacob.jun.pan@intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
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

On Mon, Jun 17, 2019 at 10:25:35AM +0200, Thomas Gleixner wrote:
> On Sun, 16 Jun 2019, Thomas Gleixner wrote:
> > On Thu, 23 May 2019, Ricardo Neri wrote:
> > > When the hardlockup detector is enabled, the function
> > > hld_hpet_intremapactivate_irq() activates the recently created entry
> > > in the interrupt remapping table via the modify_irte() functions. While
> > > doing this, it specifies which CPU the interrupt must target via its APIC
> > > ID. This function can be called every time the destination iD of the
> > > interrupt needs to be updated; there is no need to allocate or remove
> > > entries in the interrupt remapping table.
> > 
> > Brilliant.
> > 
> > > +int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
> > > +{
> > > +	u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
> > > +	struct intel_ir_data *data;
> > > +
> > > +	data = (struct intel_ir_data *)hdata->intremap_data;
> > > +	data->irte_entry.dest_id = IRTE_DEST(destid);
> > > +	return modify_irte(&data->irq_2_iommu, &data->irte_entry);
> > 
> > This calls modify_irte() which does at the very beginning:
> > 
> >    raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
> > 
> > How is that supposed to work from NMI context? Not to talk about the
> > other spinlocks which are taken in the subsequent call chain.
> > 
> > You cannot call in any of that code from NMI context.
> > 
> > The only reason why this never deadlocked in your testing is that nothing
> > else touched that particular iommu where the HPET hangs off concurrently.
> > 
> > But that's just pure luck and not design. 
> 
> And just for the record. I warned you about that problem during the review
> of an earlier version and told you to talk to IOMMU folks whether there is
> a way to update the entry w/o running into that lock problem.

I think I misunderstood your feedback. You did mention issues on locking
between NMI and !NMI contexts. However, that was in the context of using the
generic irq code to do things such as set the affinity of the interrupt and
requesting an irq. I understood that I should instead program things directly.
I extrapolated this to the IOMMU driver in which I also added code directly
instead of using the existing layering.

Also, at the time, the question regarding the IOMMU, as I understood, was
whether it was posible to reserve a IOMMU remapping entry upfront. I believe
my patches achieve that, even if they are hacky and ugly, and have locking
issues. I see now that the locking issues are also part of the IOMMU
discussion. Perhaps that was also implicit.
> 
> Can you tell my why am I actually reviewing patches and spending time on
> this when the result is ignored anyway?

Yes, Thomas, I should have checked first with the IOMMU maintainers
first on the issues in the paragraph above. It is not my intention to
waste your time; your feedback has been valuable and has contributed to
improve the code.

> 
> I also tried to figure out why you went away from the IPI broadcast
> design. The only information I found is:
> 
> Changes vs. v1:
> 
>  * Brought back the round-robin mechanism proposed in v1 (this time not
>    using the interrupt subsystem). This also requires to compute
>    expiration times as in v1 (Andi Kleen, Stephane Eranian).
> 
> Great that there is no trace of any mail from Andi or Stephane about this
> on LKML. There is no problem with talking offlist about this stuff, but
> then you should at least provide a rationale for those who were not part of
> the private conversation.

Stephane has already commented the rationale.

Thanks and BR,

Ricardo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
