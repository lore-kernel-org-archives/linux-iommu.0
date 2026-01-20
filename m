Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37718427A13
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915623; cv=none; b=TSmJ76HXK+bWlqIwGxWIwZq3FI/DhoINkWajySIqZdA93Mqh+PnlEgee0JK168JFjP7ErdIC6l+nDwpmRCapOlOzBBAc180vq1jRg7Lk04cTJvJJTJ1mBGYA9Mt4fOp2Kp/EpuugrHe5qKcfOo9h9NjaPnOV7GDdkWNUC2grEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915623; c=relaxed/simple;
	bh=7Szwsklx/Y2EMX9dqKOORk1vk6jK5LCw+XlCJJsBgeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSWoBVd/Kzb8hlgOffPJn5lqUs1cUzO11qDIuYa2/8du+Veb1bdCyKmWvOvETNvmUdOtGgjF+Fe7DNZbKI1jI6+rzc8zR5w8qiWGXgr3r4hSNLLh2FODZQqPdqT/kSgn+Ydas3eNwzO+Kfa/UIO/0mqcVgq78YYcZsozURGpfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PJZIxqoh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PJZIxqoh"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88888d80590so80206896d6.3
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768915620; x=1769520420; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLxUlz931pMaY4udrGaMFThPKCbG+2P0gYX4WJ/4nHM=;
        b=PJZIxqohKaoZP4wsJ68JW2WrHd6cYARGLrqxaKWEs7CVT1sMiG+tyiZHuSFm8VQmq7
         mfoDvO8HmAi1GAsD8v9evFXkB7Xsy3aBNL6j5yw3YpsNekAoO+3uQol1ZoCQYBe/T2kV
         kKOmKewdxGUmt6LWhY/2R30F68fh6U2DGKf+2TgT7lUei4Lf8KVWEr4PO3hEC9D5hbbQ
         T/ArrF9RVEtBYRPuYtxqqdig7hpcJ/s+2YYpzaoRDQyRqmJfxWi9/wE2eQd5OP2A013o
         3ps0ZDE2LdtZxDUcr1/m+pJ8xVwkvtFQFBqQU0XWKiMek7SQr1CLqwEGpTJTR7/hZkEg
         lsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768915620; x=1769520420;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLxUlz931pMaY4udrGaMFThPKCbG+2P0gYX4WJ/4nHM=;
        b=BWObjwQNYqgv8PXW0toV06iUaVk7CydKOHjVnO0YenDYxLQHeaFnZb/JD3+GQRPQyW
         tC5sm24/+vE5F/zZ2Dpb9bEZm9+M/DkVIHzr/UPgXLFSWK5hSFh+IqXJiRPVCJjnWKFY
         39QhIRlVdJ0DtjRBr8oXKebE93blV/Wvk1xIBUs1oG91csR0XpChJO/HkJlMViAGwt3d
         qs34YTStYsF7SqzakZhzrbtgrSDqE4twbCOnqckGAze013YmkVRCWOGwZz0NrvZ96ct6
         TFpOeJpRqUVcuBsCQdTwdgutr3skc+3LHY4Gaa/t4eFOjVDpnQdbi2gnIYA78yD+rtHe
         fN9w==
X-Forwarded-Encrypted: i=1; AJvYcCUKYg4VCa832G8ajNMOT8eLFu+qab/EOerXq0cpPkIuEfX9Uxc9ddITMvz/FVXaMwj8Md3i5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiNlsSaNhDWIDFl+YBxb/X+2NiPsfNMIfNTTC+tsmqSaDybDTa
	aDpGxTr+NQpQzvTba8HMSIAlrx7vYKKRrSQV1Rj2YX5toqLtm7An2zEe6ZyZoFJMMMY=
X-Gm-Gg: AZuq6aIPymLufTIX7kI2uFpO/H4YD9Jy535USTXU+tphtAsbejPghYld9UW9HOQ0Gj9
	ywsc18Bx+SmUyAYUjfeT/hZIbAQfSRobqtRJGgeKdmFBYjsPnniItJlcyvbXc50z4jooz0CmtRj
	+VMtgPS5PYErsUeqzY3dMQY4vXN7l1hwHw7fylgMyJK1uCHUeI9Cf73Et9snEozCQJlRLl4gNFW
	mFP6EpMyM9OU1d8b+jCRXB+f85D6dyXw2S9m68UgkQwv8VXYFlIhpCRMxU352001Vj2pxf/P62A
	S9mrDSjLg7FMTHx0JYK6DbHQQ+iXa1HSJk8C4seXBioir1nNJnEPggrr4jlwaHFyfrngYcEO+WM
	xC0xBZK4CFDJaRgKF88QwcXg0zK1mVyCtyBOXrffeDSvHgHG7RBsVxzRICc3ZR8w4IhGnHN0cEJ
	FFRaSGWcgsMJcE1tgy3MGGXr2zKNf7bYs/DIqz5CuiYo/ZZqUu/ijhcvw6fC/BLiFk4NM=
X-Received: by 2002:a05:6214:1949:b0:894:67d8:293 with SMTP id 6a1803df08f44-89467d803acmr14754196d6.57.1768915619729;
        Tue, 20 Jan 2026 05:26:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946e3aee12sm1805076d6.39.2026.01.20.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:26:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viBl3-00000005WB9-3bIR;
	Tue, 20 Jan 2026 09:26:57 -0400
Date: Tue, 20 Jan 2026 09:26:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, suzuki.poulose@arm.com, steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
Message-ID: <20260120132657.GO961572@ziepe.ca>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120064255.179425-1-aneesh.kumar@kernel.org>

On Tue, Jan 20, 2026 at 12:12:54PM +0530, Aneesh Kumar K.V (Arm) wrote:
> On systems that apply an address encryption tag or mask to DMA addresses,
> DMA mask validation must be performed against the canonical DMA address.
> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
> can incorrectly fail capability checks, since architecture-specific
> encryption bits are not part of the device’s actual DMA addressing
> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
> addresses.

Huh?

static inline dma_addr_t phys_to_dma_direct(struct device *dev,
                phys_addr_t phys)
{
        if (force_dma_unencrypted(dev))
                return phys_to_dma_unencrypted(dev, phys);
        return phys_to_dma(dev, phys);
}

dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
                enum dma_data_direction dir, unsigned long attrs)
{
[..]

        /* Ensure that the address returned is DMA'ble */
        dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
[..]
        return dma_addr;
}

The check in dma_direct_supported() is checking if the device's HW
capability can contain the range of dma_addr_t's the DMA API will
generate. Since it above is generating dma_addr_t's with the
PROT_NS_SHARED set, it is correct to check it against the mask.

If the IOVA does not contain PROT_NS_SHARED then I would expect all of
the above to be removed too?

Can you please explain what the probem is better?

I just had a long talk with our internal people about this very
subject and they were adament that the ARM design had the T=0 SMMU S2
configured so that the IOVA starts at PROT_NS_SHARED, not 0. I am
against this, I think it is a bad choice, and this patch is showing
exactly why :)

IMHO you should map the T=0 S2 so that the IOVA starts at 0 and we
don't add PROT_NS_SHARED to the IOVA anyhwere.

This logic is going to be wrong for T=1 DMA to private memory though.

Jason
