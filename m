Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFB1F2B90
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380629; cv=none; b=Zpc6t/YC2p/42thts5LpKZr21xMrEAQ6PlMQyswAdV4ski1OIswVBSJHBoa2B79I/x2et/iLAUODDXl8HZ5NlmT5a5uZDeGHZCXQ2d09lVAs3sDSFNcMC1nBUd2GxF3D0+D8e+VlVnw1PUb3wE/ZoRK6bdwWF+WyAhXZ76YOr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380629; c=relaxed/simple;
	bh=IN/+c393zV8GLe2RZvcJ5D/UQHgVQBfnFKT0jSH76NQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0clnky0gm0B1c6pvvB8bI7Sr8k0y5/R5x+Wx1luyMcAgx0EGquCvkWTx5jcFK9+w1P4PO9NCYLH5viulNrD0+GmhPtMC5j/ErcROV1jUPl6QleePbQEulaCayVgCqjCqQAMXC6CEnI1atyACzdSHOnI7vkTQ/Id+yGqSqdh27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjqZnJcF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjqZnJcF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254e500a73so15837155ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744380628; x=1744985428; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHKInpn+xU6ux5UPqfyiTHJx6fsp5WeMoLWQfB1NP+8=;
        b=cjqZnJcFQgFn8JA8ywk4XZa7ELis4/Y8aISvFdVZdFecBRmCU95ur9UstXbqgXJjej
         +mjfgQLNIdsiMvuqLeIXNg2cjVf+sCTPe1nFRzm/Q57pjsWRm1mbfvDgw4+qMWrIAA+R
         QWB48BFcxrJKaWnXgKcU30YsLEP51gURK4uOLSXOsx6LgH8EKYxPqONIBf3VxYaVe4LV
         72GbKGz6iOQTDY3D23FUogW3Nw3KRjME3TNeFadTascoeWoI6hmFxJvR1LjhUoNPY1xA
         zyvsEv5pHIuoBheJNz+nSvWv4N7az+vurPtD7Z3fa/dfp9sg7VuiaQWAJ1dONzxRwSp0
         IgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380628; x=1744985428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHKInpn+xU6ux5UPqfyiTHJx6fsp5WeMoLWQfB1NP+8=;
        b=JMG/2sU0rMvXW/lJwiJEADEMip0siAht5d6X0v4XiHw5h6E9Kzv7xZt4Qz59Uhp7pz
         sjccV0aaDptwq4wTbKzSn4ZnI9YVMujnXFXBvznl0ToVH4UFJoblWhfxEIyNi5kTt4JV
         Pav0SFBerA8/z2RVbParGNIhHSO9r0vfUT8pOH/37902Qz4DmIx4Ulx4NYbVsRbAjIOm
         HTCgS3kTR9RVr2nVyNsB/5GaYLj56+ETfBYuyBpQbtYyCX+JjjUJaF902T7lhURBy9k6
         f5SH1DarxAK3pVSJm1N1ZFLiTIQD+PkNlPdMWPMaAcK9eWtMM9ZiofSfQsRp8Ug+REwa
         WHJg==
X-Forwarded-Encrypted: i=1; AJvYcCUUx/Sy7T36p2fVOGC+G+hqqWjScA9OhYTwHg9D2+41RQrl/EE3ZToqOeOLqhpSIbOOo7gZjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHpPsdNgqydoCA46RrX8M8JbMHZJ0J3TbZcB9giLaqcvsVGQxt
	YDwCotHH2WVymAKdnilquHDTKctBSVeQqnW1u8rd2sEszKADPHoWJ2f6cWahStxOdhyu3fFC+wQ
	y5g==
X-Google-Smtp-Source: AGHT+IGc8VAEmdu1RE7oH9FrOwfX7qVcVEStmOGwcbBo53IVWdDDkx8s11OnWyHGn0RRA5FtWaNzoX9rHXg=
X-Received: from plda17.prod.google.com ([2002:a17:902:ee91:b0:221:8568:bfe3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec9:b0:227:e980:9190
 with SMTP id d9443c01a7336-22bea4fcad1mr47422905ad.44.1744380627769; Fri, 11
 Apr 2025 07:10:27 -0700 (PDT)
Date: Fri, 11 Apr 2025 07:10:26 -0700
In-Reply-To: <0895007e-95d9-410e-8b24-d17172b0b908@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-7-seanjc@google.com>
 <0895007e-95d9-410e-8b24-d17172b0b908@amd.com>
Message-ID: <Z_ki0uZ9Rp3Fkrh1@google.com>
Subject: Re: [PATCH 06/67] iommu/amd: WARN if KVM attempts to set vCPU
 affinity without posted intrrupts
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>, Naveen N Rao <naveen.rao@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > WARN if KVM attempts to set vCPU affinity when posted interrupts aren't
> > enabled, as KVM shouldn't try to enable posting when they're unsupported,
> > and the IOMMU driver darn well should only advertise posting support when
> > AMD_IOMMU_GUEST_IR_VAPIC() is true.
> > 
> > Note, KVM consumes is_guest_mode only on success.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   drivers/iommu/amd/iommu.c | 13 +++----------
> >   1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index b3a01b7757ee..4f69a37cf143 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -3852,19 +3852,12 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> >   	if (!dev_data || !dev_data->use_vapic)
> >   		return -EINVAL;
> > +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> > +		return -EINVAL;
> > +
> 
> Hi Sean,
> 'dev_data->use_vapic' is always zero when AMD IOMMU uses legacy
> interrupts i.e. when AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) is 0.
> Hence you can remove this additional check.

Hmm, or move it above?  KVM should never call amd_ir_set_vcpu_affinity() if
IRQ posting is unsupported, and that would make this consistent with the end
behavior of amd_iommu_update_ga() and amd_iommu_{de,}activate_guest_mode().

	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
		return -EINVAL;

	if (ir_data->iommu == NULL)
		return -EINVAL;

	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);

	/* Note:
	 * This device has never been set up for guest mode.
	 * we should not modify the IRTE
	 */
	if (!dev_data || !dev_data->use_vapic)
		return -EINVAL;

I'd like to keep the WARN so that someone will notice if KVM screws up.
