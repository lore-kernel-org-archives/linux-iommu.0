Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4AAD32
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 21:01:03 +0000 (UTC)
Received: by mail-pj1-f73.google.com with SMTP id q30-20020a17090a17a100b0023d376ac2c5so1306892pja.5
        for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679000463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVK7JSTP093HSgALaT47Fh8+kh5wLz2pU0fw8h+uNzk=;
        b=VC+7zohdtySY73Crulq7TLz1D3N6/p5iXZkoxtBnpdgSSjnFYB7GYb4W93JJnnTtmR
         MO9hM46dRuwESNW94ndnrSKz3ojzGoDmTdbYpT331oWt8LyUwG5rYyj2iQgGxkGGmwbz
         E7+4Bez7jaOUKPfNk5CjnNU2e9smqF3th9aK0yWtyZX981bJy/FVZCYZ30ijiIXz9z6j
         qq0KvbNw7/H4Wo2oLdAPRMYnfE1mCJDUiRWmRt1/fQ84mxFWQpIFwoZhh9niw2trS2d3
         U2pHxh58XMA6Q66Ca3H/fnRVDi16tsjig1P++9v9cVOVHr9NUQJPbX0BvvfQHc8XgXu1
         xjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679000463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVK7JSTP093HSgALaT47Fh8+kh5wLz2pU0fw8h+uNzk=;
        b=dv41yK5m17di/w5IXbnFbSgxHda/3UpJUUVBuX2pG+qNGIadsUDcqNu61wDaLvpn4T
         f4Zl7bgDOzW3CWJxmnH6upEswfQqC4FiqSf6Z2FYQ6nxrg5oYqPPuITxWiHfvLk6tsau
         I/UADSz3ryiHoc22Jv/iTVzasa6FKoqKzysBEwVj4H8jxOhCq/bsA7t1GWZ7wnSEW/nB
         gZwSqchiV2xCnb6fDy7yb37TItj1Gl39m5D82V80ZuthSQOyTF0l7xyXj+FH/ZUto0cT
         nI3IZA8dn7PKAClVD87NX4+IbcCMfAs07b8/8F6o1141j+IAayRkdOJCApcyIwgr78rQ
         4jgA==
X-Gm-Message-State: AO0yUKUqzeLFIKUD7iyulqscs1kTr0aIKypQxJYi3uUmoiRkicvPpVPY
	hbcKgqEr+2unUzEaDTmolVfuJdA2cWg=
X-Google-Smtp-Source: AK7set+IknJoLX81zWcYwrbBvfKblRTYauFuiDDs8zokETO8eOVd3VU9JV4OYu6ck+KbMc0ZQD1hxNg9Xgk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3183:b0:236:6e4c:8a1e with SMTP id
 hc3-20020a17090b318300b002366e4c8a1emr1592277pjb.1.1679000463421; Thu, 16 Mar
 2023 14:01:03 -0700 (PDT)
Date: Thu, 16 Mar 2023 14:01:02 -0700
In-Reply-To: <20230316200219.42673-2-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230316200219.42673-1-joao.m.martins@oracle.com> <20230316200219.42673-2-joao.m.martins@oracle.com>
Message-ID: <ZBODjjANx6pkq5iq@google.com>
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
> On KVM GSI routing table updates, specially those where they have vIOMMUs
> with interrupt remapping enabled (to boot >255vcpus setups without relying
> on KVM_FEATURE_MSI_EXT_DEST_ID), a VMM may update the backing VF MSIs
> with a new VCPU affinity.
> 
> On AMD with AVIC enabled, the new vcpu affinity info is updated via:
> 	avic_pi_update_irte()
> 		irq_set_vcpu_affinity()
> 			amd_ir_set_vcpu_affinity()
> 				amd_iommu_{de}activate_guest_mode()
> 
> Where the IRTE[GATag] is updated with the new vcpu affinity. The GATag
> contains VM ID and VCPU ID, and is used by IOMMU hardware to signal KVM
> (via GALog) when interrupt cannot be delivered due to vCPU is in
> blocking state.
> 
> The issue is that amd_iommu_activate_guest_mode() will essentially
> only change IRTE fields on transitions from non-guest-mode to guest-mode
> and otherwise returns *with no changes to IRTE* on already configured
> guest-mode interrupts. To the guest this means that the VF interrupts
> remain affined to the first vCPU they were first configured, and guest
> will be unable to either VF interrupts and receive messages like this
> from spuruious interrupts (e.g. from waking the wrong vCPU in GALog):
> 
> [  167.759472] __common_interrupt: 3.34 No irq handler for vector
> [  230.680927] mlx5_core 0000:00:02.0: mlx5_cmd_eq_recover:247:(pid
> 3122): Recovered 1 EQEs on cmd_eq
> [  230.681799] mlx5_core 0000:00:02.0:
> wait_func_handle_exec_timeout:1113:(pid 3122): cmd[0]: CREATE_CQ(0x400)
> recovered after timeout
> [  230.683266] __common_interrupt: 3.34 No irq handler for vector
> 
> Given the fact that amd_ir_set_vcpu_affinity() uses
> amd_iommu_activate_guest_mode() underneath it essentially means that VCPU
> affinity changes of IRTEs are nops. Fix it by dropping the check for
> guest-mode at amd_iommu_activate_guest_mode(). Same thing is applicable to
> amd_iommu_deactivate_guest_mode() although, even if the IRTE doesn't change
> underlying DestID on the host, the VFIO IRQ handler will still be able to
> poke at the right guest-vCPU.

Is there any harm in giving deactivate the same treatement?  If the worst case
scenario is a few wasted cycles, having symmetric flows and eliminating benign
bugs seems like a worthwhile tradeoff (assuming this is indeed a relatively slow
path like I think it is).

> Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation code")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..bf3ebc9d6cde 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3485,7 +3485,7 @@ int amd_iommu_activate_guest_mode(void *data)

Any chance you (or anyone) would want to create a follow-up series to rename and/or
rework these flows to make it more obvious that the helpers handle updates as well
as transitions between "guest mode" and "host mode"?  E.g. I can see KVM getting
clever and skipping the "activation" when KVM knows AVIC is already active (though
I can't tell for certain whether or not that would actually be problematic).

>  	u64 valid;
>  
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
> -	    !entry || entry->lo.fields_vapic.guest_mode)
> +	    !entry)

This can easily fit on the previous line.

	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) || !entry)
		return 0;
