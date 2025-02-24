Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8B2046A4
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425011; cv=none; b=r9aTuS77BhKQfa4DJVleG7tDYDOtB0aJGgrStny5bg0gdNORzY6OvEprMwrlwd9e+ORR1QncfTRNIVry1Mk/6hM+Vf3+wbwcTuFqjHQswRH+ktA8PXAYRGD+Bh2f5YmIgbpns3cYvuEM9X9kb4P8A9WZXswOiLANJFekKoDW0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425011; c=relaxed/simple;
	bh=8cbM4V9ub4rnejeU1ZZ2B/L3f85wUTVcUeq+2GJa79k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzM2ehIAe7YgTVZhvAgTPajaesmP19dtyH+lQ0JdTKSvrXE0YczFCfrRw3Y5j1n0ak20cCcqIG1/Zj3O0mg56av5s0bRfh94KY1XXLud03cFeE+PYU/D0ShhG/BoXVFXDiL9FH/MHsqIsjP2UWdYr6QmvGKP5JzH+FwwCYpGfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JA4WJoQk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JA4WJoQk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0892e4b19so575142585a.3
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740425009; x=1741029809; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtNAj8eJxRHAo05cYb2k/oK+PktmXbkyBqA45R/z1e0=;
        b=JA4WJoQkNuJ488z34LP1TGpf0BPH8iSHx+D0FA99xMK18OuT3Vf2cNdkWVnLMPUJ7+
         YY7+32jDQarKOmyY7TB6rIx8/uH/Ep8DXEjLUJqU+CLnvPuhsT8pnRPC2Kon+14IbSpW
         2cLOxbZhCKjCyePq06/SXxC9XjABc6KemLSYZOXNPd87wKsleLFUkwoBk/WpicQHyXcI
         QAPW7WUjLtXnfxUoTIP62TXFsfZ3Vo7CrTirS7rfP9sEZNj70Dd03c2tKYt89g9OCbEG
         G1LldxdMfScrkZdesRB1mQZHIIxZOgFYgmy7DtA6EK4USXuLB2B05AeQrcydHVzqbnoS
         Dvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425009; x=1741029809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtNAj8eJxRHAo05cYb2k/oK+PktmXbkyBqA45R/z1e0=;
        b=RbHH7uILyiXUaRgh3TLCH3Gy5vt95UrX1Q7eG5JLLJUB/WE+uiWIRxT55hHCF2kv8c
         4iuVfNtyzs/wrwumzJzzTo8Fkbdf+hvAPraxa7WWZ17fWcpX3qh0WywtVfZaFK5xlFh9
         O7bBOId9w9aRbR/QWhYaHXhqz6fmufJU6C9I89GoBgD0yCu97cVXDpwte13pF3GdH6zY
         FG7UN6mlxBPwDT77KjrEWxvLC/gexgr+LF5CdkaK7d73zxnNtzRw6FCPfBI43dmGUCRz
         Eb1U0RH3SSgfahqKjUdLQ/1nWSICw7m6Z25XyWNm+m0vikq7Ofmt59C50M2nXPX/t2/8
         juTg==
X-Forwarded-Encrypted: i=1; AJvYcCX3+93ueO0PRG4ApyY6H6TQdL4IrdnyUnQnHYTX4jhZ9uJ6WaX7eQ18lhKrU3wm1wfsgw8gPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl2BBVk8touiT8oUoeZbyPOCYeeXKILrLG4Mb738MHuODF+vHF
	X3vTNoVNwLRMvKtJGKU3rdoMME9OzDexn//DM5LyFnLIT+DeSiahvReMwxZ+BBA=
X-Gm-Gg: ASbGncul9sAJP/vy7F87Qa6xfin54YaE34Ed7ug6l0cBQK5cS+vYyr+oe1FECOVwcHI
	ZZzB+pxR6bAmA554WMErheOlA8Pm9SjC785VNHMIUSkElZvSVLjW2LmvTlREOf5E/UIbeHZKLmn
	MzX5p87a5WIdLIBp7D5Bl+NES6aScQ4orOR4zA/cQUIdc+AZRVJkhYRxXfcyq14xtGmzGDG9dIx
	HZotJoHbpG+r2hrKtcoGfKodx5t4IjbGoNy61SVhYgmdzEhgHabdX+6UTnHIBicbvPmEAA7/G2F
X-Google-Smtp-Source: AGHT+IGeq9N/sleTryYSxmFHmjG3gE9MgwEWAr2E5G/8AEMsyKAkPjD3H6qBvUlnG+WAR4l96JGZRw==
X-Received: by 2002:a05:6214:626:b0:6e6:698f:cb00 with SMTP id 6a1803df08f44-6e6ae9c0c30mr210708946d6.42.1740425008796;
        Mon, 24 Feb 2025 11:23:28 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b086e18sm464276d6.44.2025.02.24.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:23:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tme35-00000002CJx-2O9s;
	Mon, 24 Feb 2025 15:23:27 -0400
Date: Mon, 24 Feb 2025 15:23:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <20250224192327.GA3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-9-baolu.lu@linux.intel.com>
 <20250220010250.GQ3696814@ziepe.ca>
 <d93c8cc9-77a5-4b78-85d2-6b4601f52266@linux.intel.com>
 <20250220180004.GX3696814@ziepe.ca>
 <6754e308-d2ee-4389-9dcd-c2a5bbb16c48@linux.intel.com>
 <20250221150401.GY3696814@ziepe.ca>
 <682b5b61-e556-479e-b641-3c987360d87b@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682b5b61-e556-479e-b641-3c987360d87b@linux.intel.com>

On Sat, Feb 22, 2025 at 03:25:43PM +0800, Baolu Lu wrote:
> On 2/21/25 23:04, Jason Gunthorpe wrote:
> > > -       return mock_dev_enable_iopf(dev, domain);
> > > +       if (mdev->domain)
> > > +               mock_dev_disable_iopf(dev, mdev->domain);
> > > +
> > > +       ret = mock_dev_enable_iopf(dev, domain);
> > > +       if (ret)
> > Though here the domain is disabled but not removed from mdev->domain,
> > is it OK?
> 
> That's not okay. I can make it like below:
> 
> static int mock_domain_nop_attach(struct iommu_domain *domain,
>                                   struct device *dev)
> {
>         struct mock_dev *mdev = to_mock_dev(dev);
>         int ret;
> 
>         if (domain->dirty_ops && (mdev->flags & MOCK_FLAGS_DEVICE_NO_DIRTY))
>                 return -EINVAL;
> 
>         ret = mock_dev_enable_iopf(dev, domain);
>         if (ret)
>                 return ret;
> 
>         mock_dev_disable_iopf(dev, mdev->domain);
>         mdev->domain = domain;
> 
>         return 0;
> }
> 
> Both mock_dev_enable/disable_iopf() will be a no-op if domain or
> domain's iopf handler is empty:
> 
>         if (!domain || !domain->iopf_handler)
>                 return;
> 
> Does it work for you?

Yeah that looks Ok

Jason
