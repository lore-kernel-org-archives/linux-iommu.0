Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14E0C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 07:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 78AF4408F5;
	Mon, 11 Apr 2022 07:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpIuiOwc76Xq; Mon, 11 Apr 2022 07:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6265A408C3;
	Mon, 11 Apr 2022 07:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36A24C0084;
	Mon, 11 Apr 2022 07:34:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA4CC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B476402F8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c7ZC-UYQ-dZc for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:34:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44F2A402C1
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:34:05 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id o5so1915949pjr.0
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iZkMojDEiOG897WMlFg+Va0QtRJHeg2erchkTICMc24=;
 b=hRdTZbnlrYWoBM0S8X6kLUXTF8SNJO5PrmDCFE/DJnzjqJS8PZQGxNejp8OMNXx5Ra
 VB4qMrcyMMDskerI3ElBg/Pfz9IYBoHMSQJCPYscb1SwHNfFoH4xY4I3GQEW5ZPWrChB
 xuV8kHfY6s5Ut/ApM6lYD93p+BCJCX/Dlgez37VfSwOJhk6cLpU9Lt0gcBNR7hjElywR
 WRlAW3OewEjN7PS+Wqh2MW9xLOukNDMbcZ7O68ihL7U3j1puvlYv1wYHKuKlIfsvgFnK
 4xffWmjv/3yXginjUG6tzLvjnvg5Kpx55SmqqMixCVCYYyYg6hu1ZlwQwX9NlunzpMC1
 375w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iZkMojDEiOG897WMlFg+Va0QtRJHeg2erchkTICMc24=;
 b=RJ2Vb7rtiF/M8ezjvh+73eFclpYYQC9N/lbCYXPMwaGjxNYFttAdy35gU56tLY5p0P
 jqrdx/E4Y9+WzPCdmKnUzklcOrRUt6SsZMx5k3tWtUf4rmSeHA+fd3g6OkZ/mflppWjo
 5jNU6IKG4CWYR2xVFCJgXtUFpPOiVPVz14wPnjBiUsdyX7rZKsxwFFCq0InsTEc9lerM
 gHkgS3DLKqIb9jkg54/E4dxylweACqRPplrVunT8uYmhufphb4eb5eimcV2SLep8pu8j
 ED7t0Hp65e5tJkmyL9bVnrgiJYDE9HqCKdrJWHkRx0MIUzFtcydmffiyXMBLqx62Ymyz
 2XKg==
X-Gm-Message-State: AOAM533v/IBLfK1MlTy7QSSKpkS60mpM14jY8osofsrmuJHwnF6NTQIu
 RyiaeqoQCPDPZcvRJx8whCK9
X-Google-Smtp-Source: ABdhPJzAQ1sW5dAp4LbQendoFyZcshYJiDlJIWfSZjsLfFvcCcxYZj5kvAk6DUP9/icLNdM7fDr6bQ==
X-Received: by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id
 z4-20020a170902ccc400b001565d37b42fmr30864306ple.157.1649662444701; 
 Mon, 11 Apr 2022 00:34:04 -0700 (PDT)
Received: from thinkpad ([117.217.182.106]) by smtp.gmail.com with ESMTPSA id
 a21-20020a62bd15000000b00505b8bad895sm3477896pff.106.2022.04.11.00.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 00:34:04 -0700 (PDT)
Date: Mon, 11 Apr 2022 13:03:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 6/7] ARM: dts: qcom: sdx65: Add support for TCSR Mutex
Message-ID: <20220411073355.GE24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-7-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649660143-22400-7-git-send-email-quic_rohiagar@quicinc.com>
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

On Mon, Apr 11, 2022 at 12:25:42PM +0530, Rohit Agarwal wrote:
> Add TCSR Mutex node to support Qualcomm Hardware Mutex block
> on SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 2481769..5c28c94 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -168,6 +168,12 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01f40000 0x40000>;
> +			#hwlock-cells = <1>;
> +		};
> +
>  		sdhc_1: sdhci@8804000 {
>  			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x08804000 0x1000>;
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
