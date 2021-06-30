Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA0C11F69
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 06:26:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C6F61D0D
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 06:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C6F61D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE16B83A70;
	Wed, 30 Jun 2021 06:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3oL_p260I6V3; Wed, 30 Jun 2021 06:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8392683A65;
	Wed, 30 Jun 2021 06:26:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A44DC0010;
	Wed, 30 Jun 2021 06:26:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D26C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 739EE6087F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gA2SDqMaW11A for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:26:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 422B9606A8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:26:37 +0000 (UTC)
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lyTgA-00079p-VP
 for iommu@lists.linux-foundation.org; Wed, 30 Jun 2021 06:26:35 +0000
Received: by mail-ed1-f69.google.com with SMTP id
 y17-20020a0564023591b02903951740fab5so576444edc.23
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eyemzYiirXr0CnEJTypFgf/3fRZK1QJimxbVNA34t0g=;
 b=TVgz7N9ysB5VfkwYrhoIgRnR85I2qwZp6b7yYRarvSfWmFzt6m596lnXksGgf59cx7
 kL9TBrjW5ssi1L3uMlPOTYoS0JydHoSsOEVa3xQjAJ7iqXI+xi01WUO2NZkLoGH7e/Md
 aYCtYsIXmF38P6YOCpczirVImFxXFGL0kZhKmN6GCrVmoOmO8Er5wXHvKvJ5lD7nXQNO
 XbhJyMagYAMGi0pm7GOo8LLGEeTGSSB+LFDoug0np37kg+2RTdjdfVDDD9SgpCXD3J03
 vrEHxzywzy2bkgQkLUFSUP1A8VP3WqU47BG3X+EN6hcH+KjN8VPE9bpR61qOliAiz4oU
 +1xQ==
X-Gm-Message-State: AOAM531tcSftB2sot9wQpyEAjP1BnnspZQTf3tmO5NGOaPGF9NC5SlHx
 HaU3Z7CLfju8S2o9Qj6+xuV0rxv5hGjN2vl28meiowAcgWQoFPR6AXK2L5hY6MxIu2PaRt3Mr+H
 A4z71CJKkLjag13JwJY20/Vs5Q/at+8wAi39uLadDbeDZDNU=
X-Received: by 2002:aa7:cd13:: with SMTP id b19mr3967849edw.45.1625034394744; 
 Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFojo25I4HBBB+CxEut1LzXiJF0o/oIA/Lz3C0qxx65dhOyBiZgSqkJ1gbWex0mUY7C8o8FQ==
X-Received: by 2002:aa7:cd13:: with SMTP id b19mr3967821edw.45.1625034394573; 
 Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id c14sm2792126edr.27.2021.06.29.23.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 23:26:34 -0700 (PDT)
Subject: Re: [PATCH 01/24] dt-bindings: mediatek: mt8195: Add binding for MM
 IOMMU
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <41809d87-0f1b-13fd-b565-26a17626aad9@canonical.com>
Date: Wed, 30 Jun 2021 08:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630023504.18177-2-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

On 30/06/2021 04:34, Yong Wu wrote:
> This patch adds descriptions for mt8195 IOMMU which also use ARM
> Short-Descriptor translation table format.
> 
> In mt8195, there are two smi-common HW and IOMMU, one is for vdo(video
> output), the other is for vpp(video processing pipe). They connects
> with different smi-larbs, then some setting(larbid_remap) is different.
> Differentiate them with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>        |                   |
>   SMI_COMMON_VDO      SMI_COMMON_VPP
>   ---------------     ----------------
>   |      |   ...      |      |     ...
> larb0 larb2  ...    larb1 larb3    ...
> 
> Another change is that we have a new IOMMU that is for infra master like
> PCIe and USB. The infra master don't have the larb and ports, thus we
> rename the port header file to mt8195-memory-port.h rather than
> mt8195-larb-port.h.
> 
> Also, the IOMMU is not only for MM, thus, we don't call it "m4u" which
> means "MultiMedia Memory Management UNIT". thus, use the "iommu" as the
> compatiable string.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   7 +
>  .../dt-bindings/memory/mt8195-memory-port.h   | 390 ++++++++++++++++++
>  2 files changed, 397 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> 

I understand this will go through IOMMU tree. Do you know about any
further patches for memory controllers which will need the header?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
