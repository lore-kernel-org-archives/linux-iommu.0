Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100C2C43217
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 14:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E0A061017;
	Tue, 12 Apr 2022 14:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azLknwU_XP5e; Tue, 12 Apr 2022 14:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B93B60F16;
	Tue, 12 Apr 2022 14:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7088FC0033;
	Tue, 12 Apr 2022 14:26:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C924EC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A795C41487
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IXBFy3149XEX for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 14:26:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F1A7410B8
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:26:11 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id b21so4789347ljf.4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o9Y0Dxo+q6yQbzDxJ/ULmzM1Yxju629VRSmpegysqN8=;
 b=twWeTn+wbEgNDoLKArv4PJZiTp6oZnld1mH8i8kfifUjKs0iQRcaZ+kHoABKm7/Scd
 3US+3G/CYRtfNcu/VWgVjD/mESRcSvcIiq5CsdjiRaS38+bj+pDt7bnKHFiZZyy820Iy
 aZmrwQNZT0Cu/zCKNZ/XbB/VTX3yMBgV3zXiAj/E2WNiWAicWfSc75KIq+78hwogMpYJ
 ar+m0WvCjAayOJzwqk4Bqj093B/gBIHVlORyh3lXABeP2HsUVwwix5DW5QTogpeQrC+D
 CGX3bGHd2uSBpxWDWvtTv2aV5r8qht5nyXVwZlMD8pbXO7nAPZ1j77itunZ4WducbwKT
 zxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o9Y0Dxo+q6yQbzDxJ/ULmzM1Yxju629VRSmpegysqN8=;
 b=y17MZXgo3GWG9YohJV5P3FJaHLeOYxJofmRp1XqBBXui6NLrqORvVpVfDQ2Zx/VZG0
 FdMFQHucJFF/dw3LZZfW+6nB+XkXoSFm+eizSn9VTCrrjMQYnUUfCoF6kOAfUC+ZABwq
 45y0yfZBTNCF3Fn1HgmRkxOCbCVw1Iw9K8SS69AocZR2eTsxj6EhZeKBlZwfVy2RrVp+
 vta7eAIW4NxEXFXRGeFMM7J2xPuQBTJ7DIGRVvqJvnDq0z3tIeg0HDVBRm4vhiZHQKec
 X4FB+ngxGav2HqRudvVg2DNKOEeLY0khMuX+3PgbJDbuHGXcWumq2dWZzEhy/JTzh/bE
 h0cw==
X-Gm-Message-State: AOAM530Dsn1z1KFmSQdXBB7ZIZJtZ41VewTUX3RsguupRAQJ/94Bi/Eq
 Qe1Lh9Q5oWsRzMuMmfgGfZU7aRqhmLPAhtWlhH9JzQ==
X-Google-Smtp-Source: ABdhPJyaj7tFxdrLYCr2zY8LfreX76pb3X9XmGkW2cSHqy2L9vVwR4doSIMzzrLhQfMLm15Cp7vZ1XdvlfGpOmv0uxY=
X-Received: by 2002:a2e:3e05:0:b0:24b:5df0:6388 with SMTP id
 l5-20020a2e3e05000000b0024b5df06388mr8356865lja.367.1649773569043; Tue, 12
 Apr 2022 07:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649670615-21268-3-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1649670615-21268-3-git-send-email-quic_rohiagar@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Apr 2022 16:25:32 +0200
Message-ID: <CAPDyKFrU0hQzs3xL8Jf1E22cS9DWuorLgcVF9+m80+Osw8=odg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: mmc: sdhci-msm: Document the SDX65
 compatible
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, will@kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org,
 manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org, robin.murphy@arm.com,
 Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
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

+ Shaik, Bhupesh


On Mon, 11 Apr 2022 at 11:50, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

As stated in a couple of other threads for patches extending these
bindings, I would really like to see the binding being converted to
the yaml format first.

It seems like Bhupesh is working on the conversion [1]. If not, please
help him to get this done.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-arm-msm/msg107809.html

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 6216ed7..e7dec8a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,6 +25,7 @@ Required properties:
>                 "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
>                 "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string
> --
> 2.7.4
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
