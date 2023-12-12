Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABE58128
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nvyq70TQ"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B457E1A3692;
	Tue, 12 Dec 2023 10:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702372324;
	bh=t19tHgvfYg+tmGKy7EIdQj9jb04NY/+y92FQl+qOnbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvyq70TQ4DbsL1zbnONg/+aQ/xdKnMd60e/t+4JKlFYxpVjySvn0wW60tzlQLOefN
	 bqNkzMd9y81TS0Ii9saB2uXugfMR77t8KQcxJXbwKbRl4wRcKzSeVfuYC/5wVMSehD
	 LbfJbZONzNENU/DRYSBWNIvV3iKCcjLl5Ps+RimlmeDYktWlM50HvQfnRS1VlJD2mC
	 H6LtjSLLg4O/JAVLHO0K+cT2l0jlVBUu5sq5ZHwzEYElVWnN5fTvzhBAVZdC131q9N
	 SRQUY5LbLD1gC+tsJ2L7bqj44oQ1VJU5Ci9TmMJvM+l9bqz/L2Q2hzgaQqgQBHxfe6
	 JJpl5smR2cxIA==
Date: Tue, 12 Dec 2023 10:12:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v10 0/6] Share sva domains with all devices bound to a mm
Message-ID: <ZXgj49cY2PEAwHsB@8bytes.org>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027000525.1278806-1-tina.zhang@intel.com>

On Fri, Oct 27, 2023 at 08:05:19AM +0800, Tina Zhang wrote:
> Jason Gunthorpe (1):
>   iommu: Change kconfig around IOMMU_SVA
> 
> Tina Zhang (5):
>   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
>   iommu: Add mm_get_enqcmd_pasid() helper function
>   mm: Add structure to keep sva information
>   iommu: Support mm PASID 1:n with sva domains
>   mm: Deprecate pasid field

Applied, thanks.

