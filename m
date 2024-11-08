Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78401E0E1A
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071132; cv=none; b=ZmZmxancY2FOlUhJAja34ehuSNYq2y6hdkMly+HRTPxkWPNCBZ9q1VgbUr/465HTxH5y5RoVPDMMXBc3wugR7hsuQLhCmAjpY4Ap0QbeGpo7dURNVoJ6EfAiY70shWWkJKqgGMXf6aJ0nNwIeLvwsTztmPeEiAMgZI7lUiCTKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071132; c=relaxed/simple;
	bh=/bTIO1ud2blqkdRGaRyq2aumN+c5wa0zHP090YKZ2m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWK7YGLo7OiIzOrM9crAgyU5B5HtuW0EZiWmWy8gHPzlS9ZsXCm3tILeM/F5qiA/AQ1EIVztrty3hPAztMYCc9o7rzJvaTmOPiUUqkng2WSo4fjIkqC+rv6T6Xj4ntUBN+VDmUSNmuuODylPl0ZCSozjf0zlpZbgDCveuCR0b0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CAalpYo2; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CAalpYo2"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A78E12C112A;
	Fri,  8 Nov 2024 14:05:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1731071129;
	bh=/bTIO1ud2blqkdRGaRyq2aumN+c5wa0zHP090YKZ2m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAalpYo2fGpu7ai6Pfi6xdpV0KQ3xyo/B2CyYpj2VEPL4sye8wCfOafur9ISRUSi/
	 fijrvIvF0WTs5+XP5CVhpFntfWx2vm9l0MoWmdMQ2TzHTvp6p2W/zeH6koObUMZtqx
	 VJZmJFO8/7SvCzddLfujtAKF0gL2XShny+WZtgwosTojVCbAd9OuYsCV+nXGHik4Aq
	 igQAWtYEu4F+ga6fiHUWNqoHbNG6R4ECeXHLJYdbp7Zx1GiGEvYq3j117HGUyRqUaB
	 K/9MvjPKqJMq3y0JYR9l5V+Z2jkrDpQG37jDFZH3HvrStT5E1TZs+ihTtMswUHIUUZ
	 9WyDdZrDyQQBA==
Date: Fri, 8 Nov 2024 14:05:28 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] [PULL REQUEST] Intel IOMMU updates for v6.13 (2nd
Message-ID: <Zy4MmFQTHETSf1Wq@8bytes.org>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>

On Fri, Nov 08, 2024 at 10:13:51AM +0800, Lu Baolu wrote:
> Jason Gunthorpe (1):
>   iommu/arm-smmu-v3: Make set_dev_pasid() op support replace
> 
> Yi Liu (12):
>   iommu: Pass old domain to set_dev_pasid op
>   iommu/vt-d: Add a helper to flush cache for updating present pasid
>     entry
>   iommu/vt-d: Refactor the pasid setup helpers
>   iommu/vt-d: Add pasid replace helpers
>   iommu/vt-d: Consolidate the struct dev_pasid_info add/remove
>   iommu/vt-d: Add iommu_domain_did() to get did
>   iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain
>     replacement
>   iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
>   iommu/vt-d: Make intel_svm_set_dev_pasid() support domain replacement
>   iommu/vt-d: Make identity_domain_set_dev_pasid() to handle domain
>     replacement
>   iommu/vt-d: Add set_dev_pasid callback for nested domain
>   iommu: Make set_dev_pasid op support domain replacement

Applied, thanks.

