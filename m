Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A4261B9D
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981323; cv=none; b=DXK84hSjwPi2teqRQLx91vBP3Vqr/9TTOj4/TwTJ/2sJSmBoHv9ABigtTFrIHkaa+/7Vxb4+bChHOsQKwiQ4WcBWwpKd7P4f1SjwxH3ajIrn7xDCWM/Mof+g97EV2JnkG2Az1l+2xBQ4WJBtWomSY5D7nBztD/2HipcvhRCfwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981323; c=relaxed/simple;
	bh=MHYfe8bGDtNpXB2soBddZZBCJYpkG+5RTuO0JL8Lr+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acy4gZXwkuDdLn9cn6vUZfMTGKr9w2BHxJNWiMt4bfEFrjjOMhXQQtnIL4e66EgLV1S0eyGe4s/60ZfkK2YdDOIOZFtffMZuPCZojg5Q9650kx/65QvJ/5d1LymyJK0F0CcGZ+KNAYo7ymaVTFk7kQzeCfy4H5lHuYbWIctuNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4oyrBbV+; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4oyrBbV+"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b73599315adso309485066b.2
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763981320; x=1764586120; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lX+jdToFx/xjPzdH2tpm4CYF/HvbIMVX0oD+xboE4lA=;
        b=4oyrBbV+HRZgJyZExEW60WkMI3gLMHyycRVmVsepha60Rar7/D8JgY3Dgw4QKzpFIh
         4ghLSXwA8qnFrsItFcBoWrcU7vOayW/xR2OmOIEQnbydYRwG9mBKbMSOdijNTXDtUNbX
         Vpk28AuBhCaHZvjPg0kGLPvxNMr9ddvvTa68L9B0/3ODyGPdXvzp4msPPcvt2xVyUm/k
         +CZEUnX/G2YHasV8u5GWvYhAqKZlB2SwRG0woezrLcPK4/MqqMI7zkVCTuxzfCSuK1qx
         DJjwQmtYcCcOvrYBjiMz7L9y1fGxWBNMSSlcaoZyLdHutuKT1p2uRvNU9CuRXW0bCg6W
         L/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763981320; x=1764586120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX+jdToFx/xjPzdH2tpm4CYF/HvbIMVX0oD+xboE4lA=;
        b=X/aq42rEjBZzq7FbTgz2TogtZ9yi1JQidb8scIGW2nbVq07mC8RvOiAW2kB5x/vBIv
         00Wn/zdr/+jO3H9dHYe6msLRuNIPtLtKL1zbAm5fdg4gY/7e352KaO9cxT355NKMOI3a
         mUdKAOE6Cm7Wj2PhqXMG5NML7Na3QLFXWgF0xdi2CgZImfI7odIqEpKRycOaFZsHJ/cH
         kMJW42Zpc3kZnG8Fsp3yOVD1hirdFIPbyTnBCYimSNFIaaMGbx4c60mwM0p5KOl6lScm
         bEa3Es7lJGjn2OHCrefh0UBHwc6WfhQnvRCq8M4o3EcUoIhnFTrKGpZr7Yoz+XNMNEpV
         jeEw==
X-Forwarded-Encrypted: i=1; AJvYcCVuL15YO8EzKkV/giiHVnSnxWlx42yIZ/qFB/t8R1xOJ29rmQ4MMsL9XFQu7imVdg9TP2/p0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB7S/QOslbiaqp2zAh3gWVIar6Y2tIxnRnNGb/tJTi8ke0JyVU
	OufcPbdwHSElXYZw4KbhHIQVJBG5v1M3yekpvTWqAZ5MxiodWFsjwWqwYVVTkqIEETcztYQLMYe
	JEu/kyQ==
X-Google-Smtp-Source: AGHT+IFoktae1A0BdrqpkwJD+MWHUxshGOT+nbpyXrTVzweW/1e+RqyV/RiSfy7EG3W/P8GjNhl7vPPfcAk=
X-Received: from ejcst14.prod.google.com ([2002:a17:907:c08e:b0:b73:724e:575e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4fce:b0:b73:a319:e8be
 with SMTP id a640c23a62f3a-b7671a221cfmr1351585866b.57.1763981320135; Mon, 24
 Nov 2025 02:48:40 -0800 (PST)
Date: Mon, 24 Nov 2025 10:48:36 +0000
In-Reply-To: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251124104836.3685533-1-lrizzo@google.com>
Subject: Re: [PATCH v3  00/12] Coalesced Interrupt Delivery with posted MSI
From: Luigi Rizzo <lrizzo@google.com>
To: jacob.jun.pan@linux.intel.com, lrizzo@google.com, rizzo.unipi@gmail.com, 
	seanjc@google.com, tglx@linutronix.de
Cc: a.manzanares@samsung.com, acme@kernel.org, ashok.raj@intel.com, 
	axboe@kernel.dk, baolu.lu@linux.intel.com, bp@alien8.de, 
	dan.j.williams@intel.com, dave.hansen@intel.com, guang.zeng@intel.com, 
	helgaas@kernel.org, hpa@zytor.com, iommu@lists.linux.dev, 
	jim.harris@samsung.com, joro@8bytes.org, kevin.tian@intel.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org, 
	mingo@redhat.com, oliver.sang@intel.com, paul.e.luse@intel.com, 
	peterz@infradead.org, robert.hoo.linux@gmail.com, robin.murphy@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

I think there is an inherent race condition when intremap=posted_msi
and the IRQ subsystem resends pending interrupts via __apic_send_IPI().

In detail:
intremap=posted_msi does not process vectors for which the
corresponding bit in the PIR register is set.

Now say that, for whatever reason, the IRQ infrastructure intercepts
an interrupt marking it as PENDING. . handle_edge_irq() and many other
places in kernel/irq have sections of code like this:

    if (!irq_may_run(desc)) {
        desc->istate |= IRQS_PENDING;
	mask_ack_irq(desc);
	goto out_unlock;
    }

Then eventually check_irq_resend() will try to resend pending interrupts

    desc->istate &= ~IRQS_PENDING;
    if (!try_retrigger(desc))
        err = irq_sw_resend(desc);

try_retrigger() on x86 eventually calls apic_retrigger_irq() which
uses __apic_send_IPI(). Unfortunately the latter does not seem to
set the 'vector' bit in the PIR (nor sends the POSTED_MSI interrupt)
thus potentially causing a lost interrupt unless there is some other
spontaneous interrupt coming from the device.

I could verify the stall (forcing the path that sets IRQS_PENDING),
and could verify that the patch below fixes the problem

 static int apic_retrigger_irq(struct irq_data *irqd)
 {
        struct apic_chip_data *apicd = apic_chip_data(irqd);
        unsigned long flags;
+       uint vec;

        raw_spin_lock_irqsave(&vector_lock, flags);
+       vec = apicd->vector;
+       if (posted_msi_supported() &&
+           vec >= FIRST_EXTERNAL_VECTOR && vec < FIRST_SYSTEM_VECTOR) {
+               struct pi_desc *pid = per_cpu_ptr(&posted_msi_pi_desc, apicd->cpu);

+               set_bit(vec, (unsigned long *)pid->pir64);
+               __apic_send_IPI(apicd->cpu, POSTED_MSI_NOTIFICATION_VECTOR);
+       } else {
                __apic_send_IPI(apicd->cpu, apicd->vector);
+       }
        raw_spin_unlock_irqrestore(&vector_lock, flags);

        return 1;
}

Am I missing something ? any better fix ?

cheers
luigi
