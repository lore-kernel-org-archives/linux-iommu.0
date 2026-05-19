Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B2403EA1;
	Tue, 19 May 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204247; cv=none; b=jyyB7NtdHMe56ZOqtvfx/bepJjKZe69ma3CPtp85mrDeLcHCaZlIdUplfdiR7JiASguNlUEIV1zakvFT2iG4W/MoxhdtXh7Jna1tiK4Nk32pYtsa412jaLWkTmzDe8D52jflOy561oW+lMwu9AVXXnqcRSipbdIABg19Ab3RBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204247; c=relaxed/simple;
	bh=T2/UZ6X0oL5N+IpYiiuiP8No68KS+6FoVP6cqqxB9Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NC/yk68Ajh+wsm96v0M23wyegQxU5mJdKvACT5/GFB2+We0sqda0V0HhBUOoXANmHLiwpyTvEC1+0bwyRjrLsMOB36u2lsroqsqCkd3oAYA4zV8u5DomVBNaY5zwDM4ANGjPVKKwjlwTIpvIRLYs07cu4xi+4lJmssVK+SfoY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8es0zpG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8es0zpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53394C2BD00;
	Tue, 19 May 2026 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204247;
	bh=T2/UZ6X0oL5N+IpYiiuiP8No68KS+6FoVP6cqqxB9Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8es0zpGRVA5bOQn52Ey9+FnokqoG31xtshO7rf2q9VPQ2q3bmUUG1mcJePKSo4c/
	 ydaM9jhSVHOaZYM83+BggOigk3JPqr6lUQtjVSssR+HS5Mb5g/E9y0EwRJJxo7HIa3
	 IPNHj4CnsjghaiSbpL4uSk44+kZ+R+5kJSFISYSXf7upOvLKA5lEkHjVy9ncml9kQW
	 h8cE9VK0MNVxFlpSAdxYig+gQO1FtwkE4JUvhGT2gE0Bfzh4ccrmlWBBkYBRefwkEl
	 PHz5imCLjUxLiPGstfQy7rYVaDF/DxfjSKQAt3T7KuuGUUtyvUZ89lU7z3Fo/mQz1b
	 p3F9zj7SWAwSg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Constrain clocks for newer Qualcomm variants
Date: Tue, 19 May 2026 16:23:03 +0100
Message-ID: <177919680700.851863.10253442471292780349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519074059.61405-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260519074059.61405-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 May 2026 09:41:00 +0200, Krzysztof Kozlowski wrote:
> Many of SMMU on Qualcomm SoCs come in two flavors using the same front
> compatible but a bit different fallback:
> 
> 1. For application processor, usually without any controllable
>    clocks,
> 
> 2. For the Adreno GPU, with some controllable clock(s) and using
>    additionally qcom,adreno-smmu fallback compatible.
> 
> [...]

!! Please note: this conflicted with the Glymur GPU bindings update. That
   was trivial to fix, but I've also queued an update adding
   "qcom,shikra-smmu-500" which you may want in your list of platforms
   where clocks are disallowed?

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Constrain clocks for newer Qualcomm variants
      https://git.kernel.org/iommu/c/75949eb02653

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
