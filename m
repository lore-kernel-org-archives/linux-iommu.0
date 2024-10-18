Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B934D8BC
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219526; cv=none; b=f0czLEvCmWdSaVTnnYDEBVhFQ6X+sXee1OSmdlrNxeydJ/3X2slx91wqcSaB/3ITumv6/q2QicQLAeGjWu0VU4R8uKZ1XmVo1F5cUnFvM4GEO1nob8CxmsGhGhEizngwi1u2Ew3orYVLXBDVY4eHeyB3GLX3NPRmpYGOpaPR5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219526; c=relaxed/simple;
	bh=kgRRZiy9FfZN7xD7EZSFKYhFZvRCjUnO4G3r4bM18nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brw4/2Iv79UdUa8yIlVKyXj1sonYu0jMRl/Pc2EV3iDmMM3jhuo5FfOJNmxU8OUVEHQNXRISz8H9nuPJpgDk7jzk0myLhmzwdJ06alsF7TGMTjpKdBQQQFX0tVbw+JgiqgjINRj2LoXMnBf5o9V96tgS84C6Gp9JERuUTRk2R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lei/pF9R; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lei/pF9R"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so14244811fa.3
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729219522; x=1729824322; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1sLZ/lXwGBM2rahMvEDIQo5diSLBoxj3foQMEQZCG+M=;
        b=lei/pF9RSS4wg9l16IbsB/JMb7fx04kpROzJLFJD9DIYpn15VTYsGvzX5S6lKyFc9L
         eKUSydWn4EDkX1zUUSWPeWHLz1++ngdLFBQs6xpSJLPbyeITLTIGk2PTJmDVs+ZPorR0
         rnvaRPZDPnnmlJwnmYiCoaEOxD4yLpVku9HLLIDEinkymH578bhgr2L225VQdiK7muC1
         G60WmRpFO1xnhFCoQdSOxMva8Aho7EwjHFtrkJ3Tg5j1EgKdP00zsz2UKwJ2Z26SD3/O
         hpG5FmzARATj5BVg4RZmoNAlCG5Dh58QMRaUoQ/zcQjrkfWYxfuRGHrNq9kPGnLZCFf9
         h9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729219522; x=1729824322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sLZ/lXwGBM2rahMvEDIQo5diSLBoxj3foQMEQZCG+M=;
        b=rBUYsTwaPMdQBnPemUjlpF8afMD/vlhwJsVwOQfsJFLmVlFaqPl1KGQgBgYAGPsEc2
         YpQsc/+DJYpx9S6q+C9CYJY8T56bUoikykSckkxl/DSIM7i0miGO6Vl8U/M8r4i8nE2N
         uapIu4qd7E+D7rYxQWHili4pGroR5bfRzXIRNqalaVf+PywWLpVOlAd58pi3/UmlMr8V
         XIQOFYGj/X9PyAP8UY3+6pWtPXGaLfgTJEVi0s3X1hSgbCQaTfLzov4EEWZiM74LGEHR
         bglUz3mBBCDTRAxp+xOlBwDPueBW9T9Anl24HlHNCiGvAd3l5m6Id/CHL7VxGTse6bEC
         tbxw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbaA3+i3LuaYNHKSK+A55inZoSG9QR7nAHzQZ6CZax5CHpCR1i0hsdor12j8hzPtyYvcEXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ9ijASwcsZqY2SzJ7r1I+6rYqsOyjExjmCSPUv44w4jRLTkNh
	k7hGiQ55IhQ3mc/Q2chJu92rg8E+ZIPHIROeT0phw3jWJmtZaVcuxwOtni+Jb7IuS1GyEpKJyZK
	zXxc1fWvYsPgBYNOQw9gW0WXHPmSzZ2CVHaYViw==
X-Google-Smtp-Source: AGHT+IE4lNRH1NWbi5vrC+GoEkZzjuYwAofdC4w+Awg53/xnT+cp6AFOUD/q+symJRS/APkqXdj2/T+NOFXcw+CS00A=
X-Received: by 2002:a05:6512:128f:b0:539:f1ce:5fa8 with SMTP id
 2adb3069b0e04-53a1550b9e6mr438878e87.49.1729219522198; Thu, 17 Oct 2024
 19:45:22 -0700 (PDT)
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
In-Reply-To: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 18 Oct 2024 10:45:11 +0800
Message-ID: <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
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

On Fri, 18 Oct 2024 at 09:58, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> >
> >> Yes, you are right
> >>   I am using SRIOV vf and stall feature, so is_virtfn == true
> >>
> >> Our ACC devices are fake pci endpoint devices which supports stall,
> >> And they also supports sriov
> >>
> >> So I have to ignore the limitation.
> > I see, so that is more complicated.
> >
> > Lu, what do you think about also checking if the PCI function has PRI
> > ? If not PRI assume the fault is special and doesn't follow PRI rules?
> >
> > Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
> > fault?
>
> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
> a shared resource and current iommu subsystem is not ready to support
> enabling/disabling PRI on a VF without any impact on others.
>
> In my understanding, it's fine to remove this limitation from the use
> case of non-PRI on SRIOV VFs. Perhaps something like below?
>
#include <linux/pci-ats.h>
>         if (dev_is_pci(dev)) {
>                 struct pci_dev *pdev = to_pci_dev(dev);
>                 if (pdev->is_virtfn && pci_pri_supported(pdev))
>                         return -EINVAL;
>         }

Yes, this works on our platform.

Thanks Baolu.
