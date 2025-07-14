Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BA24728F;
	Mon, 14 Jul 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494091; cv=none; b=OaCMfs2ilf6dziXAtuzPJh9tjZ6LLAZuX8KnfxWP7PCRW7wjmHuQQ6nED7b+Xue9z1tYkiPonrBQ5fRT5pGf4mDtsbdu2wDYvcDteenT2nz5y95LFFRFj912vaSOKFnTQuaYpMfQDxPPrqVkeRw3Aw5JNPuYxTGsc99EKRPC1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494091; c=relaxed/simple;
	bh=d0joSu+CYHb5OJCnlRZ4ebbkZ3bY9fgZjzT8Cp/Aqi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gp7DE1Y6JGxp3W0QtnnQF5XJOO99smlmPyu2pR/+xNkIGI0eWvWA5KIYQPkKvmu8dwUE4/ngfyRKxnFBn6F+UIGs8k2PwZC4iljE8luYDul/H693MuxMqKK672yYrhHopeQKrx5CpQ/uoS/HW1/8KOcY8VC1wjKNG6Hs7I7D94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpQXCszR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpQXCszR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B100C4CEF4;
	Mon, 14 Jul 2025 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752494091;
	bh=d0joSu+CYHb5OJCnlRZ4ebbkZ3bY9fgZjzT8Cp/Aqi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpQXCszR2pubUtIf+QwsIjfF08bbyU/kiEshe5/ToEoj4I7WHAtOf3/89BFTUK+8w
	 BXsvNNrLhOtKrNb7CaGBrBlb5wC5CYcLKz6EYDC4NFwyN1WCrBh75LOK9jS/JFeSft
	 f1SvUOAs/EOcb7eIjVBMssLHTUv/Uq5DrzobyTKdn1h2HdXGdP7KihK5moScSCwTxn
	 uUcrNQQfIlr9kSJcah84/q79DgGR5rOoM5KfXzaJEJOc9nvNhahZokQDP3ML14QopM
	 bQX9erDnWxVFiV8B4U9Wi2q1S1dHUYGVDbNd11KDGJHD9lCPJxDe2fgVLPXa62PTYp
	 ieMOEgyJjAVzg==
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/exynos: add support for reserved regions
Date: Mon, 14 Jul 2025 12:54:31 +0100
Message-Id: <175249276902.1459797.13570182845894865373.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712-exynos-sysmmu-resv-regions-v1-1-e79681fcab1a@disroot.org>
References: <20250712-exynos-sysmmu-resv-regions-v1-1-e79681fcab1a@disroot.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 12 Jul 2025 17:19:30 +0530, Kaustabh Chakraborty wrote:
> The bootloader configures a reserved memory region for framebuffer,
> which is protected by the IOMMU. The kernel-side driver is oblivious as
> of which memory region is set up by the bootloader. In such case, the
> IOMMU tries to reference the reserved region - which is not reserved in
> the kernel anymore - and it results in an unrecoverable page fault. More
> information about it is provided in [1].
> 
> [...]

Applied to iommu (samsung/exynos), thanks!

[1/1] iommu/exynos: add support for reserved regions
      https://git.kernel.org/iommu/c/2d70fdd9b5c9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
