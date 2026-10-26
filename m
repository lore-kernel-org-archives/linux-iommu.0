Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001588;
	b=2QqULoIRnZRJNciNINJcEdWjdav5ainnK1I41bgrBRUieZEaSs/aG9s5TEU6GBx8Er9o
	 ivU5MLOUXV1/BKgAU2ypLubVP4WqDLhbggrwX1KQgbgPdavGcNwAnwpZMGFov3Amj37T2
	 vZef7ppkwNh6j1m5VPMdTG8wn8Q4dewibxOt5aKSk9TNOZcd8rIN0BG9nc132iy3/zkEt
	 fS7dh3fjyhAV/drebwfrPCsPBlouLo5gb93P3otkuAIdV7hC1OPHYwLVX3xEmJPMqUvKj
	 A1F77e6nkiY4eqr92DxIf8NtD0vnoVSE5t+s9mkxPiRPmxWpMg0S4m2NNbKKVrAUSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001588;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Jz2RVofrsAtIuVkB1pB0CwKwnBI0H3nNrAhf+naY36E=;
	b=DAw6VaKiwakEiQOaqqrNVUruF0QvoAWH6lKipanuoei1q36o0XW8tmF8KJLZJEXYAMEx
	 UhWEkG87YIMUWWNgeoJmY8TYXwBaeB6amAmdQNoPoiYDtdTni0ym1gZY7s+BSCFnI94qx
	 RTVSTQ5A5M0pXidQF2lozlSGDcENwykk/DMd7lkD+VaA0jT2+f9ss3JZDBKVndSeS1ncB
	 s0HcZfCGLUjgL6c7ryq6xJ5oHFPv7SVAbXYsrQuKsyxp5rfn5LqPMtazk4HLvNykTlYpe
	 rlcfJNR820lSmjma1HlJOs7h4xra9IvCFilqXIEQdgeSVM6hTxnbSGGt09PH9h4S9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj8NAlyi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE8606A31B;
	Mon, 26 Oct 2026 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj8NAlyi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6665E1F01825;
	Mon, 26 Oct 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793001588;
	bh=Jz2RVofrsAtIuVkB1pB0CwKwnBI0H3nNrAhf+naY36E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bj8NAlyiUfZTNnuTTMA5p0z7NdG0U2ouhcd/3vwUMC6BkldNf/NoXNYh0iMdSEtSO
	 qAj05uP7lp+cDlWFJwMsQkHMgaQLaY1FxD9RAkGAgdCKRCN3gPluyXZ7Fv0f1iBJbI
	 ovgQ+opqdXN1wvoKZnqG37vghiRnXCICHtCpUZIGaF+haZM7v9kMwDyYTCfTkRFksT
	 kAY5smzqueqp/aOZPuz4gvCOIHnORK+m3y6gU4aKsqeNoqfnrnMA8OhNg8AZT3btcH
	 5C6kFt523PT4b3ptSaDGMb8M7RzwSL2Cu0KDLixDLb9+mIVPFGVTl5zkMNO4tBTgL+
	 dKIWKCGua6/qA==
Date: Mon, 26 Oct 2026 08:59:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm-smmu: Document SM7250 SMMU
Message-ID: <20261026-brawny-dashing-bird-5df079@quoll>
References: <20261023-smmu-sm7250-v2-0-8bb881ce19f5@brar.si>
 <20261023-smmu-sm7250-v2-1-8bb881ce19f5@brar.si>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023-smmu-sm7250-v2-1-8bb881ce19f5@brar.si>

On Fri, Oct 23, 2026 at 01:24:31PM +0530, Ishu Brar wrote:
> Document the SMMU found on the Qualcomm SM7250 SoC: the apps SMMU, which
> is an MMU-500 implementation, and the GPU SMMU, which additionally
> carries qcom,adreno-smmu.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

