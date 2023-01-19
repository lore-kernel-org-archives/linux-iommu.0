Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0116A93E
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 17:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66446C433D2;
	Thu, 19 Jan 2023 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674150234;
	bh=esBoZHarCRcBXHGsNJk462bLB02o1AxAN9bNjEUye3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxGAXbfdIG/R1xqREgWOldwDvC1gw+KtwyNEXQDW8Hx8zJk7TZeqU6yZdXKg9gLzG
	 iKDIYtYnidUdca599t/DIIbhnDHVOX+p9Bpe1YsOCxqXpk9mDo4tZJEj3DBBMmehIp
	 046fhTpxlEtv8H17OO28vX8S15/5BoPAMsqqqL5BC73SMNSUzPSzVfqXIJ5le+vP4G
	 +HGlBRzLx9g/tjNB2FejeaFHP35zKcbIEebde+LhUd7hfhIjsPUpOFd59U3P8C0BuO
	 wqV4Nt9D7HtOjNp8YOLVGXPzjd6Am42PB8/1iBQ9LXfRV3MaNH9fYvr4cxZs5Ov8Or
	 9A7HQxBkGiRhA==
Date: Thu, 19 Jan 2023 17:43:48 +0000
From: Will Deacon <will@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: document the smmu on Qualcomm
 SA8775P
Message-ID: <20230119174348.GA20275@willie-the-truck>
References: <20230112154554.442808-1-brgl@bgdev.pl>
 <20230119173448.GB20092@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119173448.GB20092@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 19, 2023 at 05:34:51PM +0000, Will Deacon wrote:
> On Thu, Jan 12, 2023 at 04:45:54PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Document the qcom,smmu-500 SMMU on SA8775P platforms.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > - rebase on top of Krzysztof's work and add the compatible to the
> >   "clock disallow" list
> > 
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > index 124253e84c02..ea9205706b7c 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> > @@ -36,6 +36,7 @@ properties:
> >            - enum:
> >                - qcom,qcm2290-smmu-500
> >                - qcom,qdu1000-smmu-500
> > +              - qcom,sa8775p-smmu-500
> >                - qcom,sc7180-smmu-500
> >                - qcom,sc7280-smmu-500
> >                - qcom,sc8180x-smmu-500
> > @@ -326,6 +327,7 @@ allOf:
> >                - nvidia,smmu-500
> >                - qcom,qcm2290-smmu-500
> >                - qcom,qdu1000-smmu-500
> > +              - qcom,sa8775p-smmu-500
> >                - qcom,sc7180-smmu-500
> >                - qcom,sc8180x-smmu-500
> >                - qcom,sc8280xp-smmu-500
> 
> I can't get this to apply. Which tree is it against?

Aha, I just needed Krzysztof's patch for the unused clocks. All good now,
thanks!

Will
