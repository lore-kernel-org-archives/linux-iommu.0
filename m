Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583C3C17
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261990; cv=none; b=toK5POzvgwLTuC19FTOhasypsiK1X45c9ZXjmrdpBcRInDmimGLH+Tiawsv+IW6MvlS6kXvaSno2FiP1JeX+N+sSevs1lIf+LSU2/9qeXPFMweEseTh8Z/YS9tPEMSQh8bQqyhnSgLWusZeMgYldks0i1Xe5TQ7g/E9BRI85Pik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261990; c=relaxed/simple;
	bh=ZsBt8lSxzA+AlE5/dHTYCGZPEvYSA2sH3m2oRztGLPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAj3JZb2ISRZNGWYcOmt3ut4ZVmovw0WU2kT6QpFAZJKoPtaebfhzzgHqWwlKounGcd7XLF3A71mtAoVqIQPukYgMtTP/tar+70Pe6PT1xu5YSulmP1HURYGhJY1nadHdH9YatIbWDquhvwdLZjjTJqMofsWtMjNR4P92puZjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dkIqKK30; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dkIqKK30"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so13819416d6.3
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729261987; x=1729866787; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+9pFFBKupu2d6NLFEvg3/oQA/e9juqrsydZKewjkBU=;
        b=dkIqKK30LgsZQlBTeLYC2SWOPPeyEO2epy0KZ284TuIOf2ZvNBiM12nTah6+MW5RH2
         4FGPk97rJ+rTXKkQR+gfhx8Mg1quZ9MK3OOgAjVaOxRWrybi+nq5w18qGXdvEUiMB1kl
         SlLzGiDsXJEtM3KcyGQWvS8uCTFW7dToCkHZ9Py+lm9f7izo2jkAeu/urIWsvaQxfuuw
         VJKn8+omJXJpRbI4qepBw1/IUuOPQeXCPcbgDqfKfIpEwfteKXb3HlzZUj5U1J/spbcw
         TSwAp+JCO7AcvcUBxJf8++F3l+g1Fh+LSEDprtnCYrI4wzm2iT6H+b/6Z1EeEUVtRKV8
         CcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261987; x=1729866787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+9pFFBKupu2d6NLFEvg3/oQA/e9juqrsydZKewjkBU=;
        b=BiLwUtc5Kl0RumWnQbDpIKyDQCqfGMJ/MUcuobCyqrFPH4Ta4m3db1EkMTkowCP4AR
         qT1Ugr1lW3xnfkE9+s69RmLQYP9vIFb2WLo7IDtl9xrizNzJccv3OE+O0TKZCNaHZS0c
         LibXb+u4dOjtMofZm/v1tAaniyM4pLQRlAIcMkJuiQ/LT0RVhAR1RpJj0tP9ZhCTkgUA
         no2zxMIOn5bbYwMa+siPn/iiRAPltWMgEMZOzdBCBYSgnkdfapsr9koVAVgfXwbu7yb0
         Cdvfoyz5bTw0MNJeOqlrbEchtFjdT0TydM75j9D2FmxyMZQq4h26GO/3KwPTH10Jwg9b
         u3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUeEQYxbLRj4dfxNSBgtVM09gSwIrYM7AZfnmzcc6PwA8V6424IBVeSt7STNcjjRsgGR5/LOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd3z7sQnri1JGZvGJugIykxAHACeuW7V0GehEhdDQJrUhX6e2h
	7ChUtn1My30OG4LkgTRgjv+5jpKmvejR8z3Ir9m3pNsyjhwX9WJ+K+jXZJkCVXA=
X-Google-Smtp-Source: AGHT+IEUnvffc5zoOVV9FmS8JNociVSvHRxNtwPJIviTG5dQGue9og+yy0xqzK1+WW1GOz5SrBvicA==
X-Received: by 2002:a05:6214:4605:b0:6cb:e8d2:fef1 with SMTP id 6a1803df08f44-6cde15e2b1dmr56786036d6.39.1729261987343;
        Fri, 18 Oct 2024 07:33:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1179224sm7408316d6.64.2024.10.18.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:33:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1o2M-008F2Q-A5;
	Fri, 18 Oct 2024 11:33:06 -0300
Date: Fri, 18 Oct 2024 11:33:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241018143306.GN948948@ziepe.ca>
References: <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca>
 <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>

On Fri, Oct 18, 2024 at 09:58:37AM +0800, Baolu Lu wrote:
> On 2024/10/17 21:08, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
> > 
> > > Yes, you are right
> > >   I am using SRIOV vf and stall feature, so is_virtfn == true
> > > 
> > > Our ACC devices are fake pci endpoint devices which supports stall,
> > > And they also supports sriov
> > > 
> > > So I have to ignore the limitation.
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
> 	if (dev_is_pci(dev)) {
> 		struct pci_dev *pdev = to_pci_dev(dev);
> 		if (pdev->is_virtfn && pci_pri_supported(pdev))
> 			return -EINVAL;
> 	}

Makes sense to me

Thanks,
Jason
