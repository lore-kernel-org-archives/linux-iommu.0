Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD21362
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543899; cv=none; b=bvQA4m+qmrdILE+hKjXSjx9VuhINlCnG0yNl9gZNvIyeSH+ZoxXqMD4KfFJmZOIDMZ/dXxuNDx4LRuFsuTvdM0usQcEsXHWAvYxy4Hed3v3Cg9/6C+rIzrfUHNwO9TmtcrSBHsU1tsS+x8LdhyTmADr8zZhuU3HnPORaF8L62oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543899; c=relaxed/simple;
	bh=8fNMh0erOUyhYdLwt8SaHfy27gRj1t07hi2Ygwy4++g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLx5qRYA24O/w9pRB6PTQXTqx+iaIX/Lgs7B3g+BB5Odifcsb2UPt9pwPXb2pZktTHfwGe1XU/Z4ai7cVpn0/o9Ctw1Dv+MTZQGUs+wRcJNCg7k8HnZgU2OXBJmW04tzs1mnlT7vESIuvYBh9Yt/6jXpjT5Ul9Z1KeHmSUxVCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V/tHjBf/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V/tHjBf/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4774d68c670so17100941cf.0
        for <iommu@lists.linux.dev>; Thu, 29 May 2025 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748543897; x=1749148697; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6U4iis3R5XjOi+aCw7RCiw2bmEOQJGCtpg1KsnzGR0=;
        b=V/tHjBf/RzYcgcPZheF/QADE92YqoF0IpZzQsmawh752C+rSYh7RalXWRjIsHnrld1
         e4kPD83pRVKJWpuixZyTovuzgTlOM7eKKyI5fpoegHcSAAd4y0rfaea4tPD0eAaKoNsF
         WS2cbRbmn7f9Ee7pvxHLZMajc9YRSHOUKyljg61KhVolHvn7EBa5eHQvbp+FVWOPdPi1
         IfMXUc3v4XpdwoDW+ii3XopkTi8N4Bn09ev17+gaMflmszK5N/sAHR0827BfXQCBlyIl
         jlrHTkLXAm65e3BSeke+C3mVqTzDT/GGzk9rJHzINXfr2qK0WQHFNyhfxvCPH34GD0um
         hriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748543897; x=1749148697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6U4iis3R5XjOi+aCw7RCiw2bmEOQJGCtpg1KsnzGR0=;
        b=j0K68f1+9jMEv4vBXMjBKEx6jOadv6YrHaUXWsx/CoBvvjg1ofmqHRg3Bk9idUs2zl
         CXiwcnWq/oJvsWxgZNlTXceP2sNNhVtCeTSs3+T2roaO6XvJxjsphb4DOzVN+YzFUhJ+
         SDWwI7g1PHbhlwAJpZxIyp1FklOa4MP+Fj9QVLEag+XUj8YPg/vsWhB2CaDuzrUy5L+p
         EKVbqPFePLQgxPIFKrVPxGXi7FWqhsP+VXsXbIzWWBUpIAg1DHk4oXsa2tzFu3O2Xdlu
         wTSIL2eP8v6VyINzvpZ32J6nxHOjYQgpwgw7hYsL34wms/xgbT2O3kJAOjjWYueZpUH6
         sndA==
X-Forwarded-Encrypted: i=1; AJvYcCVqmuzenZS+JUJlAexLGI1eXDHGC6te1Qz9n8TOdT9XFJzOViW3+NYf3AKl+S9gIwZ4pun7SA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5xFiSGcWSwK+ozz764GuTFSc3W51PCvFLjgCGcOlwwN6laPwB
	AP0I2UGiDrfOz+eBSXPBSCDSs47Yh0Iypf84/f9Z8DTfvcdGbMtz3Bis+vhbatotHvg=
