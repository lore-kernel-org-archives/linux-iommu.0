Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29D3B27F7
	for <iommu@lists.linux.dev>; Sun,  2 Aug 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672788; cv=none; b=MlSV5YQScXHkDeEL9dqBXqXqaIj0Hr3xNCJoF5lF9X8kIGIK/8IBIIqrDR8/tnfDqsqjO5jcwCeyYbNCgdhfWphvknHInftd/qVVy47JYku0r7lsC9T/spDdEBaW77QCxidMCCOKK4pH04NBs6iBNLilp2f4dEq+8yPglIXAOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672788; c=relaxed/simple;
	bh=zEqlJGAnsdCK69X6ZmP36wd7U1NzbARggjpVXCtZL1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdrjDQ3EtoGAy6dvioHVbrZpslHrDzr64zSXXIi9/eDhYfczFEZEQbBu84Qih9/m6rbALqVW+wCdiPv3ACj0F42/rx6w5RPRR/2VglQlVM5Mk0d10k8MXw2eWNqYIvHDplTXPyVlCU+28P98U59mRbUyM2oRKcjxk4I2yVnqyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XegY3zry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XegY3zry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062C01F00A3D;
	Sun,  2 Aug 2026 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785672787;
	bh=HOsdimgk1hcuikqltrmpauaFiHs4qkbEXMgzVNkUqh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XegY3zryDTYzLZ0sDrgsP4O1R2SKJfswe4uKlJx/7cjZjSR0xCmopSl2xpSpf1xlZ
	 eMyOCHGXhg7/JkMoM3zycz/9o0RA7ExW27aBHsrmL7bJ/bcOZJ+YN9ZDz8pVrBioo6
	 dgHcf63OzfYQTputEaP3uRD8TCkkrUvDQ/3qEFkR4LpQRnPp4ovVgiw6gk8Z/FAL/g
	 hsmHrdecW5pl5hV1VXlEfUSANolTBZABUh3sbw6AnPW2OaGxzmLsvrKYOKrYG0nrR9
	 T19cJkf/OsMD5rcHxrVQskcx+Bj8BdSK1qjsvJZ4bCl+Sy/N4zgn1eBGKS/P5vcSK2
	 dudCmwe3C+8XQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Convert to use atomic poll timeout
Date: Sun,  2 Aug 2026 13:12:28 +0100
Message-ID: <178566514482.939612.15682351054124522231.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728211123.1059708-1-praan@google.com>
References: <20260728211123.1059708-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 21:11:23 +0000, Pranjal Shrivastava wrote:
> The arm_smmu_write_reg_sync() helper is currently implemented using
> readl_relaxed_poll_timeout() (that relies on usleep_range() internally)
> which becomes a critical issue when used in the gerror irq handler.
> 
> If the SMMU hits a gerror and enters Service Failure Mode
> (GERROR_SFM_ERR), the gerror handler calls arm_smmu_device_disable() in
> hard-irq context. This becomes a problem as arm_smmu_device_disable()
> inevitably calls arm_smmu_write_reg_sync() which might attempt to sleep
> inside a hard-irq context.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Convert to use atomic poll timeout
      https://git.kernel.org/iommu/c/eced8058c82a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
