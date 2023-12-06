Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8139FF5
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ta9+GWcI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqBgTJoR"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701890067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHlmot3W1hhRj+RWqh+9nLkMzx3bkSfmuH5Fhyq8ADM=;
	b=Ta9+GWcIJxmj4d3u9BZvjYQhpsZjvcjZIb44L8e6cn4XTb4CIhUcvDzJLCt7wOJeA4xekA
	mpeOiCHxEu/ZfwhtK5xjUTTh9nUp9A1VCQA+6TmCSQOSE6KIm1+Kih7Bwehkqn4w/HwYZ4
	sZYL/9Orrwze2CGSaRbAo0f3jR4/oKO6t/McU73XqFss0yb04x5DeghQFpqS8lsC459s8T
	jyeTcsptwKI8UnnSLtrrWyLKadomGiy6LK8jfijeDXwLqBDkxyaGdzBDvGTKU9/ARSGmOs
	TCLeRnuYrVQ7qyu3qKHNC2T7mj2ucXesX1CgZ/6RF2sg77Iy/dju/5kzq8Iseg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701890067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHlmot3W1hhRj+RWqh+9nLkMzx3bkSfmuH5Fhyq8ADM=;
	b=fqBgTJoRu7ALJihn+tfBI49CmKGFW+utQWueC8s/a4DoaCJ/f/XOWK39jjpK3PNctsTv71
	PTtg5JewcVGDXYDw==
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, peterz@infradead.org, seanjc@google.com, Robin Murphy
 <robin.murphy@arm.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification handler
In-Reply-To: <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
Date: Wed, 06 Dec 2023 20:14:26 +0100
Message-ID: <87fs0fuorx.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> +	/*
> +	 * Ideally, we should start from the high order bits set in the PIR
> +	 * since each bit represents a vector. Higher order bit position means
> +	 * the vector has higher priority. But external vectors are allocated
> +	 * based on availability not priority.
> +	 *
> +	 * EOI is included in the IRQ handlers call to apic_ack_irq, which
> +	 * allows higher priority system interrupt to get in between.

What? This does not make sense.

_IF_ we go there then

     1) The EOI must be explicit in sysvec_posted_msi_notification()

     2) Interrupt enabling must happen explicit at a dedicated place in
        sysvec_posted_msi_notification()

        You _CANNOT_ run all the device handlers with interrupts
        enabled.

Please remove all traces of non-working wishful thinking from this series.

> +	 */
> +	for_each_set_bit_from(vec, (unsigned long *)&pir_copy[0], 256)

Why does this need to check up to vector 255? The vector space does not
magially expand just because of posted interrupts, really. At least not
without major modifications to the vector management.

> +		call_irq_handler(vec, regs);
> +

Stray newline.

> +}

Thanks,

        tglx
