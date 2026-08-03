Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B833DAAB8;
	Mon,  3 Aug 2026 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749095; cv=none; b=QoF9A1Hbr6dA9Z04EZsT0M+jGDbA1ghJzDdUjDq7yfKs5zMnmDN5S3xWbfNWjlJrjIENo7lEUapxEcujG/Ky9EGouRrmvWLlWgFXEXBbtqvmGnE4DhSh7dBEmND6Ngu3e6Bq11xyg/FVhB/jT/LR2MBuMsRoAJ8uP0lRQkqkWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749095; c=relaxed/simple;
	bh=YQYuT1eQUJ5sbgihp/9aDuky6NeB3KIGJ0/tsgnhjIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3fr9biWserAXnQS4aaRWrKc9I2YN8OYyxzTDo/C8Nc/ettkq4MdaGE7arsXZur81pKqU068k9kD31U4Ide+GAem4XSOROiMsjVFsZaZv/zfyGQJG4uEMD3BH3pZMnZunAn6o/urq5ubIImeTLUdzJRRbi3Kwi1AI1k/ZfI/Tso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2FHA2WL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2FHA2WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3121F000E9;
	Mon,  3 Aug 2026 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785749094;
	bh=uyH3qhosLLWNc3FlTO/a9hJUBB7/XU0dA3zhQ3V9g8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S2FHA2WLBpGOYwvhxQ26xqrrS99RC6nBijLDWagQvxTndISOzIlcoSeXZKELvTay0
	 pT/TxUe8bhR3mYgsyVdQCyI0hr5gaJPBIaDk+PlLYZWixKqlS5bhyhG7GlJ31MYnuf
	 1jdFzL//DgDD/Kb2GK1riQDwMCbDBUSQSfYaDy3Rr546Nn+DBzLRbR/jKv7/Qo+oNt
	 72MWSi+uozNa8NxDao3PDtZrqgAKm1qlkc2tPjU7/ZyhNBGB5/UkQAa0cbxx4TG+Rj
	 urQmLBNm+9Wlz+u8UrPbUkzs7V73qg/grslfa6+PX38Q1XPYx9SU2V6ZNN3gXo50oL
	 sO2w1+u0dLtKw==
Date: Mon, 3 Aug 2026 11:24:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: add compatible for
 IPQ9650 SoC
Message-ID: <20260803-therapeutic-coua-of-judgment-5c6cdf@quoll>
References: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 11:01:26AM +0530, Kathiravan Thirumoorthy wrote:
> Add the compatible string for the APPS SMMU present on the Qualcomm
> IPQ9650 SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Changes in v2:
> - Add the proper constraints - no clocks needed for IPQ9650
> - Link to v1: https://patch.msgid.link/20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com
> 
> To: Will Deacon <will@kernel.org>
> To: Robin Murphy <robin.murphy@arm.com>
> To: "Joerg Roedel (AMD)" <joro@8bytes.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index f2188942f877..ffa33b7f4a96 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -38,6 +38,7 @@ properties:
>                - qcom,eliza-smmu-500
>                - qcom,glymur-smmu-500
>                - qcom,hawi-smmu-500
> +              - qcom,ipq9650-smmu-500
>                - qcom,kaanapali-smmu-500
>                - qcom,maili-smmu-500
>                - qcom,milos-smmu-500
> @@ -625,6 +626,7 @@ allOf:
>                  - qcom,eliza-smmu-500
>                  - qcom,glymur-smmu-500
>                  - qcom,hawi-smmu-500
> +                - qcom,ipq9650-smmu-500

This will disallow clocks also for the Adreno one, so confirm that it
also does not have clocks.

Best regards,
Krzysztof

