Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8132DC433F5
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 10:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23FA96FB89;
	Wed, 12 Jan 2022 10:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OxekP4KlOKZP; Wed, 12 Jan 2022 10:20:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE74860C1F;
	Wed, 12 Jan 2022 10:20:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D202DC0030;
	Wed, 12 Jan 2022 10:20:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1966FC001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE05D428DC
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0oZh3yfncoS for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:20:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61282428CF
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:20:19 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94DB73F207
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641982817;
 bh=ZFiQ3BSkZV8JLMzs5+GiJp8IJAdyEgrG9WjGPcBJ1to=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Rt7un9ol+ALmK24vm/o8c8BgKlLjlmMuhBjwWaVNE9F++hHXuoH8Q4vJFSica/36N
 7FtEcLxrnx+WOg5kTz+QYi9dXhf5+eJzeyDaFRYCgL0fxL3NmcDmzKXIA5SHei+8Iy
 aEtgvv6+rve0mICT/jqIl1zyrH9mvYsBoByj/SE8fXIyeTutqN3S2aFbPyqQ8ZVXKw
 VxuBXNUTTm2XV8XhKFVc3UUhg465hGSKvWQRepuGmDp1e67W4L0GE6zyf0exhwGLom
 H9TLnV2kC8FJOYL48znvdLMKVEtKE9K6+zPYUthP56LqF/LtncKBQyS/R6HuJTQd8L
 ASPp2wlbgjKEg==
Received: by mail-ed1-f72.google.com with SMTP id
 j10-20020a05640211ca00b003ff0e234fdfso1908883edw.0
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 02:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZFiQ3BSkZV8JLMzs5+GiJp8IJAdyEgrG9WjGPcBJ1to=;
 b=hzb2ICGG18x1T0ygyn+Nq1/uFeAJT1B9hf7oHrBRNvVd0JyrqRDjnS4BCemJg4yoOq
 PhkjWgTT6keI+i0f4Cqs2JW8OTA3KbI9mekQxfcR4iEgWpGq4rTS1MMlDRnCku3RuSVF
 v2ul6J8L2K5W/C1w7uApBgr5Vuk3X1rYEJXyohBktUsh7Tt+7RDA6B7Kt7tfYZOaeJ2Y
 gjkCPWK1o7URxFCoRCPEzanU3GmAjJsowKdk0h2yu4QC7x/pzDF6OAkFn/FTdDsSttIr
 +Xlt6E6lutRpTJk1k2ELBv/R18lVA/hxh9G5h4q4iiY/ngWcKJVQV3DxVxuCUaRWeysX
 JdLA==
X-Gm-Message-State: AOAM533TzU8o1AqT3bDd0o/GJ6V2K4g70JC2Q3oQpm99r2/OdGQWbIn8
 8oGSaTPAGzFJp9u2YOZEIM8IzEk6oJjb/2TxUH1DGKl4LXTfwv1g664VZ+ZlUNGFMWO0R8a8Xu/
 jyx4fB+D2kErjdRzse09u24zXqgFF4xvHUW+bistvM9AoCvE=
X-Received: by 2002:a05:6402:5251:: with SMTP id
 t17mr8194549edd.397.1641982813288; 
 Wed, 12 Jan 2022 02:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdLsOYtXRyV8ugt5h8vZw6vPbgwVNs4QQiqNdhIAdlMzEhEhXKY3AjG7bkdFEafgdxVmb/Yw==
X-Received: by 2002:a05:6402:5251:: with SMTP id
 t17mr8194520edd.397.1641982813026; 
 Wed, 12 Jan 2022 02:20:13 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id kw14sm4349252ejc.68.2022.01.12.02.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 02:20:12 -0800 (PST)
Message-ID: <a3c48c27-515d-f741-e447-98e0ddfe3b01@canonical.com>
Date: Wed, 12 Jan 2022 11:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 4/6] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-5-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111063904.7583-5-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
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

On 11/01/2022 07:39, Yong Wu wrote:
> The successful return value for clk_bulk_prepare_enable is 0, rather than
> "< 0". Fix this.

I do not understand. The commit description does not match the code.
What is the error here?

> 
> Fixes: 0e14917c57f9 ("memory: mtk-smi: Use clk_bulk clock ops")

There is no bug to fix...

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..e7b1a22b12ea 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -480,7 +480,7 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  	int ret;
>  
>  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/* Configure the basic setting for this larb */
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
