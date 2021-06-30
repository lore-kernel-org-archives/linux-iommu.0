Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C9C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 06:27:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CC661D07
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 06:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CC661D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0272606A8;
	Wed, 30 Jun 2021 06:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iz-1_-d06ELJ; Wed, 30 Jun 2021 06:27:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C9A2360894;
	Wed, 30 Jun 2021 06:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A575FC0010;
	Wed, 30 Jun 2021 06:27:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9E33C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AC7D83A7B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f_XuClouT55u for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:27:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1121283A73
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 06:27:16 +0000 (UTC)
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lyTgo-0007Fa-LY
 for iommu@lists.linux-foundation.org; Wed, 30 Jun 2021 06:27:14 +0000
Received: by mail-ed1-f69.google.com with SMTP id
 ds1-20020a0564021cc1b02903956bf3b50cso598186edb.8
 for <iommu@lists.linux-foundation.org>; Tue, 29 Jun 2021 23:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2nkD+uJbpxO3bUeNVNJ06+nPXq3al3hbepVix2nCh4U=;
 b=MiVcVYzg5RVHNiO+UkPXPD0viT0zLMAzJWtv7ia7f/xJkdiBl3/ua9AA5LNL3iElvI
 rIYkQLKJr7VFKv/snfX/GAG17ozRW66kvcrTS7HNDLGOgDetnGsfXHJdMLLOomqRq9Pu
 Qs7lQlNcPKkimsrV5MjSYYqxQDvcsaQYFXKk4ZhO3ueqO9KfRVxXD3QaPQET94VzKJUe
 hbX+JmnXGYBI/KzZyKj5zRmJ/cZemKeU3vM6MHev2gcsSoTqi9ysOk1R/3SQtqcKAGwW
 KH+V0INQBf+ExoYIxols4ixX8vXW3eLGTtZrp40R5tOD8FZRfxQ29uoaUCyuH3l/LjCo
 FboA==
X-Gm-Message-State: AOAM532ob9/wOqnODJ+qK81BfPKCq8c+6XwtlH57hdTNONgTGaSALY4j
 YQwXF8zBnFdG7Swe3vgecXi3pZS2DS7unmJdMgcG6KFJYzCgVm85YyLa4yHFcQWwk7y98dGmkhV
 FRAvabrZ3c8MnguGE/X5g09Gziv5sNMj7qeHjfZ2gx+IBgTs=
X-Received: by 2002:a05:6402:10c3:: with SMTP id
 p3mr42666257edu.175.1625034434319; 
 Tue, 29 Jun 2021 23:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHQKqehToed8G/oeR4lBx7PzBHYBfu1zFW0rHyBt6DYz2r1CNwHTzMzCDFt1S6Up8CIq2JSA==
X-Received: by 2002:a05:6402:10c3:: with SMTP id
 p3mr42666243edu.175.1625034434224; 
 Tue, 29 Jun 2021 23:27:14 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id g8sm2791773edv.84.2021.06.29.23.27.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 23:27:13 -0700 (PDT)
Subject: Re: [PATCH 02/24] dt-bindings: mediatek: mt8195: Add binding for
 infra IOMMU
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-3-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <24f3e157-da9c-d353-e5ae-5dac9e7d9c1d@canonical.com>
Date: Wed, 30 Jun 2021 08:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630023504.18177-3-yong.wu@mediatek.com>
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
> In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
> mainly are PCIe and USB. Different with MM IOMMU, all these masters
> connect with IOMMU directly, there is no mediatek,larbs property for
> infra IOMMU.
> 
> Another thing is about PCIe ports. currently the function
> "of_iommu_configure_dev_id" only support the id number is 1, But our
> PCIe have two ports, one is for reading and the other is for writing.
> see more about the PCIe patch in this patchset. Thus, I only list
> the reading id here and add the other id in our driver.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml         | 14 +++++++++++++-
>  .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
