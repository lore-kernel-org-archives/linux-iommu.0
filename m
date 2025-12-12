Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965344C8F
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765555639; cv=none; b=oQKwSNGrpgH4POdwK5VJ6r182GP1TL+i/rG7bPyMh2vuzMmKa76TS8FGiQiSDJz6L7HUpLUSPnbinINb3k9KwV+wFhC9bT6IfEBBuLThgYTTJsLURxAeDnAaqV1WwWu2Z5xoSnAIYT4KfWV4PeSHKoOFM3NGMSx5/nL6oIUFxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765555639; c=relaxed/simple;
	bh=CadN1clJTjA4RMo1uLhmMUV7CPVXKBuCrjugsR4QrFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3mKjKK4D8WOCoxQKeN5ponKLZM048VylW4WjjY7AnR+LhNpZVaq36jjin34nYLrDgsmQC1Bk9Jhxj9LDSsgof9qX7YVllgScDt8CsQSnYToBGM+aiDXBF0M0vIcAj68uiOJrOqbdcmENCph+6PGPXByfBYG5TpZtu0Dg9N5rZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIOKpbzC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIOKpbzC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so168535e9.1
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765555636; x=1766160436; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/MUKGMtq/AZXEzw4+AUVbVepsRjCX4PBUc6yHK/8Wg=;
        b=aIOKpbzCNl5YCsxyp0nEUuGxg1fJ4dkxmPqFtWySShgJUK9UD0MalHRKfwSsAd0zlk
         ou8WbFsrcphW55kxSJNDvMCGLzqQolkleBID8hhQsUVZC8F8hgOQWLTgtfZkFOtHxYDs
         0e5DTmkpNwIFzTqTE6S87ZHu5BmnGC12+Uh82sPBfdpKxXMAj68v4+nIdRNRa2/zFG7j
         BbRlKuOw1RU0XeXZMiEUzmSraSt4TAFUDuujmuoFO87Zq6GCAM5fjU1BHYBG50h1J8xv
         +Zy6vuwS/19fkr1n4+OhJ2hEvgL1kIoeYnj2QFV0twbbM/yOOCpmM14jfAK6NY6hGKkd
         qjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765555636; x=1766160436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/MUKGMtq/AZXEzw4+AUVbVepsRjCX4PBUc6yHK/8Wg=;
        b=RA2tvgEgaSOllpjkryRd2LWaazDREN+r6f1FhXMwR3FjHoZOJMaWPLJkU0aGixB6xD
         dQ4cTLGeEVMd94L7fHJcGpKD73xd5i409b961qytYN582V1CJktKvr03uEJbUPb562lr
         FXZQBQ2Log1Rjt7pO8kGGFCw74dsPplF4Fm+XzVLCDvjyl4Ua5JgO+vCH2ziNtFF8M7P
         NLr1lwFuxrUpI5VpvkT9pSSXc2fEsoXIMtmfmvdcyT8K9J6em77DCm/xiOO6216Vxj6G
         d0DX+r/nnM9Q3nmZ4yqKIMLhCx+3qG7C6atk+Joi6gq7wWBorFB4/0Q+18vyNk/dgF45
         hg1A==
X-Forwarded-Encrypted: i=1; AJvYcCXQo0jF7b4SrKgxwcFu/52+nw0ckcfAIi+pfwGjZafP37rqpwQhwBmWLPEIeIgcHvRtGLnmdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA8fL+T3IGLCfjF4r6LIWsmuWl124jot1K2OkPJSNsvTZXfwEq
	JXDkdFMoNTRJBImXmcP+NoIbJc87ihn97hhvhXnDydBvMVmq6rKhq5hoTrvd6XtNlQ==
X-Gm-Gg: AY/fxX6CRFYgsbynsC7JzUm4BtKNsWi2SmMY7IFdgS8iMXP+jE2rhbna5wvXuaMplA0
	B9CIGA3wVxlERRyfSJ7mrPP2JqJFKy69s+BNvG8NoM1y/4jRICdHkosqI2pU5gy3ZxdOJJsSFsy
	gOcVB9QIZaeunFUn2QVCNlVc574BMck/13opMLuwYrKDud9ryU+qTsLBFR9uEoUTAycjBnD5pT/
	KDErEWupO8GcSosgcI/EGORLtN/1yG3/3e7U6lGDwp4bbDLB+uDv4OhlnmnbMi+pmw/zudl55eA
	KB1ACh41VDY2KaW/IH1WxRijXSdJouRm+2eOnZyDVCjUZcQqcNaexrT5QsLRdA/7IdJKBQ45iTm
	ChSn0dCFvRY5ASnSS+/Nxzm6i9G/WBNvEqAtohL5Qqn0EgEarsQWJNoLEQaZuf55UHUZ+LKvRnx
	RRmdPE41Dh0dRKuDMiV/mUiHzGa1xaoQeGiUnB4fJc1VT9WodlLA==
X-Google-Smtp-Source: AGHT+IEIDx819rvyhX5iStRqL6toam/KgB5ggWiYCL8nDHKAqrNj8ytrnyVKvwTwKQ6ON9JUhN4seg==
X-Received: by 2002:a05:600c:4a19:b0:477:b358:c0cc with SMTP id 5b1f17b1804b1-47a8981f631mr1202285e9.17.1765555635793;
        Fri, 12 Dec 2025 08:07:15 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb68866f3sm3708879f8f.36.2025.12.12.08.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 08:07:15 -0800 (PST)
Date: Fri, 12 Dec 2025 16:07:11 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 17/27] iommu/arm-smmu-v3-kvm: Probe SMMU HW
Message-ID: <aTw9r9syCwJH7hgz@google.com>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-18-smostafa@google.com>
 <20251128170748.GE812105@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251128170748.GE812105@ziepe.ca>

On Fri, Nov 28, 2025 at 01:07:48PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 17, 2025 at 06:48:04PM +0000, Mostafa Saleh wrote:
> 
> > +/*
> > + * Mini-probe and validation for the hypervisor.
> > + */
> > +static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	u32 reg;
> > +
> > +	/* IDR0 */
> > +	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> > +	smmu->features = smmu_idr0_features(reg);
> > +
> > +	/*
> > +	 * Some MMU600 and MMU700 have errata that prevent them from using nesting,
> > +	 * not sure how can we identify those, so it's recommended not to enable this
> > +	 * drivers on such systems.
> > +	 * And preventing any of those will be too restrictive
> > +	 */
> 
> This driver is doing nesting though ??
> 
> Shouldn't you detect those IPs and not support a S1 at all so there is
> no nesting? Identity only?

I can see that the errarta are fixed in r1p1, and from the MMU-700 TRM,
we can extract this information from IIDR[1], I guess we can allow
nesting for all SMMUs except the one affected. Actually we can do that
at the moment from the main driver too, I can prepare a patch for that.

However nesting is still mandatroy, the fallback path for the KVM driver
if nesting is not supported (just S2 for example) is to fail and let the
upstream driver probe the platform devices with KVM out of the picture.

The main reason for this is that the KVM driver relies on CFGI to know
which SIDs to configure, for s2 only cases there won’t be trap and emulate
as the hypervisor would be take control of all the SMMUs (as v3 of this
series which requires HVCs)

It might be useful to support only S2 SMMUs, but I’d like to keep this
series simple and then we can build on top of it.

[1] https://developer.arm.com/documentation/101542/0001/Functional-description/Constraints-and-limitations-of-use/SMMUv3-implementation

Thanks,
Mostafa

> 
> Jason
