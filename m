Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60236C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 00:15:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F173961943
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 00:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F173961943
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A012B401F3;
	Mon, 22 Mar 2021 00:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Br1YiR8DqhcS; Mon, 22 Mar 2021 00:15:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 419B4401E6;
	Mon, 22 Mar 2021 00:15:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25F11C000B;
	Mon, 22 Mar 2021 00:15:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 483D3C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 00:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E2B1605C8
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 00:15:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhsYeLPjF5pP for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 00:15:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com
 [209.85.166.180])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12370605A3
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 00:15:43 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id l5so13294140ilv.9
 for <iommu@lists.linux-foundation.org>; Sun, 21 Mar 2021 17:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=2p8ffVaXunSY0rD5RmA2O4dVidEFGcmIDp/dRcWKRlA=;
 b=Tw+XLv/Uab/1rMDWqw56ZZoUzafOaOUONfonESLoIDM1GMGDD4U4h3tSuZeLXlxU0b
 GzI1rQcOk9PBFjY9gjVaWlcZz7LF2ag5Hjef9v4iDtBD7oKEf7zPvVtmXKOc5zdh+KQI
 X+CFETlAFa2UvhX3gLfhKljPSLMeHgYZblKv/mNT9D3FPtAdcE9BCrpGaWfJiAvmjj7O
 SZY/pZM/oWushjhAVGJH5uN81e0SBKyzGDsQtRGq9xyLZWZz5vNhh5ojxIS9UG+6IhaA
 7/CIoVATzNqUWCkOx/MEtt+nxsO7nZ8mPPHpGmPZ22BZHD13dPZto0xwYp6OJzlAfehk
 dFsg==
X-Gm-Message-State: AOAM531maZMVDp9rGaBBLl/hOUB61j43g/mtIvLmfyWgmKXiuGPiSJLH
 AR0j2OQI2ypYti6x8XrTVA==
X-Google-Smtp-Source: ABdhPJym/CCY6jjOTsz3gxOpR8jeyAZaxl8iAnBVd4+RbPKLB/UBSaczZ+zg/E65aTopWIGPitGYeA==
X-Received: by 2002:a05:6e02:13cf:: with SMTP id
 v15mr9627756ilj.118.1616372143214; 
 Sun, 21 Mar 2021 17:15:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id h193sm6809907iof.9.2021.03.21.17.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 17:15:42 -0700 (PDT)
Received: (nullmailer pid 1475029 invoked by uid 1000);
 Mon, 22 Mar 2021 00:15:37 -0000
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
In-Reply-To: <20210320151903.60759-3-sven@svenpeter.dev>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <20210320151903.60759-3-sven@svenpeter.dev>
Subject: Re: [PATCH 2/3] dt-bindings: iommu: add DART iommu bindings
Date: Sun, 21 Mar 2021 18:15:37 -0600
Message-Id: <1616372137.246877.1475028.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Stan Skowronek <stan@corellium.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, 20 Mar 2021 15:20:08 +0000, Sven Peter wrote:
> DART (Device Address Resolution Table) is the iommu found on Apple
> ARM SoCs such as the M1.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/iommu/apple,t8103-dart.yaml      | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iommu/apple,t8103-dart.example.dts:23.25-26 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/iommu/apple,t8103-dart.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1456122

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
