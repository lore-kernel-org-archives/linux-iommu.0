Return-Path: <SRS0=mBvT=UP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA5C31E53
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 08:53:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148AC21473
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 08:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148AC21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D559DAD1;
	Sun, 16 Jun 2019 08:53:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9DC61ACC
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 08:53:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 06A48E5
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 08:53:43 +0000 (UTC)
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hcQut-0007Ik-Bj; Sun, 16 Jun 2019 10:53:35 +0200
Date: Sun, 16 Jun 2019 10:53:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH v4 21/21] x86/watchdog/hardlockup/hpet: Support
	interrupt remapping
In-Reply-To: <alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906161051491.1760@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<1558660583-28561-22-git-send-email-ricardo.neri-calderon@linux.intel.com>
	<alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de>
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
> > +/** irq_remapping_enabled() - Detect if interrupt remapping is enabled
> > + * @hdata:	A data structure with the HPET block id
> > + *
> > + * Determine if the HPET block that the hardlockup detector is under
> > + * the remapped interrupt domain.
> > + *
> > + * Returns: True interrupt remapping is enabled. False otherwise.
> > + */
> > +static bool irq_remapping_enabled(struct hpet_hld_data *hdata)
> > +{
> > +	struct irq_alloc_info info;
> > +
> > +	init_irq_alloc_info(&info, NULL);
> > +	info.type = X86_IRQ_ALLOC_TYPE_HPET;
> > +	info.hpet_id = hdata->blockid;
> > +
> > +	return !!irq_remapping_get_ir_irq_domain(&info);
> > +}
> > +
> >  /**
> >   * compose_msi_msg() - Populate address and data fields of an MSI message
> >   * @hdata:	A data strucure with the message to populate
> > @@ -161,6 +181,9 @@ static int update_msi_destid(struct hpet_hld_data *hdata)
> >  {
> >  	u32 destid;
> >  
> > +	if (irq_remapping_enabled(hdata))
> > +		return hld_hpet_intremap_activate_irq(hdata);
> 
> No. This is horrible hackery violating all the layering which we carefully
> put into place to avoid exactly this kind of sprinkling conditionals into
> all code pathes.
> 
> With some thought the existing irqdomain hierarchy can be used to achieve
> the same thing without tons of extra functions and conditionals.

And of course this whole thing falls completely apart when someone enables
the hpet watchdog on AMD.

Can you folks please stop this works for me tinkering and finally grasp
that there is a world outside of Intel and outside of big enterprise boxes?

Thanks,

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
