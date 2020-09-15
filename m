Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41559C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 00:42:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D855321655
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 00:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D855321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6BEEE86418;
	Tue, 15 Sep 2020 00:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWBJJBkA+lfG; Tue, 15 Sep 2020 00:42:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8DF2886411;
	Tue, 15 Sep 2020 00:42:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D21FC0859;
	Tue, 15 Sep 2020 00:42:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1DD0C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 00:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DAC3685E8D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 00:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vA8K5umW1x47 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 00:42:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
 [209.85.166.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 28B6D85E03
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 00:42:51 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id y2so1379330ilp.7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 17:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ljTivD9aPg+KhnR32N2OLptR9gt/0CpuWiMcqWyJCeo=;
 b=f9qmjWjhj71nRxexJl7aO4XEzFupmTW/R1d9pMy9e8h9/Fbouh9ESIILz0ehJKstHg
 HhLotleqQNpJTjv305Q4+srZ0bzq7NcqnnH8Y8c5bCCSjwYbycyv3m6zybcTbPQYskLM
 t1NfXEwYKfikWlzCIMaIEh4hhFegP1omv5xtgyeOO3WaCC1Ky9eKhBJ0f1Md1XAeAOh8
 63IFcTU24/F22Q0jVV0MkHCEHcgSfSSBKwomINy5fMQyXpnxUMVzKP5BtPwwqB1YHcyN
 aWesnJ7cbrbsW6ttQfSG9VPpnTsOjJDKyQT+vYYpiJl7+8iVOmqHmpOkl4gdxp8L+74Z
 RQaw==
X-Gm-Message-State: AOAM531ekkl6HmlILMU33ANXMCTv2FfxpBVrZ0XEKnUP8HccN7hTMs/5
 BVlWt23vCavFY1C9QTgNjw==
X-Google-Smtp-Source: ABdhPJzUShX3XEFb2+9+p9Q90jl6hIT+CV75GSpVkzUUmQNVd40GkohHW2eQma8HdTG14EAHPUGGzg==
X-Received: by 2002:a05:6e02:eac:: with SMTP id
 u12mr9654359ilj.285.1600130570492; 
 Mon, 14 Sep 2020 17:42:50 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id m15sm6693979iow.9.2020.09.14.17.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 17:42:49 -0700 (PDT)
Received: (nullmailer pid 591961 invoked by uid 1000);
 Tue, 15 Sep 2020 00:42:45 -0000
Date: Mon, 14 Sep 2020 18:42:45 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 06/23] dt-bindings: mediatek: Add binding for mt8192
 IOMMU and SMI
Message-ID: <20200915004245.GA591931@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
 <20200905080920.13396-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200905080920.13396-7-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, Will Deacon <will@kernel.org>,
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

On Sat, 05 Sep 2020 16:09:03 +0800, Yong Wu wrote:
> This patch adds decriptions for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> mt8192 M4U support 0~16GB iova range. we preassign different engines
> into different iova ranges:
> 
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> 
> The iova range for CCU0/1(camera control unit) is HW requirement.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   9 +-
>  .../mediatek,smi-common.yaml                  |   5 +-
>  .../memory-controllers/mediatek,smi-larb.yaml |   3 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 239 ++++++++++++++++++
>  4 files changed, 251 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
