Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C48258CC3
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744754658; cv=none; b=WOwNX99CnlqlJCIQOjxdywHwClM+7KvWTD4q5KFBget5vyz8S0wW+Uk1pwROAu8A0OzUr2rfYRPVKWw9GChieyAEHTWJZq7HXGdj+LJ5m8OOyvWB0p1byjt9LOFxlN5tEf88m8T5u9alu/DPPRj7IQfg4ktwGOMrty3+lKlysBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744754658; c=relaxed/simple;
	bh=ccLH6Lx5JrbQyBvu+4aoaBT9iXuBHDx/w/Prtlwl4PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYp0cqARGEvaxrZheCdc7Ym3hftU3aYPOjseWKUen20/nNv5Ob2KfVFMgFUJFS4xg/nPUmqxUNAhwp3B699ES+VToAn/U6Y8JqjaMXFHAh7BGrSUEha8yQwUZ9Hvo+UjEDnMpfcpvb7Bc0dX3vOhDMcazjJLlcRe6geabXFNnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogmsCRwD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogmsCRwD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso7135673a91.1
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744754656; x=1745359456; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wo4Okoh6l0stYAMM4y7IqfTAs0x9rsWfp3cuNWU2IgY=;
        b=ogmsCRwDr44GZQ7oltUcHxP02wsadpTU8H3e0COuFfMrz9xIzFVZmOaqEFo6ly7VTb
         nYgMeDPzgqbQdGo8bWU98/yrbBhtmUi6e1sPOXnXReunvRc4k32nSI48RJQWrAU/wDw+
         BqEEA7fvGuYoQS1ghLPXRmOyN4jtLIoIObVHovawHCC4WnBhmWBzMEOf3nvzeJtRdNX/
         hCzMlMuKCTWkXwTsECeN+vw8fDh3JfBqTjnkUqdjSQjoJ54NjK6BkGEpchl1jsvu7PPd
         kpHRJxsmOHXB3I3bnXoZtYhp6NmiEX4eDuKsSeFVm8C5X4FaTsutepTCAFWfev9x23RO
         339Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744754656; x=1745359456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wo4Okoh6l0stYAMM4y7IqfTAs0x9rsWfp3cuNWU2IgY=;
        b=tGxxBnKLUd6Wf1kSZTBkJwZ2Qu2Q+ce2cmNRsnMd2Zn9J+6Bwhv+K+sCsxKyI7X9fQ
         0JahhnBXX8MRU9H2mb9Lb4sbtH0XdTlyFhxAyEruXdrEEb+lRTijtDH5hHzGVRtQUXFz
         NLDwpLJmzL7sI5A5jbLwY7EPjYd9wPisg2cQatDk1nRAJKbcMG4Gm8dx6f7tE34LP1et
         /BFzQki+MH7+o/Vkk2NjNz8vHIGbqgZTNP6f/gNBQyW385DVxPBKPCFGD+au4KaucRL5
         MgeZTAeaCa02T11Bgie1SEbTEv/CJUCmAVmKunhCQ2Q0DYu00XProarFi0lk9uE77dtw
         EtNw==
X-Forwarded-Encrypted: i=1; AJvYcCVdq6m4/uYV2iPWVpns02hi3RqQzqgZoWl5DA/uKtyekJpgyj57GCzWTILciRZsBZHiCpVESQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2bcP0joY1iwMwMGh24u9B39glsH75QbQVvm6KkzLOpqT9RKxk
	/pj/MFWqjmwaOxS8snktbfJ1DXRv2L5GZ74DoR9UsPDOOccDVsObwYc77axjpigz80CXca0KdFY
	h/A==
X-Google-Smtp-Source: AGHT+IHFSR2PN9qWnpYuo8R+JF0mYE1/E0Gt7NN0o/QNrpDTn7/4htyrrEr0PnokOWhJQ4DnbnOqrhm7918=
X-Received: from pjbtd5.prod.google.com ([2002:a17:90b:5445:b0:2fc:3022:36b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274d:b0:2f2:a664:df1a
 with SMTP id 98e67ed59e1d1-3085ee7fd3dmr1242998a91.2.1744754655773; Tue, 15
 Apr 2025 15:04:15 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:04:14 -0700
In-Reply-To: <fcc15956-aad0-49ea-b947-eac1c88d0542@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-7-seanjc@google.com>
 <0895007e-95d9-410e-8b24-d17172b0b908@amd.com> <Z_ki0uZ9Rp3Fkrh1@google.com> <fcc15956-aad0-49ea-b947-eac1c88d0542@amd.com>
Message-ID: <Z_7X3hoRdbHsTnc8@google.com>
Subject: Re: [PATCH 06/67] iommu/amd: WARN if KVM attempts to set vCPU
 affinity without posted intrrupts
From: Sean Christopherson <seanjc@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>, 
	Naveen N Rao <naveen.rao@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 15, 2025, Vasant Hegde wrote:
> On 4/11/2025 7:40 PM, Sean Christopherson wrote:
> > On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> >> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> >>> WARN if KVM attempts to set vCPU affinity when posted interrupts aren't
> >>> enabled, as KVM shouldn't try to enable posting when they're unsupported,
> >>> and the IOMMU driver darn well should only advertise posting support when
> >>> AMD_IOMMU_GUEST_IR_VAPIC() is true.
> >>>
> >>> Note, KVM consumes is_guest_mode only on success.
> >>>
> >>> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >>> ---
> >>>   drivers/iommu/amd/iommu.c | 13 +++----------
> >>>   1 file changed, 3 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >>> index b3a01b7757ee..4f69a37cf143 100644
> >>> --- a/drivers/iommu/amd/iommu.c
> >>> +++ b/drivers/iommu/amd/iommu.c
> >>> @@ -3852,19 +3852,12 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> >>>   	if (!dev_data || !dev_data->use_vapic)
> >>>   		return -EINVAL;
> >>> +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> >>> +		return -EINVAL;
> >>> +
> >>
> >> Hi Sean,
> >> 'dev_data->use_vapic' is always zero when AMD IOMMU uses legacy
> >> interrupts i.e. when AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) is 0.
> >> Hence you can remove this additional check.
> > 
> > Hmm, or move it above?  KVM should never call amd_ir_set_vcpu_affinity() if
> > IRQ posting is unsupported, and that would make this consistent with the end
> > behavior of amd_iommu_update_ga() and amd_iommu_{de,}activate_guest_mode().
> > 
> > 	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> 
> Note that this is global IOMMU level check while dev_data->use_vapic is per
> device. We set per device thing while attaching device to domain based on IOMMU
> domain type and IOMMU vapic support.
> 
> How about add WARN_ON based on dev_data->use_vapic .. so that we can catch if
> something went wrong in IOMMU side as well?

It's not clear to me that a WARN_ON(dev_data->use_vapic) would be free of false
positives.  AFAICT, the producers (e.g. VFIO) don't check whether or not a device
supports posting interrupts, and KVM definitely doesn't check.  And KVM is also
tolerant of irq_set_vcpu_affinity() failures, specifically for this type of
situation, so unfortunately I don't know that the IOMMU side of the world can
safely WARN.
