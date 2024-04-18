Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6D15E814
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441748; cv=none; b=rDrXeOObWLoWtJuxlHymjg23Uarhff61ADV9PCJnBPAjV07cQe4Q2SpY69YJpBF9AZrhiSZ3Y6q0XN6A51x8g4dS19qxfxRMCwgu8MKShkbC3NbfdSmOwxxYqIL3EkTyruh2rkh3wPfK6CVnZ+Wl3I7S1Nqj2P+tgYFwsO7Shr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441748; c=relaxed/simple;
	bh=ITsBhQ6SB3CHmSgX2EK/QEvUIJlCgmIXAKQpuqOzI0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/1PBLpfveuWkYMDaRs1OcNGaThmMH1XXN0u2MYbvMyQ1EzIPxI5MOJho9uJ4kx4xKIBP911yynTY2aqsf058PJMz4wRSVGWzTstS2wocngZDYezmN2CTNww4VsaBZaXVrKyN4KnaHKY5GdwfNoIJVFKiuYpDeeqDKy0RAUN/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aMTMEAwM; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aMTMEAwM"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa2dcd4454so478401eaf.2
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713441746; x=1714046546; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0iRrbqv6jSSKonYaBoI3Zi+BduXM/209JjylxcsUM4=;
        b=aMTMEAwM8QzsPVsRPVVyCp4+WtarWwo2nnUacl+2vpPgljYvOXpggTIiA0gsvwNdGi
         h0t9CjAoxJq5wyWWP9hEfxWDIpBFF5lTM1PyJ/7pOvfYzSNf8wAiNIlD24gDIP+ZBx8D
         xoSKHeWuAeZFXbb504qwoQ/5rEmK1wkeyzxYpFAfKOJ02F0oZpoWEzT4ZX915pIqWpl/
         drdc05kzf2X0NQypCSTqIYLH43mmXfXikMwu6AjR8N9af+bvyPCQdiH8O14jCV0f66qS
         krsYilLcR4749961XNiLmOIanBqKHL9kkdb3m57A8IVdmikDhVObcx8t4B5rNG8hgB1h
         aZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441746; x=1714046546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0iRrbqv6jSSKonYaBoI3Zi+BduXM/209JjylxcsUM4=;
        b=tz711OYh1NHzak7BxzZN9Bf47Bbi/ll20qi04pVAZe+tfJ74xwGrc2r8OJmC65B+1h
         lSXHPmAhq6eabVXhgkDCdoKYvBhhqoeopwFB7aVwVqzqMxpbt5w5FhTiAL0lBoCtQ3yl
         +j7RIWmT0BVNCjRsOU3KB5Wqs7jB0UKsGpyQSjouNH7dVwuyaqB0AKzksOxRT8CAH87O
         2DOhQfxwkRH8VM/e7HxtFcQNPSJJuPhcCjuNC0K8OsjDkHUPwcRj3+qC35IqW1vOZ0XN
         Jm+xBDwSIqYr5L/DvQ9eCqzA64/4mrLNalC2PJcSVBvNtooILkgZNG/P4NWwaRUeEdw7
         Kqng==
X-Forwarded-Encrypted: i=1; AJvYcCV3fW8H5EZCwpm0dTvtiCuQoXTr85Z/m9D28WIw41ZRO/2DKfBwJaKw3FjI+W6dDJQrnOR8a1JY/OGjcyrZuwL7R7N6qLU=
X-Gm-Message-State: AOJu0Yw3+2T1OfL+q1QM3XQpjQNsgNsAnCi9+axHxsVvZ7z8ggTlJ4ZW
	A2J0XW7g4HrhVWEl/F3TaWq8nczYQ4FjkzFI2bT8P9F4g5C9RDlfANu49520XEE=
X-Google-Smtp-Source: AGHT+IGY7gxrX4srNIdUaUfos2H0Ztd97DKbnrqO5Q4gdLHyFgem0Nc0mOEUyNqIJ3bpHSP3UKeldg==
X-Received: by 2002:a4a:ad8e:0:b0:5a7:c78e:410e with SMTP id v14-20020a4aad8e000000b005a7c78e410emr3252880oom.2.1713441746389;
        Thu, 18 Apr 2024 05:02:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k13-20020a4ab08d000000b005a5554a076esm353372oon.10.2024.04.18.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:02:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxQTA-00DuPT-Kl;
	Thu, 18 Apr 2024 09:02:24 -0300
Date: Thu, 18 Apr 2024 09:02:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vashegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	ewagner12@gmail.com, suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix def_domain_type interaction with untrusted
 devices
Message-ID: <20240418120224.GY223006@ziepe.ca>
References: <fa14583e94cbf540b60a6be94b41bb24d0037e75.1713272443.git.robin.murphy@arm.com>
 <20240416152943.GU223006@ziepe.ca>
 <b0db9b48-e9c6-4e40-9d07-c353ab14e4ce@amd.com>
 <20240417160635.GW223006@ziepe.ca>
 <b014b871-1be0-4316-a72c-d699b8872604@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b014b871-1be0-4316-a72c-d699b8872604@amd.com>

On Thu, Apr 18, 2024 at 05:14:59PM +0530, Vasant Hegde wrote:
> We return IDENTITY only if SNP and memory encryption is not enabled and device
> is SVA capable. Upstream has below code (v6.9-rc4)
> 
>         if (pdev_pasid_supported(dev_data) &&
>             !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>             !amd_iommu_snp_en) {
>                 return IOMMU_DOMAIN_IDENTITY;
>         }
> 
> 
> and during boot, we will enforce Paging domain when Encryption/SNP is enabled.

It is very confusing considering the comment says identity isn't supported:

        * Do not identity map IOMMUv2 capable devices when:
        *  - memory encryption is active, because some of those devices
        *    (AMD GPUs) don't have the encryption bit in their DMA-mask
        *    and require remapping.
        *  - SNP is enabled, because it prohibits DTE[Mode]=0.
        */

Then it goes on to return IDENTITY anyhow.

If the HW cannot identity map it needs to return DMA for those cases:

/* SNP is enabled, because it prohibits DTE[Mode]=0, IDENTITY is not
 * supported */
if (amd_snp_en)
   return IOMMU_DOMAIN_DMA;

/* memory encryption is active, because some of those devices
 * (AMD GPUs) don't have the encryption bit in their DMA-mask
 *  and require remapping. IDENTITY is not supported.
 */
if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
   return IOMMU_DOMAIN_DMA;


> So far the policy was core layer to handle untrusted device which got changed
> and hence we hit this bug.

Well I would say the AMD driver changed to mis-use def_domain for
policy and that causes problems.

> I don't see any issue with enforcing these checks inside AMD driver.. If we go
> with this approach then IMO core should just adhere to what driver returned
> rather than failing. Having policy decision at two level is inviting trouble
> like this one.

Again, no policy in drivers.

def_domain should return only the HW capability. If it returns
IDENTITY then the driver must fail attaches of PAGING.

You should send a patch fixing this function and remove the PASID test
entirely for now.

Jason
