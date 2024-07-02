Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A31CCCDA;
	Tue,  2 Jul 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945860; cv=none; b=hfIuuFWKh3gHxFIauNA9AHFCBeCMf0gKOSrFhuP9PIEY5Nxxe+vLyF92HwxY34Rfe0dqJPF6mp6Wzjy8ZHFmixZd5lxCXX0znx3Txer7xPLiAiJqyz0Wh9+qFxn4hQ3H3vLDAIRIApAWSyQxkBxX31N4CKWDb10svZ2FfNx1CAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945860; c=relaxed/simple;
	bh=RZj2s6IcInBWDxn4dUQtZNHNAnV78hF4Q74fLUoIFEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJtbuf5Pql3aGdZdmtbOSp2wxwkxdbv8gt6dteuHm+xE8oX4ZzEMm/70ys5u9oXzBT/5PK05rcgdawgAh7S/JnrwayCnSG654Oe/Fq+0RYBhuYQNg9qWYNXuS2OEyZybuhvRii6cIuQ1d7qcFkPmyMblTwzLlX80FDTFnGWJZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOrOtMAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOrOtMAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F21C116B1;
	Tue,  2 Jul 2024 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945859;
	bh=RZj2s6IcInBWDxn4dUQtZNHNAnV78hF4Q74fLUoIFEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOrOtMANHeQ3RdSvrgOiFCaafm/UnVG9xAaZjdYJf7EHTld/yqkOaZ57ClHeMGu4L
	 wfGE3eIxZj2mBIu5pwcNKvq8l+LgnE4LHQbmV4XkFY1yqoQ8OHsSn8WN2QWSSU2SxY
	 3x4HZ6CeBjJ2Vy7dcDGnW7iAxzVkuE1XFAYb9r8WUxF5ei7GT8l8LBRrohoVVvskvk
	 L9nbgbFnNNBLujdVJs/VhXgPknKhp8oR8vBaFARKjcvQ8XsP3qlbtaVudITc/rpsbE
	 jPEjobVrodAiuXk4MrW7r1T5Y0rBSclAEDC4BWQ5Ta/ssDKspkwovZD8Ff/KezoTwn
	 rXuOHrz1j5HaA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro
Date: Tue,  2 Jul 2024 19:44:00 +0100
Message-Id: <171993683562.1962160.3064797452781426838.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>
References: <20240613-md-arm64-drivers-iommu-arm-arm-smmu-v3-v1-1-0e9f7584a5c8@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 12:44:17 -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro
      https://git.kernel.org/will/c/a35f443d837f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
