Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32D177980
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021286; cv=none; b=eJFTh4Btk61U2iUcDnaDK3vf9My5Txy4serWVAOsDSip8BWtqjQQKjJGmyHXljtRAszwvV6JC3qG6KOR2uAuvqTRZjfK5FZGrFnxoJ/I2t7gpAdvARm6Mu1W81vxbgfMgN4ECcEYa7p17vdTEAvLfh8cjxtOXN3IP88isINyf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021286; c=relaxed/simple;
	bh=s6X8/Cl2P5VEqeNO93aV1aL8ASABJC55j3inNPIZwt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1ivkzX1scpjN7hv/RJrbVFOfYtCkr4hwNyXrkq1MkeswygZm+BN+1h4E+xJQO6F+EGmizKSf2lC7Kwml8v6OhIkjjyzwtaDE9Nb7xfuS0fqfRzk0R2Ze1/gm2ZTmbZkS4DxZWYcPLniLnIa+EN3Di/zD6+DW9BtP8feJBAupmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEwP1xKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEwP1xKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA69C2BD10;
	Wed,  3 Jul 2024 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720021286;
	bh=s6X8/Cl2P5VEqeNO93aV1aL8ASABJC55j3inNPIZwt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEwP1xKbqQx2Z/+GW02WFHVDQ98ja3i+mu/a3iAFe/E1t4V8JBc+T3T/efJ0vDCgK
	 dqgCZc0vIDMgV2xBnzhnPslq5yxEPUzsvKgXgpd/QqSXrEr4D/E3j2FSe/Qb65rHba
	 BvM6XbyI2+dpAlTs48/FEi9BaVBXTZscRDttjGcIeoGORJw+p1wqmIcZlGNC0truBF
	 TTSujk3xeAzUTtmrQzLHUbeEJ0rmzTzHMo4v8MAc4ZwYqGMFYZxQH+fSYi5AdctPqV
	 xrtX7fg0L5NgghfV+jKF67+Nd7yXpYrLJhaC1wUJALQ7zFnGyJCATEIgnZD5T+WtMf
	 6A9Bc3Wt0etSQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	ryan.roberts@arm.com,
	kevin.tian@intel.com,
	nicolinc@nvidia.com,
	mshavit@google.com,
	eric.auger@redhat.com,
	joao.m.martins@oracle.com,
	jiangkunkun@huawei.com,
	zhukeqian1@huawei.com,
	linuxarm@huawei.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v7 0/5] Add IOMMUFD dirty tracking support for SMMUv3
Date: Wed,  3 Jul 2024 16:41:19 +0100
Message-Id: <172001794954.3844800.16472185276899283949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
References: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Jul 2024 11:15:59 +0100, Shameer Kolothum wrote:
> v6 --> v7
>  -Rebased to kernel/git/will/linux.git for-joerg/smmu/updates branch
>  -Dropped patch #1 as already addressed by Jason's series.
>  -Picked up R-by tag by Nicolin for patch #2
> 
> Thanks,
> Shameer
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/5] iommu/arm-smmu-v3: Add support for domain_alloc_user fn
      https://git.kernel.org/will/c/52acd7d8a413
[2/5] iommu/arm-smmu-v3: Add feature detection for HTTU
      https://git.kernel.org/will/c/2f8d6178b4fe
[3/5] iommu/io-pgtable-arm: Add read_and_clear_dirty() support
      https://git.kernel.org/will/c/4fe88fd8b4ae
[4/5] iommu/arm-smmu-v3: Add support for dirty tracking in domain alloc
      https://git.kernel.org/will/c/eb054d67b21a
[5/5] iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping
      https://git.kernel.org/will/c/25c776dd03b3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
