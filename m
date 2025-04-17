Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6D253B73
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900080; cv=none; b=kocfHHB6ApB9Dhd0cVJpkPSLifkPuxs+CYqR45GY0Udub47/3DGcDiZq7msBQQmUmJxVIT6gmu9JDz8luY7u8Ss5srmTSH/6PWBGhUTOczAx3eLnmPvc0GkVNwNDc1Au9/B7Kn1g/ha4qh4+VU5k4wFv+U8rHzQIPeOhoxKFJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900080; c=relaxed/simple;
	bh=f0/i1f77DYXfCc5XbQGnPcXxQM8UrjBHZ/+ff6enkUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv4QuEwjSV5B7S+bvZ0Pp6dtB/54ISW1iCuCPMF+MHlo5/YFknGdFjRvKcNV/QduBC0k32XPD92/r+i5xLvgsovjaG/GVrOc41MKIJH/LjXx6IrweBuyI7FAr9LFFXZS2clMbdzDLdH23hZph93YFkpFMyiYyfcTwcXzGrSV4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkZn6SEY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkZn6SEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB6C4CEEB;
	Thu, 17 Apr 2025 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900079;
	bh=f0/i1f77DYXfCc5XbQGnPcXxQM8UrjBHZ/+ff6enkUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkZn6SEYUjtOEKtRudAJMrMNJx7y3YN9Lec0IrVZPOXLZZotAL1U8JkFxg5/hgHao
	 Wy+jY+CwxGRcpJDs93u5NAqWA/9FP6aRJK2ezX82w6Neqwov7YYEutao4D8BObs+Lu
	 3rakzxbCtCxO6V2R7dA0lBtCM1FkzqUMwj++gY8gQiDm6OZYE21CRYapry4Jj+VMLU
	 YRr1DXWWlUISuKWHn/W9CKEqqn8xBwwK5xUjYWt4SEFOz3NGzJK/isNb8CGh0S3Bqx
	 xDAO8Q5IjGToW8OgYAlO2NrVEJKgSiGNitTE5WEHc6b/yZqFQhXr3hVRIkjjdqFrRo
	 4TNKEZOiKaZAg==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nicolinc@nvidia.com,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more gracefully
Date: Thu, 17 Apr 2025 15:27:30 +0100
Message-Id: <174488998090.911565.16333351329264813205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
References: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Apr 2025 15:09:14 +0100, Robin Murphy wrote:
> We've never supported StreamID aliasing between devices, and as such
> they will never have had functioning DMA, but this is not fatal to the
> SMMU itself. Although aliasing between hard-wired platform device
> StreamIDs would tend to raise questions about the whole system, in
> practice it's far more likely to occur relatively innocently due to
> legacy PCI bridges, where the underlying StreamID mappings are still
> perfectly reasonable.
> 
> [...]

I tweaked this ever so slightly (mainly just the diagnostic message) so
that it sits on top of Nicolin's change.

Applied to iommu (arm/smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fail aliasing StreamIDs more gracefully
      https://git.kernel.org/iommu/c/2d00c34d665b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
