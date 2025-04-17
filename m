Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414FD253947;
	Thu, 17 Apr 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900068; cv=none; b=gRxzi9sVdWvvENcFk5bgkHP6bi0qyeFzwqQgKAn1KMzjrGQCJaeuz32i3gnRgmfWefh5S0jyf3NLHEtEI+bv03H9FWqLbqFon9BKXN2z2bXh7rxUiYFzKB16gkdO8fAC/nOtiL3K6ViAqxGim41YIA2BHXaBLVYzADgj57tBqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900068; c=relaxed/simple;
	bh=nXPVCryDxtAn6n/w1ELFDJIKepg5llxRHEpDLLve16E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7pWbim/XS7TZ65lrbUMJ9cPoUjFLf1xfBcwx2v8+kNoz7wnVgnsfTeqE3qIVzyfDIByN2CtHeTZnI6S6wHIKD/JFllZ38uyjcIMncaRb8LT/JWPkL3aycMUpST7xVw5LILwC5gPUIMEKN3HQHOBlwzhtOh5e8LjgYIfaOFKxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJNx3SfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJNx3SfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321ABC4CEEA;
	Thu, 17 Apr 2025 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900067;
	bh=nXPVCryDxtAn6n/w1ELFDJIKepg5llxRHEpDLLve16E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJNx3SfEtkcZpSWEw91YForzmo/avlAyghRcO6mnzhiUHqJ3oAnSRtJVqhpUER13g
	 vZdxgy8swv28AsqkpyrVU55StNGBYo5q6VrRQXzakVRlPWXoHMM0GvBQ3oKLARYfO4
	 4vyXHvlmR+3zidGDs8DeDKR7kTjIusOiUPskl5yEEYSJNNMfLuTlg1Wj6S/QlDeXls
	 NkERlLI1wkg0moGufLGJyw588M7uVxz1/pWMSnkVJ2SVHXfxl94QqHYABLbV67VYL1
	 VFEPYih+o5aQuvLjRsqPxL+Bf6C+sd8Q5gPR0vy/ILOxmNyntRvD24YryVVLRYCPHp
	 Yu9EK8oHBQ2Bg==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	praan@google.com,
	kevin.tian@intel.com,
	ddutile@redhat.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add missing S2FWB feature detection
Date: Thu, 17 Apr 2025 15:27:25 +0100
Message-Id: <174488913548.907912.11019680533308808678.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
References: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Apr 2025 09:03:51 +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> introduced S2FWB usage but omitted the corresponding feature detection.
> As a result, vIOMMU allocation fails on FVP in arm_vsmmu_alloc(), due to
> the following check:
> 
> 	if (!arm_smmu_master_canwbs(master) &&
> 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> 		return ERR_PTR(-EOPNOTSUPP);
> 
> [...]

Applied to iommu (arm/smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Add missing S2FWB feature detection
      https://git.kernel.org/iommu/c/45e00e367189

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
