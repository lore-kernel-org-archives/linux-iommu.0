Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C822563
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 08:42:20 +0000 (UTC)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D36743EE24;
	Thu, 22 Dec 2022 09:23:54 +0100 (CET)
Date: Thu, 22 Dec 2022 09:23:53 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <andersson@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	Lux Aliaga <they@mint.lgbt>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
 for SM6125
Message-ID: <20221222082353.lhdw7h3pdqyyvsxy@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <andersson@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	Lux Aliaga <they@mint.lgbt>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
 <20221216215819.1164973-2-marijn.suijten@somainline.org>
 <306709f8-7d45-9b76-f95b-1b3088d37a78@linaro.org>
 <6d263321-782d-9d9c-4fdf-8bcf5b280779@linaro.org>
 <20221219192839.6oqialqqw5xw5fxa@SoMainline.org>
 <b4186ec6-a3f2-4dfb-a83e-25cf6d460a39@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4186ec6-a3f2-4dfb-a83e-25cf6d460a39@linaro.org>

On 2022-12-20 10:52:49, Krzysztof Kozlowski wrote:
> On 19/12/2022 20:28, Marijn Suijten wrote:
> > On 2022-12-19 10:09:03, Krzysztof Kozlowski wrote:
> >> On 19/12/2022 10:07, Krzysztof Kozlowski wrote:
> >>> On 16/12/2022 22:58, Marijn Suijten wrote:
> >>>> From: Martin Botka <martin.botka@somainline.org>
> >>>>
> >>>> Document smmu-500 compatibility with the SM6125 SoC.
> >>>>
> >>>
> >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Wait, not entirely... no constraints for clocks and regs?
> > 
> > Quite odd that there is no warning for my DT patch as it clearly
> > requires at least one clock...

Again, any idea why there's no warning for this DT mismatching minItems:
1 for clocks, clock-names and power-domains?

> > Irrespective of that downstream doesn't define any (nor power domains).
> > How should we proceed?
> 
> Binding now has constraints for clocks so at least that should be added
> to your variant.

And that should be:

    clock-names: false
    clocks: false
    power-domains: false

Because this board does declare have any, at least not when going off of
downstream DT?

- Marijn
