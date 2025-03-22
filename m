Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819862E337B
	for <iommu@lists.linux.dev>; Sat, 22 Mar 2025 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742601625; cv=none; b=dWvB2Ci2g5kc8jRNcgb3iPeyFLJZ2efx2lP1QTPDC83vEM9mdS00CEHNpOlW5G4PgEbO+9Ci6CaF7vqhwQK+a8PQh/pteTx59o3R3LKw8Fb7Sn4iUhQ6JOvADA8KyehflZSZKD03ibREURzed7mCQWRsETU3SZdX5VEBWIWUB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742601625; c=relaxed/simple;
	bh=7BdWOGzsd9511imFAgF/igxE5xGiLd7Ab/gdeb15nBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0wjZ2zEx0c7QFL99MYDwj2P+hF/kV9aAK8g1XpXjKBpVHJ5bxPkogCSPc7ikG8vPkpqzn2UdTFx/4TCamh1QsNIfmowX1CEgE/dl8wudO75Q+zZI3Hq3Mp+OejtB2V+cHJ34rLvbKE99FG+yl3upwzVOT7DOGPqmS6zLCZEQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hMQxo/V5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hMQxo/V5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c547932d2eso149204585a.0
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742601622; x=1743206422; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPAcLp+5RvD/LPrukD/GFBOeRqvkbg8HRMNL6i/BOc4=;
        b=hMQxo/V5YAW1dnWBXd0JdK3hxm/3A2MqMeRC13kUlwXmcFm1l1dp5c4RrZ50NRAALi
         6xpk0jjX7nC7JWFVo7xM0dJdDQtaPJS5xZpoYwgkSCzWFuUO2tJfus0/YQIDk454xRRp
         mfi0N1i29bu+G7Ohn7ye16Rad/JJ5iXUkfbSq2XdqM+lNgDbvLrEDFYPxxabA+GSUlt8
         UelqsOK9XfzUvVzUm0tcCbkkixvtbcigpPUZQeEDf78CsKaAImapa1fE65YFtcuvfNfd
         vti5MIvU5vPqr4G9VQ/v7o1hUau5ojl41ymIrGG1R51+W9qzmff4hcuEvDtcsLdg3adt
         R0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742601622; x=1743206422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPAcLp+5RvD/LPrukD/GFBOeRqvkbg8HRMNL6i/BOc4=;
        b=n+aKnihaiDi0Dv90v4LlZYnLIUjR05mzmBCuAvV3g6QNL7CWBIaPFUQEfZywwdGOzX
         BJ096FH7pGMhcs5Pxgu3u9tWJEVuuuq04y7kFhV8pbEycsnuW5rtTkT6/+jst7cUdG6x
         FnQ4zlH5E4HPiR3R60SwAJXpYhxqfs5SCrwmzRF+/jj1fy4/nE8tbRt4Zmn/i8gJr4Eb
         AalSjt7SDjSgodujqQbwhAmWvjm2R0+n+ARm2Id/K+vxDLaoEyEeBYqw77PU0MUnKN8b
         lU2KRmHzOpeY8RUke2WLphF4RpDUdWoZHToCqkEDdjvejKBsjEpCACTCubhqZJR6fLt0
         EwLA==
X-Forwarded-Encrypted: i=1; AJvYcCVmgVs6WYPBd2KYR0iba5UdxKIgyAT3fhKrW+kHc2FEk1esXxmEEZ4SQeAOmUJ9PDXf8hZIpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCezx26/XDxZj01NjeOgdFiQg2cKWLANuhI0s2gakmJ4fUXr0Y
	UE9K1KspvmiRdTfwYbd9TOuak7uNgYcztxenQpZHHSWG+IioaY7VkQ+5Xjbj6rU=
X-Gm-Gg: ASbGncsmneexRYSM4PF7KPLkm7jv+yR7RdmGx2WQFgYLOoHMsgxGdfaxZDsC09aLQfd
	NMTukx+fUHYOAVz3XsyVoq4JCqgoMo5EIihQ6CFh6C2zpq5h1zkTAe8j3mxQVHAmG4clsHKutKm
	XibHkC7taRPF4M8daDmPx4fBLxvaJDLxTEdkE5sVDzjo943weGvgqnzllcG2SybF7rMJmGl4u6Q
	btWPz0J6u0v4Nvz1Pscg/YZ8nFyCFA9Ti4+ZRGCSqHBc8qkaNCg0qJjjP/PDx2+l2z2It/7Sgpo
	ZMYGagR2q/LMkjsEBPNTlF3XePv8nyUEZlg9zCdR6IbHwx9mtr4w0QyJuhi3wGVp1Kq/rKkfUSc
	pc1yqZHHxPYARqJjA/gDLnxU=
X-Google-Smtp-Source: AGHT+IGpRsm+hnrWMna/8NxaKfhvv8YF81jNqI3YMASg+UfBf/jmlZPMW7ewmlR3vCqQQADY0hrSgA==
X-Received: by 2002:a05:620a:179f:b0:7c5:9b2b:83c0 with SMTP id af79cd13be357-7c5ba13403bmr706666385a.7.1742601622094;
        Fri, 21 Mar 2025 17:00:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d6883sm190327485a.45.2025.03.21.17.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:00:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvmHk-000000019L9-3gBg;
	Fri, 21 Mar 2025 21:00:20 -0300
Date: Fri, 21 Mar 2025 21:00:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250322000020.GR126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yCCe1mRTr-4dTx@google.com>
 <20250320230813.GM126678@ziepe.ca>
 <Z915ebfGstqI0NIQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z915ebfGstqI0NIQ@google.com>

On Fri, Mar 21, 2025 at 02:36:41PM +0000, Pranjal Shrivastava wrote:
> > > What about IOMMUFD stuff like the Get HW info IOCTL?
> > 
> > Isn't that all from SW caches?
> >  
> 
> Not really? I see arm_smmu_hw_info reads all the IDR registers..
> The call flow I could trace is like:
> 
> iommufd_get_hw_info()
>  -> iommu_ops->hw_info()
>    -> arm_smmu_hw_info()
> 
> Am I missing something here?

Oh, I see what you mean, even the IDR won't be readable. Yeah, that
should either be copied to memory during probe or we need to wake it
up to read the IDRs..

Jason
