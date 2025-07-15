Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B95103F;
	Tue, 15 Jul 2025 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580638; cv=none; b=eicnUGcm20d5yLh8czTKt+6Hl+ZqvPkxRK6D85j7pUeZXBEeMFA9A1JAyW59TnKJ3PXr0LCRQxXdVoAWYG+2IQRAbQq2FDfD9slXByib5flXDiPJkp/uZr9s7N/bzKDLYupow3ANcXkGTPfTj2VqZopmXQ5ziA9WivU/l4Qu8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580638; c=relaxed/simple;
	bh=FSt31H26dIBp7/pCdW1m4F640hFbkhazVD7WB7oKGBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvYOo9ed1vnwMAseBS7xnyNQ5SbS4Lu8RpmsC4upvaBs0pAYWe6zQkXqPVSeHIzl3lAlQmFgUf8jS1B+tdwSbpeaGrgD9VsdNjVrX/rJs98zUQdhXXQ1lRVqRJeDz2mXEqJ8lFZCp6FrvXAwig+at4uY7ofOqKGS+jy8CYkX/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUnGb5nK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUnGb5nK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0F4C4CEE3;
	Tue, 15 Jul 2025 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752580637;
	bh=FSt31H26dIBp7/pCdW1m4F640hFbkhazVD7WB7oKGBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUnGb5nK68FV3bx2nZK+p8/xf+VTsOk2Vm5v5UVXwt9fDJwbCv2lK1fa9bHiyULgX
	 i8c1h6xUXD8pyXmkfXvKyaWRLrDqVUvM0sZmoY5lbboKoLfK0hTaZ5oUYdO+lm5P+g
	 8DIerfNH5XKM89Z0bm0uA3d7n0UufivcfX+lZMCi9vuKCVqxDRIGtzbYuR6UwVp/hw
	 6LPMyM/vpqUKxeC0bcPOitaWDG/r51pjpz7FzE3oHVghlBg9xFrQWNk1SI0NasDRC7
	 Ca91iBu6NywDbWUB7tdXxUVmKO9S0eWaxkS7dT3Kx5vJCb/1uOPyHQuxsHLsGPem4z
	 nsuS4NTy4YGNw==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Vasant.Hegde@amd.com,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 0/8] Introduce debugfs support in IOMMU
Date: Tue, 15 Jul 2025 12:57:08 +0100
Message-Id: <175257611416.2787163.3378169286521949701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 02 Jul 2025 15:07:56 +0530, Dheeraj Kumar Srivastava wrote:
> Introducing debugfs support in AMD/IOMMU driver that will allow
> userspace to dump below IOMMU information
> 1) MMIO and Capability register per IOMMU
> 2) Command buffer
> 3) Device table entry
> 4) Interrupt remapping table entry
> 
> [...]

Applied to iommu (amd/amd-vi), thanks!

[1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
      https://git.kernel.org/iommu/c/ad48b1dd14fb
[2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
      https://git.kernel.org/iommu/c/7a4ee419e8c1
[3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
      https://git.kernel.org/iommu/c/4d9c5d5a1dc9
[4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
      https://git.kernel.org/iommu/c/fb3af1f4fefb
[5/8] iommu/amd: Add support for device id user input
      https://git.kernel.org/iommu/c/2e98940f123d
[6/8] iommu/amd: Add debugfs support to dump device table
      https://git.kernel.org/iommu/c/b48457782445
[7/8] iommu/amd: Add debugfs support to dump IRT Table
      https://git.kernel.org/iommu/c/349ad6d5263a
[8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
      https://git.kernel.org/iommu/c/39215bb3b0d9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
