Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF453AC
	for <iommu@lists.linux.dev>; Sat, 29 Jun 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623510; cv=none; b=bYQSpBI9R+xvB+J3KLflc5KdL/GlWat+QQ3rs/gag5OAoOf9d729Y1CkqQHMk8C094DdrxRLF4oGRjrs9tq4U5SvibqzTy1zXlRR2RWW1ucDlU1q2gZwlVJ2GbVssc3bM0tSF2Z/bAtLvyadGCoYoJjBYNnSYXIGc1Ha6/IB0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623510; c=relaxed/simple;
	bh=0qHl+0DqNRpvSKTfp02INWgx8IbLG3jiIbFjAdPVnaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1PvsP/b5LcqhCHn0GWaC5EB0RQgbE91ICy3BbapX86BuLdTS18kEXMT9awl+qrID7gzSCACo7Sj653Di+Sh8JhgVsJNf+LaV/xLUUg58R7WvMBs+zmgs7HdHso155SCHlYJ6f3eARh5uDn+9koJE1S+EpGP67b1HHy6Fe0XcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lBT7h0+G; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lBT7h0+G"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7065e2fe7d9so924231b3a.3
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623508; x=1720228308; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhWMM+W00ZGyNJkSp9eBep0aP7iOumSA6mBp+eSCZ4g=;
        b=lBT7h0+Gs+9k3CEU88Ho6T2fQ20751LHqopN/16s0kYYHzXnnEuqPb+kGvOWd+KWqL
         UlnYXXZyWX+khBHKmdgqpqP+EkTlsM+IDB18KnXgDJpAlcvW6TC0Djo48QxJh3oiqcnI
         G3HQ0F2Y0oZqILropcg5EkOX6g4z6+BoiKnWauOtBME9Gfkds2owROiRWKBhK6c4Fa4Z
         dF3I/4Ai0SjeoifNAOgaTroxkNkydSVgc9YvjQK+7LUrV8mhjfLn0vIkpEiuqbKaJxx8
         ou6m0ZI1riV5YwOBGkrEzDVTbGmuU25gPRCxk/z3P+Dl0bq+wirxI4b/3mPHARmQrK2S
         Meew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623508; x=1720228308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhWMM+W00ZGyNJkSp9eBep0aP7iOumSA6mBp+eSCZ4g=;
        b=iKQeJFHaZU53HfYmXX/SaRCHuWVj3Xgtrek/pimGpwpy0EmAo3HtaT0lOLleeV39qa
         gW4WQUwzpvHLJ2+4/Swi34sOB8gPpxt2Dc+oghtBYECJICZf6rLIgbpon6Nc8M4juHwY
         RbukkaeFXm0sUjCJEUYlSu1cEFEKMXfxPA94gtIR3QfKnqGWjjHGUEQRPIuWwcnRftxP
         KCcq5KqjMmiSQWWoqW0dgi1mFM/5mzgXPaJLHvt4mGoSFGDTr3x2I1D4VLZGtHNK6pnD
         Ki5m+TU4T50eoVAoLPmLTd8OHLSIc+B+mg5b2RvR/ylGUOLKXBIpHNwoWFANWZpM+tVz
         NZTg==
X-Forwarded-Encrypted: i=1; AJvYcCVf36FsaOYkuoX4a0/YEvHZhys2ilBYKEarGl0xuuUPiedxCcBjpqCuuP8iq8IlWAgsd4NW0zgGVizzZyLmfaoJhml/oNY=
X-Gm-Message-State: AOJu0YzhSWY98lc6KchOPTHIWHNeypzu0MIZDrDv+Pbw2fQBPF89BLZ/
	ZShYDvGOB42A/XpxSRnq4vye7iQVlKKHtNgKZzKWFNPZhiSGjvuildJu1B7sw+Q=
X-Google-Smtp-Source: AGHT+IFV8W1dqzQexTf6L4R/t2BuL68I/iJC437XoQYe9jmo2sb2vcOp8E1T0SgaT9dJjMWIhEFnUw==
X-Received: by 2002:a05:6a00:9283:b0:705:d805:2168 with SMTP id d2e1a72fcca58-706745beb1fmr26156318b3a.10.1719623507953;
        Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:47 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNIyF-0004Uj-H8;
	Fri, 28 Jun 2024 18:17:27 -0300
Date: Fri, 28 Jun 2024 18:17:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <Zn8oZ80p0p1bHgBC@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-8-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> +{
> +	struct device *dev = idev->dev;
> +	int ret;
> +
> +	/*
> +	 * Once we turn on PCI/PRI support for VF, the response failure code
> +	 * should not be forwarded to the hardware due to PRI being a shared
> +	 * resource between PF and VFs. There is no coordination for this
> +	 * shared capability. This waits for a vPRI reset to recover.
> +	 */
> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> +		return -EINVAL;

I don't quite get this remark, isn't not supporting PRI on VFs kind of
useless? What is the story here?

Jason
