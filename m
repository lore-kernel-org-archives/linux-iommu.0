Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA6C07E99
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:34:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44268619CE
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44268619CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05C854148E;
	Thu,  8 Jul 2021 09:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWlOrb2wgjAL; Thu,  8 Jul 2021 09:34:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B14B540692;
	Thu,  8 Jul 2021 09:34:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8820DC0010;
	Thu,  8 Jul 2021 09:34:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1A6C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 012BA82B9F
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mOkZOIZz0oxU for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 09:34:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 26692826D6
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:34:09 +0000 (UTC)
Received: from mail-wm1-f72.google.com ([209.85.128.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1m1QQ3-0006cW-9k
 for iommu@lists.linux-foundation.org; Thu, 08 Jul 2021 09:34:07 +0000
Received: by mail-wm1-f72.google.com with SMTP id
 j141-20020a1c23930000b0290212502cb19aso2155555wmj.0
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 02:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E0C7nCPw9ngmgHYShx7ewbeQGAOF1fcpotAi0fhHmT0=;
 b=Q4VCNWPYC2x3jSkGePMW3VBEehlw58RzITilGmFsHohZOx6LlUn0Bp/ufxfIIHBSBa
 vFyHYlTQXSZS0Fcx2nxqq3nMjY5dckaauXq0Kd7aKtNmZfZ598j8AiwRvdgxDRwx1kI0
 8L81ZxQndtkbtauhh2ehjvrL47B32Rq6tp8010G5TcW2qt/558yGtlPmh546QIH1gpf0
 Mr2LpToViV4zhIxBvrU+Qw/OlVUxEkEUnDA04q9v4syeCI74dm6/ImB2y7zwrqp74j+4
 Oz3VwugTo9X18h3uJPQHWrAHIelYOVeOpB1lJwYpDOE6V0T6vFFwc70uxhz8oc1Q16sC
 3OGQ==
X-Gm-Message-State: AOAM531KA2DWXZ/BuwF6390L8nImz9EVmV7SXvTTSP2TN5Upceid9Zuk
 iSO1NFfx8gcPZrR9UqZnAOgJTroErrJH9su2+L9oV4vbp411qT7SvNSRnnXi35u9uIMD/PNdRij
 AGwA2EWsL90QN1BP6VdMtCl1vnZ4r6fW9XWSu9GzlmOd8SoI=
X-Received: by 2002:a05:6000:12c7:: with SMTP id
 l7mr32033337wrx.177.1625736846964; 
 Thu, 08 Jul 2021 02:34:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6b2RvxjwXvMJgFoy20i+dUp4HtIQ58rbfVrXOuRcq9Ho/OovvbcDwRF9C+0n3tuxHzLL9uQ==
X-Received: by 2002:a05:6000:12c7:: with SMTP id
 l7mr32033308wrx.177.1625736846800; 
 Thu, 08 Jul 2021 02:34:06 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id p7sm1637544wrr.21.2021.07.08.02.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 02:34:06 -0700 (PDT)
Subject: Re: [PATCH 4/9] memory: mtk-smi: Rename smi_gen to smi_type
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-5-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a3abe400-4172-4f62-1548-b78b9ec4c157@canonical.com>
Date: Thu, 8 Jul 2021 11:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616114346.18812-5-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
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

On 16/06/2021 13:43, Yong Wu wrote:
> This is a preparing patch for adding smi sub common.

Don't write "This patch". Use simple imperative:
"Prepare for adding smi sub common."

https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L89
 
> About the previou smi_gen, we have gen1/gen2 that stand for the generation
> number for HW. I plan to add a new type(sub_common), then the "gen" is not
> prober. this patch only change it to "type", No functional change.

Same.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
