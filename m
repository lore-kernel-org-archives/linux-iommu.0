Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852021DFE3
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945958; cv=none; b=aQLBLk301lBiyGRxewv64duhW5HYy5vnBbfE3geoBl/5C55+rVXu+XLUfv38m2QDIFEmRJdhSeFPYtWTAzpgvgvt0uAL/fiatxqthE51l7peGC1LRbLZBzoSLk4qbSEFjXUWGqXd+tlxsid+yJVl2tqHDVYJ1OMBfPma3PA/7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945958; c=relaxed/simple;
	bh=jL+1ejN6iogi/SUq46EXFFORYYcaYiejj3Mf4X6Ct60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzq+lDZgCYFEKeOg+/17/7+7E+wqkPNi9n4+d4/bdNWVxKCcvbZrHWvDBfGTWHLS4RwvoJw8hukdUa+YUzuzDOu8/41Z76Bn0k4aJYjn9DEZf05UayAi4F06HzSOOjJmcODuEYH1K6c8QvNGyT3uIXpyXnB4YzHIu8vN8+acnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIaIClJT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIaIClJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB0C116B1;
	Tue,  2 Jul 2024 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945958;
	bh=jL+1ejN6iogi/SUq46EXFFORYYcaYiejj3Mf4X6Ct60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIaIClJT1s7ZcSfosz+0RS7fPxDcFPHDg+KjmFJILoO+1TfrtCHH91xCcoPH3zjhB
	 NNfwAMgkb4cJ093vekNVHpbN2BexaWGrBohYYvWZlChCFnrVzzWZxfNXGrDjRxCflP
	 BjTVxozF8xyi+fz4cTX0Xny1GatOpFTbB6X4IaNNFk888+ugzi5zR6DSkKI4k2ZzSF
	 znfe+DuVaE6zZPZ+365f654cj18U28UYaZwHZW1hu4BNA+Tp7PVoa2TVgzTAbolv64
	 U+tTgYxuSYW1You8mM4RLAVOK3Yd2ayhRUd8gp5sxiOrURyFnosyccq7ve/E4BoLt8
	 v+4J1t0rgLAuA==
Date: Tue, 2 Jul 2024 19:45:52 +0100
From: Will Deacon <will@kernel.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	ryan.roberts@arm.com, mark.rutland@arm.com, kevin.tian@intel.com,
	nicolinc@nvidia.com, mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Message-ID: <20240702184551.GA5167@willie-the-truck>
References: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Shameer,

On Thu, Jun 13, 2024 at 03:41:43PM +0100, Shameer Kolothum wrote:
> v5 --> v6
>  -Minor updates based on Nicolin's feedback.
>  -Picked up R-by tags by Jason, Nicolin and Kevin(Thanks!)
> 
> Hi Will,
> 
> Not sure you got a chance to take a look at this series yet. Hopefully
> this will make it for 6.11

This all looks good to me, thanks.

However, it conflicts with some of Jason's stuff that I've pushed out to
for-joerg/smmu/updates:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

Please can you rebase, retest and repost? Hopefully it makes your life
even easier as, for example, I don't think you need the first patch at
all anymore thanks to "iommu/arm-smmu-v3: Make SVA allocate a normal
arm_smmu_domain".

Cheers,

Will
