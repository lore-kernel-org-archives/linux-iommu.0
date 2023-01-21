Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDB643
	for <iommu@lists.linux.dev>; Sat, 21 Jan 2023 09:42:35 +0000 (UTC)
Received: from g550jk.localnet (unknown [62.108.10.64])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id 51054CC376;
	Sat, 21 Jan 2023 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
	t=1674293646; bh=MqUZTlkDGQQvCi7SGR3c1VPMOPlAAw14WOQqx63RvVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T86pmCXSpo2/Jhgrr7szEYc0oopV5xI5fsJlSQydDtIvrHT+VcUKYGwUG1J/0cd+2
	 oOtk2p83/aRr0gU4TRiGD+aUPCxZm4L16g2auzJVCBBvD0OBKSxW563Agd+Q7Wh/gJ
	 QdKuUwCUgHv/HQLtGC3ldGIiIETlHaxjcN8MGaPM=
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
Date: Sat, 21 Jan 2023 10:34:05 +0100
Message-ID: <2663745.mvXUDI8C0e@g550jk>
In-Reply-To: <20230119172921.GA20092@willie-the-truck>
References:
 <20221105142016.93406-1-luca@z3ntu.xyz> <4793103.31r3eYUQgx@g550jk>
 <20230119172921.GA20092@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 19. J=E4nner 2023 18:29:22 CET Will Deacon wrote:
> On Wed, Dec 28, 2022 at 10:34:35PM +0100, Luca Weiss wrote:
> > On Montag, 14. November 2022 14:44:59 CET Will Deacon wrote:
> > > On Sat, Nov 05, 2022 at 03:20:17PM +0100, Luca Weiss wrote:
> > > > Document the compatible used for IOMMU on the msm8953 SoC.
> > > >=20
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > ---
> > > > Changes in v5:
> > > > * Change subject so it hopefully gets noticed by iommu maintainers
> > > >=20
> > > >   (thanks Krzysztof, maybe this helps..)
> > > > =20
> > > >  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > > > b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt index
> > > > 059139abce35..e6cecfd360eb 100644
> > > > --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > > > +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> > > > @@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
> > > >=20
> > > >  - compatible       : Should be one of:
> > > >                          "qcom,msm8916-iommu"
> > > >=20
> > > > +                        "qcom,msm8953-iommu"
> > > >=20
> > > >                       Followed by "qcom,msm-iommu-v1".
> > >=20
> > > I'd expect the MSM maintainers (i.e Andy and Bjorn) to pick this up.
> >=20
> > Bjorn, could you pick this up for v6.3 please?
>=20
> Since this seems to be stagnating here, I'll pick it up into the smmu
> queue along with the other pending bindings patches I have.

Thanks a lot!

>=20
> Will




