Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495375;
	b=HHMZ6y5aYh3LHmFU3d9GGuzb3LQzGuhFu8Dn3NKF22tD1/9IfDGLKlgsSHgcbYsK57pE
	 8WfxP2GNB3zf1Qn9HHT8nSn4VhrgnibRpcfOhXndSrl4tKGBU1xK0WaE3VuLw/SSJrlwM
	 4sw/4Gkn0c+lfTHYkKIDls09DCQ5Yw4vuUlqqwcW9fdEDcCGuHV2pOah+Y/wXhTsDofpc
	 B0+iBz4Gfi+AsO34pKI5hrBZrRvuLbBNho0a9YkuVMhJf8eV72KtQRdTTo2iGrtMR381w
	 wSzsq1aRJcfth/eLThZFTeoWRhHjoSaB8XMIgxn6c7GQfxbhn2bGjDnh60QMNoaFAgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZhRLvzJzPI5U781F/KKbvaLNO/DRwhdbN5Luxo3sgyY=;
	b=JqMWHe4KvYXbp3NF0/2Md2bejJRgZshr9Uyp9LKqaCE1SkBP/fk6N9VEdk7rK2s2rBrV
	 BPB66qkGTlP/aZ0/koHzTNRH6E3r0q0V4OsyoiteIELFUR/44n7o6+rMJn3oGX9Oajklu
	 YQTvCnrGDAhyESbxHt4b/ZdfJ99pk5GpgjDLgIuY5WVZXaHEL73tpg4R7KVGb6PBZaTfF
	 q3HfHvRj9lg5pA3/N7clGYtU9vRzqwnpOtRisc7QSPTYu5OoKeQVqUDgpVcINfGO22UU9
	 Il6TAZEgGRL7/dGa8n5qVlhEk3VObXUyNdxftvDNx4V0lKTX/LTvpnXU6ofB/mkD4wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jt4R9hUH;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F14606A319
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F14606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Jt4R9hUH
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1d2ec9aadso41465e9.1
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792495373; x=1793100173; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZhRLvzJzPI5U781F/KKbvaLNO/DRwhdbN5Luxo3sgyY=;
        b=Jt4R9hUHHbg1ZFBcanSWqTIFzUNCUapf5NBk0d4S2p8Si8iI+7nOg5ABbr/2pUqvme
         1NFzDifPuWttg8UmwiOZAzo5z/hQ5hbRpb1D7kZBJW+L5i3pDUP2OoP5fKvChFyyK/eW
         +3cfMPlNm/QSk7Z3Bua3DcH3I/C2PzHsJ8+fnVfKNcrzanmXPdiNXIll6xQClWFsUgT6
         Be/NEWN/SG3FXy8p7KhD5ms2sEeyVQS8xD9KfXKUwSmC2PKMjopqEk56DhnQWVCCLNlc
         pRnFLgJ/RYMoYNr75UaM8NLgd+9e4bjQ4Lkq+Z6FaelW6m+Jwi0rG1nQt8lAJqRaogGI
         5LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792495373; x=1793100173;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhRLvzJzPI5U781F/KKbvaLNO/DRwhdbN5Luxo3sgyY=;
        b=N3OxnU9LSlMyaI5CLpwWr4RRguhHOC3doqQEeZkQblOfiQPFPPfsY6v1QYfgjvRA48
         0IuH5MX82e8/gccV+sp/1OKJ43Lo2QIsprwqUJ/v7NvXavHP9O0HJ/9UZkjIdoxBdf3t
         ecNByMlKU2YXKQFJ8XaOzNw0K0r5oV5+HSUtTT4FAmHHC746be2eDF05VHwRohiMoKlK
         h5LMG8T+naD+SV2kA8Jx0tWoXWqIxDkjbuXgr4YA61JxZQUOjzxfM7E6leuXiusFq2GU
         kkkbv8c0nZuvj+h0F2i72Cx/7AXf8MnKj+TJE1SLo2H2GzvAAKzWNYmcnk/ZZ0p3lT5T
         jWWA==
