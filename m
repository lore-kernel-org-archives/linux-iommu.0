Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AD4776E;
	Thu, 22 Feb 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625209; cv=none; b=kqOvQzWkNasLaXetU2uN1dTSidc5kZJki0j8752CJ6VmiT2AwnvSyjp9yFuCAikOwu+jvUYXMWB/0QIyCfB5KR1bmcUqOf44s5SJUZcrUhXgRSyrkchWgWabwu94TTmtB6f3pTew+lN34YQFiMulhYXyCp+iHVdoeENTIUbpeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625209; c=relaxed/simple;
	bh=9zlXzRoU7sp0rxSoNtBm4mF59g8JTlA/QOnM1iyBpDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CB9ZXMRjSSe65fElAiDO+0r9swxczSf4A0NnaWRIvHoF6toRyzVt6zKncug4i6/zkhgTaUM7SA9jLm23ZJazwH9n/mFikNwwOd12LihQSruK0XozSbmEJPisYv2NcPwCuXHWdFzLcD/foBH1jdrggpvLa1/mp+jPQm6LNUjFxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5qPjfx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5qPjfx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DFCC433C7;
	Thu, 22 Feb 2024 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625209;
	bh=9zlXzRoU7sp0rxSoNtBm4mF59g8JTlA/QOnM1iyBpDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5qPjfx6fGVeVc090SROU04EKEuhttAPQD6ERj3JQmd1+ZY+EZ8N6UwlUsPii7PCL
	 omlIjIJuNFvuOZJkvdBqshMDISeKMZ8STew+NM+F5EyKcf9UXsROe3ia34fVkk4g34
	 HZM1PBWVUY+bVNR6Ra27J22I9k6OoI1+36w2sG33lM0gwB3WDXDTZ2fEqijA7781iG
	 Qbzme580d8+rg/t8HiAgekqw4hq8Q8FBn8x31GnuuUw8zp3Uu39m9p81RHZG4wbpNA
	 T/cB2dOvCEH+qbufyVjGiLbzTZzU6VRZwhBMLr2OY/koYwCiUkhyazsWGtQ3X4tr/5
	 NhBdrVbOL3yug==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible
Date: Thu, 22 Feb 2024 18:06:23 +0000
Message-Id: <170861674966.1924480.16417881961597163115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240131-x1e80100-iommu-arm-smmu-qcom-v1-1-c1240419c718@linaro.org>
References: <20240131-x1e80100-iommu-arm-smmu-qcom-v1-1-c1240419c718@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 14:35:16 +0200, Abel Vesa wrote:
> Add the X1E80100 MDSS compatible to clients compatible list, as it also
> needs the workarounds.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible
      https://git.kernel.org/will/c/12721e660057

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
