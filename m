Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90A7CF3A
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407959; cv=none; b=VPWBRaSgabK4Igq2hccwleyPyEx6PS3Frxff1HpCxVLzRisNvScxYTY+0d5Whi/i8NM/fG9GDzDJaYgjkyfIoNq9SuhqXOTtHuXL9a5tjotESRarEZ4jeqOiY0oXmd5yYRyeREn18yHhXorwUK+2dG8ze2rlo19Ei4lMjj/94BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407959; c=relaxed/simple;
	bh=1ivvQ9HdJsVX8jcJMUEyyxeKARTjHpPH8W6wVOTh89c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+72U1envj779CvcBkCPQUEVtS6IUBpcVcII9JWVX5umvp77DLdBGkRYBSS7Ua0MoMGxt4UVHS7gUy20BFBe64iQXlz1aCNwggc120KcWJWazKjXPq/I9pmvdQRmLvNLCUUKDZoCbvCBLzZawdzIDR0JUrzciTbRRmpF9cfvISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jvEe4eDi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jvEe4eDi"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so1207245b6e.3
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707407956; x=1708012756; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj/DNLe5yS0yLTeKvt3K6e8Yabk69ndGeOwvP32wo54=;
        b=jvEe4eDizI+wHBCHkFGiymaLKQVGjdH5QPF+bTpBXw5+c+9h9LLY4L+M5M5qzsc3Fs
         /oDR9x630axGkXIWIsfi7sHI6A2ZE15J7O6guLHvrQjRx2nBQfJN5ogt4rwKCbfdbnez
         vAMdUdApXxYvPAEIv5fhdzGZ1C7UTW83r7rIHOjHM79kJvFmzSSqmFKduPnFzXzTVF/8
         mrAmyCaiVvrU/AIA910d/av3mMatJMoAUwppKlggSoidHSxJTk31P0BZc5lvGGxkZYce
         IZEvJVQn5gxvv+gKS7iGfXJUlIMBywHqUzT3zWFwTQpRauuNCecBjXjf4W1PT52AREzQ
         csSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407956; x=1708012756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj/DNLe5yS0yLTeKvt3K6e8Yabk69ndGeOwvP32wo54=;
        b=rvgoqoks89sm2eJGv6ABeogasxvuGRHceGf1TvVn6e+s0e41B/zVkSJZjzisb4/2Z1
         WfY4vbiJ/ClcsgaOZ1jh6ambiC94FTW3q/0mzKQkffyxLNGtZLcf3Mt+t8ZKLqGSEZOY
         DJLfZ01Sdy0h+qGcFo836KkwJT3cR2Ale1s8D7H3lc3+KZMIXaXpAaPQMmAJq34FENFF
         SPg4exRFZ4xpKeuy5Diya8zkljYAFMFWCiJT6MxDWTWQSnTGbqy7hXViYLDIE9cNjm14
         nIIEhnKP5Zn81G1upvJUs20a6jXZKS70sfZuxMRfcmm/V+mg+xzcKnyubHZK0nFAxs2J
         bgLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3QA9CDf1lYZ9WDlOWBha721j64CfYBchHfJZRID7+oBazqCyCEp1fIXg72gwsJIIUoFSJ1pTuE1nHDlboozzUQmnhxS0=
X-Gm-Message-State: AOJu0YyN28VZCgqzF5pMSHv3cwDkKO/pmoFs+9owbD1j39rx1ZFoSpT1
	iM9h980b4kysV5qZ4Lzt0Ef4ya7hq+ZR92XXVqRZG/xcX8HEsVjluQlNbCgpRiQ=
X-Google-Smtp-Source: AGHT+IFP8DbkjTenyJR5thtweAtKztIJdY1G+NMJu85H8wqB0kxgunIam6otwOelUaeDQ4OcaDSZGQ==
X-Received: by 2002:a05:6808:16a5:b0:3bd:bef9:84b9 with SMTP id bb37-20020a05680816a500b003bdbef984b9mr9546321oib.33.1707407956730;
        Thu, 08 Feb 2024 07:59:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJNsE0dUOlwuH6DYZSiIyy8pR4Dql+yj3/JSJt9cdNmNHFY7/67rB64IwrNvP8wc3lMYmBzD/UMwTfe9p/x+sphsiNTYhUNbVeW/yBKUP92S9W37CNZNLckynm0wGbbrv9AA+6/3tD5SupqYFStdtJM6vB7n8JxthDPFIyx0h3dfIU/Yga7BGOs1/eZVJ7VS5t0xG+hbfwjjB4UcXCAvzp25IpKDSoxSPhaXz1ZgW07oP/WaoWhhcd/i9sqkw3u2F5Sm+KlMilOSji/7m4YBoVY+pnY7apaoDWzkwFn8lxbk9zFbHxqBP/qgXGL7Bvk6h8Gy8O9KaZo88hhlcyj51EgbSU9z3i4tCiWGzt7UcV8BZ09aMY3RDlW7jocKdtXE3LFpQqrihVf78Et0Al74p5MC84tLZFSsk=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bl3-20020a056808308300b003be4835ba31sm580967oib.32.2024.02.08.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:59:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY6nz-00ExTR-E5;
	Thu, 08 Feb 2024 11:59:15 -0400
Date: Thu, 8 Feb 2024 11:59:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org,
	oliver.upton@linux.dev, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, jonathan.cameron@huawei.com
Subject: Re: [RFC PATCH v2 6/7] iommu/arm-smmu-v3: Use KVM VMID for s2 stage
Message-ID: <20240208155915.GR31743@ziepe.ca>
References: <20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com>
 <20240208151837.35068-7-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208151837.35068-7-shameerali.kolothum.thodi@huawei.com>

On Thu, Feb 08, 2024 at 03:18:36PM +0000, Shameer Kolothum wrote:
> If kvm is available make use of kvm pinned VMID interfaces to
> set the s2 stage VMID for nested domains.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b41d77787a2f..18e3e04b50f4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io-pgtable.h>
>  #include <linux/iopoll.h>
> +#include <linux/kvm_host.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> @@ -2399,9 +2400,13 @@ int arm_smmu_domain_alloc_id(struct arm_smmu_device *smmu,
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2) {
>  		int vmid;
>  
> -		/* Reserve VMID 0 for stage-2 bypass STEs */
> -		vmid = ida_alloc_range(&smmu->vmid_map, 1,
> -				       (1 << smmu->vmid_bits) - 1, GFP_KERNEL);
> +		if (smmu_domain->kvm) {
> +			vmid = kvm_pinned_vmid_get(smmu_domain->kvm);
> +		} else {
> +			/* Reserve VMID 0 for stage-2 bypass STEs */
> +			vmid = ida_alloc_range(&smmu->vmid_map, 1,
> +					       (1 << smmu->vmid_bits) - 1, GFP_KERNEL);
> +		}

We cannot allow the two different STEs to be programmed with the same
VMID but different translations, so somehow the two allocators have to
work together.

This is why the SVA BTM code has that complex ASID reassignment logic
so it can get away with two allocators. However ASID also has SMMU HW
ASET support to opt-in to the BTM broadcast.

My suggestion is to avoid two allocators and make iommu instances that
support BTM always use the KVM owned VMID allocator by forbidding a S2
domain from being created with a NULL KVM.

IOW all the DMA API/etc will use S1 domains and the only way to get to
a S2 is to allocate a nesting parent via iommufd - for BTM systems
only.

Since the S2 can't opt-out of the BTM broadcast this means the VMIDs
are cleanly assigned and we never get an issue where the KVM TLBI's
are flushing an unrelated S2.

Jason
