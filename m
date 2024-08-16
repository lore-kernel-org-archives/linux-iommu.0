Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E816F8EF
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801771; cv=none; b=d8+7NAEEgz25oHpiZFhMNOMYSB5YQHgBZPXq71fBA2iTuqjKg6LxhMsEwLrSVF+zyYTeW6GlC/DpgdnN2UoStedBKIft2DWJAObPO3mMIxMjlC9XOuZCMNMfCzAnN+Knx4JvPN5UbdQGlPWaT0b/zcLsrBxXrECaA1xdyCxqmQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801771; c=relaxed/simple;
	bh=6HxYlVeSj+feLLqVwLyA6gyKQAFXCa/JmZNNn6JD9Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9rSevDJJm/zfAAjNqyhoLkIV7UJDiPbbK0uJzKbNStI3xY3gudsIywth455+FPOgz36Xto9tee6tS8lG9Yop/0PPYFIY+9awkEbxAaCW6XDmH4ZhUwDQ0H7afzn8rPZCFIEnjvrE/Q/wzjf0lVh1adSGiE1pDM766IWD5RjfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQnjNxQN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQnjNxQN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec507f4ddso5843a12.0
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723801768; x=1724406568; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOA95EcZV4F+QzgQrhXwRVL4HJzAvrbHCbGVhhVHvoE=;
        b=IQnjNxQNMI1yvkVcSz654MHuR5fkmvlmQvaTbJZNYVI6Tu2Hf0uzduxW7yCsH++DCA
         +uBclnKsPYozd9Xk52MHoR7TwisPRmDFjfoIiKUKErU+BjPfHFXrkN+z+/f6Zu8IQBbV
         xMtNgKlo2plfjpz2Vv54UeEslVwtHcbZXa4sPgvKvYrcwD82iQ/jS99aRSce9g7CjwtV
         dakMmhJvlFc8/n7Uch4MnKPD093tgI3TVori7XovUDgnkP7GT++bZ6X2TbaqbVzUY65b
         uoy6di4lrZgodPU1xp4nId5Kqn8a7cm3obCtT7OPkd8j5O8FKyXK1Du2PonsQKitvjYT
         1PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801768; x=1724406568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOA95EcZV4F+QzgQrhXwRVL4HJzAvrbHCbGVhhVHvoE=;
        b=nmLvLepuGY99j3aHtCokFii3TlJiOA0VxAPXq9fpmuTbt4tnwCKly0GsZiZeojrDjI
         uxVu2M+rmx76fy52XnY3ZBV3xGxB4Ot/E+8ezWGIGCT69qB9bM0umC6L5ha9XxSISDwB
         WcdTkPmO1OKoMdPvmq9es6Ru9umUdRDKnL2GdiqhtwEzO0K2Joux+Y6oYp4WoQPLXA6/
         twMD4JkKk+YkSg4FGqG7b/MGAtHTFUrOrzCfzc3N1uSX21IOKxyyjYLyyT7bjV7FmGeu
         PaveHUdZ9Ep2GCCm1+2mSY5pEIyv1I1nmloGEuuSWrFGAzA6wMFQ1c8FT/j/dgTVxtLG
         NGdg==
X-Forwarded-Encrypted: i=1; AJvYcCVhZ+RNxVrDjOvcpt2ngHw+EvTi7OiFAwL7t/Zk6LrEI+JSyyfIfFS8kwujPr5xkkUkCKwbs412zam3eHgaq8JTpCQ57i4=
X-Gm-Message-State: AOJu0Ywfozh3IKycFccrLjjwClhhsog9rEkqmN3YOHzYYtHED9q/NQ2M
	e5cusAklsHYdOhK0IAW/Zspmr/wTBSCKaE28NPAwGA8XuD7vmFRETig7IZ0fkQ==
X-Google-Smtp-Source: AGHT+IHw6CJucdNUOT49n/SKAIgvr3RO6U5YYbnchDOoUIK7w+vVHjT3ah8z6zNusnLajEb9jDZuyg==
X-Received: by 2002:a05:6402:27ca:b0:57d:32ff:73ef with SMTP id 4fb4d7f45d1cf-5becb5bc0acmr67991a12.6.1723801767410;
        Fri, 16 Aug 2024 02:49:27 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648ea4sm18231855e9.1.2024.08.16.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:49:26 -0700 (PDT)
Date: Fri, 16 Aug 2024 09:49:22 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr8gom978iZftV_9@google.com>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
 <Zr30BjAcVDKJPv3B@google.com>
 <20240815125919.GH3468552@ziepe.ca>
 <43290d6c-004d-423c-822c-7b2558badcee@arm.com>
 <20240815135951.GM3468552@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815135951.GM3468552@ziepe.ca>

On Thu, Aug 15, 2024 at 10:59:51AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 02:41:52PM +0100, Robin Murphy wrote:
> 
> > Unfortunately we can't do that, because there *are* RCiEP devices whose data
> > interfaces are native AMBA, and thus for whom stalling is not actually a
> > protocol violation as it would be on a real PCIe transport layer;
> > correspondingly, it's *because* they are not true PCIe devices that they
> > can't support ATS, and thus need stall support in order to do SVA, so things
> > should still work out OK in practice.
> 
> I wondered if that would be the case.
> 
> Looks like if we want to do anything then arm_smmu_ats_supported()
> would be the right place.

Yes, I guess that might be the place, although the spec seems more
relaxed regarding stage-1 stall.

Anyway I will drop it from this patch, as Robin mentioned this should
only happen with buggy firmware and we can have another patch to
harden that if required.

Thanks,
Mostafa

> 
> > >          if (dev_is_pci(dev)) {
> > > 
> > > Though I have no idea how the GPU driver that wants to use this
> > > works - it doesn't seem to be intree :\
> > 
> > It's not a GPU: drivers/crypto/hisilicon/zip/
> 
> Ohhhh.. so it goes through uacce, I see.
> 
> Jason
