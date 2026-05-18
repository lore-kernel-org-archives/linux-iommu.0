Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A540C5D6;
	Mon, 18 May 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107613; cv=none; b=JR/4MaFIYuX5+X5qCwLG6n29gwrKvWX0YwGTbpBAK/UzrlI2CwHsBOhSFXbnRXdx/Dbax+OIA2v+fgoPI0vR9lm+NS4pyPHjwKjOvwqQJVYcoVAzxzxmbXjNV35xyEZhwjdCsC4fZyi9ZwkgAeenbWp7yLVVx9Bu/wmi3eyN6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107613; c=relaxed/simple;
	bh=v3h//Duuy7AHQQ8ShnbJDLW3E+a+LiFjIf5rtx+YwOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twy8+IFDLKe7pN+Yf+hN+V7KhirAceF9Iwqp22pD1mn4XS1f7/2jGUUx+Bfky+vKTtYidPBjJNNxhP1lIAAgZMrgOBo41IAhllwSchUZQYWj6kS6rRzRjLPXZRiMBydMr1UzszHn2iEHy6sWn19eSl3CgPDN5c73qQlj13DrDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPAlED3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPAlED3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14096C2BCFF;
	Mon, 18 May 2026 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779107612;
	bh=v3h//Duuy7AHQQ8ShnbJDLW3E+a+LiFjIf5rtx+YwOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPAlED3RNR9MJ+3qW2zXG2w1+/Oo/0DqssTSaiZl0JdqA8/KoaWu0DzXMU96auN2G
	 h4YTbU81AUFehiocRa1YcuuftQK81BN0RkebW51FjezL1AYfsjtn8Zz2nnh4QjoY44
	 KDy9A5G5LA//5TfwuMIW7DvvwAH1CBPHVghJWBacn3eckm92MbfeWaUBdAGAWdmILT
	 VtBKsaJHXWtc+4VSnGsKZGyPj3lwBP7yv9OaOz43fg0qNE1F1Ez3/vbZL9Dys3kwl8
	 mGzJDwMMDAQ4wkRNlV5/HtAX97YXx2N3REyt+l0TbsEUfySbFg9r6KhikF4ltjHmqS
	 QlpCTFfujwafA==
Date: Mon, 18 May 2026 14:33:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iommu: arm,smmu: Document optional
 interconnects property
Message-ID: <20260518-mellow-robust-caterpillar-93fcaa@quoll>
References: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
 <20260516-smmu_interconnect_addition-v1-1-f889d933f5c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516-smmu_interconnect_addition-v1-1-f889d933f5c1@oss.qualcomm.com>

On Sat, May 16, 2026 at 06:04:03PM +0530, Bibek Kumar Patro wrote:
> Some SoC implementations require a bandwidth vote on an interconnect

Then this should be disallowed for other devices in "allOf:".

> path before the SMMU register space is accessible. Add the optional
> 'interconnects' property to the binding to allow platform DT nodes
> to describe this path.
> 
> The arm-smmu driver uses these properties to vote for bandwidth before
> accessing any SMMU registers and releases the vote on runtime suspend.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 06fb5c8e7547cb7a92823adc2772b94f747376a6..5cbf944f2d3e178b3723d4dbaa19ee0d33446979 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -243,6 +243,15 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  interconnects:
> +    maxItems: 1
> +    description:
> +      Optional interconnect path to the SMMU register space. On some SoCs
> +      the SMMU registers are only accessible after a bandwidth vote has been

Drivers are irrelevant here, drop. Also first sentence is redundant.
Schema says what is and what is not optional.

Best regards,
Krzysztof

