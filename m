Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941C6FAE
	for <iommu@lists.linux.dev>; Wed, 28 Dec 2022 21:42:39 +0000 (UTC)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id 964ABCB428;
	Wed, 28 Dec 2022 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
	t=1672263276; bh=P7Zg/b7zNWRtK1YhRoeKSV0ZncuTX3zqOfvkP8ZocvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jlfuRHrKhhHdomTKJzvJoOzwZIG6RMbL6HUGhCGxDsDDdlR5wRQrfYCFM9Z+YskjO
	 ByxnoQytPVdCSl/1CrWpsMa7sy4qNwBJgmTImQ4bKW4PTttgH9IWkFCIRgsBSoQMpx
	 SiPr/BsvcbwvfgVxYsflVk2rZ8WRCdtkJFzuSsNo=
From: Luca Weiss <luca@z3ntu.xyz>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5] dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
Date: Wed, 28 Dec 2022 22:34:35 +0100
Message-ID: <4793103.31r3eYUQgx@g550jk>
In-Reply-To: <20221114134458.GD30263@willie-the-truck>
References:
 <20221105142016.93406-1-luca@z3ntu.xyz>
 <20221114134458.GD30263@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 14. November 2022 14:44:59 CET Will Deacon wrote:
> On Sat, Nov 05, 2022 at 03:20:17PM +0100, Luca Weiss wrote:
> > Document the compatible used for IOMMU on the msm8953 SoC.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Changes in v5:
> > * Change subject so it hopefully gets noticed by iommu maintainers
> > 
> >   (thanks Krzysztof, maybe this helps..)
> >  
> >  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt index
> > 059139abce35..e6cecfd360eb 100644
> > --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > @@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
> > 
> >  - compatible       : Should be one of:
> >                          "qcom,msm8916-iommu"
> > 
> > +                        "qcom,msm8953-iommu"
> > 
> >                       Followed by "qcom,msm-iommu-v1".
> 
> I'd expect the MSM maintainers (i.e Andy and Bjorn) to pick this up.

Bjorn, could you pick this up for v6.3 please?

> 
> Will




