Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E621C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49B79828A5;
	Mon, 14 Feb 2022 12:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F070hxAoMMCK; Mon, 14 Feb 2022 12:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 380DA82868;
	Mon, 14 Feb 2022 12:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13919C001A;
	Mon, 14 Feb 2022 12:00:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64DD3C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42869405A4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=cogentembedded-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TUbfCPLZyRF for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:00:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93D40405E5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:00:04 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id z14so8964761lfu.5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=1soBarvyGYEO2s/ygy+VNECztQ8yHUAApb2QrCHbwz0=;
 b=3CxAsSDTY4mfLl78v0BjFrbWZ1ZwflUPwWg8cKfolovebAEwpWx/Tf95FPm//pLUUC
 zuFCYYc2HcKLMWlp3C0cyobG4fZu7+fPiQPqDslEcDf5HjLEHBBP1gprQirjK1QISfAv
 I8Z64lqLPDnssmf/A1mAWqNsZWEZ9bIgmXPTe32rcRMK64uJvTc9dalE53Jh220+qccH
 QIKLDk9AcP/sE1k0JEFkow0JxnpUecxjnFkXBtBv9D/0Tni3VT45Aa7wL9BxlPQDvbpH
 nvW/RJ3wFvjFitwFDF78qJV7cTG5/HbCgtvEbyN6pFNJez+daQ2eBHQjZXphPTULSZRg
 uDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1soBarvyGYEO2s/ygy+VNECztQ8yHUAApb2QrCHbwz0=;
 b=yQJC8nGHZ1oY0j5WWqEYjM8fvzdsjh8rEfnIS/KMjNHw1Lhjhb7tsjRcrnF1Mvn4Y3
 CLFh6ytQqQmd1t6PqYNvIt7kz2/kc2Vs6lyzb9EIxeLI7jhm7rj1SXSeECbP63ctnvSH
 zhk1UKhmmJwX9apzAqivJYyODE954jumQpdtZlIjM+mquiFHXqSD9XXCLQsiYvO2s99u
 TuXSDkx4KtoSTtky2bEWeRIOo+oMOc8ymFBeuuDPhQP2O8E/wPe4dA55j0J5jzr4yK5H
 4JhGbk3wES5GAd8yhd031d8bP6vMXE4797k1A0Z2DmPwRSWPb4dFzJPDZkgWqvAcnqGj
 Y5wg==
X-Gm-Message-State: AOAM533OZcWVhmdXonG31BUi3UjqpFZ1yXCcv1No9pFSc49hR8WVWanO
 RYdLSwnHpcw6fyW31IOGo1w2Gg==
X-Google-Smtp-Source: ABdhPJzyQYnHIxZnKEtoj/FwNDQtqU+sRMQ3ROYdR8cEw34ogvBZWf6hZa2n/d8J3b7HljbygcPNAA==
X-Received: by 2002:a05:6512:3042:: with SMTP id
 b2mr10466866lfb.208.1644840002506; 
 Mon, 14 Feb 2022 04:00:02 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
 by smtp.gmail.com with ESMTPSA id q16sm614047ljc.66.2022.02.14.04.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Feb 2022 04:00:02 -0800 (PST)
Message-ID: <8e341c5e-018b-f176-1b68-a412a9cf4906@cogentembedded.com>
Date: Mon, 14 Feb 2022 15:00:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jiasheng Jiang <jiasheng@iscas.ac.cn>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
 <YgpAfVVhkNljJhJY@8bytes.org>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <YgpAfVVhkNljJhJY@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, will@kernel.org,
 linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Adding more potential reviewers.
> 
> On Thu, Jan 06, 2022 at 10:43:02AM +0800, Jiasheng Jiang wrote:
>> Because of the possible failure of the dma_supported(), the
>> dma_set_mask_and_coherent() may return error num.
>> Therefore, it should be better to check it and return the error if
>> fails.

Indeed, most uses of dma_set_mask_and_coherent() in the kernel do check return value.

Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
