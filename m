Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A610363C74
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162023; cv=none; b=ijUaqmhsxm+fLVB3SBMpLQU5cj7suVv3Leea8i5QcNtqcRZ4YhpfOPQW1wI74QNYZ/nWpiAM9PB+vlDUKIJOWdICsor+GBkf/tfq08wZsWZZqKKJVeEs+Wrqm0/Y40M3XW+ftoBWxVoZwSIAsf9wfNRTCywU4hpi+SE7HWOI5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162023; c=relaxed/simple;
	bh=fbHAXtMgNBpKPLxNGOFiSceLUQjlHsjSTYzbd3h/6Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6TiVilBzinM4wHfNNj182hM9DOpacjNdm1xHdZfdRCBsJP+su0mtDi6JQq9JgehuEAOc4lt/5c5KmrqUU1JkjfDsxXPLmA8ZaE/PCRQZsrVWjohtw12XaxtxCfxPgg+VpmjGstGZ3Irt9cq0sAfXukYelq8bOjVhbEj513gniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5UcZKuI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5UcZKuI"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a1462573caso102125ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 01:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769162015; x=1769766815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePKEQ0GejUBw1iTzV1iSOFdxHwY73KC0ci9l7qDVv0U=;
        b=J5UcZKuIHih6vCNFGje6Rt9vIct+yF4npfQO6ikIeXmvQG6ouZD4Kb3RSFFV0k6HFu
         NALxxWt6bmdH432WiF1aBY+9y+pwKgRN3pkahHKzECg7fmxvenjXryC75WeHDMp4B1kN
         xeQfOuS2JJBWSp/NQ9w/Go4w17aZ5//y4XH2iWhogqXXPcniwBMOOktSgaoNy65PR1jq
         tdUThUobygU+GAh6YRlvIwRGX6lALxt6YQcNxeNJdwz6gME44jpops9rLtQEevBUEhnJ
         vXWLcitUv/UsydHQ9HTTJC/0qDLdnJhZUrvS20ToPSNL9qJa6FakU22VmmdUtBynULPM
         K+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769162015; x=1769766815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePKEQ0GejUBw1iTzV1iSOFdxHwY73KC0ci9l7qDVv0U=;
        b=aqtRtvl13TUwSB4VimqkvIRH1zeBdBn+wGhi8+DrBbTvp+w5oToxKWA8ZMstaic849
         rVa03Cmas4Je3kYBS4RcWSQO2szKzmh/kZTr6uLX5yGpvjuk3Ps2Aq65PmNLErvxQWbP
         CWBzGrM532wB/OPkod5qX9w3YmA0EBtVbGpDrKV8HYjWN7ZkF04NreWHMOkXimsi32VV
         FuQb2IthMjKBaJveDbTzX2VRYhNdv1cH2WVpFuUDoWkWoagTPgFusuJ54eRCGzOpXzEj
         vqccDKQEgFC9DyPrDJ/jOBfGILozbEtReMhyJIthnC2c2aFFr1ZLearwAZrVWl0q07GV
         mstg==
X-Forwarded-Encrypted: i=1; AJvYcCVkCHaj9O/q3SDg0F1Y7VdWNhSop5gzEwcRL+POFlXgMfvpe6ihJmz9Eo3v+raD069QImWlMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxY9e47y2UyqGsHhgzOY5oBHZP6eNI6QYLYFcj2mn9oZ2Ew1Kf
	t33bTLsHcdzzPvZ0pKcMi1NrcddN2fI0kS5E4eZOwMXWJp2udrv6jLzIeI9g2dh45w==
X-Gm-Gg: AZuq6aIEbo6PpnfcLjPvZ3WlpL1yiEa5VouVVkXBHvKbFkYWU0bLsJdpAKOP+grwpv3
	7lVhjRU3rr8qhpb6LJHeD3HRMpV8ddDXzdPVxKouoQHsYVDVeZFfpMx4BHbG9amBozLiE8UdMeS
	+2Il6+TBsg6nvKpyvZ0dZ1EDt5TsSIqieQc+3mvR3K10ZGt5XDub1i1zvpCOe4ladsAiHSdZEgD
	snf9lqnV0jvlj0l711clsw2L49WvS0Tsa+YBNdDjWuDOQ5TMnaT3jkYWMCQWILz9lY3rG3tnhEg
	YY8lbeFWROpHB5TfMQeQkEZtcG0CEQRz3Lfi9BgmWBdnbwpOHomNoB8DzSgWMos9H8TSOfY8PDk
	OjwqwfdO4/3zXBrg1CE2GYBQ9N4wkuqMu/ku9r42mnzaDUQPzA8wM4x+ej4JpZJMUGcmizoyNV8
	gSqAwY8TVrw+/KWROqKFrvNLJZaR/urz4opRw6XtomBhUK7msJ
X-Received: by 2002:a17:903:40cc:b0:2a3:cd98:f07 with SMTP id d9443c01a7336-2a805c91485mr1873745ad.3.1769162014172;
        Fri, 23 Jan 2026 01:53:34 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f97a81sm15301165ad.47.2026.01.23.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:53:33 -0800 (PST)
Date: Fri, 23 Jan 2026 09:53:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <aXNFGNM5MmEuyUSG@google.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c94c5194871ee1a0f3a6b49e18818b88f51226d.1766174731.git.nicolinc@nvidia.com>

On Fri, Dec 19, 2025 at 12:11:25PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create a new data structure to hold an array of invalidations that need to
> be performed for the domain based on what masters are attached, to replace
> the single smmu pointer and linked list of masters in the current design.
> 
> Each array entry holds one of the invalidation actions - S1_ASID, S2_VMID,
> ATS or their variant with information to feed invalidation commands to HW.
> It is structured so that multiple SMMUs can participate in the same array,
> removing one key limitation of the current system.
> 
> To maximize performance, a sorted array is used as the data structure. It
> allows grouping SYNCs together to parallelize invalidations. For instance,
> it will group all the ATS entries after the ASID/VMID entry, so they will
> all be pushed to the PCI devices in parallel with one SYNC.
> 
> To minimize the locking cost on the invalidation fast path (reader of the
> invalidation array), the array is managed with RCU.
> 
> Provide a set of APIs to add/delete entries to/from an array, which cover
> cannot-fail attach cases, e.g. attaching to arm_smmu_blocked_domain. Also
> add kunit coverage for those APIs.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  98 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 +++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 258 ++++++++++++++++++
>  3 files changed, 448 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
