Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C069C31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 08:25:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B72D218A0
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 08:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B72D218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C8B84C3A;
	Mon, 17 Jun 2019 08:25:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A51DBC37
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 08:25:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ED080828
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 08:25:49 +0000 (UTC)
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hcmxN-0000zt-D9; Mon, 17 Jun 2019 10:25:37 +0200
Date: Mon, 17 Jun 2019 10:25:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 20/21] iommu/vt-d: hpet: Reserve an interrupt
	remampping table entry for watchdog
In-Reply-To: <alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906171007360.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906162049300.1760@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
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

On Sun, 16 Jun 2019, Thomas Gleixner wrote:
> On Thu, 23 May 2019, Ricardo Neri wrote:
> > When the hardlockup detector is enabled, the function
> > hld_hpet_intremapactivate_irq() activates the recently created entry
> > in the interrupt remapping table via the modify_irte() functions. While
> > doing this, it specifies which CPU the interrupt must target via its APIC
> > ID. This function can be called every time the destination iD of the
> > interrupt needs to be updated; there is no need to allocate or remove
> > entries in the interrupt remapping table.
> 
> Brilliant.
> 
> > +int hld_hpet_intremap_activate_irq(struct hpet_hld_data *hdata)
> > +{
> > +	u32 destid = apic->calc_dest_apicid(hdata->handling_cpu);
> > +	struct intel_ir_data *data;
> > +
> > +	data = (struct intel_ir_data *)hdata->intremap_data;
> > +	data->irte_entry.dest_id = IRTE_DEST(destid);
> > +	return modify_irte(&data->irq_2_iommu, &data->irte_entry);
> 
> This calls modify_irte() which does at the very beginning:
> 
>    raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
> 
> How is that supposed to work from NMI context? Not to talk about the
> other spinlocks which are taken in the subsequent call chain.
> 
> You cannot call in any of that code from NMI context.
> 
> The only reason why this never deadlocked in your testing is that nothing
> else touched that particular iommu where the HPET hangs off concurrently.
> 
> But that's just pure luck and not design. 

And just for the record. I warned you about that problem during the review
of an earlier version and told you to talk to IOMMU folks whether there is
a way to update the entry w/o running into that lock problem.

Can you tell my why am I actually reviewing patches and spending time on
this when the result is ignored anyway?

I also tried to figure out why you went away from the IPI broadcast
design. The only information I found is:

Changes vs. v1:

 * Brought back the round-robin mechanism proposed in v1 (this time not
   using the interrupt subsystem). This also requires to compute
   expiration times as in v1 (Andi Kleen, Stephane Eranian).

Great that there is no trace of any mail from Andi or Stephane about this
on LKML. There is no problem with talking offlist about this stuff, but
then you should at least provide a rationale for those who were not part of
the private conversation.

Thanks,

	tglcx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
