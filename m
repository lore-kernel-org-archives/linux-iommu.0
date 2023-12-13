Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338036132
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeBfiOPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702438640; x=1733974640;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TTYLl6m3nDoZ6t2LsN549k9K+o9cYhBy102gdNwk1c=;
  b=DeBfiOPN4nF51hDXLXxSEi6BGXdFvvJpbPg4dIWuzkbfSrlPMHfKE7P+
   BX8jKINQh6ci4SN6r6LknACxtcWhZx/MpoCl+FjLCK4+2trzddzjrzbmy
   DQ+9rpCtKRqTIZZsL3rcW83oT9oudOy45VhUjIxLX5iEFmE6tBQjY3ZwS
   OzDLuLdPVxemu0b9Ve7XYD4LzkmABerl2QDycpk9EPtTWRKVCxieyX1vM
   tGp/Vv40OJ1y3QKg7MFPOjNSZDwHOZTZWJSkng9rZ5iGAY8Ckw1FcfcUD
   QtxbhDxflslcZO+JriAzUgxkTmSL85MnVoUWFwjqHOcMkNwUbN7eerdvB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2081088"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="2081088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:37:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917520199"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="917520199"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 19:37:18 -0800
Date: Tue, 12 Dec 2023 19:42:13 -0800
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
Message-ID: <20231212194213.1ad94584@jacob-builder>
In-Reply-To: <87wmtrt625.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
	<20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
	<87wmtrt625.ffs@tglx>
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

On Wed, 06 Dec 2023 21:44:02 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> >  static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
> >  {
> >  	memset(msg, 0, sizeof(*msg));
> > @@ -1361,7 +1397,7 @@ static int intel_irq_remapping_alloc(struct
> > irq_domain *domain, 
> >  		irq_data->hwirq = (index << 16) + i;
> >  		irq_data->chip_data = ird;
> > -		irq_data->chip = &intel_ir_chip;
> > +		irq_data->chip = posted_msi_supported() ?
> > &intel_ir_chip_post_msi : &intel_ir_chip;  
> 
> This is just wrong because you change the chip to posted for _ALL_
> domains unconditionally.
> 
> The only domains which want this chip are the PCI/MSI domains. And those
> are distinct from the domains which serve IO/APIC, HPET, no?
> 
> So you can set that chip only for PCI/MSI and just let IO/APIC, HPET
> domains keep the original chip, which spares any modification of the
> IO/APIC domain.
> 
> 
make sense.
-               irq_data->chip = posted_msi_supported() ? &intel_ir_chip_post_msi : &intel_ir_chip;
+               if ((info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI) && posted_msi_supported())
+                       irq_data->chip = &intel_ir_chip_post_msi;
+               else
+                       irq_data->chip = &intel_ir_chip;

Now in IRQ debugfs, I can see the correct IR chips for IOAPIC IRQs and
MSIs.

e.g


domain:  IO-APIC-8
 hwirq:   0x9
 chip:    IR-IO-APIC
  flags:   0x410
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  INTEL-IR-9-13
     hwirq:   0x80000
     chip:    INTEL-IR
      flags:   0x0
     parent:
        domain:  VECTOR


domain:  IR-PCI-MSI-0000:3d:00.4-11
 hwirq:   0x0
 chip:    IR-PCI-MSI-0000:3d:00.4
  flags:   0x430
             IRQCHIP_SKIP_SET_WAKE
             IRQCHIP_ONESHOT_SAFE
 parent:
    domain:  INTEL-IR-4-13
     hwirq:   0x0
     chip:    INTEL-IR-POST
      flags:   0x0
     parent:
        domain:  VECTOR


Thanks,

Jacob
