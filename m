Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E3C47425
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 11:10:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DC220719
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 11:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DC220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97C1B86432;
	Fri,  2 Oct 2020 11:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bSpllvYXYDhg; Fri,  2 Oct 2020 11:10:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D67DC86403;
	Fri,  2 Oct 2020 11:10:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFFC7C016F;
	Fri,  2 Oct 2020 11:10:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B060C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 11:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E3BAF273CF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 11:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DeWHBugX5FV0 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 11:10:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id D3BB1204CA
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 11:10:19 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id p9so1394375ejf.6
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 04:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wDTKbdGBT6DJY0L4YlF2VzawALLmfAUZKYoHRF2W8hw=;
 b=KyxAapNSzpRHF5x6ojRccgD7knYN21fU3OhRVIa/pvQs9pbCznuGdwMvfvZjoRtQV6
 8QqGFis7hBce2IQqAVMMa1NyHquyJ7bfkED9AY03QxwQi/d9uPVSZZX0MRGVp5qIfPWN
 JyFQKTSzBYWF5kmcjzllsL9aHTS88A/K5sy05LcrmbHCflpVCa5lBUAcv2AlsVwdQ5H4
 R7H2ti57meTY0bFHv0vvn55NuNXOqrzrT8boJQmP+WTwrd2nOBLKYxzYzjRrIrBp2V58
 zZkaikXlEiSXiSbnXLeaGJmrOx95ZEfaJH4GHJAN4XhZD83o5dBiJUpAV8ebJMQiGcRL
 4oRg==
X-Gm-Message-State: AOAM53308SW5nrD4Ww0zsefENiBYe6ifA64yBrJrn77h6wzreNJJycIx
 W7f7Sqx4hrrfb44l5fuSi8Q=
X-Google-Smtp-Source: ABdhPJyr+lz9aljZjSALIJLlmHUZmvPOwMjCcDNc2vDAAzSqnPdX/49XBEEsx1dw9329gDRVFsjj5w==
X-Received: by 2002:a17:906:2dd7:: with SMTP id
 h23mr302773eji.175.1601637018319; 
 Fri, 02 Oct 2020 04:10:18 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
 by smtp.googlemail.com with ESMTPSA id v25sm906385edr.29.2020.10.02.04.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:10:17 -0700 (PDT)
Date: Fri, 2 Oct 2020 13:10:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 06/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201002111014.GE6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-7-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Wed, Sep 30, 2020 at 03:06:29PM +0800, Yong Wu wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   9 +-
>  .../mediatek,smi-common.yaml                  |   5 +-
>  .../memory-controllers/mediatek,smi-larb.yaml |   3 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 239 ++++++++++++++++++
>  4 files changed, 251 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h

I see it depends on previous patches but does it have to be within one
commit? Is it not bisectable? The memory changes/bindings could go via
memory tree if this is split.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
