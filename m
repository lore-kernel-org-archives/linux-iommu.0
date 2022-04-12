Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CF3C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 11:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5504561005;
	Tue, 12 Apr 2022 11:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZUPCi4LBCGV; Tue, 12 Apr 2022 11:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44A3D60E61;
	Tue, 12 Apr 2022 11:56:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17899C002F;
	Tue, 12 Apr 2022 11:56:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE3FC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7415560F6B
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q8ileE3mNDyA for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 11:54:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E916260E61
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:54:46 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id u15so18167394ejf.11
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=6udN7p84mQQbGIPlPrTSL/PLuG+dh1guReUObCKNXP8=;
 b=DpJ5xce5z1oKLNoQI5H77n+qFkrR2trfG6eiMK3QQPicwsTlh1LbOMYrgQK2Jwkdwj
 LK4vOsQSTqEtifdm6tfTeWzv5O6laFEG0jqXYJI8aqW9qc8WznM4Wh4ljvA2WY057Y2X
 BOGQY5uI3BLeoeBOdfi3C/KNrD9lwiHjVqr88X5WIDgjNizuqzL4SvOf5YrNCrawGh8A
 sXIlPr21fu2tSAT5DJoGwj0mpoVZPaVDZ20xJ6aJQ94w8uMTA94CkuyR12nglFQ5Ks7w
 RaEhnkEIVS+j23IO68YdoptMq+MMdR6wiU1zJDTfHdQgmNoaxVKVcknvT8kKsjeHBk2v
 d0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6udN7p84mQQbGIPlPrTSL/PLuG+dh1guReUObCKNXP8=;
 b=a904ODov22rrEBNof3NSjY9BEv+5pplxpGt7SyAH+58ZqnJFZjcbvRotCwC8qBeCmV
 IhWYvHCxBa6sHbyddLS0xI2aVdZRL4KuyFFA0J1xB6Q22RLCtJ0k9UCOpSOIWl/5PJF8
 AYJbBYgXg/wM3LGYe3AyZpgFM9OVZw7Lq1S7rLJkJRxGkEtdHiyENP3ipcJw0Ygv1SUb
 7LK/SRjZbowtrTaREWsyUaOUQertI3BruRR7sdRdXQ88uF23fN8XtIdadKngd2gIHZuX
 sEkCLTeGdpBZ1+G7LRPa0W3+OEcRlSxK8Aqfa7UsAKRsaISDoLS17lUevEgbtbZpOjW7
 ziSA==
X-Gm-Message-State: AOAM530ztKWqagxXeBQ+Tdiq9wYwfuwSMdFv2ELSfnXz1CVrCRGsneEx
 SVYQ7N7ONyoxWEzNe2vyO4Ni6Q==
X-Google-Smtp-Source: ABdhPJyJhJm8ZVPk7tw6VD+la4hCwdTsmQiQ9k85Y+ogd6oPi0J+6g0dtxAMCcJdiZDIn+K32a4jtw==
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id
 mp27-20020a1709071b1b00b006e47fac6ce0mr34100414ejc.617.1649764485066; 
 Tue, 12 Apr 2022 04:54:45 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch.
 [188.155.201.27]) by smtp.gmail.com with ESMTPSA id
 u4-20020aa7db84000000b004136c2c357csm16632865edt.70.2022.04.12.04.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 04:54:44 -0700 (PDT)
Message-ID: <1b0c00bd-de0e-3096-556d-4d944e5d9b00@linaro.org>
Date: Tue, 12 Apr 2022 13:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/7] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Content-Language: en-US
To: Rohit Agarwal <quic_rohiagar@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailman-Approved-At: Tue, 12 Apr 2022 11:56:46 +0000
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, manivannan.sadhasivam@linaro.org,
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

On 11/04/2022 11:50, Rohit Agarwal wrote:
> Add devicetree binding for Qualcomm SDX65 SMMU.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
