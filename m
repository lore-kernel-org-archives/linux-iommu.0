Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D718C1A
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 10:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1694600946; x=1694860146;
	bh=Tb4Bg3x5OGpUdHwJymJdAFTJs8535yToLqaPcZ6nlrM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iI3BVFsvok36MtypPZwLNZHlRoLEl3x+HNeh1GSCvGWVjSsb7sZOLiU8au/c6JcUi
	 0PUR+vBVFsc5iDQ+Tws2gEvLOhhSQ37Qs7EGU+K76BatVAiWzxHoEh2MViuPLdb6g+
	 vJ7bnT/CtRMcCL1qqAyaT/Utt7X0jLs2QDDVQdt8kNquBvc32LcY//Ok+35l51cLZl
	 S30RiuCmdXDLw36Uo3LBYyTLXjzJvKP4AsciAOC+Wydu6MspQaK+sCvLx3OckSM9i+
	 HQq2/IND57hmOez/OyulGoedxt3f0KVueFCs1i+yZ43s1JnLvdeFOGueX50ZvA5dXK
	 IPzr6xjI9f6CQ==
Date: Wed, 13 Sep 2023 10:29:00 +0000
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, Alexey Minnekhanov <alexeymin@postmarketos.org>, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 13/14] arm64: dts: qcom: msm8996: Remove PNoC clock from MSS
Message-ID: <3dce9fea-0544-4219-a9fd-520cb0ef0eb2@protonmail.com>
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
> The PNoC clock is a clock for the entire PNoC bus, managed from
> within the interconnect driver. Attaching it to MSS was a total hack.
> Get rid of it and take the liberty to make the clock-names entries
> more readable.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/=
qcom/msm8996.dtsi
> index 7061a8e12c81..51db5ddcef88 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2479,10 +2479,15 @@ mss_pil: remoteproc@2080000 {
>   =09=09=09=09 <&gcc GCC_MSS_GPLL0_DIV_CLK>,
>   =09=09=09=09 <&gcc GCC_MSS_SNOC_AXI_CLK>,
>   =09=09=09=09 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
> -=09=09=09=09 <&rpmcc RPM_SMD_PCNOC_CLK>,
>   =09=09=09=09 <&rpmcc RPM_SMD_QDSS_CLK>;
> -=09=09=09clock-names =3D "iface", "bus", "mem", "xo", "gpll0_mss",
> -=09=09=09=09      "snoc_axi", "mnoc_axi", "pnoc", "qdss";
> +=09=09=09clock-names =3D "iface",
> +=09=09=09=09      "bus",
> +=09=09=09=09      "mem",
> +=09=09=09=09      "xo",
> +=09=09=09=09      "gpll0_mss",
> +=09=09=09=09      "snoc_axi",
> +=09=09=09=09      "mnoc_axi",
> +=09=09=09=09      "qdss";
>  =20
>   =09=09=09resets =3D <&gcc GCC_MSS_RESTART>;
>   =09=09=09reset-names =3D "mss_restart";

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>

