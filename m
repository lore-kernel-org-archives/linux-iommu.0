Return-Path: <SRS0=3YoF=JH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB0CC433B4
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 12:40:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77635610F9
	for <iommu@archiver.kernel.org>; Sat, 10 Apr 2021 12:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77635610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 358D2607CE;
	Sat, 10 Apr 2021 12:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nwj-Fpy5JjMI; Sat, 10 Apr 2021 12:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F8CC60624;
	Sat, 10 Apr 2021 12:40:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55BF5C000C;
	Sat, 10 Apr 2021 12:40:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 169F0C000A
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 12:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E24FF40454
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 12:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VyQVdlJOlnmJ for <iommu@lists.linux-foundation.org>;
 Sat, 10 Apr 2021 12:40:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E19454044B
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 12:40:15 +0000 (UTC)
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lVCuL-0002Yg-GD
 for iommu@lists.linux-foundation.org; Sat, 10 Apr 2021 12:40:13 +0000
Received: by mail-ed1-f69.google.com with SMTP id b8so589928ede.5
 for <iommu@lists.linux-foundation.org>; Sat, 10 Apr 2021 05:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k8kbv7tLUPin7vEZz6Y8S8Ho2i9EHLVgMoQhgUpPZTc=;
 b=UpQCl2GZ4SxR2ikwaB/YV5IyN4E1/7e5dhnUHZI53AbomuFwVHyjtfZlSVzqUo7u/q
 7Bh/E7NgOG8DKRBlgO7eYDCSo7/sogdEYCmHLy63FO0OXjpfTj0moirAQu23QDa2RJYt
 CIfT+UY0XJsQRiUzEofZi2zFwOrWHAd4dxmfpc5pGU7hQiFE3iymU1seZwjWaD2ks10k
 xl8/CYmwNckJueDpCBQBRptioD7pw2hrjvIG8VUhmgzFy5HzQq5p8/Ef8Nwc/fzDZrQ0
 Fl4xDidkMZvfQpp1BL/6upGxrL6dQ6ixowadqOBUJx2/IYupMCGi5uKYtfDKwGgf2mPA
 enBw==
X-Gm-Message-State: AOAM5333z16gfku6I87J4z1FT5x4irxiJ+YibRrVA8fAmF4ziHfYMM8j
 CIrIMPRN8iONrwvoJtEHOK4kPdfVLqo5ki3JUA/Ct5UuuJuylqDQ3A9hcI6wWrysORBxApbQEOt
 JyPwX4KYOx+M+5jIgxTZMSJGNCB1v8z56nqkEZ/6tlg5uRDQ=
X-Received: by 2002:a05:6402:148a:: with SMTP id
 e10mr21482432edv.377.1618058413094; 
 Sat, 10 Apr 2021 05:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnEqzqI9N9YfHRefBuhHMer8IAZFUeA1p/w31AAx1VON2hHKiqTW68RFjQfE3PCZ9Bpj9RyA==
X-Received: by 2002:a05:6402:148a:: with SMTP id
 e10mr21482422edv.377.1618058412954; 
 Sat, 10 Apr 2021 05:40:12 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch.
 [188.155.192.147])
 by smtp.gmail.com with ESMTPSA id d6sm3149960edr.21.2021.04.10.05.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Apr 2021 05:40:12 -0700 (PDT)
Subject: Re: [PATCH v5 04/16] memory: mtk-smi: Add device-link between
 smi-larb and smi-common
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-5-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ea7ed30f-050d-2d38-7c61-1e0c192f6ded@canonical.com>
Date: Sat, 10 Apr 2021 14:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-5-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, acourbot@chromium.org,
 srv_heupstream@mediatek.com, eizan@chromium.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On 10/04/2021 11:11, Yong Wu wrote:
> Normally, If the smi-larb HW need work, we should enable the smi-common
> HW power and clock firstly.
> This patch adds device-link between the smi-larb dev and the smi-common
> dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> (smi-common-dev) will be called automatically.
> 
> Also, Add DL_FLAG_STATELESS to avoid the smi-common clocks be gated when
> probe.
> 
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

I understood this is a dependency for other patches, so:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

If I am wrong and I can take it via memory tree, let me know.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
