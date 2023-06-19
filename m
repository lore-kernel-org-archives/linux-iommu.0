Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE814A8B
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 21:50:16 +0000 (UTC)
Received: from g550jk.localnet (unknown [62.108.10.64])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0D633C6A1D;
	Mon, 19 Jun 2023 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
	t=1687210970; bh=3hu0soY9YtA7km69BMGRI2IE7KVXxSt8iu2LEiYvoTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gj7U3cG7k9Fcgl3XhebpEAHFAeaw+vYZ66Dee3gcqkpFUXkk/g74PzshA4fdQRSMU
	 Jk1ttgNaUr373W5d97uOZR/xijnmYXFXOFTu/ICjg3D2yKZv16tYsU/abh+cYDZEoD
	 g0dv8uA7CrBf5x/l07LEpyxgEm6mKc446uPHUMMU=
From: Luca Weiss <luca@z3ntu.xyz>
To: agross@kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, a39.skl@gmail.com, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for Qualcomm's legacy IOMMU v2
Date: Mon, 19 Jun 2023 23:42:49 +0200
Message-ID: <2759637.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <254cfbb5-c8b8-0abc-e6bc-5007fe757004@collabora.com>
References:
 <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <254cfbb5-c8b8-0abc-e6bc-5007fe757004@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 22. Februar 2023 10:57:47 CEST AngeloGioacchino Del Regno wrote:
> Il 15/11/22 11:11, AngeloGioacchino Del Regno ha scritto:
> > This series adds support for handling "v2" firmware's IOMMU, found
> > on at least MSM8956 and MSM8976 (some other SoCs also need the same
> > but I honestly don't remember which ones precisely).
> > 
> > This is strictly required to get functional IOMMUs on these SoCs.
> > 
> > I'm sorry for not performing a much needed schema conversion on
> > qcom,iommu.txt, but I really didn't have time to do that :-(
> > 
> > This series was tested on Sony Xperia X and X Compact (MSM8956):
> > ADSP, LPASS, Venus, MSS, MDP and GPU are happy :-)
> 
> Hello,
> this series is really old and got sent and resent many times.
> The first time I've sent this one was .. I think in 2019, then, at the
> end of 2022, I had some time to actually respin it and send another
> three versions. It's been 3 long years :-)
> The third version got the last comments addressed.
> 
> Since this didn't get any more feedback for 3 months, I'm worried that it
> will be forgotten again, hence:
> 
> Is there any more feedback? Anything else to fix?
> If not, can this be picked, please?

Hi Angelo,

there's some open review comments since March now on this series. Since some 
of these patches are also needed for msm8953 and msm8974 IOMMU it would be 
nice if you could respin :)

Regards
Luca

> 
> Thank you.
> 
> Best regards,
> Angelo
> 
> > Changes in v3:
> >   - Removed useless FSRRESTORE reset and definition as pointed
> >   
> >     out in Robin Murphy's review
> >   
> >   - Fixed qcom,iommu.txt changes: squashed MSM8976 compatible
> >   
> >     string addition with msm-iommu-v2 generics addition
> > 
> > Changes in v2:
> >   - Added back Marijn's notes (sorry man!)
> >   - Added ARM_SMMU_CB_FSRRESTORE definition
> >   - Changed context bank reset to properly set FSR and FSRRESTORE
> > 
> > AngeloGioacchino Del Regno (6):
> >    dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
> >    iommu/qcom: Use the asid read from device-tree if specified
> >    iommu/qcom: Properly reset the IOMMU context
> >    iommu/qcom: Index contexts by asid number to allow asid 0
> >    dt-bindings: iommu: qcom,iommu: Document QSMMUv2 and MSM8976
> >    
> >      compatibles
> >    
> >    iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
> >   
> >   .../devicetree/bindings/iommu/qcom,iommu.txt  |  9 +++
> >   drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 78 +++++++++++++++----
> >   2 files changed, 70 insertions(+), 17 deletions(-)




