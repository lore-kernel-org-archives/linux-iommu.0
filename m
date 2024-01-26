Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C595A0FE
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311564; cv=none; b=t9I+hq/ZerltcX1w/fiHbI7EUsxb/1sQ6p2havfF5hdb3+CPlERP57f2QeC6WwkzdWQqI2KTYdBXgeJRT2LPbwLkPNT+oozZP/RJfpxGSiMAtTb6uEwz0coBYaXvnzXO6vx+6BpSgSABRu1muR3HzKT2nOobbSbQxjB0PP/YNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311564; c=relaxed/simple;
	bh=9iGGg8kmwIrcyuY9SjFmZ8N8m2mIq7q3D6o7JOq2y1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/GxYe9rfTwwH66B093TM3MiyG9dYlZaBJeXer0MJ779j35r8PbylOxXOofBVqXsmm/rKjjRQ8kipHABAb38Gw4PGN4EbzEozDsdx6vze/tFetiTmgtxIsr4JaSaLyi3ao7g2z/aCiuo/lKVQ2wuB2MdZdIOovoNp2hZbrc+TfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmeJpsRQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmeJpsRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706311563; x=1737847563;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iGGg8kmwIrcyuY9SjFmZ8N8m2mIq7q3D6o7JOq2y1A=;
  b=dmeJpsRQRkv0trtSoXooorxHdOzTEqumqof35R5wQ9MFyJ77uPe/d2K6
   vWWrnuZn4oINPW5iNJd98G55PP8fcwF6+xlHYhqNfUrEmIdNmr3gosGyD
   GuaMWNxz/NYT4gRF4zXcpDGOWpgTGQaZurLLNmzx9lp6pJWsC5SkoNvYy
   WDKAwTMhBZQUTxOMGY2jbEDes888cTLv48zuNdaeoEbtntc1ghF9TPZHE
   0gZEcIyGbOu2iAFHUz0sPGeu01ACEH/bjXzR75337LtZ58YuVRN24gzuY
   hR6hA7RPExs7RF5nhoFEjz47gQ7djss5vRwoALH1SY2r2uggMa8Hb49Dr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2441262"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2441262"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35567739"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:26:02 -0800
Date: Fri, 26 Jan 2024 15:31:21 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, peterz@infradead.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 11/13] iommu/vt-d: Add an irq_chip for posted MSIs
Message-ID: <20240126153121.7c24617d@jacob-builder>
In-Reply-To: <877clrulyb.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
 <877clrulyb.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Thomas,

On Wed, 06 Dec 2023 21:15:24 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> > With posted MSIs, end of interrupt is handled by the notification
> > handler. Each MSI handler does not go through local APIC IRR, ISR
> > processing. There's no need to do apic_eoi() in those handlers.
> >
> > Add a new acpi_ack_irq_no_eoi() for the posted MSI IR chip. At runtime
> > the call trace looks like:
> >
> > __sysvec_posted_msi_notification() {
> >   irq_chip_ack_parent() {
> >     apic_ack_irq_no_eoi();
> >   }  
> 
> Huch? There is something missing here to make sense.
Good point, I was too focused on eoi. The trace should be like

 * __sysvec_posted_msi_notification()
 *	irq_enter();
 *		handle_edge_irq()
 *			irq_chip_ack_parent()
 *				dummy(); // No EOI
 *			handle_irq_event()
 *				driver_handler()
 *	irq_enter();
 *		handle_edge_irq()
 *			irq_chip_ack_parent()
 *				dummy(); // No EOI
 *			handle_irq_event()
 *				driver_handler()
 *	irq_enter();
 *		handle_edge_irq()
 *			irq_chip_ack_parent()
 *				dummy(); // No EOI
 *			handle_irq_event()
 *				driver_handler()
 *	apic_eoi()
 * irq_exit()

> >   handle_irq_event() {
> >     handle_irq_event_percpu() {
> >        driver_handler()
> >     }
> >   }
> >
> > IO-APIC IR is excluded the from posted MSI, we need to make sure it
> > still performs EOI.  
> 
> We need to make the code correct and write changelogs which make
> sense. This sentence makes no sense whatsoever.
> 
> What has the IO-APIC to do with posted MSIs?
> 
> It's a different interrupt chip hierarchy, no?
Right, I should not modify IOAPIC chip. Just assign posted IR chip to
device MSI/x.

> > diff --git a/arch/x86/kernel/apic/io_apic.c
> > b/arch/x86/kernel/apic/io_apic.c index 00da6cf6b07d..ca398ee9075b 100644
> > --- a/arch/x86/kernel/apic/io_apic.c
> > +++ b/arch/x86/kernel/apic/io_apic.c
> > @@ -1993,7 +1993,7 @@ static struct irq_chip ioapic_ir_chip
> > __read_mostly = { .irq_startup		= startup_ioapic_irq,
> >  	.irq_mask		= mask_ioapic_irq,
> >  	.irq_unmask		= unmask_ioapic_irq,
> > -	.irq_ack		= irq_chip_ack_parent,
> > +	.irq_ack		= apic_ack_irq,  
> 
> Why?
ditto.

> 
> >  	.irq_eoi		= ioapic_ir_ack_level,
> >  	.irq_set_affinity	= ioapic_set_affinity,
> >  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > diff --git a/arch/x86/kernel/apic/vector.c
> > b/arch/x86/kernel/apic/vector.c index 14fc33cfdb37..01223ac4f57a 100644
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -911,6 +911,11 @@ void apic_ack_irq(struct irq_data *irqd)
> >  	apic_eoi();
> >  }
> >  
> > +void apic_ack_irq_no_eoi(struct irq_data *irqd)
> > +{
> > +	irq_move_irq(irqd);
> > +}
> > +  
> 
> The exact purpose of that function is to invoke irq_move_irq() which is
> a completely pointless exercise for interrupts which are remapped.

OK, I will replace this with a dummy .irq_ack() function.
Device MSIs do not have IRQD_SETAFFINITY_PENDING set.

Thanks,

Jacob
