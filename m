Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808021148F
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546383; cv=none; b=ch3FC7FpGv1DFDdB3q2zvGYMcwzzv8Uc9wjjU6ccRnkqh9/oRBSB14iKhn8H2tIWl1Ubtze1S+usjTXXO3ErTX9H9t2q2La9Spy4e7QA6Vza3+hZoLMLtTQnO55RtKlY9pkHh0IqeZ2G8JSBBRRL94ER3ScN0ZivgnRKnVCzpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546383; c=relaxed/simple;
	bh=qyEKQ9E1yROQG1tbcPMuIfSm6sdPYtdc/z20peUWf/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i39SvVQDSRVvf0P6PRKszhgL2CzW6Ewd4DBV6AmroYqnUsY2tf0uHEViYnCGVgkzky7dBMgKXf0JQTYD1R47j3qDiulvlVij/+7dmXhRlBc5GloDKxxCNeCMxjJ+wY/h8D8GyGCkYH4UG2LmvsiluO+CPJiRai3DgDQSRZ5GDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAIcvszv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAIcvszv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43621d2dd4cso51235e9.0
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737546380; x=1738151180; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M66snbmYrKqt/mbHszvaMECVHNs6H3jl0JCiF0yhrSs=;
        b=EAIcvszvodimdjn+BKasDcq/Wy7T0RqBHG1l7XMTrTpwiia72wNouvk3undj6Ivkhg
         Ai93zrldq4MRs3V0nQfTHdZglw5AJDVl+qzwjyTOrPQxKFqoT7/L8+oBrQgw0fy6DfKT
         G/yXY3Nxo2xYT/TCs9G8PJ9V5HodYbRLs+YK0C1Zd/qIXxZ7UtFcEqn0P/cG0TClCPIg
         XYQgfgT0EsEgulSUbY3iW8v38oxbyHyhdIOLvz6lWAuD62HGFGzFYECFVjVDtr66GQ98
         5BzfvISafIDdHPBTbx52cDAYJT8Blm7x796piAKuLXGCMfa+qQCKDDW5UNcTIm2lbjSR
         Tuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546380; x=1738151180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M66snbmYrKqt/mbHszvaMECVHNs6H3jl0JCiF0yhrSs=;
        b=cs19jHw651PXpGwD5DyFcRFJ6JR5T0nJGAtEPEGuQCptwaorsIEhiERKR96jRARhP8
         V6htG1X9q035ools8UN8tukB+Yz85o0wUPv/nJUNsN5tx19tvbWc1wHHzUN8X8c1kjOf
         yrMNVqX1Ok8GebPNw4UAlV5uzMcRAecMMVxGjbOrnlEM4BCJpk7FtVAFGbKPbI3OJ3qG
         4unkRKCQSzdu2pOS0pjlAwpazRF791QO0vOzN/YJGFBx4X4OVdnpT6wUCD+e2Pq8o+Q8
         e8+NojJsZpeygmyOKV+r0cPRrXI465B89uw+l/OLB1YQ0FM2HVu2TIdAPzfij7hH9LmR
         GRnw==
X-Gm-Message-State: AOJu0Yx+6hLShhsgFShl5zLc5B6zbFOlf1O57EQPFkVrPrL4f3tr5kFW
	OBgjASchoXi/kIvUVXb6qQMElfRyKZ+oxoZrBvCEP8DgpcDqnzt5ilFcHUM8wg==
X-Gm-Gg: ASbGnctbf+jyGpehc4No5dXufIczMfyue+FrssLIKbjAf3lmf4wJlF8icQSEN+gmAbz
	yA4RY5Z+rf4XV06IFmE5KUAZSRfDFPGIMLLBkKhmYliuXHf2jObq0YInJCt/VlKAC2ZfhqTpCQ7
	VQjy6Q5WJ0+64fgCZbW+/VDKUcEwdmrQNJguUxtrvGmCfgzoCFcmlEyWeEwelUT11SdAejZyR2f
	RN1LR3qfZdFIUSsUdkT00AMRAVs9dpGLNk+cKAOVhixkpaPdJq6cGE1LpoHCuLbgcDJB1cgJWIY
	hzkFP1t8iWYpEKbpbbdpdjlPLbD9Ww==
X-Google-Smtp-Source: AGHT+IFls5TpL47C7K0O0oaibl6d2ILOLB2S6EMRWR6zhH8HrTL9uwlX0dZcT7Ee9IXAWCDbxNzW+g==
X-Received: by 2002:a05:600c:1f91:b0:434:9d0b:bd7c with SMTP id 5b1f17b1804b1-438b2da67dcmr845945e9.3.1737546379863;
        Wed, 22 Jan 2025 03:46:19 -0800 (PST)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31c6fbasm21159875e9.33.2025.01.22.03.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:46:19 -0800 (PST)
Date: Wed, 22 Jan 2025 11:46:14 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, nicolinc@nvidia.com,
	vdonnefort@google.com, qperret@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 00/58] KVM: Arm SMMUv3 driver for pKVM
Message-ID: <Z5DahnNdoShXesib@google.com>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212194119.GA4679@ziepe.ca>
 <Z1yNWI9lBNIZg6Le@google.com>
 <20250102201614.GA26854@ziepe.ca>
 <Z35rEeSVwfZVA9IF@google.com>
 <20250116191952.GD674319@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116191952.GD674319@ziepe.ca>

On Thu, Jan 16, 2025 at 03:19:52PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 08, 2025 at 12:09:53PM +0000, Mostafa Saleh wrote:
> 
> > I am open to gradually upstream this as you mentioned where as a first
> > step pKVM would establish DMA isolation without translation for host,
> > that should be enough to have functional pKVM and run protected workloads.
> 
> Personally I hate these giant patch series, you should strip it down
> to small meaningful steps and try to stay below 20 per series.
> 
> I think getting pkvm to own the SMMU HW is a great first step that
> everything else can build on

I plan to do that for v3, I think that also removes the out-of-tree
dependencies, so the code applies directly on upstream.
Thanks for the feedback!

> 
> > But although that might be usable on some systems, I don’t think that’s
> > practical in the long term as it limits the amount of HW that can run pKVM.
> 
> I suspect you will end up doing everything. Old HW needs paravirt, new
> HW will want nesting and its performance. Users other than mobile will
> come. If we were to use pKVM on server workloads we need nesting for
> performance.

Yes, I guess that would be the case, as I mentioned in another reply
it would be interesting to get the order of magnitude both, which I am
looking into, I hope it'd help with which direction we should
prioritize upstream.

Thanks,
Mostafa

> 
> Jason
