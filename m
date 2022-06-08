Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F61C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 17:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8660B40A87;
	Wed,  8 Jun 2022 17:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVeqNUEILeqY; Wed,  8 Jun 2022 17:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64BF640002;
	Wed,  8 Jun 2022 17:26:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40E0CC0032;
	Wed,  8 Jun 2022 17:26:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 460A2C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3419860E18
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wOGQpidkkIEe for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 17:26:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFAC660E13
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:26:43 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 184so3581353pga.12
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 10:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vdq4x2cK2Kxb7bPLAXT0rRqzYQf9uH8WQ9IJlchFrLc=;
 b=eSMfA1RhZSB9qedtYN1jRO5LtHzgQ2owH/F5JNmAzWMzw7ZyxbkxdGYbCdjRnXR1Hu
 PoItjxgTvpSGMi615sH/DD7t1izulT1LpE+o16w5V2pMcv0igfvggARqdoeKgNuvXHo5
 dCYKGauoaAx7UOLw5oX4pEF1NcfkokAwYELFfM/UvXotaRA5lnBKrhjJsb66eY7rk8zQ
 fRUykQLQV4+RhYf7AylbtXkC2AVsUDYqU8UvOMjNc3hiSer0Z1ftNLfIDQonzxRLiR7D
 ZEqe+ilvE/DmGTbRzL+2OChJ9gSQNENh1u7U2tUVvuANu8DQRCRulKxfj/ZZMpiZCF6I
 qUCQ==
X-Gm-Message-State: AOAM533IKv5ZapQDdteT6x9JSu/RP6PnLqsX3HXKV/Bh7ziT57+80T7W
 shy42p5biTFO1H/cTLZVQ/0=
X-Google-Smtp-Source: ABdhPJy2XkL1wjH+iK3e6e2Hx2QMmfgjTy/wyGK/xCsPzQDJHM5fZRi20ssFAqNOW/TkC9QwcpHNxQ==
X-Received: by 2002:a05:6a00:1344:b0:51b:ed0d:dbbd with SMTP id
 k4-20020a056a00134400b0051bed0ddbbdmr26197497pfu.45.1654709202923; 
 Wed, 08 Jun 2022 10:26:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39?
 ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a62d005000000b0050dc762813csm3282490pfg.22.2022.06.08.10.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 10:26:42 -0700 (PDT)
Message-ID: <d7a72f92-15c9-1d58-c711-83c47444094e@acm.org>
Date: Wed, 8 Jun 2022 10:26:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-3-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-3-git-send-email-john.garry@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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

On 6/6/22 02:30, John Garry via iommu wrote:
> +unsigned long iova_rcache_range(void)
> +{
> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> +}

My understanding is that iova cache entries may be smaller than 
IOVA_RANGE_CACHE_MAX_SIZE and hence that even if code that uses the DMA 
mapping API respects this limit that a cache miss can still happen.

Thanks,

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
