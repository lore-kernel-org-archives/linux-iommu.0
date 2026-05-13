Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573F3C9893
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709304; cv=none; b=CMQufYLgI5g66FyxQ/ATX6QL5U8smbyufBipYnS3xLbXzPhKXsbX9i0fBRy5VfibE8Dh2h6iG7tXMdMHat+PZZls1XmvktsK9w8tPvNWbhfRRw7cjuLp9zW4UMqNt8MCQPllqYKJTigZh+z6ivwOMuviABtu9HIj4bRzAGGOeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709304; c=relaxed/simple;
	bh=33ib9KkcLLrn3VhTTtFpwjAuQ5li1GsPjQBsArINN90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs4DGuNmF6KGuCCsNvUVQQRBA4yblsZ9zH7U+k5zMY/DCQmKQhSC26WV1YAzXtPB9tOf/O6hjp/PF24j/nMV3LdFVrwS/JpaPd++XNh7xu3R4KkZ7dJLgFkfVCRPE8sXQs4eYqE0f6HlApatUVsxcyb4wRVFCP8eHUpfwTj2fD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4FvhiXS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4FvhiXS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so11325e9.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778709301; x=1779314101; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezXQwA1bTr4JmObmofRNYrBy4UfsX59CPxxan0BrTBM=;
        b=Z4FvhiXSN6pnjemQpGNtN6SzaDIINiv9WVJnTpAPgTbGIHyCI56fDgL6uRkT5w3Nk9
         weIc3FnKFXQgqlE3O94NiqpLAMS5B/gHl0/rs8F9JAyI0mj+DjHIng+OVeKjv0NfTI/o
         IG1YWFX3/yVYEZp/5oTnDv7DrQmbW3mnUtiiT8B8f4/a4RQQkrmvqJKEM61LlJP+nRBS
         ByPSkkx1tWLLnBSJqg2pmMBiQ0Zsq0PxRReRRACEhdnj0+kS0pPCQEHMqVMCFb4KTse7
         xbL/hi4/n9mPz5IxHQodGC3gJB5OGNc9G1++Fi4RwXKRXFXYIbdUpZKVa5fjoEfRdcTM
         Cojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709301; x=1779314101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezXQwA1bTr4JmObmofRNYrBy4UfsX59CPxxan0BrTBM=;
        b=bDxxiTeFl0Jzhjfl2XiTNLncx78SSWUCkXHUIthE3TqOjJSApxeg4Op5LYaaf58V9M
         wmfRf86pIfVIKp+ywtftvRtJ/q2Ml4bn3umRJVzcoiSRbEl//WeGYLegtVjqgG7wSKNw
         /OdTn9xXTgl2kTRWns4xTL6tFhkYsaINUv6wTMZvrMkn5tO8WYv8Yen6oLX3EHt9yPkJ
         AucdnldvtFuYlwx37EOJnCyczRTFG661fmx9ZFu1eb+obzD/zw//CslbmTEj4Jee2DD+
         o3SHkRFc1qVNiB7Cgqo4CdJD5EW6ZR4ZPSDcHSU5O6UtR8xGuWBlBsajblmqq78OffBH
         Ih/g==
X-Forwarded-Encrypted: i=1; AFNElJ+C2SA0S6aKgoiRj17eQPnbfq5AUCUt9cmfnAGI/DjCj7Gg3XWcPSs1wGldEGdULlD4tbl6YA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzgl6Ph8BtfqDgQwbhjF0pnEdJ8ZaSZQsCZy4+IZeEjWeR9qg43
	BayTE5qjNWsEnFXYvDlfvEcR4tva7ySpK6fVh/lJdH7rTEmIHC3qiLJbAyeEh4Vtbg==
X-Gm-Gg: Acq92OHgFHeeQbrAF9TEc3WPXtMyIxgbCgs/IL5qfFFqjvWbZ/Z+Sm/Nfv1sYj1oejC
	jx9lndXfsHkYGIJ4Uz0QZBqirJAIy/vbnCAfrI8GEzO1FrPC5ujOdUHEkvU9UayxueA7Ilcd81G
	/QnmTP8otBRUyYCgnfB4zNlPjiKrcDvHs0k0j8xAUrn47M8vQw9L8esa/wyKStTQh/bSaGCMyfB
	Y4f8474pJOqkEr/V1T2nYu3OTo8I4QNHlc6IZs3erMS+b6oKf/UGGj9aqj3HDMO5KOt4E3X68Fp
	UMQjaMXl4FaycYn7okYWdY2I9EFWvmztrJgSMu4cVOP/CTqs/txeTVR50KY0rrvVqH4FwzUxLuh
	0KaxYSQGmYIRPMub2+M51sLJUjMFOGNc2LN1R04dN+VDcGDoJGx3K8FSV+x3Xt+d7j15sFaTDiw
	iFszV6wVZMRj856QXoJZmEn/7j+Ek4uP6U05L/FsYAFT1i0FzsvNwwEYlCuXfFqBBNLKQ=
X-Received: by 2002:a05:600c:a404:b0:483:6a76:11a6 with SMTP id 5b1f17b1804b1-48fdafcf030mr95235e9.5.1778709300573;
        Wed, 13 May 2026 14:55:00 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm1499641f8f.17.2026.05.13.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:54:59 -0700 (PDT)
Date: Wed, 13 May 2026 21:54:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 06/25] iommu/io-pgtable-arm: Rework to use the
 iommu-pages API
Message-ID: <agTzJuKQoBqfQkq7@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-7-smostafa@google.com>
 <20260501122424.GA6912@ziepe.ca>
 <afiO2WL4ILGfmUui@google.com>
 <20260509232155.GH9285@ziepe.ca>
 <agG6n4CeuIMD57G1@google.com>
 <20260511141849.GO9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511141849.GO9285@ziepe.ca>

On Mon, May 11, 2026 at 11:18:49AM -0300, Jason Gunthorpe wrote:
> On Mon, May 11, 2026 at 11:16:47AM +0000, Mostafa Saleh wrote:
> > > IDK, why? virt_to_phys() is part of the iommu-pages API, I'd just
> > > leave it.. If you want to narrow it then #define it for pkvm when
> > > compiling this file..
> > 
> > It is not going to be part of the iommu-pages API, I meant in
> > io-pgtable-arm, we will use something arm_lpae_virt_to_phys()...
> > which is then implemented differently for pkvm.
> 
> Again why? I think the main goal should be to not mess up the normal
> code. 
> 
>   #define virt_to_phys pkvm_virt_to_phys
> 
> Does that, we should be leaning into this pattern I think, not adding
> unnecessary churn...
> 
> If anything is needed then it should be an iommu_pages function to
> wrapper virt_to_phys() for use by iommu_pages uses but I'd rather
> not..
> 

Sure, no strong opinion, I did post this patch along with cleanups
separately in:
https://lore.kernel.org/linux-iommu/20260513215203.3852661-1-smostafa@google.com/

Thanks,
Mostafa


> Jason
