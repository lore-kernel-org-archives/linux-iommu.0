Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB41C288
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nj085e1a"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-66d332f23e4so764136d6.0
        for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697212704; x=1697817504; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKokJXJ1Dul85caQaznSMt0gGgKBhn4yHFt4mqvG6qw=;
        b=Nj085e1al4x9g7WIcl/vI8HXDgnd+/taLB6ViOPT5xDsFJOsKbnG9uGjZjb++bSkem
         VzjcuZd4ChgorgsSyMkB2QHtxYFQaKEhIuPWg+vE5/9cXxXOKCLxqoIivGqHLgaJ9tG9
         xJR5bWPc9QtnsQ8CpscnPTWPTjVoBXEBxAwv3cJ/Ifyb9vDmGmAzzalKWeqqOBOM5fkZ
         FiXH3NtQe1krB3frxRWL49PwCEK+e3ULmvOdhCq8iPAhlv7dXENGRTZMZQzW4XR0xuFc
         k8iZJoj0daWzi/ZLbOKwg8J3WaFrm/bwbMxZShtn1U0hI1P+WASeFsgIkI0uGb8hH25Y
         PwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212704; x=1697817504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKokJXJ1Dul85caQaznSMt0gGgKBhn4yHFt4mqvG6qw=;
        b=lfbgz6dqvI9QN/nLql+JDChvIECfukfA3upQ19ijTvER2DeUjQdhxB39FzL9VuzF6x
         Nejtk0bhXihH0S0KXYJglcS4zoAP04lsgBCWORBvmDVvGlARiiA3LmfISEmYd+jnzXca
         ItKR36EViM/meA++IefXQJQuGv03hwwpauPFkfEOrNMN71KckKQ2D/GGCx8H43c15tiS
         lVExCCo/W4v5QyV+pRd+D+BFHy/jeZgGs5WGyuARna3D35RIygZjgp8pjdVeDT1fzNC7
         G4adujBXqYYyn4M7L26vXczfdpJfMDInI782gCCGWLpgv2vVLTASDe1D7yNJIXUtC1xt
         sI7A==
X-Gm-Message-State: AOJu0YzGjMMupWwqDc6dXGIatIFe27o8MBFyNmOrmFgS/Pf1hDMCLhas
	etBXl5rVP1FVC05gzFDq7JGLlA==
X-Google-Smtp-Source: AGHT+IEPW2p3LRW8sTMOqomXmy595vM0X2cc32JOE4V0pceFmIOEv74X02cmrSo2LXxFht7XOfqBLA==
X-Received: by 2002:a0c:e50c:0:b0:66d:542:57a8 with SMTP id l12-20020a0ce50c000000b0066d054257a8mr8433505qvm.5.1697212704428;
        Fri, 13 Oct 2023 08:58:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id d6-20020a0cdb06000000b0065b11053445sm758158qvk.54.2023.10.13.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:58:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qrKYQ-001VNh-TA;
	Fri, 13 Oct 2023 12:58:22 -0300
Date: Fri, 13 Oct 2023 12:58:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 04/11] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20231013155822.GA282036@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-5-vasant.hegde@amd.com>
 <ZQCWMFFgbbcBN+0n@ziepe.ca>
 <2d863928-6ffa-4bf7-d4d6-689d779ad701@amd.com>
 <20230918125328.GD13795@ziepe.ca>
 <019ab268-fee3-215e-b805-cc3f19e0f634@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019ab268-fee3-215e-b805-cc3f19e0f634@amd.com>

On Fri, Oct 13, 2023 at 09:22:20PM +0530, Vasant Hegde wrote:

> > If you reoganize things so the notifier is always registered then you
> > don't need to have the spinlock protecting it anymore. this requires
> > putting the unregister in the domain deallocation routine.
> 
> Yeah. I will put unregister in de-allocation path instead of adding another lock.

If you inspect the series I posted here (actually just get it from
github and look at it) you can see an example of how to structure all
of this to avoid all of the concerns in this thread:

https://lore.kernel.org/linux-iommu/0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com/
ttps://github.com/jgunthorpe/linux/commits/smmuv3_newapi

Feel free to take the patch introducing the new core op to your
series, it really helps alot to make this sane and clean.

Notice how little of the code that is left is actually SVA specific.
When structured properly the majority of the work is to enable PASID
support. SVA is just a small bit on top to manage the mmu_notifier.

Jason
