Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2773CC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 10:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6D4340A63;
	Wed,  4 May 2022 10:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Sbg6nyK21st; Wed,  4 May 2022 10:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3C614045C;
	Wed,  4 May 2022 10:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0B5C0039;
	Wed,  4 May 2022 10:38:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9516EC007E
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 10:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75F5D83F0B
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 10:38:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7j91J_MnNys for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 10:38:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5DD28138C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 10:38:27 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id bq30so1605945lfb.3
 for <iommu@lists.linux-foundation.org>; Wed, 04 May 2022 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DYZZJ2RGWR4j938/XSjxsXX/60h4AxrLG5sI5Y987hY=;
 b=fdzBEJ6SFRCb7lwT03+s2FLMl65CCztPC2XYsZgju7u64bW6VBtAKc6qb8q0t4IhWq
 3Q+OdboG897r1ttwSDzTapKM2d5TryFr6PI8YqgF+ASvcbYqlXFFWBpCqX5wUZZL/Bbd
 tLKOZyGvWTeK/fpUurJISfy7107/e5gPxTIW1lhKrDCj0YsqgTIYLErtB6MlRTYt4l60
 oJHaKC5RU+pxgeBZMfl4IeP/Gp08t/+kHHUDI7Hx3/xzaesdZIfZszBFLNojscZ2Phlo
 2GRN97TPy/ss2hMQuIHCp/5JDY1er1uxPrMgD5HHBMImXPYjXab88iUyU7P/rOka/M2Q
 uJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DYZZJ2RGWR4j938/XSjxsXX/60h4AxrLG5sI5Y987hY=;
 b=ureQtbIkk1ACFkPUTpPC5v7YoAzfhqWDS1Z2DihOkPHMuDo8c0K8EISFlXX779JwBK
 UA4Ql1ZFTWl3lqLaQwqHJhpQTbpct3G0+lWxTsrYJokZxn5P0z7FTf9gBgU7eC4tI/ME
 fh8O/y6zhd7WUIKo+VisJUilneYn1wFFFtOZuL/Gml9TDYpq3N3DKutX8ndjzr58KB1C
 34Knfh919hDtADYi7m3KiePxZZQhA45wAxt+zv/KDs9nyhPs+ALSoxx2RaVgf2HGwQfq
 SiF+vE1n2PPE/NKjC4o8cN0pnHpNoiv3HDow/Rbej+2bxWGxsjXTSdeoJOht9QCcxp/m
 ZDbQ==
X-Gm-Message-State: AOAM532y14dBkob/8JkxsgRN0mcdqpYdbUIyfkbTtxFcTQWBRndr2g5W
 xV6b6h6XrUER3UuYigJeLolo4IfzQ4RQnYjk68WU4g==
X-Google-Smtp-Source: ABdhPJxjiemVetoJfIr6tRJ3te8pbVvcqd5V0ltf1SL2oo79ntfHWl46nNgx8/fVPMPOajXBx8ZGY+gKKpTJvr1k/Ds=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr13186045lfo.358.1651660705671; Wed, 04
 May 2022 03:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651480665-14978-3-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1651480665-14978-3-git-send-email-quic_rohiagar@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 May 2022 12:37:49 +0200
Message-ID: <CAPDyKFoJcbbbUEMCX7QyfRLLYPjqnb6UL1QNv8jnh-pWa39EGA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: host/sdhci-msm: Add compatible string check for
 sdx65
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhupesh.sharma@linaro.org, will@kernel.org, linux-mmc@vger.kernel.org,
 agross@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
 adrian.hunter@intel.com, robin.murphy@arm.com,
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

On Mon, 2 May 2022 at 10:38, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Add sdx65 SoC specific compatible string check inside qcom
> 'sdhci-msm' controller driver.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index fd8b4a9..65661ad 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2453,6 +2453,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>          */
>         {.compatible = "qcom,qcs404-sdhci", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sdx55-sdhci",  .data = &sdhci_msm_v5_var},
> +       {.compatible = "qcom,sdx65-sdhci",  .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
> --
> 2.7.4
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
