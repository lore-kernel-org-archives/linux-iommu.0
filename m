Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8166EC43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 21:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1561141A58;
	Wed,  8 Jun 2022 21:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5LwljxxLyUN; Wed,  8 Jun 2022 21:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B86A841A41;
	Wed,  8 Jun 2022 21:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80326C0039;
	Wed,  8 Jun 2022 21:07:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B02A8C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6F77408E0
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jcngaigEtPhe for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 21:07:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34ADC400A6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 21:07:09 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id y187so20062777pgd.3
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 14:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9ecb3buQLdnsK4f3qTJQfieUPfKbyWt/zyj1SzIvpTM=;
 b=ZhOuuEuPr2WkfxKtfOcbD3NyrIlYVmbxGMti4dAtF5v8VGpMzWuaeTd0GfjB2oZDah
 CTiUG0vgBbAq1lUHcMb9h0sk8dHZhsNCgoTGNh5xK0ZoecZJPYeiUrAvrJb2Bx8ELpgj
 39HXi598zGke5SZl3clTroNwnqCojHmsPwAlq+P4H/zC7Q2LMWBcNqrAogyV5w7rUyt6
 wxdKXpL4CagDw7tM6W7Uoa1djTk0X1WuWBpRMegqt2lsu7AbMWnx6j+QzK1T7gPT00Vw
 LbiZC5QS8n59QIOKMOoSUi5f3Z7Fzab6BwiHiuQBRWUlToKlAiqcKVsJBxtdWzMlvA5y
 0dYA==
X-Gm-Message-State: AOAM530DzpkhOCzReBDanLo1dSyrOPjebYYvFiEYJkA1TONdJLm0Qa1/
 3k2wp+ckkzPhSjef+khj9Nc=
X-Google-Smtp-Source: ABdhPJwGJ0nRHde8RTl6xYLYR29tSKmbbRXlGMXSsUmS5fgFGnp4YCile/NXrK4PxwLOOdGqsZyMzw==
X-Received: by 2002:a63:18b:0:b0:3fe:e54b:da15 with SMTP id
 133-20020a63018b000000b003fee54bda15mr789973pgb.571.1654722428389; 
 Wed, 08 Jun 2022 14:07:08 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39?
 ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a170902d29400b00161947ecc82sm15020395plc.199.2022.06.08.14.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 14:07:07 -0700 (PDT)
Message-ID: <bccbcc9b-4750-a1a7-130f-69eeea5dcb23@acm.org>
Date: Wed, 8 Jun 2022 14:07:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
 <1654507822-168026-4-git-send-email-john.garry@huawei.com>
 <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
 <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <31417477-953d-283e-808e-cf8701e820a8@huawei.com>
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

On 6/8/22 10:50, John Garry wrote:
> Please note that this limit only applies if we have an IOMMU enabled for 
> the scsi host dma device. Otherwise we are limited by dma direct or 
> swiotlb max mapping size, as before.

SCSI host bus adapters that support 64-bit DMA may support much larger 
transfer sizes than 128 KiB.

Thanks,

Bart.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
