Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA837701A
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517924; cv=none; b=lLoQUmHceUgT5+aqpde6sd0YEC6R8w06aFXf1f5UFY4raezmyIayXHRY1O9lbNaSwYI5juwO+VF2Mj8cukx+7dXW0wRBnjrinE0gSVlinfQX6NoVmQN787H58GrwYzgzU4jGHXlk0lJu7RZKsfaLXvzxnGO4VpVKpSmMi6Tj2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517924; c=relaxed/simple;
	bh=XMqR7Vt7Zu1rEVb/wo+OI6Zz2nFEcyiLoyMkLEqY1cA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FTpIN+jUuaSJMKh8e5QlqltVSliBt/ciokp9+fVubLgRzO/kYZOmjcDOXisHfnIdU8rWdKXzcIgw8KfBbNb209fqhY2EmkCjwL1WHcpOWHWF2ZCX1qZ91oIGjh3wXe0VbSLB/UtPeWhvLEG0Xg5IrH3gOdHgNsvlJe50Q+snYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZS4SbnrL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZS4SbnrL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so723696a12.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517923; x=1784122723; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+G9o1zSTCJcxxAOl2khdNwOmpU0MLiiAaN/I8VPs28=;
        b=ZS4SbnrLrfYYZEIcEiTBwUlEltNj14NwiyV8gXn3DRXNtjnrBZQJ1dNDy92aYTOp6I
         m/Pi6BCBVj4SrdlxouCQk3/FoJUR7uPIosytDL4zKHKsGcorNY8qME1227aMf0QtUigs
         wI8Ig49RAb1zpUwz8A5elE0mFnPSzCPCbfaZG2fKQZrgBt0KB32+R48uDGQ4nld+cnNc
         FWg4D4kxhMFLCx2oiIKbndRULdOSvSL55vRTIXtE7Qo2pTFO6K59DXRPjboH15RjavgS
         30KuXbqXxRiWG4m1d2lcFrmVclPlBgjz49J5sekeha7NRAkwWdE72zzhNAvcab9Pf9gT
         G4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517923; x=1784122723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+G9o1zSTCJcxxAOl2khdNwOmpU0MLiiAaN/I8VPs28=;
        b=JO0GT4M8JYDyA/Rt/gz/KRSYtP3Wb57jddHoivW7IVPq4WQdvojmix1GkVrGEcZNOK
         +ESINUllk+vDpmcMsvkG6f/TwIc7JEHSSTcKcShQdoSP3Zy5nZ3LsAlJZ3+8zRjEgdrc
         XoIVHHbrrbgyJnhX/A3HknEK1xmYfmhO9dG07MAG3abM2aI4uM9c77yLpHySPWqy7Juj
         Z5KEN2XjTmggv7CYjs3I2zF0Tu6ht4eB/5Oq1tDbavYGC2YN0QTVHuRN6ySCu1jpdVyf
         6oDE6jhsymiCwgPVKryTMZrOPNDI2bB5cYj6/x+jUrbrMKwoh9o9sRJKcWzibhxcdVfh
         C2qw==
X-Forwarded-Encrypted: i=1; AHgh+Rrn8V+cCqAY+rM6q8fT4R5Q8juK0TQ+ywfgPEtHTht2zmX4v/QLVBn3xItNV17Rk9bxM7nBwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzBliZw1oexLMo5YVVx1Ww9rsRhvOViz6YvbaHpOIGy4gPKVq+
	PFP2P8pyLUCJPoiszbYPcsNrq8AhEq6AnFgQnz0R85yi0n0It2oGaLs6+wZ07qFo2aEACv2/U9x
	W1uU1WA==
X-Received: from pgbe18.prod.google.com ([2002:a63:5012:0:b0:c8b:2f5f:81a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4591:b0:3bf:6f9f:3381
 with SMTP id adf61e73a8af0-3c0bc9c00b3mr3154704637.33.1783517922783; Wed, 08
 Jul 2026 06:38:42 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:38:42 -0700
In-Reply-To: <20260708091408.12106-5-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708091408.12106-1-sarunkod@amd.com> <20260708091408.12106-5-sarunkod@amd.com>
Message-ID: <ak5S4hKoGxEb-4fP@google.com>
Subject: Re: [RFC PATCH v2 4/5] kvm/svm: Update the per-CPU wakeup-list during
 vCPU load and unload
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM: SVM:

And this shortlog+changelog is woefully inadequate.  For all intents and purposes
this patch adds KVM support for GAPPI.  So, state that in the shortlog, explain
what GAPPI is (and spell out the acronym), how it works, what KVM's scheme is,
and so on and so forth.  I'm not even going to try to review the code without that.

On Wed, Jul 08, 2026, Sairaj Kodilkar wrote:
> When a vCPU is unloaded from a physical CPU enqueue it on that CPU's
> GAPPI wakeup list. Remove the vCPU from the wakeup list when it is loaded
> on to a CPU again.
> 
> Also enqueue from avic_pi_update_irte() when vCPU is not running and
> ir_list is still empty.  This handles the condition where vCPU load skips
> the per-CPU wakeup-list update when ir_list is empty.
> 
> The GAPPI wakeup handler walks this CPU's list and wakes vCPUs that still
> have a pending IRR.  Install it with kvm_set_posted_intr_wakeup_handler()
> so deliveries on POSTED_INTR_WAKEUP_VECTOR invoke it.
