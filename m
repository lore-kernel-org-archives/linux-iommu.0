Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712F208DC;
	Mon, 13 Nov 2023 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3/cI2De"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C575C433C8;
	Mon, 13 Nov 2023 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699883607;
	bh=NPFv8IDR5Iz2rcH50WIYXqaNrpO/dsM3gH+iAJPH420=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3/cI2DeHdNVzCIdnfdN7Vl0mIHYXVHKb8Rl2hjaiw/qxjNRMbPpoq/wU535DhBEl
	 zt2sryiaj4HrNvbZvdpC1YwT7AIh8R5dIfKQZ8NKJRerLgJ92ZBvCvqXN5r9F8PNnw
	 LSmZQ1hB1A3mXvGa7M5DKqK6dCinBfTweFwAGlT3Ev5FM2KQbdGreMWa5QwGVms4/M
	 ZIjUu/q1POf2swVlmjq2TeNW9cB575o0fdn2rERoiTkk8DeO+wGL9M7/D4hGIbXew6
	 mYMxtTQBePqS0V+4CwHGd1FmNt5qpD/XUV+M9whoprDJq7vyaKb1ceXMIYwAvGTgPi
	 K4uS9o7BeNVbA==
Date: Mon, 13 Nov 2023 13:53:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu: document clocks for the
 SM8350 GPU SMMU
Message-ID: <20231113-shredder-oversold-82a33b5d67d7@squawk>
References: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QZm8CBtXdB5lkCMu"
Content-Disposition: inline
In-Reply-To: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>


--QZm8CBtXdB5lkCMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:45:22PM +0100, Krzysztof Kozlowski wrote:
> Document the clocks for Qualcomm SM8350 Adreno GPU SMMU, already used in
> DTS:
>=20
>   sm8350-hdk.dtb: iommu@3da0000: clock-names: False schema does not allow=
 ['bus', 'iface', 'ahb', 'hlos1_vote_gpu_smmu', 'cx_gmu', 'hub_cx_int', 'hu=
b_aon']
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Docu=
mentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 54c333ddf916..14dc54b0e7b3 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -429,6 +429,30 @@ allOf:
>              - description: interface clock required to access smmu's reg=
isters
>                  through the TCU's programming interface.
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - enum:
> +                - qcom,sm8350-smmu-500
> +            - const: qcom,adreno-smmu
> +            - const: qcom,smmu-500
> +            - const: arm,mmu-500
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: bus
> +            - const: iface
> +            - const: ahb
> +            - const: hlos1_vote_gpu_smmu
> +            - const: cx_gmu
> +            - const: hub_cx_int
> +            - const: hub_aon
> +        clocks:
> +          minItems: 7
> +          maxItems: 7
> +
>    - if:
>        properties:
>          compatible:
> @@ -472,7 +496,6 @@ allOf:
>                - qcom,sdx65-smmu-500
>                - qcom,sm6350-smmu-500
>                - qcom,sm6375-smmu-500
> -              - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
>                - qcom,sm8550-smmu-500
>      then:
> --=20
> 2.34.1
>=20

--QZm8CBtXdB5lkCMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIqUAAKCRB4tDGHoIJi
0nUEAQD8IIFMbwM8e6R5NOOw0fYY48i9PvQQ6lW7B4GAx+6XwAD9HMHYK2k8z3hb
u0X2/zY5HBr11XM53V0ngkrxaTU8Xg0=
=o2U6
-----END PGP SIGNATURE-----

--QZm8CBtXdB5lkCMu--
