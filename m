Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71C227E92
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903211; cv=none; b=Vq05V+PMLfHWsDhFpcwZBvh/xNXDYiz5sfT2wo4UIiHXIqJnotZdPavJZPGbxxIhMuuuEJ05EWAoofI2M6ci3EhoghjyvjaOrM0c5ZtB4lHCxzRncbA/ks0hvFF8PPDbWN2bpK9zh4UEmEzB/LbCleeL3ZoTvEPoFCRXhJfuz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903211; c=relaxed/simple;
	bh=c+BDr4P7jNalnDKIP6u0X6a/Cl+H/puu3xwpkfVmgA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zit2yvxK/dmK6eccaPLLhZkYFLhLfxNKJUWEjT0DegFpuYMwlVRcA2SvOYy7UWNaRjSwAQOZP1GyUU1XVMHm6p+r6qSJQA4rzTD9LV9OCgvrQTnPcmcrYq7cDhSGg5oEO3woBE4JMTtK+oNaypeK0Jaa2Ah5jpqWtOkpAnjyG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSRGkDOK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSRGkDOK"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73c09e99069so5429402b3a.0
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748903209; x=1749508009; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdJnF0896Ypx9eyH3mHj+rVd2VxznzYekZ5A4PKpgUE=;
        b=zSRGkDOKwTW4VqS3gKFLRZq2G8lOYF9PHXoWqLats8qgdJjXaoMywn5Rm35sGcT1R/
         w+PcTDGndFIxq1LXu9DBluz4FiM+KHpLtGUspdQnTNf+xjy6c1M3QM5/3NmX+HrNFFS8
         1JcotBH1zrOcgPnT2WnVH3kuMBrxo/UYiK6jmSzy1D7fpEIr3Zd4exSZYUedGByenJXH
         brhoZ9KrsCrQET7bodcvUNde6QH/H6o4tg4IThgy2wl5ChqLCCrTt41f0aIH9VRet5ET
         nObqyJzIOSuJ14mLZD2o3BFl7GWD7qEXHlGz4CI9a9+vYN0OdSlE+1AdfIuJy4ldeK+M
         yweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903209; x=1749508009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdJnF0896Ypx9eyH3mHj+rVd2VxznzYekZ5A4PKpgUE=;
        b=oUfjAPbnn/+UDX096DFVSqHp0iJ7nzhuseRTkKrEuEGwplRN0uvv2m3doNRz/tNas9
         TA967N3HCxODWlzQBYH7G+yad92Ejk9th8Eu6kfFVTgYnV2EPaqZmlt/umH0U0JRT13I
         w8yYb+j08Van10uAtw4sRuZM2EVdK9ZZ+daD3/Sh0ZypXZ106xLzxSZ1y6Al+oEdqQP3
         H2cwWfg0mNXsh5Mneo2p1xwWWo9CSQDZhKYSffEis0eYCkiiHY4QmLu/e0L3AgCgP4TB
         cjBDltKvv/3Cev5nq3pGS8k0NlcaHCacSVzdpkXer7j6x0FC8FHZ243MfziMkPSJ2QLq
         zh8A==
X-Forwarded-Encrypted: i=1; AJvYcCXSdV0/aIFOMfrVikvQS5XHWVA0Ik3YF3ShDkJBONebi8Cora0dl4IcXmpDV3Wyt55CtWa4Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWF0+0a4oX1nDY0XchWfrbdNc80pMbCC+kIhkNF5woaPTFgDev
	uEZ3Y+FIIdhbr7eJu02lJgENnqkJv3cHQduXVK5gX5kn9b1eAmF2dWBgevtnDhLKqheFSlFEYTC
	FIEDnAQ==
X-Google-Smtp-Source: AGHT+IFuNo5ZnwTVE6yOLsfBnqP+WjCy7EMLzRmm6zfdCY+/FJKXvUUZBo59GAd71qcOacDTj+nt+tjQ1PY=
X-Received: from pfbit20.prod.google.com ([2002:a05:6a00:4594:b0:746:21fd:3f7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23d1:b0:746:3200:5f8
 with SMTP id d2e1a72fcca58-747d1afd58emr12433194b3a.22.1748903208790; Mon, 02
 Jun 2025 15:26:48 -0700 (PDT)
Date: Mon, 2 Jun 2025 15:26:47 -0700
In-Reply-To: <a30dd520-b6d2-4ae8-86f8-d4f71ef3e0e0@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com> <20250523010004.3240643-42-seanjc@google.com>
 <a30dd520-b6d2-4ae8-86f8-d4f71ef3e0e0@amd.com>
Message-ID: <aD4lJyqHswt-Mofy@google.com>
Subject: Re: [PATCH v2 41/59] iommu/amd: KVM: SVM: Add IRTE metadata to
 affined vCPU's list if AVIC is inhibited
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Vasant Hegde <vasant.hegde@amd.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, Francesco Lavra <francescolavra.fl@gmail.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 30, 2025, Sairaj Kodilkar wrote:
> On 5/23/2025 6:29 AM, Sean Christopherson wrote:
> 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 718bd9604f71..becef69a306d 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -3939,7 +3939,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
> >   		ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
> >   		ir_data->ga_vector = pi_data->vector;
> >   		ir_data->ga_tag = pi_data->ga_tag;
> > -		ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
> > +		if (pi_data->is_guest_mode)
> > +			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
> > +		else
> > +			ret = amd_iommu_deactivate_guest_mode(ir_data);
> 
> Hi Sean,
> Why the extra nesting here ?
> Its much more cleaner to do..
> 
> if (pi_data && pi_data->is_guest_mode) {
> 	ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
>    	ir_data->ga_vector = pi_data->vector;
>    	ir_data->ga_tag = pi_data->ga_tag;
> 	ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
> } else {
> 	ret = amd_iommu_deactivate_guest_mode(ir_data);
> }

Because the intent of the change (and the long-term code) is to affine/bind the
vCPU to the IRTE metadata, while leaving the actual IRTE in remapped mode.  I.e.
connect the passed in pi_data (@info) to the the chip data:

	pi_data->ir_data = ir_data;

and set the GA root, vector and tag in the chip data.

		ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
		ir_data->ga_vector = pi_data->vector;
		ir_data->ga_tag = pi_data->ga_tag;

That way if KVM enables AVIC, KVM can call amd_iommu_activate_guest_mode() to
switch the IRTE to vAPIC mode.

If KVM doesn't bind to the IRTE, KVM would need to track all host IRQs (Linux's
"virtual" IRQ numbers) that can be posted to the vCPU in order to active vAPIC
mode.  It would also require taking VM-wide locks in KVM in order to guarantee
accurate IRQ routing information.

FWIW, I don't love that KVM essentially backdoors into the AMD IOMMU via
amd_iommu_(de)activate_guest_mode(), but I also don't see a better alternative.
E.g. on Intel, KVM just leaves the IRTE in posted mode, and relies on the notification
vector IRQ to kick the vCPU into host mode so that KVM can manually process the
PIR.

But that trick doesn't work as well on AMD, because the "guest isn't running" IRQ
will hit whatever CPU is handling the IOMMU interrupts, not the CPU that's running
the vCPU.  I.e. it _could_ functionally be made to work, but it would likely yield
pretty poor performance (and would require a decent amount of new KVM code).
