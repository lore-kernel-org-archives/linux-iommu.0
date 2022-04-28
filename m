Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCC4C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 06:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C65A141803;
	Thu, 28 Apr 2022 06:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksuTez9juowh; Thu, 28 Apr 2022 06:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 33E1E41750;
	Thu, 28 Apr 2022 06:56:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1267CC0039;
	Thu, 28 Apr 2022 06:56:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9C5EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 06:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C316D4011C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 06:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MfuIWTjz6SIx for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:56:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5BF340117
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 06:56:41 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id g6so7650868ejw.1
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=sMmOD7GMEu0/gsFoG9iqyQyFiCKRtOd12iyqG/63olA=;
 b=QOWbX6PH/GWuJhnKuTgq7cjozoP88TYKSMHfYLVvD+t6SpJ1bN/CQ1ebK136Z2NcMD
 ot803Y0xBpZmxiRNBL5lza5CkBU8AZ5PZPk1/TtFiBG5DmbnGnt2nG/IsrovXPFA9qN8
 LfRDMeQ4nAlRXcL4LBUlROGjn6zRLtzhX4y4Qt9KMo7dGL3RBh3C1CvVYiIc769uudqB
 gMawnH1WWU8645kWmBliXd4EQAgUBQn1P/vLlrPAqk5+CvaeJ56dsA+Y3EfWjQz3EYsB
 U1meYTY3gYh6i2aVVnSWgeqZo0O60fRTNNM2FgH3rx8rQv1XpRdMIAOikV/Aa3+2akvg
 Jjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sMmOD7GMEu0/gsFoG9iqyQyFiCKRtOd12iyqG/63olA=;
 b=Q7hMt0FNiSShzLrjaegIEcFI9Um4g+oBy9DdlXDBFGx2y6f+NNCu9YDV9eT4/+Y+xq
 70O6ScpSe2j68l8cevKQeJu6VPROUNIGe3oE34iVVout2URehFwn40jTDCgds39CKDvg
 cumqGXL4HbvvgqBPRLSurWiK+2T4Vm5r0D9kQ3u8my8bjpyqampJuJcoWIsoIcO13DNn
 dLHWBl/8VIq5zkOVsrDcdcjeksLThGqj3zsecFf2Z53U2twd2vXfjApc4xNoIRXmMDpX
 N0EGKPDY0Yxkqxp6aE6Wm/po74ZG27XsJq2ciaC2iz6mnL+qQhjFOKgnfMQjSg8QLkK+
 2Jig==
X-Gm-Message-State: AOAM532cKTYOr4teoK90b6fdTh6MbLlQ7ZEKyypMYaHjSikl/Cuukkdj
 IyS4s+u2fZcXSn0FZh7FB7K3IQ==
X-Google-Smtp-Source: ABdhPJyHs2CcAo3hM0iwJpMnUhMYNDytz03ohxNqhQvdBuPX83AJ83SUKNTfFuzXRtXfHfQT0v91Bg==
X-Received: by 2002:a17:907:6294:b0:6e1:ea4:74a3 with SMTP id
 nd20-20020a170907629400b006e10ea474a3mr29866571ejc.168.1651128999848; 
 Wed, 27 Apr 2022 23:56:39 -0700 (PDT)
Received: from [192.168.0.160] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 m21-20020aa7c2d5000000b0042617ba6395sm1002195edp.31.2022.04.27.23.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 23:56:39 -0700 (PDT)
Message-ID: <4d37f41c-4463-73e4-7271-8d191e9953af@linaro.org>
Date: Thu, 28 Apr 2022 08:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/11] dt-bindings: iommu: arm,smmu-v3: make PRI IRQ
 optional
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220427112528.4097815-1-andre.przywara@arm.com>
 <20220427112528.4097815-2-andre.przywara@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427112528.4097815-2-andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 27/04/2022 13:25, Andre Przywara wrote:
> The Page Request Interface (PRI) is an optional PCIe feature. As such, a
> SMMU would not need to handle it if the PCIe host bridge or the SMMU
> itself do not implement it. Also an SMMU could be connected to a platform
> device, without any PRI functionality whatsoever.
> In all cases there would be no SMMU PRI queue interrupt to be wired up
> to an interrupt controller.
> 
> Relax the binding to allow specifying three interrupts, omitting the PRI
> IRQ. At the moment, with the "eventq,gerror,priq,cmdq-sync" order, we
> would need to sacrifice the command queue sync interrupt as well, which
> might not be desired.
> The Linux driver does not care about any order at all, just picks IRQs
> based on their names, and treats all (wired) IRQs as optional.

The last sentence is not a good explanation for the bindings. They are
not about Linux and are used in other projects as well.

> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/iommu/arm,smmu-v3.yaml           | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> index e87bfbcc69135..6b3111f1f06ce 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -37,12 +37,23 @@ properties:
>            hardware supports just a single, combined interrupt line.
>            If provided, then the combined interrupt will be used in preference to
>            any others.
> -      - minItems: 2
> +      - minItems: 1
>          items:
> -          - const: eventq     # Event Queue not empty
> -          - const: gerror     # Global Error activated
> -          - const: priq       # PRI Queue not empty
> -          - const: cmdq-sync  # CMD_SYNC complete
> +          - enum:
> +              - eventq     # Event Queue not empty
> +              - gerror     # Global Error activated
> +              - cmdq-sync  # CMD_SYNC complete
> +              - priq       # PRI Queue not empty
> +          - enum:
> +              - gerror
> +              - cmdq-sync
> +              - priq
> +          - enum:
> +              - cmdq-sync
> +              - priq
> +          - enum:
> +              - cmdq-sync
> +              - priq

The order should be strict, so if you want the first interrupt optional,
then:
oneOf:
 - items:
    ... 4 items list
 - items
    ... 3 items list

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
