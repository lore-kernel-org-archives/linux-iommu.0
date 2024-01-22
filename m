Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C151023
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946414; cv=none; b=D5Cbk+hyWbPdFVeTf1FMcZNRh5PXRz/I4HcGPKX0wPdOUvpG6g9v9aG8enCqgkR8hVgWx1ozQ6xjGNfCuG16SjbObs7LzSPU8gh/VZmh3sd3HKaB5rREZoatdHuJA8jo499C9wMs03Z6qGsvtGMYgbzw0DEZd60qyClyxSUvmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946414; c=relaxed/simple;
	bh=emEYyaoft+mj559a2nWavURaoE0Q7pX9ocKF3h0Gs1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN31+sdwrWAonDZpcJVIdFNpsu5sJW/www3LyX2Iubl+njoXWwG8t6r+BjJUl35vEEyCobYgS3/2Svb1Qnyv6MuOZbfFoWNvjiBC1jzobwsCAUO6fOrw1G+3o9nsoL+bIFYAECtFQm7JM/20tTUWhMfpnxMCW685pHtzH2NtAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C0HtvZ2B; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C0HtvZ2B"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5986cb7bb61so1947650eaf.2
        for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705946411; x=1706551211; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb+RWVktgE8OHhHTF0ToEEFBFKQS1T9lY0yNb5W2cZI=;
        b=C0HtvZ2BxGbbB+gbqW5uZEjRpYcvH7/Z1NYqSc0qf3CJlrsQGEffDwPcJUj5jzndLF
         fHY2G1XTE9mg2YZt0fl1S/858tIGshZH/sBEDMLVjKkpgG/cO0Vk//yRXODqANErr5RC
         dk57PisKKoQJRaIRWc0RoNbruVYPpCsP371C6VU+ooIgU3xLBBhoSyY5ktP/KuZom/KW
         c7fHnREOIGW9uEjnLJlnK2gITSsxhzmejA+Ws0uipK2qoUgedCwkNkGeW1y/4ZMMB3SF
         f2r0JcjdFBlH8zjdSSTVamjb32eipL1U8srHv3S5JhDUUf8QdXIrzlyFHKF2EKW/mE8H
         oL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946411; x=1706551211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb+RWVktgE8OHhHTF0ToEEFBFKQS1T9lY0yNb5W2cZI=;
        b=KZvaxJgl7toImgA9H4dQAjbDODQ9q8HPI++2U2sPL848qKvXBHiWqdHe1+IpYG7eCZ
         sTWNjGe6vOmRQzh+/11HnXgYi95VXW5yh9lISIM8KbJcUq05JnEw97vEebxy+6vluV5w
         AMXHEDN0t9b1pqBbqjJlHcBYM36jDQFTjCcg+FB1RRvTEdqi7VvniQUnWETDIYv95P+v
         rzCf4u0wM7T4WeLT+FliNQALnc9xg+9t/oY51y3baZ3w+P2YOMDBa7UgC9UPilgwIKs+
         45n6e8L5CRIArhsglTXPSrimDfAvQjl1ndOK1C43BG1Km1kyURUoV6UiH4lSgEXjdHYs
         SL/A==
X-Gm-Message-State: AOJu0Yz4m/Dty/YEsRw4ma1npbhDBn+O51iKtTI3Uq4BcFybUH1UbsQA
	FQ2L5kg0GnkNPWYgPc3nzSNi72Q2Wv75DmJZZ2HPTzij7yfx7EUG+8kJQo4Kxgo=
X-Google-Smtp-Source: AGHT+IF2E9XImglTP3NY2pCKyj/FI7FMhn5zj61373AEXiogqenvzjENVucK6qCCQV1ED1a5+HN+OQ==
X-Received: by 2002:a05:6820:345:b0:599:698d:a470 with SMTP id m5-20020a056820034500b00599698da470mr2336039ooe.2.1705946411263;
        Mon, 22 Jan 2024 10:00:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id k9-20020a4ab089000000b00591d271c95fsm4118990oon.4.2024.01.22.10.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:00:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rRyaf-006xc8-EV;
	Mon, 22 Jan 2024 14:00:09 -0400
Date: Mon, 22 Jan 2024 14:00:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/17] iommu: Introduce iommu_group_mutex_assert()
Message-ID: <20240122180009.GO50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-11-vasant.hegde@amd.com>
 <20240119190955.GM50608@ziepe.ca>
 <c5be6a3f-bb45-58b1-a832-82c140299ac3@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5be6a3f-bb45-58b1-a832-82c140299ac3@amd.com>

On Mon, Jan 22, 2024 at 11:54:39AM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 1/20/2024 12:39 AM, Jason Gunthorpe wrote:
> > On Tue, Jan 16, 2024 at 04:53:28PM +0000, Vasant Hegde wrote:
> > 
> >> +/**
> >> + * iommu_group_mutex_assert - Check device group mutex lock
> >> + * @dev: the device that has group param set
> >> + *
> >> + * This function is called by an iommu driver to check whether it holds
> >> + * group mutex lock for the given device or not.
> >> + *
> >> + * Note that this function must be called after device group param is set.
> >> + */
> >> +void iommu_group_mutex_assert(struct device *dev)
> >> +{
> >> +	struct iommu_group *group = dev->iommu_group;
> >> +
> >> +	lockdep_assert_held(&group->mutex);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_group_mutex_assert);
> >> +
> >>  static struct device *iommu_group_first_dev(struct iommu_group *group)
> >>  {
> >>  	lockdep_assert_held(&group->mutex);
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index 7f6342bc71c3..c983b6a1ebce 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -751,6 +751,7 @@ extern int iommu_group_set_name(struct iommu_group *group, const char *name);
> >>  extern int iommu_group_add_device(struct iommu_group *group,
> >>  				  struct device *dev);
> >>  extern void iommu_group_remove_device(struct device *dev);
> >> +extern void iommu_group_mutex_assert(struct device *dev);
> > 
> > This shouldn't be unconditional. Like this outside the other ifdefs:
> > 
> > #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU)
> 
> This is already covered by `CONFIG_IOMMU_API` check.
> Also lockdep_assert_held() is already covered by LOCKDEP config check in
> lockdep.h file.
> 
> So I think another explicit check in redundant.
> 
> Is there  any other reason to have explicit check?

We don't want the out of line function call overhead even when lockdep
is not turned on.

The point is that without lockdep the inline stub should be the
only thing present and the compiler simply does nothing at all.

What you have here will generate an function call and a stack frame
push to do nothing.

Jason
