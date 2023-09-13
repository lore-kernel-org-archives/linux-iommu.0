Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E83C0F
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1694600715; x=1694859915;
	bh=j2bZUbHn1fYvLLZAU6epHZ10YTHV4Zbb2PaB882T1Us=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nS505dD0/EbnrmYip73Pl4Ik5XTe3GnsP1SIdmtdCjOtSMaQer2JrTDY4QmXBLMX0
	 Ux5Hn+FmKi1Cdu3n5rl0V7NB4H00VAr4LgIACw/2WKzudJ4GsqZVMf03fjH3O8w7YV
	 8gLxI+QaLyVWCckZ5RQx6+gxbeUReMhcIfqmXLT+O9ha8Skyo3VNYw6tm/1Rc9ok94
	 xNSkxpGcKpEUfvMx/dSr1/OKP+MkyC5FfjFyAxKHYKLhnZvChqAslh6m2NBuEeOfsp
	 oJHeFQt+yFpns3Q3VWCHWIIj6uUcEhdHk7qWIoFWb8OwrdztXfPBAwo6Rpb2GlvnNO
	 79HoMuvnqhpuA==
Date: Wed, 13 Sep 2023 10:25:05 +0000
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, Alexey Minnekhanov <alexeymin@postmarketos.org>, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 12/14] arm64: dts: qcom: msm8996: Remove AGGRE2 clock from SLPI
Message-ID: <d72b7d68-afa4-45a4-ab2a-7c86954cde12@protonmail.com>
Feedback-ID: 6882736:user:proton
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/09/2023 4:31 pm, Konrad Dybcio wrote:
> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
> within the interconnect driver. Attaching it to SLPI was a total hack.
> Get rid of it.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/=
qcom/msm8996.dtsi
> index acef67ab0581..7061a8e12c81 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2433,9 +2433,8 @@ slpi_pil: remoteproc@1c00000 {
>   =09=09=09=09=09  "handover",
>   =09=09=09=09=09  "stop-ack";
>  =20
> -=09=09=09clocks =3D <&xo_board>,
> -=09=09=09=09 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -=09=09=09clock-names =3D "xo", "aggre2";
> +=09=09=09clocks =3D <&xo_board>;
> +=09=09=09clock-names =3D "xo";
>  =20
>   =09=09=09memory-region =3D <&slpi_mem>;
>  =20

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>

