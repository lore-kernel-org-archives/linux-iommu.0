Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED71DB95E
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381010; cv=none; b=ntBdm0DLz7xLfsVXWlsjVg+Uxm4deDmQmoWkFNTR1K2sqg4JBiBIiMDBAS+Sv7cI5Qj5Qrpw1rSE8Xe4GhafLU9DkAChGgRg5iAf1rBSRpu3JrOWUurjwTIqG6+yh6NuQIPGli6twEVhwJwhk3UgAUkn5F+oen3noSjkMyZ9G1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381010; c=relaxed/simple;
	bh=vn+VKp3Ay36aECIQWn3gk7Kfab8dWu7P+S0abFwbfXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYd+kwMohPqIpEBSxAI/uTRKrLeQSMhnXLVDorRgShkcFXBPSpAMYbJw6swvxyvJ7H/5EMhu98BlCTmtrxVlXHa8U5reTeQQPsg5XpXV6RXJYzCkDhqwm0RX6/DQJmQr5kPGMmab6tvevAPOHupY3E5gFFTJrCFy0Y8wnRUaXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsWQ0ptX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsWQ0ptX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3082946f829so535488a91.0
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744381008; x=1744985808; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WLm9nSzf8mbzQ6eRy3dVX2xRtWadZfn8/wglqYhatY=;
        b=BsWQ0ptXtoLWTwI1C3gMzVtslnrqWdK7p0b23iEDkjiMtyBt5It3oC0MVSMitl8/4O
         18lifwuD0uvhNBlEQRTz5ai7O/7T88Saf8j6GVBQ/obxoSZ6A2Nl7QRQrwoorDy3O0Qw
         sHLLTnLVFzG3ZG518wlHQUuc5OpEZaGTcf4Gr9RTC+mlAmMy2h9oU9oZ7YylFM8YKqKH
         z2ywbBx08JZqd9y/zvklmXKqi9vb0dfLv4GAx2wsysW7y/7u7IQaSeaQ7iEjYYuTdVMI
         etrMLvoR7IzaejJ9Eazmb+jovPC+G6ng0b2O1i0+yz669T+FnxqWINQ9epdzKW0NcOvF
         rqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744381008; x=1744985808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WLm9nSzf8mbzQ6eRy3dVX2xRtWadZfn8/wglqYhatY=;
        b=uldK6Ikv2lnguaNb4+Mdl17xITt2QOiFU+qdvDOPDWL4f3+Ae1f9r7wn8Yj324q1Nb
         +aHTfcoVHap/7N6ASZyn4JG8jTSPoSJIxBX6C3fMcgkl3xGJ8SeoEnbh4mw/uCg9GIQi
         pZA012ZY97cRO4mxxsm8xTsRA6hbXXJtmdyHrDx5dTWEE7k8hSMtjSLJNlQXbyjl8HH6
         nsO/QJQXwAJq8nBzjPMCBRmTV6lei2cKcTyBGAuz+FZBg73YczedloRvAncI3T1ErzXC
         AmowyErk0tUND5uFlYhrUl8zh/j41ayaBWNG0D8fqTOsV9l63/YCQU75TBwpZANY/Vg+
         Jyjg==
X-Forwarded-Encrypted: i=1; AJvYcCUeO5nQsctrIhESFq5AIQIa0XtKhTFaeufOERUwR4qQUyb+wlw6B7v97zK/oUtO1DzPnUvDIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl9qNt4t2muwXPf0n7wyzQ3ySa9b6foRmnCos/rq3vcVD1tq83
	T74f5Wlsb1yRLy9DBKbOLtR7Qg2HfsSQ+LpFlaWRcuBBD0kQHmTRI35OFUJA92NBo+5l57z0SZA
	DVQ==
X-Google-Smtp-Source: AGHT+IFATnSMfrlSoDr0AZ6VmD2LhVdWjxVhiNFsnVuSJSTgsZ8GDkGzqSkWXdTOGULav9ok7fnrCtR9H0A=
X-Received: from pjtq5.prod.google.com ([2002:a17:90a:c105:b0:305:2d68:2be6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2703:b0:2fe:b735:87da
 with SMTP id 98e67ed59e1d1-3082354ee9amr6053899a91.0.1744381008123; Fri, 11
 Apr 2025 07:16:48 -0700 (PDT)
Date: Fri, 11 Apr 2025 07:16:46 -0700
In-Reply-To: <ad53c9fe-a874-4554-bce5-a5bcfefe627a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-3-seanjc@google.com>
 <ad53c9fe-a874-4554-bce5-a5bcfefe627a@amd.com>
Message-ID: <Z_kkTlpqEEWRAk3g@google.com>
Subject: Re: [PATCH 02/67] KVM: x86: Reset IRTE to host control if *new* route
 isn't postable
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Naveen N Rao <naveen.rao@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > @@ -991,7 +967,36 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
> >   		}
> >   	}
> > -	ret = 0;
> > +	if (enable_remapped_mode) {
> > +		/* Use legacy mode in IRTE */
> > +		struct amd_iommu_pi_data pi;
> > +
> > +		/**
> > +		 * Here, pi is used to:
> > +		 * - Tell IOMMU to use legacy mode for this interrupt.
> > +		 * - Retrieve ga_tag of prior interrupt remapping data.
> > +		 */
> > +		pi.prev_ga_tag = 0;
> > +		pi.is_guest_mode = false;
> > +		ret = irq_set_vcpu_affinity(host_irq, &pi);
> > +
> > +		/**
> > +		 * Check if the posted interrupt was previously
> > +		 * setup with the guest_mode by checking if the ga_tag
> > +		 * was cached. If so, we need to clean up the per-vcpu
> > +		 * ir_list.
> > +		 */
> > +		if (!ret && pi.prev_ga_tag) {
> > +			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
> > +			struct kvm_vcpu *vcpu;
> > +
> > +			vcpu = kvm_get_vcpu_by_id(kvm, id);
> > +			if (vcpu)
> > +				svm_ir_list_del(to_svm(vcpu), &pi);
> > +		}
> > +	} else {
> > +		ret = 0;
> > +	}
> 
> Hi Sean,
> I think you can remove this else and "ret = 0". Because Code will come to
> this point when irq_set_vcpu_affinity() is successful, ensuring that ret is
> 0.

Ah, nice, because of this:

		if (ret < 0) {
			pr_err("%s: failed to update PI IRTE\n", __func__);
			goto out;
		}

However, looking at this again, I'm very tempted to simply leave the "ret = 0;"
that's already there so as to minimize the change.  It'll get cleaned up later on
no matter what, so safety for LTS kernels is the driving factor as of this patch.

Paolo, any preference?
