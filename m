Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727191D5173
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168541; cv=none; b=e/wL8HMEytf0wfmJEe3xBQyocLF7a26PRM+uMrrTM7qDUFBIx0x1Tj84fOJapUE4ONVDa4uKLPyo001xNClkwbcYi8V6VPy17lY4Ww1GGDdmX8PswVDx+OrikGjkxipO0LZYIRtvQhnMKRWSR250CIIi9mOVmWUsoROFihBhNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168541; c=relaxed/simple;
	bh=stgROs37qwDGESBufWBachz+WHBFXWh4SvTQfT/sml0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkA28OlXuCwqFXG4hgWLihCieEZUgGEwPXyx2OybCvVoCjynCl+4+NLRShixfhuFPWaCk9Q6ON89qf9dLAedldpS0XsMP33fknEin7EXU5VCCX2NZIqQ6Xdqvbi3+4mHusRM1wsTww7pi86wUenN2FZXghjJWqvmQZCiDlnc7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oN9kUXb4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oN9kUXb4"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so879311e87.3
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729168536; x=1729773336; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kM7OrfRTdZQrTofk4LGSXNvpUV7LDhsGRtxbKPLtBSM=;
        b=oN9kUXb4NF8WB0TJuOO12f6r4uxd/OX6ZGrFPtqZX6ZO+oFuCmkWCDK2uwrT2MTlgY
         mED/4X6LQ9NAJuHnLKY7LRhl4ljbLPRHWA37vxA0+P5vzlxpG50anQZHFn9agGcZUg1o
         ++4V7/PJxwq8wkdycLni33nCyGv27fmQubbbkeBPzVR4BzmajG1pdeQOVz88K95IC0vO
         LiW7Abxoelpt/UnRlUk7hfonvQo+frE6WeJjufmXB0jffOEVvrFVfurnPtDl94r7Cr7w
         VcyAWhxNuaMr06i+oHfEVb9vX9OEw9c08i+E4WirkYUg9k5Nao7qIjhfrANwkCL6BnTI
         75Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729168536; x=1729773336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM7OrfRTdZQrTofk4LGSXNvpUV7LDhsGRtxbKPLtBSM=;
        b=uXDZcgHGVUiDFPxGmuPWYqu3aJ95vbGkIvXYNqOu7Vm7miG2KCmOefOiZuXKUHIMj6
         Lz5A+EeBm4bhRSs8YHuHf+aLnYEv4Vwa3ePE+ay/KpvpgwB737U1omfwqtmjWnNl0gpb
         xO6uHX7rt4LzBHSrwcJnBylPa0tBLO6qkSaAjrj83uiBje/opVp3d8YzU7ZQLSYXvCxq
         iP/rpQe18JUITxk9ehpccbg8LHp8QSDGHEWf/eCM6AmH/OLlPGalD9Gzak6nYmRjYy96
         MrX7GA9/qE3KOTIPsEWxYQlZnEDWvxykH/Cb+rF22Bqw8H1scRQQeb/wEnfj98hf2ixP
         fzrw==
X-Forwarded-Encrypted: i=1; AJvYcCVvroDmwA9G2B6qpfRjr64igrkzp+dJVuk5Ohy1KzkfCuDdPmlrR+amcPmStaXN2bcR0ODfAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNYqC6ZYkFO7YPL6w1euNqs7nMa4zcdFyIxuxNDJEah7EBscvy
	AESu9SMyf/XgTX8a0qAzS83/mz2HTKliiUUPeWDr6j6pUhMKIey9OXr6JRoxcVRijjLyxPF/wD4
	54uqa0H2geqWHges6dqsO8vpYyoWO4pr5gHWWJw==
X-Google-Smtp-Source: AGHT+IH4WJKolhUJPprqECOsvSWy5mgerznZLfFjdhTs0fsqDZ0hzHkE+rz7FwoNqJnQZ8jgoGMGTXT1t5RYO39n54k=
X-Received: by 2002:a05:6512:3085:b0:539:e873:6e6 with SMTP id
 2adb3069b0e04-53a03f82439mr5602333e87.43.1729168536304; Thu, 17 Oct 2024
 05:35:36 -0700 (PDT)
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
 <20241017120518.GI4020792@ziepe.ca>
In-Reply-To: <20241017120518.GI4020792@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 20:35:24 +0800
Message-ID: <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 20:05, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Oct 17, 2024 at 09:44:18AM +0800, Zhangfei Gao wrote:
> > On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > > > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > > > +{
> > > > > > > +       struct device *dev = idev->dev;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > > > +        */
> > > > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > > > +               return -EINVAL;
> > > > > >
> > > > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > > > And now I am hacking to comment this check.
> > > > > > Any suggestions?
> > > > >
> > > > > Are you using PCI SRIOV and stall together?
> > > >
> > > > Only use smmuv3 stall feature.
Sorry, this is not correct

> > >
> > > Then isn't to_pci_dev(dev)->is_virtfn == false?
> > >
> > > That should only be true with SRIOV
> >
> > Do you mean
> > if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
> >     return -EINVAL;
> >
> > This is fine
>
> No, I mean on your test system you are not using SRIOV so all your PCI
> devices will have is_virtfn == false and the above if shouldn't be a
> problem. is_virtfn indicates the PCI device is a SRIOV VF.
>
> Your explanation for your problem doesn't really make sense, or there
> is something wrong someplace else to get a bogus is_virtfn..
>
> If you are doing SRIOV with stall, then that is understandable.

Yes, you are right
 I am using SRIOV vf and stall feature, so is_virtfn == true

Our ACC devices are fake pci endpoint devices which supports stall,
And they also supports sriov

So I have to ignore the limitation.

Thanks
