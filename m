Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BA61D1754;
	Fri,  6 Sep 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633330; cv=none; b=gkleRJCwYpicxzKgn1UvBTtR6i2KUf1+Y/PBkkwhksJQHJqWzvtZbyTJFRTsvtc2B6ZsfZijNE0zCM+pvxkHy6Xycw/YmK+3vbwTx6QOq7p0ruhpdysY/yMOmhmEDceWqlwiKIxdaNaujc1/r6bSaccb8pe22L5hIB2haDvmCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633330; c=relaxed/simple;
	bh=/u2pu1SmAbLZGcpI5X6lShg6xdqpahZolZVK48gbNTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Etn8DgVgY7fV+fojF+edCEieEXF5oPqXIU+OBhGSpuDGY6C0FxAUlKNKG87Ls7fGw16XU5tODFEg199UXsyxODiy32vbyOItrBHp7AtVXA6kHku8eBH2i0dtfoNZVG8TODCg8FT3+yebLmU2U+5BP3vNN0iYmkWh2o+7MPRIeuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUEEoLcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUEEoLcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB773C4CEC7;
	Fri,  6 Sep 2024 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725633329;
	bh=/u2pu1SmAbLZGcpI5X6lShg6xdqpahZolZVK48gbNTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUEEoLcFEQQ/7/xfCWWtL7CGOHVu37TOZbWxgI+GMNuSmRDnh52CVsO3siFM8ywtc
	 ohbGzO0pEJbAXY/bK/amDRdpWb2+ge2iBy8bYmTAhfkL9Gbu4xfa8Tryq2lzlKlo0N
	 Jnj9FdFKZgfNSFvGeS2Ck4f791bk/lGwPqSg/g3WBoNPm6Ix04hIjNgkakSHFppgpw
	 1gHzdV4PxRrRept203Z2LM+ng4GA5ToDqBkQCwrRzow/5GPXxjuaudKGr4Xq1iCUDJ
	 4/XVr+rUeKl9S6qDaif7jQW0082cqaZcXFAH9a5j8WRl2j0LI9KAHKR5++0fPZ6I67
	 aCl9l2+IcU3ww==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Nikunj Kela <quic_nkela@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com,
	quic_psodagud@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: document the support on SA8255p
Date: Fri,  6 Sep 2024 15:35:18 +0100
Message-Id: <172562657358.407153.3274974734964182940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240905193656.3785537-1-quic_nkela@quicinc.com>
References: <20240905193656.3785537-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Sep 2024 12:36:56 -0700, Nikunj Kela wrote:
> Add compatible for smmu representing support on SA8255p.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: document the support on SA8255p
      https://git.kernel.org/will/c/757c5ceedc69

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
