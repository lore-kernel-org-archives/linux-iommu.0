Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222E20318
	for <iommu@lists.linux.dev>; Fri, 31 Jan 2025 01:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288106; cv=none; b=MtbqPLnelFRF6BfKqR0xMxYOB6vtuH9q6YKPalnuAMuxXCJkMfXP/RGvyqb17+8lW4HNWOdgJxdd5T9NB9CYnTXQrduijGM4F+BJ0D+pniVVcfoIjUK2qpNknn+rw0BPS3ZLHqEBPOPgs+tUsPCwr7C1Krp6Ppfw4amC9TQ36ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288106; c=relaxed/simple;
	bh=PCcWp1tjtTTwT+4T+gwNe8f1pHXDJ+jDQQs7L3JrJJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uA66EEX7nvh9HXu+QI/nTz0hpQcb014FcGLV97kqyJ00Pnr2TkBp/WuITQCNyOsv8wQ+wQldm/+0W5H4PE2/RdAT4DGpV6ijVLW/CcSuxo3dqvebFZ5cLu/yNQxHBfGvia0jK5FD/i/kqupdFqyd9PEbrppEJPwvV0SdIp200nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBFs5JFV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBFs5JFV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-218cf85639eso43696185ad.3
        for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 17:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738288103; x=1738892903; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yk4T/kfqEFgVa3SrODaXARdMdIV0x31oxIDNkWjd6DU=;
        b=aBFs5JFVyUKZCjzbQmfjNBLTWNR/N8ztsVCvcuxiWnBvpxZwfDqQO/Ax5rr/TtB+lg
         T21AOFth6TIJQSyRz/A4bYsEm3Lo3xfVoAp9lzOX26xxHRRcNKzyG6JgW35UbqOweC+9
         EjJT5XW2/P0dy/Desinz8aypsDAUUEIWTdDvV5ZKcufRl6zTjVgzJrZhieYcfbpViYaC
         1YgmrEfBQlsPqYzzahthFLrEPtNEFWJelPRgzT8EshgVgvEDpNbiVpf/MEqOV9NjbsxF
         fO/HJkwl4S43fyBrObadrcEXX+y55Lfmc4niUkfvtTKb5SlFRnWkoPdBA6NNQd/uG05K
         Qd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738288103; x=1738892903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk4T/kfqEFgVa3SrODaXARdMdIV0x31oxIDNkWjd6DU=;
        b=tuBRjuLT0Blc0pUrCAS9EF/sd7CsGVJCWoJY00mhVVFay4undA1zY9vLRBxywqalAj
         c0biE9cLfIQ9OoafJROADyVaRNZkIIYiFMqREhudD/u9/D2C/TnWNwvcvF29RNbzPbf1
         8fLt1Z3Gtqx9VRPuUOtYj+r7GPpacnDVmTurlBmRL8z2FuRBq/WtDsQNhStBYH+r0evm
         IrYoAAp8zNOtpq+BApkjBzapwdCkBwc0iCWd+GAt0TIsMSqzm1tGlC4VjGeRQfbJe7nR
         N+2KYYhLttGBpxAoFbBYaif+tlI9mclKrNXA+F65xXenv1tk06iAoeRqzANJOsoH8d8K
         mVHA==
X-Forwarded-Encrypted: i=1; AJvYcCUy65p5HSW+IljqyNTz6TUh7nUuF2pdVpfoqXUUq9AHBZr8hb+DTFQ8OrW/j4ie4l4oFRBq0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGAUp2uHUEpTySpdcjNP3kgS14V+IX+3srUvb0rmzNux+82Vj9
	Tkgif4FAg08qK1EcrWjE0QdyghLU+q8qCcNhIo3+T6g7pQqGygdwhgDE1bQ3ZaLnnbdjJWVN2E6
	kBQ==
X-Google-Smtp-Source: AGHT+IG0aBeCk8/iEUAOZ9Ro4ZQRn21EJE6cjItE25bpHK7iUdp9q2QgGNTaw88LaidLTqtzkYVxy3WfYW8=
X-Received: from pjbso10.prod.google.com ([2002:a17:90b:1f8a:b0:2ef:82c0:cb8d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70c:b0:21d:3bee:990c
 with SMTP id d9443c01a7336-21dd7de15b4mr143430755ad.42.1738288103586; Thu, 30
 Jan 2025 17:48:23 -0800 (PST)
Date: Thu, 30 Jan 2025 17:48:22 -0800
In-Reply-To: <afc1fb55dfcb1bccd8ee6730282b78a7e2f77a46.1738274758.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1738274758.git.ashish.kalra@amd.com> <afc1fb55dfcb1bccd8ee6730282b78a7e2f77a46.1738274758.git.ashish.kalra@amd.com>
Message-ID: <Z5wr5h03oLEA5WBn@google.com>
Subject: Re: [PATCH v2 4/4] iommu/amd: Enable Host SNP support after enabling
 IOMMU SNP support
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	will@kernel.org, robin.murphy@arm.com, michael.roth@amd.com, 
	dionnaglaze@google.com, nikunj@amd.com, ardb@kernel.org, 
	kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-coco@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 31, 2025, Ashish Kalra wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> This patch fixes the current SNP host enabling code and effectively SNP
  ^^^^^^^^^^
> ---
>  drivers/iommu/amd/init.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c5cd92edada0..ee887aa4442f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3194,7 +3194,7 @@ static bool __init detect_ivrs(void)
>  	return true;
>  }
>  
> -static void iommu_snp_enable(void)
> +static __init void iommu_snp_enable(void)

If you're feeling nitpicky, adding "__init" could be done in a separate patch.

>  {
>  #ifdef CONFIG_KVM_AMD_SEV
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> @@ -3219,6 +3219,11 @@ static void iommu_snp_enable(void)
>  		goto disable_snp;
>  	}
>  
> +	if (snp_rmptable_init()) {
> +		pr_warn("SNP: RMP initialization failed, SNP cannot be supported.\n");
> +		goto disable_snp;
> +	}
> +
>  	pr_info("IOMMU SNP support enabled.\n");
>  	return;
>  
> @@ -3426,18 +3431,23 @@ void __init amd_iommu_detect(void)
>  	int ret;
>  
>  	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
> -		return;
> +		goto disable_snp;
>  
>  	if (!amd_iommu_sme_check())
> -		return;
> +		goto disable_snp;
>  
>  	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
>  	if (ret)
> -		return;
> +		goto disable_snp;

This handles initial failure, but it won't handle the case where amd_iommu_prepare()
fails, as the iommu_go_to_state() call from amd_iommu_enable() will get
short-circuited.  I don't see any pleasant options.  Maybe this?

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c5cd92edada0..436e47f13f8f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3318,6 +3318,8 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
                ret = state_next();
        }
 
+       if (ret && !amd_iommu_snp_en && cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+               cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
        return ret;
 }
 

Somewhat of a side topic, what happens if the RMP is fully configured and _then_
IOMMU initialization fails?  I.e. if amd_iommu_init_pci() or amd_iommu_enable_interrupts()
fails?  Is that even survivable?

>  
>  	amd_iommu_detected = true;
>  	iommu_detected = 1;
>  	x86_init.iommu.iommu_init = amd_iommu_init;
> +	return;
> +
> +disable_snp:
> +	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
>  }
>  
>  /****************************************************************************
> -- 
> 2.34.1
> 
