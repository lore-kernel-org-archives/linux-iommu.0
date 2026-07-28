Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04A42A7AE;
	Tue, 28 Jul 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237342; cv=none; b=FHU8HxscA/XgZzOw14Ln/ou2+qmJ3CN5rcDcC7jgeVlAmP/xtpzh9hwTxzwcDroQUEatfIsOg7ziKtW9a6Du0Rre4XnGI0SGzdAEmtDlTiUNok/5NvQxs2+jZjOic2ivuW0mcyUnnIIgU/izkMGn1pK3OZPdhLDA4Exdq1rA9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237342; c=relaxed/simple;
	bh=mJLAqC9pDaWPlSayhZskSdxrEqlcTpCYpAR1zDMQb3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0A/ITTe9DqUIwgY+Z7NnjfydDgv24f3p239CekO+XSmcRi8LzsvQ/PI4LUl4iHhvo14y4ABoP1Ejh7rI8ddYUvuNidX/iaNh0/fKV8pMd4y/yhOJqs/xzmCYBcmsGJFctlbrB6BnB+e+r2NTzIs7EO6rlJzPdjs/lXGfaUUnqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nArRvbYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nArRvbYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F71F00A3E;
	Tue, 28 Jul 2026 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237340;
	bh=QAXXo+PhSkrJo36ImVUjmOnQ0ftX4EsaB1ZksVpLTlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nArRvbYCKg21eEKy6vf51vA9HdrHSXuDmgoTk7yx8+TX1ExIRh5OWDqyGFi3MGgEt
	 bjKtlFYpWuv45xzQ1GKjPvF9yWo7VIMT/OqbhlEG+tNeySR6EafBvBMlJP+LxLOAw8
	 ox2xSeFn5t4fsTv7SdxFxnBumjLzeRpgtKxdql2bDW93hNq/YSTSuAD9Q483WntcMC
	 3Jo3mnhLTEYbEYg2fHZxRpicFVvHDMp+kzUolx4mQQDse7p2I31V/ALg+Sr6sF0A8P
	 Qsq0FyDSnEaeKg/yqE9CswG8LiW4TwOG5qHhma/jyjMbw4TlzfU+5EC97bldPGS1H+
	 YpllvocnQ+1nA==
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 00/11] iommu/tegra241-cmdqv: Fix error-interrupt races and VINTF lifecycle bugs
Date: Tue, 28 Jul 2026 12:15:26 +0100
Message-ID: <178523230947.340181.5626643238486784200.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784059577.git.nicolinc@nvidia.com>
References: <cover.1784059577.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Jul 2026 13:54:57 -0700, Nicolin Chen wrote:
> These fix a cluster of bugs reported by Sashiko during patch reviews. The
> patches are ordered roughly most-critical-first, so some later ones fix
> smaller pre-existing issues in the same functions that earlier patches
> touch.
> 
> Issues fixed:
>   - the error ISR racing VINTF (de)init and reading a NULL, freed, or not
>     yet fully initialized slot
>   - the probe fallback dereferencing an smmu freed by devm_krealloc()
>   - a guest vSID programmed without validating its width or the device's
>     Stream ID count
>   - VINTF0 leaked on an init-failure path
>   - error-map index/bounds handling and a VCMDQ base above the 48-bit limit
>   - the error ISR flooding the kernel log under repeated guest errors
> 
> [...]

Applied (apart from patch 10) to iommu (arm/smmu/updates), thanks!

[01/11] iommu/tegra241-cmdqv: Publish an LVCMDQ only after it is fully initialized
        https://git.kernel.org/iommu/c/cbc41aacd49e
[02/11] iommu/tegra241-cmdqv: Synchronize the error ISR against VINTF (de)init
        https://git.kernel.org/iommu/c/a491be376abd
[03/11] iommu/tegra241-cmdqv: Harden error-map index handling in the error ISR
        https://git.kernel.org/iommu/c/a2ee315db426
[04/11] iommu/tegra241-cmdqv: Don't run the error ISR before probe sets up vintfs
        https://git.kernel.org/iommu/c/5acd67ceb38d
[05/11] iommu/tegra241-cmdqv: Don't fall back to a freed smmu after devm_krealloc()
        https://git.kernel.org/iommu/c/d4d05f55e9da
[06/11] iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
        https://git.kernel.org/iommu/c/61f0d437988e
[07/11] iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field
        https://git.kernel.org/iommu/c/4379610c79bd
[08/11] iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
        https://git.kernel.org/iommu/c/fb292bfc9be9
[09/11] iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path
        https://git.kernel.org/iommu/c/f40f31444773
[11/11] iommu/tegra241-cmdqv: Rate-limit the error ISR's log message
        https://git.kernel.org/iommu/c/a86c36163c97

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
