Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BBCC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 14:50:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0075F2077C
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 14:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C391F2824;
	Thu, 11 Apr 2019 14:50:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E2AF325F9
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 14:49:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5305BF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 14:49:41 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id EDDBF20D38;
	Thu, 11 Apr 2019 16:49:38 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id BDB8E20C9E;
	Thu, 11 Apr 2019 16:49:38 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: msm8998: Add ANOC1 SMMU node
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <edade219-aa77-e7f0-af68-1c192632b2ca@free.fr>
Message-ID: <b10c2b17-4108-ba09-c56f-079761f3493b@free.fr>
Date: Thu, 11 Apr 2019 16:49:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <edade219-aa77-e7f0-af68-1c192632b2ca@free.fr>
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
	Thu Apr 11 16:49:39 2019 +0200 (CEST)
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Evan Green <evgreen@chromium.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Manu Gautam <mgautam@codeaurora.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411144938.m3TGxnaQc6DAUxXyUKIXoTvd2sjm_wtXhHeLB0ptPVs@z>

+robh, +mrutland for DT

On 01/04/2019 17:40, Marc Gonzalez wrote:

> The MSM8998 ANOC1(*) SMMU services BLSP2, PCIe, UFS, and USB.
> (*) Aggregate Network-on-Chip #1
> 
> Based on the following DTS downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v1:
> 	Split off from "PCIe and AR8151 on APQ8098/MSM8998" series
> 	Change compatible string to use qcom,msm8998-smmu-v2
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index ef71e8f1d102..f807ea3e2c6e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -606,6 +606,21 @@
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		anoc1_smmu: arm,smmu@1680000 {

As discussed with Arnd, this should probably be anoc1_smmu: iommu@1680000

> +			compatible = "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
> +			reg = <0x01680000 0x10000>;
> +			#iommu-cells = <1>;
> +
> +			#global-interrupts = <0>;
> +			interrupts =
> +				<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0x1f40000 0x20000>;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
