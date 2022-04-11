Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE89C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 07:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87A8640137;
	Mon, 11 Apr 2022 07:33:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5jfcexii2OF; Mon, 11 Apr 2022 07:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09690415A1;
	Mon, 11 Apr 2022 07:33:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDCD0C0084;
	Mon, 11 Apr 2022 07:32:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA72C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 391FF4041C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U07cBDnxFBn2 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:32:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1B9C4029B
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:32:56 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 mp16-20020a17090b191000b001cb5efbcab6so5311650pjb.4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6Bcipwo2t195QVJFmmzu71Z0FtdQvx0x9uvTartKReE=;
 b=xz0kRGucxrAsw2ENDOBT3/CQ9WGjLIBdTL9q2ce5qSASw2pV2bZWB6F+yDGWkvLf1D
 YxnUb9YnUe3wn7BgQ0ZOs6vfP+ItQdzWbEoFt2nTmyjOi2f5EZx9rJGN94j/ZDnW7zVd
 9pnif/5B0u6JiEal2wcP7UwObcgwinWIvVCjS9xDCU0TV3lbs4LLNddQQPgUsQ4DzFfP
 pXpo0E+nIsC1ZyDewoFR8lVwiGCmGW2zOLmOlaoBMv9TUMGGNHOSBr05gOSU3EeECvDB
 MhJhcKTUGBmoQ0gCOWPkr7M4ZJsmq22zEZ+6KKcDnYoASH4qjp2Te1RbUmyPjBq4PcF5
 Rx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6Bcipwo2t195QVJFmmzu71Z0FtdQvx0x9uvTartKReE=;
 b=WNbkUHPi7oIuPj24Un8cXLRPi/Y9pIrgOFlq4XLgDQwYudqQawXIPB455dvgdhvNuw
 9lFprB9d5b2w6OWYT5tfKyQ9NYgeyEvtdXLVku+mwhHvCMP+bKLU1RL1Jd5TtS+JYmtf
 +AhS8PKLLJdtVWDwc39vo+mZ3mH3fHgNOD40u0KmjK1Q7FIRZ6JUP7Vx085BWVHWe/Sp
 0b9P9DY0rG6DEGxhb2AyvECU5Umu0OTgwFUYhzNjgaIWRCsPudjkO1pXkdc1OKlZXaKh
 lwaxlm8GRvFpX8+ncP4irTkfu0iTJCdpncvGODJ4hEcoUeCiCXPxcO2f3nR0L63wJujX
 X9zQ==
X-Gm-Message-State: AOAM532nfqMiGEQEyGkQTqwAWciVUytPilrK4qxZcwanFG6Ewi2SBlai
 eWtwZRqu0BTSiowekHnYCcyi
X-Google-Smtp-Source: ABdhPJymDSL0wYm7Gy/Y8s9Ov9nZtnJdrl315iiyAsoeZ3s3YHNZuGUWiSY5ZkcV20aurQGIxbOq8A==
X-Received: by 2002:a17:90b:4b0e:b0:1c6:f499:1cc9 with SMTP id
 lx14-20020a17090b4b0e00b001c6f4991cc9mr35475405pjb.133.1649662376064; 
 Mon, 11 Apr 2022 00:32:56 -0700 (PDT)
Received: from thinkpad ([117.217.182.106]) by smtp.gmail.com with ESMTPSA id
 x6-20020a056a000bc600b005058a09f3aesm10186371pfu.147.2022.04.11.00.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 00:32:55 -0700 (PDT)
Date: Mon, 11 Apr 2022 13:02:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 5/7] ARM: dts: qcom: sdx65: Enable ARM SMMU
Message-ID: <20220411073246.GD24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-6-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649660143-22400-6-git-send-email-quic_rohiagar@quicinc.com>
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

On Mon, Apr 11, 2022 at 12:25:41PM +0530, Rohit Agarwal wrote:
> Add a node for the ARM SMMU found in the SDX65.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 632ac78..2481769 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -181,6 +181,46 @@
>  			status = "disabled";
>  		};
>  
> +		apps_smmu: iommu@15000000 {

Please sort the nodes in ascending order.

Thanks,
Mani

> +			compatible = "qcom,sdx65-smmu-500", "arm,mmu-500";
> +			reg = <0x15000000 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
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
