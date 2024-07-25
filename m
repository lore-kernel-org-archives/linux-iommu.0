Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C326281;
	Thu, 25 Jul 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911386; cv=none; b=iOUeScpoj9DtQGB/x0iKh3TsRpidiym1WrLpOQUamu11FE2GtKwKwUFTasYawetbhwqSLz5gftymIlxtiaBtvPLJ+b6r02vdi6MbNz1nzmcuYP7mYF6c4HlV2pZsb4xzpJkx/eM1vDWSYFlT7K0jh8H8CzSJ2A6GafZ5+j7MoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911386; c=relaxed/simple;
	bh=tC43HF5shSRy1Qp9aEL/m7tJcGEGxkURSW88ynoN5XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LC7LmhKH2vL1jWh0+xiW6J9iaCcGFEJO1YFMP3KCkRRXLlrTMfIndQav3KXgRF2F/Wuq024Lyotxtbqu8rvYBBNgSW/U3SKYmqDiqzRHbQNQjuXhDZwWuMz3+/ThRHQu2JJeBR08oU9FHn9F2cx1FjGjyKhgHcsh59vo2DpzOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT/Lh4B5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT/Lh4B5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226FCC116B1;
	Thu, 25 Jul 2024 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721911386;
	bh=tC43HF5shSRy1Qp9aEL/m7tJcGEGxkURSW88ynoN5XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT/Lh4B5uF0w84Fk+Mswy75DQppXHRZTGI0GQPw55xdMn+kFSHSYI052KZtH8o8pw
	 urHYvsRHa2romZV6EDoDOZn2jTL4hDKE7bgyRITaP89FKpJd5wLi3n8WeikFziC8IO
	 0tu9EVb1kmeeq+ckDCMOLPDKaef1nA1CTwg41z6/AkcrFItcO8jS5I2QaPzAWFvkRN
	 uzYx2KzkGHymBf/lf4KFrJmlBf8f0XTeXeZ6EvRqglMi2N17WlPzIjaIJgOwCtt2ru
	 9uXaw+SqHf9bkLnHi4s4+aeRlariaqtCY4Wq8xnP7Ezhjh4XY9RgR0gP6ElCKTy4x2
	 RDsiUT8NELpfw==
From: Will Deacon <will@kernel.org>
To: thierry.reding@gmail.com,
	vdumpa@nvidia.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE mappings
Date: Thu, 25 Jul 2024 13:42:59 +0100
Message-Id: <172190932508.3262642.13562592827305317735.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240724173132.219978-1-amhetre@nvidia.com>
References: <20240724173132.219978-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jul 2024 17:31:32 +0000, Ashish Mhetre wrote:
> PAGE_SIZE can be 16KB for Tegra which is not supported by MMU-500 on
> both Tegra194 and Tegra234. Retain only valid granularities from
> pgsize_bitmap which would either be 4KB or 64KB.
> 
> 

Applied to iommu (next), thanks!

[1/1] iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE mappings
      https://git.kernel.org/iommu/c/726d4f528dbc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
