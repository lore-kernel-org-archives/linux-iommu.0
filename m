Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC44C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 13:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79688C433D6;
	Mon, 14 Nov 2022 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668433506;
	bh=MYstW8SE3ONnJctPeqr+ypLXgBUU9RqG63/tZbCw9f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNm4ryaTUbwZAcb504Qddb3MW7lWhRXZRE7IHgjg8OKOpTUJP+N/9qNeZFC5aFp/g
	 Z3uVIj+iDf5xv++yrZ/mhRnOuJsOimuXnoZs5jFbsMA5rJaivXMX21JudfwynwwQGr
	 F2hQ/l6yDGg3ZXDfEE7LBpGc8pzXNqugX4f5zkX+OMCHxyULeAgZCrpdQHAF1Aak9i
	 uJ3xHKEgvOAEMfcUWyGE+XyeXw3I3C/BGgqvb9+/cdedEmtfcEb/+rv358MX0s/Fas
	 ZW1k9/CMrRWzouPZ9OC7gLBOhhp+1s8tO3Kqld7E6iJn3haiBYY8CnEUAJwgQlRhum
	 wvijOtoWmlFTA==
Date: Mon, 14 Nov 2022 13:44:59 +0000
From: Will Deacon <will@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: iommu@lists.linux.dev, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: iommu: qcom: Add Qualcomm MSM8953
 compatible
Message-ID: <20221114134458.GD30263@willie-the-truck>
References: <20221105142016.93406-1-luca@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105142016.93406-1-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Nov 05, 2022 at 03:20:17PM +0100, Luca Weiss wrote:
> Document the compatible used for IOMMU on the msm8953 SoC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v5:
> * Change subject so it hopefully gets noticed by iommu maintainers
>   (thanks Krzysztof, maybe this helps..)
> 
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> index 059139abce35..e6cecfd360eb 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
>  - compatible       : Should be one of:
>  
>                          "qcom,msm8916-iommu"
> +                        "qcom,msm8953-iommu"
>  
>                       Followed by "qcom,msm-iommu-v1".

I'd expect the MSM maintainers (i.e Andy and Bjorn) to pick this up.

Will
