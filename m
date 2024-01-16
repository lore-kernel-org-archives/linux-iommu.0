Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF521CA92
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425736; cv=none; b=rNgtk9cAk012gvygXY1YG+xKmHHig0SXskPXHQ5exBAhrtdbwa+dL/Dex5Yp8CWlKZ0A6niNQMQJKTqoj7gj2PfrY3DBx3FCIZA6PvOt0Ba7F5+coTXguVscw3a/kHmOwN5X3dlewI3oR4zbUFZokvuCQJsDiIx5No8HA1mgWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425736; c=relaxed/simple;
	bh=aYK0pXUCQDuWqK9h1FN+gk+wNlGZ4DmYNR3Rcj4LiQM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=g6yQBbHlb3nEOVtO2EDzZXoxKOWP6btTJfiIkc/vFaBGwNaMd+TakOh+5XsolI52QlyHorH/Sc5ASSnqnsn3VEnqj7GdkjMut3hRGCOC89f7I+rUTIB5444/z7UNtx1ArZAjRkFnRmfFcAoVcahorKxbMlcn0gywoD2KHqwwPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AnAVyu03; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AnAVyu03"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-429be9fe952so38207711cf.0
        for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705425733; x=1706030533; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/brWcTdNs+6S2k/yrCHCfUU2lKmPGBcNCKNqgF66R0=;
        b=AnAVyu03g8T2Ebw2gntEOq+sy3lpz67jFSrsbsqoljt92lY4mXyDhtRt+EQaQgT6lr
         1rE2PtDQbM/VYe/7YY1G14HPgrj/mif1MerlxrThUyW62MPwkYBEX9nhLabCpri+sduN
         uOhCYIp0ls2HhzfI7R2ivnqB9dS+O2J/y3WN6mTEC7DsW9A+XYtrqaYOCaKTHuGupv/Z
         v7An6fIVWNLgo67LZJcWoKF4vQYE7OnKTzQpOLQoIJlo7Ty61G+L70/K4+DdvyFYz6l6
         pVFUkfG/bXSBhs++mIyjzMw2akI6sAI8Tv09rLGa8vDktmHk7EJb4eCEaXZ5Ec2hP6KE
         4ZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705425733; x=1706030533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/brWcTdNs+6S2k/yrCHCfUU2lKmPGBcNCKNqgF66R0=;
        b=JnUtQZpCXaLqHKbRD/h7uVVFOnH7TLtS4i+XRS8/U5jUNAgs9tx10OXfZ0chxDxOz1
         9C+igpVRyOjpvse4keE3EXS0Z/5Ahvr7TDPVfIHajz4tLDY30YC3s33mx2QzFoS8xaRT
         Ebq1CB8rIfOIQFe2ERJuVGFPc8V8JKVzrVbKnLIJ4VewyqdclbHlCNYMl7T2yG/aybx3
         6rcP8JrWRchiUIqU+K+Gz3AjAyo6ZfZLOzpCL8hf2Sgqsx3vOZ7+9RGUu9IimQ+U3Ttr
         66q5cdvwXMDFIjJCFdI97PVEbfhFKHUrSpO4eJ/esYp7ULkl9CExGg/Df8sTR1k5pCwc
         baww==
X-Gm-Message-State: AOJu0YxcmzSJn/PFjH5rZr5NNwLroUHsU5n/wmF0upOiNZ3m7SWPJ7W3
	RuZMV+U0qMcCEs/kLtMPuQ9jGYC1PnZ3BA==
X-Google-Smtp-Source: AGHT+IEqX6FBlJcqIURQNWdMB4Pjrd+85tT1vjPWzBCDLpIX3WTAFh+m0WiWcCtR2bz4jTiceZxLKg==
X-Received: by 2002:ac8:5b8a:0:b0:42a:c2b:adc6 with SMTP id a10-20020ac85b8a000000b0042a0c2badc6mr324639qta.40.1705425733751;
        Tue, 16 Jan 2024 09:22:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a03cd00b0078326257ab7sm3872984qkm.37.2024.01.16.09.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 09:22:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPn8e-0046hz-P7;
	Tue, 16 Jan 2024 13:22:12 -0400
Date: Tue, 16 Jan 2024 13:22:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20240116172212.GG50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
 <20240111135952.GV50608@ziepe.ca>
 <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>
 <20240112145934.GY50608@ziepe.ca>
 <5d0f4146-fb57-d700-1263-881e2ec3ded7@amd.com>
 <20240116140049.GD50608@ziepe.ca>
 <2fa63c4c-28bb-246d-300b-852db447a3c7@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa63c4c-28bb-246d-300b-852db447a3c7@amd.com>

On Tue, Jan 16, 2024 at 10:38:16PM +0530, Vasant Hegde wrote:
> Joson,
> 
> 
> On 1/16/2024 7:30 PM, Jason Gunthorpe wrote:
> > On Tue, Jan 16, 2024 at 04:22:16PM +0530, Vasant Hegde wrote:
> > 
> >>> The *device* has a list of PASID's that point to iommu_domains. This
> >>> is stored in an xarray inside the iommu_group.
> >>>
> >>> The *iommu_domain* has a list of *devices & PASIDs* that can use this
> >>> domain for translation (ie that it was attached to)
> >>
> >> IIUC domain will be having device/PASID combination something like below:
> >>
> >> UNMANAGED_DOMAIN_A with IO Page table :
> >>   - DevA + PASID zero (say non PASID capable device)
> >>   - devB + PASID <M>
> >>   - devC + PASID <N>
> >>
> >> We will *not* have same device with different PASID in same domain like
> >>   - DevB + PASID M
> >>   - DevB + PASID N
> >>
> >> Is that correct?
> > 
> > No, all combinations are allowed in the API.
> 
> What is the use case for same device with two or more different PASID to point
> to same page table?

Possibly something with SIOV like techniques where you have two
virtual functions, each being DMA isolated with PASID, installed into
the same VM. The guest physical map would be the same iommu_domain but
the PASID would be different.

Regardless, the API doesn't require this and I don't want to see
drivers inventing their own restrictions without a reason..

Jason
