Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22AC4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 21:45:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA316102A
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 21:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFA316102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C04660635;
	Tue, 17 Aug 2021 21:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZyBrGa-dlrd; Tue, 17 Aug 2021 21:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 65C58605F8;
	Tue, 17 Aug 2021 21:44:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2460DC0010;
	Tue, 17 Aug 2021 21:44:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B26EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 21:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9150A80D27
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 21:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a7Qdx5YDpfOl for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 21:44:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0BBC80CAF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 21:44:55 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 m11-20020a056820034b00b0028bb60b551fso83301ooe.5
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 14:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tJbXJaO1S8CDBHolXnG0pNdqRsTOC5L9HS9uoBlFyko=;
 b=nb6cMU3vkm2PQ5bFsTdeszfr0yEO3z4pRA4OVDKWOwMjGqrxW+AzhdaNHAdM3uJ2Op
 dx8jKHQBU6RCoRTUkDr2yecalBhC5etk33OD6kG+Wld9tYvcHRPupB/FO2703wbyDaFI
 XotMdaQCXTImEhym451xtuYQvH5v4GjVRJSNbsQTM987oF1UOpvAx9nU9hfjTwMV1mMR
 3HZtmq/JTm2LcXykG6yOEm1S1L7lchExeOSQGxMIEv8K6WgRKYOCq3Pv0Pkeww/W+kjx
 fGrpmdPGBGSEhadK4E2AqGnss/DJb5GgUyUzAZAaXYpsXRSulqbcGV2gkPK2dt5oVhcQ
 MRag==
X-Gm-Message-State: AOAM533Xy4PtmxodHfpliat18/5LeCCZdEEcjA/at/bmrO15kUOlqKlO
 HBeuPXTHn90qWEOoEGWWag==
X-Google-Smtp-Source: ABdhPJwR5dd5wQ/YDvk31PYwnhKCj+LV9fYj+okbAgVw5jhjaeHzx9gGBJxGwPQRMUTxP3PjUVi0XQ==
X-Received: by 2002:a05:6820:61b:: with SMTP id
 e27mr4117053oow.68.1629236695061; 
 Tue, 17 Aug 2021 14:44:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id k16sm668797oor.16.2021.08.17.14.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 14:44:54 -0700 (PDT)
Received: (nullmailer pid 894487 invoked by uid 1000);
 Tue, 17 Aug 2021 21:44:53 -0000
Date: Tue, 17 Aug 2021 16:44:53 -0500
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 02/29] dt-bindings: mediatek: mt8195: Add binding for
 infra IOMMU
Message-ID: <YRwt1f6UBL0zoxF4@robh.at.kernel.org>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210813065324.29220-3-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Tomasz Figa <tfiga@google.com>,
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

On Fri, 13 Aug 2021 14:52:57 +0800, Yong Wu wrote:
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
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> Change note: use "contains" commented from Rob.
> ---
>  .../bindings/iommu/mediatek,iommu.yaml         | 13 ++++++++++++-
>  .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
