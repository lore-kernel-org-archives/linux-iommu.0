Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887AD4499B4
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703962; cv=none; b=LYWLgP2ZMbNlRnlKSSB0CDoGT5VFFaHpBW8SChmOhjUV+RsSMVnYYFQpeGAfjWBS0zfLXf8un/oYhaxb74bgnZkCzUDopBAd4jMktx1NT2Of7JKRCo4sdOV7fNaLiLVmdck7C+1ixI0SAgXiP+C6Yoxvr6k14uHCG3EmHZsEXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703962; c=relaxed/simple;
	bh=C7s5jAd/T3HA9BZzIyyz+yXgtX3iska8zCISmuUMLlE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hkrvwfu9jWpOjLUPvzwWneXaNYdMX61mxR3u1kxIBC2nM5K7mucrUinJQdHfYsxSLA3IsDATKB6Wa/9yQY3HsIYIbUx8+3qHa6kOH6cN59preTOp9orK8OP9ZU9YVy0Tbm/rFLapWxb3GvJz5OlMW00ffsmgCxgHVmcET2L3uGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2paQX6m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2paQX6m"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca8409ba0easo1905635a12.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783703961; x=1784308761; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VRZ45JtZZxDdYD7+bsxG2AOz/hLWpM5AAXGE7/MLeMI=;
        b=M2paQX6m95OS9AkrFhXpi9xAc8THs4O1lsZoIMvGkR6NQ+SogUfAuajra05tbWetMu
         OX2Ayji7eOkBEUZwlo70re8Jpnd3ObbhXRKqvx6tN7cOfeP5Sx6UthL1LP7V5PDVQLNp
         89H8Ik0HaY5opZ3OJ4r/JevKIDBQ6ZyU/V+EiM2l3GY4Lm08l+4Gvajo+wetQF6Wk49+
         rs6s2IiyeA3AOOlI34xGW3NLPxsnooAT32YI+XPLsc8hk1d8MFtf5PmcL1Df7zmnlFBf
         8VLCRHiogMwubU8cZMvEbMLljKptle2KX1eYUd2QOpslj63Lk6UYqmvSGe3aedlWSNwL
         LS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703961; x=1784308761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VRZ45JtZZxDdYD7+bsxG2AOz/hLWpM5AAXGE7/MLeMI=;
        b=Tqbx28LyH8wLzAX6DXI7oO61FWG5GrH34lNkDaE7AFwt+LYpRXn4mkmOTVprBfmwyI
         xku42xBL0f3FPPW5yEEwXhn+TUDB7srWBMJBKPDEee3jgyOmif6VkZLi7qLHFoUM0fe5
         ITPZMXSNRr2MY4pifEp73gMA+WJZ87hK/z1erBakkMVoRUqOUPN1gW/lbodT8IgzQfN1
         YRIBbNdkq8tIcG7XOUhXwAOHXJWVIFy/FuRIFlDlvPqBHLWthTFT5AzhegfHo93+34Ce
         mo+5T0K9fw1JJRCMrCxCBu9F5QkAwM5TpKS1krlr8KhsXeFH/k7qF7Ac9IMGsYrhv0HN
         CobA==
X-Forwarded-Encrypted: i=1; AHgh+RpMSU2lSOp4e3T/cZmKPPhT39uFfK/9GsXRokr/V6e3vDxfes+ZXxCn1TQSVZ3XXcdFvklFMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlxzLvNf+KUxK3y3vtqR4u971ZrcMPVqlTg2tybmLBm/NqDVmH
	nfhRJ8rWvLOPyWLVaiXmwH2RbVwh8I2Q+U/39zOvDI+v0IoIxvFtgeKy4xrcdBnSOqFI289G+m7
	o7N7n+A==
X-Received: from pgii35.prod.google.com ([2002:a63:2223:0:b0:c9c:a355:d74e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d09:b0:3bf:6c27:38d
 with SMTP id adf61e73a8af0-3c0f131c358mr4487356637.31.1783703960757; Fri, 10
 Jul 2026 10:19:20 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:19:20 -0700
In-Reply-To: <f3037b16-0974-4c6a-9914-50f0401af656@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708091408.12106-1-sarunkod@amd.com> <20260708091408.12106-2-sarunkod@amd.com>
 <ak5SXWcvtVLL0eKs@google.com> <f3037b16-0974-4c6a-9914-50f0401af656@amd.com>
Message-ID: <alEpmLuz1mGqonj7@google.com>
Subject: Re: [RFC PATCH v2 1/5] iommu/amd: kvm/svm: Improve API between SVM
 and AMD IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, Sairaj Kodilkar wrote:
> On 7/8/2026 7:06 PM, Sean Christopherson wrote:
> >> @@ -949,10 +950,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >>  		 */
> >>  		entry = svm->avic_physical_id_entry;
> >>  		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
> >> -			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
> >> +			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
> >> +			pi_data.flags = AMD_IOMMU_FLAG_VCPU_RUNNING;
> >>  		} else {
> >> -			pi_data.cpu = -1;
> >> -			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
> >> +			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
> > 
> > "posted_intr" is misleading, and IMO flat out wrong.  Even when a GA Log Intr
> > and notification is logged/sent, the virtual interrupt is still posted to the
> > vCPU's virtual APIC.  I have no idea what you're trying to capture with this
> > code.  And that is yet another reason why this patch needs to be split up: so
> > that you can explain the reasoning and logic behind this refactoring.
> > 
> 
> I needed an generic name for boolean that is being used by both GAPPI
> and GALOG, hence I replaced ga_log_intr with posted_intr. But I can
> understand that it can lead to confusion. How about replacing
> ga_log_intr with wakeup_intr and AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR with
> AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR

Yeah, wakeup_intr works for me.  I don't love bleeding KVM's usage into other
parts of the kernel, but the POSTED_INTR_WAKEUP_VECTOR ship sailed a looong time
ago.
