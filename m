Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23679C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 07:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D46F960C2D;
	Mon, 11 Apr 2022 07:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8bF3nx345qR; Mon, 11 Apr 2022 07:31:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA12860AB5;
	Mon, 11 Apr 2022 07:31:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 856C2C0084;
	Mon, 11 Apr 2022 07:31:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C33AC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A16A4041C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6xKAp_MVV4Lw for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:31:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A04D44029B
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:31:33 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id bo5so13860914pfb.4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FfEzcEDEdqQNmI2+YlsWqpFHuyfIdxXuU7HJ0a4fGQo=;
 b=sI/ocz9wDZjxqQqOzNmUcUDPN9KrGYS3zYDMdkd/sWnqmiDS1qt93vVIsObw85l7D9
 tlheE45On53591S96LiPbVvo19qWHmNxVLuoxaGKXaR5s1I2i1aqGq9aynFgTqH/GYES
 d1591qqOSCVrOLcI1VKeXoNHewXSF/oesLBGcfM+nlrpuYiTX1UiNtBmc9WMNqfrhqaF
 r72BDpgCqppBoyRm+TQetcd0kIhaTKzUj/1uEFHFVxzEJgsLG0Fd/uzUi+9fvZUXQaLx
 vSsSHMG7dmUJfSs9x8IiErIWasoH/m+FWmuFI/Y9Cixwc8l1a4RfKVS/IKeYDRCNx000
 95uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FfEzcEDEdqQNmI2+YlsWqpFHuyfIdxXuU7HJ0a4fGQo=;
 b=3z6NjIqSN2j9YAm3ApHAzU1TUu6pQO5Ms2iNvtklXQ6MHxUHiGboQIXZKXGiAumsg1
 vqd+FjB3IDIylRbLR6ALZlf5tpZsHiJiRoxz+I9LInBw1HIdiF8x+rYsi3f2fM+acn8t
 MaIQxe1zk04/JFSrwswGbjhIqeke/+VlX/XO3W0Ii26MdvBE2QrdR2Du0hyeYvj5IzZl
 lsNi5JMhxBpxx4TaWIbPSEuvMvLO6pV2k/H51tLEX/2B+1FO9+aSSOMuZxasZpt7kSi2
 IPzB4uSpKPRAVmlvZCZZgKOu+GO5P+Mxr+T8RG0UhFKCJaS79NuvAgv5oZvBapE2b4DV
 SgSw==
X-Gm-Message-State: AOAM533u9OBdshVEoKOkWhRkVh8gXlhZMlWjpeNP69awj1PjYdtFFBb9
 eluV0RW4/KJGzzMjqqHLXIwV
X-Google-Smtp-Source: ABdhPJx2Xho7Q5HAaLdf8iiaBePJw/O334cIT0KhKVd34d6Wo1TE9jRJs8qmvQqrP21VT/DmNFOI+w==
X-Received: by 2002:a63:3185:0:b0:39c:c854:34ae with SMTP id
 x127-20020a633185000000b0039cc85434aemr16189345pgx.13.1649662292941; 
 Mon, 11 Apr 2022 00:31:32 -0700 (PDT)
Received: from thinkpad ([117.217.182.106]) by smtp.gmail.com with ESMTPSA id
 a9-20020a056a000c8900b004fb37ecc6bbsm35321318pfv.65.2022.04.11.00.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 00:31:32 -0700 (PDT)
Date: Mon, 11 Apr 2022 13:01:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 3/7] ARM: dts: qcom: sdx65: Add support for SDHCI
 controller
Message-ID: <20220411073124.GC24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-4-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649660143-22400-4-git-send-email-quic_rohiagar@quicinc.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, will@kernel.org, linux-mmc@vger.kernel.org,
 agross@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 11, 2022 at 12:25:39PM +0530, Rohit Agarwal wrote:
> Add devicetree support for SDHCI controller found in Qualcomm SDX65
> platform. The SDHCI controller is based on the MSM SDHCI v5 IP.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 365df74..632ac78 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -168,6 +168,19 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		sdhc_1: sdhci@8804000 {
> +			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x08804000 0x1000>;
> +			reg-names = "hc_mem";
> +			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> +				<&gcc GCC_SDCC1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b210000 {
>  			compatible = "qcom,sdx65-pdc", "qcom,pdc";
>  			reg = <0xb210000 0x10000>;
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
