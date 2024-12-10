Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E22AE93
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789869; cv=none; b=iOkh675Zp3Y0l+tht1m5pvRlft0KLmKvzEaFWywt8lgXdBmZhQqEofkbylWW4UPjlI7XqyK5zEKGC93ppe2cmOgp66smmj0n+kwP3N3gpuDUOSZNwgbUdrJmAHn8eQVsSVMRlLIW3XnDldEZVdr6rb3ixxgcNcpmeHFT1SPpWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789869; c=relaxed/simple;
	bh=+d/z7lM6Ty4nkhWISS9A4dpkXbJaiWaiwpS72Ypiu1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1D/vO2iWYJOhiCB3zbpUdKZu/d3AkQLx+kWNpRFbdkeLVQiZ7OsYRwd01pTQRS6vvrMKHjZJbOH09JPMDMGOPCPrK9AG1eGpbh5AnZEJ+++7TQfQU0ZPDlAQdZNIMSvl/zoSVhHJCVqHmQNuGnAhvhRr/3RF5T3CE4ZMwXPqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZM3wGon; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZM3wGon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2995C4CEE1;
	Tue, 10 Dec 2024 00:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789868;
	bh=+d/z7lM6Ty4nkhWISS9A4dpkXbJaiWaiwpS72Ypiu1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZM3wGonVFHWXCsEXoU3JNBXwF/BxX1+yWNISPgO6Aaqajo8aZwhZMCeQZNgKVlku
	 NkGtQu3PvKpdjpmvwTf75EgWBGIZV9fsZTuObfTZMJyY4mG0YHkMXbHuwVuN/8DRuU
	 0TMePcHK84LhDTBVvGQ73JbDPEAZ8YumGmm3ZMk4f+sTkql0ZBz2HalWpu+OYu3VDv
	 vDX/7XkXFl6wdxJjnbEbh2jn/BMV6uHi2LjGgefRB0qxi2UNyPBseoqPJbbGwiU674
	 qcXzJcsmnvuvDhogWlSMbB2TYiereFg9kf344BggKm/kY3Ng2GvYNmpEY5cMFvbFhI
	 ZeixckeT2DNfg==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Robin Murphy <robin.murphy@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	joro@8bytes.org,
	jean-philippe@linaro.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Document SVA interaction with new pagetable features
Date: Tue, 10 Dec 2024 00:17:30 +0000
Message-Id: <173378456062.4186718.3662609391353650164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Dec 2024 13:48:09 +0000, Robin Murphy wrote:
> Process pagetables may now be using new permission-indirection-based
> features which an SMMU may not understand when given such a table for
> SVA. Although SMMUv3.4 does add its own S1PIE feature, realistically
> we're still going to have to cope with feature mismatches between CPUs
> and SMMUs, so let's start simple and essentially just document the
> expectations for what falls out as-is. Although it seems unlikely for
> SVA applications to also depend on memory-hardening features, or
> vice-versa, the relative lifecycles make it tricky to enforce mutual
> exclusivity. Thankfully our PIE index allocation makes it relatively
> benign for an SMMU to keep interpreting them as direct permissions, the
> only real implication is that an SVA application cannot harden itself
> against its own devices with these features. Thus, inform the user about
> that just in case they have other expectations.
> 
> [...]

Applied SMMU change to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Document SVA interaction with new pagetable features
      https://git.kernel.org/will/c/6e192214c6c8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
