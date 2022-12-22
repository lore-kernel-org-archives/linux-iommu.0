Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760B29CA
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 14:47:56 +0000 (UTC)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 44A2C1FFC2;
	Thu, 22 Dec 2022 15:47:54 +0100 (CET)
Date: Thu, 22 Dec 2022 15:47:52 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Message-ID: <20221222144752.2h7huydvbo5zxxtv@SoMainline.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
 <20221222101611.nwt5arux2hcvvtvf@SoMainline.org>
 <bff48e91-3cdc-a052-9573-3c4271f88e5a@linaro.org>
 <20221222133305.txcla3kk6lrqk7sc@SoMainline.org>
 <5025ab98-ecd2-2fa1-adbc-15b4fd6e85b3@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5025ab98-ecd2-2fa1-adbc-15b4fd6e85b3@linaro.org>

On 2022-12-22 15:03:20, Krzysztof Kozlowski wrote:
> On 22/12/2022 14:33, Marijn Suijten wrote:
> > On 2022-12-22 11:36:16, Krzysztof Kozlowski wrote:
> >> On 22/12/2022 11:16, Marijn Suijten wrote:
> >>> Is this missing a cc to linux-arm-msm?
> >>
> >> No, it is not (or maybe but then fix MAINTAINERS). The policy is to use
> >> get_maintainers.pl to CC people.
> > 
> > Yes, that is the question: is it in MANTAINERS and if not, why not?
> 
> You can check by yourself if it is there.

It's not there.

> Why not? I don't know. Could be that no one ever added it there.

Let's leave it like that then :)

<snip>

> > sc7280 has two IOMMU nodes.  One with clocks (should not be in this
> > list), the other doesn't have clocks (should be in this list).
> > 
> > How do you want to address that?
> 
> No, because it is the same compatible.

That is the point.  We can tell them apart based on the presence of
"qcom,adreno-smmu" though.  But if it is not spitting out any errors
right now, let's not bother.

- Marijn
