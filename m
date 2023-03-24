Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF501210B
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 14:31:57 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso1929667ybu.9
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679668316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ty3wse5DF2ys6PoInqEvitG3vpIktmR+SFLR6U/ysFc=;
        b=KrvNTV+VwvF0CjZfmGIp7CnP7o0W8sxb7gs0MBkMD8ZiGSZMvSNH59YtWyLSriVv75
         cgruU2EOipD92w4i5Q7i03b7I3mEEtTpvjnmuHgVcjPgFvwTLCasowWJTqQSeHOE1A3K
         bpwILXupYeXhBvnmhVCFcCP+hOJpt6upQXRXeUXeqEjzPoLo2VkyGeevEW1H/dL4f7sh
         DrywnkrjwATzOEwagnfUwQOqQGEV9BqoDlFZrFUmrZFhPl7LAgczSqKx82m0ojVHCjTA
         pDK4T7uH4fGDa70GCuwVREq1Gz3Ogn6KtVU+i7hkE0cZVMtxKhsGw0yx+0wPAMaHQSnY
         vfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679668316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty3wse5DF2ys6PoInqEvitG3vpIktmR+SFLR6U/ysFc=;
        b=0Z7dfS+AbJk9LdFRcPIZJZNmCvsVgxxI/FwZjHryN33XWQQsHvGI4FagtRUuQxW9kz
         AUX/gd7U5Zgm5aIP0nW9KeQM0hevcqIOB3JNFDhddhqVRLMARzvvItdLehdmskYoNcPX
         LdkCJBGvMkDkf/3Jbs+AtFUFKkMwN4ynNknaESa/ILSBP/rnJonr9XSgsKYKGniUYYRp
         O45FgZg/Ogh0vSl9pVUAC6hjMxNl1MRAcYUxDkxDY55gA/Of+XQlKydx64rWQlB7eq0O
         +lplQBwLvjArEXcIhXIiokZ0fJ8e3uUoYQt1LtDvSR60Jc/hVrqyKQPDRokt05z4ZuC3
         myPA==
X-Gm-Message-State: AAQBX9eczRZewf3frVtmnJ4jLrCV+1zJcWhLUMmodT1V4eIjCMvsokMw
	kT/ZG7SjQw5ZAlCH4hQ7AAacJg7IIWQ=
X-Google-Smtp-Source: AKy350b/nn/R+ZOxHwMrUoKAuwzV0OlisAA4vPdStZV49dEt07t6trWRHl4OtpI5R6SD0zZLsf9Wf51b9fw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bd4d:0:b0:541:359c:103a with SMTP id
 n13-20020a81bd4d000000b00541359c103amr1122172ywk.8.1679668316732; Fri, 24 Mar
 2023 07:31:56 -0700 (PDT)
Date: Fri, 24 Mar 2023 07:31:55 -0700
In-Reply-To: <655ac0f7-223b-9440-1bcb-e93af8915bfa@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230316200219.42673-1-joao.m.martins@oracle.com>
 <20230316200219.42673-2-joao.m.martins@oracle.com> <ZBODjjANx6pkq5iq@google.com>
 <655ac0f7-223b-9440-1bcb-e93af8915bfa@oracle.com>
Message-ID: <ZB20W14VzVZZz+nI@google.com>
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

On Thu, Mar 16, 2023, Joao Martins wrote:
> On 16/03/2023 21:01, Sean Christopherson wrote:
> > Is there any harm in giving deactivate the same treatement?  If the worst case
> > scenario is a few wasted cycles, having symmetric flows and eliminating benign
> > bugs seems like a worthwhile tradeoff (assuming this is indeed a relatively slow
> > path like I think it is).
> > 
> 
> I wanna say there's no harm, but initially I had such a patch, and on testing it
> broke the classic interrupt remapping case but I didn't investigate further --
> my suspicion is that the only case that should care is the updates (not the
> actual deactivation of guest-mode).

Ugh, I bet this is due to KVM invoking irq_set_vcpu_affinity() with garbage when
AVIC is enabled, but KVM can't use a posted interrupt due to the how the IRQ is
configured.  I vaguely recall a bug report about uninitialized data in "pi" being
consumed, but I can't find it at the moment.

	if (!get_pi_vcpu_info(kvm, e, &vcpu_info, &svm) && set &&
		    kvm_vcpu_apicv_active(&svm->vcpu)) {

		...

	} else {
			/* Use legacy mode in IRTE */
			struct amd_iommu_pi_data pi;

			/**
			 * Here, pi is used to:
			 * - Tell IOMMU to use legacy mode for this interrupt.
			 * - Retrieve ga_tag of prior interrupt remapping data.
			 */
			pi.prev_ga_tag = 0;
			pi.is_guest_mode = false;
			ret = irq_set_vcpu_affinity(host_irq, &pi);
	}


> > Any chance you (or anyone) would want to create a follow-up series to rename and/or
> > rework these flows to make it more obvious that the helpers handle updates as well
> > as transitions between "guest mode" and "host mode"?  E.g. I can see KVM getting
> > clever and skipping the "activation" when KVM knows AVIC is already active (though
> > I can't tell for certain whether or not that would actually be problematic).
> > 
> 
> To be honest, I think the function naming is correct.

After looking more closely at the KVM code, I agree.  I was thinking KVM invoked
the (de)activate helpers somewhat spuriously, but that's not actually the case,
KVM just has a few less-than-perfect names due to conflicting requirements.

Thanks!
