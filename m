Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E806EB5A
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+2F6TIO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCX20KMC"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701893725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mm/xd8Se0/L/NRX1TjDPwoGPasQSGsV/i+Ec5BCG+FM=;
	b=J+2F6TIOyj3wf2tDOYwMQJoDYJz7EZ36PyPw/7LHlxTdBqPDUEr01lZxxSGooZrbW1312v
	Zr9zaBa/7nNKvd68ycoQ3FZvZ0rirQIdr4cBIttI35v1p7u1+LVKDYkKcFgJSb5nnEB4KO
	E5IgFs4hfHx7hdrRUBasjn4zERgKApvoQXZVBj1JjSGHZ52PG2SvmTeDWwwtLDPZ97zzbE
	9prYWXTPWE7h6IQ4JTQoVUgwuFk/pwUJvxu9+BVhJbRInK1+elCOYXmtX88en5FfwHI5z3
	YHp8b8kx+RTPRwL1bDQ7fM1Um8ESsDDETzyk2dzD3ZoIBJAIfagBq1GRFM0Rvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701893725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mm/xd8Se0/L/NRX1TjDPwoGPasQSGsV/i+Ec5BCG+FM=;
	b=DCX20KMC2OUjq+V5pdimOkHeXWecRRdn4mmRc4T43HKU0XG2r3cWdceeDlVtQLC+vqP4aQ
	ugxlXS0cjDxEI8BA==
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, peterz@infradead.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 11/13] iommu/vt-d: Add an irq_chip for posted MSIs
In-Reply-To: <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-12-jacob.jun.pan@linux.intel.com>
Date: Wed, 06 Dec 2023 21:15:24 +0100
Message-ID: <877clrulyb.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> With posted MSIs, end of interrupt is handled by the notification
> handler. Each MSI handler does not go through local APIC IRR, ISR
> processing. There's no need to do apic_eoi() in those handlers.
>
> Add a new acpi_ack_irq_no_eoi() for the posted MSI IR chip. At runtime
> the call trace looks like:
>
> __sysvec_posted_msi_notification() {
>   irq_chip_ack_parent() {
>     apic_ack_irq_no_eoi();
>   }

Huch? There is something missing here to make sense.

>   handle_irq_event() {
>     handle_irq_event_percpu() {
>        driver_handler()
>     }
>   }
>
> IO-APIC IR is excluded the from posted MSI, we need to make sure it
> still performs EOI.

We need to make the code correct and write changelogs which make
sense. This sentence makes no sense whatsoever.

What has the IO-APIC to do with posted MSIs?

It's a different interrupt chip hierarchy, no?

> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 00da6cf6b07d..ca398ee9075b 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1993,7 +1993,7 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
>  	.irq_startup		= startup_ioapic_irq,
>  	.irq_mask		= mask_ioapic_irq,
>  	.irq_unmask		= unmask_ioapic_irq,
> -	.irq_ack		= irq_chip_ack_parent,
> +	.irq_ack		= apic_ack_irq,

Why?

>  	.irq_eoi		= ioapic_ir_ack_level,
>  	.irq_set_affinity	= ioapic_set_affinity,
>  	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 14fc33cfdb37..01223ac4f57a 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -911,6 +911,11 @@ void apic_ack_irq(struct irq_data *irqd)
>  	apic_eoi();
>  }
>  
> +void apic_ack_irq_no_eoi(struct irq_data *irqd)
> +{
> +	irq_move_irq(irqd);
> +}
> +

The exact purpose of that function is to invoke irq_move_irq() which is
a completely pointless exercise for interrupts which are remapped.
