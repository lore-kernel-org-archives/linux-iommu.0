Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1673EC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 17:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A86FD60EA1;
	Wed,  8 Jun 2022 17:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_4p7295N7AY; Wed,  8 Jun 2022 17:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7790760DB2;
	Wed,  8 Jun 2022 17:33:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49944C0032;
	Wed,  8 Jun 2022 17:33:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC18C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03F5980A75
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SGRbmiIQ503K for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 17:33:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89F6983E8D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 17:33:29 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 3-20020a17090a174300b001e426a02ac5so21303495pjm.2
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 10:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=URIZCp/jWQNLisOjE8f9wYPe1lbI6/tMNbNejKjnaZ4=;
 b=kvLfr5Vt9XspEiL2nzFSdT9GxaEgW0b7ZRPRhmNl+dnvXUrkE4TKV20vSRD0CjjVj0
 mKc73Thj6F1z014giCUE5+mldNe+g5sTm8l2RGhRQalrI+bifY/JPLVbFwgWGQwc/OP8
 Ld251OBQugW00uDbcfEb7rcHvrFeQWtKTYJgh7SEvF4Xix3HbXoQrQgrP2C605oA/BjW
 nREK+HQfka6+iKySDjVRbz6jIBUsE28/XvyWBx8SYMjBILUW1xQ257LSm/TI+Wa+7xvQ
 4FQZzHjBSBz/CO3dASwTMqCKnZS7XO7XfcLZbxL4hYYAvEnyDdO4jIU/YQ5XVZYNz5sM
 OO6w==
X-Gm-Message-State: AOAM530k3FNbrR2yJNKgFcx8JvMGapl7fS6RR1MT7+QWbG94m7BbjSWC
 xHdcmVzoPLHSjegU51/3S9M=
X-Google-Smtp-Source: ABdhPJyg/AK8j680Ym1MLmXvtMNO7idwCDt0mxe0LmDZt+QIharawT9S6BKDFL1MLiFHnWCay3fYlA==
X-Received: by 2002:a17:902:7886:b0:167:5c8c:4d3e with SMTP id
 q6-20020a170902788600b001675c8c4d3emr24496557pll.74.1654709608885; 
 Wed, 08 Jun 2022 10:33:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1cb7:9e5d:5ca4:2a39?
 ([2620:15c:211:201:1cb7:9e5d:5ca4:2a39])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a1709027fc400b0015e8d4eb28esm15055558plb.216.2022.06.08.10.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 10:33:28 -0700 (PDT)
Message-ID: <fe365aa8-00d5-153d-ceb2-f887a71a6927@acm.org>
Date: Wed, 8 Jun 2022 10:33:26 -0700
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-4-git-send-email-john.garry@huawei.com>
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

On 6/6/22 02:30, John Garry wrote:
> +	if (dma_dev->dma_mask) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}

Since IOVA_RANGE_CACHE_MAX_SIZE = 6 this limits max_sectors to 2**6 * 
PAGE_SIZE or 256 KiB if the page size is 4 KiB. I think that's too 
small. Some (SRP) storage arrays require much larger transfers to 
achieve optimal performance.

Thanks,

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
