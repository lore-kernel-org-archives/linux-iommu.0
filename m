Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D088AC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 22:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6415D82C4D;
	Tue,  7 Jun 2022 22:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZEir50Pzu0En; Tue,  7 Jun 2022 22:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C691882C33;
	Tue,  7 Jun 2022 22:43:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C325C0032;
	Tue,  7 Jun 2022 22:43:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA7B3C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 22:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B891A409F4
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 22:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1N5vE3Lsn_Z for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 22:43:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B823E409A9
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 22:43:45 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 gc3-20020a17090b310300b001e33092c737so16687356pjb.3
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 15:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=w8NDUBo3z6UDbWsc/XByX6YF7c4oG4yuYC7oAUnBsYY=;
 b=IM7nDoYZGLAVa4tKw3MezF4eJ1gfHAdpctksAPml0WiKTglQ+alFUsRX5H0asnHDiC
 NxfMw3PpPQvKSuNcB2/FVkrZ6X3BS3v1PortippT0Q6nrzaZc5ZfNswk2W+Qfz7GwDFM
 uEx+nQhNooIdDkiNYulIvBsgmE8HBbWHjvEAQI2Yx3YzBLcR+m/HGVbUBqC/t1IIlTN2
 hNzMB2/fBBJoDr1/eR8Q7lHryz7I9UlY8ycvbc97uCUqfxY7AABOezo0/ufvzmFuXu6g
 ofcMR3Wq2xASxFJVjfwiLi+BCTuFtg0+ixrXHuJx/9xJAKfHk1qx9r5Bn0p40UF7C4c3
 hZAg==
X-Gm-Message-State: AOAM532Jjj78ZLtH9N5uJOK0ifQtvUJUuy5AaLKzBW7W53VWgHaglO0+
 lpSRDRVNx4f/5RVS/1or19c=
X-Google-Smtp-Source: ABdhPJyerYGytLfJP4UmMuvbsKpIxNlss+3u6Myd9djlsW8ZEBq2xQNYIWDPe/Kqg6qSLUHDPa8PZg==
X-Received: by 2002:a17:902:7088:b0:167:78c0:e05e with SMTP id
 z8-20020a170902708800b0016778c0e05emr13533905plk.149.1654641824895; 
 Tue, 07 Jun 2022 15:43:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e794:fbe6:94b0:435b?
 ([2620:15c:211:201:e794:fbe6:94b0:435b])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a62a50b000000b0051ba97b788bsm13451064pfm.27.2022.06.07.15.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jun 2022 15:43:44 -0700 (PDT)
Message-ID: <3e2324dc-2ab1-6a35-46ab-72d970cc466c@acm.org>
Date: Tue, 7 Jun 2022 15:43:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/4] DMA mapping changes for SCSI core
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, damien.lemoal@opensource.wdc.com,
 joro@8bytes.org, will@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com
References: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1654507822-168026-1-git-send-email-john.garry@huawei.com>
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
> As reported in [0], DMA mappings whose size exceeds the IOMMU IOVA caching
> limit may see a big performance hit.
> 
> This series introduces a new DMA mapping API, dma_opt_mapping_size(), so
> that drivers may know this limit when performance is a factor in the
> mapping.
> 
> Robin didn't like using dma_max_mapping_size() for this [1].
> 
> The SCSI core code is modified to use this limit.
> 
> I also added a patch for libata-scsi as it does not currently honour the
> shost max_sectors limit.
> 
> Note: Christoph has previously kindly offered to take this series via the
>        dma-mapping tree, so I think that we just need an ack from the
>        IOMMU guys now.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> [1] https://lore.kernel.org/linux-iommu/f5b78c9c-312e-70ab-ecbb-f14623a4b6e3@arm.com/

Regarding [0], that patch reverts commit 4e89dce72521 ("iommu/iova: 
Retry from last rb tree node if iova search fails"). Reading the 
description of that patch, it seems to me that the iova allocator can be 
improved. Shouldn't the iova allocator be improved such that we don't 
need this patch series? There are algorithms that handle fragmentation 
much better than the current iova allocator algorithm, e.g. the 
https://en.wikipedia.org/wiki/Buddy_memory_allocation algorithm.

Thanks,

Bart.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
