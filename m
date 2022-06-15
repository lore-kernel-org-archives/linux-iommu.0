Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C8C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 10:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 867DD402B9;
	Wed, 15 Jun 2022 10:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SgjIdmx8J7tJ; Wed, 15 Jun 2022 10:28:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 160C54028B;
	Wed, 15 Jun 2022 10:28:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3D91C0032;
	Wed, 15 Jun 2022 10:28:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64FB2C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53A3D40489
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uNf7w4dH7F6A for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 10:28:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DFF14017A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 10:28:39 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id x16so7781549qtw.12
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5AvCzV/qAuI7bWpBXxG/Nqj5ArEGXpfhZRBeCyeuUgQ=;
 b=B7T3jGhOh96+HQqjFaBvXx5Qblxeyq2/IWkCavhwANY5BJ082XVB/INkKlWXB2CWjM
 +wlATX9xcmkvr9bgTz9LIjzi1KhAnGxma+tTljwi/THilaWMX8L/THptViEqmg7swLtl
 fAHBVQTt/eqdmjZBVO25k3eDG9BIisH5JsrbFucnPeNMpkXhaPwfwGnLmOVrFXl+8Ax+
 cvcidu0blDozQMvNgEYs/+lcWAc5fKXjB8iIhNAELyHTGRCRP0+LSghteu5x6XPWQu2C
 rqEm8E0t9Z+niFwJvrgoQ5UHrViJRpmS2fEaSLFFWaAL5id2aEXRu/DxAO+EfAcYGtmV
 hdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5AvCzV/qAuI7bWpBXxG/Nqj5ArEGXpfhZRBeCyeuUgQ=;
 b=d9RvLreo7NxqAe2sqFUiMMuzXlh/ehbyljowS+6ojae8hBxoRXVzHf7Yci74eGcauJ
 7MfaBIE4kIEdTh9MQbFS9+3SGrYhaJof02rc2G9jzMKdj5nA3DyTe4/Zmm8n+DOCOq3D
 BF5B1DuFLkf/6J0dbQAG/b/aV7stFJRIrv3x/4fQbA51888qPy5YXRzWhz+HPnc4vasB
 Euy9mHk/SgI31OwzX4Nz4+dsrGBqar/buhVHByAbnYmOSalyB2wKo2ooaHY36L7uRPb2
 PzQCkSrdEDccUubo6mUy8QYiZaUHSAp9T6xYg0kudb37+ODIHzEDxhc6syA1bA53uqkx
 VUAg==
X-Gm-Message-State: AOAM530Kv+bcULq5GcIFlC6bbtwWubP1SHzo6Lc0by2uaDebTWCI0Xe5
 wXDu1oii7WuzHTNMphqWbt1Q2foeSBBuEW8aYLnpVA==
X-Google-Smtp-Source: ABdhPJwt4UdjNNMt5RFrBj0SVHw/NJX+pbEHJb1fSV0Rp+uVukRrCUveQlDV6O8j1EkY3e+RuatpMex07QktOP5CpMg=
X-Received: by 2002:ac8:598f:0:b0:305:8f8:2069 with SMTP id
 e15-20020ac8598f000000b0030508f82069mr8202247qte.370.1655288918492; Wed, 15
 Jun 2022 03:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220614230136.3726047-1-emma@anholt.net>
In-Reply-To: <20220614230136.3726047-1-emma@anholt.net>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 15 Jun 2022 13:28:27 +0300
Message-ID: <CAA8EJpqs8ooZL43gCV=+rR7TdRJhOLrPSBrUfStkZkH4igCL7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Add 8250 display compatible to
 the client list.
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
> Required for turning on per-process page tables for the GPU.
>
> Signed-off-by: Emma Anholt <emma@anholt.net>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d8e1ef83c01b..bb9220937068 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -233,6 +233,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>         { .compatible = "qcom,sc7280-mdss" },
>         { .compatible = "qcom,sc7280-mss-pil" },
>         { .compatible = "qcom,sc8180x-mdss" },
> +       { .compatible = "qcom,sm8250-mdss" },
>         { .compatible = "qcom,sdm845-mdss" },
>         { .compatible = "qcom,sdm845-mss-pil" },
>         { }
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