X-Gm-Gg: ASbGncsfw7IkAFPt590LnicuGRoPVm/MWjjRMCQEGEcNhxij/3Kx7zI5ud22siCR142
	FbGsuvprEOVt2CSjJFZq4QF22kQv8ccUX/S0WuxvPAG6PEjaM8s2pNk9K/xxjD/xKarUYmQgknz
	le/MyTdth6pfOjkSCMpVXujPe0EkSZO7zjkGgOyokW5zULe3ctTLClrDla0VmctAgcbhfbjvw9r
	6/Xk3/iO0+ElGEQaIYiEN9P3Lr9X5ashhPpqjgNHhPvgbBSJ52UtyHjTVFtLZo5LYR1ngXQ4qag
	bjr0N9NfevbGPU5+5ChNQpbVz95XJa5fSqDSnYPk0xfXBK9WSk+uEzvtpSzKKdOhp2aBEZqOFoM
	LhVA/u0AfG8i/LGXHubtIbKlniX5ahZaKGC6NLw==
X-Google-Smtp-Source: AGHT+IEg275FMxde1zTXTRnOX2l5C2eqH11zCR4cQAT539QqGLVvAFWBmzNkj2MQGivWQQr0ei8qBw==
X-Received: by 2002:a05:620a:4711:b0:7c5:47c6:b888 with SMTP id af79cd13be357-7d0a2013056mr95749785a.40.1748543896682;
        Thu, 29 May 2025 11:38:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e3fdfsm122585685a.9.2025.05.29.11.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 11:38:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uKi8t-00000000zty-2gm0;
	Thu, 29 May 2025 15:38:15 -0300
Date: Thu, 29 May 2025 15:38:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250529183815.GA236098@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
 <20250529182219.GA20289@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529182219.GA20289@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, May 29, 2025 at 11:22:19AM -0700, Shyam Saini wrote:
> > All IOVA that the platform cannot DMA from should be reported in the
> > reserved_regions file as "reserved". You must make your platform
> > achieve this.
> 
> so should it be for all the iommu groups?
> 
>                 no_dma_mem {
>                        reg = <0x0 0x8000000 0x0 0x100000>;
>                         no-map;
>                 };
>  
> i think that's how we reserve memory in general, eg: ramoops
> but this doesn't show up in:
>   /sys/kernel/iommu_groups/*/reserved_regions

I don't know anymore, I've forgotten these details about DT, you will
need to consult with DT experts..

> > But I still don't have a clear sense of what your actual problem is as
> > you are show DT that seems reasonable and saying that
> > /sys/../reserved_regions is working..
> 
> /sys/../reserved_regions is working for certain devices like dma controller
> but it doesn't work for pcie devices and its vfio-pcie driver calling
> iommu_get_resv_regions() but we don't have dts node for vfio.
> I have confirmed this about pcie on two different platforms, it seems to be
> OF DMA-API gap that you hinted above, happy to work on that :), it would be
> great if you can share any other reference discussions to that problem

Some of it was around the dma_mask and the ranges, but I'm not sure
exactly what is your issue here..

It is very important the the dma-iommu.c code also knows not to use
the non-working IOVA or your system will be buggy and eventually fail.
If that isn't happening you have a critical bug beyond the SW_MSI
issue.

The easiest way to fix it is to have reserved_regions report the right
stuff.

> When i specify this for dma controller:
> 
> 		faulty_iova: resv_faulty {
> 			iommu-addresses = <&dmaX 0x8000000 0x100000>;
> 		};
> &dmaX {
> 	memory-region = <&faulty_iova>;
> };
> 
> I see following:
> $ cat /sys/kernel/iommu_groups/y/reserved_regions 
> 0x0000000008000000 0x00000000080fffff reserved
> 0x00000000a0000000 0x00000000a00fffff msi

See, that looks better. You need to make that happen for all the
effected devices.

> Upon investigation, our hardware team confirmed that the memory region
> containing 0x08000000 is already mapped for other peripherals, making it
> unavailable for MSI usage.

See, that's just wrong HW design. The path from PCI to the SMMU should
not have any other decodes on it, isn't that SBSA?

How does your platform work at all? Isn't 0x08000000 physical memory in
your address map?

Jason
