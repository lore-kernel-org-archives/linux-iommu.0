Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C42F49
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 13:07:26 +0000 (UTC)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 78B1B3F356;
	Tue,  4 Oct 2022 14:59:45 +0200 (CEST)
Date: Tue, 4 Oct 2022 14:59:43 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Martin Botka <martin.botka@somainline.org>
Cc: martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Jami Kettunen <jamipkettunen@somainline.org>,
	Paul Bouchara <paul.bouchara@somainline.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: iommu: arm-smmu: Add binding for sm6125
Message-ID: <20221004125943.kifkeq3uugprh6jv@SoMainline.org>
References: <20221001185715.495477-1-martin.botka@somainline.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001185715.495477-1-martin.botka@somainline.org>

On 2022-10-01 20:57:15, Martin Botka wrote:
> This patch adds binding for sm6125 SoC
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..21e15b88bae7 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -41,6 +41,7 @@ properties:
>                - qcom,sdm845-smmu-500
>                - qcom,sdx55-smmu-500
>                - qcom,sdx65-smmu-500
> +              - qcom,sm6125-smmu-500

Shouldn't this be in the list above given that you switched the APPS to
smmu-v2 in
https://lore.kernel.org/linux-arm-msm/20221001185750.495874-1-martin.botka@somainline.org/

Alas, I don't remember which of the two compatibles is correct for this
SoC, since both were seemingly working correctly...

- Marijn

>                - qcom,sm6350-smmu-500
>                - qcom,sm6375-smmu-500
>                - qcom,sm8150-smmu-500
> -- 
> 2.37.3
> 
