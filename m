Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A145BC433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 20:36:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DCB60FDA
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 20:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46DCB60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BF1E40172;
	Tue, 21 Sep 2021 20:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SX9TKmUPrR0T; Tue, 21 Sep 2021 20:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5264400E9;
	Tue, 21 Sep 2021 20:36:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A60C000F;
	Tue, 21 Sep 2021 20:36:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0B44C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 20:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FD5C401B0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 20:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5OhRcMYT1Xlw for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 20:36:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D81B400E9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 20:36:46 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id w206so1034659oiw.4
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 13:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=74OhYUyeQYysi/TzRlJJ051fes4I/adprkYFLTi5Sdw=;
 b=jJUnUgA9BBsFZu5qhr2t/qVidvNfl5PcIPhFvQ3T1HNbRZkS6y1JR+6C6DVgYwj1m4
 Q9vZ0N+7V8Ecn46f1YOSeqL6objKr8s555aBVR0vaSFc/z3NOG2pHp/UJa4OoNqmCcgw
 YBmkSh+QWZniv/vpx9s8FWEL4L1A2abcG/z5FkPTT/wsP4KDqJVKUCzxmtYuxTTwSp2Z
 98gSRdoMCdmRntwIv4V7W1BEJazAdNBx4xX83qUtxpXb8yn9kGsTMYNwGo58ZDT25aGs
 DFZGwKPEl6jvfgMo3IoS7sJxs/WPal35ZQ6N1/GZkwlXAYxOoKzV544iIpJOr3IQKZKp
 JvAg==
X-Gm-Message-State: AOAM533zoNvPo5XEX0gHZiuKUNAo8/ABD4oVFhbeU+FRqtBfXCwYBY+/
 jhUTWDa1kLTa4caKhqBICw==
X-Google-Smtp-Source: ABdhPJzpj/fzNJ7BMj74jnTQOWdAXExqWcupsGQA5m5n6ary5zeQWefviZyc6aAk8QOZVNYAsL3+Tg==
X-Received: by 2002:a05:6808:1481:: with SMTP id
 e1mr5210840oiw.5.1632256605224; 
 Tue, 21 Sep 2021 13:36:45 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com.
 [192.154.179.36])
 by smtp.gmail.com with ESMTPSA id v19sm16599oic.31.2021.09.21.13.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 13:36:44 -0700 (PDT)
Received: (nullmailer pid 3285894 invoked by uid 1000);
 Tue, 21 Sep 2021 20:36:42 -0000
Date: Tue, 21 Sep 2021 15:36:42 -0500
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 02/13] dt-bindings: memory: mediatek: Add mt8195 smi
 sub common
Message-ID: <YUpCWib8Tpf0wfif@robh.at.kernel.org>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
 <20210914113703.31466-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914113703.31466-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, yi.kuo@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
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

On Tue, 14 Sep 2021 19:36:52 +0800, Yong Wu wrote:
> Add the binding for smi-sub-common. The SMI block diagram like this:
> 
>         IOMMU
>          |  |
>       smi-common
>   ------------------
>   |      ....      |
>  larb0           larb7   <-max is 8
> 
> The smi-common connects with smi-larb and IOMMU. The maximum larbs number
> that connects with a smi-common is 8. If the engines number is over 8,
> sometimes we use a smi-sub-common which is nearly same with smi-common.
> It supports up to 8 input and 1 output(smi-common has 2 output)
> 
> Something like:
> 
>         IOMMU
>          |  |
>       smi-common
>   ---------------------
>   |      |          ...
> larb0  sub-common   ...   <-max is 8
>       -----------
>        |    |    ...   <-max is 8 too.
>      larb2 larb5
> 
> We don't need extra SW setting for smi-sub-common, only the sub-common has
> special clocks need to enable when the engines access dram.
> 
> If it is sub-common, it should have a "mediatek,smi" phandle to point to
> its smi-common. meanwhile the sub-common only has one gals clock.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> change note: add "else mediatek,smi: false".
> ---
>  .../mediatek,smi-common.yaml                  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
