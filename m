Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425911;
	b=wjNFd4Qy9JqlOYXnhtQqf6/CBFQb/0u8jG5QaS5tDLNtxIKMBwmaRbE4PlmDlIdkSXr+
	 /TFDmA7+gdwSMmXlWbZJo4J8hw50Y2yjhHaPUkNW0cqG0c1G11X6tYpAlR+aCKpE2RLIq
	 qmkt43kC+pIEsnEw2Q+Ct7smRGRmVnmrhvLQ30rDDWjZG1RvNoxCItJBjAxwa3CMmmUTa
	 QH4aNZKEIs9i/uKFJ1R9PMRR/+svq3IOR7HpLqfEmGJzNarh/h3J81k/qnIgjEOlVqj5U
	 pi0y0+Np7Kt9CW1sXNRV9KM8iRx/4Woyp172L0LBgJTqoECekiAQWV/hU5G8BM6Z06Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425911;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EGHXVFudJQgrigdJDc3r+sYIi6a6KP1wbs0YNcEORm0=;
	b=DNOPIfCToKU6uv/laGPuBRV/9O7gi3YAHtG27Pf8Lr5AXW7LJc2kimiklRTlDrmvt7Tp
	 mLVbH3fE1eJrzeHD8rMUtDjcBLd4F0Wi9Xo1Fp2PVWn/v/hDtnpeBPeFmn+LnuZcRd+Hm
	 GYnRs7FKu9Mb86KsLSE553/IfbJDLY9DhlUssdJTAwVHjCtXIBZnL8EAZx/A5C1gq2k6m
	 Bib/J5j3KBjOaxvjRHJ5W7Qc0KvTP5YlVXR+cUABzaHIrfu7GSb3cwMbrIiG0i89epwA6
	 RIWZjxb7twpDNzt4PstrUmvpzTQlCxlElA1UryxGGZCcNQNr2ynshqsnzZVFrh5PhEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13056606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13056606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ECAAF244CA1;
	Mon, 23 Nov 2026 10:25:09 +0100 (CET)
Date: Mon, 23 Nov 2026 10:25:08 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: will@kernel.org, robin.murphy@arm.com, joerg.roedel@amd.com, 
	jgg@ziepe.ca, jgg@nvidia.com, dan@reactivated.net, vasant.hegde@amd.com, 
	kevin.tian@intel.com, Ankit.Soni@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, guoren@kernel.org
Subject: Re: [PATCH v2] iommupt/kunit: Skip the page-table leak check on SMP
Message-ID: <awQGZIKqZOHcuTqP@8bytes.org>
References: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>

On Sat, Oct 31, 2026 at 04:55:36PM +0800, fangyu.yu@linux.alibaba.com wrote:
>  drivers/iommu/generic_pt/kunit_iommu_pt.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.
