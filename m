Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1528171A7
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043931; cv=none; b=QntRiIXHMRDfoLvBg1/e42IEDIpm/WcRKUbkM2M3OKD9+nJm0CuhX8GvaRX/q3nNDkVt3tjBaFqphsA/LPMhCa/Sqy2bHpi9fXXmEtEikLuH2Y/yBUw3ae3kd8PTghYAOiR3Zd0dLz/JwR64brQ6URq8XBQBbxGtTYt+8zTXp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043931; c=relaxed/simple;
	bh=dVq8802sNgxsYQrKPhpLGl2Ji48gzebkMI0KMfI8BG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eptjHVXWx57uRvErY6z7USsu4mCkScZr4Ld3IUBFEWeZO1OBaScUXopNz2Xn0R7f4P41r76y13bs82bIdaD1l2cf8oz+0yU2mTHZ/1M3YJNcE3u86SS7iYNGwZuGb/k6j9Zyzqm408L+M9NLlNQhsW+0X/e/cR0MmwodQiySVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iF0j/cA+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iF0j/cA+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fe02c386so443142e87.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729043928; x=1729648728; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/rtU2ORxq4VQYJugdVXcy5ZyrAZXc1jQ9TPE/XvnVI=;
        b=iF0j/cA+tMC58oHzIhNX9W5gk0zsnG7PDpUOaBgPvi8uI3E3UHCkecRvoixp7kEszu
         MV3av3BqlF+htRahjFgV7ljpovKfC8yf8hCKreg3liieL8ttYSHCEJa5Us6Xj7wcEwkd
         gr94qIJql0Pa46EXEzd49YstickRaAdKwXnFm4S5JvtzlJmibzLSo8Ub+nHePqjZiVA7
         qxtfmjtXrjPrtdLpk8AbyIqFeI9fHPv2CRe0UkYfrZ9fTv81Hi+KpnkFUb2uBmpqb6ZP
         bMxJOHJ5d+nsRHtFfZK29CqkgOP0FE0Nk8kdojxL8++mw8GmgbEUABrToQJGTJsTOFK4
         jrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729043928; x=1729648728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/rtU2ORxq4VQYJugdVXcy5ZyrAZXc1jQ9TPE/XvnVI=;
        b=ZvZuzrXaMqSxeJlfE60lgVCqaWwT9G76EzAbhArALTohxe87fXW+3PZM7OrMil6wpq
         H3jnyMGxgFi5NXVfbH8s7q0n8kCDTWLrrlmNlMk89NSiY6dFKIBC6vUxN0DgTEmhYsY0
         hIb3bnX2oLJqh+yu8JgsEv+suXJPiUcnFeSiEReRpBAHJ5iNMHHOGNxWVWW07yPZSWuY
         l9VMl+YMipMiUQEHFENHuIjWZihjf8xOCKqpqaEFmhlv06PcMtrxwYQzL9Jbp7+HwMUh
         haQB3mZMAA/A3gzFbinrrVyk4wB/lo+6n1u5L/GWL+upru3z0kKxLJkFTThP7VTEkWjR
         DaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOBW3lc0/lghW0fK12wd0ezLKbRtP3aUy9mQieNpRO6qMLXJGaOdlou6nRkwordAo5UjqUWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOyFL3Gy9VXkX7QE4h+dVHUOAb/Ime5pX3xsgodvJj8koUY6z7
	o47mTVBh43WgXCPAVXb2mETz2tNRtLxHMvKJK331JOyAozq154Kx0VZ2s+emACFhRaumLNmhupZ
	c2ycb7Z8q0D++4IxdqrtT5yjqAkCZuPTIAQQqOg==
X-Google-Smtp-Source: AGHT+IEB/XndljAYmvf9daRxR8zUkYMGinPm83aD1j6YhAnINHWEAphdGASnRtu0uajjdc4lTF2hFS3dM0SJE/wV/i4=
X-Received: by 2002:a05:6512:3a94:b0:539:fc1b:36d1 with SMTP id
 2adb3069b0e04-53a03c8fc81mr731316e87.6.1729043927809; Tue, 15 Oct 2024
 18:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
In-Reply-To: <20241015125420.GK1825128@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 09:58:36 +0800
Message-ID: <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
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

On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +       struct device *dev = idev->dev;
> > > +       int ret;
> > > +
> > > +       /*
> > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > +        * resource between PF and VFs. There is no coordination for this
> > > +        * shared capability. This waits for a vPRI reset to recover.
> > > +        */
> > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > +               return -EINVAL;
> >
> > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > And now I am hacking to comment this check.
> > Any suggestions?
>
> Are you using PCI SRIOV and stall together?

Only use smmuv3 stall feature.

>
> > > +       mutex_lock(&idev->iopf_lock);
> > > +       /* Device iopf has already been on. */
> > > +       if (++idev->iopf_enabled > 1) {
> > > +               mutex_unlock(&idev->iopf_lock);
> > > +               return 0;
> > > +       }
> > > +
> > > +       ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
> > > +       if (ret)
> > > +               --idev->iopf_enabled;
> > > +       mutex_unlock(&idev->iopf_lock);
> >
> > Also iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_SVA); is required
> > In thinking how to add it properly.
>
> FEAT_SVA needs to be deleted, not added too.
>
> smmu-v3 needs some more fixing to move that
> arm_smmu_master_enable_sva() logic into domain attachment.

Will think about this, Thanks Jason

>
> Jason
