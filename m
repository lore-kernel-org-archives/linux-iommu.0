Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48291C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 06:44:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E5161184
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 06:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4E5161184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A55B240714;
	Wed, 22 Sep 2021 06:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6faKvr7VNwPt; Wed, 22 Sep 2021 06:44:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C15B406D5;
	Wed, 22 Sep 2021 06:44:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32F96C0011;
	Wed, 22 Sep 2021 06:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04D1BC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 06:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5C854020A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 06:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjxtMWeTyyzE for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 06:44:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5606C400DB
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 06:44:42 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5EB90402D9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 06:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1632293079;
 bh=PHpWlL5286L9Vy7vwwtJJDOqUvt0lVJtNPWSRo8nnkI=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=X2tPR+GdMJEYpgN/lUT3nmnkcPVIYTt3aKblh1AYZR++NEA0fisxxTNEBo/xlggv+
 lPbS2lVmNuPPzXA/hLNj1pLCfhqLSAeyJYBmz3WuBPZ3SAmTsSnOH2MzVdiCljIlVc
 6zwToe9Mb4hckB429xPBWIJQY3MzGhteM3SXMY33sz8I9COX1AYafL6xHVCCY55aow
 qXGpoakfdhJ3D4t55/vo83PSgyq9QnhPZ+AEeI5u/NKWmfyBLNPu60LQySzYml9uXK
 jmkJstHdpkgSf9koyCKB6GqJvaZ02RAiSXaTF1SfNjgd5o3PHEneyLKBSl3EfoEgLJ
 3tEGlHxEbvTUA==
Received: by mail-wr1-f70.google.com with SMTP id
 u10-20020adfae4a000000b0016022cb0d2bso1147346wrd.19
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 23:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PHpWlL5286L9Vy7vwwtJJDOqUvt0lVJtNPWSRo8nnkI=;
 b=Ip6owkpEgS7aA/laoNb3wGLnOGQQ6ZVByKLLyWvKEyZj7lVZWAIFO/tYybfxsdf5OE
 KsJ98E/xrJCBnuwWZ3AXEDXLSYXFEqVLOLdb99pvuvBNukizg5uPBjvNKA1KNq4YtEf+
 o9QZSNUFOeRf5k/NuvoDh4AiKrG/1MYBNVHpDS//+DVzDCEPSgqMvNem4pinvsZE73p8
 rsIaKp5zu0JmvjLXLctMhKHGTSjj4h+dyb/jv73zlMVTOjVlRG1STbUh1piIdMeLulc2
 CAu/Z579ds7TSdU4gWSMQiuBfHpqY4RZW2OA2GUMUgf6leSwYoTjM4ysgdJc/7Ri5c2r
 /ZJA==
X-Gm-Message-State: AOAM532lWZMbeVNFToCE6SevIaUGBRggLyxM5WJ6xxWGDtv28O8h33mU
 mlpVlNu7Y8FS2Fp+4uI8S8+EDvJUbiGuVbv/ySFLXRvLQ8r+ReeyLY9cVxft0nIpvWIx8rYmoyY
 4FqBdoGtagzYK1v9Iy/PYzcvwWWHiXNSkBIYFZzVt9s2MfUk=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr40411590wrb.237.1632293079027; 
 Tue, 21 Sep 2021 23:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7X/xE8BOJMFBcSLMZa3NNLNdKake1etQzDd7PnPQEF6xSjGfjlZkAQpczOFislXeA7hs9uQ==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr40411555wrb.237.1632293078867; 
 Tue, 21 Sep 2021 23:44:38 -0700 (PDT)
Received: from localhost.localdomain
 (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
 by smtp.gmail.com with ESMTPSA id g2sm1244554wrb.20.2021.09.21.23.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 23:44:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 00/13] MT8195 SMI support
Date: Wed, 22 Sep 2021 08:44:01 +0200
Message-Id: <163229303729.7874.4095337797772755570.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
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

On Tue, 14 Sep 2021 19:36:50 +0800, Yong Wu wrote:
> This patchset mainly adds SMI support for mt8195.
> 
> Comparing with the previous version, add two new functions:
> a) add smi sub common
> b) add initial setting for smi-common and smi-larb.
> 
> Change note:
> v4:1) base on v5.15-rc1
>    2) In the dt-binding:
>       a. add "else mediatek,smi: false." in the yaml.
>       b. Remove mediatek,smi_sub_common. since we have only 2 level currently,
>       It should be smi-sub-common if that node has "mediatek,smi". otherwise,
>       it is smi-common.
> 
> [...]

Applied, thanks!

[01/13] dt-bindings: memory: mediatek: Add mt8195 smi binding
        commit: b01065eee432b3ae91a2c0aaab66c2cae2e9812d
[02/13] dt-bindings: memory: mediatek: Add mt8195 smi sub common
        commit: 599e681a31a2dfa7359b8e420a1157ed015f840b
[03/13] memory: mtk-smi: Use clk_bulk clock ops
        commit: 0e14917c57f9d8b9b7d4f41813849a29659447b3
[04/13] memory: mtk-smi: Rename smi_gen to smi_type
        commit: a5c18986f404206fdbc27f208620dc13bffb5657
[05/13] memory: mtk-smi: Adjust some code position
        commit: 534e0ad2ed4f9296a8c7ccb1a393bc4d5000dbad
[06/13] memory: mtk-smi: Add error handle for smi_probe
        commit: 30b869e77a1c626190bbbe6b4e5f5382b0102ac3
[07/13] memory: mtk-smi: Add device link for smi-sub-common
        commit: 47404757702ec8aa5c8310cdf58a267081f0ce6c
[08/13] memory: mtk-smi: Add clocks for smi-sub-common
        commit: 3e4f74e0ea5a6a6d6d825fd7afd8a10afbd1152c
[09/13] memory: mtk-smi: Use devm_platform_ioremap_resource
        commit: 912fea8bf8d854aef967c82a279ffd20be0326d7
[10/13] memory: mtk-smi: mt8195: Add smi support
        commit: cc4f9dcd9c1543394d6ee0d635551a2bd96bcacb
[11/13] memory: mtk-smi: mt8195: Add initial setting for smi-common
        commit: 431e9cab7097b5d5eb3cf2b04d4b12d272df85e0
[12/13] memory: mtk-smi: mt8195: Add initial setting for smi-larb
        commit: fe6dd2a4017d3dfbf4a530d95270a1d498a16a4c
[13/13] MAINTAINERS: Add entry for MediaTek SMI
        commit: 93403ede5aa4edeec2c63541b185d9c4fc9ae1e4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
