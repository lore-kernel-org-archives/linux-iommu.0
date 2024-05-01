Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A43175B1
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582237; cv=none; b=ha1q+CAIiBugI5uFF/6wMuuvR7fCoNdaF/pwySzKeN4YTPC0uFwvpNEbMYXJ7BDxg1m3DcqJaU0s62/eMq6KDaGau8eSYs8A/2cnFroMpiDrGUxOXAo9t2G8MWMnj8vCBBllqifuMqPRP6lff8cNpQDiuSO/pX+PSZq0oiZFBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582237; c=relaxed/simple;
	bh=c7T7L26EaZ7WV7e/5lbYoLtRA5fjwDPvAyAPxWpdp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu5AMoCY0nixTqZ2Vsi3zQ7gNXL95pyhcv8AnPj3yKPJS7JvzuNdAHxVopVE5unpIbaTQENIkiBmsklUsqdmNoVHQJyE+nCod3JC1lv7oH4t7C3yhW1csQ5XS/Mu45jReMI5okiaZP2ZbROfBoVryvGf8bZBtCM3WBizjxySlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hJId3OSu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hJId3OSu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792639cf4faso115483585a.1
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714582235; x=1715187035; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbJ+amWUmdqnBEY3P5pFxkrI6iYx8TZc072WUlpjvno=;
        b=hJId3OSumOq3hLb0SDVtG33dX3PynnyWnAxMEnZTOoQdcWiCFjXUlPNuyMEYUX99uC
         wXb4eCiDD++GP5OKgO+wT5mFVplx+5zvG/WzJZJXL3tkwJZOjKmgI88NgisMkCZwBSIT
         0O51v8LQN0fzsZ7KUHk/GZ6WtYhMWpXlu3i42zrEs0aIAWChCMCss7O1T1KN25SJ/b/J
         YC8pT34S888+TziiM8QuQGB05q1mnqJ0h4F+WzS9glPf2J8dMsqzQvDsmWslON79ObEs
         0klGQelj1+3UjumJ4lJl9FivbjGSE7ga+gVNa6bFuBhhbNwLQoz1sh08pD3HwDLjLRpY
         DJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582235; x=1715187035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbJ+amWUmdqnBEY3P5pFxkrI6iYx8TZc072WUlpjvno=;
        b=sWnDfLHiSI+ddnIcV5hSj8/1q17NCGyQCvzHd3al3WpvpMPIBD87LIMDsgB1ueoWqU
         PEQyQdLjygzKn03AOeLEWLqIsV7BK48QhoEXUUvPaK8ElVdoS46i5uNh4MYH4H0dQQQM
         zbqIQzEfecXZYrlCSCnaE3ZEGSRy28rKYN/iOaoVZQgX5uDp3tSUjcV5H83mNkJp357M
         fodt/JoeVjuCrE02MLnRe2CbS7KcO8IHRQE0KI+OPd4XkpON8NqPx26uxkncEvGV5Jkf
         pReNvspR9L5C2wHtPSG1gJnF+0wDf+wjS6ZZ+2LdLKZ0u8fIBJloJuOT0MYTP/GY27Dn
         kQ0w==
X-Gm-Message-State: AOJu0YzGVVtvP+5JusTqOKn0qkBS6NjJbVKPypG1Hv+ecCJNqBG6gPNb
	qb7T9b+3/69gCmZ0CcUmeNEB+WBCrMXNs/27cS+jLWVqlOrVTH/LWeDqviptR08=
X-Google-Smtp-Source: AGHT+IGjqqJ3/loD+iZja2KV3FOqgKEvoh6dNdyC5k3af7/ZiaW9qXq24m428AYDQzhNYdPecGkpiQ==
X-Received: by 2002:a05:620a:1990:b0:790:f7da:ce61 with SMTP id bm16-20020a05620a199000b00790f7dace61mr3973487qkb.1.1714582234848;
        Wed, 01 May 2024 09:50:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id wh13-20020a05620a56cd00b007906ab7b0b5sm9966083qkn.11.2024.05.01.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:50:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2DA9-00E6Ob-Ib;
	Wed, 01 May 2024 13:50:33 -0300
Date: Wed, 1 May 2024 13:50:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	kernel-team@android.com, Eric Auger <eric.auger@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Moritz Fischer <moritzf@google.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v9 0/9] Make the SMMUv3 CD logic match the new STE design
 (part 2a/3)
Message-ID: <20240501165033.GH1723318@ziepe.ca>
References: <0-v9-5040dc602008+177d7-smmuv3_newapi_p2_jgg@nvidia.com>
 <171456087391.35017.3249073955778510141.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171456087391.35017.3249073955778510141.b4-ty@kernel.org>

On Wed, May 01, 2024 at 05:20:29PM +0100, Will Deacon wrote:
> On Tue, 30 Apr 2024 14:21:32 -0300, Jason Gunthorpe wrote:
> > This is split out from the larger part two which aimes to rework the PASID
> > related code.
> > 
> > No new functionality is introduced in theses commits, it just reorganizes
> > the CD logic to follow the same design of the new STE logic using make
> > functions and a single programming flow without leaking details to
> > callers.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/9] iommu/arm-smmu-v3: Add an ops indirection to the STE code
> 	https://git.kernel.org/will/c/de31c3555412
> [2/9] iommu/arm-smmu-v3: Make CD programming use arm_smmu_write_entry()
> 	https://git.kernel.org/will/c/78a5fbe8395b
> [3/9] iommu/arm-smmu-v3: Move the CD generation for S1 domains into a function
> 	https://git.kernel.org/will/c/e9d1e4ff74b9
> [4/9] iommu/arm-smmu-v3: Consolidate clearing a CD table entry
> 	https://git.kernel.org/will/c/af8f0b83ea2b
> [5/9] iommu/arm-smmu-v3: Make arm_smmu_alloc_cd_ptr()
> 	https://git.kernel.org/will/c/b2f4c0fcf094
> [6/9] iommu/arm-smmu-v3: Allocate the CD table entry in advance
> 	https://git.kernel.org/will/c/13abe4faac43
> [7/9] iommu/arm-smmu-v3: Move the CD generation for SVA into a function
> 	https://git.kernel.org/will/c/7b87c93c8b86
> [8/9] iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()
> 	https://git.kernel.org/will/c/04905c17f648
> [9/9] iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry
> 	https://git.kernel.org/will/c/56e1a4cc2588

Thanks Will, I will repost the rebased 2b part once Joerg picks this
up.

Jason
