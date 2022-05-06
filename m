Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EC3C433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 19:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84DB160D6E;
	Fri,  6 May 2022 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EhOCK6W8NWZZ; Fri,  6 May 2022 19:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C3F560D57;
	Fri,  6 May 2022 19:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12665C0039;
	Fri,  6 May 2022 19:53:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 488ADC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 19:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2108340577
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 19:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="Xc8Vtd93";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="/4l7akva"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hA4DXeJcKHq7 for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 19:53:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EFC740558
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 19:53:56 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651866834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPigNHr8wXW4Jsp9L+zcdiLLC2xp5wKYQoiAjHdLkb0=;
 b=Xc8Vtd935tKSHJ4TItbPhom70GX4iR+XaOHyoZEbq2TCP4h9WjKpN0MVzmsUbMnujiBgnV
 WXGzehvrucSX1BoXOdNpoMb3s0YNBoPdGbKtAB3wDRyptT25vNwG7QcC7LwRl3B15XR6VM
 FhGG5jK12XCNGha0igmSaWXXc2p4A3H1NRfSABcL1Z3IwAXCO4O3qpx16YQ/THdTjg92ya
 In409B3HY2BR55Mv7J/T3Np4Rdy7VMWpG58IDPN5+hY6NlLD7uyzePgQU6EvXGIFGFCODZ
 3pB/pK2v3RdJoDZ1aaYSIcYs0qALgfVW7BGlvJCXH5N/7ExJVtGCxVmBC9jnxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651866834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPigNHr8wXW4Jsp9L+zcdiLLC2xp5wKYQoiAjHdLkb0=;
 b=/4l7akvaVCpYSimscxE6emXgo2DDhYqJsbAjKJILCBQFs5NLOHNmvvAauEvq153gAwkORH
 f5cYHMQqOtGE5zCA==
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH v6 02/29] x86/apic: Add irq_cfg::delivery_mode
In-Reply-To: <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-3-ricardo.neri-calderon@linux.intel.com>
Date: Fri, 06 May 2022 21:53:54 +0200
Message-ID: <875ymih1yl.ffs@tglx>
MIME-Version: 1.0
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 Ricardo Neri <ricardo.neri@intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
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

On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> Currently, the delivery mode of all interrupts is set to the mode of the
> APIC driver in use. There are no restrictions in hardware to configure the
> delivery mode of each interrupt individually. Also, certain IRQs need
> to be

s/IRQ/interrupt/ Changelogs can do without acronyms.

> configured with a specific delivery mode (e.g., NMI).
>
> Add a new member, delivery_mode, to struct irq_cfg. Subsequent changesets
> will update every irq_domain to set the delivery mode of each IRQ to that
> specified in its irq_cfg data.
>
> To keep the current behavior, when allocating an IRQ in the root
> domain

The root domain does not allocate an interrupt. The root domain
allocates a vector for an interrupt. There is a very clear and technical
destinction. Can you please be more careful about the wording?

> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -567,6 +567,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>  		irqd->chip_data = apicd;
>  		irqd->hwirq = virq + i;
>  		irqd_set_single_target(irqd);
> +

Stray newline.

>  		/*
>  		 * Prevent that any of these interrupts is invoked in
>  		 * non interrupt context via e.g. generic_handle_irq()
> @@ -577,6 +578,14 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
>  		/* Don't invoke affinity setter on deactivated interrupts */
>  		irqd_set_affinity_on_activate(irqd);
>  
> +		/*
> +		 * Initialize the delivery mode of this irq to match the

s/irq/interrupt/

> +		 * default delivery mode of the APIC. Children irq domains
> +		 * may take the delivery mode from the individual irq
> +		 * configuration rather than from the APIC driver.
> +		 */
> +		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
> +
>  		/*
>  		 * Legacy vectors are already assigned when the IOAPIC
>  		 * takes them over. They stay on the same vector. This is
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
