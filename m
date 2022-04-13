Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0014C4332F
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 03:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 624DC84017;
	Wed, 13 Apr 2022 03:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGH7O4xNZ8rP; Wed, 13 Apr 2022 03:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4EEE083EC1;
	Wed, 13 Apr 2022 03:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A80AC002F;
	Wed, 13 Apr 2022 03:27:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27DD6C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 03:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05F6D40180
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 03:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uQGtffOET0id for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 03:27:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA92940127
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 03:27:17 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-deb9295679so761395fac.6
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dUpDo/QNpCbo5GZEPxRqX5x6FMXpOsSDNvk0dyDtdNE=;
 b=Qoa2SFBc+/cWAU+18k83xzBSnsr6mjIjIKevIRfXjlLAf5wkUT/HB1wyDu+Hh7v3nH
 3CyOtYYpS6fH0ebGk+lemTxWmpGSyXa5hdiHc5909dUCHiR20YfENjYgR527HYEKJPlJ
 yLBN03W/usixM7bZoAyAXcRh/LUcQdbaxhLFBE6JWjlXUqJTvfaMlRweZXeybWZlyqMI
 q8VHX3ej2/m/A9LOET/tHEi2QMLPEVWwjrUiy+1wy9ZdF9vjFWTpYUofk9iP+qcAGifz
 LaoDVGKvmeKHoiMrEWqtYVU/oepepXLfyo9FniBIILSRg10dueSSg5WsBFVaKS3N2xzZ
 oUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dUpDo/QNpCbo5GZEPxRqX5x6FMXpOsSDNvk0dyDtdNE=;
 b=WDoDBUp+OfcomGrBkSIctwJC7AOD3aoI5SjIvlPM36t/yX3N/zjZMMhukU/0XyajgJ
 AjSXj/rf0ZStqdsrEQWnO5NprkxIQKAzjX/R4FYs6Fwy4VxmWUmSQVXH/c4xPHA24BxK
 +qyBe5FG9opvqaM/JHJMqyQSYvKNFEiAe/Bowi118GCPETKy/cK2sT2xh7ljzAnpeea2
 TndGrotw21IVHuJpYZ93or6ZiovO42WB2076KklAuCeTGE46EefmcgCDmh3mMPjMrZAt
 85Hhz+u59dS7bsZhBRYJpMfv4/cEt8Yp3TsqcBvnKJW2WTr5gPmMzSrs/24BNjyxY877
 iIVQ==
X-Gm-Message-State: AOAM531NtfKd5ztVwwrAH7PXdcJ364uEntrbb6u0weTc8XXW5GVmSops
 KDJITeY97Eyw1GyUUA9gtn0zjg==
X-Google-Smtp-Source: ABdhPJydY2hFrfknHiVRaGDlyOcQdWrVsnV9NAvW1aQdEvbPls9I0GRD+D3Gb4XN/CTvQJ56SnYovA==
X-Received: by 2002:a05:6870:e3c1:b0:d7:2dc8:7fd0 with SMTP id
 y1-20020a056870e3c100b000d72dc87fd0mr3535533oad.104.1649820436948; 
 Tue, 12 Apr 2022 20:27:16 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
 by smtp.gmail.com with ESMTPSA id
 o64-20020acad743000000b002ef3b249b9esm13165081oig.58.2022.04.12.20.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Apr 2022 20:27:16 -0700 (PDT)
Date: Tue, 12 Apr 2022 22:27:14 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH v2 7/7] ARM: dts: qcom: sdx65: Add Shared memory manager
 support
Message-ID: <YlZDEk2Z47GoX/jQ@builder.lan>
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649670615-21268-8-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649670615-21268-8-git-send-email-quic_rohiagar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 ulf.hansson@linaro.org, will@kernel.org, linux-mmc@vger.kernel.org,
 agross@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org, robin.murphy@arm.com,
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

On Mon 11 Apr 04:50 CDT 2022, Rohit Agarwal wrote:

> Add smem node to support shared memory manager on SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 210e55c..8fef644 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -113,6 +113,12 @@
>  		};
>  	};
>  
> +	smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem_mem>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};

As you only have the single region, please move the compatible and
hwlocks properties into the &smem_mem node (see sm8450.dtsi in arm64 as
an example).

I've applied the other dts changes.

Thanks,
Bjorn

> +
>  	soc: soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
