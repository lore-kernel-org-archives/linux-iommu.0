Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22594DAF84
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162727; cv=none; b=DHFKvtiFyGHPDvh3xZ2xyVTGLFY+DAoWRCpgfUNxeIyjPcgvW1yJQwR06wGbAwycumdcxt6Kx+2XcNPQd2IYvPnmADkkMqxQ6bEWpMAh28R/qLP+XJAz2TkuAC2NVnWrmmKWVa0ZgBlkekZh1w0Qmy2eJQGFlLFACeYBGVc20Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162727; c=relaxed/simple;
	bh=Gs6UDVs85lAeYcbz5natlQddcSkvTtyPzng7JiqW+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Visj1Y2/80GuxC4ASuTLFkC0onXVwJ31hdA+Rc16xYGbjM+PNSZmmRg4MlXB3+6tSGkBzmwcxGNSPHcZaaglpiR+tss+am1NnUkcYMP5XQyAIRI8tKC/q3DmMUuffRhp/rjT9ZBRxbVqgX+ok6a5+XXnjQLNvb6/KbaXSEYoOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PNEmVOB9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PNEmVOB9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e515769d3so2974185a.3
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792162725; x=1792767525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4TOl9JQUahFIQiKudG6oBPl46TqBGSAJ68OWGmu91g=;
        b=PNEmVOB9Rg6QcEvX6/gWhD6UCBPSE32cake3aVtH1b8DaeVTJx18/sEL2ZpNTDcQ1E
         tjG6gh9rWPGqpcfiUy9XX8TEp3NNAH9d11k4gP+2z7ADpKirEb3UPEF8f5tRIF8l0Pv2
         bNd038QKkbiMcnJVm4fMDs2whaTSR6C0K7Foqll40q42bC5dQBWosRsnfmaE4DrWMsVd
         pAOTCEZUfzJ8h2so04HvAV8S2gTnpSLeg32iBK+U6VqVZGMwBQ9HDunxA2ZnVBw175NN
         8SaXkf6fma69TDmuDLXCC10yqEdQGvf7Is1Y4IoTFi1G2gvp9BaEbNXbmsi3J3X4LJmN
         j43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162725; x=1792767525;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q4TOl9JQUahFIQiKudG6oBPl46TqBGSAJ68OWGmu91g=;
        b=2UGuIbe2Rj7mCbRebsazMRfrPEl2pxVzOn6JdVK4O28XUDeNRxZAThry/YVVx/CzPs
         L7PjvlltrPn2lNuhqBjnxr4ZYGXXELCnaTvHfZYl/GhzcS9/l8ENNCM1y4GXvmrqJ+N0
         P6XNitOXL4SgX3cqCxG5OQ/+XmxXq+am3PeREbf57Z3a+9f6dDgmbbW7EwTccQeWs4Cn
         sqdQQ2Jn8+tPaGI2kN/vbG58VQk1CKK2Niu6Hs3+b4XUXmlHpPOAunuoBjqnEpE9KiAz
         45comoLWYck7VBjiHZVbn0i70N26rv930DYoCTRFzK8GDPKjg+oOEavwiR7ZppWDJn1Z
         6NeA==
X-Forwarded-Encrypted: i=1; AKwUvByK/r7UIGzb0GgB+MvnyOFpmM283yCPxmQ7CbxPD4ueK6bfJiQGrXvRLUZK1yrw7hLYjHrdzg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLHmhXwJlTvhQJJha//0yv2nIWnx4roOPKO1ILDH7qQmLXIoddi
	OC9mu+Tkd/jbDiZh6r+oBaPhkwpQsNRBMTeGeMOI8bb1wK0WOkDNuyyzpsDqw4Ao9ms=
X-Gm-Gg: AYBFou2Ngni3vdi86+RpQu+S5fkmY1tYWciup3Q/Yj0sYdfdXsXPxXXQwJEGaVhNibG
	nXFUhTFzAafhW/fbZCgV2NtI8LrzX94c5gg94jEYs5wvcBreDNLS32hbcPP8MlEdvk3rzUgUXOa
	+f5PwOBw+13WCLaNXGErOLf+azvaR+gM6Xco570onTQwAU4FhDd/k+PIZkJugrRw9ftjzodAXs4
	OcYN4CehGkbqXJgdqh7eslTSeUqUWKooSWe0D1p4ttIKECJsrkI05NNTKzooB5aYBvf5RY+LtcJ
	BkOOrsS2fa8eypBo0Y91h7Ki3WpMGYUyJNWZSmrF16S/1KwjuHXnynklNW2K6GpgYiHKCupk1GX
	cVL54qecoOvln8lvsXalJUZ4ONZFKRiXLPBPy+1S60XTbA2lnD7jBdveI3P2eam+Nk5FaQX30dv
	gEoAjsZrhxhF/GlgyXgpQdcZvNmavoB2JdrtkhevtA9Pe8sFO96z9QKmetYpuw01s7xIjupF1/V
	8/Z2F5qXq8p3MFNtVyZ+7KNgCZnIzns9adarxvCCOkc0I5z/ewifp8I
X-Received: by 2002:a05:620a:7113:b0:93e:96cb:3083 with SMTP id af79cd13be357-93f29d38660mr12133885a.33.1792162725326;
        Fri, 16 Oct 2026 07:58:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a197bd2sm231474285a.29.2026.10.16.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:58:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHjON-00000001tP5-3WxW;
	Fri, 16 Oct 2026 11:58:43 -0300
Date: Fri, 16 Oct 2026 11:58:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, iommu@lists.linux.dev,
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <20261016145843.GF14213@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
 <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>

On Fri, Oct 16, 2026 at 03:03:23PM +0800, Baolu Lu wrote:
> On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
> > 
> > > An alternative could be, bringing up one IOMMU when an associated
> > > device requests link encryption. Then a no-tdx-support iommu fails the
> > > encryption request naturally.
> > That is what ARM is planning to do. I think it is reasonable to
> > trigger creation of the secure iommu when the TSM is connected to TDX.
> > 
> > Fail connect if the iommu could not be created.
> 
> Yes, agreed. The Intel iommu driver could use per-device interfaces,
> just as ARM is planning. There are some differences, though.
> 
> ARM's interaction with the iommu driver in viommu_init() appears to
> consist of two steps:
> 
>  - arm_smmu_get_realm_params(dev, &params): get and validate the
>    physical iommu information from the arm-smmu-v3 driver;
>  - cca_psmmu_get(&params): activate the physical smmu for Realm use.

Okay, I haven't looked, not sure what is in cca_psmmu_get() yet

> So the Intel iommu driver will probably end up with interfaces like:
>
>  - dmar_tdxcs_iommu_init(struct device *dev, ...);
>  - dmar_tdxcs_iommu_release(struct device *dev, ...);
> 
> These would be called from the connect and disconnect callbacks of
> the TDX link ops:

It seems OK

It sounds like you will have a one time init of the secure iommu at
the time the first PCI device wants to use the TSM? It seems like no
problem.

Jason
