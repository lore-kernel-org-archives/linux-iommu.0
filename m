Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221054C97
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 14:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABE7C433D6;
	Mon, 14 Nov 2022 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668436946;
	bh=zsPHg2CbneKaAfSvj9WkPgYa0y7b09xQojV5FYHP5sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5Qy7Rlxxzy9JFuT/hsrGD7f4hcJbO+ae6+Z61L2DEEAQC8FLT8AzwxSGnRYkjM1L
	 JXl7B816rveuzs3L556r6NgStq28YHhw9aR3ouMRpSOfV7M+4blTngit83vE/8cV8J
	 lF4oqxRF2Zpj3r1LLNx0YVeJZdQ1J1mFbOYFMPhwfA07JK8qs7jNlfMQSUduK/CVii
	 R0XwReJzXGRWDzqx9BGNEPMzg8F8LCpNxP83h/yoVp4tFpJyJp2xY2QKy3KOZYnWTO
	 nu0Nb4qLpiFVTOtyQmLtwu55ms6fwZb5cc3ZIn4Gx58AYlv0PLaOHN/sAWctoQRWZ2
	 lUA80vWx3Wrow==
Date: Mon, 14 Nov 2022 14:42:21 +0000
From: Will Deacon <will@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Melody Olvera <quic_molvera@quicinc.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000
 iommu implementation
Message-ID: <20221114144220.GA31043@willie-the-truck>
References: <20221026190534.4004945-1-quic_molvera@quicinc.com>
 <20221026190534.4004945-3-quic_molvera@quicinc.com>
 <0ae09be0-cb1b-dc27-943b-db64ca97b8c7@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae09be0-cb1b-dc27-943b-db64ca97b8c7@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 14, 2022 at 03:28:15PM +0100, Krzysztof Kozlowski wrote:
> On 26/10/2022 21:05, Melody Olvera wrote:
> > Add compatible for Qualcomm QDU1000 and QRU1000 SoCs to add iommu
> > support for them.
> > 
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index b2708de25ea3..0580a381a04b 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -426,6 +426,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
> >  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
> >  	{ .compatible = "qcom,msm8998-smmu-v2" },
> >  	{ .compatible = "qcom,qcm2290-smmu-500" },
> > +	{ .compatible = "qcom,qdu1000-smmu-500" },
> 
> The patch was applied but it contradicts work here:
> https://lore.kernel.org/all/20221102184420.534094-12-dmitry.baryshkov@linaro.org/
> which explicitly asks not to add such compatibles...

Sure, but we've been adding new compatibles for years so I don't mind
picking up the last few now before we stop accepting new ones.

I already asked Dmitry to respin his series as there are some open comments
from others anyway.

Will
