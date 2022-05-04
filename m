Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B33C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 10:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81F2961066;
	Wed,  4 May 2022 10:38:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvUtnK36_Ixg; Wed,  4 May 2022 10:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 70BEA60A73;
	Wed,  4 May 2022 10:38:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4906EC0039;
	Wed,  4 May 2022 10:38:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EF99C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 10:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4DA1183F0B
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 10:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMauOlfr66r7 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 10:38:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D7F98138C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 10:38:25 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id 4so1105090ljw.11
 for <iommu@lists.linux-foundation.org>; Wed, 04 May 2022 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e0/S6UE8kVYqDNad7z3pjtRuJgpmgvfwcT2yCsHCfEM=;
 b=d6aE1Ig3kJW12Aq8yvux6ub9aoclrmtZQHodl+2SCNC1TTVIXN2a1xcOKMo477nJZM
 SYZJZnn/rjIOvYvEOSZT2kWMjKEd/8O9GrUloItb29+AVGSwuBw0s/OUfTYXbcaMixgr
 YNdnKaRQiFPHQ7yd004TWRlTGlB0KKgMZmgrAK40rawynkvyzNHrt1WmQDTyww2hh6T1
 0b5cqCZJLb3MbtQZRn/PlJnEglVfDAvFBFIL0iCsix5AuCHH0lYC3TxNE4GqR6oPAIeM
 7uvfx97tO7AaevpDLUPVRb3LwkpkblXSYQxj3xyFGg6TspgCo8DqCwfyq7yJZe63eq64
 1jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e0/S6UE8kVYqDNad7z3pjtRuJgpmgvfwcT2yCsHCfEM=;
 b=0V6Bdchv3bj5TbiM3FtgPBRFHg5AO3w1lff6hI9lNL3+k2zCPIgNE7VkFsX4hsdvk0
 LPj5Q29CujoaStKedJMSgVWNMUza/sOOlQ6Tfde0fiF3c8+w060ucFjOEFq8GgWPwhCQ
 i1N9btEvFVmDC7e3GDa9gsmuDw0BVAduE2PapYp3YG623KtFsNYAtL9WJdOTUILX7Q3P
 u8UrsddXWamZQvmM0zSsB8yQ3U4HzsSGezfjntQSqtc+DIxLX1Fd1wTccbzk859qD5sj
 TsunCkhYni7QWStd7QfN0h15PnKmbJCJNF91yAcJypSRFkgbkUPCMQRNxsEedENn1XVI
 /2bA==
X-Gm-Message-State: AOAM533VzNMKxCUwIRSszszd0Ds9E0VX55hZXyU3im/wP8ZBcUTZVr8O
 6KVvBaWRRBuv+xiu3qsehrtELdk+rMVMFALcJZ0e9g==
X-Google-Smtp-Source: ABdhPJxNdFWS/wru3JHuLyOEikz5IC7uPf4QUB9vcB6u578vrjN4goN8ah7xYQTsnbdk4O0TiH3kqranj+niTENGv8M=
X-Received: by 2002:a05:651c:988:b0:24a:c21f:7057 with SMTP id
 b8-20020a05651c098800b0024ac21f7057mr12487369ljq.16.1651660703238; Wed, 04
 May 2022 03:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
In-Reply-To: <1651480665-14978-2-git-send-email-quic_rohiagar@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 May 2022 12:37:46 +0200
Message-ID: <CAPDyKFqmPdzR-RrQUf2bkr6KnSNVUt4uS5Tj31ug+y95ZSXhxA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the SDX65
 compatible
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
> The SDHCI controller on SDX65 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index da42a88..e423633 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -33,6 +33,7 @@ properties:
>                - qcom,sdm630-sdhci
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
> +              - qcom,sdx65-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
> --
> 2.7.4
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
