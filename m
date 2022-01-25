Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580FCC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 13:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B72C60B5B;
	Tue, 25 Jan 2022 13:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zhpP_Ddni5Y0; Tue, 25 Jan 2022 13:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EDE9D60B0C;
	Tue, 25 Jan 2022 13:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0C76C0039;
	Tue, 25 Jan 2022 13:19:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A146EC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 816614028D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6D1rioxi3WhR for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E9BD40277
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:19:43 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A76A3F1C9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1643116780;
 bh=7H+kwmtltVSBKx5eHk33vYDBjpgrbeevYoDgB27H+CI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=lokDWwC6CE9N/xXzBGFrWAkmoqIQt5tP7uAgs8+EQzRKp0ED6fVN7Yef4QIMOp97s
 jg2KVzr9h3dwoISj8WO9mPnp96YT9boiNcoBnXQO950r8/CZpAlUus8yi8n+LGtF3i
 oAwUTJtNhwVj6iBUj+i1rbjs6IRf911/cqtZE5b8ucyfbVsGZXmCBUnMXAWeRCimE2
 a7sci0pgBRa3gkm4s3ruBSCz60GiTcN+4thtK38rH/XyqgDwSTG7U73L72FA1w96Vu
 F43EV44S/rx6aDf5H44SsC1tvZHxFefhyDagpqG1mjO8BZHwwYzKicBzTViBvqQFcL
 oZNxRZzxV7F5w==
Received: by mail-wm1-f72.google.com with SMTP id
 w5-20020a1cf605000000b0034b8cb1f55eso1232283wmc.0
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7H+kwmtltVSBKx5eHk33vYDBjpgrbeevYoDgB27H+CI=;
 b=4WJZCvP+xzMFKpDCp4gwm30XsixIcXCHvjvsdY1mQBsEwFYO0Ashnx/O24UpZXEVZO
 OH5joxN43WQdl7IGeuoWZSvPXMn6La5Eq4jbIAYQCmUZpmou8YOSZIX5un68UdTLB6+W
 GJuyLZZt5QuXYBkvdLLcBxZombtCkU74wW10tgmcCeAK/3d8uvxPdjciOULVlpSyzH5D
 9IjQgsnzEnNBnSQncyWYlnp8vrKvx2oRN7djtALbDq4xngW1gRDnN4jPUvhNdmyzq9Jj
 iPVVvm/v28anHZevma5nT7IhnBwFo3j9GbcefhA9gTha8qySByVe//LkFru5IAUSsO6G
 5pUw==
X-Gm-Message-State: AOAM531UfVGdY2IIgqBdQZa0er3UKHc7iQxZR2TZGXKo86YjE5BfuxsM
 l3vuNB1hVDdNwDcKQh2X6lPvfE31cnyo+CNIo2sPj4/fEHXg7DQbOo1Iq6RBm2jEmt5GFveri6t
 W0zsa6EgOyEL91plerRHLN18/5DhD8WHGTDtbfk26RFRphZ0=
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr2930700wmh.1.1643116779760;
 Tue, 25 Jan 2022 05:19:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa5CbjVgAdTzjpJrtsTBt6f96wmnehH2oqiBhJobNl5d/0gRlB/5PGKzta91V9mOV7mtz02w==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr2930685wmh.1.1643116779550;
 Tue, 25 Jan 2022 05:19:39 -0800 (PST)
Received: from [192.168.0.57] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id l20sm552432wms.24.2022.01.25.05.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jan 2022 05:19:38 -0800 (PST)
Message-ID: <9ce18ea8-caed-7d46-8f79-725561429f57@canonical.com>
Date: Tue, 25 Jan 2022 14:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mt8186: Add binding for MM
 iommu
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220125093244.18230-2-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On 25/01/2022 10:32, Yong Wu wrote:
> Add mt8186 iommu binding. "-mm" means the iommu is for Multimedia.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
>  .../dt-bindings/memory/mt8186-memory-port.h   | 217 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
