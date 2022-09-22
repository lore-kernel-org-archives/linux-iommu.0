Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C605F2560
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 21:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F10C433D7;
	Thu, 22 Sep 2022 21:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663880941;
	bh=i1G2EpapqGlrX1fXkpTvIIoPLOYCALNxOS7HLc8mTNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzDOPfdigGaZs8keTalK9ypEt7vWJv68KsVi39L167AwpT1mF5FAubNlIjOGdIytP
	 KTjGiJ194xcRfqeXJDJeBi/ZxVJNjo0q1VDV9dksdV5NEdpSwl8+MBBkuUUcXHqBQO
	 iFDPJ4lvSosBK8+DfxZsk9f9utoELX/SnmFCXV3jXCcxYkEizjaCl806FEm3cenjwJ
	 S7pUhbFIjekRLMkknJ+TANX8BepamsHv6224B4p+ULtp4dkzpYSploLXtZbKbVsXBE
	 Dj1Cs4mn0fX77yVdZE3t/xjb2GVt35ctQUQf/55k7bqK/DqoVxy/jg6e5s7sTMdV75
	 EkQGR2YRtfQTA==
Date: Thu, 22 Sep 2022 22:08:56 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org
Cc: robin.murphy@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu-v3: Relax order of
 interrupt names
Message-ID: <20220922210855.GC12945@willie-the-truck>
References: <20220916133145.1910549-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916133145.1910549-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 16, 2022 at 02:31:47PM +0100, Jean-Philippe Brucker wrote:
> The QEMU devicetree uses a different order for SMMUv3 interrupt names,
> and there isn't a good reason for enforcing a specific order. Since all
> interrupt lines are optional, operating systems should not expect a
> fixed interrupt array layout; they should instead match each interrupt
> to its name individually. Besides, as a result of commit e4783856a2e8
> ("dt-bindings: iommu: arm,smmu-v3: make PRI IRQ optional"), "cmdq-sync"
> and "priq" are already permutable. Relax the interrupt-names array
> entirely by allowing any permutation, incidentally making the schema
> more readable.
> 
> Note that dt-validate won't allow duplicate names here so we don't need
> to specify maxItems or add additional checks, it's quite neat.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu-v3.yaml    | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index c57a53d87e4e..75fcf4cb52d9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -39,16 +39,11 @@ properties:
>            any others.
>        - minItems: 1
>          items:
> -          - enum:
> -              - eventq     # Event Queue not empty
> -              - gerror     # Global Error activated
> -          - const: gerror
> -          - enum:
> -              - cmdq-sync  # CMD_SYNC complete
> -              - priq       # PRI Queue not empty
> -          - enum:
> -              - cmdq-sync
> -              - priq
> +          enum:
> +            - eventq      # Event Queue not empty
> +            - gerror      # Global Error activated
> +            - cmdq-sync   # CMD_SYNC complete
> +            - priq        # PRI Queue not empty
>  
>    '#iommu-cells':
>      const: 1

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you take this one directly for 6.1? I don't actually
have any other SMMU patches queued, so it doesn't seem worth sending a pull
request just for this.

Cheers,

Will
