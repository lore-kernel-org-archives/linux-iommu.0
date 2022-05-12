Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFFAC433EF
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 00:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E166383E23;
	Thu, 12 May 2022 00:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CAvw61HHcEjK; Thu, 12 May 2022 00:23:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C9CD83E20;
	Thu, 12 May 2022 00:23:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3544DC0039;
	Thu, 12 May 2022 00:23:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2225C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8984760B1D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aE-tVXNE6YHj for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 00:23:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE8F960AA0
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652315010; x=1683851010;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FXGLp4kn6zowFU/uMojpzoAT+8Tt5jfdv5yfT9ck7Mg=;
 b=ZpFanYLyGX5y1/fqGKF9pKF1Wg2HCxi9RZkrgrEkEePxJFFCiGBr9xap
 OW49awZKtmhg1iDUA5oki+Yhpf7jL7VPBQDc+tPMiQQD3niLkTn6o+c3W
 rwyQ5LnBP7KTFwoCa/xzsHN//QiprEQdw29falx7UGNRAm9RMHqZsMRdK
 a5zQLnHE2h+pnHmeRkX/FEOt17PItdKbuKzQYVWUo71bV7w590b7tju2e
 0AiY4gVuGTMN96qwL6vRyQGVX8zHKuC0RfyvUOnru7mXVgwMfpVfWGns4
 jPVgfeLJRLmh996QNaHgBYBGAbYyvvVhnSAq939WnPxk85qBNUSuiN7xm A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269519757"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="269519757"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 17:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; d="scan'208";a="594395631"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by orsmga008.jf.intel.com with ESMTP; 11 May 2022 17:23:27 -0700
Date: Wed, 11 May 2022 17:26:58 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 02/29] x86/apic: Add irq_cfg::delivery_mode
Message-ID: <20220512002658.GB16273@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
 <875ymih1yl.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875ymih1yl.ffs@tglx>
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

On Fri, May 06, 2022 at 09:53:54PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > Currently, the delivery mode of all interrupts is set to the mode of the
> > APIC driver in use. There are no restrictions in hardware to configure the
> > delivery mode of each interrupt individually. Also, certain IRQs need
> > to be
> 
> s/IRQ/interrupt/ Changelogs can do without acronyms.

Sure. I will sanitize all the changelogs to remove acronyms.

> 
> > configured with a specific delivery mode (e.g., NMI).
> >
> > Add a new member, delivery_mode, to struct irq_cfg. Subsequent changesets
> > will update every irq_domain to set the delivery mode of each IRQ to that
> > specified in its irq_cfg data.
> >
> > To keep the current behavior, when allocating an IRQ in the root
> > domain
> 
> The root domain does not allocate an interrupt. The root domain
> allocates a vector for an interrupt. There is a very clear and technical
> destinction. Can you please be more careful about the wording?

I will review the wording in the changelogs.

> 
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -567,6 +567,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
> >  		irqd->chip_data = apicd;
> >  		irqd->hwirq = virq + i;
> >  		irqd_set_single_target(irqd);
> > +
> 
> Stray newline.

Sorry! I will remove it.
> 
> >  		/*
> >  		 * Prevent that any of these interrupts is invoked in
> >  		 * non interrupt context via e.g. generic_handle_irq()
> > @@ -577,6 +578,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
> >  		/* Don't invoke affinity setter on deactivated interrupts */
> >  		irqd_set_affinity_on_activate(irqd);
> >  
> > +		/*
> > +		 * Initialize the delivery mode of this irq to match the
> 
> s/irq/interrupt/

I will make this change.

Thanks and BR,
Ricardo

> 
> > +		 * default delivery mode of the APIC. Children irq domains
> > +		 * may take the delivery mode from the individual irq
> > +		 * configuration rather than from the APIC driver.
> > +		 */
> > +		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
> > +
> >  		/*
> >  		 * Legacy vectors are already assigned when the IOAPIC
> >  		 * takes them over. They stay on the same vector. This is
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
