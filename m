Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90660111E
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 13:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA28C433C9;
	Tue,  1 Aug 2023 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690897801;
	bh=F6qNx1+2DizxHTJiZUKIuy5n3rMNPhTbB7x6ZD0mVPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7ur1W1DVbjmyh5TpwK7GalrpbIf0FUAHrNiu8AEp6T4GFosqyOTFtivu+/VTg3w9
	 LX4IExOlNpV3tkNw2iHoWXXJDtmG+aAAwTrp5pfOkXCUcdm3jR/uAMj1zyKTwIZYZw
	 jdpbDz08IDXaVlsGQQPae1FnpaHpykrgm19mVu0/c858TOsXeJao+Jl7y/Zg8EIMWN
	 9vPXS4yhCtmC7WYU2KmnPn2xH4E7ugbHSTI7k3+4VHG+zfIv44L5HNBNJdE/Mdg/7j
	 DZwAj0pY5YETsSIiwvDXgBrGyTZ04o9o7wsbjnvuaofvZ8JgvFthT78b658xfzaNb+
	 Mlw8GzVOKhcRQ==
Date: Tue, 1 Aug 2023 14:49:54 +0100
From: Will Deacon <will@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: agross@kernel.org, andersson@kernel.org, luca@z3ntu.xyz,
	konrad.dybcio@linaro.org, dmitry.baryshkov@linaro.org,
	joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v5 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
Message-ID: <20230801134953.GA26253@willie-the-truck>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 22, 2023 at 11:27:38AM +0200, AngeloGioacchino Del Regno wrote:
> As specified in this driver, the context banks are 0x1000 apart but
> on some SoCs the context number does not necessarily match this
> logic, hence we end up using the wrong ASID: keeping in mind that
> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
> mandatory that we communicate the right context number.
> 
> Since this is all about how context banks are mapped in firmware,
> which may be board dependent (as a different firmware version may
> eventually change the expected context bank numbers), introduce a
> new property "qcom,ctx-asid": when found, the ASID will be forced
> as read from the devicetree.
> 
> When "qcom,ctx-asid" is not found, this driver retains the previous
> behavior as to avoid breaking older devicetrees or systems that do
> not require forcing ASID numbers.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index a503ed758ec3..8face57c4180 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -531,7 +531,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	 * index into qcom_iommu->ctxs:
>  	 */
>  	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
> +	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> +	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
>  		put_device(&iommu_pdev->dev);
>  		return -EINVAL;
>  	}
> @@ -617,7 +618,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>  
>  static int get_asid(const struct device_node *np)
>  {
> -	u32 reg;
> +	u32 reg, val;
> +	int asid;
>  
>  	/* read the "reg" property directly to get the relative address
>  	 * of the context bank, and calculate the asid from that:
> @@ -625,7 +627,17 @@ static int get_asid(const struct device_node *np)
>  	if (of_property_read_u32_index(np, "reg", 0, &reg))
>  		return -ENODEV;
>  
> -	return reg / 0x1000;      /* context banks are 0x1000 apart */
> +	/*
> +	 * Context banks are 0x1000 apart but, in some cases, the ASID
> +	 * number doesn't match to this logic and needs to be passed
> +	 * from the DT configuration explicitly.
> +	 */
> +	if (!of_property_read_u32(np, "qcom,ctx-asid", &val))
> +		asid = val;
> +	else
> +		asid = reg / 0x1000;
> +
> +	return asid;

Shouldn't we at least have some error checking here? For example, ensuring
that the ASIDs are within range, aren't duplicates etc?

Also, can you elaborate a little more on what sort of ASID-to-Context
mappings you actually see in practice?

Will