X-Forwarded-Encrypted: i=1; AKwUvBz2BKoiGuH5OUP3cYJ3D2i6Kgo3/McBn/PeqZ7HiQvVPyIjno9oYKocHExPs4bz7UIem/SoOg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIPwiMYf3XtADlyXLnwKe04qDQrEoe4mvD8qK0Qm6kD9RV/ZJBZ
	hxjKF9+guqxKpUFPfludJ6a88RIuV2lohLEuFw4HdMJtV0CH/GElqctL5VECbNy+EQ==
X-Gm-Gg: AYBFou0pGPRaOKvSr9V5yYulAy/u75uyS2NzX7vq/nEFf/PlGho3PlSfJ3QhOejqczY
	dlc7yNPRC53Lz3wrEYyI+qrmXDG/bdBIu7hhNSDtaaPEnWr1lVu6legBx71c6wpilkcerJwdWqd
	5l5F2CXdtzLst6i6OqA4FPHOThbWRuDHlngy7FhJHpx05HUQREuWGv6xS16J1yfAsUtpS2hybm7
	pIIicoQ0qDXYi5fZ74Sc5JjYfOpMDQw0Rrf6CTkZHsZbJyYVxvwk18CEV2vxvQmEbsM3LBQmEZU
	bVccz3WlpFT/j0Nnuh627kRnzOA/PFZxhqr/4K3FQO5WrQNEFunPtZSq4vNZXwW8WGcl2odFTOF
	jl7eZIj1+wxit4aLwVUfTs39da4GbDWCRDT7oJMhgnMDitNW9448urN3gzrK6UEpUBFUOZlfkQG
	qvJqMLjfZmbFI3uiCCAQwjYNsgQ/Tc2WKZJkKj9dxjcci4gxNfeDi2hJVPVD0BYH02G+OuSxTab
	0uuUJKK7B9rFqUX8HxvjwEuvHBikx/XdgW0GQb2
X-Received: by 2002:a05:600d:640e:10b0:4a1:98b1:1de9 with SMTP id 5b1f17b1804b1-4a1f59c151cmr652475e9.13.1792495372639;
        Tue, 20 Oct 2026 04:22:52 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm5787276f8f.33.2026.10.20.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:22:50 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:22:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	praan@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 05/11] iommu/arm-smmu-v3: Disable the EVTQ and the
 PRIQ in a kdump kernel
Message-ID: <atdPBqd1-xLNZ1hs@google.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <fdebf9f372ebabd7a44581a2068d6fcbff058783.1791226953.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdebf9f372ebabd7a44581a2068d6fcbff058783.1791226953.git.nicolinc@nvidia.com>

On Mon, Oct 05, 2026 at 12:30:48PM -0700, Nicolin Chen wrote:
> A kdump kernel cannot use either queue. The crashed kernel's CDs and page
> tables might be corrupted, so events would spam the EVTQ, and there is no
> way to serve the page requests that would arrive at the PRIQ.
> 
> The reset routine still enables both of the queues and then masks the two
> enable bits back out, having already programmed the queue bases and taken
> the interrupts of both.
> 
> Clear ARM_SMMU_FEAT_EVTQ and ARM_SMMU_FEAT_PRI in the probe instead, so as
> to entirely skip the queue initialization and handling in a kdump kernel.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/all/amiBagGKn-Aym1DK@willie-the-truck/
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 756825e004774..42cd30c79211e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5247,9 +5247,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> -	if (is_kdump_kernel())
> -		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> -
>  	/* Enable the SMMU interface */
>  	enables |= CR0_SMMUEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -5576,6 +5573,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	if (arm_smmu_sva_supported(smmu))
>  		smmu->features |= ARM_SMMU_FEAT_SVA;
>  
> +	/*
> +	 * A kdump kernel wants neither queue: the crashed kernel's CDs and page
> +	 * tables might be corrupted, spamming events, and page requests cannot
> +	 * be served. A disabled queue discards new records without raising any
> +	 * global error.
> +	 */

I find this a bit confusing. If the CD or page table of the crashed kernel are
corrupted how is it safe to adopt them later in this series?

Thanks,
Mostafa

> +	if (is_kdump_kernel())
> +		smmu->features &= ~(ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI);
> +
>  	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
>  		 smmu->oas, smmu->features);
>  	return 0;
> -- 
> 2.43.0
> 
