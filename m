Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3987AC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 15:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2B7C60D76;
	Wed,  4 May 2022 15:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jF1Y8HgMynsF; Wed,  4 May 2022 15:08:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC57560D74;
	Wed,  4 May 2022 15:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92BB5C0039;
	Wed,  4 May 2022 15:08:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 016D3C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D469661083
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jQf3UeMUPnMk for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:08:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E764D60D74
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:08:41 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id l18so3461432ejc.7
 for <iommu@lists.linux-foundation.org>; Wed, 04 May 2022 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=OvVWFDJHVBQ2gAFb6YOBhaG9PIC2m/VMXu8QQADNdLc=;
 b=ZsTJAqdm18tvarOdlZrUplyaMpMT48eO1YW7m3yfZgW/UzuBzQ/EYGlto1CYFX3vFy
 t9amHZIt1/kbASG/QbevQmMPhD1h+kcKS1Wwlga9uXmY/FmReaG4/qDZemD2p2m9oS8O
 moXPoMXcscuD5b/POKA/BkOKlc9GY2/c9MN4Q7ld2yRoqrGpK15M48iv2SPKGpzJQRZy
 5FJpb+eDExfJRJbSCGZMAapmNhojdD+N5FIhzshM4OL7iu/IxlAO5B92tddt6g0ng0+G
 Cjzcxhpx9iU/EvG7ChlbYQ+OQGQdiYdHilgo+cAL5QO88Y5DPOs/RByJdT/6zLteAvse
 jL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OvVWFDJHVBQ2gAFb6YOBhaG9PIC2m/VMXu8QQADNdLc=;
 b=rjcYYtOLhHD8NI5jCNfw3LZdYPxqmzN+1CIXOgIn11HEoEquqTyo9QzUif9tYzdzyA
 RSuH6fnO2jm6N2i9avkg8GOgQg+3gwP3sAc8uaZrMUNjQFXEWV4YVdIRlqfiAAvue60f
 AgMw0I4hnMPiVKe6w49SS8kTNwaCvcsx6skEvAnsYcUZLxE7LCh/ORtctdDYC+5n/EoF
 /X0ny+RUcUVY/ukj2+i5dkLCOTcfaaveraX98kOJ2j+g2qLeR0KpESb4nAXOB9KIT7sw
 e44ouFGaI1pv9Kb+qVPf9PwlwkPv1v7Ci/xS62XIuqz4ZPj+VVT/fExfXCmeDMR6QrRE
 JNfw==
X-Gm-Message-State: AOAM530/QgrN0R4nvk28IGfjLj85KBlwPtwxY1J2i9xHylYosJQcwJlC
 rynUqz23pMbChuhjS/bcT1NjZQ==
X-Google-Smtp-Source: ABdhPJxmVQA4qV7ej58brqZ2gGQycy2rr2zls5Bx7lvSEtC5wJ7j+/HiJkxyVO+vbZE/6lEnkT3GVA==
X-Received: by 2002:a17:906:c114:b0:6f3:ad4c:c886 with SMTP id
 do20-20020a170906c11400b006f3ad4cc886mr21460881ejc.124.1651676920086; 
 Wed, 04 May 2022 08:08:40 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 l21-20020a056402345500b0042617ba6393sm9202157edc.29.2022.05.04.08.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 08:08:39 -0700 (PDT)
Message-ID: <02b65b74-c37d-0bf6-5cfa-883b20c716ae@linaro.org>
Date: Wed, 4 May 2022 17:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for Qualcomm
 SC8280XP
Content-Language: en-US
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220503163429.960998-1-bjorn.andersson@linaro.org>
 <20220503163429.960998-2-bjorn.andersson@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503163429.960998-2-bjorn.andersson@linaro.org>
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 03/05/2022 18:34, Bjorn Andersson wrote:
> Add compatible for the Qualcomm SC8280XP platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
