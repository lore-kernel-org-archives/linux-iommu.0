Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52628BE0
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:20:56 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-54196bfcd5fso121137947b3.4
        for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BDyXdwLNDkkL1EG1Vlg4E16wOafaNr02fD8vdba9Dk=;
        b=RbKYy2noIQch80Msv5bqAn0EyQhd27bVKyUSI0EMZX8IuPWMo+mLVJKHSwqUfD5zMt
         1S1fMEbHqh8a+fnJiferohyaGfiQ6WbTT2eMABg4attHMptZRuReJHL4lQdFgejv4vtM
         s16zpjwXOQRsJ+YLsCocF7ZPAaq6tfdZ0Utq8NEh0JSnAfU1lch1kOy6Gb+T4vZK8OrP
         j9izUYQxl9+jkwjEN+kCtsyZG+WnWn3bD5Uij8BqKyGQzOX6LsAfBmQUtIuzDz5IKQ4N
         mj4ac674SwliP4++uxcrQMgQoUpTHfFDNqsYBozygFtoY0n9v2QBxuKjBdL7arM545og
         Uw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BDyXdwLNDkkL1EG1Vlg4E16wOafaNr02fD8vdba9Dk=;
        b=Eb96qrpbUhCQr+zlih2CVtp3lPselEkJkYqbSl3tjpugf1mfWbJQssjCRMrxZ1Chpv
         Lb+ecYfSdDFHTtElgZ64rr9Nu0g/mqIX+wkMpNhZezf6TIO2hy/6vKXJNAlEXIB3rFUK
         j6rKHw9ZopEx6QotpAP8nHBSwEFIcSXS6okUzaO+eP10/z7vVXoD0oSI0EKlTxjCjumu
         MsP/u+ArALlkG39DpHauYAdOF7z5VL2Kc9lYwZ80JzC1EE6omIYZtSfKPWwVuuwiPTuX
         cZnSHjL/90rZkROKTmn8cFIOxPIFqOlOksV3kgm7WEuzR923/jYuRMMO7PHS0x+tTdYH
         8wBQ==
X-Gm-Message-State: AAQBX9f5epNbmKkWDHWI0yY8oEjY43Z9+F0Pyw2HXbm+GSxQMSEbW1a5
	KdlkcjBan172nek0FxsuB/W8H5F9TLQ=
X-Google-Smtp-Source: AKy350Y8HtUvudF/HEaI9/VQYB1jeEz2Bcg1zL2sdiujAx+T2SuW0eY/9HbiCKVqy3WNPHtE3AE9PjyBVew=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:b75:9519:dbcd with SMTP id
 w3-20020a05690210c300b00b759519dbcdmr10605629ybu.12.1680016855844; Tue, 28
 Mar 2023 08:20:55 -0700 (PDT)
Date: Tue, 28 Mar 2023 08:20:49 -0700
In-Reply-To: <cde77b1f-e612-2a9e-e437-8892f7f1fde9@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230316200219.42673-1-joao.m.martins@oracle.com>
 <20230316200219.42673-2-joao.m.martins@oracle.com> <ZBODjjANx6pkq5iq@google.com>
 <655ac0f7-223b-9440-1bcb-e93af8915bfa@oracle.com> <ZB20W14VzVZZz+nI@google.com>
 <cde77b1f-e612-2a9e-e437-8892f7f1fde9@oracle.com>
Message-ID: <ZCMF0ReWqG0Q7Zna@google.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Don't block updates to GATag if guest
 mode is on
From: Sean Christopherson <seanjc@google.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 28, 2023, Joao Martins wrote:
> [I was out sick, hence the delay]
> 
> On 24/03/2023 14:31, Sean Christopherson wrote:
> > On Thu, Mar 16, 2023, Joao Martins wrote:
> >> On 16/03/2023 21:01, Sean Christopherson wrote:
> >>> Is there any harm in giving deactivate the same treatement?  If the worst case
> >>> scenario is a few wasted cycles, having symmetric flows and eliminating benign
> >>> bugs seems like a worthwhile tradeoff (assuming this is indeed a relatively slow
> >>> path like I think it is).
> >>>
> >>
> >> I wanna say there's no harm, but initially I had such a patch, and on testing it
> >> broke the classic interrupt remapping case but I didn't investigate further --
> >> my suspicion is that the only case that should care is the updates (not the
> >> actual deactivation of guest-mode).
> > 
> > Ugh, I bet this is due to KVM invoking irq_set_vcpu_affinity() with garbage when
> > AVIC is enabled, but KVM can't use a posted interrupt due to the how the IRQ is
> > configured.  I vaguely recall a bug report about uninitialized data in "pi" being
> > consumed, but I can't find it at the moment.
> > 
> > 	if (!get_pi_vcpu_info(kvm, e, &vcpu_info, &svm) && set &&
> > 		    kvm_vcpu_apicv_active(&svm->vcpu)) {
> > 
> > 		...
> > 
> > 	} else {
> > 			/* Use legacy mode in IRTE */
> > 			struct amd_iommu_pi_data pi;
> > 
> > 			/**
> > 			 * Here, pi is used to:
> > 			 * - Tell IOMMU to use legacy mode for this interrupt.
> > 			 * - Retrieve ga_tag of prior interrupt remapping data.
> > 			 */
> > 			pi.prev_ga_tag = 0;
> > 			pi.is_guest_mode = false;
> > 			ret = irq_set_vcpu_affinity(host_irq, &pi);
> > 	}
> > 
> > 
> 
> I recall one instance of the 'garbage pi data' issue but this was due to
> prev_ga_tag not being initialized (see commit f6426ab9c957).

Yep, that's the one I was trying to recall.

> As far as I understand, AMD implementation on irq_vcpu_set_affinity will
> write back to caller the following fields of pi:
> 
> - prev_ga_tag
> - ir_data
> - guest_mode (sometimes when it is unsupported or disabled by the host via cmdline)
> 
> On legacy interrupt remap path (no iommu avic) the IRQ update just uses irq data
> mostly. It's the avic path that uses more things (vcpu_data, ga_tag, base,
> ga_root_ptr, ga_vector), but all of which are initialized by KVM properly already.

Ya, on my Nth read through, I don't see any issues with KVM's behavior.  I was
thinking that KVM's "pi" could bleed into amd_iommu_deactivate_guest_mode(), but
I had just gotten turned around by the many "data" variables.  Bummer.
