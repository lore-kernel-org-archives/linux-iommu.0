Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D982D7E
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039366; cv=none; b=GwCC71GMF0Cs5LasJVWeOC0V3axoE/tr02rYCe1w93YqpcqbCJV1ItnJXarvdGBJyKtve2xeD/jmg4A/2Uwd0VhXePouYcie5BMvA2VI1+bzVX8GNgHqUBliQzUQpQNmDy4mBGQQ9MI9rWjudVZf7wSeF17baPG9vm+ZmtbP9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039366; c=relaxed/simple;
	bh=5a50XFyy6hbMzQLCzCl9kkt/qQbAxlHL862YhlOKj08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaE2PdjSxPVmZRaBhFc3MsL65PXwksOhICSWI8EyI3n4hRVaGvtTpoZzzqnFKzEiAOWoMRfMq03LQHPXKxp2Yv+w9S7A5gF1wTxi6HH4SuqrZMyiJEoMxsNkwCRt+jK2evZFQniSF+jLSbdp03cApahhvK5FDBDuF2F43aGJ4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZjAbReJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZjAbReJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so4143743f8f.2
        for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 11:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706039362; x=1706644162; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qE28dlWF6DGyTTPmng9ihaceKW+IRRh93UPoev7s84=;
        b=OZjAbReJYEt7q9LAyn88qSuJvjoRNAUyU6ZFmwrrqQoY4zyitzj2w6JR1c01rpKftu
         +vnYRdyi7r0QxnrYYofburgMP+UKiSKvmNoGfKNbA/ta5tdWXMx4NfKxda8o75ZpJjPN
         IaquvCSlrjrHSGSguAqvJypV+g7mAZSTdoNfd/XsGtoau5tQNieCznP9BEI6FFTVvuEe
         KTTBBH9KwvPNQbk0tuwbd0eo1p1EUWErIKmlO1cR8rS7hD2t8+EWvx5A6EUGNuQ5sDqx
         pXuRQmLTdMcPnbjfliKY3cNEK6CO8ygTYeTgj+FfNBTXFMnMeHP6QSZ3MTc3OaPIKyaz
         NFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039362; x=1706644162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qE28dlWF6DGyTTPmng9ihaceKW+IRRh93UPoev7s84=;
        b=hrBDPyCRHpzNFmmNpZqJ1I5EP+jsLeMozcKOZk33Iud1pS0pIQYz5eNL/OuTzs14NQ
         fp5kUCqoB1hewD5LXdaJpZtp/IXMEwiQ6BqCKNe1wQPrvHYgeOkhZJ0558Z87mx6rICn
         2L9/e+RqTBG6TzsPYtpxrSJ56BwOTXZcqcXSfwEjGHv/6cXPh6KylFznhLI2jCk56G0T
         gpY2SnQjqyGNtxlYAaWgxaJtIiSNaTZa2KVkrAlYzTT8OtoLsvixTw73+z99he/M8NDP
         fK7+FCS4Tbq1dITYtZVIr+H7GyHO+znUTzGsS/6iGNkafKxFRs6Djd9j3rNCYhQdVpFR
         adFQ==
X-Gm-Message-State: AOJu0YwvAoc7hbanc6/HKuWZ2xQbbhmPCE3t6ZeeFeJEXzjb0BhqhcSe
	6zyTVvyZwXLUqeRn50Il+2RDBlNWrKdZdqe+88qw8MQ6vP9HSRmbswVup6vnSlk=
X-Google-Smtp-Source: AGHT+IFumTc9KtJ/kCVLcF8NzAKi14YhOjo/H7kRpM6sr9VqFP25QaURtKyQ3GiPFue0ZdupifoJrg==
X-Received: by 2002:adf:f70f:0:b0:337:c93d:fe44 with SMTP id r15-20020adff70f000000b00337c93dfe44mr2726111wrp.58.1706039362497;
        Tue, 23 Jan 2024 11:49:22 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b00339237a2752sm10844430wri.33.2024.01.23.11.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:49:22 -0800 (PST)
Date: Tue, 23 Jan 2024 19:49:31 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Sebastian Ene <sebastianene@google.com>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, smostafa@google.com, dbrazdil@google.com,
	ryan.roberts@arm.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 12/45] KVM: arm64: pkvm: Unify
 pkvm_pkvm_teardown_donated_memory()
Message-ID: <20240123194931.GB40099@myrica>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-13-jean-philippe@linaro.org>
 <ZaVCTuM7KDSWqqaE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaVCTuM7KDSWqqaE@google.com>

Hi Seb,

On Mon, Jan 15, 2024 at 02:33:50PM +0000, Sebastian Ene wrote:
> >  int __pkvm_teardown_vm(pkvm_handle_t handle)
> >  {
> >  	size_t vm_size, last_ran_size;
> > @@ -813,19 +802,18 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
> >  		vcpu_mc = &hyp_vcpu->vcpu.arch.pkvm_memcache;
> >  		while (vcpu_mc->nr_pages) {
> >  			addr = pop_hyp_memcache(vcpu_mc, hyp_phys_to_virt);
> > -			push_hyp_memcache(mc, addr, hyp_virt_to_phys);
> > -			unmap_donated_memory_noclear(addr, PAGE_SIZE);
> > +			pkvm_teardown_donated_memory(mc, addr, 0);
> 
> Here we probably need to pass PAGE_SIZE as an argument instead of "0"
> to make sure that we clear out the content of the page before tearing it
> down.

But since it's replacing unmap_donated_memory_noclear(), would that be a
change of behavior?  That would be a separate patch because this one is
just trying to refactor things.

Thanks,
Jean

> 
> >  		}
> >  
> > -		teardown_donated_memory(mc, hyp_vcpu, sizeof(*hyp_vcpu));
> > +		pkvm_teardown_donated_memory(mc, hyp_vcpu, sizeof(*hyp_vcpu));
> >  	}
> >  
> >  	last_ran_size = pkvm_get_last_ran_size();
> > -	teardown_donated_memory(mc, hyp_vm->kvm.arch.mmu.last_vcpu_ran,
> > -				last_ran_size);
> > +	pkvm_teardown_donated_memory(mc, hyp_vm->kvm.arch.mmu.last_vcpu_ran,
> > +				     last_ran_size);
> >  
> >  	vm_size = pkvm_get_hyp_vm_size(hyp_vm->kvm.created_vcpus);
> > -	teardown_donated_memory(mc, hyp_vm, vm_size);
> > +	pkvm_teardown_donated_memory(mc, hyp_vm, vm_size);
> >  	hyp_unpin_shared_mem(host_kvm, host_kvm + 1);
> >  	return 0;
> >  
> > -- 
> > 2.39.0
> >
> 
> Thanks,
> Seb
