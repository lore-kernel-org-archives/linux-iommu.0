Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B7C43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 10:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC2E76066D;
	Wed, 15 Jun 2022 10:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z91iVo2GWFzd; Wed, 15 Jun 2022 10:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA23D607C1;
	Wed, 15 Jun 2022 10:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD48C0032;
	Wed, 15 Jun 2022 10:28:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B80C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E21FD83E16
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Em0E8UgT9_N6 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 10:28:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F7F783E12
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:28:24 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id f13so7816519qtb.5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VRRIXOfBq1yQuH5EfBFqRJA+XF3LzpkQlfmJRxNlHxM=;
 b=eTPtLP4NDpa8P0aI9dKapfMCGv9h90H8cChydbnDbXwDM3c9dFce+zWip7UvMIpzAj
 MwWt4NSMWMqrTbGPwJOf7l27KNudx15eMZzj6SyR4Zlj5OpOoagmM2K/3bI+5LT3Niyi
 h1vN0EW/aD3emP+jNz1Zcr7cozm+JkmhQecbNLlW+mU39R/LAtqcL2ahfL9sPHZJmXtA
 n+McjAPLlSceH+/folG8esKMX+j5OcZkgls4MZ7OITX1SzUtIIuFxa5K+LPw/fz8Cv5V
 vwmBMQsLsRdxHoNvxi45kD3Ty/9jaUWcXcCG6j3dwqXXCZ+czmFsSDp+cv482KfCuh2i
 qjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VRRIXOfBq1yQuH5EfBFqRJA+XF3LzpkQlfmJRxNlHxM=;
 b=Oc5QPGe9qOZMCKqwmiDjM0FRKGmDA2kx3uTE2AzUA/BguMSAFV/lzHjkUaccheQ5VJ
 lDEHFNCuUFvbmH7+nJ7WubaojDJxwf78QvaUZflRPlmG1zsukWDfB6fuMoP/uDEKZinw
 d/wBLJ5JfRfXI1SXiajxWh3/+Wj6NN0XbfvZyTDRWTAdJEbvaqyu306oAkewVXRhCOVg
 sU4wE2vH5R7T1KrqRg+ffyIEq72r2vqJ6PdegmacB3iDuRZZJAq8Hn9dMXtD7wQj2rPC
 a9woLEEBsn+MiS6IqE6HwHX3iuhgPMKWBHknzvpVxQbgKcV6lNamPvvjnVcxsPBD0Tsg
 Twtw==
X-Gm-Message-State: AOAM531vM7NfmsbBd9mXqswaPBlTqTSqPeHd8EL0fB6DUVeasDZiZvY1
 410fO8b6cl7GB0VQh1B562ID/w+A7xyFHFJAUejwKw==
X-Google-Smtp-Source: ABdhPJzgorGZ/k2s8/OSl6pg37NaKBcKW1yennvKVAegxKpGmun7X2J8lIgtj5Inxl+I5AXypY0S3fE/EQB34TCAN80=
X-Received: by 2002:a05:622a:1351:b0:305:2e58:939 with SMTP id
 w17-20020a05622a135100b003052e580939mr7765424qtk.295.1655288902992; Wed, 15
 Jun 2022 03:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220614230136.3726047-1-emma@anholt.net>
 <20220614230136.3726047-2-emma@anholt.net>
In-Reply-To: <20220614230136.3726047-2-emma@anholt.net>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 15 Jun 2022 13:28:12 +0300
Message-ID: <CAA8EJpo=vLmsBRo16_xfbSdfFGvR1ocyuXm=2mqRR-9wyUESvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Enable per-process page
 tables.
To: Emma Anholt <emma@anholt.net>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
 dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, 15 Jun 2022 at 02:01, Emma Anholt <emma@anholt.net> wrote:
>
> This is an SMMU for the adreno gpu, and adding this compatible lets
> the driver use per-fd page tables, which are required for security
> between GPU clients.
>
> Signed-off-by: Emma Anholt <emma@anholt.net>
> ---
>
> Tested with a full deqp-vk run on RB5, which did involve some iommu faults.
>
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a92230bec1dd..483c0e0f1d1a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2513,7 +2513,7 @@ gpucc: clock-controller@3d90000 {
>                 };
>
>                 adreno_smmu: iommu@3da0000 {
> -                       compatible = "qcom,sm8250-smmu-500", "arm,mmu-500";
> +                       compatible = "qcom,sm8250-smmu-500", "arm,mmu-500", "qcom,adreno-smmu";

I see that other dtsi files use a bit different order for the
compatibility strings. They put "qcom,adreno-smmu" before
"arm,mmu-500". Can we please follow them?

With that fixed:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>                         reg = <0 0x03da0000 0 0x10000>;
>                         #iommu-cells = <2>;
>                         #global-interrupts = <2>;
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
