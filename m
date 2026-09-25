Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F253451C8
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321423; cv=none; b=efcoD7fXzbmCTov2IcWsEAVFDfj1f6Dht2JkHArUhKeD89olg6f8NWkK3eNlDgNGvttD8g8qOiGkLxpcVrUNE9FBCTfOCuBd2nejlNM5kUYGSj6O4j4jcKEFqiqH1USVsZCbpitRzsnTq0bW1r+t3rWN+7ZJ1VupwgVWFjx0Pfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321423; c=relaxed/simple;
	bh=wVMwo2mfq81Ht0TsJoOb9zV7lP3/klkJ8nSXvhifymc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTj63QwstpuO4dEXsjLlsRoyh17kNxNPqhq+3DI+2c7EHhEAKzaVLn+1pqaNi3KKSZ9274TMPkIpSO6EOGZ+k5febOlV4wBvlMylUMn1e57OYpQSLhjHNXrNRA3KaDT16ZCKWf5mhaskVUmnp6U754L7zekvF2qiv6niNE0+H+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a000b03c3c046b119f0.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:b03:c3c0:46b1:19f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E2CC41C7759;
	Fri, 25 Sep 2026 09:30:18 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:30:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, 
	Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>, 
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <arYiqAIbThf5mLLr@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908041207.38113-2-mario.limonciello@amd.com>

On Mon, Sep 07, 2026 at 11:12:06PM -0500, Mario Limonciello wrote:
> +#ifdef CONFIG_AMD_IOMMU
> +int amd_iommu_enable_perfopt(struct pci_dev *pdev);
> +void amd_iommu_disable_perfopt(struct pci_dev *pdev);
> +#else
> +static inline int amd_iommu_enable_perfopt(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
> +static inline void amd_iommu_disable_perfopt(struct pci_dev *pdev) { }
> +#endif

This commit broke build on i386, I fixed it up but please compile test on
32-bit next time.

-Joerg
