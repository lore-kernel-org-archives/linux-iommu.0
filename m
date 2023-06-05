Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263B1F93A
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 15:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EFBC4339E;
	Mon,  5 Jun 2023 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685979826;
	bh=LzpzvXyyXQzwkwbSAIUoLeJNTmxmMIl7hNCUv+YezGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEXeNhlnAbRnfis4uneWkVDGIAApQq24LkbdjlApCcdmF2u9UZ9gPwEtoKRSBYn3P
	 W42S45nu69RxPfio4wZnLsJlnoa3RqgWdMcfywTnVQ99Khx03M1+SW58TTW+CUFod6
	 9JIz23UQwgAHP/223iyqdDNwykJqS2SRu1LHhy0UnWOAxPSu4Yauw8coJq+XoJX7/Y
	 Q1NJynk5OgSV+DCHUg0Kqy00N+WSOKhDtBmJnVKIz27Vua4pfPyJmCmNkjj9YJs3mo
	 GQ2JJJqWCSZsHobX+7U8YxIAiROvLyS0ASnpHuBq0nq4338R27NZaAJa6L/lGcDwAw
	 1si4ag9Xvy8DA==
Date: Mon, 5 Jun 2023 16:43:39 +0100
From: Will Deacon <will@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>
Subject: Re: [PATCH v5 00/12] SM63(50|75) DPU support
Message-ID: <20230605154338.GC21796@willie-the-truck>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <0fbe5ddb-c3de-0724-fb69-a99e4980b26c@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbe5ddb-c3de-0724-fb69-a99e4980b26c@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 01, 2023 at 03:16:52AM +0300, Dmitry Baryshkov wrote:
> On 23/05/2023 10:46, Konrad Dybcio wrote:
> 
> [skipped the changelog]
> 
> > ---
> > Konrad Dybcio (12):
> >        dt-bindings: display/msm: dsi-controller-main: Add SM6350
> >        dt-bindings: display/msm: dsi-controller-main: Add SM6375
> >        dt-bindings: display/msm: sc7180-dpu: Describe SM6350 and SM6375
> >        dt-bindings: display/msm: Add SM6350 MDSS
> >        dt-bindings: display/msm: Add SM6375 MDSS
> >        drm/msm/dpu: Add SM6350 support
> >        drm/msm: mdss: Add SM6350 support
> >        drm/msm/dpu: Add SM6375 support
> >        drm/msm: mdss: Add SM6375 support
> >        iommu/arm-smmu-qcom: Sort the compatible list alphabetically
> >        iommu/arm-smmu-qcom: Add SM6375 DPU compatible
> >        iommu/arm-smmu-qcom: Add SM6350 DPU compatible
> 
> As we are now nearly ready to merge this series, Will, Robin, what should be
> the merge strategy for these three patches? Would you take them through the
> arm-smmu/iommu tree?

I'm happy to take the three IOMMU changes, but the bulk of this series is
replated to display and GPU so I don't think it makes sense for me to take
those.

Will
