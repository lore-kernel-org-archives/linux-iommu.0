Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DF6C433E0
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 20:13:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAEA20720
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 20:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAEA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A0A0787CB6;
	Thu,  9 Jul 2020 20:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZ_Wi6HMVmiQ; Thu,  9 Jul 2020 20:13:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 120CA87CAE;
	Thu,  9 Jul 2020 20:13:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F094EC0865;
	Thu,  9 Jul 2020 20:13:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7F02C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 20:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A74682DA73
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 20:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZMUZfZDwRfgb for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 20:13:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by silver.osuosl.org (Postfix) with ESMTPS id B96222D82D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 20:13:50 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id k6so3144488ili.6
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 13:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k0op+C2S3aQoquxdFo+HuSbYEJeD5ZxAC+v6vN831a4=;
 b=nlzGVLvgD5fma+LNr+dw6AHIcGA1X5D+0c5WwlmybRs0W9c1rQg3aX9Mf0v16K/FJo
 26XrIW88ADe5kEwczr2Q9kEJIXyHDPZwndNPY+wW+3UEy/7WcxabCG9Mqw/o84m9xhcH
 IPNgHfLU5FsnN3CxkivQhV6wcd7mA4d0R2GapH3/cSyAuuL4kR2xOO6vGQttLu4Ms76R
 4drPppNtaJC6fmlot8a4OceskeBQkYAXSBLTw9zKYwYE4NyBS7xom72E1F7b4vGKvlvk
 iKcdgrR4J9M1zJMcnG5QBu1T+TY1I8Ez9PaCEXkntwSVlL7t4w5JTXy/flm2vQEoJPxJ
 k5kQ==
X-Gm-Message-State: AOAM532PaPg6QKFmqSdH9lNrLExUlEpOdaGdxebBEPAZbe3BVUC5dnlQ
 WptU2z1ZyDlUj5hKVogIBg==
X-Google-Smtp-Source: ABdhPJwN9Tnm2g10urJefbESGH3i3X/kkcFt7HTqUBM8iKFH7AQHI2Y9MXUrD93PD3LlrhQdXnC3sQ==
X-Received: by 2002:a92:cc50:: with SMTP id t16mr48154798ilq.180.1594325629998; 
 Thu, 09 Jul 2020 13:13:49 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
 by smtp.gmail.com with ESMTPSA id c3sm2314843ilj.31.2020.07.09.13.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 13:13:49 -0700 (PDT)
Received: (nullmailer pid 813726 invoked by uid 1000);
 Thu, 09 Jul 2020 20:13:48 -0000
Date: Thu, 9 Jul 2020 14:13:48 -0600
From: Rob Herring <robh@kernel.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v10 4/5] dt-bindings: arm-smmu: add binding for Tegra194
 SMMU
Message-ID: <20200709201348.GA808454@bogus>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-5-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-5-vdumpa@nvidia.com>
Cc: snikam@nvidia.com, devicetree@vger.kernel.org, nicoleotsuka@gmail.com,
 mperttunen@nvidia.com, praithatha@nvidia.com, bhuntsman@nvidia.com,
 will@kernel.org, linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 talho@nvidia.com, iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

On Tue, Jul 07, 2020 at 10:00:16PM -0700, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 SoC SMMU.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d7ceb4c34423..ac1f526c3424 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -38,6 +38,11 @@ properties:
>                - qcom,sc7180-smmu-500
>                - qcom,sdm845-smmu-500
>            - const: arm,mmu-500
> +      - description: NVIDIA SoCs that program two ARM MMU-500s identically
> +        items:
> +          - enum:
> +              - nvidia,tegra194-smmu
> +          - const: nvidia,smmu-500
>        - items:
>            - const: arm,mmu-500
>            - const: arm,smmu-v2
> @@ -138,6 +143,19 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-smmu
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2

This doesn't work. The main part of the schema already said there's only 
1 reg region. This part is ANDed with that, not an override. You need to 
add an else clause with 'maxItems: 1' and change the base schema to 
{minItems: 1, maxItems: 2}.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
