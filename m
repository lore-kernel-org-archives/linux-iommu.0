Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C234C433E4
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 20:51:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE95020672
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 20:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE95020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 96E6426EC8;
	Wed, 15 Jul 2020 20:51:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMd47w9p6nr8; Wed, 15 Jul 2020 20:51:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5D3E0204D3;
	Wed, 15 Jul 2020 20:51:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB51C0891;
	Wed, 15 Jul 2020 20:51:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E864C0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 20:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D30A882F6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 20:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXEYdiuXaxWx for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 20:51:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D69A088529
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 20:51:22 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id k23so3723169iom.10
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 13:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q9ACE8nvrxYAkV7UmkgZ6sY12qZMuGAXz/YkNp21cP8=;
 b=sPZGLtxwz0n+m0IxUC/RtyEJNLy8p/3pmmoCHLStY2WTQJFnE/g9RES2lXI0tjiO8x
 JXEvtKV4eJQb7/Fy55MssJV/7BRYzGjno4e1FgLuTLOpA0VU6LhgHfXS87oLPIUISbwp
 bi3TjyUfGN6K3tsRJ/VcBkMbjdFO5urvICaL1nLoa9Qed7q5GPt7poTnR1p9Psc5h59h
 FMDbjqYiRnUvD27tf6LAggHC1T1Wgy44Y8EwV5dLr5lqEs7jRTpeRqnpDe7nf0KVS6OR
 z1kTUg56glfcWCIFfF6EuhDPBmNDS9iaJvcqQ/8A64weYDF3alNzbz5hoMF0W2eR18Nu
 SxkA==
X-Gm-Message-State: AOAM532R+0jUoC45cGcymvcJnxCMsgNovJCCeF8qIkAovTHTntKTd9OS
 /KB0TwKHVefgGFbhtaVXbg==
X-Google-Smtp-Source: ABdhPJwJgZBHTochu4o5lfkCZewGDWCyBkruv1P6g3YXlsJ82fsfdRZEt+/xHnCbpv9RpaMjsjLcFw==
X-Received: by 2002:a6b:4409:: with SMTP id r9mr1160938ioa.158.1594846282053; 
 Wed, 15 Jul 2020 13:51:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id s18sm1576592ilj.63.2020.07.15.13.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 13:51:21 -0700 (PDT)
Received: (nullmailer pid 795410 invoked by uid 1000);
 Wed, 15 Jul 2020 20:51:20 -0000
Date: Wed, 15 Jul 2020 14:51:20 -0600
From: Rob Herring <robh@kernel.org>
To: Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: mediatek: add mediatek,infracfg phandle
Message-ID: <20200715205120.GA778876@bogus>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702093721.6063-1-miles.chen@mediatek.com>
Cc: devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, Jul 02, 2020 at 05:37:17PM +0800, Miles Chen wrote:
> Add a description for mediatek,infracfg. We can check if 4GB mode
> is enable by reading it instead of checking the unexported
> symbol "max_pfn".
> 
> This is a step towards building mtk_iommu as a kernel module.

You determined this before without DT, so it is an OS problem and 
shouldn't need a DT update.

I'd assume there's only one instance of the node mediatek,infracfg 
points to, so just search for it if you want to get the info from DT.


> 
> Cc: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> index ce59a505f5a4..a7881deabcca 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -74,6 +74,8 @@ Required properties:
>  - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
>  	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
>  	according to the local arbiter index, like larb0, larb1, larb2...
> +- mediatek,infracfg: a phandle to infracfg. It is used to confirm if 4GB mode is set.
> +	It is an optional property, add it when the SoC have 4g mode.
>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>  	Specifies the mtk_m4u_id as defined in
>  	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> -- 
> 2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
