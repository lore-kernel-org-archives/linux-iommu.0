Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855673F9D2
	for <iommu@lists.linux.dev>; Sun, 27 Oct 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730038391; cv=none; b=cAQIqUSvdzKsNHfXV1ttqqg9VWiXI5SO3r60s+S1bEPyKKUyqd3Q8YtqvpKCoYzWdnStbOMofC+uPvsQAh0aDtWAdpmhlv4rF+yLdRlULWc/Z7APJWb4wgN9Cw/uzXehB4lsdtmew5DpbPAQn+HVbS4uZzR1J+Nw7aSFwrTveGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730038391; c=relaxed/simple;
	bh=NuJVWMDK6/NmMLATecVP6fHMJcRsxCQ6vGdOe7SC6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9U4qiUpQFHe/vQf8W8a7Qht6eQwD6LIvt12qouU9dK0L48kVeo0AG7qsTfaXgfcnvFi11e0fNS5ZCX78EXlOcARAnkTqQSqZ6BMKdN0uUDiDeLrOY1R357aWO1vubav6RONbAjT4+q1R1vnLds9T4cAhjL7GwVYIwXMJT6CV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fl98W2AZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fl98W2AZ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f84907caso3718197e87.3
        for <iommu@lists.linux.dev>; Sun, 27 Oct 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730038388; x=1730643188; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mY015nA+JmXHvPrUJpYeYBU2P2Uf8UWr8WMYD7k1UEk=;
        b=Fl98W2AZEAlYuwuTKpnWqgDu8FSOkneuvUi1Sqto1HQzBIMSkAydZqBxYFqbB2KrGg
         igGy85NNf4/yQYyqEgqNrHKJ9Yxq6KWdtPEACJ9unbadwJgJysvpeWcQGPC4cBpRHwNG
         wkmZu3DtBq0ASgw4DjNmvGs1LmjvZjqXva/1eYZizBstvqx0An0gpLhExtr0OrGNN9/G
         YqKAMtA6Vb0m2QFkdxd/jQbb6ftSItf8Hzm7fP5MHdMIHpPjW86rNssQD+SCL5lzOKpR
         0P3oMU3+kIqY6k4JPtftLVWMyac3KnbYBY2nvdqhNRFOG27jjzQUdPLcWGN7X0YLxf2t
         ZSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730038388; x=1730643188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mY015nA+JmXHvPrUJpYeYBU2P2Uf8UWr8WMYD7k1UEk=;
        b=N25USXkfarNYGMrs+qx8UOASz8nOGvKn3B60Z8WptbI2FhGnp7MxENRezHqWu5lh8K
         kM1iAkIGDGuMZx6JukfCytIBAv6IikK3Fah36ro1L1Yj5Olf2pA6wXjdJVzbejbljyTI
         cHxsgnTW1BEME+aUfucxEMR33hCTfyMshwQsa6RdHdJipzwwQInOSGlqyKSa+arZqD8Q
         /hY48PWoSIAXPo/T3c4hym3xFL4xhFPwr2Sy2kIY5wU+Bv5EcTfwB1K35id55PqPtPLc
         UPUbNCcd9n9nY8ke0oeZnW+HEObzBVS38oR6LqlUBTSIbFoEr8leKidgB3xNwqCGFw01
         Crrw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/VkOeapF6GX6B6bwnokucN8MH8QcE78QHYJGw1l6ZmCTsf70O+G2mGEMJ46DVFiaAagrvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1XphVjtfSQ1MlSBZlFxYRtgc+CKBF/iROFtFG76LRpkvQACPG
	UxoaaVzm4bVV26MkwpwTRBFJHYPSu1ApS146+GlBQByKcSpU47XcYrgL4if6uRJudI0MwWNG1mD
	EPjx2M2QP4CqN/0ELtQojhy3FplhD+kn4vCJSPQ==
X-Google-Smtp-Source: AGHT+IG4rD8sxA4zeN56s3nv4eo2saz2wQJT8dqXvPZ5lIrF4A6ASYbFn9RyJjsRApMWKVy/sZQFavLyt3vl81pP7/0=
X-Received: by 2002:a05:6512:3b27:b0:539:de9c:c890 with SMTP id
 2adb3069b0e04-53b34c5f9b5mr1778649e87.42.1730038387547; Sun, 27 Oct 2024
 07:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca> <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca> <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca> <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
In-Reply-To: <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Sun, 27 Oct 2024 22:12:55 +0800
Message-ID: <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Fri, 18 Oct 2024 at 10:45, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Baolu
>
> On Fri, 18 Oct 2024 at 09:58, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> > >
> > >> Yes, you are right
> > >>   I am using SRIOV vf and stall feature, so is_virtfn == true
> > >>
> > >> Our ACC devices are fake pci endpoint devices which supports stall,
> > >> And they also supports sriov
> > >>
> > >> So I have to ignore the limitation.
> > > I see, so that is more complicated.
> > >
> > > Lu, what do you think about also checking if the PCI function has PRI
> > > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> > >
> > > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > > fault?
> >
> > This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> > a shared resource and current iommu subsystem is not ready to support
> > enabling/disabling PRI on a VF without any impact on others.
> >
> > In my understanding, it's fine to remove this limitation from the use
> > case of non-PRI on SRIOV VFs. Perhaps something like below?
> >
> #include <linux/pci-ats.h>
> >         if (dev_is_pci(dev)) {
> >                 struct pci_dev *pdev = to_pci_dev(dev);
> >                 if (pdev->is_virtfn && pci_pri_supported(pdev))
> >                         return -EINVAL;
> >         }
>
> Yes, this works on our platform.

Will you send this patch?

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
