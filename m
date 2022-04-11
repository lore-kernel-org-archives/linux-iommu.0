Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A9C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 07:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ECB283E30;
	Mon, 11 Apr 2022 07:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASg4_Bt0sv7P; Mon, 11 Apr 2022 07:30:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6588583E0B;
	Mon, 11 Apr 2022 07:30:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 265B7C0084;
	Mon, 11 Apr 2022 07:30:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F420DC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D239760BBF
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6muh6bQdKJAf for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:30:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6E3960AB5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:30:14 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 s14-20020a17090a880e00b001caaf6d3dd1so17560672pjn.3
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Uoh+5w2FgxHInN7CbCfRJ6Q2aacclOIxcqG3PNif+Zw=;
 b=gtKjjh2ETnixhTITydnZTFhqZignJ2uRgWkCFRy3W5TFg+Px0zK+Q0lyDIWstXUBok
 d/H2oITXryoLemFXT9D9rnKh5FpHIAlunMf/hXFsJdEqcKD2IjJre7AUEj1T5aNRg8uj
 MvePwFuTKCFm0jCEW4egwcicD8uL8DT4QMFCuwvnW5qQmMWO+darhKYGEWLIFkL19FAJ
 eItP5SDxXLNf1Z/uQbzmpQOdm77HLinRnmZeErinPaMhljD/u1ux4/Q71RSgJ3mPX+/8
 A/1BdMHxqjb56H/UMUblA5k79uh0tL/ce4ttNFK6kUsKMmYQv2oSE9VPSJlPnofKRaml
 29MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Uoh+5w2FgxHInN7CbCfRJ6Q2aacclOIxcqG3PNif+Zw=;
 b=wKWmygVDQQ116wlhmIZn83GU8d20ObcpVbtCwrgQp8obPQ9M6WMQlbXZ7u9DZfAk9n
 oPCCnQCCxMHKJER/eSRyma1MS6aZtMbfeX/wdE4x1gnsfmsVzoOWwNvhRaKDXekJKGyY
 /oiXusLhktJb1DtZnSoZiTghZD1c+E+YK/MdNF/HFS/hb1oKHu9I4N1IydMrl9SyiYQo
 W+nhIyS7+z4N61RQb2Kl9fF2gfQrd2kzFhbmMQ1Jv2g6OVkMg4mfj3vZZAvLdH5CDqUO
 YbkFIC9gUjqpkW6QR2/mflyZau3n9ohL/AGlwO9kZ+N/JnODV5MQglZFLtpNKBPO3bOK
 cVLA==
X-Gm-Message-State: AOAM533Bvn0I8XQM9ODjP9DaBPOnZgi61HdfSswW8ZYtqE/y5UZv3CMA
 BASZbGXE1nj8WDrqRtspzy+A
X-Google-Smtp-Source: ABdhPJygvM3jQ3jaVw0+r0xd6u8Q896A5b6KJejsyKga7jtU0Kt77d6eULc8Qw+p4MptIaTHDQrBTg==
X-Received: by 2002:a17:90a:b10c:b0:1cb:9e27:5005 with SMTP id
 z12-20020a17090ab10c00b001cb9e275005mr4222480pjq.241.1649662214084; 
 Mon, 11 Apr 2022 00:30:14 -0700 (PDT)
Received: from thinkpad ([117.217.182.106]) by smtp.gmail.com with ESMTPSA id
 rj13-20020a17090b3e8d00b001c77bc09541sm19665923pjb.51.2022.04.11.00.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 00:30:13 -0700 (PDT)
Date: Mon, 11 Apr 2022 13:00:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 1/7] ARM: dts: qcom: sdx65: Add reserved memory nodes
Message-ID: <20220411073004.GB24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649660143-22400-2-git-send-email-quic_rohiagar@quicinc.com>
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

On Mon, Apr 11, 2022 at 12:25:37PM +0530, Rohit Agarwal wrote:
> Add reserved memory nodes to the SDX65 dtsi as defined by
> the memory map.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 21 +++++++++++++++++
>  arch/arm/boot/dts/qcom-sdx65.dtsi    | 45 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index ad99f56..5d51cc4 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -23,6 +23,27 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mpss_dsm: mpss_dsm_region@8c400000 {

Node name should be generic. So please use "memory@" here and below.

Thanks,
Mani

> +			no-map;
> +			reg = <0x8c400000 0x3200000>;
> +		};
> +
> +		ipa_fw_mem: ipa_fw_region@8fced000 {
> +			no-map;
> +			reg = <0x8fced000 0x10000>;
> +		};
> +
> +		mpss_adsp_mem: mpss_adsp_region@90800000 {
> +			no-map;
> +			reg = <0x90800000 0x10000000>;
> +		};
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 7e2697f..365df74 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -66,6 +66,51 @@
>  			reg = <0x8fee0000 0x20000>;
>  			no-map;
>  		};
> +
> +		secdata_mem: secdata_region@8fcfd000 {
> +			no-map;
> +			reg = <0x8fcfd000 0x1000>;
> +		};
> +
> +		hyp_mem: hyp_region@8fd00000 {
> +			no-map;
> +			reg = <0x8fd00000 0x80000>;
> +		};
> +
> +		aop_mem: aop_regions@8fe00000 {
> +			no-map;
> +			reg = <0x8fe00000 0x20000>;
> +		};
> +
> +		access_control_mem: access_control_region@8fd80000 {
> +			no-map;
> +			reg = <0x8fd80000 0x80000>;
> +		};
> +
> +		smem_mem: smem_region@8fe20000 {
> +			no-map;
> +			reg = <0x8fe20000 0xc0000>;
> +		};
> +
> +		tz_mem: tz_mem_region@8ff00000 {
> +			no-map;
> +			reg = <0x8ff00000 0x100000>;
> +		};
> +
> +		tz_apps_mem: tz_apps_mem_region@90000000 {
> +			no-map;
> +			reg = <0x90000000 0x500000>;
> +		};
> +
> +		tz_heap_mem: tz_heap_region@8fcad000 {
> +			no-map;
> +			reg = <0x8fcad000 0x40000>;
> +		};
> +
> +		llcc_tcm_mem: llcc_tcm_region@15800000 {
> +			no-map;
> +			reg = <0x15800000 0x800000>;
> +		};
>  	};
>  
>  	soc: soc {
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
