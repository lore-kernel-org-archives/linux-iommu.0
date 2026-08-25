Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD31346FC3
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681182; cv=none; b=kBm+TTCha7RBILqks6qMc13Kb588SmEZuvbYUpYyWdmIkvFaHzLRbxzYIlm3bDglr914V5iSsGaSF3sxl1C6TmOxO2SnEHFTQQNLsA3pTQS+4eu31Y0LLXEMespDyhHCH/GqAvB3xsHnE/XcFv7MPNaiKo4Fr7j1fSwqMaYTgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681182; c=relaxed/simple;
	bh=wRXxjZ3DhFLp690GXFW6USKlVolGgMlTl6tiGOqLZo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2Geaxi5lcGmAKdbWzmwcYsVJlyivVsnRU5SUqzx6i03+rQkKls/KmouBgAmXl4NAxJT+gX3kzSU+H1X0GjxZcINaBCvaSjmZ3m1s+Nbo0Vjhkm+8zCRX7iibV5N/h+yHFljoYRpX7VHpePpW3A0yw2YSBSZ6Birry2N7rqIvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvvzMK2n; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvvzMK2n"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso14575ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787681181; x=1788285981; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vCJ1xkQLO3MSgQZs7mGkGgaw4XAmZCjoHaPeMHZ/TTo=;
        b=YvvzMK2nj1etwPotVLkfItxRcEB/DNYomYl0v4wjcD962Ypaun8ZZ47fAV6160Mia9
         ub9uWMeDGN74Vh/y4RbuVq6DP8UdoIuV7iChsvnJX3DSAHKtoOe1ySWxF6SH0bFhIb9T
         qu2ND82o2Zx/Nqwjea/GpULS7mq89+zJItUpCEl+va6YzJM0ucDoGaEv0UuRu0PJ+BBX
         vnj208aAqzPPtEAXXdYrKCAvId5rxIVshbbZWCUCBPhjSTssVXGnVfd9ZNtuN3czt3HW
         g35IPgvK28O+PNSORnzAvfhv1G1Rnl9fRSIk5f0vqbAIJCWczizcoyIN5SQrhNRBHhjo
         o2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681181; x=1788285981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCJ1xkQLO3MSgQZs7mGkGgaw4XAmZCjoHaPeMHZ/TTo=;
        b=PWKa7Z9TqAHVS4byV9o8dbF7UEfLhp3DEZgihGO1rM6JjtZ0qNXDrksDrImuT7gpzm
         NO8QM7OZfvbE1uR2bTUVyBuUXtxW2dQlttsdWnjpTrnWwJUb2cPWbPpwk+a829IfVSL6
         1ZxhoEWL3e9T2jja1deYAdbklQjRTnnbdMTw3T4ZfE3iwyyyZDS8OzQfFRz9t/g/g5om
         AABfJpCC/5cTdqsiTwANVdX/UMyd/AvEN/TAPKG2Up3WCMvXS8GLo6z/9Et7Csj9LXN1
         m7w4sihNNc4kScxofLEbeVtixYiRn2KhepZ8dO27iW634FvkhYVnhqGyNUmFyoIXLzLb
         m1+w==
X-Gm-Message-State: AFuF++kDsuMpCh/0Vw7MHV/Kdej5Yz+URl7bG0GBWvl2ATK0bYl/0pq2
	Hhw5x6AXZlAu+MWe3rGYAA1U6OYEzzUBGh+IU1wFLCkdpeHkB45ufXyCwsfyjStjjw==
X-Gm-Gg: AR+sD121zg3mcCv/1kZJc4rfi771GMlz1OsfFun8OERTVUkWbHNL14X/KA2pV4s0nqY
	lGUxAQHy7l5Qcn+sdrGP5IYwvC56BX1TTF/zTUxGoqQmB74Vuiq2ryeBsZkxi6221l6hfyqqdIZ
	MTSLm+K4Jg/XtK4rFtmWCnjFaZrKaKLp8abUH4EIlDDy8KYGDXXoOTG+fNg05YLN5IC2p+PYEfS
	p+OP05wSrmRASlcaHpo9AxcgjZ9mi1NMDDe34FSt+VlxMYMNw85FgkkdUyolNSxwMn3HeCaNMus
	RsrajilrtKUObUyJ7E3e7+1q1QMOI4e2gpMvdnNyB2kCNO/SAK9HcGBOJUbEWBUHjS6YK9y2RFa
	EfVBG7oxU3gJhKZYVw7K7BI9VXNpDNayqDHlG3K2yC1Ywm0NbYvrcW2Z3RjnKobEeeTnQAFn/XD
	ruiliGextdWOQ2MgX9Y9B6X20hjlQzxSyhShhSmq0nTwNGME7PRZGeBB4HXq83902SyiOgQYNDx
	EB5wsNC0hfggOxhRvQktw==
X-Received: by 2002:a17:902:f645:b0:2d5:db38:8012 with SMTP id d9443c01a7336-2d707c0662amr23845ad.17.1787681180219;
        Tue, 25 Aug 2026 11:06:20 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b3a49bsm4631775a91.6.2026.08.25.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:06:19 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:06:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 06/12] iommu/arm-smmu-v3: Handle gerror during suspend
Message-ID: <ao3ZlVVwzDkWkuvn@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-7-praan@google.com>
 <178767577113.3356902.10872241669143339312.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178767577113.3356902.10872241669143339312.b4-review@b4>

On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > The GERROR register's state might be lost when the SMMU is powered down
> > during runtime suspend. Handle any pending errors before suspending.
> > 
> > Refactor the gerror handling logic into a helper function and invoke it
> > from the runtime suspend callback after disabling the SMMU. This ensures
> > that any late-breaking gerrors are logged and ack'ed before the hardware
> > state is lost.
> 
> The commit message isn't clear, this is just a refactoring patch it
> does not "Handle gerror during suspend"
> 
> But the refactoring is fine
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Though sashiko seems right about the pre-existing bug.
> 

Yes, we recently fixed the pre-existing bug with this:
https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?id=eced8058c82a

Thanks
Praan
