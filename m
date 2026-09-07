Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D79526AA9
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806730; cv=none; b=CsqycipkmyAY5BWHVy1GcTZV5i/0rIo6Rlk4IVUiW9/A4k+DZGexhp9PY4NmPRNnr6SLJAWYmbV036UYEALfXDRDWBiEkK5uraZ9UFUF5WgoIT208djYtaJQ0JOaz6aPlQ1/8+fLmiyK+gPDIAYvKpAOy2b1geofTIjacQhRYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806730; c=relaxed/simple;
	bh=MEIl3cnZEx9wSqrzI6g+3M1l8s9u76zrSgaouWKJgqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNyRjpeEMOKc4QZkT79W3s7vAfpOz64UcL1cqQkM3lyHEnOAd05lvSxRKZFCzgFSb9ge0FzBJGiDM0o/J/TwFdSg2u7l3wriI60kSQZV1WtMHueDsj1/cpS79VPqnKDJZuFL3TgNQKuOfv1f5fvB272+3VfYybY0MYLLyPE/1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XADn9EdF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XADn9EdF"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e7fd978beso69816346d6.1
        for <iommu@lists.linux.dev>; Mon, 07 Sep 2026 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1788806714; x=1789411514; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sjn+XNWiK56tmINhkcWxojIKugJpXGM2NaDQl0J3MLw=;
        b=XADn9EdFenRODh/N6yEOEyvv4poLgtYiNYHJuPxUhL1kVCrdX//oqiE/gO/BeBJh2X
         gCafRLNr/u/I0+TgMna7ENyn+QABE9aCKHJhqhIYVgF4FlST0Qi3xJOOc/NbQIriw3C+
         UWedMqZLttTskIvw4MoAceh5dcwEG+gX1kSNgUHDx6rxj3ZkhUtxuQwH4HfECvhabD90
         8ozL0I/S6ivGgLdpG9OuqXMP4JCFQ4MJuwh5tiCouKkfhLxieM+iSHAJqDnf1BO17CVx
         esm9ECcqJlSkXTckYBcNXOnul8ScsyvPkUCIPORwL5AbbU/9T1bjZM5Sk7kft2iIhJGh
         QWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788806714; x=1789411514;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjn+XNWiK56tmINhkcWxojIKugJpXGM2NaDQl0J3MLw=;
        b=sNz+hz7V2F8EV4gwcUXSDAo4JwfJcoJ6SpdyliJo0Kf29AlCsxZjQnj/0KwB0SqEwg
         Locv5VA0c0NrkLEfAkDjET6kvD77iFJBMwnI64fZ94fIgzbq0s8ahRq9BbbXkZQXYFFh
         PQkuQA/EgxGfwe/FzXjxYOfuBfx4CV1SwhZqQgpF8qJEBQU/WtAPvh3+k7uFg7+oUbc0
         7xFyerd+G7rDoTrT4ih0+lsaAA5eUFiOQ+YXUtC3sV56dkHJcW5MdfN7GZnOqh8u5M6P
         hfVKQS1pUaOaXfT2uHxR7+HwpX0iW/kLtkYVKLnWM4PqG6B//gDiSwrHkCL0t6FTQRsj
         GmbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGxjaBczEJn7nMIPy6Dot1AzLfqtg5qnEE+HHp3SNifVN0t6RboRO2ACBa+m6b4VY2F1dUNw==@lists.linux.dev
X-Gm-Message-State: AFuF++nSy881IoxFie7jUOX1UPlMOZgUGtIrZREheg8akERPPsAY1Aqc
	zxT/xKctkZTCj5KUgin7dMjV8Kt7re9cXZT4/qXCa7z7Ij0sdZo4Ji+BSDFKdSk6Nc4=
X-Gm-Gg: AYBFou2tWRA2BJ73iMWts7TaP2I4Y3e5IVU3Hynb5hTs/OMfeOFBim72SrUdNt6fLE/
	+g+iH0jjDoaouizKT9KQ1KdCmY0XtMfrcrVsYsufe6sjKGOT67n2/sbf1tyWJGYnffl9J6YB6Kw
	aaYfy+icq3T6yOPGybutrnhGFZcWO8RcuoVCmwqxTsks08VKXgqxcWP7lVnuTKsDccRDl7AzuXy
	hnulc1GdnDS/m0w+rFb+OxVeeh+mKdRCPs4D5dtHPzpIj4W2C3q80A2eKAG1uX1lAnyV0q7wJsk
	lQ4CbfIJYJ02YmbiedIQ8AL96plzLOm4sMgWTFFjtyGTJfJ+YOmBQoVNq0tO+K9sWVvYn6Mo4wj
	d1yzS/xWU5ERl5MY38L4olhAB6L/8KZjxG0CgQ3pYJ7ptyUAQPgzuJAXc1IR7V2u3dNyBdFKGm2
	tiQdTHDt39RbAli8bn57gIlAxm04mxhs2+Gzu9VCQAMIp6APlkWto4pp1RiP1gz1557maYnFE39
	Ofm1GPb2s3NTCUwzub+unm2puNgXFntAQAZV2MHGttmsJEMbRvHr3XQ
X-Received: by 2002:a05:620a:690e:b0:939:6de8:43de with SMTP id af79cd13be357-939804e9754mr2480105785a.50.1788806714194;
        Mon, 07 Sep 2026 11:45:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f151esm943101985a.6.2026.09.07.11.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 11:45:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x3eLB-0000000BMS0-0MGY;
	Mon, 07 Sep 2026 15:45:13 -0300
Date: Mon, 7 Sep 2026 15:45:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jpb@kernel.org,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, praan@google.com
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Relax ASID requirements
Message-ID: <20260907184513.GA2543240@ziepe.ca>
References: <20260907154928.4012151-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907154928.4012151-1-smostafa@google.com>

On Mon, Sep 07, 2026 at 03:49:28PM +0000, Mostafa Saleh wrote:
> arm_smmu_sva_supported() have some residual checks for ASID from the
> original commit d744f9e6c222 ("iommu/arm-smmu-v3: Check for SVA features")
> 
> As DVM was used for TLB invalidation and the ASID of the domain was shared
> with the CPU process.
> 
> However, the commit
> d38c28dbefee ("iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain")
> removed that support.
> 
> So matching the SMMU ASID space to the CPU is unnecessary and can be
> relaxed.
> 
> Remove the CPU ASID related code, and update the print for the SMMUv3.

It is OK, but maybe this could also be but under an if
ARM_SMMU_FEAT_BTM?  That is never enabled and is a placeholder to for
eventual BTM support.

Once we get the last part of the invs code the BTM support can come
back in.

Jasson
