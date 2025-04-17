Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BD254AE2;
	Thu, 17 Apr 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900076; cv=none; b=f/XagH6G4dHQBztQUswSJtuc7RjQO+zQuXb//Rjg77FvJx84bU3HjZI/QyKe6HiQI+YPDkbF+ZfBdTOaQ3lnXbcb6QZbqmuwG1zqbNj2ula9epR9dDp9lUkgFc5AvLxdiwQOycZguatQJ3KGY8Ypd15MtYk4BYKi5ixAS/EL/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900076; c=relaxed/simple;
	bh=m5ffm3GL0s490Ji0qAeVsgvxw9sdNIOdZU+SRNY4CGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBa8mczxPRVWfniYQXSmWz+Ht+Wz765h35u4f/sXwPBqcX7fFMxSmuE2z52IBrp0ZK9rEyifeJXPE1WhsEe8a0amhpQlojvwOM9pHkmzMTuncC7DdAZ5HRRX5KMMltzvID9uQQD8R+LOlK2a4prg5+uDOxrY6mbHbJtZT0WukGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gALtF2FQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gALtF2FQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85066C4CEE4;
	Thu, 17 Apr 2025 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900075;
	bh=m5ffm3GL0s490Ji0qAeVsgvxw9sdNIOdZU+SRNY4CGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gALtF2FQhfhGku6VNrV78WL4sU7Eaw2X+uzxniSyNE3QKX6gRro2e6E/F3ZTnm82X
	 UJz+4Al51eWjIIYLAtJiWlDtqo/FF60sQk8JBmp6V1HQQsHngygigVp34t7oGzecPG
	 nTlAoDmMnaLz3dFNbWMzRaMAA4O6FPuan+cOtALnyhtGdygnsMXd+cfJ4wbVwCh5h0
	 1pFGN7giho0jrnLdBYpuUKwxDZqK/j998Jr1FfrXCo8ooe4dd7FqDp29AY8Di/9xPf
	 o2ZASfv839k+sGSCAyqomIfnBzdYgvHVN0jBbknOdSBSxkgecpy298loozyUGqvJH4
	 +jBcPCqaSeqNQ==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	joro@8bytes.org,
	jsnitsel@redhat.com,
	kevin.tian@intel.com,
	praan@google.com,
	zhukeqian1@huawei.com,
	Jonathan.Cameron@huawei.com,
	jean-philippe@linaro.org,
	eric.auger@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids
Date: Thu, 17 Apr 2025 15:27:28 +0100
Message-Id: <174488987895.911007.3600084862328161208.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250415185620.504299-1-nicolinc@nvidia.com>
References: <20250415185620.504299-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 11:56:20 -0700, Nicolin Chen wrote:
> ASPEED VGA card has two built-in devices:
>  0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
>  0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)
> 
> Its toplogy looks like this:
>  +-[0008:00]---00.0-[01-09]--+-00.0-[02-09]--+-00.0-[03]----00.0  Sandisk Corp Device 5017
>                              |               +-01.0-[04]--
>                              |               +-02.0-[05]----00.0  NVIDIA Corporation Device
>                              |               +-03.0-[06-07]----00.0-[07]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
>                              |               +-04.0-[08]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
>                              |               \-05.0-[09]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>                              \-00.1  PMC-Sierra Inc. Device 4028
> 
> [...]

Applied to iommu (arm/smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids
      https://git.kernel.org/iommu/c/b00d24997a11

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
