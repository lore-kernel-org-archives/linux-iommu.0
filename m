Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BAD27FD51
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649090; cv=none; b=dnt9OkYYJNXX7r2r7RUGiVBEno2YY5IOX2QJlo6HT5mSH4AeaWAj2NmkxlS3MUe1/Sr/RNgNEJpky/TUDsRu7HHTDfcEFDOiraKSC7jvRmxZExlggdEE8IfnmVLFdpv3WwieOaubf+urvhddDVwUV3ZDruX/9NMZe/zhWWEGDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649090; c=relaxed/simple;
	bh=nKAZfoAjOKM9CWFiJ6E1W5BaQQoUhnD1jwF7C/Ohzg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV8sLa4279fC+DpguXCXr/EAz/MorxBIQT9n6qQ5Y0LV/lcLoCrM0BOX899ybvLCa5QjvJXMTpTsn5zFyumdLlWj67wqLluZGPQcSNH8F53hi205jU54INPjpTsAVNn9+fxU+NWtPoEVeG00r+DHN6VeZu0U5dNhvY24j6HCPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o0xyka0h; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o0xyka0h"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cce50dfb4so4417266fac.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758649088; x=1759253888; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZBIJqbmEZbrWURHaKZlCYT/zn1TgwW+8+aRFRZatnkY=;
        b=o0xyka0hHvd9IAJ8YNGrz7AuCSBn9GSEuN5Vum2EjbUNuaVXSsHdKbYOR+wG3qzG4P
         FH17W2pszvbCOV+BMxnrMnlzgw9xicplbEtP3Fw2SiPm8CFATrjCT0MaP5IXRof42V6C
         QQZghte3JTpwMkLLKPc5MNm0gjAd8QHBikQcM/qR5h6DxrlvEZAipp8Mx1yUpyewXhDC
         2F21c+r5STLAbJvZVRJhb6g5A7mE8HhSgtQoQ/ehtXCAKl5zIzWW66XApeB7Rre741tj
         t8UAnHDO9dhYlmiVo0z7Rxh/wPJk0D02Ry0nMdRotJGwq9k1CUfPKXBD/5rkvOrYC2vW
         HVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649088; x=1759253888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBIJqbmEZbrWURHaKZlCYT/zn1TgwW+8+aRFRZatnkY=;
        b=DA89ORt6KRILp20e6QZ8iQWcxBO4AXN0Dt8Enn1zRq5c8ld9ZKdwyqs054Nrlr1fH4
         K1FXx6V3GvEnxi4xc0SZwqwcogTF1M/91nUIbCBQ8cdfIghZN2bhgnty+4Jny8xMdicF
         mwuHtQ007uoTQ9x2mdYplPksoaeRb5zpidfrfgEnpQM94GSyeBDwOZjRMk3ITtKN5Hmn
         7MsKVir3+NZ0nqhM8uSfF/+uAxFwMm7GAL0kfZypmMWJG/2ekaaIVR5NV8FnAW6p45rD
         7vVJoEmkTxWAeo2tAtYF4qOUw7YGtFQhVJO4yeKmdi0bb7cI5MMCTr1h1KVLpBGOR7Vr
         HwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6cFD/nfIEfrTamUowoe1A0J8NYvZcKhJbXREkTeyzgoc/GPvWvz1ko534kDsVnMzWifUGpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye8CCITagkIYJQSNCaxpoXQkQI4oOIdO05lfa7o/rzP+pFLl+W
	v7Nf1xEEAbJCZveu23RKgMGWLLf2EyGoR25mg6eJLig176hKRo6Hs03SZ3a6dYWhks8=
X-Gm-Gg: ASbGncsT8l92vBVqM2shbaSsabS6/V4eXtujNMGXZHpbJqLXAUTjCu9A/0e4a5MWzxe
	Mvwrj/fFmhxbC+L5ZMq8h8LXPuuGz4IjnVARRIlQu59hoiQXyZJPcK7FLKCs9zUqdA5ePbZshI/
	ugJ78/CGo4K1r2meEU81LIkxGhMyAAxfWy+bJTCO9peQIZgJCAON2O0D1EzjApcvSzo95VF2OgL
	UzmtAa/VOvUvxwGGmLs59OkoMU56lLffBaoIw1GKwiDSIzY2Em//hmedV/DtW0x1GPJtsW5IBF4
	dwuEh/mEV7vzs5vOiHa93CLqszbXuDQLxtwnLIYZ7cm8DoVrrLn46AZFQlH3mDlZnKMR5f/b
X-Google-Smtp-Source: AGHT+IEiUq4ZNiIQ/kvtshlpB8TY+qUCVv3sM7ttZqsjKZyYCVp5SpveErcNASTGPSdrjl/Eyj3Y1g==
X-Received: by 2002:a05:6870:15ca:b0:32f:ec51:a716 with SMTP id 586e51a60fabf-34c83545b23mr2456188fac.29.1758649088337;
        Tue, 23 Sep 2025 10:38:08 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e3af73f5sm9720934fac.6.2025.09.23.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:38:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v16xq-0000000AySS-4AaP;
	Tue, 23 Sep 2025 14:38:07 -0300
Date: Tue, 23 Sep 2025 14:38:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <20250923173806.GF2547959@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNKwROPzDCWgJBGQ@google.com>

On Tue, Sep 23, 2025 at 02:35:48PM +0000, Mostafa Saleh wrote:
> If we really want to avoid the current approach, we can keep deferring probe,
> until a check for a new flag set from “finalize_pkvm” which is called
> unconditionally of KVM state.

I still think the pkvm drivers should be bound to some special pkvm
device_driver and the driver core should handle all this special
dancing:
 - Wait for pkvm to decide if it will start or not
 - Claim a device for pkvm and make it visible in some generic way,eg
   in sysfs
 - Fall back to using the normal driver once we conclude pkvm won't
   run.

It sounds like a pain to open code all this logic in every pkvm
driver? How many do you have?

Jason
