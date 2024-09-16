Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E714EC47
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500170; cv=none; b=FKB9uPsccQhaUMMy9AXb3eaRvwJWMeOoTGD6Lz7+BOp2qNWLYBmOlxK9OLKRYWivgjlFwM3+ofdaYmal/ZAAQhSVDP3MTY7pvM3b+NN3/gQHAPGCpgRj4atYgWGI8o7oRDn2HzEHYWTxfx3KLdOWgaB2Ckk150ioLvvUHHn/gA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500170; c=relaxed/simple;
	bh=tVZWxRmIaPjkwxZjrjPsv3Y2yTvtta+wB5FvXUdecJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyXfTMs3tTSin4yZFZUEFu/HS5bWCBsZZji7Ing0cLACRCxC2l6yGz+8rNi6iiJh0KIk2K+NZawrjLmvb461bmjmlY6gDwcq/w0ujbq4P6QtZSLAiFstDNR0Mi3SWpOfKEA//6r6vsNQDo0NYhgdATYSxjUHszN9lcpVLENpBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmKfOVW3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmKfOVW3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365cf5de24so5754179e87.1
        for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726500167; x=1727104967; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJH8q3zUGDvemsqnvmD1EkQ7apsHHqB99DRBXUhb52Y=;
        b=WmKfOVW3mal2+qTEEibwrnTUN1/AzbtjXJ0Hkx1Wk8r/vjhT1qj97fFRYoLq6jjsHG
         1YndB+Gs4AdJRP9PCx6ARffCLpryfoLooGacbLVGesVwGQhrW75Xmaxp78APTgpG+tP5
         cg9UOovxXv0gHgrKuQnSMqL+UTOjYjnyM8hYPKc8Ef18BiF1n1zO4cpXPiHPaydtXaoO
         hr7GqwtxSYQ70u97tXdV+4N9GeHZcvXfvzgU7vzaktWHFZ/EhNDvRU3zH2WCXL8xZWfC
         IOR7prDefcbN0f9kpcM9abB8IKv0gxppvFDJfdYikUwXDP9Zie0uxWBJco5itvyy/leq
         qkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726500167; x=1727104967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJH8q3zUGDvemsqnvmD1EkQ7apsHHqB99DRBXUhb52Y=;
        b=u7xBoqWvLdgGhVBGiuVn5s3W69qyfYAHwpAMcVNGEG7dSoKJsoF8t7XQzI+LKNaULd
         gqRHC9PhXXINrWTvBauS5gvSY+39o7XIhrkC91TxMGwZ9gG4WLKwbgU7+K7yor5FmAPU
         Y3/IO9XIBrhoN7YrU9Agl3sB48Nvd249tbHL+5wXDfUyn8Lm/YQ6i4nP0Xx878cR9W1b
         wTl+756jtAJGrhnIWlMtBtgAF6DiBQkzZivpEDr/mrPHdooogSded0N+jgPtKHzYQ+Nj
         KKOtEudrCCd2JZ6th4Iy8IRbs2S5Qf8Ux3eWqGo7MMUQEbcSfxz2oHWJDauwtsDl/PS8
         ncww==
X-Forwarded-Encrypted: i=1; AJvYcCX5QmOEruCsq1L1+LqWa/gNMRMbzevuNsej/oL0MMZYzyp1FDa0exBJOTJLXn/BxBGdlt6JXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHHmhNnJoPxAKz62QG/0ktkNPMugIK1c67dxEdNmCQmWutK6Gb
	ypSkyn1y9DShcEX5NgtDJCkC2MS2XgI6PWtQfv1PRhdFggzo4wdqCQX5WvJ6D6lpK/UDLPsXvnA
	7nSyXMVQQwFL18ImhPRHL0gykSDQ9XO84aoVPEg==
X-Google-Smtp-Source: AGHT+IGcEKlFV3pwbfg7CV1kZ+gQRTNQk5/kvcUGWZdfkvvt5fw/iXNqIsTSUF3APv0qV9KKgaOmCjXJOGrBE10LspA=
X-Received: by 2002:a05:6512:224f:b0:52f:c13f:23d2 with SMTP id
 2adb3069b0e04-53678fbf051mr8212934e87.25.1726500166823; Mon, 16 Sep 2024
 08:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZsdktJEqR9BOgivK@p14s> <20240822162425.GE3468552@ziepe.ca> <20240915140929.GA1834200@nvidia.com>
In-Reply-To: <20240915140929.GA1834200@nvidia.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 16 Sep 2024 09:22:35 -0600
Message-ID: <CANLsYkwQ3LbvyUSnJjSTYRPSwaWxwKn3sRFS1iy0=d2F-TyoFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, andersson@kernel.org, afd@ti.com, nm@ti.com, 
	hnagalla@ti.com, b-padhi@ti.com, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-remoteproc@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 08:09, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Aug 22, 2024 at 01:24:25PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 22, 2024 at 10:17:56AM -0600, Mathieu Poirier wrote:
> >
> > > > - domain = iommu_domain_alloc(dev->bus);
> > > > - if (!domain) {
> > > > + domain = iommu_paging_domain_alloc(dev);
> > >
> > > I'm a little hesitant here.  Function iommu_domain_alloc() passes NULL two the
> > > second argument of __iommu_domain_alloc() while iommu_paging_domain_alloc()
> > > provides a 'dev'.  I don't have any HW to test on and I am not familiar enough
> > > with the IOMMU subsystem to confidently more forward.
> >
> > So long as dev is the device that will be initiating DMA this is a
> > correct change from the iommu subsystem perspective.
>
> This is the only call site left for iommu_domain_alloc() - we want to
> remove this API on the next cycle. Please take the patch
>

And I have no intentions of delaying things further.  I will discuss
this with Bjorn later this week in Vienna.

> Thanks,
> Jason
