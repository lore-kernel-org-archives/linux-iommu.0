Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391AA1DC18B
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166723; cv=none; b=fsngAi1L4NbYU4I4rxnh5N53KZgxQXGHs4fPdVoV1Zci0VhRKt5mazT6ZbXn7COpik5NDARmO3urKnJtv2UIGBx/yOTO3/wGXOR4LkgIzYB/fn1ew1btBLyqmWBqa4Hp/zUeESkgiNE11DBvIBr2T342dAGmnDHGZjLKACQMMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166723; c=relaxed/simple;
	bh=9Ou2IPV+fUYVUZFwDwpHsxjEEQ10P3Z4LAfWFwq7vtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG6WeqHtBMVLAAF6AZTKex4laeWpaT2vWL1ge7V3UghjSxMv0xRkgFZPF6hrC8OMG3P+fPCpkAN1k1hXP8KzZVzoEXb8S53k3kTRXktVWM0lfW5yzcXIuVTFFnz6B4XDIVG4nLbAucLRRvXzHlkuSg2yFBqqwMfwKZJ4FY67svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ibjJy1xu; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ibjJy1xu"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b14f3927ddso68553185a.3
        for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729166719; x=1729771519; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqYmbfPGoH8bApHw169OlytcN5sSb6v9X/QNj/xnHLY=;
        b=ibjJy1xuFx/wxf78NE4VpFl1nznV3/7ezosqdGbFz2oMNcuXwrQ0I0SPun8km7Jhza
         JIievyEPMVCByrcP60S8i4bUoISna8TpTbyIPrN3HjDvhmLEmOpdbSMclb3gBA3WnvZq
         ZoEga59f9tIcZNL6oiXuCvdfeALKtnHUcqp34meoRc0cWTAZBt5OSIg0g7eFGalb9cIf
         7fHXkBFN8vlP2PmqqYlXh1OBxv4mpkz6IskFxqOPwEXQ4OTdWn4GsbKtd15yNXbYjXZh
         /J7dyzoGmciKMWqCGv+oGZH8kaEMvRThFvDGdoNG8fzsY8MEu057yuTnnLZoOAbtm2ot
         fUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166719; x=1729771519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqYmbfPGoH8bApHw169OlytcN5sSb6v9X/QNj/xnHLY=;
        b=sLwtI9jfuW/JERrUz3MrOFXoOzYQOBjO/vcPKvJMzgo2160OmY7a5A57XPK29Ugz4O
         8MwpXleibTKR6d+2uFQxJJhNYOiJi5GWFAWS78vn/WEFMfpyiIayYd1HLDAkPRKb3Bhm
         PQURZckMZxsziUvfPsZqujCJ8t4I6zpc4ozqIKDdO9bQB+Gzg4RjKSA+vIm2q9XgWIqq
         69SygY/kwX7TrpuqcdMzQ6QWJ55Z87FsHCOje9gX9ZCW/FXGAeEoiKhlhKYIL/nVdpDW
         /fIEKD+RAJ1q4Qj4xpk5ZfCbGWSB3zW2FQYSamNFVTBoFxp+hUripbfgWkBofiQPeFaf
         pi4g==
X-Forwarded-Encrypted: i=1; AJvYcCXISz2a70D/DIc44ctRAJL2ASiyegYGzk9Rx/NX8mOvpIBlR+zh9NmZzowGEB14cO83SLmqLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8sQ6cioTUxjScPZs48tX7QygIB/7MDg3YJi3ptnWkiP0J9zYC
	HYCk70Pi1foUdGFKMNm8yp+ObdUTh78HmAmLoauLcMYAlCt+6bAD0XXSIrSk2yM=
X-Google-Smtp-Source: AGHT+IEPtt04l70kN6bicB55lZv2cm4Yf4rIE4G65war3hf5YJH+Qt48rYAG8z4yCn6t9Q2qUjjXgg==
X-Received: by 2002:a05:620a:44c5:b0:7a9:ab71:f820 with SMTP id af79cd13be357-7b1417a24ddmr959080985a.4.1729166719151;
        Thu, 17 Oct 2024 05:05:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1424ba332sm223436285a.81.2024.10.17.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:05:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1PFm-003iH2-4Y;
	Thu, 17 Oct 2024 09:05:18 -0300
Date: Thu, 17 Oct 2024 09:05:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241017120518.GI4020792@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:44:18AM +0800, Zhangfei Gao wrote:
> On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > > +{
> > > > > > +       struct device *dev = idev->dev;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > > +        */
> > > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > > +               return -EINVAL;
> > > > >
> > > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > > And now I am hacking to comment this check.
> > > > > Any suggestions?
> > > >
> > > > Are you using PCI SRIOV and stall together?
> > >
> > > Only use smmuv3 stall feature.
> >
> > Then isn't to_pci_dev(dev)->is_virtfn == false?
> >
> > That should only be true with SRIOV
> 
> Do you mean
> if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
>     return -EINVAL;
>
> This is fine

No, I mean on your test system you are not using SRIOV so all your PCI
devices will have is_virtfn == false and the above if shouldn't be a
problem. is_virtfn indicates the PCI device is a SRIOV VF.

Your explanation for your problem doesn't really make sense, or there
is something wrong someplace else to get a bogus is_virtfn..

If you are doing SRIOV with stall, then that is understandable.

Jason
