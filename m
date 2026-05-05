Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34203D524E;
	Tue,  5 May 2026 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964731; cv=none; b=rBD78d+cp2F0INNoswPewEJlKNvdhP94ELmgHiai20R0pOa7B0AYbEnRpFdodRFctN5E+g6nBVtadk+RYsx8u7yzBGvnI0d05xJwkKxbfnsuonbmNhl/hNwoKUjh0ECecBNqCklKdWybv5gdXhExg+DjyXnovUuadWf3Ke+lk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964731; c=relaxed/simple;
	bh=KeD3hNB1aBViD8XJsMRtJnRNpZcXLtMshug6sI4oWA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5La3rTaG+1QauHCl7rWEzexZBsKxt2zemCOLsZqcAXTNeOoKKfgj3Ch4uFvWBXNIzKL0Li6kmeHHWfiz1j5fQDksnbg5fAZGRCbUzZNJ39mrUKLH+cHJw4C/2ZMXCae1KlKN5AjvOfc0kQlPQ/FNOkdrUru4zb+DaPj+vmBBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iii18oxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iii18oxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ADAC2BCB4;
	Tue,  5 May 2026 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777964731;
	bh=KeD3hNB1aBViD8XJsMRtJnRNpZcXLtMshug6sI4oWA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iii18oxMAJ+ojyRulFwwI0k/BDlMfq5jAFBbOpTCXbj9LoeKnY68zpxwcMlUEuhok
	 VWgRBQ+QbCd24ADxgQi3Nx71QrbsGglVecm2MSLd9lW37+7Rh5JUfKQHTGY59ARsoM
	 WbINrLTr+7E6B0k3Tx2clDYGgd95iMMvEpRKrVYsNQ6IWuhYWV6NF2PfjV4zMAaaYu
	 cxAXm51pWtFTnUT+x79z1Tx4vFKkE+b8vfQgqNMJNSrpAafhMQE6cfAz635xF8Xgtr
	 T9WEnV6StnJC//ir/Ve00gAuHhGvVe60hZU1okxrbZN0lkD5XKEPCQ8h2XffohriXL
	 HaC6W59Jxys5Q==
Date: Tue, 5 May 2026 09:05:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: Add compatible for Qualcomm
 Nord SoC
Message-ID: <20260505-nimble-real-cuttlefish-b62daa@quoll>
References: <20260504080943.825496-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504080943.825496-1-shengchao.guo@oss.qualcomm.com>

On Mon, May 04, 2026 at 04:09:43PM +0800, Shawn Guo wrote:
> Document Applications Processor Subsystem (APSS) SMMU on Qualcomm
> Nord SoC.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
> Changes in v3:
>  - Improve commit log to expand APSS and drop "compatible with" part
>  - Link to v2: https://lore.kernel.org/all/20260427011728.231026-1-shengchao.guo@oss.qualcomm.com/
> 
> Changes in v2:
>  - Improve commit log to make the compatibility explicit
>  - Link to v1: https://lore.kernel.org/all/20260420022452.1239665-1-shengchao.guo@oss.qualcomm.com/
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 06fb5c8e7547..bf29e453058f 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -39,6 +39,7 @@ properties:
>                - qcom,glymur-smmu-500
>                - qcom,kaanapali-smmu-500
>                - qcom,milos-smmu-500
> +              - qcom,nord-smmu-500

This still looks incomplete - device does not have variable number of
clocks. I guess that's reoccuring pattern, so I will fix existing ones.

Best regards,
Krzysztof

